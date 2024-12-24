#!/bin/bash 

# Usuario y contraseña
USERNAME="anon"
PASSWORD="voidlinux"

# Obtener las direcciones IP configuradas usando `ip addr`

IP_LIST=$(ip addr | grep 'inet ' | awk '{print $2}' |fzf -m) 

for SUBNET in $IP_LIST; do
  # Determinar la subred /24

  echo "Escaneando la red: $SUBNET"
  
  # Escanear la red para encontrar hosts con el puerto SSH (22) abierto
  HOSTS=$(nmap -p 22 --open -n $SUBNET | grep -Eo '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b')

  for HOST in $HOSTS; do
    echo "Probando conexión SSH en $HOST..."

    # Intentar iniciar sesión con las credenciales proporcionadas
    sshpass -p "$PASSWORD" ssh -o StrictHostKeyChecking=no -o ConnectTimeout=5 $USERNAME@$HOST exit 2>/dev/null

    if [ $? -eq 0 ]; then
      echo "¡Conexión exitosa en $HOST con $USERNAME:$PASSWORD!"
    else
      echo "No se pudo autenticar en $HOST."
    fi
  done
done