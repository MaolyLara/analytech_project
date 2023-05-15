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

# Mapeamento de valores para a coluna code_financiamento
code_financiamento_values = {
    'A': 'Alto',
    'B': 'Médio',
    'C': 'Baixo'
}

# Função para gerar a quantidade de horas baseada nas datas de início e fim do projeto
def gerar_horas(data_inicio, data_fim):
    diff = data_fim - data_inicio
    dias_totais = diff.days
    horas_totais = dias_totais * 8  # Assumindo 8 horas de trabalho por dia
    return horas_totais

# Função para gerar o custo baseado na categoria de financiamento
def gerar_custo(categoria_financiamento):
    if categoria_financiamento == 'A':
        valor_medio = 100000
        variacao_percentual = 0.1
    elif categoria_financiamento == 'B':
        valor_medio = 50000
        variacao_percentual = 0.15
    else:
        valor_medio = 10000
        variacao_percentual = 0.2
    
    variacao = valor_medio * variacao_percentual
    valor_final = random.uniform(valor_medio - variacao, valor_medio + variacao)
    return round(valor_final, 2)

# Conexão ao banco de dados MySQL
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
    code_projeto = fake.unique.random_number(digits=5)
    titulo = fake.sentence(nb_words=6, variable_nb_words=True, ext_word_list=None)
    data_inicio = fake.date_between(start_date='-1y', end_date='today')
    data_fim = fake.date_between(start_date=data_inicio, end_date='+1y')
    horas = gerar_horas(data_inicio, data_fim)
    code_area = random.randint(1, 10)  # Substitua pelo código real da área
    code_regiao = random.choice(list(code_regiao_values.keys()))
    code_financiamento = random.choice(list(code_financiamento_values.keys()))
    costo = gerar_custo(code_financiamento)

# Comando SQL para inserção dos dados
sql = "INSERT INTO projetos (code_projeto, titulo, horas, data_Inicio, data_Fim, costo, code_area, code_regiao, code_financiamento) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)"
    
# Valores a serem inseridos
values = (code_projeto, titulo, horas, data_inicio, data_fim, costo, code_area, code_regiao, code_financiamento)
    
# Execução do comando SQL
cursor.execute(sql, values)

# Confirma as alterações no banco de dados
conexao.commit()

# Fecha o cursor e a conexão
cursor.close()
conexao.close()
