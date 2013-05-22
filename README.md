oracle-ecommerce
================

Base de donnée Oracle distribuée avec fragmentation verticale, horizontale, horizontale dérivée et réplication de données

Deploiement
-----------

Le depôt comprend différentes configurations pour les serveurs à deployer :

* **servers/ecommerce.fr** : Configuration du serveur local.
* **servers/ecommerce.us** : Configuration d'un serveur distant pour l'internationalisation de l'application avec fragmentation verticale.
* **servers/ecommerce.secure** : Configuration d'un serveur distant pour la fragmentation verticale des données sensibles

Il est possible de deployer toutes ces definitions sur leur serveurs respectifs grâce à la commande :

    ./deploy

Chacune des ces configurations comprend les scripts suivants :

* `./configure` : A éxecuter sur un poste client pour la configuration des routes de la machine virtuelle (développment)
* `. ./profile` : Permet l'initialisation de l'environemment sur le serveur
* `./setup` : Migrer les fichiers de configuration, créer la base de données, le comptes, les privileges et les alias.
* `./start` : Permet le démarrage du serveur oracle et du listener de port.
* `./stop` : Permet l'arrête du seveur oracle et du listener de port.
* `./migrate` : Migrer les tables, les indexes, les synonymes, les vues, les séquences, les triggers et le procédures
* `./seed` : Permet l'imporation de données examples pour le tester le système.
* `./test` : Execute un jeu de requêtes de test pour valider le bon fonctionnement du système.

