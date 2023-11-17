--ZAD1--
create table PROJEKTY(ID_PROJEKTU NUMBER(4) GENERATED ALWAYS AS IDENTITY,
OPIS_PROJEKTU VARCHAR2(20 CHAR),
DATA_ROZPOCZECIA DATE DEFAULT CURRENT_DATE,
DATA_ZAKONCZENIA DATE,
FUNDUSZ NUMBER(7,2));
--ZAD2--
INSERT INTO PROJEKTY(OPIS_PROJEKTU,DATA_ROZPOCZECIA,DATA_ZAKONCZENIA,FUNDUSZ)
VALUES('INDEKSY BITMAPOWE',DATE '1999-04-02',DATE '2001-08-31',25000);
INSERT INTO PROJEKTY(OPIS_PROJEKTU,DATA_ROZPOCZECIA,FUNDUSZ)
VALUES('SIECI KRÊGOS£UPOWE',DEFAULT,19000);
--ZAD3--
Select id_projektu, opis_projektu from projekty;
--ZAD4--
--Error report 
--SQL Error: ORA-32795: nie mo¿na wstawiæ do kolumny to¿samoœci utworzonej jako GENERATED ALWAYS
--32795.0000 -  "cannot insert into a generated always identity column"
--*Cause:    An attempt was made to insert a value into an identity column
  --         created with GENERATED ALWAYS keywords.
--*Action:   A generated always identity column cannot be directly inserted.
  --         Instead, the associated sequence generator must provide the value.--
INSERT INTO PROJEKTY(OPIS_PROJEKTU,DATA_ROZPOCZECIA,DATA_ZAKONCZENIA,FUNDUSZ)
VALUES('INDEKSY DRZEWIASTE',DATE '2013-12-24',DATE '2014-01-01',1200);
Select id_projektu, opis_projektu from projekty;
--zad5--
update projekty
set id_projektu = 10
where opis_projektu = 'INDEKSY DRZEWIASTE';
--Error report -
--SQL Error: ORA-32796: nie mo¿na zaktualizowaæ kolumny to¿samoœci utworzonej jako GENERATED ALWAYS
--32796.0000 -  "cannot update a generated always identity column"
--*Cause:    An attempt was made to update an identity column created with
  --         GENERATED ALWAYS keywords.
--*Action:   A generated always identity column cannot be directly updated.
--zad6--
create table PROJEKTY_KOPIA
AS SELECT * FROM projekty;

--zad7--
INSERT INTO PROJEKTY_KOPIA(id_projektu,OPIS_PROJEKTU,DATA_ROZPOCZECIA,DATA_ZAKONCZENIA,FUNDUSZ)
VALUES(10,'SIECI LOKALNE',CURRENT_DATE,CURRENT_DATE+INTERVAL '1' YEAR,24500);
SELECT * FROM PROJEKTY_KOPIA;
--ZAD8--
DELETE FROM PROJEKTY
WHERE OPIS_PROJEKTU IN('INDEKSY DRZEWIASTE');
select * from PROJEKTY;
SELECT * FROM PROJEKTY_KOPIA; --nie zosta³o usuniete
--ZAD9--
SELECT table_name FROM user_tables;
