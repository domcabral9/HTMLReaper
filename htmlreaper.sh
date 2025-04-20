#!/bin/bash

# =============================
# Ferramenta: HTMLReaper
# Versão: 1.0
# Descrição: Busca subdomínios em páginas HTML e resolve IPs.
# Autor: domcabral9
# Pré-requisitos: dig, nslookup, grep, awk, sort, wget
# =============================

# Cores para terminal
verde="\e[32m"
vermelho="\e[31m"
amarelo="\e[33m"
azul="\e[34m"
reset="\e[0m"

# Função principal
buscar_subdominios() {
    clear
    echo -e "${azul}[*] Digite o domínio (ex: exemplo.com) ou digite 'sair' para encerrar:${reset}"
    read dominio

    if [[ "$dominio" == "sair" ]]; then
        echo -e "${verde}[+] Finalizando script. Até mais!${reset}"
        exit 0
    fi

    # Nome do arquivo onde vai salvar o resultado
    data=$(date +%Y%m%d-%H%M%S)
    dominio_formatado=${dominio//./_}
    nome_base="${dominio_formatado}_$data"
    arquivo_saida="resultado_subdominios_${nome_base}.txt"
    arquivo_html="pagina_${nome_base}.html"

    echo -e "${amarelo}[*] Baixando conteúdo HTML de $dominio com wget...${reset}"
    wget -q -O "$arquivo_html" "http://$dominio"

    if [ ! -f "$arquivo_html" ]; then
        echo -e "${vermelho}[!] Erro ao baixar o conteúdo. Verifique o domínio.${reset}"
        return
    fi

    echo -e "${amarelo}[*] Extraindo possíveis subdomínios...${reset}"
    subdominios=$(grep -oP "([a-zA-Z0-9_-]+\\.)+$dominio" "$arquivo_html" | sort -u)

    if [ -z "$subdominios" ]; then
        echo -e "${vermelho}[!] Nenhum subdomínio encontrado.${reset}"
        rm -f "$arquivo_html"
        return
    fi

    echo -e "\n${verde}[+] Subdomínios encontrados:${reset}\n"
    printf "${azul}%-20s %-40s${reset}\n" "IP" "Nome"
    echo "$subdominios" > /tmp/subs_temp.txt

    > "$arquivo_saida"
    printf "IP\t\t\tNome\n" >> "$arquivo_saida"
    printf -- "--------------------------------------------\n" >> "$arquivo_saida"

    while read sub; do
        ip=""
        resultados=$(dig +short "$sub")

        # Filtra apenas linhas que são IPs (evita nomes DNS)
        for linha in $resultados; do
            if [[ "$linha" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
                ip="$linha"
                break
            fi
        done

        if [ -z "$ip" ]; then
            # Se não veio IP direto, tenta resolver via nslookup
            ip=$(nslookup "$sub" | awk '/^Address: / { print $2 }' | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' | head -n1)
        fi

        if [ -n "$ip" ]; then
            printf "${verde}%-20s ${reset}%-40s\n" "$ip" "$sub"
            printf "%s\t\t%s\n" "$ip" "$sub" >> "$arquivo_saida"
        fi
    done < /tmp/subs_temp.txt

    echo -e "\n${verde}[+] Resultado salvo em:${reset} ${azul}$arquivo_saida${reset}\n"

    # Remove o arquivo HTML temporário
    rm -f "$arquivo_html"

    # Pergunta se quer fazer nova busca
    echo -e "${amarelo}[*] Deseja pesquisar outro domínio? (s/n):${reset}"
    read opcao
    if [[ "$opcao" =~ ^[sS]$ ]]; then
        buscar_subdominios
    else
        echo -e "${verde}[+] Finalizando script. Valeu!${reset}"
        exit 0
    fi
}

# Inicia o script
buscar_subdominios

