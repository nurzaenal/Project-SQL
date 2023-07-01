WITH unique_prices AS (
    SELECT DISTINCT "from", "to", price
    FROM flight_dataset
),
ranked_prices AS (
    SELECT "from", "to", price, 
           ROW_NUMBER() OVER(PARTITION BY "from", "to" ORDER BY price DESC) AS price_rank
    FROM unique_prices
),
user_transaction_counts AS (
    SELECT a.user_id, b.price_rank, COUNT(a.travel_id) AS transaction_count
    FROM flight_dataset AS a
    JOIN ranked_prices AS b ON a."from" = b."from" AND a."to" = b."to" AND a.price = b.price
    GROUP BY a.user_id, b.price_rank
	
),
max_transactions AS (
    SELECT user_id, MAX(transaction_count) AS max_transaction
    FROM user_transaction_counts
    GROUP BY user_id
),
user_rankings AS (
    SELECT a.*, b.price_rank
    FROM user_dataset AS a
    JOIN user_transaction_counts AS b ON a.user_id = b.user_id
    RIGHT JOIN max_transactions AS c ON b.user_id = c.user_id AND b.transaction_count = c.max_transaction
)
SELECT * FROM user_rankings
