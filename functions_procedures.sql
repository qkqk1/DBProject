-- Функция, выводящая когда должен выходить на работу каждый сотрудник данного заказа:
CREATE OR REPLACE FUNCTION GetStaffProfessionTimeForOrder(order_id INTEGER)
RETURNS TABLE (
    staff_name VARCHAR(255), 
    staff_surname VARCHAR(255),
    proffession_start_time TIME,
    profession_end_time TIME
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        s.staff_name,
        s.staff_surname,
        p.profession_start_time,
        p.profession_end_time
    FROM
        delivery.Orders o
    JOIN
        delivery.Staff s ON o.staff_id = s.staff_id
    JOIN
        delivery.Profession p ON s.profession_id = p.profession_id
    WHERE
        o.order_id = GetStaffProfessionTimeForOrder.order_id;
END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM GetStaffProfessionTimeForOrder(1);- пример вызова.

-- Функция выводящая список ресторанов, из которых клиент заказывал еду:
CREATE OR REPLACE FUNCTION GetRestaurantsFromClients(client_id INTEGER)
RETURNS TABLE (
    client_name VARCHAR(255),
    client_surname VARCHAR(255),
    restaurant_name VARCHAR(255);
) AS $$
BEGIN
    RETURN Query
    SELECT
        c.client_name,
        c.client_surname,
        r.restaurant_name
    FROM
        delivery.Order_History oh
    JOIN
        delivery.Client c ON oh.client_id = c.client_id
    JOIN
        deivery.Orders o ON c.client_id = o.client_id
    JOIN
        delivery.Orders_and_Dishes od ON o.order_id = od.order_id
    JOIN
        delivery.Dishes d ON od.order_id = d.order_id
    JOIN
        delivery.Dishes_and_Restaurants dr ON d.dish_id = dr.dish_id
    JOIN
        delivery.Restaurants r ON dr.restaurant_id = r.restaurant_id
    WHERE 
        oh.client_id = GetRestaurantsFromClients.client_id;
END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM GetRestaurantsFromClients(1);- пример вызова.
