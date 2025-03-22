create table EDITURI(
id_editura number(3),
nume varchar(20),
email varchar(20),
constraint pk_id_editura primary key(id_editura),
constraint unq_nume_editura unique(nume),
constraint unq_email_editura unique(email)
);

create table CARTI(
id_carte number(3),
nume varchar(30),
autor varchar(30),
isbn varchar(20),
categorie varchar(20),
an_publicare date default sysdate,
id_editura number(3),
nr_pagini number(4),
constraint pk_id_carti primary key(id_carte),
constraint unq_isbn_carti unique(isbn),
constraint fk_carti_editura foreign key(id_editura) references EDITURI(id_editura)
);

create table UTILIZATOR(
id_utilizator number(3),
nume varchar(20) constraint null_nume not null,
prenume varchar(20),
telefon varchar(20),
email varchar(20),
constraint pk_id_utilizator primary key(id_utilizator),
constraint unq_nume_prenume unique(nume, prenume),
constraint unq_tel unique(telefon),
constraint unq_email unique(email)
);

create table RECENZII(
id_recenzie number(3),
id_carte number(3),
id_utilizator number(3),
evaluare number(2),
comentariu varchar(30),
data_recenziei date default sysdate,
constraint pk_id_recenzie primary key(id_recenzie),
constraint fk_recenzie_carte foreign key(id_carte) references CARTI(id_carte),
constraint fk_recenzie_utilizator foreign key(id_utilizator) references UTILIZATOR(id_utilizator)
);

create table IMPRUMUTURI(
id_imprumut number(3),
id_exemplar number(3),
id_utilizator number(3),
data_imprumut date default sysdate,
data_scadenta date default sysdate+30,
constraint pk_id_imprumut primary key(id_imprumut),
constraint fk_imprumut_utilizator foreign key(id_utilizator) references UTILIZATOR(id_utilizator)
);

create table REZERVARI(
id_rezervare number(3),
id_utilizator number(3),
id_exemplar number(3),
data_rezervare date default sysdate,
constraint pk_id_rezervare primary key(id_rezervare),
constraint fk_rezervare_utilizator foreign key(id_utilizator) references UTILIZATOR(id_utilizator)
);

create table EXEMPLARE_CARTI(
id_exemplar number(3),
id_carte number(3),
id_filiala number(3),
stare varchar(30) default 'disponibila',
constraint pk_id_exemplar primary key(id_exemplar),
constraint fk_exemplar_carte foreign key(id_carte) references CARTI(id_carte)
);

alter table rezervari
add constraint fk_rezervare_exemplar foreign key(id_exemplar) references exemplare_carti(id_exemplar);

alter table imprumuturi
add constraint fk_imprumut_exemplar foreign key(id_exemplar) references exemplare_carti(id_exemplar);

create table FILIALE(
id_filiala number(3),
id_sef number(3),
nume varchar(20),
locatie varchar(20),
telefon varchar(20),
constraint pk_id_filiala primary key(id_filiala),
constraint unq_tel_filiala unique(telefon)
);
alter table filiale
modify (id_sef number(3) default null);
alter table exemplare_carti
modify (id_filiala number(3) default null);

alter table exemplare_carti
add constraint fk_exemplar_filiala foreign key(id_filiala) references FILIALE(id_filiala);

create table ANGAJATI(
id_angajat number(3),
id_departament number(3),
nume varchar(20),
prenume varchar(20),
functie varchar(20),
constraint pk_id_angajat primary key(id_angajat)
);
alter table ANGAJATI
add (salariu number(10, 2));
alter table filiale
add constraint fk_filiala_sef foreign key(id_sef) references angajati(id_angajat);


create table DEPARTAMENTE(
id_departament number(3),
id_sef number(3),
nume varchar(20),
constraint pk_id_departament primary key(id_departament),
constraint fk_departament_sef foreign key(id_sef) references angajati(id_angajat)
);

alter table angajati
add constraint fk_angajat_departament foreign key(id_departament) references departamente(id_departament);

create table RAPOARTE_FINANCIARE(
id_raport number(3),
id_responsabil number(3),
data_raport date default sysdate,
venit number(6),
chetuieli number(6),
constraint pk_id_raport primary key(id_raport),
constraint fk_raport_responsabil foreign key(id_responsabil) references angajati(id_angajat)
);

create table EVENIMENTE(
id_eveniment number(3),
id_organizator number(3),
data_eveniment date default sysdate,
nume varchar(20),
constraint pk_id_eveniment primary key(id_eveniment),
constraint fk_eveniment_organizator foreign key(id_organizator) references angajati(id_angajat)
);

commit;


create  sequence seq_edituri
start with 10
increment by 1
maxvalue 10000
nocycle
nocache;

create  sequence seq_carti
start with 50
increment by 1
maxvalue 10000
nocycle
nocache;

create  sequence seq_exemplare
start with 100
increment by 1
maxvalue 10000
nocycle
nocache;

create  sequence seq_recenzii
start with 150
increment by 1
maxvalue 10000
nocycle
nocache;

create  sequence seq_rezervari
start with 200
increment by 1
maxvalue 10000
nocycle
nocache;

create  sequence seq_imprumuturi
start with 250
increment by 1
maxvalue 10000
nocycle
nocache;


create  sequence seq_utilizatori
start with 300
increment by 1
maxvalue 10000
nocycle
nocache;

create  sequence seq_filiale
start with 350
increment by 1
maxvalue 10000
nocycle
nocache;

create  sequence seq_angajati
start with 400
increment by 1
maxvalue 10000
nocycle
nocache;

create  sequence seq_departamente
start with 450
increment by 1
maxvalue 10000
nocycle
nocache;

create  sequence seq_rapoarte
start with 500
increment by 1
maxvalue 10000
nocycle
nocache;

create  sequence seq_evenimente
start with 550
increment by 1
maxvalue 10000
nocycle
nocache;

commit;

insert into EDITURI (id_editura, nume, email) 
values (seq_edituri.nextval, 'Humanitas', 'contact@humanitas.ro');
insert into EDITURI (id_editura, nume, email) 
values (seq_edituri.nextval, 'Polirom', 'contact@polirom.ro');
insert into EDITURI (id_editura, nume, email) 
values (seq_edituri.nextval, 'Nemira', 'contact@nemira.ro');
insert into EDITURI (id_editura, nume, email) 
values (seq_edituri.nextval, 'RAO', 'contact@rao.ro');
insert into EDITURI (id_editura, nume, email) 
values (seq_edituri.nextval, 'Litera', 'contact@litera.ro');
insert into EDITURI (id_editura, nume, email) 
values (seq_edituri.nextval, 'Art', 'contact@art.ro');
insert into EDITURI (id_editura, nume, email) 
values (seq_edituri.nextval, 'Curtea Veche', 'contact@cveche.ro');
insert into EDITURI (id_editura, nume, email) 
values (seq_edituri.nextval, 'Trei', 'contact@trei.ro');
insert into EDITURI (id_editura, nume, email) 
values (seq_edituri.nextval, 'Paralela 45', 'contact@par45.ro');
insert into EDITURI (id_editura, nume, email) 
values (seq_edituri.nextval, 'Corint', 'contact@corint.ro');


insert into CARTI (id_carte, nume, autor, isbn, categorie, an_publicare, id_editura, nr_pagini) 
values (seq_carti.nextval, 'Micul Print', 'Antoine de Saint-Exupery', '9786064001010', 'Literatura', sysdate - 1000, 10, 96);
insert into CARTI (id_carte, nume, autor, isbn, categorie, an_publicare, id_editura, nr_pagini) 
values (seq_carti.nextval, '1984', 'George Orwell', '9786064001027', 'Literatura', sysdate - 2000, 11, 328);
insert into CARTI (id_carte, nume, autor, isbn, categorie, an_publicare, id_editura, nr_pagini) 
values (seq_carti.nextval, 'Brave New World', 'Aldous Huxley', '9786064001034', 'Literatura', sysdate - 1500, 12, 311);
insert into CARTI (id_carte, nume, autor, isbn, categorie, an_publicare, id_editura, nr_pagini) 
values (seq_carti.nextval, 'To Kill a Mockingbird', 'Harper Lee', '9786064001041', 'Literatura', sysdate - 1700, 13, 281);
insert into CARTI (id_carte, nume, autor, isbn, categorie, an_publicare, id_editura, nr_pagini) 
values (seq_carti.nextval, 'Harry Potter', 'J.K. Rowling', '9786064001058', 'Fictiune', sysdate - 800, 14, 309);
insert into carti (id_carte, nume, autor, isbn, categorie, an_publicare, id_editura, nr_pagini)
values (seq_carti.nextval, 'Crima si pedeapsa', 'Fiodor Dostoievski', '9781234567890', 'Categoria Cartii', to_date('01-01-2020', 'DD-MM-YYYY'), 10, 300);

insert into utilizator (id_utilizator, nume, prenume, telefon, email) 
values (seq_utilizatori.nextval, 'Ionescu', 'Ana', '0723456789', 'ana.ionescu@mail.com');
insert into utilizator (id_utilizator, nume, prenume, telefon, email) 
values (seq_utilizatori.nextval, 'Popescu', 'Mihai', '0712345678', 'mihai.p@mail.com');
insert into utilizator (id_utilizator, nume, prenume, telefon, email) 
values (seq_utilizatori.nextval, 'Georgescu', 'Maria', '0734567890', 'maria.g@mail.com');
insert into utilizator (id_utilizator, nume, prenume, telefon, email) 
values (seq_utilizatori.nextval, 'Marin', 'Ion', '0745678901', 'ion.marin@mail.com');
insert into utilizator (id_utilizator, nume, prenume, telefon, email) 
values (seq_utilizatori.nextval, 'Dumitrescu', 'Elena', '0756789012', 'elena.d@mail.com');
insert into utilizator (id_utilizator, nume, prenume, telefon, email)
values (seq_utilizatori.nextval, 'Pop', 'Ion', '0700111222', 'ion.pop@mail.com');
insert into utilizator (id_utilizator, nume, prenume, telefon, email)
values (seq_utilizatori.nextval, 'Ion', 'Maria', '0700222333', 'maria.i@mail.com');
insert into utilizator (id_utilizator, nume, prenume, telefon, email)
values (seq_utilizatori.nextval, 'George', 'Andrei', '0700333444', 'andrei.g@mail.com');
insert into utilizator (id_utilizator, nume, prenume, telefon, email)
values (seq_utilizatori.nextval, 'Vasilescu', 'Ana', '0700444555', 'ana.v@mail.com');
insert into utilizator (id_utilizator, nume, prenume, telefon, email)
values (seq_utilizatori.nextval, 'Dumitrescu', 'Mihai', '0700555666', 'mihai.d@mail.com');
insert into utilizator (id_utilizator, nume, prenume, telefon, email)
values (seq_utilizatori.nextval, 'Constantinescu', 'Elena', '0700666777', 'elena.c@mail.com');
insert into utilizator (id_utilizator, nume, prenume, telefon, email)
values (seq_utilizatori.nextval, 'Popa', 'George', '0700777888', 'george.p@mail.com');
insert into utilizator (id_utilizator, nume, prenume, telefon, email)
values (seq_utilizatori.nextval, 'Radu', 'Adrian', '0700888999', 'adrian.r@mail.com');
insert into utilizator (id_utilizator, nume, prenume, telefon, email)
values (seq_utilizatori.nextval, 'Stan', 'Roxana', '0700999000', 'roxana.s@mail.com');
insert into utilizator (id_utilizator, nume, prenume, telefon, email)
values (seq_utilizatori.nextval, 'Enescu', 'Daniel', '0700001111', 'daniel.e@mail.com');

insert into exemplare_carti (id_exemplar, id_carte, id_filiala, stare) 
values (seq_exemplare.nextval, 50, null, 'disponibila');
insert into exemplare_carti (id_exemplar, id_carte, id_filiala, stare) 
values (seq_exemplare.nextval, 51, null, 'disponibila');
insert into exemplare_carti (id_exemplar, id_carte, id_filiala, stare) 
values (seq_exemplare.nextval, 52, null, 'disponibila');
insert into exemplare_carti (id_exemplar, id_carte, id_filiala, stare) 
values (seq_exemplare.nextval, 53, null, 'disponibila');
insert into exemplare_carti (id_exemplar, id_carte, id_filiala, stare) 
values (seq_exemplare.nextval, 55, null, 'disponibila');
insert into exemplare_carti (id_exemplar, id_carte, id_filiala, stare) 
values (seq_exemplare.nextval, 50, null, 'indisponibila');
insert into exemplare_carti (id_exemplar, id_carte, id_filiala, stare) 
values (seq_exemplare.nextval, 51, null, 'indisponibila');
insert into exemplare_carti (id_exemplar, id_carte, id_filiala, stare) 
values (seq_exemplare.nextval, 52, null, 'indisponibila');
insert into exemplare_carti (id_exemplar, id_carte, id_filiala, stare) 
values (seq_exemplare.nextval, 53, null, 'indisponibila');
insert into exemplare_carti (id_exemplar, id_carte, id_filiala, stare) 
values (seq_exemplare.nextval, 55, null, 'indisponibila');
insert into exemplare_carti (id_exemplar, id_carte, id_filiala, stare) 
values (seq_exemplare.nextval, 56, null, null);

insert into recenzii (id_recenzie, id_carte, id_utilizator, evaluare, comentariu, data_recenziei) 
values (seq_recenzii.nextval, 50, 300, 5, 'O carte excelenta!', sysdate - 30);
insert into recenzii (id_recenzie, id_carte, id_utilizator, evaluare, comentariu, data_recenziei) 
values (seq_recenzii.nextval, 51, 302, 4, 'Foarte interesanta!', sysdate - 20);
insert into recenzii (id_recenzie, id_carte, id_utilizator, evaluare, comentariu, data_recenziei) 
values (seq_recenzii.nextval, 52, 304, 3, 'Buna, dar putea fi mai buna.', sysdate - 10);
insert into recenzii (id_recenzie, id_carte, id_utilizator, evaluare, comentariu, data_recenziei) 
values (seq_recenzii.nextval, 53, 305, 4, 'Recomand!', sysdate - 5);
insert into recenzii (id_recenzie, id_carte, id_utilizator, evaluare, comentariu, data_recenziei) 
values (seq_recenzii.nextval, 55, 306, 5, 'Extraordinar!', sysdate - 1);
insert into recenzii (id_recenzie, id_carte, id_utilizator, evaluare, comentariu, data_recenziei) 
values (seq_recenzii.nextval, 56, 306, 5, 'Extraordinar!', sysdate - 1);
insert into recenzii (id_recenzie, id_carte, id_utilizator, evaluare, comentariu, data_recenziei) 
values (seq_recenzii.nextval, 55, 304, 5, 'Extraordinar!', sysdate - 1);
insert into recenzii (id_recenzie, id_carte, id_utilizator, evaluare, comentariu, data_recenziei) 
values (seq_recenzii.nextval, 51, 304, 5, 'Extraordinar!', sysdate - 1);
insert into recenzii (id_recenzie, id_carte, id_utilizator, evaluare, comentariu, data_recenziei) 
values (seq_recenzii.nextval, 50, 305, 4, 'Recomand!', sysdate - 5);
insert into recenzii (id_recenzie, id_carte, id_utilizator, evaluare, comentariu, data_recenziei) 
values (seq_recenzii.nextval, 53, 302, 5, 'Recomand!', sysdate - 5);

insert into rezervari (id_rezervare, id_utilizator, id_exemplar, data_rezervare) 
values (seq_rezervari.nextval, 300, 101, sysdate - 10);
insert into rezervari (id_rezervare, id_utilizator, id_exemplar, data_rezervare) 
values (seq_rezervari.nextval, 302, 102, sysdate - 9);
insert into rezervari (id_rezervare, id_utilizator, id_exemplar, data_rezervare) 
values (seq_rezervari.nextval, 304, 103, sysdate - 8);
insert into rezervari (id_rezervare, id_utilizator, id_exemplar, data_rezervare) 
values (seq_rezervari.nextval, 305, 104, sysdate - 7);
insert into rezervari (id_rezervare, id_utilizator, id_exemplar, data_rezervare) 
values (seq_rezervari.nextval, 306, 105, sysdate - 6);
insert into rezervari (id_rezervare, id_utilizator, id_exemplar, data_rezervare) 
values (seq_rezervari.nextval, 313, 105, sysdate - 600);
insert into rezervari (id_rezervare, id_utilizator, id_exemplar, data_rezervare) 
values (seq_rezervari.nextval, 305, 105, sysdate - 700);
insert into rezervari (id_rezervare, id_utilizator, id_exemplar, data_rezervare) 
values (seq_rezervari.nextval, 318, 104, sysdate - 800);
insert into rezervari (id_rezervare, id_utilizator, id_exemplar, data_rezervare) 
values (seq_rezervari.nextval, 317, 103, sysdate - 400);
insert into rezervari (id_rezervare, id_utilizator, id_exemplar, data_rezervare) 
values (seq_rezervari.nextval, 318, 101, sysdate - 60);
insert into rezervari (id_rezervare, id_utilizator, id_exemplar, data_rezervare) 
values (seq_rezervari.nextval, 313, 102, sysdate - 30);

insert into imprumuturi (id_imprumut, id_exemplar, id_utilizator, data_imprumut, data_scadenta) 
values (seq_imprumuturi.nextval, 106, 307, sysdate - 20, sysdate + 10);
insert into imprumuturi (id_imprumut, id_exemplar, id_utilizator, data_imprumut, data_scadenta) 
values (seq_imprumuturi.nextval, 107, 309, sysdate - 15, sysdate + 15);
insert into imprumuturi (id_imprumut, id_exemplar, id_utilizator, data_imprumut, data_scadenta) 
values (seq_imprumuturi.nextval, 108, 309, sysdate - 10, sysdate + 20);
insert into imprumuturi (id_imprumut, id_exemplar, id_utilizator, data_imprumut, data_scadenta) 
values (seq_imprumuturi.nextval, 109, 310, sysdate - 5, sysdate + 25);
insert into imprumuturi (id_imprumut, id_exemplar, id_utilizator, data_imprumut, data_scadenta) 
values (seq_imprumuturi.nextval, 110, 315, sysdate - 1, sysdate + 29);
insert into imprumuturi (id_imprumut, id_exemplar, id_utilizator, data_imprumut, data_scadenta) 
values (seq_imprumuturi.nextval, 110, 302, sysdate - 1, sysdate + 29);
insert into imprumuturi (id_imprumut, id_exemplar, id_utilizator, data_imprumut, data_scadenta) 
values (seq_imprumuturi.nextval, 102, 302, sysdate - 1, sysdate + 29);
insert into imprumuturi (id_imprumut, id_exemplar, id_utilizator, data_imprumut, data_scadenta) 
values (seq_imprumuturi.nextval, 110, 304, sysdate - 1, sysdate + 29);
insert into imprumuturi (id_imprumut, id_exemplar, id_utilizator, data_imprumut, data_scadenta) 
values (seq_imprumuturi.nextval, 102, 304, sysdate - 10, sysdate + 19);
insert into imprumuturi (id_imprumut, id_exemplar, id_utilizator, data_imprumut, data_scadenta) 
values (seq_imprumuturi.nextval, 103, 304, sysdate - 10, sysdate + 19);
insert into imprumuturi (id_imprumut, id_exemplar, id_utilizator, data_imprumut, data_scadenta) 
values (seq_imprumuturi.nextval, 105, 304, sysdate - 1, sysdate + 29);
insert into imprumuturi (id_imprumut, id_exemplar, id_utilizator, data_imprumut, data_scadenta) 
values (seq_imprumuturi.nextval, 108, 302, sysdate - 1, sysdate + 29);
insert into imprumuturi (id_imprumut, id_exemplar, id_utilizator, data_imprumut, data_scadenta) 
values (seq_imprumuturi.nextval, 107, 302, sysdate - 10, sysdate + 19);
insert into imprumuturi (id_imprumut, id_exemplar, id_utilizator, data_imprumut, data_scadenta) 
values (seq_imprumuturi.nextval, 102, 304, sysdate - 1, sysdate + 29);
insert into imprumuturi (id_imprumut, id_exemplar, id_utilizator, data_imprumut, data_scadenta) 
values (seq_imprumuturi.nextval, 106, 302, sysdate - 10, sysdate + 19);
insert into imprumuturi (id_imprumut, id_exemplar, id_utilizator, data_imprumut, data_scadenta) 
values (seq_imprumuturi.nextval, 107, 304, sysdate - 1, sysdate + 29);

insert into filiale (id_filiala, id_sef, nume, locatie, telefon) 
values (seq_filiale.nextval, null, 'Filiala Centrala', 'Bucuresti', '0219123456');
insert into filiale (id_filiala, id_sef, nume, locatie, telefon) 
values (seq_filiale.nextval, null, 'Filiala Nord', 'Cluj', '0264123456');
insert into filiale (id_filiala, id_sef, nume, locatie, telefon) 
values (seq_filiale.nextval, null, 'Filiala Vest', 'Timisoara', '0256123456');
insert into filiale (id_filiala, id_sef, nume, locatie, telefon) 
values (seq_filiale.nextval, null, 'Filiala Sud', 'Craiova', '0254123456');
insert into filiale (id_filiala, id_sef, nume, locatie, telefon) 
values (seq_filiale.nextval, null, 'Filiala Est', 'Iasi', '0232123456');

update exemplare_carti
set id_filiala = 350;

update exemplare_carti 
set id_filiala = 351
where id_exemplar >107;

insert into angajati (id_angajat, id_departament, nume, prenume, functie, salariu) 
values (seq_angajati.nextval, null, 'Popescu', 'Ion', 'Director', 5000.00);
update angajati
set id_departament = 450
where id_angajat = 400;

insert into angajati (id_angajat, id_departament, nume, prenume, functie, salariu) 
values (seq_angajati.nextval, null, 'Ionescu', 'Ana', 'Manager', 4000.00);
update angajati
set id_departament = 451
where id_angajat = 401;

insert into angajati (id_angajat, id_departament, nume, prenume, functie, salariu) 
values (seq_angajati.nextval, null, 'Georgescu', 'Vasile', 'Bibliotecar', 3000.00);
update angajati
set id_departament = 452
where id_angajat = 402;

insert into angajati (id_angajat, id_departament, nume, prenume, functie, salariu) 
values (seq_angajati.nextval, null, 'Dumitrescu', 'Elena', 'Bibliotecar', 3000.00);
update angajati
set id_departament = 453
where id_angajat = 403;

insert into angajati (id_angajat, id_departament, nume, prenume, functie, salariu) 
values (seq_angajati.nextval, null, 'Marin', 'Ioana', 'Asistent', 2500.00);
update angajati
set id_departament = 454
where id_angajat = 404;

insert into angajati (id_angajat, id_departament, nume, prenume, functie, salariu)
values (seq_angajati.nextval, null, 'Popa', 'Marius', 'Bibliotecar', 3000.00);
update angajati
set id_departament = 451
where id_angajat = 405;

insert into angajati (id_angajat, id_departament, nume, prenume, functie, salariu)
values (seq_angajati.nextval, null, 'Ionescu', 'Raluca', 'Asistent', 2500.00);
update angajati
set id_departament = 451
where id_angajat = 406;

insert into angajati (id_angajat, id_departament, nume, prenume, functie, salariu)
values (seq_angajati.nextval, null, 'Georgescu', 'Alina', 'Manager', 5000.00);
update angajati
set id_departament = 452
where id_angajat = 407;

insert into angajati (id_angajat, id_departament, nume, prenume, functie, salariu)
values (seq_angajati.nextval, null, 'Dumitrescu', 'Mihai', 'Contabil', 3500.00);
update angajati
set id_departament = 453
where id_angajat = 408;

insert into angajati (id_angajat, id_departament, nume, prenume, functie, salariu)
values (seq_angajati.nextval, null, 'Vasilescu', 'Ioana', 'Specialist IT', 4000.00);
update angajati
set id_departament = 453
where id_angajat = 409;

insert into angajati (id_angajat, id_departament, nume, prenume, functie, salariu)
values (seq_angajati.nextval, null, 'Constantinescu', 'Radu', 'Specialist HR', 3800.00);
update angajati
set id_departament = 454
where id_angajat = 410;

insert into angajati (id_angajat, id_departament, nume, prenume, functie, salariu)
values (seq_angajati.nextval, null, 'Popescu', 'Adrian', 'Analist', 3700.00);
update angajati
set id_departament = 454
where id_angajat = 411;

insert into angajati (id_angajat, id_departament, nume, prenume, functie, salariu)
values (seq_angajati.nextval, null, 'Radu', 'Elena', 'Secretar', 2700.00);
update angajati
set id_departament = 451
where id_angajat = 412;

insert into angajati (id_angajat, id_departament, nume, prenume, functie, salariu)
values (seq_angajati.nextval, null, 'Enescu', 'Daniel', 'Agent de Securitate', 3200.00);
update angajati
set id_departament = 451
where id_angajat = 413;

insert into angajati (id_angajat, id_departament, nume, prenume, functie, salariu)
values (seq_angajati.nextval, null, 'Stan', 'Roxana', 'Consultant', 3600.00);
update angajati
set id_departament = 451
where id_angajat = 414;

insert into departamente (id_departament, id_sef, nume) 
values (seq_departamente.nextval, 400, 'Resurse Umane');
insert into departamente (id_departament, id_sef, nume) 
values (seq_departamente.nextval, 401, 'IT');
insert into departamente (id_departament, id_sef, nume) 
values (seq_departamente.nextval, 402, 'Marketing');
insert into departamente (id_departament, id_sef, nume) 
values (seq_departamente.nextval, 403, 'Financiar');
insert into departamente (id_departament, id_sef, nume) 
values (seq_departamente.nextval, 404, 'Administrativ');

insert into rapoarte_financiare (id_raport, id_responsabil, data_raport, venit, chetuieli) 
values (seq_rapoarte.nextval, 410, sysdate - 30, 10000, 5000);
insert into rapoarte_financiare (id_raport, id_responsabil, data_raport, venit, chetuieli) 
values (seq_rapoarte.nextval, 411, sysdate - 20, 15000, 8000);
insert into rapoarte_financiare (id_raport, id_responsabil, data_raport, venit, chetuieli) 
values (seq_rapoarte.nextval, 412, sysdate - 10, 12000, 7000);
insert into rapoarte_financiare (id_raport, id_responsabil, data_raport, venit, chetuieli) 
values (seq_rapoarte.nextval, 414, sysdate - 5, 20000, 10000);
insert into rapoarte_financiare (id_raport, id_responsabil, data_raport, venit, chetuieli) 
values (seq_rapoarte.nextval, 409, sysdate - 1, 18000, 9000);
select * from rapoarte_financiare;


insert into evenimente (id_eveniment, id_organizator, data_eveniment, nume) 
values (seq_evenimente.nextval, 400, sysdate + 10, 'Lansare carte');
insert into evenimente (id_eveniment, id_organizator, data_eveniment, nume) 
values (seq_evenimente.nextval, 401, sysdate + 20, 'Scriere creativa');
insert into evenimente (id_eveniment, id_organizator, data_eveniment, nume) 
values (seq_evenimente.nextval, 402, sysdate + 30, 'Seminar literatura');
insert into evenimente (id_eveniment, id_organizator, data_eveniment, nume) 
values (seq_evenimente.nextval, 403, sysdate + 40, 'Expozitie de carte');
insert into evenimente (id_eveniment, id_organizator, data_eveniment, nume) 
values (seq_evenimente.nextval, 404, sysdate + 50, 'Intalnire cu autorul');


desc carti;
desc imprumuturi;

select * from imprumuturi;
select * from utilizator;


--Enunt: Afisati numele cartilor si numele editurilor pentru cartile care au fost împrumutate de utilizatorii cu nume de familie 'Popescu'.
--subcereri sincronizate cu cel putin 3 tabele(punctul a))
select c.nume as nume_carte, e.nume as nume_editura
from carti c join edituri e on c.id_editura = e.id_editura
join exemplare_carti e on e.id_carte = c.id_carte
where e.id_exemplar in (
    select i.id_exemplar
    from imprumuturi i join utilizator u on i.id_utilizator = u.id_utilizator
    where u.nume = 'Popescu'
    and i.id_exemplar = e.id_exemplar
);




select * from carti;
select * from recenzii;
select * from utilizator;




--Subcereri nesincronizate în clauza FROM(punctul b))
--Enunt: Afisati numele si adresele de email ale utilizatorilor care au facut recenzii pentru carti publicate în anul 2020.
select u.nume, u.email
from utilizator u
join (
    select r.id_utilizator
    from recenzii r
    join carti c on r.id_carte = c.id_carte
    where extract(year from c.an_publicare) = 2020
) aux on u.id_utilizator = aux.id_utilizator;


--Grupari de date, functii grup, filtrare la nivel de grupuri cu subcereri nesincronizate (în clauza de HAVING) 
--în care intervin cel putin 3 tabele(punctul c))
--Enunt: Afisati numele si adresele de email ale utilizatorilor care au facut cel putin 5 împrumuturi 
--si au dat o evaluare medie mai mare de 4 pentru cartile împrumutate.
select u.nume, u.email
from utilizator u
join (
    select i.id_utilizator, avg(r.evaluare) as evaluare_medie, count(i.id_imprumut) as numar_imprumuturi
    from imprumuturi i
    join recenzii r on i.id_utilizator = r.id_utilizator
    join exemplare_carti ec on i.id_exemplar = ec.id_exemplar
    join carti c on ec.id_carte = c.id_carte
    group by i.id_utilizator
    having count(i.id_imprumut) >= 5 and avg(r.evaluare) >= 4
) aux on u.id_utilizator = aux.id_utilizator;


--Ordonari si utilizarea functiilor NVL si DECODE (în cadrul aceleiasi cereri)(punctul d))
--Enunt: Afisati numele cartilor, numele autorilor si starea exemplarului, 
--înlocuind valoarea NULL din starea exemplarului cu 'Necunoscut'. 
--De asemenea, afisati starea ca 'Disponibil' pentru 'disponibila', altfel afisati 'Indisponibil'.
select c.nume as nume_carte, c.autor, decode(nvl(ec.stare, 'Necunoscut'), 'disponibila', 'Disponibil', 'Necunoscut', 'Necunoscut', 'Indisponibil') as stare_exemplar
from carti c
join exemplare_carti ec on c.id_carte = ec.id_carte
order by c.nume;


--Utilizarea a cel putin 2 functii pe siruri de caractere, 2 functii pe date calendaristice, a cel putin unei expresii CASE 
--si a cel putin 1 bloc de cerere (clauza WITH)(punctele e), f))
--Enunt: Afisati numele complet al utilizatorilor (nume si prenume concatenat), 
--luna si anul ultimei rezervari si un mesaj personalizat care sa spuna daca utilizatorul 
--a facut vreo rezervare în ultimul an sau nu.
with rezervari_recente as (
    select id_utilizator, max(data_rezervare) as ultima_rezervare
    from rezervari
    group by id_utilizator
)
select u.nume || ' ' || u.prenume as nume_complet, to_char(rr.ultima_rezervare, 'MM') as luna_ultima_rezervare, to_char(rr.ultima_rezervare, 'YYYY') as anul_ultima_rezervare,
       case
           when rr.ultima_rezervare >= add_months(sysdate, -12) then 'A facut rezervari în ultimul an'
           else 'Nu a facut rezervari în ultimul an'
       end as status_rezervari
from utilizator u left join rezervari_recente rr on u.id_utilizator = rr.id_utilizator;

--Cerere care implementeaza analiza Top-N
--Enunt: Afisati top 5 utilizatori care au împrumutat cele mai multe carti.
select *
from (
    select u.id_utilizator, u.nume, u.prenume,count(i.id_imprumut) as numar_imprumuturi
    from utilizator u join imprumuturi i on u.id_utilizator = i.id_utilizator
    group by u.id_utilizator, u.nume, u.prenume
    order by numar_imprumuturi desc
) 
where rownum <= 5;

--Mariti cu 10% salariul angajatilor care lucreaza in departamentul resurse umane.
update angajati
set salariu = salariu * 1.10
where id_departament = (
    select id_departament
    from departamente
    where nume = 'Resurse Umane'
);

select * from angajati;

select * from departamente;
select * from rapoarte_financiare;
select * from angajati;


--Mariti cu 10 numarul de pagini al cartilor publicate de editura Humanitas.
update carti
set nr_pagini = nr_pagini + 10
where id_editura = (
    select id_editura
    from edituri
    where nume = 'Humanitas'
);

--Stergeti toate rapoartele financiare coordonate de angajati din departamentul administrativ
delete from rapoarte_financiare
where id_responsabil in (
    select id_angajat
    from angajati
    where id_departament in (
        select id_departament
        from departamente
        where nume = 'Administrativ'
    )
);

commit;




--cartile cu cele mai multe exemplare
select * from carti;
select * from exemplare_carti;

insert into exemplare_carti (id_exemplar, id_carte, id_filiala, stare) 
values (seq_exemplare.nextval, 56, null, null);


select id_carte
from exemplare_carti 
group by id_carte
having count(id_exemplar) = (
                                select max(count(id_exemplar))
                                from exemplare_carti
                                group by id_carte
                                );

select * from rezervari;

select c.nume as nume_carte, e.nume as nume_editura
from carti c join edituri e on c.id_editura = e.id_editura
join exemplare_carti e on e.id_carte = c.id_carte
where e.id_exemplar in (
    select i.id_exemplar
    from imprumuturi i join utilizator u on i.id_utilizator = u.id_utilizator
    where u.nume = 'Popescu'
    and i.id_exemplar = e.id_exemplar
);


with rezervari_recente as (
    select id_utilizator, max(data_rezervare) as ultima_rezervare
    from rezervari
    group by id_utilizator
)
select u.nume || ' ' || u.prenume as nume_complet, to_char(rr.ultima_rezervare, 'MM') as luna_ultima_rezervare, to_char(rr.ultima_rezervare, 'YYYY') as anul_ultima_rezervare,
       case
           when rr.ultima_rezervare >= add_months(sysdate, -12) then 'A facut rezervari în ultimul an'
           else 'Nu a facut rezervari în ultimul an'
       end as status_rezervari
from utilizator u
left join rezervari_recente rr on u.id_utilizator = rr.id_utilizator;


update angajati
set salariu = salariu * 1.10
where id_departament = (
    select id_departament
    from departamente
    where nume = 'Resurse Umane'
);

delete from rapoarte_financiare
where id_responsabil in (
    select id_angajat
    from angajati
    where id_departament in (
        select id_departament
        from departamente
        where nume = 'Administrativ'
    )
);
rollback;
select * from rapoarte_financiare;
commit;

select *
from (
    select u.id_utilizator, u.nume, u.prenume,count(i.id_imprumut) as numar_imprumuturi
    from utilizator u join imprumuturi i on u.id_utilizator = i.id_utilizator
    group by u.id_utilizator, u.nume, u.prenume
    order by numar_imprumuturi desc
) 
where rownum <= 5;



--6Sa se creeze un subprogram stocat 
--care sa genereze un raport despre cartile imprumutate, 
--utilizatorii implicati si starea exemplarelor împrumutate. 



CREATE OR REPLACE TYPE t_id_carti IS TABLE OF NUMBER; 
/
CREATE OR REPLACE TYPE t_utilizatori IS TABLE OF VARCHAR2(100); 
/
CREATE OR REPLACE TYPE t_stare_exemplare IS VARRAY(100) OF VARCHAR2(20); 
/

CREATE OR REPLACE PROCEDURE raport_imprumuturi IS
    v_id_carti t_id_carti;                
    v_utilizatori t_utilizatori;          
    v_stare_exemplare t_stare_exemplare;  

    CURSOR c_imprumuturi IS 
        SELECT ID_EXEMPLAR 
        FROM IMPRUMUTURI;

    CURSOR c_utilizatori IS 
        SELECT NUME || ' ' || PRENUME AS NUME_COMPLET
        FROM UTILIZATOR;

    CURSOR c_stare IS 
        SELECT NVL(STARE, 'necunoscut') AS STARE 
        FROM EXEMPLARE_CARTI;

BEGIN
    v_id_carti := t_id_carti();
    v_utilizatori := t_utilizatori();
    v_stare_exemplare := t_stare_exemplare();

    OPEN c_imprumuturi;
    FETCH c_imprumuturi BULK COLLECT INTO v_id_carti;
    CLOSE c_imprumuturi;

    OPEN c_utilizatori;
    FETCH c_utilizatori BULK COLLECT INTO v_utilizatori;
    CLOSE c_utilizatori;

    OPEN c_stare;
    FETCH c_stare BULK COLLECT INTO v_stare_exemplare;
    CLOSE c_stare;

    DBMS_OUTPUT.PUT_LINE('Raport carti împrumutate:');
    FOR i IN 1 .. v_id_carti.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('ID Carte: ' || v_id_carti(i));
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Detalii Utilizatori:');
    FOR i IN 1 .. v_utilizatori.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Utilizator: ' || v_utilizatori(i));
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Stare Exemplare:');
    FOR i IN 1 .. v_stare_exemplare.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Stare: ' || v_stare_exemplare(i));
    END LOOP;
END raport_imprumuturi;
/

BEGIN
    raport_imprumuturi;
END;
/


SELECT * 
FROM EXEMPLARE_CARTI
WHERE STARE IS NULL;

--7Se doreste realizarea unui raport despre cartile împrumutate 
--dintr-o biblioteca, folosind doua tipuri de cursoare. 
--Un cursor parametrizat va afisa detalii despre 
--utilizatorii care au împrumutat anumite carti, iar celalalt 
--cursor principal va furniza informatiile generale despre cartile împrumutate. 
--Subprogramul trebuie sa prelucreze datele astfel încât sa afiseze pentru fiecare 
--carte împrumutata lista utilizatorilor care au împrumutat exemplarele respective.

CREATE OR REPLACE PROCEDURE raport_carti_imprumutate IS
   CURSOR c_carti IS
      SELECT DISTINCT ID_CARTE
      FROM EXEMPLARE_CARTI;
   
   CURSOR c_utilizatori(p_id_carte EXEMPLARE_CARTI.ID_CARTE%TYPE) IS
      SELECT DISTINCT i.ID_UTILIZATOR
      FROM IMPRUMUTURI i
      JOIN EXEMPLARE_CARTI e ON i.ID_EXEMPLAR = e.ID_EXEMPLAR
      WHERE e.ID_CARTE = p_id_carte;

   v_id_carte EXEMPLARE_CARTI.ID_CARTE%TYPE;
   v_id_utilizator IMPRUMUTURI.ID_UTILIZATOR%TYPE;

BEGIN
   FOR r_carte IN c_carti LOOP
      v_id_carte := r_carte.ID_CARTE;
      DBMS_OUTPUT.PUT_LINE('ID Carte: ' || v_id_carte);
      DBMS_OUTPUT.PUT_LINE('Utilizatori care au imprumutat cartea:');

      OPEN c_utilizatori(v_id_carte);
      LOOP
         FETCH c_utilizatori INTO v_id_utilizator;
         EXIT WHEN c_utilizatori%NOTFOUND;

         DBMS_OUTPUT.PUT_LINE('   ID Utilizator: ' || v_id_utilizator);
      END LOOP;
      CLOSE c_utilizatori;

      DBMS_OUTPUT.PUT_LINE('------------------------');
   END LOOP;
END raport_carti_imprumutate;
/

BEGIN
   raport_carti_imprumutate;
END;
/

--8Se doreste crearea unei functii stocate independente care sa 
--determine numele autorului si categoria unei carti, 
--pe baza unui ID utilizator care a imprumutat o carte. 
--Functia trebuie sa foloseasca date din 3 tabele:


CREATE OR REPLACE FUNCTION obtine_autor_si_categorie(p_id_utilizator IMPRUMUTURI.ID_UTILIZATOR%TYPE)
RETURN VARCHAR2 IS
   v_id_carte EXEMPLARE_CARTI.ID_CARTE%TYPE;
   v_autor CARTI.AUTOR%TYPE;
   v_categorie CARTI.CATEGORIE%TYPE;
   v_rezultat VARCHAR2(200);

   ex_nicio_carte EXCEPTION;
   ex_conflict_date EXCEPTION;

BEGIN
   SELECT e.ID_CARTE 
   INTO v_id_carte
   FROM IMPRUMUTURI i
   JOIN EXEMPLARE_CARTI e ON i.ID_EXEMPLAR = e.ID_EXEMPLAR
   WHERE i.ID_UTILIZATOR = p_id_utilizator;

   SELECT AUTOR, CATEGORIE
   INTO v_autor, v_categorie
   FROM CARTI
   WHERE ID_CARTE = v_id_carte;

   v_rezultat := 'Autor: ' || v_autor || ', Categoria: ' || v_categorie;

   RETURN v_rezultat;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      RETURN 'Eroare: Utilizatorul nu a imprumutat nicio carte.';
   WHEN TOO_MANY_ROWS THEN
      RETURN 'Eroare: Date conflictuale - utilizatorul are mai multe imprumuturi simultane.';
   WHEN OTHERS THEN
      RETURN 'Eroare neprevazuta: ' || SQLERRM;
END obtine_autor_si_categorie;
/

DECLARE
   v_rezultat VARCHAR2(200);
BEGIN
   v_rezultat := obtine_autor_si_categorie(315); 
   DBMS_OUTPUT.PUT_LINE(v_rezultat);
END;
/

select * from utilizator;

--9Se doreste crearea unei proceduri stocate independente care sa genereze 
--un raport al cartilor imprumutate de utilizatori, incluzand urmatoarele informatii:
---Numele utilizatorului,
---Numele cartii,
---Autorul,
---Categoria cartii,
---Filiala de unde s-a facut imprumutul.
--Procedura trebuie sa primeasca doi parametri:
---p_id_filiala - ID-ul filialei pentru care se doreste raportul.
---p_data_start - Data de inceput pentru intervalul de imprumuturi.

CREATE OR REPLACE PROCEDURE raport_carti_imprumutate (
    p_id_filiala IN NUMBER,
    p_data IN DATE
) IS
    v_filiala FILIALE.NUME%TYPE;
    v_nume_utilizator UTILIZATOR.NUME%TYPE;
    v_nume_carte CARTI.NUME%TYPE;
    v_autor CARTI.AUTOR%TYPE;
    v_categorie CARTI.CATEGORIE%TYPE;

    CURSOR c_raport IS
        SELECT U.NUME AS utilizator, C.NUME AS carte, C.AUTOR, C.CATEGORIE, F.NUME AS filiala
        FROM IMPRUMUTURI I
        JOIN EXEMPLARE_CARTI EC ON I.ID_EXEMPLAR = EC.ID_EXEMPLAR
        JOIN UTILIZATOR U ON I.ID_UTILIZATOR = U.ID_UTILIZATOR
        JOIN CARTI C ON EC.ID_CARTE = C.ID_CARTE
        JOIN FILIALE F ON EC.ID_FILIALA = F.ID_FILIALA
        WHERE EC.ID_FILIALA = p_id_filiala
        AND I.DATA_IMPRUMUT >= p_data;

    ex_filiala_inexistenta EXCEPTION;
    ex_nicio_inregistrare EXCEPTION;

BEGIN
    BEGIN
        SELECT NUME 
        INTO v_filiala
        FROM FILIALE
        WHERE ID_FILIALA = p_id_filiala;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE ex_filiala_inexistenta;
    END;

    OPEN c_raport;
    FETCH c_raport INTO v_nume_utilizator, v_nume_carte, v_autor, v_categorie, v_filiala;

    IF c_raport%NOTFOUND THEN
        RAISE ex_nicio_inregistrare;
    END IF;

    DBMS_OUTPUT.PUT_LINE('Raport pentru filiala: ' || v_filiala);
    LOOP
        DBMS_OUTPUT.PUT_LINE('Utilizator: ' || v_nume_utilizator || 
                             ', Carte: ' || v_nume_carte || 
                             ', Autor: ' || v_autor || 
                             ', Categoria: ' || v_categorie);
        FETCH c_raport INTO v_nume_utilizator, v_nume_carte, v_autor, v_categorie, v_filiala;
        EXIT WHEN c_raport%NOTFOUND;
    END LOOP;
    CLOSE c_raport;

EXCEPTION
    WHEN ex_filiala_inexistenta THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: Filiala cu ID-ul ' || p_id_filiala || ' nu exista.');
    WHEN ex_nicio_inregistrare THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: Nu exista imprumuturi inregistrate pentru filiala specificata in intervalul dat.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Eroare neprevazuta: ' || SQLERRM);
END raport_carti_imprumutate;
/

BEGIN
    raport_carti_imprumutate(340, TO_DATE('2024-01-01', 'YYYY-MM-DD'));
END;
/

select * from filiale;


--10Se doreste implementarea unui mecanism care sa inregistreze automat 
--toate operatiile de tip INSERT, UPDATE si DELETE efectuate asupra 
--tabelei IMPRUMUTURI, intr-un jurnal special destinat monitorizarii modificarilor. 
--In acest jurnal se vor inregistra detalii precum tipul operatiei, numele tabelei afectate, 
--data modificarii si utilizatorul care a efectuat operatia. 
--Acest mecanism va fi realizat printr-un trigger LMD la nivel de comanda, 
--iar rezultatele vor putea fi consultate intr-o tabela separata de tip jurnal.
CREATE TABLE LOG_MODIFICARI (
    ID_LOG NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    OPERATIE VARCHAR2(10),
    NUME_TABELA VARCHAR2(50),
    DATA_MODIFICARE DATE,
    UTILIZATOR VARCHAR2(50)
);

CREATE OR REPLACE TRIGGER TRIGGER_LOG_IMPRUMUTURI
AFTER INSERT OR UPDATE OR DELETE ON IMPRUMUTURI
BEGIN
    IF INSERTING THEN
        INSERT INTO LOG_MODIFICARI (OPERATIE, NUME_TABELA, DATA_MODIFICARE, UTILIZATOR)
        VALUES ('INSERT', 'IMPRUMUTURI', SYSDATE, USER);
    END IF;

    IF UPDATING THEN
        INSERT INTO LOG_MODIFICARI (OPERATIE, NUME_TABELA, DATA_MODIFICARE, UTILIZATOR)
        VALUES ('UPDATE', 'IMPRUMUTURI', SYSDATE, USER);
    END IF;

    IF DELETING THEN
        INSERT INTO LOG_MODIFICARI (OPERATIE, NUME_TABELA, DATA_MODIFICARE, UTILIZATOR)
        VALUES ('DELETE', 'IMPRUMUTURI', SYSDATE, USER);
    END IF;
END;
/
insert into EDITURI (id_editura, nume, email) 
values (seq_edituri.nextval, 'test', 'contact@test.ro');

select * from utilizator;
select * from exemplare_carti;
select * from imprumuturi;

insert into imprumuturi (id_imprumut, id_exemplar, id_utilizator, data_imprumut, data_scadenta) 
values (seq_imprumuturi.nextval, 105, 315, sysdate - 20, sysdate + 10);

UPDATE IMPRUMUTURI
SET DATA_SCADENTA = SYSDATE + 10
WHERE ID_IMPRUMUT = 267;

DELETE FROM IMPRUMUTURI
WHERE ID_IMPRUMUT = 267;

SELECT * FROM LOG_MODIFICARI;

--11

CREATE TABLE JURNAL_IMPRUMUTURI (
    ID_LOG NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    ID_IMPRUMUT NUMBER,
    OPERATIE VARCHAR2(10),
    DATA_MODIFICARE DATE,
    UTILIZATOR VARCHAR2(50)
);

CREATE OR REPLACE TRIGGER TRIGGER_LMD_IMPRUMUTURI
AFTER INSERT OR UPDATE OR DELETE ON IMPRUMUTURI
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO JURNAL_IMPRUMUTURI (ID_IMPRUMUT, OPERATIE, DATA_MODIFICARE, UTILIZATOR)
        VALUES (:NEW.ID_IMPRUMUT, 'INSERT', SYSDATE, USER);
    END IF;

    IF UPDATING THEN
        INSERT INTO JURNAL_IMPRUMUTURI (ID_IMPRUMUT, OPERATIE, DATA_MODIFICARE, UTILIZATOR)
        VALUES (:NEW.ID_IMPRUMUT, 'UPDATE', SYSDATE, USER);
    END IF;

    IF DELETING THEN
        INSERT INTO JURNAL_IMPRUMUTURI (ID_IMPRUMUT, OPERATIE, DATA_MODIFICARE, UTILIZATOR)
        VALUES (:OLD.ID_IMPRUMUT, 'DELETE', SYSDATE, USER);
    END IF;
END;
/

insert into imprumuturi (id_imprumut, id_exemplar, id_utilizator, data_imprumut, data_scadenta) 
values (seq_imprumuturi.nextval, 105, 315, sysdate - 20, sysdate + 10);

select * from imprumuturi;

UPDATE IMPRUMUTURI
SET DATA_SCADENTA = SYSDATE + 10
WHERE ID_IMPRUMUT = 268;

DELETE FROM IMPRUMUTURI
WHERE ID_IMPRUMUT = 268;

SELECT * FROM JURNAL_IMPRUMUTURI;


--12

CREATE TABLE JURNAL_LDD (
    ID_LOG NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    OPERATIE VARCHAR2(50),
    TIP_OBIECT VARCHAR2(50),
    NUME_OBIECT VARCHAR2(100),
    DATA_MODIFICARE DATE,
    UTILIZATOR VARCHAR2(50)
);


CREATE OR REPLACE TRIGGER TRIGGER_LDD_OPERATIONS
AFTER CREATE OR ALTER OR DROP ON SCHEMA
BEGIN
    INSERT INTO JURNAL_LDD (OPERATIE, TIP_OBIECT, NUME_OBIECT, DATA_MODIFICARE, UTILIZATOR)
    VALUES (
        ORA_SYSEVENT, 
        ORA_DICT_OBJ_TYPE, 
        ORA_DICT_OBJ_NAME, 
        SYSDATE, 
        USER 
    );
END;
/

CREATE TABLE TEST_TABLE (
    ID NUMBER,
    NAME VARCHAR2(50)
);

ALTER TABLE TEST_TABLE AGE NUMBER;
DROP TABLE TEST_TABLE;

SELECT * FROM JURNAL_LDD;

SHOW PARAMETER memory;
SELECT * FROM v$sga;
SELECT * FROM v$pgastat;

SHOW PARAMETER sga_target;
SHOW PARAMETER pga_aggregate_target;


SELECT component, current_size, min_size, max_size FROM v$sga_dynamic_components;

SELECT * FROM user_role_privs;

SHOW PARAMETER memory;

SELECT name, value 
FROM v$parameter 
WHERE name LIKE '%memory%';








