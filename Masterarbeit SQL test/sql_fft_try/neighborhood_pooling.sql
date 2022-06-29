


SELECT ceil(verbund.i/2) as i, ceil(verbund.j/2) as j, MAX(c1.re) as re#id ,ni ,nj, c1.n ,c1.i, c1.j, MAX(c1.re) as re
FROM c1 join
(
SELECT  c1.i as i, c1.j as j, c1.re as re, c1.im as im, neighborhoodmax_sql.id as id, neighborhoodmax_sql.istrich as ni, neighborhoodmax_sql.jstrich as nj
FROM c1 join neighborhoodmax_sql on c1.i=neighborhoodmax_sql.i and c1.j=neighborhoodmax_sql.j ) verbund
on c1.i=ni and c1.j=nj
GROUP BY verbund.i, verbund.j