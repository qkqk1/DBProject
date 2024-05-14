-- Функция, обновляющая общую стоимость заказа
CREATE OR REPLACE FUNCTION UpdateTotalCost()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE delivery.Orders
  SET order_total_cost = (
    SELECT SUM(dish_price)
    FROM delivery.Orders_and_Dishes
    JOIN delivery.Dishes ON delivery.Orders_and_Dishes.dish_id = delivery.Dishes.dish_id
    WHERE order_id = NEW.order_id
  )
  WHERE order_id = NEW.order_id;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- Триггер, вызывающий функцию UpdateTotalCost
CREATE OR REPLACE TRIGGER UpdateTotalCostTrigger
AFTER INSERT OR UPDATE OR DELETE ON delivery.Orders_and_Dishes
FOR EACH ROW
EXECUTE FUNCTION UpdateTotalCost();


-- Функция, обновляющая меню ресторана:
CREATE OR REPLACE FUNCTION UpdateRestaurantComment()
RETURNS TRIGGER AS $$
DECLARE
  new_restaurant_comment VARCHAR(255);
BEGIN
  SELECT r.restaurant_comment
  INTO new_restaurant_comment
  FROM delivery.Restaurants r
  JOIN delivery.Dishes_and_Restaurants dr ON r.restaurant_id = dr.restaurant_id
  JOIN delivery.Dishes d ON dr.dish_id = d.dish_id
  JOIN delivery.Orders_and_Dishes od ON d.dish_id = od.dish_id
  WHERE od.order_id = NEW.order_id;

  UPDATE delivery.Restaurants
  SET restaurant_comment = new_restaurant_comment
  WHERE restaurant_id IN (
    SELECT rd.restaurant_id
    FROM delivery.Dishes_and_Restaurants dr
    JOIN delivery.Orders_and_Dishes od ON dr.dish_id = od.dish_id
    WHERE od.order_id = NEW.order_id
  );

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Триггер, вызывающий функцию UpdateRestaurantComment:
CREATE TRIGGER UpdateRestaurantCommentTrigger
AFTER INSERT OR UPDATE OR DELETE ON delivery.Orders_and_Dishes
FOR EACH ROW
EXECUTE FUNCTION UpdateRestaurantComment();
