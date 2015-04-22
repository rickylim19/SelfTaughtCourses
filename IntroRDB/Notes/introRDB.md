# What is database?

Relational databases feature:

* Persistent storage
* Concurrent access
* Flexible query language with aggregation and join
* Constraints, rules to protect the consistency of the data

Anatomy of a table:

* Header: tableName, column name & type
* Body: rows, and columns

Basic query language:

* SELECT `->` columns FROM a tableName
* WHERE `->` restrictions on the rows 

    ## Example of Query Syntax
    #
    ##animals:
    ##name   species   birthdate
    ##Max    gorilla   2001-04-13
    ##Sue    gorilla   1998-06-12
    ##Max    moose     2012-02-20
    #
    ##diet:
    ##species   food
    ##gorilla   fish
    ##gorilla   meat
    ##moose     fish

    # question:
    ##  How many individuals animals eat fish?
    ## 
    ## Joining table
    ##
    ## Select animals.name, animals.species, diet.food
    ## from animals join diet on animals.species = diet.species
    ## where food = 'fish';
    ##
    ##name   species   food
    ##Max    gorilla   fish
    ##Max    gorilla   meat
    ##Sue    gorilla   fish
    ##SUe    gorilla   meat
    ##...
    ##

# Types of SQL

* `text`            : a string
* `char(n)`         : a string of exactly n characters
* `varchar(n)`      : a string of up to n characters
* `integer`         : int 
* `real`            : float
* `double precision`: more accurate floating point up to 15 decimals
* `decimal`         : an exact decimal value
* `time`            : a time of day
* `timestamp`       : a date and time together
* `date`            : a calendar date, e.g `2014-11-19`
* note: "2014-11-19" is interpreted as text or date but
2014-11-19 is interpreted as integer

## Select Where Statement

select                      `->` keyword
|
name, birthdate             `->` columns
|
from                        `->` keyword
|
animals                     `->` tables
|
where species = 'gorilla'   `->` row restriction
  and name = 'Max'; 
  
## creating table animals

    create table animals (
        name text,
        species text,
        birthdate date
    );

## Select NOT

    select name from animals where
        (not species = 'gorilla') and (not name = 'Max');

    select name from animals where
        not(species = 'gorilla' or name = 'max');
        
    select name from animals where
        species != 'gorilla' and name != 'max';
    
### Question: find the llamas that were born between 01/01/1995 and 31/12/1998

    select name from animals where
        species = 'llamas' and
        birthdate >= '1995-01-01' and
        birthdate <= '1998-12-31';
        
## The one thing SQL sucks at

Listing your tables and columns in a standard way

* PostgreSQL: \dt and \d tablename
* MySQL: show tables and describe tablename
* SQLite: .tables and .schema tablename
* 

### Tables in this course

All the tables in the zoo database

####animals

This table lists individual animals in the zoo. Each animal has only one row. There may be multiple animals with the same name, or even multiple animals with the same name and species.

name — the animal's name (example: 'George')
species — the animal's species (example: 'gorilla')
birthdate — the animal's date of birth (example: '1998-05-18')

####diet

This table matches up species with the foods they eat. Every species in the zoo eats at least one sort of food, and many eat more than one. If a species eats more than one food, there will be more than one row for that species.

species — the name of a species (example: 'hyena')
food — the name of a food that species eats (example: 'meat')

####taxonomy

This table gives the (partial) biological taxonomic names for each species in the zoo. It can be used to find which species are more closely related to each other evolutionarily.

name — the common name of the species (e.g. 'jackal')
species — the taxonomic species name (e.g. 'aureus')
genus — the taxonomic genus name (e.g. 'Canis')
family — the taxonomic family name (e.g. 'Canidae')
t_order — the taxonomic order name (e.g. 'Carnivora')
If you've never heard of this classification, don't worry about it; the details won't be necessary for this course. But if you're curious, Wikipedia articles Taxonomy and Biological classification may help.

####ordernames

This table gives the common names for each of the taxonomic orders in the taxonomy table.

t_order — the taxonomic order name (e.g. 'Cetacea')
name — the common name (e.g. 'whales and dolphins')

#### ZOO database in SQL

    create table animals (  
       name text,
       species text,
       birthdate date);

    create table diet (
        species text,
        food text);  

    create table taxonomy (
        name text,
        species text,
        genus text,
        family text,
        t_order text); 

    create table ordernames (
        t_order text,
        name text);

#### Example of SQL query

    QUERY = "select max(name) from animals;"

    QUERY = "select * from animals limit 10;"

    QUERY = "select * from animals where species = 'orangutan' order by birthdate;"

    QUERY = "select name from animals where species = 'orangutan' order by birthdate desc;"

    QUERY = "select name, birthdate from animals order by name limit 10 offset 20;"

    QUERY = "select species, min(birthdate) from animals group by species;"

    QUERY = '''
    select name, count(*) as num from animals
    group by name
    order by num desc
    limit 5;
    '''

#### Select clauses in SQL

    LIMIT count [OFFSET skip]
    # count: how many rows to return
    # skip: how far into the result to start

    # e.g
    # LIMIT 10 OFFSET 150
    ## return 10 rows, starting with the 151st row

    ORDER BY columns [DESC]
    # columns: which columns to sort by, separated with commas
    # DESC: sort in reverse order (descending)

    # e.g
    # ORDER BY species, name 
    ## sort result rows first by the species column,
    ## then within each species, sort by the name column

    GROUP BY columns
    # columns: which columns to use as groupings when aggregating
    # aggregation function, such as `max`, `count`, `sum`
    
    # e.g
    # SELECT species, min(birthdate) from
    # animals GROUP BY species;
    ## for each species of animal, find 
    ## the smallest value of the birthdate column,
    ## that is, the oldest animals birthdate

    # e.g to find how common different names in zoo database
    # select name, count(*) as num from animals
    # GROUP BY name;
    ## count(*): count all the rows
    ## as num: call the count column as num
    ## GROUP BY name: aggregate by values of the name column



    
            
