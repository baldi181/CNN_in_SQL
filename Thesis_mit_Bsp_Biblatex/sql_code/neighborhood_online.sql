SELECT KREUZ.I,
       KREUZ.J,
       SUM(KREUZ.VSTRICH * F.V) AS V
FROM
  (SELECT X1.I AS I,
          X1.J AS J,
          X1.V AS V,
          X2.I AS ISTRICH,
          X2.J AS JSTRICH,
          X2.V AS VSTRICH
   FROM X X1
   CROSS JOIN X X2
   WHERE X2.I - X1.I BETWEEN -l AND l
     AND X2.J - X1.J BETWEEN -l AND l ) KREUZ
JOIN K ON K.I = KREUZ.ISTRICH - KREUZ.I + (l+1)
AND K.J = KREUZ.JSTRICH - KREUZ.J + (l+1)
GROUP BY KREUZ.I,
         KREUZ.J