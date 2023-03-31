-- Challenge 1 - Most Profiting Authors

---------------------------------------------------------


SELECT  author_id,
	  SUM(Advance) + SUM(agg_royalty) AS Profit
		
FROM (
		SELECT  title_id,
			  author_id,
			  MAX(Advance) AS Advance,
			  SUM(royalty) AS agg_royalty
		
		FROM   (
				SELECT  ta.title_id AS title_id,
					  a.au_id AS author_id,
					  COALESCE(t.advance * ta.royaltyper / 100, 0) AS Advance,
					  COALESCE(t.price * s.qty * t.royalty / 100 * ta.royaltyper/100, 0) AS Royalty
		
				FROM sales s 
				INNER JOIN titleauthor ta ON s.title_id = ta.title_id AND a.au_id = ta.au_id
				INNER JOIN titles t ON ta.title_id = t.title_id
				INNER JOIN authors a ON a.au_id = ta.au_id
				)summary
	
		GROUP BY title_id, author_id
	 )
		
GROUP BY author_id

ORDER BY Profit

---------------------------------------------------------

-- Challenge 2 - Alternative Solution

---------------------------------------------------------

-- STEP 1

CREATE TEMP TABLE step_1 AS

SELECT  ta.title_id AS title_id,
	  a.au_id AS author_id,
	  COALESCE(t.advance * ta.royaltyper / 100, 0) AS Advance,
	  COALESCE(t.price * s.qty * t.royalty / 100 * ta.royaltyper/100, 0) AS Royalty

FROM sales s 
INNER JOIN titleauthor ta ON s.title_id = ta.title_id AND a.au_id = ta.au_id
INNER JOIN titles t ON ta.title_id = t.title_id
INNER JOIN authors a ON a.au_id = ta.au_id


-- STEP 2

CREATE TEMP TABLE step_2 AS

SELECT  title_id,
	  author_id,
	  MAX(Advance) AS Advance,
  	  SUM(royalty) AS agg_royalty
		
FROM  step_1
	
GROUP BY title_id, author_id

-- STEP 3

SELECT  author_id,
	  SUM(Advance) + SUM(agg_royalty) AS Profit
		
FROM step_2
		
GROUP BY author_id

ORDER BY Profit

---------------------------------------------------------

-- Challenge 3

---------------------------------------------------------

CREATE TABLE most_profiting_authors AS
SELECT  author_id,
	  SUM(Advance) + SUM(agg_royalty) AS Profit		
FROM step_2		
GROUP BY author_id
ORDER BY Profit




