..
    Note for teaching assistants, you may find this introduction to reStructuredText useful:

    - https://www.sphinx-doc.org/en/1.8/usage/restructuredtext/basics.html
    - https://www.sphinx-doc.org/en/1.8/usage/restructuredtext/directives.html#math



Pih, ionako je kiselo
=====================

Iz zadate ulazne datoteke učitati podatke u jednostruko spregnutu listu, gde
struktura ``namirnica_st`` sadrži sledeća polja:

- naziv namirnice (jedna reč, do 13 karaktera)
- količina vitamina C u namirnici (mg/100g)
- vrsta namirnice (jedna reč, do 10 karaktera)

Naravno, struktura ``namirnica_st`` sadrži i polja potrebna za pravilno
formiranje jednostruko spregnute liste.

Na osnovu zadate vrste namirnice ``vrsta`` iz formirane liste upisati podatke u
zadatu izlaznu datoteku, u sledećem rasporedu polja strukture ``namirnica_st``:

- količina vitamina (koristiti ``"%3u"`` format specifikator)
- naziv namirnice (koristiti ``"%-13s"`` format specifikator)
- vrsta namirnice

i potom u istu izlaznu datoteku upisati informaciju o namirnici sa najviše
vitamina C.

Primer poziva programa::

    ./analiza voce namirnice.txt izvestaj.txt

sa ``vrsta=voce`` i zadatim ulazom u datoteci ``namirnice.txt``::

    CrvenaPaprika 190 povrce
    Grejpfrut      29 voce
    Jagoda         60 voce
    Kivi           89 voce
    Krompir        20 povrce
    Limun          40 voce
    Paradajz       10 povrce
    PilecaJetra    13 meso
    Pomorandza     50 voce
    Spanac         30 povrce

i očekivanim izlazom u datoteci ``izvestaj.txt``::

    190 CrvenaPaprika povrce
     29 Grejpfrut     voce
     60 Jagoda        voce
     89 Kivi          voce
     20 Krompir       povrce
     40 Limun         voce
     10 Paradajz      povrce
     13 PilecaJetra   meso
     50 Pomorandza    voce
     30 Spanac        povrce

    Namirnica sa najvise vitamina C je:
     89 Kivi          voce
