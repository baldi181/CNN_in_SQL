SELECT kreuz.i AS i,
       kreuz.j AS j,
       SUM(kreuz.vstrich * K.v) AS v
FROM
  (SELECT X1.i AS i,
          X1.j AS j,
          X1.v AS v,
          X2.i AS istrich,
          X2.j AS jstrich,
          X2.v AS vstrich
   FROM X X1
   CROSS JOIN X X2
   WHERE X2.i - X1.i BETWEEN -l AND l
     AND X2.j - X1.j BETWEEN -l AND l ) kreuz
JOIN K ON K.i = kreuz.istrich - kreuz.i + (l+1)
AND K.j = kreuz.jstrich - kreuz.j + (l+1)
GROUP BY kreuz.i,
         kreuz.j