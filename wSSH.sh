#!/bin/sh

linha=0
auxLinha=0
confirmacao=""
nome=""
host=""
user=""
pass=""
port=""


# Função responsável por montar o cabeçalho
header(){
 clear
 echo " -----------------------------------------------------"
 echo "|                      wSSH v0.1                      |"
 echo "|            Gerenciador de credenciais SSH           |"
 echo "|     (c) William Costa - william@wapstore.com.br     |"
 echo " -----------------------------------------------------"
}


# Função responsável por montar e gerenciar as opções do menu
menu(){
  opcao = ""
  header
  echo "Menu principal:"
  echo "1 - Conectar a um cliente existente";
  echo "2 - Gravar um novo cliente";
  echo "3 - Excluir cliente";
  echo "0 - Sair";
  echo
  echo -n "Digite a opção desejada:"
  read opcao

  if [ "$opcao" -eq "0" ]; then
    echo "Bye"
  elif [ "$opcao" -eq "1" ]; then
    conectar
  elif [ "$opcao" -eq "2" ]; then
    gravar
  elif [ "$opcao" -eq "3" ]; then
    excluir
  else
    menu
  fi
}


# Função responsável por listar os clientes
listarClientes(){
  auxLinha=`expr 0`
  for line in $(cat ~/.wssh/hosts.w);
  do
    auxLinha=`expr $auxLinha + 1`
    nome=$(echo $line | awk -F "," '{print $1}');
    host=$(echo $line | awk -F "," '{print $2}');
    echo $auxLinha" - "$nome" ("$host")"
  done
}

# Função responsável por conectar um ssh
conectar(){
 header
 echo "Conectar a um cliente"
 listarClientes
 auxLinha=`expr 0`
 linha=`expr 0`
 echo 
 echo -n "Digite o número do cliente (0 para voltar ao menu): "
 read linha
 if [ "$linha" -eq "0" ]; then
  menu
 else
  for line in $(cat ~/.wssh/hosts.w);
  do
    auxLinha=`expr $auxLinha + 1`
    if [ "$auxLinha" -eq "$linha" ]; then
      clear
      host=$(echo $line | awk -F "," '{print $2}');
      port=$(echo $line | awk -F "," '{print $3}');
      pass=$(echo $line | awk -F "," '{print $4}');
      user=$(echo $line | awk -F "," '{print $5}');
      eval "sshpass -p '"$pass"' ssh -oStrictHostKeyChecking=no "$user"@"$host" -p "$port
      echo -n "Pressione qualquer tecla para voltar ao wSSH..."
      read linha
    fi
  done
  conectar
 fi
}

# Função responsável por gravar um novo cliente
gravar(){
 header
 echo "Novo cliente"
 echo -n "Digite o nome do novo cliente (0 para voltar ao menu): ";
 read nome
 if [ "$nome" = "0" ]; then
  menu
 else
  echo -n "Digite o host: ";
  read host
  echo -n "Digite a porta: ";
  read port
  echo -n "Digite o usuário: ";
  read user
  echo -n "Digite a senha: ";
  read pass
  echo $nome","$host","$port","$pass","$user >> ~/.wssh/hosts.w
  conectar
 fi
}

# Função responsável por excluir clientes
excluir(){
 header
 echo "Excluir um cliente"
 listarClientes
 auxLinha=`expr 0`
 linha=`expr 0`
 echo
 echo -n "Digite o número do cliente a ser excluído (0 para voltar ao menu): "
 read linha
 if [ "$linha" -eq "0" ]; then
   menu
 else
   echo "Deseja realmente excluir o cliente "$linha"? (s/n)"
   read confirmacao
   if [ "$confirmacao" = "s" ]; then
     eval "sed -i "$linha"d ~/.wssh/hosts.w"
     menu
   else
     excluir
   fi
 fi
}

# Função responsável por verificar se o arquivo de hosts existe
verificarArquivoHost(){
 if [ ! -e ~/.wssh ]; then
   eval 'mkdir ~/.wssh'
 fi
 if [ ! -e ~/.wssh/hosts.w ]; then
   eval '> ~/.wssh/hosts.w'
 fi
}

verificarArquivoHost
menu

