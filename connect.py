import sqlite3
from contextlib import contextmanager

database = 'test_text.db'

@contextmanager
def get_db_connection(db_file):
    '''Контекстний менеджер для отримання з'єднання з базою даних'''
    conn = sqlite3.connect(db_file)
    yield conn
    conn.rollback()  # Відкат транзакції, якщо виникне помилка
    conn.close()