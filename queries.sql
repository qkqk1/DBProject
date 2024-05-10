-- Запрос на вывод средней зарплаты по каждой профессии:
SELECT p.profession_name,
  AVG(p.profession_salary) AS avg_salary
FROM 
  delivery.Professions p
JOIN 
  delivery.Staff s ON p.profession_id = s.profession_id
GROUP BY 
  p.profession_name;


-- Список наиболее часто покупаемого блюда и общее количество заказов с этим блюдом:
SELECT
  d.dish_name,
  COUNT(*) AS total_orders
FROM
  delivery.Orders_and_Dishes od
JOIN
  delivery.Dishes d ON od.dish_id = d.dish_id
GROUP BY
  d.dish_name
ORDER BY
  total_orders DESC
LIMIT 6;


-- Запрос на вывод списка клиентов, оставивших отзывы с оценкой 3:
SELECT DISTINCT
  c.client_name,
  r.review_text,
  r.review_rating
FROM 
  delivery.Clients c
JOIN 
  delivery.Reviews r ON c.client_id = r.client_id
WHERE 
  r.review_rating = 3;


-- Список клиентов, заказавших блюдо дороже 450 рублей:
SELECT DISTINCT 
  c.client_id, c.client_name, c.client_surname
FROM
  delivery.Clients c
JOIN
  delivery.Orders o ON c.client_id = o.client_id
JOIN
  delivery.Orders_and_Dishes od ON o.order_id = od.order_id
WHERE 
  od.dish_id IN (
    SELECT
      dish_id 
    FROM
      delivery.Dishes 
    WHERE
      dish_price > 450
  )
ORDER BY
  client_id;


-- Получить список всех сотрудников, работающих курьером ночной смены:
SELECT DISTINCT
  s.staff_name, s.staff_surname
FROM
  delivery.Staff s
JOIN
  delivery.Professions p ON s.profession_id = p.profession_id
WHERE
  p.profession_name = 'Курьер ночной смены';


-- Вывести список заказов, сделанных в Москве:
SELECT DISTINCT
  o.order_id
FROM
  delivery.Orders o
JOIN
  delivery.Cities c ON o.order_id = c.order_id
WHERE
  c.city_name = 'Москва';


-- Вывести часовой пояс города с наибольшей общей стоимостью заказа и саму его стоимость:
SELECT DISTINCT
  c.city_time_zone, o.order_total_cost
FROM
  delivery.Cities c
JOIN
  delivery.Orders o ON c.order_id = o.order_id
WHERE
  order_total_cost = (SELECT MAX(order_total_cost) FROM delivery.Orders);


-- Вывести список всех блюд дешевле 300 рублей и их стоимость:
SELECT DISTINCT
  d.dish_name, d.dish_price
FROM
  delivery.Dishes d
WHERE
  d.dish_price < 300;


-- Вывести список всех промоакций, действующих в настоящее время вместе с их описанием:
SELECT
  p.promotion_name, p.promotion_description
FROM
  delivery.Promotions p
WHERE
  p.promotion_datetime_start < CURRENT_TIMESTAMP AND p.promotion_datetime_end > CURRENT_TIMESTAMP;


-- Запрос на вывод количества заказов, сделанных каждым сотрудником за последний месяц:
SELECT 
  s.staff_id,
  s.staff_name,
  s.staff_surname,
  COUNT(o.order_id) AS total_orders
FROM 
  delivery.Staff s
JOIN 
  delivery.Orders o ON s.staff_id = o.staff_id
WHERE 
  o.order_datetime_end >= CURRENT_DATE - INTERVAL '1 month'
GROUP BY 
  s.staff_id, s.staff_name
ORDER BY 
  total_orders DESC;
