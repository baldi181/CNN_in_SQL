# load data
LOAD DATA INFILE 'C:\F1.csv' 
INTO TABLE filter 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;
