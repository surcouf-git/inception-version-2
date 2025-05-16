#!/bin/bash

# Vérifier si la base de données existe déjà
if [ ! -d "/var/lib/mysql/mysql" ]; then
    # Initialiser MariaDB
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    # Démarrer MariaDB temporairement
    /usr/bin/mysqld_safe --datadir=/var/lib/mysql &
    
    # Attendre que MariaDB soit disponible
    until mysqladmin ping &>/dev/null; do
        echo "Attente de MariaDB..."
        sleep 1
    done
    
# Configurer MariaDB
    mysql -u root << EOF
# Supprimer les utilisateurs anonymes
DELETE FROM mysql.user WHERE User='';
# Supprimer l'accès distant à root
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
# Supprimer la base de test
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
# Créer la base de données WordPress
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
# Créer l'utilisateur WordPress avec tous les privilèges sur cette base
CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
# Définir le mot de passe root
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
# Appliquer les changements
FLUSH PRIVILEGES;
EOF

    # Arrêter MariaDB proprement
    mysqladmin -u root -p${DB_ROOT_PASSWORD} shutdown
    
    echo "Base de données initialisée avec succès."
else
    echo "La base de données existe déjà, pas besoin d'initialisation."
fi

# Démarrer MariaDB en premier plan pour que le conteneur reste actif
exec mysqld_safe
