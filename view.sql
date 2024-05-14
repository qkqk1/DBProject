-- Представление для удобного управления сотрудников:
CREATE VIEW ManagementStaff AS
SELECT
  s.staff_id,
  s.staff_name,
  s.staff_surname,
  p.profession_name,
  p.profession_salary,
  p.profession_start_t,
  p.profession_end_t
FROM
  delivery.Staff s
JOIN
  delivery.Professions p ON s.profession_id = p.profession_id;


-- Представление для аналитики отзывов клиентов:
CREATE VIEW ReviewAnalytic AS
SELECT
  r.review_id,
  r.review_date,
  r.review_rating,
  r.review_text,
  c.client_name,
  c.client_surname
FROM
  delivery.Reviews r
JOIN
  delivery.Clients c ON r.client_id = c.client_id;


-- Представление для стоимости каждого блюда:
CREATE VIEW MenuCosts AS
SELECT
  d.dish_id,
  d.dish_name,
  d.dish_price,
  r.restaurant_name,
  r.restaurant_rating
FROM
  delivery.Dishes d
JOIN
  delivery.Dishes_and_Restaurants dr ON d.dish_id = dr.dish_id
JOIN
  delivery.Restaurants r ON dr.restaurant_id = r.restaurant_id;

-- Представление для работы с заказами:
CREATE VIEW OrdersInfo AS
SELECT 
  o.order_id,
  o.order_datetime_start,
  o.order_datetime_end,
  o.order_total_cost
  c.client_name,
  c.client_surname,
  c.client_phone_number,
  c.client_address,
  s.staff_name,
  s.staff_surname,
  d.dish_name,
  d.dish_price,
  d.dish_description,
FROM 
  delivery.Orders o
JOIN 
  delivery.Clients c ON o.client_id = c.client_id
JOIN 
  delivery.Staff s ON o.staff_id = s.staff_id
JOIN 
  delivery.Orders_and_Dishes od ON o.order_id = od.order_id
JOIN 
  delivery.Dishes d ON od.dish_id = d.dish_id;

--Представлениe для работы с акциями:
CREATE VIEW PromotionsInfo AS
SELECT
  p.promotion_id,
  p.promotion_name,
  p.promotion_datetime_start,
  p.promotion_datetime_end,
  p.promotion_description,
  c.client_name,
  c.client_surname
FROM
  delivery.Promotions p
JOIN
  delivery.Clients c ON p.client_id = c.client_id;


--Представление для работы с историей заказов:
CREATE VIEW OrderHistoryInfo AS
SELECT
  oh.order_history_id,
  c.client_name,
  c.client_surname,
  o.order_datetime_start,
  o.order_datetime_end,
  o.order_total_cost,
FROM
  delivery.Order_History oh
JOIN
  delivery.Clients c ON oh.client_id = c.client_id
JOIN
  delivery.Orders o ON oh.order_id = o.order_id;
  
