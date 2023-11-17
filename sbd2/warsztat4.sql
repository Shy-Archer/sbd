--1--
CREATE TABLE DziennikOperacji (
  id NUMBER GENERATED ALWAYS AS IDENTITY,
  data_realizacji date not null,
  typ_operacji VARCHAR2(10) not null,
  nazwa_tabeli VARCHAR2(30) not null,
  liczba_rekordow NUMBER not null
);
Drop table dziennikoperacji;
create or replace trigger LogujOperacje
AFTER INSERT OR DELETE OR UPDATE ON zespoly
declare
vOperacja VARCHAR(50);
begin
CASE
 WHEN INSERTING THEN
 vOperacja := 'Insert';
 WHEN DELETING THEN
 vOperacja := 'Delete';
 WHEN UPDATING THEN
 vOperacja := 'Update';
end case;
Insert into dziennikoperacji(data_realizacji,typ_operacji,nazwa_tabeli,liczba_rekordow)
values(current_date,vOperacja,'Zespoly',(select count(*) from zespoly));
end;
begin
IntZespoly.usunzespolpoid(51);
end;
--2--
CREATE OR REPLACE TRIGGER PokazPlace
 BEFORE UPDATE OF placa_pod ON Pracownicy
 FOR EACH ROW
 WHEN (COALESCE(OLD.placa_pod,0) <> COALESCE(NEW.placa_pod,0))
BEGIN
 DBMS_OUTPUT.PUT_LINE('Pracownik ' || :OLD.nazwisko);
 DBMS_OUTPUT.PUT_LINE('P³aca przed modyfikacj¹: ' || :OLD.placa_pod);
 DBMS_OUTPUT.PUT_LINE('P³aca po modyfikacji: ' || :NEW.placa_pod);
END;

update  pracownicy
set placa_pod=1350
WHERE ID_ZESP=40;
--3--
CREATE TRIGGER WymuszajPlace
 BEFORE INSERT ON Pracownicy
 FOR EACH ROW
DECLARE
 vPlacaMin Etaty.placa_min%TYPE;
 
BEGIN
if :NEW.etat is not null then
 SELECT placa_min
 INTO vPlacaMin
 FROM Etaty WHERE nazwa = :NEW.etat;
 
 if :NEW.placa_dod is null or :NEW.placa_pod is null then 
 :NEW.placa_dod:=0;
 :NEW.placa_pod:=vPlacaMin;
 END IF;
elsif :NEW.placa_dod is null then
:NEW.placa_dod:=0;
end if;
END;
insert into pracownicy(id_prac,nazwisko,id_szefa,zatrudniony,id_zesp)
values(360,'ok',130,current_date,20);


--4--
CREATE OR REPLACE TRIGGER UzupelnijID
 BEFORE insert ON zespoly
 FOR EACH ROW
declare
vid_zesp zespoly.id_zesp%type;
BEGIN
 SELECT seq_zespoly.nextval into vid_zesp FROM DUAL;
 :new.id_zesp := vid_zesp;
END;
INSERT INTO Zespoly(nazwa, adres) VALUES('NOWY', 'brak');
--5--
create or replace view szefowie(szef,pracownicy) as select s.nazwisko,count(*) from pracownicy p join pracownicy s on p.id_szefa = s.id_prac group by s.nazwisko;
CREATE OR REPLACE TRIGGER UsunSzefa
INSTEAD OF DELETE ON Szefowie
DECLARE
      l_count NUMBER;
BEGIN
  FOR employee IN (SELECT * FROM Pracownicy WHERE id_szefa=(select id_prac from pracownicy WHERE NAZWISKO = :OLD.szef)) LOOP
    -- SprawdŸ, czy podw³adny jest szefem innych pracowników
      SELECT COUNT(*) INTO l_count FROM Pracownicy WHERE ID_SZEFA = employee.ID_PRAC and (not NAZWISKO = :OLD.szef);

      IF l_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Jeden z podw³adnych usuwanego pracownika jest szefem innych pracowników. Usuwanie anulowane!');
      END IF;
      -- Usuñ podw³adnego
    DELETE FROM Pracownicy WHERE ID_PRAC = employee.ID_PRAC;
  END LOOP;

  -- Usuñ szefa
  DELETE FROM Pracownicy WHERE NAZWISKO = :OLD.szef;
END;
 DELETE FROM szefowie WHERE szef='WEGLARZ';
 --6--
 ALTER table zespoly 
 add liczba_pracownikow number;
 update zespoly z
 set liczba_pracownikow=(select count(*) from pracownicy p where p.id_zesp= z.id_zesp);
 CREATE OR REPLACE TRIGGER PoZmianieZespolow
 AFTER INSERT OR DELETE OR UPDATE ON Pracownicy
 FOR EACH ROW
 BEGIN
 CASE
 WHEN INSERTING THEN
 update zespoly
 set liczba_pracownikow = liczba_pracownikow+1
 where zespoly.id_zesp = :new.id_zesp;
 WHEN DELETING THEN
  update zespoly
  set liczba_pracownikow = liczba_pracownikow-1
 where zespoly.id_zesp = :old.id_zesp;
 WHEN UPDATING THEN
 update zespoly
  set liczba_pracownikow = liczba_pracownikow-1
 where zespoly.id_zesp = :old.id_zesp;
 update zespoly
 set liczba_pracownikow = liczba_pracownikow+1
 where zespoly.id_zesp = :new.id_zesp;

end case;
 END;
UPDATE Pracownicy SET id_zesp = 10 WHERE id_zesp = 30;
delete from pracownicy where id_prac=300;
 SELECT * FROM Zespoly;
 
 --7--

ALTER TABLE PRACOWNICY add constraint FK_ID_SZEFA foreign key(id_szefa) references pracownicy (id_prac) on delete cascade;
--MATYSIAK ZAKRZEWICZ MORZY
create OR REPLACE trigger Usun_Prac
after delete on pracownicy
for each row
begin
DBMS_OUTPUT.PUT_LINE(:old.nazwisko);
end;
delete from pracownicy
where nazwisko = 'MORZY';
create OR REPLACE trigger Usun_Prac --MORZY MATYSIAK ZAKRZEWICZ INNA KOLEJNOSC
BEFORE delete on pracownicy
for each row
begin
DBMS_OUTPUT.PUT_LINE(:old.nazwisko);
end;
--8--
ALTER TABLE PRACOWNICY DISABLE ALL TRIGGERS;
 SELECT trigger_name, trigger_type, triggering_event, table_name,status
 when_clause
 FROM User_Triggers
 WHERE table_name IN ('PRACOWNICY')
 ORDER BY table_name, trigger_name;
 update  pracownicy
set placa_pod=1300
WHERE ID_ZESP=40; 
insert into pracownicy(id_prac,nazwisko,ETAT,id_szefa,zatrudniony,id_zesp)
values(360,'ok','STAZYSTA',130,current_date,20);
delete from pracownicy
where nazwisko = 'MORZY';
UPDATE Pracownicy SET id_zesp = 10 WHERE id_zesp = 30;
 SELECT * FROM Zespoly;
 --9--
  SELECT trigger_name, trigger_type, triggering_event, table_name,status
 when_clause
 FROM User_Triggers
 WHERE table_name IN ('PRACOWNICY','ZESPOLY')
 ORDER BY table_name, trigger_name;
 DROP trigger POKAZPLACE;
  DROP trigger POZMIANIEZESPOLOW;
   DROP trigger USUN_PRAC;
    DROP trigger WYMUSZAJPLACE;
     DROP trigger LOGUJOPERACJE;
      DROP trigger UZUPELNIJID;

