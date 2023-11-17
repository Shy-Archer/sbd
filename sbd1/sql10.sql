--ZAD1--

create or replace view ASYSTENCI(nazwisko,placa,staz)

as select nazwisko,placa_pod+coalesce(placa_dod,0), (DATE '2023-01-01' - zatrudniony) YEAR TO MONTH from pracownicy

where etat in ('ASYSTENT'); 



SELECT nazwisko,placa,staz FROM asystenci order by nazwisko;

DROp VIEW PLACE;

--ZAD2--

CREATE VIEW PLACE (id_zesp,srednia,minimum,maximum,fundusz,L_PENSJI,L_DODATKÓW)

AS select id_zesp,round(avg(placa_pod+coalesce(placa_dod,0)),2),min(placa_pod+coalesce(placa_dod,0)),max(placa_pod+coalesce(placa_dod,0)),sum(placa_pod+coalesce(placa_dod,0)),count(placa_pod),count(placa_dod) from pracownicy

group by id_zesp

order by id_zesp;

select * from place;

--zad3--

select nazwisko, placa_pod from pracownicy join place on pracownicy.id_zesp = place.id_zesp where placa_pod+coalesce(placa_dod,0) < srednia order by nazwisko; 



--zad4--

create view place_minimalne(id_prac,nazwisko,etat,placa_pod)

as select id_prac,nazwisko,etat,placa_pod from pracownicy where placa_pod <=700

with check option constraint za_wysoka_placa;

select * from place_minimalne order by nazwisko;

--zad5--

update place_minimalne

set placa_pod = 800

where nazwisko in ('HAPKE');

--zad6--

create or replace view PRAC_SZEF( ID_PRAC, ID_SZEFA, PRACOWNIK, ETAT, SZEF)

as

select p.id_prac,p.id_szefa, p.nazwisko,p.etat, s.nazwisko from pracownicy p left join pracownicy s on p.id_szefa = s.id_prac;



INSERT INTO PRAC_SZEF (ID_PRAC, ID_SZEFA, PRACOWNIK, ETAT)

 VALUES (280,150, 'MORZY','ASYSTENT');

UPDATE PRAC_SZEF SET ID_SZEFA = 130 WHERE ID_PRAC = 280;

 DELETE FROM PRAC_SZEF WHERE ID_PRAC = 280;

 

 select * FROM PRAC_SZEF order by pracownik;

 

 select *  from pracownicy;

 --zad7--

create or replace view ZAROBKI(ID_PRAC, NAZWISKO, ETAT, PLACA_POD)

as select ID_PRAC, NAZWISKO, ETAT, PLACA_POD from PRACOWNICY p where placa_pod <= (select  placa_pod from pracownicy where pracownicy.id_prac = p.id_szefa)

WITH CHECK OPTION CONSTRAINT za_wysoka_placa1;



select * from zarobki order by nazwisko;



 UPDATE ZAROBKI SET PLACA_POD = 2000

 WHERE NAZWISKO = 'BIALY';

 --zad8--

SELECT column_name, updatable, insertable, deletable

 FROM user_updatable_columns

 WHERE table_name = 'PRAC_SZEF';    