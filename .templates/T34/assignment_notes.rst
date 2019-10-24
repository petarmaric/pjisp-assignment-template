Test traje 120 minuta.

Savetuje se upotreba alata za automatizovanu proveru kvaliteta Vašeg rešenja::

    ./smoke_test.pex assignment.c
    ./smoke_test.pex --help

Napomene:

- programski kod mora biti snimljen u okviru home direktorijuma, na predviđenom mestu
- nije dozvoljeno snimanje više kopija ili varijacija izvornog koda, samo jedna .c datoteka
- program se **mora kompajlirati**, pri čemu kompajler ne sme ukazivati na upozorenja tokom kompajliranja
- nije dozvoljeno koristiti globalne promenljive
- organizovati kod u funkcije
- obratiti pažnju na odgovarajuće rukovanje greškama pri radu sa datotekama (ne ispisivati ništa u datoteku niti standardni izlaz):

    - Ako nije moguće otvoriti ulaznu datoteku: izaći iz programa sa ``exit(1)``
    - Ako nije moguće otvoriti izlaznu datoteku: izaći iz programa sa ``exit(2)``

- redosled argumenata komandne linije je veoma bitan i ne sme se menjati
- ukoliko je potrebno pretvoriti argument komandne linije u drugi tip podataka (npr. ``int``, ``float``) koristiti odgovarajuće funkcije za konverziju (npr. ``atoi``, ``atof``)
- podaci se čitaju isključivo iz odgovarajuće datoteke (naziv ulazne datoteke je dat kroz argument komandne linije)
- ispis rezultata rada dozvoljen je isključivo u odgovarajuću datoteku (naziv izlazne datoteke je dat kroz argument komandne linije)
