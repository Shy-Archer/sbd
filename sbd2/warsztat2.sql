
        --1--
CREATE SEQUENCE customers_seq START WITH  300 INCREMENT BY  10;
drop sequence customers_seq;
CREATE or replace PROCEDURE NowyPracownik(pNazwisko in varchar,pZespol in Varchar,pSzef in Varchar,pPlaca_pod in Number) IS
Begin
  
    Insert into pracownicy(id_prac,nazwisko,id_zesp,id_szefa,placa_pod,zatrudniony,etat)
    values(customers_seq.nextval,pNazwisko,(select id_zesp from zespoly where nazwa=pZespol),(select id_prac from pracownicy where nazwisko =pSzef),pPlaca_pod,SYSDATE,'STAZYSTA');
end NowyPracownik;
EXECUTE NowyPracownik('Dyndalski','ALGORYTMY','BLAZEWICZ',250);



    --2--
create or replace function PlacaNetto
(fPlaca_pod in pracownicy.placa_pod%type, fpodatek in number default 20)
return natural is
vPlaca_netto Natural;
BEGIN
vPlaca_netto:=fplaca_pod- fplaca_pod*fpodatek/100; 
return vPlaca_netto;
END;
SELECT nazwisko, placa_pod AS BRUTTO,
PlacaNetto(placa_pod, 35) AS NETTO
FROM Pracownicy WHERE etat = 'PROFESOR' ORDER BY nazwisko;


--3--
create or replace function silnia
(fN in number)
return natural is
vSilnia natural;
begin
    vSilnia := 1;
    if fN>0 then
    for vIndeks in 1..fN loop
        vSilnia:= vSilnia* vIndeks;
    END LOOP;
    return vSilnia;
    else
    return vSilnia;
     end if;
     
    
end;
select silnia(8) from dual;
--4--
create or replace function silniarek
(fN in number)
return natural is
vSilnia natural;
begin
    if fN =0 then
    vSilnia := 1;
    else
    vSilnia :=  fN*silniarek(fN-1);
    end if;
    return vSilnia;
        
end;
select silniarek(10) from dual;
--5--
create or replace function ilelat
(fzatrudniony in date)
return number is
vLata number;
begin
vLata:=extract(year from (sysdate-fzatrudniony) year to month);
return vLata;
end;
 SELECT nazwisko, zatrudniony, IleLat(zatrudniony) AS staz
 FROM Pracownicy WHERE placa_pod > 1000
 ORDER BY nazwisko;

--6--
create or replace package konwersja is
    function Cels_To_Fahr(temp in natural)
     return natural;
    function Fahr_To_Cels(temp in natural)
     return natural;
end konwersja;
create or replace package body konwersja is
    function Cels_To_Fahr(temp in natural)
     return natural is
     vTemp natural;
     begin
     vTemp := 9/5*temp+32;
     return vTemp;
     end;
     
     function Fahr_To_Cels(temp in natural)
     return natural is
     vTemp natural;
     begin
     vTemp := 5/9*(temp-32);
     return vTemp;
     end;
end konwersja;
     
     
SELECT Konwersja.Fahr_To_Cels(212) AS CELSJUSZ FROM Dual;    
SELECT Konwersja.Cels_To_Fahr(0) AS FAHRENHEIT FROM Dual;
--7--
create or replace package Zmienne is
    vLicznik natural :=0;
    procedure ZwiekszLicznik;
    procedure ZmniejszLicznik;
    function PokazLicznik return natural;
end zmienne;

create or replace package body Zmienne is
    
    
    procedure ZwiekszLicznik is
    begin
    vLicznik:= vLicznik+1;
     DBMS_OUTPUT.PUT_LINE('Zwiêkszono');
    end;
    procedure ZmniejszLicznik is
    begin
    vLicznik:= vLicznik-1;
     DBMS_OUTPUT.PUT_LINE('Zmniejszono');
    end;
    function PokazLicznik return natural is
  begin
    return vLicznik;
  end;
  Begin
    vLicznik:= 1;
    DBMS_OUTPUT.PUT_LINE('Zainicjalizowano');
       
end;

BEGIN
 DBMS_OUTPUT.PUT_LINE (Zmienne.PokazLicznik);
 Zmienne.ZmniejszLicznik;
 DBMS_OUTPUT.PUT_LINE (Zmienne.PokazLicznik);
 END;

BEGIN
 DBMS_OUTPUT.PUT_LINE (Zmienne.PokazLicznik);
 END;
 BEGIN
 Zmienne.ZwiekszLicznik;
 DBMS_OUTPUT.PUT_LINE(Zmienne.PokazLicznik);
 Zmienne.ZwiekszLicznik;
 DBMS_OUTPUT.PUT_LINE (Zmienne.PokazLicznik);
 END;

 --8--
 create or replace package IntZespoly AS
 
  procedure DodajZespol(pnazwa varchar2, padres varchar2);
   procedure UsunZespolPoId(pid_zespol number);
   procedure UsunZespolPoNazwie(pnazwa varchar2);
   procedure ModyfikujZespol(pid_zespol number, pnowa_nazwa varchar2, pnowy_adres varchar2);
   function PobierzIdZespoluPoNazwie(pnazwa varchar2) return NUMBER;
   function PobierzNazweZespoluPoId(pid_zespol number) return varchar2;
   function PobierzAdresZespoluPoId(pid_zespol number) return varchar2;
END IntZespoly;

create or replace package body IntZespoly AS
  vId_Zesp number;
  vAdres varchar2(20);
  vNazwa varchar2(20);
  procedure DodajZespol(pnazwa varchar2, padres varchar2)is
  begin
  insert into zespoly values((select max(id_zesp)+1 from zespoly),pnazwa,padres);
  end;

   procedure UsunZespolPoId(pid_zespol number)is
   begin
   delete from zespoly where id_zesp=pid_zespol;
   end;

   procedure UsunZespolPoNazwie(pnazwa varchar2) is
   begin
   delete from zespoly where nazwa=pnazwa;
   end;
   

   procedure ModyfikujZespol(pid_zespol number, pnowa_nazwa varchar2, pnowy_adres varchar2)is
   begin
    update zespoly
    set nazwa = pnowa_nazwa,
        adres = pnowy_adres
    where id_zesp=pid_zespol;
    end;

   function PobierzIdZespoluPoNazwie(pnazwa varchar2) return number is
   begin
   select id_zesp into vId_zesp from zespoly where nazwa = pnazwa;
   return vId_zesp;
   end;
    

   function PobierzNazweZespoluPoId(pid_zespol number) return varchar2 is
   begin
   select nazwa into vNazwa from zespoly where id_zesp = pid_zespol;
   return vNazwa;
   end;

   function PobierzAdresZespoluPoId(pid_zespol number) return varchar2 is
   begin
   select adres into vAdres from zespoly where id_zesp = pid_zespol;
   return vAdres;
   end;
   
   
END IntZespoly;
begin

DBMS_OUTPUT.PUT_LINE(IntZespoly.PobierzNazweZespoluPoId(50));
end;

--9--
SELECT text
FROM User_Source
where type = 'PROCEDURE'
ORDER BY line;

SELECT text
FROM User_Source
where type = 'FUNCTION'
ORDER BY line;

SELECT text
FROM User_Source
where type = 'PACKAGE'
ORDER BY line;

SELECT text
FROM User_Source
where type = 'PACKAGE BODY'
ORDER BY line;

SELECT object_name, status,object_type
FROM User_Objects
WHERE object_type in ('PROCEDURE','FUNCTION','PACKAGE','PACKAGE BODY')
ORDER BY object_name;

SELECT p.procedure_name AS podprogram, o.object_name AS pakiet ,o.status
FROM User_Procedures p join user_objects o on p.object_name=o.object_name
WHERE p.object_type = 'PACKAGE'
AND procedure_name IS NOT NULL
ORDER BY pakiet, podprogram;
--10--
drop function Silnia;
drop function Silniarek;
drop function IleLat;
--11--
drop package body konwersja;
drop package konwersja;
