-- Функция выводящая список ресторанов, из которых клиент заказывал еду:
CREATE OR REPLACE FUNCTION GetRestaurantsFromClients(client_id INTEGER)
RETURNS TABLE (
    client_name VARCHAR(255),
    client_surname VARCHAR(255),
    restaurant_name VARCHAR(255)
) AS $$
BEGIN
    RETURN Query
    SELECT DISTINCT
        c.client_name,
        c.client_surname,
        r.restaurant_name
    FROM
        delivery.Order_History oh
    JOIN
        delivery.Clients c ON oh.client_id = c.client_id
    JOIN
        delivery.Orders o ON c.client_id = o.client_id
    JOIN
        delivery.Orders_and_Dishes od ON o.order_id = od.order_id
    JOIN
        delivery.Dishes d ON od.dish_id = d.dish_id
    JOIN
        delivery.Dishes_and_Restaurants dr ON d.dish_id = dr.dish_id
    JOIN
        delivery.Restaurants r ON dr.restaurant_id = r.restaurant_id
    WHERE 
        oh.client_id = GetRestaurantsFromClients.client_id;
END;
$$ LANGUAGE plpgsql;


-- Процедура для подсчета суммарной стоимости заказа:
CREATE OR REPLACE PROCEDURE TotalCost(order_id_ INTEGER)
LANGUAGE plpgsql
AS $$
DECLARE
    total_cost INTEGER;
BEGIN
    total_cost := 0;

    SELECT SUM(d.dish_price)
    INTO total_cost
    FROM delivery.Orders_and_Dishes od
    JOIN delivery.Dishes d ON od.dish_id = d.dish_id
    WHERE od.order_id = order_id_;

    RAISE NOTICE 'Суммарная стоимость заказа с идентификатором % составляет % рублей', order_id_, total_cost;
END;
$$;


-- Функция, выводящая когда должен выходить на работу каждый сотрудник данного заказа:
CREATE OR REPLACE FUNCTION GetStaffProfessionTimeForOrder(order_id INTEGER)
RETURNS TABLE (
    staff_name VARCHAR(255), 
    staff_surname VARCHAR(255),
    proffession_start_t TIME,
    profession_end_t TIME
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        s.staff_name,
        s.staff_surname,
        p.profession_start_t,
        p.profession_end_t
    FROM
        delivery.Orders o
    JOIN
        delivery.Staff s ON o.staff_id = s.staff_id
    JOIN
        delivery.Professions p ON s.profession_id = p.profession_id
    WHERE
        o.order_id = GetStaffProfessionTimeForOrder.order_id;
END;
$$ LANGUAGE plpgsql;


