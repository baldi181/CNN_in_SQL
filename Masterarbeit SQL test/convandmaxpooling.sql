# full step of forward pass


#faltten to vector
SELECT (i-1)*2+j as i, 1 as j, v1 as v
FROM 

#stride (2)
(
SELECT CEIL(sub3.i/2) as i , CEIL(sub3.j/2) as j, sub3.v1
    
FROM #maxpooling
    (SELECT 
        MAX(v) AS v1,
            neighborhoodmax1.i AS i,
            neighborhoodmax1.j AS j,
            istrich,
            jstrich
    FROM #conv
        (SELECT 
        sub.i AS i, sub.j AS j, SUM(sub.v1 * filter.v) AS v
    FROM
        (SELECT 
        v AS v1,
            neighborhood1.i AS i,
            neighborhood1.j AS j,
            istrich,
            jstrich
    FROM
        testimage, neighborhood1
    WHERE
        testimage.i = istrich
            AND testimage.j = jstrich) sub
    JOIN filter ON sub.istrich - sub.i + 2 = filter.i
        AND sub.jstrich - sub.j + 2 = filter.j
    GROUP BY sub.i , sub.j) sub2, neighborhoodmax1
    WHERE
        sub2.i = istrich AND sub2.j = jstrich
    GROUP BY i , j) sub3
    
    WHERE i mod 2=0 and j mod 2=0
    )sub4
    
