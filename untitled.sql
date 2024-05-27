# Bài tập SQL
CREATE TABLE food_type (
    type_id INT PRIMARY KEY,
    type_name VARCHAR(100)
);

CREATE TABLE food (
    food_id INT PRIMARY KEY,
    food_name VARCHAR(100),
    image VARCHAR(255),
    price FLOAT,
    description VARCHAR(255),
    type_id INT,
    FOREIGN KEY (type_id) REFERENCES food_type(type_id)
);

CREATE TABLE sub_food (
	sub_id INT PRIMARY KEY,
	sub_name VARCHAR(100),
	sub_price FLOAT,
	food_id INT,
	FOREIGN KEY (food_id) REFERENCES food(food_id)
)

CREATE TABLE user(
    user_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(100),
    password VARCHAR(50)
);

CREATE TABLE `order` (
    user_id INT,
    food_id INT, 
    amount INT,
    code VARCHAR(255),
    arr_sub_id VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (food_id) REFERENCES food(food_id)
);

CREATE TABLE restaurant (
	res_id INT PRIMARY KEY,
	res_name VARCHAR(100),
	image VARCHAR(255),
	`desc` VARCHAR(255)
)

CREATE TABLE rate_res (
    user_id INT,
    res_id INT,
    amount INT,
    date_rate DATETIME,
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (res_id) REFERENCES restaurant(res_id)
);

CREATE TABLE like_res (
    user_id INT,
    res_id INT,
    date_like DATETIME,
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (res_id) REFERENCES restaurant(res_id)
);

# Tìm 5 người đã like nhà hàng nhiều nhất

SELECT user.user_id, user.full_name, COUNT(like_res.date_like) AS total_likes
FROM like_res
JOIN user ON like_res.user_id = user.user_id
GROUP BY user.user_id, user.full_name
ORDER BY total_likes DESC
LIMIT 5;

# Tìm 2 nhà hàng có lượt like nhiều nhất

SELECT restaurant.res_id, restaurant.res_name, COUNT(like_res.res_id) AS num_likes
FROM like_res
JOIN restaurant ON like_res.res_id = restaurant.res_id
GROUP BY like_res.res_id, restaurant.res_name
ORDER BY num_likes DESC
LIMIT 2;

# Tìm người đã đặt hàng nhiều nhất

SELECT user.user_id, user.full_name, SUM(`order`.amount) AS total_amount
FROM `order`
JOIN user ON `order`.user_id = user.user_id
GROUP BY user.user_id, user.full_name
ORDER BY total_amount DESC
LIMIT 1;

# Tìm người không dùng hoạt động trong hệ thống

SELECT user_id, full_name
FROM user
WHERE user_id NOT IN (
    SELECT user_id FROM `order`
    UNION
    SELECT user_id FROM like_res
    UNION
    SELECT user_id FROM rate_res
);












 

