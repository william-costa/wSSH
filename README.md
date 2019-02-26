# wSSH

```
 -----------------------------------------------------
|                      wSSH v0.1                      |
|            Gerenciador de credenciais SSH           |
|     (c) William Costa - william@wapstore.com.br     |
 -----------------------------------------------------
 Menu principal:
 1 - Conectar a um cliente existente
 2 - Gravar um novo cliente
 3 - Excluir cliente
 0 - Sair

 Digite a opção desejada:
```


Simples gerenciador de senhas SSH para linux escrito em shell.

É necessário ter o pacote **sshpass** instalado para que a conexão funcione.

____

Para utilizar o gerenciador, abra o terminal e execute os comandos abaixo:


**Dê permissões de execução para o arquivo** 
```
chmod +x wSSH.sh
```

**Execute o arquivo** 
```
./wSSH.sh
```

**Conecte-se diretamente a um SSH cadastrado**
Se você conhece o ID do cliente cadastrado (para verificar acesse a opção 1 e veja o ID de cada SSH cadastrado), basta chamar o script passando o ID como argumento:
```
./wSSH.sh 10
```
____

Melhorias são bem-vindas!
