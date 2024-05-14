CREATE INDEX ON delivery.Orders(order_datetime_start);
CREATE INDEX ON delivery.Orders(order_datetime_end);
CREATE INDEX ON delivery.Orders(client_id);

CREATE INDEX ON delivery.Restaurants(restaurant_name);
CREATE INDEX ON delivery.Restaurants(restaurant_rating);

CREATE INDEX ON delivery.Dishes(dish_name);
CREATE INDEX ON delivery.Dishes(dish_price);

CREATE INDEX ON delivery.Staff(staff_phone_number);

CREATE INDEX ON delivery.Reviews(review_rating);

CREATE INDEX ON delivery.Clients(client_name);
CREATE INDEX ON delivery.Clients(client_phone_number);
CREATE INDEX ON delivery.Clients(client_address);

CREATE INDEX ON delivery.Promotions(promotion_name);
CREATE INDEX ON delivery.Promotions(promotion_description);

CREATE INDEX ON delivery.Cities(city_name);
