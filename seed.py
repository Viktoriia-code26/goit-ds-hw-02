from random import choice
import sqlite3
from faker import Faker

DATABASE = "test_text.db"

NUMBER_USERS = 10
NUMBER_TASKS = 30

fake = Faker()


def insert_statuses(cursor):
    statuses = ["new", "in progress", "completed"]

    for status in statuses:
        cursor.execute(
            "INSERT OR IGNORE INTO status (name) VALUES (?)",
            (status,)
        )


def insert_users(cursor):
    for _ in range(NUMBER_USERS):
        cursor.execute(
            "INSERT INTO users (fullname, email) VALUES (?, ?)",
            (fake.name(), fake.unique.email())
        )


def insert_tasks(cursor):
    cursor.execute("SELECT id FROM users")
    user_ids = [row[0] for row in cursor.fetchall()]

    cursor.execute("SELECT id FROM status")
    status_ids = [row[0] for row in cursor.fetchall()]

    for _ in range(NUMBER_TASKS):
        cursor.execute(
            """
            INSERT INTO tasks (title, description, status_id, user_id)
            VALUES (?, ?, ?, ?)
            """,
            (
                fake.sentence(nb_words=4),
                fake.text(max_nb_chars=100),
                choice(status_ids),
                choice(user_ids)
            )
        )


def seed_database():
    with sqlite3.connect(DATABASE) as conn:
        cursor = conn.cursor()

        insert_statuses(cursor)
        insert_users(cursor)
        insert_tasks(cursor)

        conn.commit()


if __name__ == "__main__":
    seed_database()