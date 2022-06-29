#fft2 try
#compute 2fft W Image W^T
DELETE FROM c1;
INSERT INTO c1(n,i,j,re,im)
(
SELECT 1 as n,
    netinput.i - 3 AS i,
    netinput.j - 3 AS j,
    IF(re >= 0, re, 0) AS act,
    0 as im
FROM
    (SELECT 
        ifft_scaled.j AS i,
            ifft_scaled.i AS j,
            re / 784 + b1.v AS re
    FROM
        b1, (SELECT 
        W_trans.i AS i,
            WH.WHj AS j,
            SUM(W_trans.re * WHre - W_trans.im * WHim) AS re,
            SUM(W_trans.re * WHim + W_trans.im * WHre) AS im
    FROM
        (SELECT 
        twiddle_real_sql.j AS WHi,
            twiddle_real_sql.i AS WHj,
            twiddle_real_sql.re AS WHre,
            twiddle_real_sql.im AS WHim
    FROM
        twiddle_real_sql) WH
    JOIN (SELECT 
        twiddle_real_sql.i AS i,
            elemwise_ad.j AS j,
            SUM(twiddle_real_sql.re * elemwise_ad.re - twiddle_real_sql.im * elemwise_ad.im) AS re,
            SUM(twiddle_real_sql.re * elemwise_ad.im + twiddle_real_sql.im * elemwise_ad.re) AS im
    FROM
        twiddle_real_sql
    JOIN (SELECT 
        elemwise.j AS i, elemwise.i AS j, re, im
    FROM
        (SELECT 
        imagetrans.i AS i,
            imagetrans.j AS j,
            (imagetrans.re * filterfft_sql.re - imagetrans.im * filterfft_sql.im) AS re,
            -(imagetrans.re * filterfft_sql.im + imagetrans.im * filterfft_sql.re) AS im
    FROM
        (SELECT 
        Wx.Wxi AS i,
            WH.WHj AS j,
            SUM(Wxre * WHre - Wxim * WHim) AS re,
            SUM(Wxre * WHim + Wxim * WHre) AS im
    FROM
        (SELECT 
        twiddle_real_sql.j AS WHi,
            twiddle_real_sql.i AS WHj,
            twiddle_real_sql.re AS WHre,
            twiddle_real_sql.im AS WHim
    FROM
        twiddle_real_sql) WH
    JOIN (SELECT 
        twiddle_real_sql.i AS Wxi,
            image_sql_fft.j AS Wxj,
            SUM(twiddle_real_sql.re * image_sql_fft.re) AS Wxre,
            SUM(twiddle_real_sql.im * image_sql_fft.re) AS Wxim
    FROM
        twiddle_real_sql
    JOIN image_sql_fft ON twiddle_real_sql.j = image_sql_fft.i
    GROUP BY twiddle_real_sql.i , image_sql_fft.j) Wx ON Wx.Wxj = WH.WHi
    GROUP BY Wx.Wxi , WH.WHj) imagetrans
    JOIN filterfft_sql ON imagetrans.i = filterfft_sql.i
        AND imagetrans.j = filterfft_sql.j) elemwise) elemwise_ad ON twiddle_real_sql.j = elemwise_ad.i
    GROUP BY twiddle_real_sql.i , elemwise_ad.j) W_trans ON W_trans.j = WH.Whi
    GROUP BY W_trans.i , WH.Whj) ifft_scaled
    WHERE
        b1.i = 1
            AND ifft_scaled.i BETWEEN 4 AND 27
            AND ifft_scaled.j BETWEEN 4 AND 27) netinput
);

## test max pool
DELETE FROM p1;
CALL max_pool(2);