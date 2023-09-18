#!/bin/bash

# Criar um diretório para armazenar os logs baseado na data e hora
DIR="./$(date +'%d-%m-%Y_%H-%M-%S')"
mkdir -p "$DIR"

exec &> "$DIR/log.txt"  # Redirecionar saída padrão e erros para o arquivo de log dentro do diretório criado

echo "==== INFORMAÇÕES DO SISTEMA ===="

# Informações sobre hardware
echo "--- Informações do Hardware ---"
lscpu
echo
lshw -short | grep -E "system|processor|memory|disk|network"
echo

# Uso de memória
echo "--- Uso de Memória ---"
free -h
echo

# Uso de rede
echo "--- Uso de Rede ---"
ifconfig | grep -E "inet|RX bytes"
echo

# Uso de I/O do disco
echo "--- Uso de I/O do Disco ---"
iostat
echo

# Quantidade de processos em uso
echo "--- Processos em Execução ---"
echo "Total: $(ps aux | grep -v "grep" | wc -l)"
echo

# Quantidade de processos parados
echo "--- Processos Parados ---"
echo "Total: $(ps aux | grep -v "grep" | grep "T" | wc -l)"
echo

# Quantidade de softwares instalados
echo "--- Softwares Instalados ---"
echo "Total: $(dnf list installed | wc -l)"
echo

# Carga Média do Sistema e Uptime
echo "--- Carga Média e Uptime ---"
uptime
echo

# Informações sobre aquecimento
echo "--- Temperatura do Hardware ---"
sensors
echo

# Identificação da máquina na rede
echo "--- Identificação na Rede ---"
echo "Hostname: $(hostname)"
echo "Endereço IP: $(hostname -I)"
echo

echo "==============================="