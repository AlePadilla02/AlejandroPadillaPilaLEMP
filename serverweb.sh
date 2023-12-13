echo "Actualizando repositorios..."
sudo apt -y update
sudo apt -y upgrade

echo "Instalando servidor web nginx y el cliente nfs..."

sudo apt install -y nginx
sudo apt install -y nfs-common