--zad1--
SELECT nazwisko, pracownicy.id_zesp, nazwa
from pracownicy left join zespoly
on pracownicy.id_zesp = zespoly.id_zesp
order by nazwisko;
--zad2--
SELECT nazwa, zespoly.id_zesp, coalesce(nazwisko,'brak pracownikow') as pracownik
from zespoly left join pracownicy
on pracownicy.id_zesp = zespoly.id_zesp
order by nazwa, nazwisko;
--zad3--
SELECT coalesce(nazwa,'brak zespo³u') as zespoly, coalesce(nazwisko,'brak pracowników') as pracownik
from zespoly full join pracownicy
on pracownicy.id_zesp = zespoly.id_zesp
order by nazwa, nazwisko;
--ZAD4--
select zespoly.nazwa as zespol, count(pracownicy.id_zesp), sum(pracownicy.placa_pod) from zespoly left join pracownicy  on pracownicy.id_zesp = zespoly.id_zesp group by zespoly.nazwa;

--zad5--
select zespoly.nazwa as zespol from zespoly left join pracownicy  on pracownicy.id_zesp = zespoly.id_zesp group by zespoly.nazwa having count(pracownicy.id_zesp)=0;
--zad6--
select p.nazwisko as pracownik,p.id_prac, s.nazwisko as szef, p.id_szefa as id_szefa from pracownicy p left join pracownicy s on p.id_szefa = s.id_prac
order by p.nazwisko;
--zad7--
select s.nazwisko as pracownik, count(p.id_zesp) from pracownicy p right join pracownicy s on p.id_szefa = s.id_prac group by s.nazwisko order by s.nazwisko;
--zad8--
select p.nazwisko, p.etat, p.placa_pod, nazwa, s.nazwisko as szef
from pracownicy p left join pracownicy s on p.id_szefa = s.id_prac left join zespoly z on p.id_zesp =  z.id_zesp order by p.nazwisko;
--zad9--
select nazwisko, nazwa from pracownicy cross join zespoly order by nazwisko;
--zad10--
select count(*) from etaty cross join pracownicy cross join zespoly;
--zad11--
select etat from pracownicy where extract(year from zatrudniony) = 1992 intersect
select etat from pracownicy where extract(year from zatrudniony) = 1993 order by etat;
--zad12--
select id_zesp from zespoly
minus
select id_zesp from pracownicy group by id_zesp having count(id_zesp) > 0;
--zad13--
select id_zesp, nazwa from zespoly
minus
select pracownicy.id_zesp, zespoly.nazwa from pracownicy join zespoly on pracownicy.id_zesp = zespoly.id_zesp
group by pracownicy.id_zesp,zespoly.nazwa having count(pracownicy.id_zesp) > 0;
--zad14--
select nazwisko, placa_pod, 'Poni¿ej 480 z³otych' as prog from pracownicy where placa_pod < 480
union
select nazwisko, placa_pod, 'Dok³adnie 480 z³otych' as prog from pracownicy where placa_pod = 480
union
select nazwisko, placa_pod, 'Powy¿ej 480 z³otych' as prog from pracownicy where placa_pod > 480
order by placa_pod;
