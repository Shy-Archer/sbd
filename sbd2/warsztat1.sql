    --1--
DECLARE
vTekst VARCHAR(100) := 'Witaj œwiecie!';
vLiczba NUMBER := 1000.456;
begin
dbms_output.put_line('Zmienna vTekst: ' || vTekst);
dbms_output.put_line('Zmienna vLiczba: ' || vLiczba);

end;


    --2--
DECLARE
vTekst VARCHAR(100) := 'Witaj œwiecie!';
vLiczba NUMBER := 1000.456;
begin
vTekst := vTekst || ' Witaj nowy dniu!';
vLiczba:= vLiczba + power(10,15);
dbms_output.put_line('Zmienna vTekst: ' || vTekst);
dbms_output.put_line('Zmienna vLiczba: ' || vLiczba);

end;

    --3--
Declare
vliczba1 Number := 10.2356000;
vliczba2 Number := 0.0000001;
vWynik Number;
Begin
vWynik:= vliczba1+vliczba2;
dbms_output.put_line('Wynik dodawania ' || vliczba1 || ' i ' || vliczba2 || ' : ' || vWynik );
end;


    --4--
declare 
    cPI CONSTANT NUMBER := 3.14;
    radius number := 5;
 
BEGIN

 dbms_output.put_line('Obwód ko³a o promieniu równym ' || radius || ': ' || 2*cpi*radius);
 dbms_output.put_line('Pole ko³a o promieniu równym '|| radius ||': ' || cPI*power(radius,2));
END;


     --5--
Declare
 vNazwisko PRACOWNICY.NAZWISKO%TYPE;
 vEtat pracownicy.etat%type;
 Begin
 select nazwisko,etat into vNazwisko,vEtat from pracownicy where placa_pod = (select max(placa_pod) from pracownicy);
 dbms_output.put_line('Najlepiej zarabia pracownik '|| vNazwisko);
 dbms_output.put_line('Pracuje on jako '|| vEtat);
 End;
 
 
        --6--
Declare
type tdane is record(
Nazwisko PRACOWNICY.NAZWISKO%TYPE,
Etat pracownicy.etat%type);
vPracownik tdane;
BEGIN
select nazwisko, etat into vPracownik
from pracownicy where placa_pod = (select max(placa_pod) from pracownicy);
 dbms_output.put_line('Najlepiej zarabia pracownik '|| vPracownik.nazwisko);
 dbms_output.put_line('Pracuje on jako '|| vpracownik.etat);

end;
    --7--
declare 
subtype tkwota  is number;
tpieniadze tkwota;
vNazwisko pracownicy.nazwisko%type;
begin
select nazwisko,12*placa_pod into vnazwisko,tpieniadze from pracownicy where nazwisko in('SLOWINSKI');
dbms_output.put_line('Pracownik ' || vnazwisko ||' zarabia rocznie ' || tpieniadze);
end;

  --8--
DECLARE
   current_second NUMBER;
BEGIN
   LOOP
      SELECT to_number(to_char(SYSDATE,'SS')) into current_second FROM dual;
      

      IF current_second = 25 THEN
         DBMS_OUTPUT.PUT_LINE('Nadesz³a 25 sekunda!');
         EXIT; 
      END IF;
      
  
    
   END LOOP;
END;

     --9--
DECLARE
 vN Number := 10;
 vLiczba number := 1;
 vWynik number := 1;
BEGIN
 
 LOOP
 if vN = 0 then vWYNIK:=1;
 EXIT;
 END IF;
 IF vLiczba = vN THEN
 EXIT;
 END IF;
 vLiczba := vLiczba + 1;
 vWynik := vWynik * vLiczba;
 END LOOP;
 DBMS_OUTPUT.PUT_LINE('Silnia dla n='|| vN ||': '||vWynik);
END;

  

--10--
 DECLARE
    start_date DATE := TO_DATE('2001-01-13', 'YYYY-MM-DD');
    end_date DATE := TO_DATE('2100-12-13', 'YYYY-MM-DD');
    current_date DATE := start_date;

BEGIN
    WHILE current_date <= end_date LOOP
        IF TO_CHAR(current_date, 'D') = '5' THEN
            DBMS_OUTPUT.PUT_LINE(TO_CHAR(current_date, 'DD-MM-YYYY'));
        END IF;
        current_date := ADD_MONTHS(current_date, 1);
    END LOOP;
END;