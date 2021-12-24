
--------------------------SELECT ---------------------------------------

-- Limit the number of rows returned
SELECT
  TOP (50) points PERCENT *
FROM
  eurovision;

-- Return unique countries and use an alias
SELECT
  distinct country as unique_country
FROM
  eurovision;

--------------------------FILTER---------------------------------------

-- TOP(), DESC, ORDER BY, AND, IS NULL, IS NOT NULL


-- Select the first 5 rows from the specified columns
SELECT
  TOP(5) description,
  event_date
FROM grid
  -- Order your results by the event_date column
Order by event_date;


-- Select the top 20 rows from description, nerc_region and event_date
SELECT
  TOP (20) description,
  nerc_region,
  event_date
FROM
  grid
  -- Order by nerc_region, affected_customers & event_date
  -- Event_date should be in descending order
ORDER BY
  nerc_region,
  affected_customers,
  event_date DESC;


-- Select description and event_year
SELECT
  description,
  event_year
FROM
  grid
  -- Filter the results
WHERE
  description = 'Vandalism';

-- Select nerc_region and demand_loss_mw
SELECT
  nerc_region,
  demand_loss_mw
FROM
  grid
-- Retrieve rows where affected_customers is >= 500000  (500,000)
WHERE
  affected_customers >= 500000;



-- Select description and affected customers
SELECT
  description,
  affected_customers, event_date
FROM
  grid
  -- Retrieve rows where the event_date was the 22nd December, 2013
  where
  event_date = '2013-12-22'


-- Select description, affected_customers and event date
SELECT
  description,
  affected_customers,
  event_date
FROM
  grid
  -- The affected_customers column should be >= 50000 and <=150000
WHERE
  affected_customers BETWEEN 50000
  AND 150000
   -- Define the order
order by
 event_date DESC;


-- Retrieve all columns
SELECT
  *
FROM
  grid
  -- Return rows where demand_loss_mw is not missing or unknown
WHERE
  demand_loss_mw IS NULL;




-- Retrieve all columns
SELECT
  *
FROM
  grid
  -- Return rows where demand_loss_mw is not missing or unknown
WHERE
  demand_loss_mw IS NOT NULL;



SELECT
  song,
  artist,
  release_year
FROM
  songlist
WHERE
  -- Retrieve records greater than and including 1980
  release_year >= 1980
  -- Also retrieve records up to and including 1990
  AND release_year <= 1990
ORDER BY
  artist,
  release_year;



SELECT
  artist,
  release_year,
  song
FROM
  songlist
  -- Choose the correct artist and specify the release year
WHERE
  (
    artist LIKE 'B%'
    and release_year = 1986
  )
  -- Or return all songs released after 1990
  or release_year > 1990
  -- Order the results
ORDER BY
  release_year,
  artist,
  song;

--------------------------AGGREGATION---------------------------------------


-- SUM(), MIN(), AS, MAX(), AVG, LEN(), LEFT(DDD, 20), RIGHT()
-- CHARINDEX ('_', URL) AS ...
-- SUBSTRING(URL, START, NUMBER)
-- REPLACE(URL, '', '')
-- Group by
-- Sum the demand_loss_mw column
SELECT
  sum(demand_loss_mw) AS MRO_demand_loss
FROM
  grid
WHERE
  -- demand_loss_mw should not contain NULL values
  demand_loss_mw is not NULL
  -- and nerc_region should be 'MRO';
  and nerc_region = 'MRO';


-- Obtain a count of 'grid_id'
SELECT
  COUNT(grid_id) AS RFC_count
FROM
  grid
-- Restrict to rows where the nerc_region is 'RFC'
where
  nerc_region = 'RFC';



-- Find the maximum number of affected customers
SELECT
  MIN(affected_customers) AS min_affected_customers
FROM
  grid
-- Only retrieve rows where demand_loss_mw has a value
WHERE
  demand_loss_mw IS NOT NULL;



-- Find the average number of affected customers
SELECT
  MAX(affected_customers) AS max_affected_customers
FROM
  grid
-- Only retrieve rows where demand_loss_mw has a value
WHERE
  demand_loss_mw IS NOT NULL;


-- Find the average number of affected customers
SELECT
  AVG(affected_customers) AS avg_affected_customers
FROM
  grid
-- Only retrieve rows where demand_loss_mw has a value
WHERE
  demand_loss_mw IS NOT NULL;


-- Calculate the length of the description column
SELECT
 LEN(description) AS description_length
FROM
  grid;

-- Amend the query to select 25 characters from the  right of the description column
SELECT
  LEFT(description, 20) AS left_25_left
FROM
  grid;

-- Amend the query to select 25 characters from the  right of the description column
SELECT
  RIGHT(description, 20) AS last_25_right
FROM
  grid;


-- Complete the query to find `Weather` within the description column
SELECT
  description,
  CHARINDEX('Weather', description)
FROM
  grid
WHERE description LIKE '%Weather%';



-- Complete the query to find the length of `Weather'
SELECT
  description,
  CHARINDEX('Weather', description) AS start_of_string,
  LEN('Weather') AS length_of_string
FROM
  grid
WHERE description LIKE '%Weather%';


-- Complete the substring function to begin extracting from the correct character in the description column
SELECT TOP (10)
  description,
  CHARINDEX('Weather', description) AS start_of_string,
  LEN ('Weather') AS length_of_string,
  SUBSTRING(
    description,
    15,
    LEN(description)
  ) AS additional_description
FROM
  grid
WHERE description LIKE '%Weather%';



-- Select the region column
SELECT
  nerc_region,
  -- Sum the demand_loss_mw column
  SUM(demand_loss_mw) AS demand_loss
FROM
  grid
  -- Exclude NULL values of demand_loss
WHERE
  demand_loss_mw is not null
  -- Group the results by nerc_region
Group BY
  nerc_region
  -- Order the results in descending order of demand_loss
ORDER BY
  demand_loss DESC;



-- Having clause
SELECT
  nerc_region,
  SUM (demand_loss_mw) AS demand_loss
FROM
  grid
  -- Remove the WHERE clause
WHERE demand_loss_mw  IS NOT NULL
GROUP BY
  nerc_region
  -- Enter a new HAVING clause so that the sum of demand_loss_mw is greater than 10000
HAVING
  SUM(demand_loss_mw) > 10000
ORDER BY
  demand_loss DESC;



-- Retrieve the minimum and maximum place values
SELECT
  -- the lower the value the higher the place, so MIN = the highest placing
  MIN(place) AS hi_place,
  MAX(place) AS lo_place,
  -- Retrieve the minimum and maximum points values
  MIN(points) AS min_points,
  MAX(points) AS max_points
FROM
  eurovision;
  -- Group by country
Group by
  country;

-- Retrieve the minimum and maximum place values
SELECT
  -- the lower the value the higher the place, so MIN = the highest placing
  MIN(place) AS hi_place,
  MAX(place) AS lo_place,
  -- Retrieve the minimum and maximum points values
  MIN(points) AS min_points,
  MAX(points) AS max_points
FROM
  eurovision
  -- Group by country
GROUP BY
  country;



-- Obtain a count for each country
SELECT
  count(country) AS country_count,
  -- Retrieve the country column
  country,
  -- Return the average of the Place column
  AVG(place) AS average_place,
  AVG(points) AS avg_points,
  MIN(points) AS min_points,
  MAX(points) AS max_points
FROM
  eurovision
GROUP BY
  country;


SELECT
  country,
  COUNT (country) AS country_count,
  AVG (place) AS avg_place,
  AVG (points) AS avg_points,
  MIN (points) AS min_points,
  MAX (points) AS max_points
FROM
  eurovision
GROUP BY
  country
  -- The country column should only contain those with a count greater than 5
HAVING
  COUNT(country) > 5
  -- Arrange columns in the correct order
ORDER BY
  avg_place,
  avg_points DESC;

--  Joining table

SELECT
    track_id,
    name AS track_name,
    title AS album_title
FROM track
         -- Complete the join type and the common joining column
         INNER JOIN album on track.album_id = album.album_id;


-- Select album_id and title from album, and name from artist
SELECT
    album_id,
    title,
    name AS artist
    -- Enter the main source table name
FROM album
         -- Perform the inner join
         INNER JOIN artist on album.artist_id = artist.artist_id;


SELECT track_id,
-- Enter the correct table name prefix when retrieving the name column from the track table
       track.name AS track_name,
       title as album_title,
       -- Enter the correct table name prefix when retrieving the name column from the artist table
       artist.name AS artist_name
FROM track
         -- Complete the matching columns to join album with track, and artist with album
         INNER JOIN album on track.album_id = album.album_id
         INNER JOIN artist on album.artist_id = artist.artist_id;


-- INNER JOIN only returns matching rows
-- LEFT JOIN Or RIGHT JOIN returns all rows from the main table plus matches from the joining

SELECT
    invoiceline_id,
    unit_price,
    quantity,
    billing_state
    -- Specify the source table
FROM invoiceline
         -- Complete the join to the invoice table
         LEFT JOIN invoice on invoiceline.invoice_id = invoice.invoice_id;


-- SELECT the fully qualified album_id column from the album table
SELECT
    album.album_id,
    album.title,
    album.artist_id,
    -- SELECT the fully qualified name column from the artist table
    artist.name as artist
FROM album
-- Perform a join to return only rows that match from both tables
         INNER JOIN artist ON album.artist_id = artist.artist_id
WHERE album.album_id IN (213,214)


SELECT
    album.album_id,
    title,
    album.artist_id,
    artist.name as artist
FROM album
         INNER JOIN artist ON album.artist_id = artist.artist_id
-- Perform the correct join type to return matches or NULLS from the track table
         RIGHT JOIN track on album.album_id = track.album_id
WHERE album.album_id IN (213,214)

--------------------------UNION---------------------------------------
-- UNION, UNION ALL,

SELECT
    album_id AS ID,
    title AS description,
    'Album' AS Source
    -- Complete the FROM statement
FROM Album
     -- Combine the result set using the relevant keyword
UNION
SELECT
    artist_id AS ID,
    name AS description,
    'Artist'  AS Source
    -- Complete the FROM statement
FROM Artist;

----------------------------------Update table CRUD---------------------------------------

-- CREATE  date(YYYY-MM-DD) datetime(YYY-MM-DD hh:mm:ss) 1= true 0 false

-- Create the table
-- Create the table
CREATE TABLE results (
    -- Create track column
                         track VARCHAR(200),
    -- Create artist column
                         artist VARCHAR(120),
    -- Create album column
                         album VARCHAR(160),
    -- Create track_length_mins
                         track_length_mins INT,
);

-- Select all columns from the table
SELECT
    track,
    artist,
    album,
    track_length_mins
FROM
    results;



-- Create the table
CREATE TABLE tracks(
    -- Create track column
                       track VARCHAR(200),
    -- Create album column
                       album VARCHAR(160),
    -- Create track_length_mins column
                       track_length_mins INT
);
-- Complete the statement to enter the data to the table
INSERT INTO tracks
-- Specify the destination columns
(track, album, track_length_mins)
-- Insert the appropriate values for track, album and track length
VALUES
    ('Basket Case', 'Dookie', 3);
-- Select all columns from the new table
SELECT
    *
FROM
    tracks;