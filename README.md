# Gestion Bibliotheque Python
Création d'une gestion bibliotheque en Python avec Pycharm Professional :

Lancement de la console pour le projet localhost : python manage.py runserver

Site :

Url bibliotheque : 
http://127.0.0.1:8000/bibliotheque/ 

Url membre : 
http://127.0.0.1:8000/membres/ 


Administration (Connexion obligatoire pour accéder à bibliotheque) :

Url localhost: http://127.0.0.1:8000/admin/login/?next=/admin/

Username: admin
Password: admin


Lancer un fichier sans prérequis sauf avoir installer un interpréteur Python, nous utilisons la commande : python mon_programme.py


Test unitaires avec pytest : 

pytest bibliotheque/tests/test_index.py 

pytest bibliotheque/tests/test_addmedia.py 

pytest bibliotheque/tests/test_createmember.py 

pytest bibliotheque/tests/test_listmember.py 

pytest bibliotheque/tests/test_delmember.py 

pytest bibliotheque/tests/test_listemprunt.py
