# pgwatch: PostgreSQL monitoring solution

![pgwatch typical deployment architecture diagram](docs/gallery/pgwatch_architecture_no_config.png)

## Usage

1. Criar o arquivo `.env`

```shell
touch .env
```

2. Verificar quais variáveis de ambiente precisam ser definidas no `.env` - verificar output do comando.

```shell
./run.sh
```

3. Editar o arquivo `.env`, definindo todas as variáveis que forem indicadas no output do comando anterior.

4. Rodar novamente para inicializar os containers dos serviços

```shell
./run.sh
```
