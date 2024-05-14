-- Функция, обновляющая рейтинг ресторана:
CREATE OR REPLACE FUNCTION update_restaurant_rating()
RETURNS TRIGGER AS $$
DECLARE
  new_restaurant_rating INTEGER;
BEGIN
  SELECT r.restaurant_rating
  INTO new_restaurant_rating
  FROM delivery.Restaurant r
  JOIN delivery.Restaurant_and_Dishes rd ON r.restaurant_id = rd.restaurant_id
  JOIN delivery.Dishes d ON rd.dish_id = d.dish_id
  JOIN delivery.Orders_and_Dishes od ON d.dish_id = od.dish_id
  WHERE od.order_id = NEW.order_id;

  UPDATE delivery.Restaurants
  SET restaurant_rating = new_restaurant_rating
  WHERE restaurant_id IN (
    SELECT rd.restaurant_id
    FROM delivery.Restaurant_and_Dishes rd
    JOIN delivery.Orders_and_Dishes od ON rd.dish_id = od.dish_id
    WHERE od.order_id = NEW.order_id
  );

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Триггер, вызывающий функцию update_restaurant_rating():
CREATE TRIGGER update_restaurant_rating_trigger
AFTER INSERT OR UPDATE OR DELETE ON delivery.Orders_and_Dishes
FOR EACH ROW
EXECUTE FUNCTION update_restaurant_rating();
