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
LIMIT 5;

-- Запрос на вывод списка клиентов, оставивших отзывы с оценкой 3:
SELECT 
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

-- Получить список всех сотрудников, работающих доставщиком:
SELECT DISTINCT
  s.staff_name, s.staff_surname;
FROM
  delivery.Staff s;
JOIN
  delivery.Professions p ON s.profession_id = p.profession_id;
WHERE
  Staff.profession_name = "Доставщик";

-- Вывести список заказов, сделанных в Москве:
SELECT
  o.order_id;
FROM
  delivery.Orders o;
JOIN
  delivery.Cities c ON o.order_id = c.order_id;
WHERE
 Cities.city_name = "Москва";

-- Вывести часовой пояс города с наибольшим количеством заказов:
-- Вывести список всех промоакций, действующих в настоящее время вместе с их описанием:
-- Вывести список всех блюд дешевле 200 рублей и их стоимость:
-- 
