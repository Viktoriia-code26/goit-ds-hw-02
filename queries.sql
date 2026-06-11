 #Отримати всі завдання певного користувача.
SELECT * FROM tasks 
WHERE user_id = 10;

#Отримати всі завдання, які мають певний статус.
SELECT * FROM tasks 
WHERE status_id IN (
SELECT id FROM status 
WHERE name = 'new');

#Оновити статус конкретного завдання.
UPDATE tasks
SET status_id = (
    SELECT id
    FROM status
    WHERE name = 'in progress'
)
WHERE id = 5;

#Отримати список користувачів, які не мають жодного завдання.
SELECT * FROM users 
WHERE id NOT IN (
SELECT user_id FROM tasks
WHERE user_id IS NOT NULL);

#Додати нове завдання для конкретного користувача.
INSERT INTO tasks (title, description, user_id, status_id) 
VALUES ('new task', 'add new task in tasks', 2, 1);

#Отримати всі завдання, які ще не завершено.
SELECT * FROM tasks
WHERE status_id IN (
SELECT id FROM status
WHERE name IS NOT 'completed');

#Видалити конкретне завдання.
DELETE FROM tasks WHERE id = 5;

#Отримати список користувачів з певною електронною поштою.
SELECT * FROM users 
WHERE email LIKE '%@example.net'
ORDER BY fullname;

#Оновити імя користувача.
UPDATE users 
SET fullname = 'Alice Poprichka' 
WHERE id = 3;

#Отримати кількість завдань для кожного статусу.
SELECT status.name, COUNT(tasks.id) AS task_count
FROM status
LEFT JOIN tasks ON tasks.status_id = status.id
GROUP BY status.name;

#Отримати завдання, які призначені користувачам з певною доменною частиною електронної пошти. 
SELECT * FROM tasks 
JOIN users ON tasks.user_id = user_id 
WHERE users.email LIKE '%@example.com';

#Отримати всі завдання, які не мають опису.
SELECT * FROM tasks
WHERE description IS NULL OR description = '';

#Вибрати користувачів та їхні завдання, які є у статусі в процесі виконання.
SELECT u.fullname, t.title, s.name AS status
FROM tasks AS t
INNER JOIN users AS u ON t.user_id = u.id 
INNER JOIN status AS s ON t.status_id = s.id 
WHERE s.name = 'in progress';

#Отримати користувачів та кількість їхніх завдань.
SELECT 
    u.fullname, t.title,
    COUNT(t.id) AS total_tasks
FROM users AS u
LEFT JOIN tasks AS t ON t.user_id = u.id
GROUP BY u.id, u.fullname;

#Отримати всі завдання певного користувача.
SELECT * FROM tasks 
WHERE user_id = 3;

#Отримати всі завдання, які мають певний статус, з їхніми назвами та статусами.
SELECT t.title, s.name AS status 
FROM tasks AS t
JOIN status AS s ON t.status_id = s.id 
WHERE s.name = 'new';

#Отримати користувачів та їхні завдання.
SELECT u.fullname, t.title, t.description 
FROM tasks AS t 
JOIN users AS u ON t.user_id = u.id;

#Отримати всiх користувачів та кількість їхніх завдань.
SELECT u.fullname, COUNT(t.id) AS total_tasks
FROM users AS u 
LEFT JOIN tasks AS t ON t.user_id = u.id
GROUP BY u.id, u.fullname;

#Отримати всі завдання, які не мають опису.
SELECT t.id, t.title, t.description 
FROM tasks AS t
WHERE t.description IS NULL OR t.description = '';

#Отримати користувачів та їхні завдання, які є у статусі в процесі виконання.
SELECT u.fullname, t.title, s.name AS status
FROM tasks AS t
INNER  JOIN users AS u ON t.user_id = u.id
INNER JOIN status AS s ON t.status_id = s.id
WHERE s.name = 'in progress';

#Оновити статус конкретного завдання.
UPDATE tasks 
SET status_id =
(SELECT id 
FROM status 
WHERE name = 'completed')
WHERE id =5;

#Отримати користувачів, які не мають жодного завдання.
SELECT u.id, u.fullname, u.email, t.id
FROM users AS u
LEFT JOIN tasks AS t ON t.user_id = u.id 
WHERE t.id IS NULL;

#Отримати всі завдання, які мають певний статус, з їхніми назвами та статусами.
SELECT t.title, s.name AS status
FROM tasks AS t
JOIN status AS s ON t.status_id = s.id;

#Отримати користувачів та їхні завдання.
SELECT u.fullname, t.title 
FROM users AS u
LEFT JOIN tasks AS t ON t.user_id = u.id;

#Отримати всі завдання, які мають певний статус, з їхніми назвами та статусами.
SELECT t.id, t.title, s.name AS status
FROM tasks AS t 
INNER JOIN status AS s ON t.status_id = s.id 
WHERE s.name = 'completed';

#Порахувати кількість завдань для кожного статусу.
SELECT s.name, COUNT(t.status_id) as task_count
FROM tasks AS t 
INNER JOIN status AS s ON t.status_id = s.id
GROUP BY s.id, s.name;

#Отримати користувачів з певною доменною частиною електронної пошти.
SELECT u.id, u.fullname, u.email  
FROM users AS u
WHERE u.email LIKE '%@gmail.%';

#Оновити певну задачу, тобто змінити її статус.
UPDATE tasks 
SET status_id = (
SELECT id FROM status
WHERE name = 'in progress')
WHERE id = 2;

#Видалити всі завдання, які належать певному користувачу.
DELETE FROM tasks WHERE user_id = 4;