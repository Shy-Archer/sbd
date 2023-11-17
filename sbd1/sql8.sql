--zad1--
INSERT INTO pracownicy
VALUES(250, 'KOWALSKI','ASYSTENT',NULL,'2015-01-13',1500,NULL,10);
INSERT INTO pracownicy
VALUES(260, 'ADAMSKI','ASYSTENT',NULL,'2014-09-10',1500,NULL,10);
INSERT into pracownicy
values(270,'NOWAK','ADIUNKT',null,'1990-05-01',2050,540,20);
SELECT * FROM PRACOWNICY where id_prac >=250;
--2--
update PRACOWNICY
set placa_pod = placa_pod+placa_pod*0.1,
    placa_dod = coalesce(placa_dod+placa_dod*0.2,100)
where id_prac >= 250;
SELECT * FROM PRACOWNICY where id_prac >=250;
--3--
insert into zespoly
values(60,'BAZY DANYCH', 'PIOTROWO 2');
SELECT * from zespoly where id_zesp = 60;
--4--
update Pracownicy p
set id_zesp = (select id_zesp from zespoly where nazwa = 'BAZY DANYCH')
where id_prac >= 250;
SELECT p.id_prac, p.nazwisko,p.etat,p.id_szefa,p.zatrudniony,p.placa_pod,p.placa_dod,p.id_zesp FROM PRACOWNICY p JOIN ZESPOLY Z on p.id_zesp = Z.id_zesp where nazwa in ('BAZY DANYCH');
--5--
update PRACOWNICY 
SET ID_SZEFA = (select id_prac from pracownicy where nazwisko in ('MORZY'))
where id_zesp = (select id_zesp from zespoly where nazwa = 'BAZY DANYCH');
select p.id_prac, p.nazwisko,p.etat,p.id_szefa,p.zatrudniony,p.placa_pod,p.placa_dod,p.id_zesp from pracownicy p join pracownicy s on p.id_szefa = s.id_prac where s.nazwisko = 'MORZY';

--6--
delete from zespoly
where nazwa in('BAZY DANYCH'); --REKORDY DODANE W  RELACJI PRACOWNICY S¥ PODRZEDNE WZGLEDEM TEGO REKORDU CO UNIEMOW¯LIWIA USUNIECIE--
--7--
delete from PRACOWNICY
where id_zesp = (select id_zesp from zespoly where nazwa = 'BAZY DANYCH');
delete from zespoly
where nazwa in('BAZY DANYCH');
--8--
select nazwisko, placa_pod,  s.srednia*0.1  
from pracownicy p
join (select id_zesp, avg(placa_pod) as srednia from pracownicy group by id_zesp) s using(id_zesp)
order by nazwisko;
--9--
update PRACOWNICY p 
set placa_pod = placa_pod + (select avg(placa_pod)*0.1 from pracownicy where p.id_zesp=id_zesp);
select nazwisko,placa_pod from pracownicy order by nazwisko;
--10--
select * from pracownicy where placa_pod = (select min(placa_pod) from pracownicy);
--11--
update PRACOWNICY p
set placa_pod = (select round(avg(placa_pod),2)from pracownicy)
where placa_pod = (select min(placa_pod) from pracownicy);
select * from pracownicy where id_prac = 200;
--12--
update PRACOWNICY p
set placa_dod = (select avg(placa_pod) from pracownicy where id_szefa = (select id_prac FROM pracownicy where nazwisko in ('MORZY')))
where id_zesp = 20;
select nazwisko, placa_dod from pracownicy where id_zesp = 20;
--13--
select nazwisko,placa_pod from pracownicy join  zespoly using(id_zesp) where zespoly.nazwa in ('SYSTEMY ROZPROSZONE') order by nazwisko;
update (select nazwisko,placa_pod from pracownicy join  zespoly using(id_zesp) where zespoly.nazwa in ('SYSTEMY ROZPROSZONE'))
set placa_pod = placa_pod* 1.25;
--14--
select p.nazwisko as pracownik, s.nazwisko as szef from pracownicy p join pracownicy s  on p.id_szefa = s.id_prac where s.nazwisko in ('MORZY');
delete from (select p.nazwisko as pracownik, s.nazwisko as szef from pracownicy p join pracownicy s  on p.id_szefa = s.id_prac where s.nazwisko in ('MORZY'));
--15--
select * from pracownicy order by nazwisko;
--16--
create sequence PRAC_SEQ start with 300 increment by 10;

--17--
insert into pracownicy(id_prac,nazwisko,etat,placa_pod)
values(PRAC_SEQ.nextVAL, 'Tr¹bczyñski', 'STAZYSTA', 1000);
select * from pracownicy where id_prac >= 300;

--18--
update pracownicy
set placa_dod = PRAC_SEQ.currval
where id_PRAC =300;
select * from pracownicy where id_prac >= 300;
--19--
delete from pracownicy
where nazwisko in('Tr¹bczyñski');
--20--
create sequence MALA_SEQ start with 1 increment by 5 MAXVALUE 10;
select MALA_SEQ.nextval FROM dual; -- SEKWENCJA PO PRZEKROCZENIU MAKSYMALNEJ WARTOŒCI NIE JEST W STANIE WYGENEROWAÆ KOLEJNEJ LICZBY
--21--
drop SEQUENCE MALA_SEQ;