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