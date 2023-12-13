echo "Actualizando repositorios..."
sudo apt -y update
sudo apt -y upgrade

echo "Instalando servidor nfs..."
sudo apt install -y nfs-kernel-server

echo "Instalando motor php fpm..."

sudo apt install -y php-fpm

sudo apt install -y php-mysql