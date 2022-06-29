#conv as procedure

#CALL conv22()

#elementwise product
SELECT SUM(wise) as val 
FROM
(SELECT k1.i,k1.j, k1.v*region.vv as wise
FROM k1 join
(SELECT image.i as i, image.j as j, image.v as vv
		FROM image
		WHERE image.i BETWEEN 1 AND 1+4 and image.j BETWEEN 1 AND 1+4)  region
        on k1.i=region.i and k1.j=region.j
        GROUP BY region.i, region.j) element;
        
        
        #SELECT * FROM
        ##(SELECT image.i as i, image.j as j, image.v as vv
		#FROM image
		#WHERE image.i BETWEEN image.i-2 AND image.i+2 and image.j BETWEEN image.j-2 AND image.j+2)  region
        