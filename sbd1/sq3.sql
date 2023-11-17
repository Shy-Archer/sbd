                --zad1--
select min(placa_pod) as minimum, max(placa_pod) as maximum, max(placa_pod)-min(placa_pod) as ró¿nica from pracownicy;
                --zad2--
select etat,avg(placa_pod) as srednia from pracownicy group by etat order by avg(placa_pod) desc;

--zad3--

select count(etat) as profesorowie from pracownicy where etat in('PROFESOR');

--ZAD4--
select id_zesp, sum(placa_pod+coalesce(placa_dod,0)) as sumaryczne_place from pracownicy group by id_zesp order by id_zesp;
--zad5--
select  max(sum(placa_pod+coalesce(placa_dod,0))) as max_sum_placa from pracownicy group by id_zesp;
--zad6--
select id_szefa as id_szefa, min(placa_pod) from pracownicy where id_szefa is not null group by id_szefa order by min(placa_pod) desc;
--zad7--
select id_zesp, count(*) as ilu_pracuje from pracownicy group by id_zesp order by count(*) desc;
--zad8--
select id_zesp, count(*) as ilu_pracuje from pracownicy group by id_zesp having count(*)>3 order by count(*) desc;
--zad10--
select etat, avg(placa_pod) as srednia, count(*) as liczba from pracownicy where zatrudniony < date '1990-01-01' group by etat order by etat;
--zad11--
select id_zesp, etat, round(avg(placa_pod+coalesce(placa_dod,0))) as srednia, 
round(max(placa_pod+coalesce(placa_dod,0))) as maksymalna
from pracownicy 
where etat in('ASYSTENT','PROFESOR') group by etat,id_zesp order by id_zesp,etat;
--zad12--
select extract(year from zatrudniony) as rok, count(*) as ilu_pracownikow from pracownicy group by extract(year from zatrudniony) order by extract(year from zatrudniony);
--zad13--
select length(nazwisko) as ile_liter, count(*) as w_ilu_nazwiskach from pracownicy group by length(nazwisko) order by length(nazwisko);
--zad14--
select sum(case when nazwisko like '%A%'  then 1 else 0 END) as ile_nazwisk_z_A from pracownicy;
--zad15--
select sum(case when nazwisko like '%A%'  then 1 else 0 END) as ile_nazwisk_z_A, sum(case when nazwisko like '%E%' then 1 else 0 END) as ile_nazwisk_z_E from pracownicy;
--zad16--
