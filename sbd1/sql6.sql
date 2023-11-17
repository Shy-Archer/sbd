--zad1--
select id_zesp, nazwa, adres from zespoly z where not exists(select * from pracownicy where id_zesp = z.id_zesp);
--zad2--
select nazwisko, placa_pod, etat from pracownicy p where placa_pod > (select avg(placa_pod) from pracownicy where etat = p.etat) order by placa_pod desc;
--zad3--
select nazwisko, placa_pod from pracownicy p where placa_pod > 0.75*(select placa_pod from pracownicy where p.id_szefa = id_prac); 
--zad4--
select nazwisko from pracownicy p where  not exists(select * from pracownicy where id_szefa = p.id_prac and etat in('STAZYSTA')) and etat in('PROFESOR');
--zad5--
select nazwa, max from (select max(sum(placa_pod)) as max from pracownicy  group by id_zesp) p join (select id_zesp, sum(placa_pod) as suma from pracownicy group by id_zesp) s on p.max = s.suma join zespoly on s.id_zesp = zespoly.id_zesp; 
--zad6--
select nazwisko,placa_pod from pracownicy p where (select count(*) from pracownicy where  p.placa_pod < placa_pod) < 3 order by placa_pod desc;
--zad7--
select extract (year from zatrudniony) as rok, max(count(extract (year from zatrudniony))) as liczba from pracownicy group by extract (year from zatrudniony) order by liczba desc;
--zad8--
select extract (year from zatrudniony) as rok, count(*) as liczba
from pracownicy
group by extract (year from zatrudniony)
having count(*) = (select max(liczba) from (select  count(*) as liczba from pracownicy group by extract (year from zatrudniony) ));
--zad9--
select nazwisko, placa_pod, placa_pod-(select avg(placa_pod) from pracownicy where id_zesp = p.id_zesp) from pracownicy p order by nazwisko;

