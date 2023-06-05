--EJERCICIO 1
create or replace procedure ej1(cod_p in number,cod_e in number, salario out number)is
    cant number(5,2);
    sal number(5,2);
begin
    select count(*)
    into cant
    from horarios
    where evento=cod_e and
    ponente=cod_p;
    
    select salario
    into sal
    from ponente where cod=cod_p;
    
    sal:=sal+(cant*30);
end ej1;


--EJERCICIO 2

create or replace procedure ej2(nom_evento in varchar2,fecha in date)is
    cursor datos is select ponente.nombre,ponente.salario  
                        from recuentos,evento,horarios,ponente
                        where ponente.cod=horarios.ponente and
                        evento.cod=horarios.evento and
                        recuentos.ponente=ponente.cod and
                        evento.titulo='&nom_evento' and
                        evento.fecha='&fecha';
                        
    suma_ponentes number:=0;
    fila_datos datos%rowtype;
begin
    open datos;
    fetch datos into fila_datos;
    dbms_output.put_line('---------------------------------');
    while(datos%found)loop
        suma_ponentes:=suma_ponentes+fila_datos.salario;
        dbms_output.put_line('El ponente '||fila_datos.nombre||' va a cobrar '||fila_datos.salario||' euros');
        dbms_output.put_line('------------------------------');
        fetch datos into fila_datos;
    end loop;
        dbms_output.put_line('El evento va a costar un total de:'||suma_ponentes);
    close datos;
end;

exec ej2('Diseño front-end','24/06/2023');


--EJERCICIO 3

create or replace trigger ej3 before insert or delete on horarios
for each row
declare
    t varchar2(50);
    c varchar2(50);
    n varchar2(50);
begin
    if inserting then
        select titulo into t from evento where cod=:new.evento;
        select nombre into c from charla where cod=:new.charla;
        select nombre into n from ponente where cod=:new.ponente;
        dbms_output.put_line('Se ha creado un nuevo horario para el evento '||t||' se dara la charla '||c||' por el ponente'||n);
    elsif deleting then
        select titulo into t from evento where cod=:old.evento;
        select nombre into c from charla where cod=:old.charla;
        select nombre into n from ponente where cod=:old.ponente;

        dbms_output.put_line('Se ha borrado la charla '||c||' del evento '||t||' iba a darla el ponente '||n);
    end if;
end ej3;


--EJERCICIO4

create or replace trigger ej4 after update of ponente on horarios
for each row
declare
    nom_a varchar2(50);
    nom_b varchar2(50);
begin
    select nombre into nom_a from ponente where cod=:old.ponente;
    select nombre into nom_b from ponente where cod=:new.ponente;
    dbms_output.put_line('Nombre ponente sustituido:'||nom_a);
    dbms_output.put_line('Nombre ponente sustituto:'||nom_b);
    update ponente set salario=salario-50 where cod=:old.ponente;
    update ponente set salario=salario+50 where cod=:new.ponente;
end ej4;

update horarios set ponente=3
where ponente=4 and
evento=1 and
orden=3;

--EJERCICIO 5

create or replace trigger ej5 after insert on horarios
for each row
declare
    drn number(3);
    cant number(2);
begin
    select duracion
    into drn
    from charla
    where cod=:new.charla;
    
    select count(*)
    into cant
    from recuentos
    where ponente=:new.ponente;
    
    if(cant>=0)then
        update recuentos 
        set num_charlas=num_charlas+3
        where ponente=:new.ponente;
        
        update recuentos 
        set tiempo=tiempo+drn
        where ponente=:new.ponente;
    else
        insert into recuentos values(:new.ponente,2,drn);
    end if;
end ej5;

