# sprint2_mysql_estructura

## Learning MySQL - Creating DataBase

Repositorio creado para incluir todos los ejercicios de MySQL del sprint2 de NodeJS.

Primera entrega NIVEL 1

Cada carpeta corresponde a un ejercicio, que incluye diagrama de la base de datos, creación de base de datos, inserción de datos y queries correspondientes si se piden.
Cada carpeta incluye 2 archivos, uno con el diagrama y el archivo sql con el resto.

Los scripts de creación de la base de datos elimina previamente cualquier base de datos anterior con el mismo nombre.

**- OPTICA:**
Nivel 1, Ejercicio 1,
_Diagrama, estructura, datos y consultas_

**- PIZZERIA:**
Nivel 1, Ejercicio 2,
_Diagrama, estructura, datos y consultas_

**- YOUTUBE:**
_Nivel 2, Ejercicio 1,
Diagrama, estructura y datos_

**- SPOTIFY:**
_Nivel 3, Ejercicio 1,
Diagrama y estructura_

**Detalls EXERCICI OPTICA:**

Una òptica anomenada Cul d'Ampolla vol informatitzar la gestió dels clients i la venda d'ulleres:

En primer lloc l'òptica vol saber quin és el proveïdor de cadascuna de les ulleres. En concret vol saber de cada proveïdor el nom, l'adreça (carrer, número, pis, porta, ciutat, codi postal i país), telèfon, fax, NIF.

La política de compres de l'òptica es basa en que les ulleres d'una marca es compraran a un únic proveïdor (així en podrà treure més bons preus), però poden comprar ulleres de diverses marques a un proveïdor. De les ulleres vol saber, la marca, la graduació de cadascun dels vidres, el tipus de muntura (flotant, pasta o metàl·lica), el color de la muntura, el color dels vidres i el preu.

Dels clients vol emmagatzemar el nom, l'adreça postal, el telèfon, el correu electrònic i la data de registre. També ens demanen, quan arriba un client nou, d'emmagatzemar el client que li ha recomanat l'establiment (sempre i quan algú li hagi recomanat). El nostre sistema haurà d’indicar qui ha sigut l’empleat que ha venut cada ullera i quan.

Queries:

1. Llista el total de compres d'un client
2. Llista les diferents ulleres que ha venut un empleat durant un any
3. Llista els diferents proveïdors que han subministrat ulleres venudes amb èxit per l'òptica

**Detalls EXERCICI PIZZERIA:**

Un client t’ha contractat per dissenyar un web que permeti fer comandes de menjar a domicili per Internet:

Tingues en compte les següents indicacions per a modelar com seria la base de dades del projecte: per a cada client emmagatzemem un identificador únic, nom, cognoms, adreça, codi postal, localitat, província i número de telèfon. Les dades de localitat i província estaran emmagatzemats en taules separades. Sabem que una localitat pertany a una única província, i que una província pot tenir moltes localitats. Per cada localitat emmagatzemem un identificador únic i un nom. Per a cada província emmagatzemem un identificador únic i un nom.

Un client pot realitzar moltes comandes, però una única comanda només pot ser realitzat per un únic client. De cada comanda s'emmagatzema un identificador únic, data i hora, si la comanda és per a repartiment a domicili o per a recollir en botiga, la quantitat de productes que s'han seleccionat de cada tipus i el preu total. Una comanda pot constar d'un o diversos productes.

Els productes poden ser pizzes, hamburgueses i begudes. De cada producte s'emmagatzema: un identificador únic, nom, descripció, imatge i preu. En el cas de les pizzes existeixen diverses categories que poden anar canviant de nom al llarg de l'any. Una pizza només pot estar dins d'una categoria, però una categoria pot tenir moltes pizzes.

De cada categoria s'emmagatzema un identificador únic i un nom. Una comanda és gestionada per una única botiga i una botiga pot gestionar moltes comandes. De cada botiga s'emmagatzema un identificador únic, adreça, codi postal, localitat i província. En una botiga poden treballar molts empleats i un empleat només pot treballar en una botiga. De cada empleat s'emmagatzema un identificador únic, nom, cognoms, nif, telèfon i si treballa com a cuiner o repartidor. Per a les comandes de repartiment a domicili interessa guardar qui és el repartidor que realitza el lliurament de la comanda i la data i hora del moment del lliurament.

Queries:

1. Llista quants productes del tipus 'begudes' s'han venut en una determinada localitat
2. Llista quantes comandes ha efectuat un determinat empleat
