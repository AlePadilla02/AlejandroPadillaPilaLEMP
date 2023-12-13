echo "Actualizando repositorios..."
sudo apt -y update
sudo apt -y upgrade

echo "Instalando servidor mariadb..."

sudo apt install -y mariadb-server