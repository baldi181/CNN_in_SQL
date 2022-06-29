# 2d conv test

#select region

SELECT image.i, image.j, image.v
FROM image
WHERE image.i BETWEEN image.i AND image.i+5;

CALL conv22();