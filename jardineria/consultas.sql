/*1. Crear un bloque que muestre por pantalla todos los trabajos que
empiecen hoy.*/
declare
    hoy date:=sysdate-6;
    cadena_fecha varchar2(25):=to_char(hoy,'DD/MM/YYYY');
    cursor datos is select trabajos.*
                            from trabajos
                            where trabajos.fecha_inicio=cadena_fecha;
    fila_datos datos%rowtype;
begin
    open datos;
    fetch datos into fila_datos;
    dbms_output.put_line('-------------------------------------------------');
    while(datos%found)loop
        dbms_output.put_line('Jardinero: '||fila_datos.jardinero);
        dbms_output.put_line('Plantacion: '||fila_datos.plantacion);
        dbms_output.put_line('Fecha de inicio: '||fila_datos.fecha_inicio);
        dbms_output.put_line('Dias: '||fila_datos.dias);
        dbms_output.put_line('Terminado: '||fila_datos.terminado);
        dbms_output.put_line('-------------------------------------------------');
        fetch datos into fila_datos;
    end loop;
    close datos;
end;


/*2. Crear un bloque que muestre por pantalla todos los trabajos que hayan
empezado hace 3 d�as.*/
declare
    hoy date:=sysdate-3;
    cadena_fecha varchar2(25):=to_char(hoy,'DD/MM/YYYY');
    cursor datos is select trabajos.*
                        from trabajos
                        where trabajos.fecha_inicio=cadena_fecha;
    fila_datos datos%rowtype;
begin
    open datos;
    fetch datos into fila_datos;
    dbms_output.put_line('-------------------------------------------------');
    if(datos%found)then
        while(datos%found)loop
                dbms_output.put_line('Jardinero: '||fila_datos.jardinero);
                dbms_output.put_line('Plantacion: '||fila_datos.plantacion);
                dbms_output.put_line('Fecha de inicio: '||fila_datos.fecha_inicio);
                dbms_output.put_line('Dias: '||fila_datos.dias);
                dbms_output.put_line('Terminado: '||fila_datos.terminado);
                dbms_output.put_line('-------------------------------------------------');
                fetch datos into fila_datos;
        end loop;
    else
        dbms_output.put_line('No hay ningun trabajo');
    end if;
    close datos;
end;


/*3. Crear un procedimiento almacenado que reciba una fecha y muestre
por pantalla todos los trabajos que hayan empezado desde esa fecha
hasta la actual.*/
create or replace procedure proc1(fe in date)is
    cursor datos is select trabajos.*
                    from trabajos
                    where trabajos.fecha_inicio>=fe;
    hoy date:=sysdate;
    fecha_actual varchar2(25):=to_char(hoy,'DD/MM/YYYY');
    fila_datos datos%rowtype;
begin
    open datos;
    fetch datos into fila_datos;
    dbms_output.put_line('-------------------------------------------------');
    if(datos%found)then
        while(datos%found)loop
                dbms_output.put_line('Jardinero: '||fila_datos.jardinero);
                dbms_output.put_line('Plantacion: '||fila_datos.plantacion);
                dbms_output.put_line('Fecha de inicio: '||fila_datos.fecha_inicio);
                dbms_output.put_line('Dias: '||fila_datos.dias);
                dbms_output.put_line('Terminado: '||fila_datos.terminado);
                dbms_output.put_line('-------------------------------------------------');
                fetch datos into fila_datos;
        end loop;
    else
        dbms_output.put_line('No hay ningun trabajo');
    end if;
    close datos;
end;

exec proc1('04/05/2023');



/*4. Escribir un bloque PL/SQL que muestre por pantalla todos los datos de
los jardineros. Tener en cuenta que, si el salario est� a null, se deber�
mostrar un 0 en vez de NULL. Nota: utilizar la funci�n NVL.*/

declare
    cursor datos is select jardinero.*,nvl(jardinero.salario,0) sr
                            from jardinero;
    fila_datos datos%rowtype;
begin
    open datos;
    fetch datos into fila_datos;
    dbms_output.put_line('-------------------------------------------------');
    while(datos%found) loop
            dbms_output.put_line('Nombre: '||fila_datos.nombre);
            dbms_output.put_line('Salario: '||fila_datos.sr);
            dbms_output.put_line('Dni: '||fila_datos.dni);
            dbms_output.put_line('-------------------------------------------------');
            fetch datos into fila_datos;
    end loop;
    close datos;
end;


/*5. Crear un procedimiento almacenado que reciba como par�metro el
nombre de un jardinero. El procedimiento devolver� el total del sueldo
que habr� que pagarle al jardinero, teniendo en cuenta que por cada d�a
trabajado se le pagar�n 6,5� adem�s de su salario. NOTA: el n�mero
devuelto no podr� llevar decimales.*/

create or replace procedure proc2(nom in varchar2) is 
        sld number:=0; 
        ds number:=0;  
        sueldo_total number:=0;
begin
    select jardinero.salario
    into sld
    from jardinero
    where jardinero.nombre=nom;

    select sum(trabajos.dias)
    into ds
    from trabajos,jardinero
    where trabajos.jardinero=jardinero.dni and 
    jardinero.nombre=nom;

    sueldo_total:=trunc(sld+(ds*6.5),2);

    dbms_output.put_line('El sueldo total es de: '||sueldo_total);
end;

exec proc2('Juan');


/*6. Crear un bloque PL/SQL que reciba un nuevo nombre para una
plantaci�n.El bloque deber� indicar si el nombre cabe en la tabla o no.
Tener en cuenta que el nombre de las plantaciones est� creado como
varchar2(10).*/

accept nom1 prompt 'Introduce el nombre:'
declare
    nombre varchar2(10);
begin
    nombre:=length('&nom1');

    if(nombre<=10)then
        dbms_output.put_line('El nombre si cabe en la tabla');
    else
        dbms_output.put_line('El nombre no cabe en la tabla');
    end if;
end;


/*7. Crear un procedimiento almacenado que reciba una fecha y un nombre
de mes. El procedimiento deber� devolver un �SI� o un �NO� dependiendo
de si la fecha pertenece al mes indicado.*/

create or replace procedure proc3(fe in date,n_mes in varchar2,cd out varchar2)is
    mensaje varchar2;
begin
    mensaje:=trim(to_char(fe,'month'));
    if(fe=mensaje)then
        cd:='SI';
    else
        cd:='NO';
    end if;
end proc3;


/*8. Crear un bloque PL/SQL que reciba el nombre de un mes y muestre la
siguiente salida: (reutilizar el procedimiento del ejercicio 7)
Jardinero Plantaci�n De <nombre mes>
<nombreJardinero> <nombrePlantacion> S� o no pertenece
<nombreJardinero> <nombrePlantacion> S� o no pertenece
<nombreJardinero> <nombrePlantacion> S� o no pertenece*/

accept n_mes prompt 'Introduce el nombre del mes:'
declare
    cursor datos is select jardinero.nombre,plantacion.nombre pr,trabajos.fecha_inicio
                        from jardinero,plantacion,trabajos
                        where jardinero.dni=trabajos.jardinero and
                        trabajos.plantacion=plantacion.codigo;
    condicional varchar2(50);
    fila_datos datos&rowtype;
begin
    open datos;
    fetch datos into fila_datos;
    dbms_output.put_line('Jardinero plantacion de : &mes');
    while(datos%found)loop

        proc3(fila_datos.fecha_inicio,'&n_mes',condicional);

        dbms_output.put_line('Nombre jardinero:'||fila_datos.nombre);
        dbms_output.put_line('Nombre plantacion:'||fila_datos.pr);
        dbms_output.put_line(condicional||' pertenece');

        fetch datos into fila_datos;
    end loop;
    close datos;
end;


/*9. Escribir un procedimiento almacenado que reciba una fecha y devuelva
el nombre del mes al que pertenece dicha fecha.*/



/*10.Escribir un bloque PL/SQL que muestre la siguiente salida:
Jardinero Plantaci�n Mes.
<nombreJardinero> <nombrePlantacion> <nombre mes>
<nombreJardinero> <nombrePlantacion> <nombre mes>
<nombreJardinero> <nombrePlantacion> <nombre mes>*/



/*11.Escribir un procedimiento almacenado que reciba una fecha y devuelva
el d�a de la semana a la que corresponde esa fecha.
Independientemente del idioma del sistema deber� devolver el d�a en
espa�ol.*/



/*12.Escribir un procedimiento almacenado que reciba el nombre de una
plantaci�n y que muestre una salida como la siguiente:
En la plantaci�n <nombre_plantacion> se han hecho los siguientes
trabajos:
1 <dia_semana><fecha_inicio> durante <d�as>
2 <dia_semana><fecha_inicio> durante <d�as>
3 �
En total se han trabajado <total_dias>*/