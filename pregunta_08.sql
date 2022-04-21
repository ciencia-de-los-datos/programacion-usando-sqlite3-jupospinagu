-- 
--  Sea el siguiente conjunto de tablas en una base de datos:
-- 
--    tbl0
--    ------------------------
--    K0  CHAR(1)
--    c01 INT
--    c02 INT
--    c03 CHAR(4)
--    c04 FLOAT
--        
--    tbl1
--    ------------------------
--    K0  CHAR(1)
--    K1  INT
--    c12 FLOAT
--    c13 INT
--    c14 DATE
--    c15 FLOAT
--    c16 CHAR(4)
--
--    tbl2
--    ------------------------
--    K1  INT,
--    c21 FLOAT,
--    c22 INT,
--    c23 DATE,
--    c24 FLOAT,
--    c25 CHAR(5)
--
--  Escriba una consulta que compute el promedio
--  de la columna c21 de la tabla tbl2 por ano 
--  (columna c23).
--
--  Rta/
--     YEAR    avg(c21)
--  0  2016  564.476429
--  1  2017  515.156364
--  2  2018  557.559375
--  3  2019  550.998571
--
--  >>> Escriba su codigo a partir de este punto <<<
--
import pandas as pd

tbl2 = pd.read_csv("tbl2.csv", sep=",", header = None, names=["K1", "c21","c22","c23", "c24", "c25"])
YEAR = pd.DataFrame(tbl2['c23'].str.split('-', expand=True)[0])
YEAR.columns = ['YEAR']   #se nombra la columna como year
tbl2 = tbl2.join(YEAR)  

tbl2.to_sql(
    name="tbl2",
    con=conn,
    if_exists="replace",  # {‘fail’, ‘replace’, ‘append’}
)

SELECT
    YEAR, AVG(c21)
FROM
    tbl2
GROUP BY
   YEAR
