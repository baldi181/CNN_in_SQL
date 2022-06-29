# try index conv
delete from neighborhood28;

LOAD DATA INFILE  'C:\Neighborhood28_sql.csv'
INTO TABLE neighborhood28
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';
#IGNORE 1 ROWS;

SELECT sameconv.i-2, sameconv.j-2, netinput
FROM
	(
    
    SELECT verbund.i as i, verbund.j as j, k1.v , verbund.re as re, SUM(k1.v*verbund.re) +b1.v as netinput
    FROM b1, k1 join(
	SELECT image_sql_fft.i as i, image_sql_fft.j as j, image_sql_fft.re as re, neighborhood28.id as id, neighborhood28.istrich as ni, neighborhood28.jstrich as nj
	FROM image_sql_fft join neighborhood28 on image_sql_fft.i=neighborhood28.i and image_sql_fft.j=neighborhood28.j ) verbund
	on ni-verbund.i+3=k1.i and nj-verbund.j+3=k1.j
    WHERE k1.n=1 and b1.i=1
    GROUP BY
    verbund.i, verbund.j) sameconv
    WHERE sameconv.i Between 3 and 26 and sameconv.j Between 3 and 26
	#GROUP BY verbund.i, verbund.j;
    
    #sub.istrich - sub.i + 2 = filter.i