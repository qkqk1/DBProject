CREATE SCHEMA delivery;

CREATE TABLE delivery.Professions (
  profession_id SERIAL PRIMARY KEY,
  profession_name VARCHAR(255) NOT NULL,
  profession_salary INTEGER NOT NULL,
  profession_start_t TIME NOT NULL,
  profession_end_t TIME NOT NULL
);

CREATE TABLE delivery.Clients (
  client_id SERIAL PRIMARY KEY,
  client_name VARCHAR(255) NOT NULL,
  client_surname VARCHAR(255) NOT NULL,
  client_address VARCHAR(255) NOT NULL,
  client_phone_number VARCHAR(255) NOT NULL
);

CREATE TABLE delivery.Restaurants (
  restaurant_id SERIAL PRIMARY KEY,
  restaurant_name VARCHAR(255) NOT NULL,
  restaurant_rating INTEGER NOT NULL,
  restaurant_comment VARCHAR(255) NOT NULL
);

CREATE TABLE delivery.Staff (
  staff_id SERIAL PRIMARY KEY,
  staff_name VARCHAR(255) NOT NULL,
  staff_surname VARCHAR(255) NOT NULL,
  staff_phone_number VARCHAR(255) NOT NULL,
  profession_id INTEGER REFERENCES delivery.Professions(profession_id)
);

CREATE TABLE delivery.Orders (
  order_id SERIAL PRIMARY KEY,
  order_datetime_start TIMESTAMP NOT NULL,
  order_datetime_end TIMESTAMP NOT NULL,
  client_id INTEGER REFERENCES delivery.Clients(client_id),
  staff_id INTEGER REFERENCES delivery.Staff(staff_id),
  order_total_cost INTEGER NOT NULL
);

CREATE TABLE delivery.Promotions (
  promotion_id SERIAL PRIMARY KEY,
  promotion_name VARCHAR(255) NOT NULL,
  promotion_description VARCHAR(255) NOT NULL,
  promotion_datetime_start TIMESTAMP NOT NULL,
  promotion_datetime_end TIMESTAMP NOT NULL,
  client_id INTEGER REFERENCES delivery.Clients(client_id)
);

CREATE TABLE delivery.Dishes (
  dish_id SERIAL PRIMARY KEY,
  dish_name VARCHAR(255) NOT NULL,
  dish_description VARCHAR(255) NOT NULL,
  dish_price INTEGER NOT NULL,
  dish_weight INTEGER NOT NULL
);

CREATE TABLE delivery.Cities (
  city_id SERIAL PRIMARY KEY,
  city_name VARCHAR(255) NOT NULL,
  city_time_zone VARCHAR(255) NOT NULL,
  order_id INTEGER REFERENCES delivery.Orders(order_id)
);

CREATE TABLE delivery.Reviews (
  review_id SERIAL PRIMARY KEY,
  review_date DATA NOT NULL,
  review_rating INTEGER NOT NULL,
  review_text VARCHAR(255) NOT NULL,
  client_id INTEGER REFERENCES delivery.Clients(client_id)
);

CREATE TABLE delivery.Order_History (
  order_history_id SERIAL PRIMARY KEY,
  client_id INTEGER REFERENCES delivery.Clients(client_id),
  order_id INTEGER REFERENCES delivery.Orders(order_id)
);

CREATE TABLE delivery.Orders_and_Dishes (
  order_id INTEGER REFERENCES delivery.Orders(order_id),
  dish_id INTEGER REFERENCES delivery.Dishes(dish_id),
  PRIMARY KEY (order_id, dish_id)
);

CREATE TABLE delivery.Dishes_and_Restaurants (
  dish_id INTEGER REFERENCES delivery.Dishes(dish_id),
  restaurant_id INTEGER REFERENCES delivery.Restaurants(restaurant_id),
  PRIMARY KEY (dish_id, restaurant_id)
);