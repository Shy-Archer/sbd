--zad1--
select nazwisko, etat, id_zesp from pracownicy where id_zesp = (select id_zesp from pracownicy where nazwisko = 'BRZEZINSKI') order by nazwisko;
--zad2--
select nazwisko,etat, zespoly.nazwa from pracownicy join zespoly on pracownicy.id_zesp = zespoly.id_zesp
where pracownicy.id_zesp = (select id_zesp from pracownicy where nazwisko = 'BRZEZINSKI');
--zad3--
select nazwisko,etat, zatrudniony from pracownicy where etat = 'PROFESOR' and zatrudniony = (select min(zatrudniony) from pracownicy where etat = 'PROFESOR');

--zad4--
select nazwisko,zatrudniony,id_zesp from pracownicy where (zatrudniony,id_zesp)  in (select max(zatrudniony),id_zesp from pracownicy group by id_zesp) order by zatrudniony;
--zad5--
select zespoly.id_zesp, nazwa, adres from zespoly left join pracownicy on pracownicy.id_zesp = zespoly.id_zesp where nazwisko is null;
--zad6--
SELECT nazwisko from pracownicy where etat = 'PROFESOR' and id_prac < all(select id_szefa from pracownicy where etat in('STAZYSTA')) order by nazwisko;
--zad7--
select id_zesp, sum(placa_pod) as suma_plac from pracownicy group by id_zesp having sum(placa_pod) = (select max(sum(placa_pod)) from pracownicy group by id_zesp);
--zad8--
select nazwa, sum(placa_pod) as suma_plac from pracownicy join zespoly using(id_zesp) group by nazwa having sum(placa_pod) = (select max(sum(placa_pod)) from pracownicy group by id_zesp);
--zad9--
select nazwa, count(pracownicy.id_zesp) as ilu_pracownikow from pracownicy 
join zespoly on zespoly.id_zesp = pracownicy.id_zesp group by nazwa
having count(pracownicy.id_zesp) > (select count(pracownicy.id_zesp) from pracownicy  join zespoly on zespoly.id_zesp = pracownicy.id_zesp 
where nazwa in('ADMINISTRACJA')) order by nazwa;
--zad10--
select etat from pracownicy group by etat having count(*) = (select max(count(*)) from pracownicy group by etat);
--zad11--
select etat, listagg(nazwisko,',') within group(order by nazwisko) as pracownicy from pracownicy group by etat having count(*) = (select max(count(*)) from pracownicy group by etat);
--zad12--
select p.nazwisko, s.nazwisko from pracownicy p join pracownicy s on p.id_szefa = s.id_prac 
where s.placa_pod - p.placa_pod = (select min( s.placa_pod - p.placa_pod) from pracownicy p  join pracownicy s on p.id_szefa = s.id_prac);