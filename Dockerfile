# Etapa 1: Escolha da imagem base
# Usamos uma imagem 'slim' que é uma boa base, menor que a padrão,
# mas com as bibliotecas essenciais, evitando problemas de compilação que podem ocorrer com a 'alpine'.
# O README menciona Python 3.10+, então 3.11 é uma escolha segura e moderna.
FROM python:3.13.4-alpine3.22

# Etapa 2: Definir o diretório de trabalho dentro do contêiner
WORKDIR /app

# Etapa 3: Copiar o arquivo de dependências
# Copiamos primeiro para aproveitar o cache do Docker. Se este arquivo não mudar,
# o Docker não reinstalará as dependências em builds futuros.
COPY requirements.txt .

# Etapa 4: Instalar as dependências
# O '--no-cache-dir' desabilita o cache do pip, o que ajuda a manter o tamanho da imagem menor.
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 5: Copiar o restante do código da aplicação
COPY . .

# Etapa 6: Expor a porta que a aplicação usará
EXPOSE 8000

# Etapa 7: Comando para executar a aplicação quando o contêiner iniciar
# Usamos "0.0.0.0" para que a aplicação seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]