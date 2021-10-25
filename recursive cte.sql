WITH recursive ways_from_s_to_y (to_node2, way, is_cycle)
 AS
 (SELECT DISTINCT from_node, array[from_node], false
 FROM graph
 WHERE from_node = 'S'
 UNION ALL
 SELECT to_node,
 wfsty.way || g.to_node as way,
 g.to_node = any(wfsty.way) as is_cycle
 FROM graph as g
 INNER JOIN ways_from_s_to_y as wfsty
 ON wfsty.to_node2 = g.from_node AND NOT is_cycle)
SELECT way FROM ways_from_s_to_y WHERE to_node2 = 'Y' AND NOT is_cycle;

WITH recursive shortest_way_from_s_to_y (to_node2, distance, way, is_cycle)
 AS
 (SELECT DISTINCT from_node, 0, array[from_node], false
 FROM graph
 WHERE from_node = 'S'
 UNION ALL
 SELECT to_node,
 swfsty.distance + g.distance,
 swfsty.way || g.to_node as way,
 g.to_node = any(swfsty.way) as is_cycle
 FROM graph as g
 INNER JOIN shortest_way_from_s_to_y as swfsty
 ON swfsty.to_node2 = g.from_node AND NOT is_cycle),
short (distance)
 AS (SELECT MIN(distance)
 FROM shortest_way_from_s_to_y
 WHERE to_node2 = 'Y')
 SELECT * FROM shortest_way_from_s_to_y swfsty
 INNER JOIN short s
 ON swfsty.distance = s.distance;

