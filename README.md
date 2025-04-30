#RatedPosts

## 🚀 Sobre o Projeto
RatePost é uma API REST desenvolvida com Ruby on Rails que permite a criação de posts com sistema de avaliação. Ela também oferece funcionalidades para listar os melhores posts, além de agrupar IPs por autores.

### Tarefas em : https://github.com/users/mosca06/projects/11/views/1

## 📌 Tecnologias Utilizadas

- Ruby on Rails (versão mais recente estável)
- PostgreSQL
- RSpec (para testes automatizados)
- RuboCop (para validação de estilo)
- SimpleCov (para cobertura de testes)

## 📖 Passo a Passo para Configurar e Executar o Projeto
### **1️⃣ Clonando o Repositório**
```sh
git clone https://github.com/mosca06/kikkerRatePost.git
cd kikkerRatePost
```
### **2️⃣ Instalando Dependências**
```sh
bundle install
```
### **3️⃣ Configurando o Banco de Dados**
```sh
rails db:create db:migrate
```
### **4️⃣ Rodando o Servidor**
```sh
rails s
```

### 🧪 **Testes Automatizados**
Para rodar os testes com RSpec:
```sh
rspec
```
### **🧹 Linting com RuboCop**
Verifique se o código está de acordo com as boas práticas Ruby:

```sh
rubocop
```
### **🌱 Populando o Banco de Dados**
Execute o script de seeds para gerar dados em massa :
```sh
rails db:seed
```
⚠️ O seed utiliza a própria API via curl, simulando requisições reais com criação de posts e avaliações.

### **🔗 Endpoints da API**

🔹 Criar um novo Post
<details>
	<summary> Detalhes da criação</summary>
  
  Método POST: 
  ```
  127.0.0.1:3000/api/v1/posts
  ```
  
  Parâmetros JSON:
  ```
  {
    "post": {
      "title": "Título do Post",
      "body": "Conteúdo do post",
      "ip": "XXX.XXX.XXX.XXX"
    },
    "user": {
      "login": "Login"
    }
  }
 ```
  Resposta JSON:
  ```
  {
	"post": {
		"id": "id do post",
		"user_id": "id do usuario",
		"title": "Título do Post",
		"body": "Conteúdo do post",
		"ip": "XXX.XXX.XXX.XXX",
		"created_at": "2025-04-25T12:11:01.599Z",
		"updated_at": "2025-04-25T12:11:01.599Z"
	},
	"user": {
		"id": id do usuario",
		"login": "Login",
		"created_at": "2025-04-25T12:11:01.589Z",
		"updated_at": "2025-04-25T12:11:01.589Z"
	  }
  }
  ```
</details>

🔹 Avaliar um Post
<details>
	<summary> Detalhes da avaliação</summary>

 Método POST: 
```
127.0.0.1:3000/api/v1/ratings
```

Parâmetros JSON:
```
{
	"user_id": "id do usuario",
	"post_id": "id do post",
	"value": "Valor entre 1 a 5"
}
```
Resposta JSON:
```
{
	"average_rating": "media da avaliação do post"
}
```
⚠️ Um usuário só pode avaliar um post uma única vez.
  
</details>


🔹 Listar os N melhores posts (por média de avaliação)
<details>
	
  <summary> Detalhes dos N melhores</summary>
  
  Método GET:
  ```
  127.0.0.1:3000/api/v1/posts/top
  ```

  Parâmetros JSON:
  ```
  {
	"limit" : "X"  
  }
  ```
⚠️ Caso não for passado o limite os vai retornar com 10.
Resposta JSON:
 ```
  [
    {
      "id": 1,
      "title": "Post A",
      "body": "Conteúdo A"
    },
    ...
  ]
 ```
  
</details>

🔹 Listar IPs utilizados por diferentes autores
<details>
	<summary> Detalhes da listagem</summary>
  
  Método GET:
   ```
  127.0.0.1:3000/api/v1/posts/ips
   ```
  Resposta JSON:
  ```
  [
    {
      "ip": "192.168.0.1",
      "logins": [
        "user1", 
        "user2"
      ]
    },
    ...
  ]
  ```
</details>



