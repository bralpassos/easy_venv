#!/bin/bash
#
# ambiente.sh
#
# Este script é o responsável por montar o ambiente
# de desenvolvimento do projeto.
#
# Além de montar, ele também inicia o ambiente.
#
# Códigos de saída:
# 0 : Tudo ok
# 1 : Não tem o virtualenv instalado
# 2 : Ambiente já existe
# 3 : Erro ao configurar o virtualenv
# 4 : Erro ao ativar o virtualenv
# 5 : Erro ao instalar um pacote
#
# Autor: Evaldo Junior <junior@casoft.info>
#
# Versão: 0.1 alpha

#
# Área de configuração, configure seu ambiente abaixo
#
DIRETORIO="./venv"
PACOTES=( "bottle" "jinja2" )

#
# Fim da área de configuração
# Só altere daqui para baixo se souber o que está fazendo!
# THIS IS SPARTA!
#
VIRTUALENV=$(which virtualenv)


if [ $VIRTUALENV == "" ]; then
    echo "Você não tem o virtualenv instalado!"
    exit 1
fi

if [ -d $DIRETORIO ]; then
    echo "Ambiente já existe em $DIRETORIO"
    exit 2
fi

echo "Criando o ambiente virtual em $DIRETORIO"
$VIRTUALENV $DIRETORIO

if [ ! $? -eq 0 ]; then
    echo "Houve algum problema ao configurar seu ambiente virtual!"
    exit 3
fi

echo "Ambiente criado em $DIRETORIO"

echo "Ativando o ambiente..."
. $DIRETORIO/bin/activate

if [ ! $? -eq 0 ]; then
    echo "Houve algum problema ao ativar o ambiente!"
    exit 4
fi

echo "Instalando pacotes selecionados"

for pacote in "${PACOTES[@]}"
do
    $DIRETORIO/bin/pip install $pacote

    if [ ! $? -eq 0 ]; then
        echo "Houve algum problema ao instalar o pacote $pacote"
        exit 5
    fi
done

echo "Ambiente instalado e pronto para usar!"
