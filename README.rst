About
=====

An automated workflow for creating assignments for our `ACS`_ students, their
deployment and examination.

.. _`ACS`: http://www.acs.uns.ac.rs/

Installation
============

`Use this repository template`_ to create a new repository named::

    pjisp-{SCHOOL_YEAR}-{COURSE_ID}-{TEST_ID}-{GROUP_ID}

where:

``{SCHOOL_YEAR}``
    School year, for example ``2019``.

``{COURSE_ID}``
    Course id, can be ``E214`` for the winter semester or ``E111`` for summer.

``{TEST_ID}``
    Test id, can be ``T12``, ``T34`` or ``SOV``.

``{GROUP_ID}``
    Student group id, for example ``G10``.

    It can be within the range of ``G1`` to ``G13`` for the winter semester, or
    ``G1`` to ``G10`` for summer. In general, the student groups are assigned
    in accordance to their weekly lab schedule.

When creating your assignment repository please:

- make sure the repository is set to **private** access
- add your professor(s) as repository collaborator(s)

This project doesn't require system wide installation, simply clone your newly
created repository to get started::

    $ git clone https://github.com/your-account/ASSIGNMENT_ID.git
    $ cd ASSIGNMENT_ID

If you do not wish to install Python, pip or Pipenv on your system you can use
the dockerized version of this project instead, by replacing all your ``make``
calls, such as::

    $ pipenv run make [TARGET] [quiet=1] ...

with::

    $ ./dockerized.sh [TARGET] [quiet=1] ...

.. _`Use this repository template`: https://github.com/petarmaric/pjisp-assignment-template/generate

Usage
=====

Show help
---------

::

    $ pipenv run make help

    # dockerized version:
    $ ./dockerized.sh help

    Usage: make [TARGET] [quiet=1] ...

    Targets:
      help              Display this help message
      init              Initialize the assignment template
      test-solution     Test your assignment solution
      assignment-clean  Remove all generated student assignment files
      assignment-build  Build the student assignment PDF
      assignment-view   View the student assignment PDF
      assignment-pack   Pack the student assignment
      assignment        Build, view and pack the student assignment
      extract-exams     Extract student assignments from exam archives
      examine           Examine student assignment

Using ``make TARGET quiet=1`` will make most of the targets to be quiet,
showing only warnings and errors.

Initialize the assignment template
----------------------------------

Before creating an assignment you need to initialize the assignment template::

    $ pipenv install
    $ pipenv run make init template=TEST_ID

    # dockerized version:
    $ ./dockerized.sh init template=TEST_ID

where ``TEST_ID`` can be ``T12``, ``T34`` or ``SOV``.

Create a student assignment
---------------------------

#. in general, your assignment should follow the form of `existing PJISP zbirka assignments`_

#. create your assignment, while keeping in mind you should not edit any files other than:

   #. ``assignment.rst``, where you enter the assignment text
   #. ``assignment_solution.c``, where you enter the assignment solution (will not be shared with students)
   #. ``fixtures/*.yaml``, where you enter the assignment tests (will be shared with students)

#. build (and check) your assignment text often as you write::

    $ pipenv run make assignment-view

    # dockerized version: 'assignment-view' won't work, please open the built PDF yourself
    $ ./dockerized.sh assignment-build

#. test your assignment solution::

    $ pipenv run make test-solution

    # dockerized version:
    $ ./dockerized.sh test-solution

#. pack your assignment into an archive and prepare if for deployment to the ACS labs::

    $ pipenv run make assignment-pack

    # dockerized version:
    $ ./dockerized.sh assignment-pack

#. push commits onto your assignment repository

#. inform the professor(s) that your assignment repository is ready for review

.. _`existing PJISP zbirka assignments`: http://pjisp.petarmaric.com/zbirka-zadataka

Deploy student assignments to the ACS labs
------------------------------------------

These steps should be performed within the ACS labs:

#. extract the ``assignment_packed_for_students *.tar.gz`` archive into
   ``ispitni_materijaliA/.eXXXXX/`` and ``ispitni_materijaliB/.eXXXXX/``

#. ask the administrator to switch the lab to the "exam" mode (aka "provera")

#. wait for all of the students to login

#. verify the identity of all students

#. instruct the students to:

   #. locate the ``assignment.c`` file in their ``$HOME/$STUDENT_ID``
      directory

   #. update the contents of the file with their own solution

   #. test their solution as often as possible, be it manually or via ``smoke_test``

   #. save the file and close the editor

   #. logout

#. ask the administrator to collect the exam ``.tar`` archive and switch the lab
   to the "normal" mode

Next, save the collected exam archive onto your computer for later student
assignment extraction and examination.

Extract student assignments from exam archives
----------------------------------------------

#. copy the collected exam archive into ``archives/``

#. extract student assignments, while taking special note of any errors or warnings::

    $ pipenv run make extract-exams

    # dockerized version:
    $ ./dockerized.sh extract-exams

Automated student assignment examination
----------------------------------------

Examine (and then grade) each student assignment::

    $ pipenv run make examine computer=COMPUTER

    # dockerized version:
    $ ./dockerized.sh examine computer=COMPUTER

where ``COMPUTER`` is within the range of ``s100`` to ``s131``, or ``s200`` to
``s231`` (depending on the ACS lab).

Finally, publish the exam results to the ACS site within the PJISP news section.

Contribute
==========

If you find any bugs, or wish to propose new features `please let us know`_.

If you'd like to contribute, simply fork `the repository`_, commit your changes
and send a pull request. Make sure you add yourself to `CONTRIBUTORS`_.

.. _`please let us know`: https://github.com/petarmaric/pjisp-assignment-template/issues/new
.. _`the repository`: https://github.com/petarmaric/pjisp-assignment-template
.. _`CONTRIBUTORS`: https://github.com/petarmaric/pjisp-assignment-template/blob/master/CONTRIBUTORS
