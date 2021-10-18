WITH RECURSIVE r_managers AS (
 SELECT *
 FROM managers
 WHERE uniqueId = 1
 UNION
 SELECT managers.*
 FROM managers
 JOIN r_managers
 ON managers.parentId = r_managers.uniqueId
)
SELECT * FROM r_managers;
