#query for convolution

SELECT sub.i as i, sub.j as j, sub.v1 as v1, filter.v as v2, SUM(sub.v1*filter.v)
FROM (

SELECT  v as v1, neighborhood1.i as i, neighborhood1.j as j, istrich, jstrich
FROM testimage , neighborhood1
WHERE testimage.i=istrich and testimage.j=jstrich) sub

JOIN

filter on sub.istrich-sub.i+2=filter.i and sub.jstrich-sub.j+2=filter.j

GROUP BY

sub.i, sub.j
#, neighborhood1.istrich-testimage.i+2 as i, neighborhood1.jstrich-testimage.j+2 as j
#neighborhood1.istrich - testimage.i+2 as i, neighborhood1.jstrich - testimage.j+2 as j