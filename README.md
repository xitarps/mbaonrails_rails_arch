Aluno: Rodrigo Pimentél Sátyro
<br>
Email: xitarps@gmail.com

# Market(Produtos)

Este é um projeto desenvolvido como parte do curso de Ruby on Rails.
O objetivo é aplicar os conceitos aprendidos em aula para criar uma aplicação web funcional, bem estruturada e com boas práticas de desenvolvimento.

Aqui temos uma Api que cadastra, apresenta, edita e apaga produtos;
Também realiza busca e retorna um relatório no formato CSV

## 📦 Tecnologias Utilizadas

- [Ruby](https://www.ruby-lang.org/pt/) 3.3.x
- [Ruby on Rails](https://rubyonrails.org/) 7.x
- [PostgreSQL](https://www.postgresql.org/)
- [Redis](https://redis.io/) *(Disponibilizado para melhorias futuras, ex: sidekiq)*

## 🚀 Como rodar o projeto localmente

```bash
# Clone o repositório
git clone https://github.com/xitarps/mbaonrails_rails_arch.git
cd mbaonrails_rails_arch

# abra o VSCode
code .

# rode o projeto no Dev container
# (caso tenha a extensão de vscode instalado, surgirá um popup perguntado se deseja abrir com dev container)

# prepare o banco de dados
rails db:create
rails db:migrate

# Inicie o projeto dentro do dev container
rails server
```

## Utilização da API(Curl)

<details>
  <summary>
     Endpoints
  </summary>

<br>

Criar Produto
```
curl -X POST -d '{"name": "apple juice", "price": 0.9 }' -H 'Content-type:application/json' http://127.0.0.1:3000/api/v1/products
```

Mostrar todos os produtos
```
curl -H 'Content-type:application/json' http://127.0.0.1:3000/api/v1/products
```

Mostrar um produto pelo seu id(ex: 8)
```
curl -H 'Content-type:application/json' http://127.0.0.1:3000/api/v1/products/8
```

Atualizar um produto pelo seu id(ex: 8)
```
curl -X PUT -d '{"price": 4.2 }' -H 'Content-type:application/json' http://127.0.0.1:3000/api/v1/products/8
```

Deletar um produto pelo seu id(ex: 8)
```
curl -X DELETE -H 'Content-type:application/json' http://127.0.0.1:3000/api/v1/products/8
```

Buscar produtos por um termo de busca (ex: 'pp') *no caso vai buscar nos campos name e price
```
curl -X GET -H 'Content-type:application/json' http://127.0.0.1:3000/api/v1/products?term=pp
```

Retornar relatório de todos os produtos no formato CSV(type=csv)

```
curl -X GET -H 'Content-type:application/json' http://127.0.0.1:3000/api/v1/products/generate_report?type=csv
```
</details>

<br>
caso prefira importar para o insomnia(yaml):

[.yaml](./docs/api_produtos_insomnia_v5.yaml)

## ✅ Funcionalidades implementadas

 - CRUD de produtos
 - Busca de produtos
 - Relatorio de produtos no formato CSV

## 🧠 Conceitos aplicados

Abaixo estão os conceitos aprendidos em aula e aplicados neste projeto, junto com a justificativa de sua utilização:
* os commits de \[Feat\] são focados nas aplicações desses conceitos, sendo recomendado caso precise de profundidade técnica quanto as implementações.

### 1. **Api(NameSpaces)**

Utilizados para organizar e separar endpoints e seus recursos:
Rotas com namespace de versão e controller de api com herança de API no lugar de Base

### 2. **Repository**

Utilizado para criar uma camada entre a aplicação em si e o contato com o banco,
permitindo que caso tenha uma necessidade de modificar o acesso aos dados, não impacte no sistema em si ou suas regras

### 3. **Service Object**

Utilizado para desacoplar regras de negocio(no caso a geração de relatório em csv)

### 4. **Concern**

Usado para criar uma funcionalidade de busca que pode ser facilmente reaproveitada em outroas models

### 5. **Query Object**

Aplicado para separar a construção de uma query do restante da aplicação; no caso a query vai ser montada dinamicamente para se adequar a model e aos atribuots conforme a necessidade

### 6. **Indiretos**

Alguns conceitos mostrados em aula foram aplicado indiretamente como:
 - Validations,similar a um  hook/ before save que roda as validações sobre a model de produto
 - Utilização do MVC / Apesar de ser uma api, o JBuilder utiliza a pasta de views para serializar os dados, assim tratando como a camada de view/apresentação em json
