-- Список клиентов, заказавших блюдо дороже 300 рублей:
SELECT DISTINCT 
  c.client_id, c.client_name, c.client_surname
FROM
  delivery.Clients c
JOIN
  delivery.Orders o ON c.client_id = o.client_id
JOIN
  delivery.Orders_x_Dishes od ON o.order_id = od.order_id
WHERE 
  od.dish_id IN (
    SELECT
      dish_id 
    FROM
      delivery.Dishes 
    WHERE
      dish_price > 300
  )
ORDER BY
  client_id;

-- Список наиболее часто покупаемого блюда и общее количество заказов с этим блюдом:
SELECT
  d.dish_name,
  COUNT(*) AS total_orders
FROM
  delivery.Orders_x_Dishes od
JOIN
  dekivery.Dishes d ON od.dish_id = d.dish_id
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

-- Запрос на вывод количества заказов, сделанных каждым клиентом за последнюю неделю:
SELECT 
  s.client_id,
  s.client_name,
  s.client_surname,
  COUNT(o.order_id) AS total_orders
FROM 
  delivery.Clients s
JOIN 
  delivery.Orders o ON s.client_id = o.client_id
WHERE 
  o.order_date >= CURRENT_DATE - INTERVAL '1 week'
GROUP BY 
  s.client_id, s.cliet_name
ORDER BY 
  total_orders DESC;

-- Средний вес блюд в ресторанах:
SELECT 
  d.dish_name,
  AVG(d.dish_weight) AS avg_dish_weight
FROM
  delivery.Dishes d
JOIN
  delivery.Dishes_x_Restaurants di ON d.dish_id = di.dish_id
GROUP BY 
  d.dish_name
ORDER BY
  avg_dish_weight DESC;

-- Запрос на вывод средней зарплаты по каждой профессии:
SELECT 
  p.profession_name,
  AVG(p.profession_salary) AS avg_salary
FROM 
  delivery.Professions p
JOIN 
  delivery.Staff s ON p.profession_id = s.profession_id
GROUP BY 
  p.profession_name;
