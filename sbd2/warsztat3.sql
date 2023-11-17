--1--
DECLARE
 CURSOR cpracownicy IS
 SELECT nazwisko,zatrudniony
 FROM pracownicy
 where etat in('ASYSTENT');

 vPracownik cPracownicy%ROWTYPE;
 vNazwisko Pracownicy.nazwisko%type;
 vZatrudniony Pracownicy.Zatrudniony%type;
 BEGIN
 open cpracownicy;
 LOOP
FETCH cpracownicy INTO vNazwisko, vZatrudniony;
 EXIT WHEN cpracownicy%NOTFOUND;
 DBMS_OUTPUT.PUT_LINE(vNazwisko||' pracuje od '||
 vzatrudniony);
 END LOOP;
close cpracownicy;


 end;
 --2--
 DECLARE
 CURSOR cpracownicy IS
 SELECT *
 FROM pracownicy
 order by placa_pod desc;
 vPracownik cPracownicy%ROWTYPE;
 
BEGIN
  open cpracownicy;
 LOOP
 FETCH cpracownicy INTO vPracownik;
 EXIT WHEN cpracownicy%ROWCOUNT=4;
 DBMS_OUTPUT.PUT_LINE(cpracownicy%ROWCOUNT||' : '||
 vPracownik.nazwisko);
 END LOOP;
close cpracownicy;
END;
--3--
 
Declare
CURSOR cpracownicy(pDzienTygodnia varchar) IS
SELECT *
 FROM pracownicy
 where TO_CHAR(zatrudniony, 'D') = pDzienTygodnia
 order by nazwisko
 for update;
 
 BEGIN
 FOR vPracownik IN cPracownicy(1) LOOP
 
 UPDATE Pracownicy
 SET placa_pod = placa_pod * 1.2
 WHERE CURRENT OF cPracownicy;


 END LOOP;
END;
--4--
declare
CURSOR cpracownicy is
select * from pracownicy 
 for update;
 v_id_zesp_algorytmy ZESPOLY.id_zesp%type;
 v_id_zesp_administracja ZESPOLY.id_zesp%type;
 begin
  SELECT id_zesp INTO v_id_zesp_algorytmy FROM zespoly WHERE nazwa = 'ALGORYTMY';
   SELECT id_zesp INTO v_id_zesp_administracja FROM zespoly WHERE nazwa = 'ADMINISTRACJA';
   
 for vPracownik in cPracownicy loop
 if vPracownik.id_zesp = v_id_zesp_algorytmy then
 update pracownicy
 set placa_dod = coalesce(placa_dod,0)+100
 WHERE CURRENT OF cPracownicy;
 elsif vPracownik.id_zesp = v_id_zesp_administracja then
 update pracownicy
 set placa_dod = coalesce(placa_dod,0)+150
 WHERE CURRENT OF cPracownicy;
 ELSIF vPracownik.etat = 'STAZYSTA' THEN
 
 DELETE FROM Pracownicy
 WHERE CURRENT OF cPracownicy;

 end if;
 end loop;
 end;
 --5--
 create or replace procedure PokazPracownikowEtatu(pEtat in pracownicy.etat%type) is
 cursor cPracownicy(cEtat in pracownicy.etat%type) is
 SELECT * FROM pracownicy where etat in(cEtat);
 begin
 for vPracownik in cPracownicy(pEtat) loop
 DBMS_OUTPUT.PUT_LINE(vPracownik.nazwisko);
 end loop;
 end;
 begin
  PokazPracownikowEtatu('PROFESOR');

 end;
 --6--
  create or replace procedure  RaportKadrowy is
 cursor cEtat is
  SELECT * FROM etatY;
 cursor cPracownicy(cEtat in Etaty.nazwa%type) is
 SELECT * FROM pracownicy where etat in(cEtat);
 ilewetacie number;
 srednia number;
 begin
 for vEtat in cEtat loop
    DBMS_OUTPUT.PUT_LINE('Etat: '|| vEtat.nazwa);
    DBMS_OUTPUT.PUT_LINE('------------------------------');
    for vPracownik in cPracownicy(vEtat.nazwa) loop
    DBMS_OUTPUT.PUT_LINE(cpracownicy%ROWCOUNT||'. '||
 vPracownik.nazwisko||', pensja: '||vPracownik.placa_pod);
    end loop;
    SELECT count(*) INTO ilewetacie FROM pracownicy WHERE etat = vEtat.nazwa;
    SELECT avg(placa_pod) INTO srednia FROM pracownicy WHERE etat = vEtat.nazwa;
    DBMS_OUTPUT.PUT_LINE('Liczba pracowników: '|| ilewetacie);
    DBMS_OUTPUT.PUT_LINE('Œrednia pensja: '|| srednia);
     DBMS_OUTPUT.PUT_LINE('');
end loop;
 end;

begin
RaportKadrowy();
end;

--7--
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
  
  IF SQL%FOUND THEN
 DBMS_OUTPUT.PUT_LINE ('Dodano rekord');
 ELSE
 DBMS_OUTPUT.PUT_LINE ('Nie wstawiono ¿adnego rekordu!');
 END IF;
  end;

   procedure UsunZespolPoId(pid_zespol number)is
   begin
   delete from zespoly where id_zesp=pid_zespol;
   IF SQL%FOUND THEN
 DBMS_OUTPUT.PUT_LINE ('Usuniêto rekord');
 ELSE
 DBMS_OUTPUT.PUT_LINE ('Nie usuniêto ¿adnego rekordu!');
 END IF;
   end;

   procedure UsunZespolPoNazwie(pnazwa varchar2) is
   begin
   delete from zespoly where nazwa=pnazwa;
   IF SQL%FOUND THEN
 DBMS_OUTPUT.PUT_LINE ('Usuniêto rekord');
 ELSE
 DBMS_OUTPUT.PUT_LINE ('Nie usuniêto ¿adnego rekordu!');
 end if;
   end;
   

   procedure ModyfikujZespol(pid_zespol number, pnowa_nazwa varchar2, pnowy_adres varchar2)is
   begin
    update zespoly
    set nazwa = pnowa_nazwa,
        adres = pnowy_adres
    where id_zesp=pid_zespol;
    
    IF SQL%FOUND THEN
 DBMS_OUTPUT.PUT_LINE ('Zmodyfikowano rekord');
 ELSE
 DBMS_OUTPUT.PUT_LINE ('Nie zmodyfikowano ¿adnego rekordu!');
 end if;
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
IntZespoly.modyfikujzespol(50,'dwa','dwad');
end;

--8--
create or replace package IntZespoly AS
 
  procedure DodajZespol(pid_zespol number,pnazwa varchar2, padres varchar2);
   procedure UsunZespolPoId(pid_zespol number);
   procedure UsunZespolPoNazwie(pnazwa varchar2);
   procedure ModyfikujZespol(pid_zespol number, pnowa_nazwa varchar2, pnowy_adres varchar2);
   function PobierzIdZespoluPoNazwie(pnazwa varchar2) return NUMBER;
   function PobierzNazweZespoluPoId(pid_zespol number) return varchar2;
   function PobierzAdresZespoluPoId(pid_zespol number) return varchar2;
   exNiepoprawneid exception;
   exNiepoprawnanazwa exception;
   exPowielenieid exception;

END IntZespoly;


create or replace package body IntZespoly AS
  vId_Zesp number;
  vAdres varchar2(20);
  vNazwa varchar2(20);
  procedure DodajZespol(pid_zespol number,pnazwa varchar2, padres varchar2)is
  begin
  insert into zespoly values(pid_zespol,pnazwa,padres);
  EXCEPTION
 WHEN DUP_VAL_ON_INDEX  THEN
 RAISE exPowielenieid;
  IF SQL%FOUND THEN
 DBMS_OUTPUT.PUT_LINE ('Dodano rekord');
 ELSE
 DBMS_OUTPUT.PUT_LINE ('Nie wstawiono ¿adnego rekordu!');
 END IF;
  end;

   procedure UsunZespolPoId(pid_zespol number)is
   begin
   SELECT id_zesp INTO vid_zesp FROM Zespoly
 WHERE id_zesp = pid_zespol;
   delete from zespoly where id_zesp=pid_zespol;
    EXCEPTION
 WHEN NO_DATA_FOUND THEN
 RAISE exNiepoprawneid;
   
   IF SQL%FOUND THEN
 DBMS_OUTPUT.PUT_LINE ('Usuniêto rekord');
 ELSE
 DBMS_OUTPUT.PUT_LINE ('Nie usuniêto ¿adnego rekordu!');
 END IF;
   end;

   procedure UsunZespolPoNazwie(pnazwa varchar2) is
   begin
   SELECT nazwa INTO vNazwa FROM Zespoly
 WHERE nazwa = pnazwa;
   delete from zespoly where nazwa=pnazwa;
   EXCEPTION
 WHEN NO_DATA_FOUND THEN
 RAISE exNiepoprawnanazwa;
   IF SQL%FOUND THEN
 DBMS_OUTPUT.PUT_LINE ('Usuniêto rekord');
 ELSE
 DBMS_OUTPUT.PUT_LINE ('Nie usuniêto ¿adnego rekordu!');
 end if;
   end;
   

   procedure ModyfikujZespol(pid_zespol number, pnowa_nazwa varchar2, pnowy_adres varchar2)is
   begin
   SELECT id_zesp INTO vid_zesp FROM Zespoly
 WHERE id_zesp = pid_zespol;

    update zespoly
    set nazwa = pnowa_nazwa,
        adres = pnowy_adres
    where id_zesp=pid_zespol;
    EXCEPTION
 WHEN NO_DATA_FOUND THEN
 RAISE exNiepoprawneid;
    
    IF SQL%FOUND THEN
 DBMS_OUTPUT.PUT_LINE ('Zmodyfikowano rekord');
 ELSE
 DBMS_OUTPUT.PUT_LINE ('Nie zmodyfikowano ¿adnego rekordu!');
 end if;
    end;

   function PobierzIdZespoluPoNazwie(pnazwa varchar2) return number is
   begin
   select id_zesp into vId_zesp from zespoly where nazwa = pnazwa;
   return vId_zesp;
   EXCEPTION
 WHEN NO_DATA_FOUND THEN
 RAISE exNiepoprawnanazwa;

   
   end;
    

   function PobierzNazweZespoluPoId(pid_zespol number) return varchar2 is
   begin
   select nazwa into vNazwa from zespoly where id_zesp = pid_zespol;
   return vNazwa;
   EXCEPTION
 WHEN NO_DATA_FOUND THEN
 RAISE exNiepoprawneid;

   
   end;

   function PobierzAdresZespoluPoId(pid_zespol number) return varchar2 is
   begin
   select adres into vAdres from zespoly where id_zesp = pid_zespol;
   return vAdres;
   EXCEPTION
 WHEN NO_DATA_FOUND THEN
 RAISE exNiepoprawneid;

  
   end;
end Intzespoly;

BEGIN
 IntZespoly.UsunZespolPoId('51');
 EXCEPTION
 WHEN Intzespoly.exPowielenieid THEN
 DBMS_OUTPUT.PUT_LINE('Podano id zespo³u istniejacego');

 WHEN Intzespoly.exNiepoprawneid THEN
 DBMS_OUTPUT.PUT_LINE('Podano id nieistniej¹cego zespo³u!');

 WHEN Intzespoly.exNiepoprawnanazwa THEN
 DBMS_OUTPUT.PUT_LINE('Podano nazwê nieistniej¹cego zespo³u!');
 

end;