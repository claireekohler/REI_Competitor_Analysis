-- Clean my data
-- data cleaning process
-- 1. check for duplicates and remove any
-- 2. standardize data and fix errors
-- 3. Look at null values 
-- 4. remove any columns and rows that are not necessary


UPDATE running_shoes_staging 
SET Rating = ABS(Rating);


SELECT DISTINCT Title
FROM running_shoes_staging
;

CREATE TABLE `shoe_features` (
`Title` varchar(64), 
`Features` varchar(256)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

ALTER TABLE shoe_features
DROP COLUMN features;

ALTER TABLE running_shoes_staging 
DROP COLUMN Column9;

INSERT `shoe_features`
SELECT DISTINCT Title
FROM running_shoes_staging;

ALTER TABLE shoe_features 
ADD COLUMN `id` INT PRIMARY KEY AUTO_INCREMENT;

ALTER TABLE `shoe_features`
RENAME TO `master_id`

-- Create table for features

CREATE TABLE shoe_features (
	id INT PRIMARY KEY AUTO_INCREMENT,
	master_id INT,
	features varchar(256),
	FOREIGN KEY (master_id) REFERENCES master_id(id)
);

INSERT INTO shoe_features (master_id, features)
SELECT 
	m.id,
	s.Features 
FROM 
	running_shoes_staging s
JOIN
	master_id m
ON 
	s.Title = m.Title
	
SELECT *
FROM shoe_features;

SELECT * FROM master_id;

SELECT m.Title, s.features, m.id
FROM master_id m, shoe_features s
where m.id = s.master_id
;

ALTER TABLE running_shoes_staging 
DROP COLUMN Features;

SELECT * FROM running_shoes_staging;


-- Get rid of duplicates in staging table now that normalized

ALTER TABLE running_shoes_staging 
ADD COLUMN row_num INT;

ALTER TABLE running_shoes_staging 
ADD COLUMN `id` INT PRIMARY KEY AUTO_INCREMENT;


UPDATE running_shoes_staging rss
JOIN (
	SELECT id, row_num
	FROM (
		SELECT id,
			ROW_NUMBER() OVER (
			PARTITION BY Title) as row_num
		FROM running_shoes_staging
		) AS subquery
) AS duplicate_cte
ON rss.id = duplicate_cte.id
SET rss.row_num = duplicate_cte.row_num;
	
SELECT * 
FROM running_shoes_staging rss 
WHERE row_num >1
ORDER BY Title;

DELETE 
FROM running_shoes_staging 
WHERE row_num > 1;

ALTER TABLE running_shoes_staging 
DROP COLUMN row_num;

-- Data Exploration

-- What shoes are the have the most ratings?
SELECT Title, Brand, Rating
FROM running_shoes_staging 
GROUP BY Title, Brand, Rating 
ORDER BY Rating DESC
LIMIT 5;

-- HOKA's bondi 8 and Clifton 9 have the most ratings at 9K then 4K
-- Brook's Glycerin 20 is third at 2K reviews

-- What shoes have the best ratings?

SELECT *
FROM REI_Running.Ratings
GROUP BY Title, Brand, Ratings 
ORDER BY Ratings DESC
LIMIT 10;
;

-- Interestingly, none of the shoes with the most ratings were ones with
-- the highest 

ALTER TABLE REI_Running.Ratings
CHANGE Time Ratings double;

-- What shoes are the most expensive?
SELECT Title, Brand, Price
FROM REI_Running.running_shoes_staging
GROUP BY Title, Brand, Price 
ORDER BY Price DESC
LIMIT 
;

-- How does rating count and rating value relate?

SELECT *
FROM Ratings;

-- Clean Ratings table 

UPDATE Ratings 
SET Title = LTRIM(SUBSTRING(TITLE, LOCATE(' ', TITLE) + 1));

-- Join tables to look at ratings

SELECT rss.Brand, rss.Title, rss.Rating, rt.Ratings, rss.Price
FROM running_shoes_staging rss
INNER JOIN Ratings rt
	ON rss.Title = rt.Title
GROUP BY rss.Brand, rss.Title, rss.Rating, rt.Ratings, rss.Price
ORDER BY rss.Rating desc
;

-- Most expensive shoes have high ratings however rating count is variable

-- How about average rating by brand?
-- Compared to the number of ratings?
-- Use CTEs


WITH AVG_RATING AS 
(
SELECT Title, AVG(Ratings) as avg_rating
FROM Ratings rt
GROUP BY Title
ORDER BY avg_rating desc
), 
AVG_RATE_CT AS 
(
SELECT Title, AVG(Rating) as avg_rate_ct
FROM running_shoes_staging rss 
GROUP BY Title
ORDER BY avg_rate_ct desc
)
SELECT * 
FROM AVG_RATING
JOIN AVG_RATE_CT
	ON AVG_RATING.Title = AVG_RATE_CT.Title
;

-- Highest rating shoe by rate count is Hoka. Next is adidas then Brooks


-- Highest Rated shoes -- What features?
-- Top three highest ranking shoes with the most rating counts
-- 1. HOKA Bondi 8
-- 2. HOKA Clifton 9
-- 3. Adidas Ultraboost 22

-- What features sell?

SELECT md.Title, sf.features
FROM master_ID md
INNER JOIN shoe_features sf 
	ON md.id = sf.id
WHERE Title LIKE '%Bondi%'
	 OR Title LIKE '%Clifton%'
	 OR Title LIKE '%Ultraboost%'
;
 
-- Highly Rated Features
-- "Reflective heel panel and streamlined tongue with single side medial gusset
-- "Eliminates weight (4 g, to be exact), while adding 3 mm in stack height"
-- "Late Stage Meta-Rocker profile"
-- "Flat-Knit Upper Construction"
-- "Collar Foam Package"

UPDATE shoe_features sf
INNER JOIN master_ID md 
    ON md.id = sf.id
SET sf.features = 'Reflective heel panel and streamlined tongue with single side medial gusset, 
Eliminates weight (4 g, to be exact), while adding 3 mm in stack height'
WHERE md.Title LIKE '%Clifton%';

SELECT * FROM ratings;


