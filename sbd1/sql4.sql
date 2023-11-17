
select nazwisko, etat, id_zesp,nazwa from pracownicy natural join zespoly order by pracownicy.nazwisko;

select nazwisko, etat, id_zesp,nazwa from pracownicy natural join zespoly WHERE adres = 'PIOTROWO 3A' order by pracownicy.nazwisko;

select nazwisko, etat, placa_pod,placa_min,placa_max from pracownicy join etaty on etat = nazwa order by etat, nazwisko;

select nazwisko, etat, placa_pod,placa_min,placa_max,
case 
when placa_pod <= placa_max and placa_pod >=placa_min then 'OK'
else 'NIE'
end as czy_pensja_ok
from pracownicy join etaty on etat = nazwa order by etat, nazwisko;

select nazwisko, etat, placa_pod,placa_min,placa_max
from pracownicy join etaty on etat = nazwa
where  placa_pod >= placa_max and placa_pod <=placa_min
order by etat, nazwisko;

select nazwisko, placa_pod, etat, nazwa as kat_plac, placa_min, placa_max from pracownicy join etaty on placa_pod >= placa_min and placa_pod <= placa_max
order by nazwisko, kat_plac;
select nazwisko, placa_pod, etat, nazwa as kat_plac, placa_min, placa_max from pracownicy join etaty on placa_pod >= placa_min and placa_pod <= placa_max
where nazwa = 'SEKRETARKA'
order by nazwisko, kat_plac;

select p.nazwisko as pracownik,p.id_prac, s.nazwisko as szef, p.id_szefa as id_szefa from pracownicy p join pracownicy s on p.id_szefa = s.id_prac
where p.id_szefa is not null
order by p.nazwisko;

select p.nazwisko as pracownik, p.zatrudniony as prac_zatrudniony, s.nazwisko as szef, s.zatrudniony as szef_zatrudniony, extract(year from p.zatrudniony)- extract(year from s.zatrudniony) as lata
from pracownicy p join pracownicy s on p.id_szefa = s.id_prac
where extract(year from p.zatrudniony)- extract(year from s.zatrudniony) < 10
order by p.zatrudniony, p.nazwisko;
