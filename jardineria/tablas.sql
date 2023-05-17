drop table trabajos;
drop table plantacion;
drop table jardinero;
/* **********     TABLAS    ************ */
create table jardinero
(
	dni varchar2(9) primary key,
	nombre varchar2(10),
	salario number(6,2)
);

create table plantacion
(	
	codigo number(2) primary key,
	nombre varchar2(10),
	mcuadrados number(3)
);

create table trabajos
(
	jardinero varchar2(9),
	plantacion number(2),
	fecha_inicio date,
	dias number(2),
	terminado varchar2(2),
	constraint pk primary key (jardinero, plantacion, fecha_inicio),
	constraint fk1 foreign key (jardinero) references jardinero (dni),
	constraint fk2 foreign key (plantacion) references plantacion (codigo)
);

/* **********     DATOS    ************ */
insert into jardinero values ('11111111S', 'Manolo', 352);
insert into jardinero values ('22222222R', 'Juan', 1500);
insert into jardinero values ('33333333M', 'Andres', 985.2);
insert into jardinero values ('44444444J', 'Maria', 1150.50);
insert into jardinero values ('55555555P', 'Ana', 985.75);
insert into jardinero values ('66666666L', 'Helena', null);
insert into jardinero values ('77777777B', 'Pablo', null);

insert into plantacion values (1, 'Villanueva', 500);
insert into plantacion values (2, 'Realejo', 150);
insert into plantacion values (3, 'Historiado', 375);

insert into trabajos values ('11111111S', 1, '07/05/2023', 3, 'SI');
insert into trabajos values ('11111111S', 2, '04/05/2023', 4, 'NO');
insert into trabajos values ('11111111S', 3, '04/05/2023', 15, 'SI');
insert into trabajos values ('22222222R', 1, '08/05/2023', 8, 'NO');
insert into trabajos values ('22222222R', 2, '07/05/2023', 23, 'NO');
insert into trabajos values ('22222222R', 3, '04/05/2023', 4, 'SI');
insert into trabajos values ('22222222R', 2, '08/05/2023', 23, 'NO');
insert into trabajos values ('22222222R', 3, '07/05/2023', 1, 'SI');
insert into trabajos values ('33333333M', 1, '08/05/2023', 9, 'NO');
insert into trabajos values ('33333333M', 2, '04/05/2023', 10, 'SI');
insert into trabajos values ('33333333M', 3, '07/05/2023', 23, 'SI');
insert into trabajos values ('33333333M', 2, '07/05/2023', 4, 'NO');
insert into trabajos values ('33333333M', 3, '04/05/2023', 21, 'SI');
insert into trabajos values ('44444444J', 1, '07/05/2023', 2, 'NO');
insert into trabajos values ('44444444J', 3, '08/05/2023', 8, 'NO');
insert into trabajos values ('44444444J', 2, '07/05/2023', 17, 'NO');
insert into trabajos values ('44444444J', 2, '08/05/2023', 15, 'SI');
insert into trabajos values ('44444444J', 3, '07/05/2023', 12, 'NO');
insert into trabajos values ('44444444J', 3, '04/05/2023', 7, 'SI');
insert into trabajos values ('55555555P', 3, '06/05/2023', 7, 'SI');
insert into trabajos values ('66666666L', 1, '06/05/2023', 14, 'SI');
insert into trabajos values ('55555555P', 2, '09/05/2023', 4, 'SI');
insert into trabajos values ('66666666L', 1, '07/05/2023', 38, 'SI');
insert into trabajos values ('66666666L', 2, '09/05/2023', 6, 'SI');
insert into trabajos values ('66666666L', 3, '09/05/2023', 9, 'SI');

