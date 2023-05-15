# Script Python para simulação de dados da tabela cientistas
# Downloads ferramenta MySQL https://dev.mysql.com/downloads/installer/
# Passo a passo  conexão Python - MySQL Workbenk https://programacionfacil.org/blog/utilizar-bases-de-datos-mysql-con-python/

# Instalar con pip el conector de MySQL para Python
# pip install mysql-connector
# pip install mysql-connector-python

""" Biblioteca Faker é um pacote Python que gera dados falsos para você. Se você precisa inicializar 
seu banco de dados, criar documentos XML de boa aparência, preencher sua persistência para testá-lo 
ou anonimizar dados obtidos de um serviço de produção, o Faker é para você. Documentação  
https://pypi.org/project/Faker/ """

# pip install Faker

# Script simulaçãon de dados para o banco de dados da tabela cientistas

import random
import mysql.connector
from faker import Faker

# Mapeamento de valores para a coluna code_regiao
code_regiao_values = {
    '1': 'Centro-Oeste',
    '2': 'Nordeste',
    '3': 'Norte',
    '4': 'Sudeste',
    '5': 'Sul'
}

# Mapeamento de valores para a coluna code_sexo
code_sexo_values = {
    '1': 'Feminino',
    '2': 'Masculino'
}

# Função para gerar CPFs válidos
def gerar_cpf():
    cpf = [str(random.randint(0, 9)) for _ in range(9)]
    cpf = cpf + [verificador(cpf)]
    return ''.join(cpf)

def verificador(cpf):
    soma1 = sum([int(cpf[i]) * (i + 1) for i in range(9)]) % 11
    digito1 = 0 if soma1 < 2 else 11 - soma1
    cpf.append(str(digito1))
    soma2 = sum([int(cpf[i]) * (i + 2) for i in range(10)]) % 11
    digito2 = 0 if soma2 < 2 else 11 - soma2
    cpf.append(str(digito2))
    return cpf[-2:]

# Conexão ao banco de dados MySQL
""" Substituir seu_usuario, sua_senha, nome_do_banco 
com as informações correspondentes ao seu banco de dados"""

conexao = mysql.connector.connect(
    host="localhost",
    user="seu_usuario",
    password="sua_senha",
    database="nome_do_banco"
)

# Criação do cursor
cursor = conexao.cursor()

# Gerador de dados faker
fake = Faker()

# Geração e inserção dos dados na tabela
for i in range(100):  # Altere o número de registros desejado
    nome = fake.name()
    cpf = gerar_cpf()
    regiao = random.choice(list(code_regiao_values.keys()))
    sexo = random.choice(list(code_sexo_values.keys()))

    # Comando SQL para inserção dos dados
    sql = "INSERT INTO cientistas (cpf, nome, code_regiao, code_sexo) VALUES (%s, %s, %s, %s)"
    valores = (cpf, nome, regiao, sexo)

    # Execução do comando SQL
    cursor.execute(sql, valores)

# Confirmação das alterações no banco de dados
conexao.commit()

# Fechamento do cursor e da conexão
cursor.close()
conexao.close()
