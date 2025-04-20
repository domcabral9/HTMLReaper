# HTMLReaper - Parsing HTML para Subdomínios

Ferramenta criada para fins educacionais, como parte do desafio prático do Curso **Novo Pentest Profissional** da **DESEC Security**. Essa ferramenta foi desenvolvida com Bash Script puro e tem como objetivo realizar parsing de HTML em busca de subdomínios, resolvendo os IPs associados e exibindo os resultados no terminal.

---

## ✨ Funcionalidades
- Baixa o HTML do domínio informado
- Extrai e lista subdomínios encontrados no código HTML
- Resolve os IPs via `dig` e fallback com `nslookup`
- Exibe os resultados em uma tabela colorida
- Salva o resultado em um arquivo `.txt` com timestamp
- Remove arquivos temporários após a execução
- Interface interativa que permite consultar vários domínios

---

## ⚡ Requisitos
- `bash`
- `wget`
- `dig`
- `nslookup`
- `awk`, `grep`, `sort`

Instale as dependências no Debian/Ubuntu:
```bash
sudo apt update && sudo apt install dnsutils wget -y
```

---

## ⚙ Uso
```bash
chmod +x htmlreaper.sh
./htmlreaper.sh
```

---

## 🔒 Aviso
Este projeto tem **fins educacionais**. O uso para fins maliciosos é expressamente proibido. O autor não se responsabiliza por qualquer uso indevido.

---

## 🌐 ENGLISH VERSION

# HTMLReaper - HTML Parsing for Subdomains

Tool created for educational purposes as part of the **Novo Pentest Profissional** course by **DESEC Security**. Developed in pure Bash, this tool performs HTML parsing to extract subdomains, resolves their associated IPs, and displays the results in a clean and colorful terminal interface.

---

## ✨ Features
- Downloads HTML from the target domain
- Extracts and lists subdomains found in the HTML code
- Resolves IPs using `dig`, with fallback to `nslookup`
- Displays output in a colored table format
- Saves results in a timestamped `.txt` file
- Removes temporary HTML files after execution
- Interactive shell to analyze multiple domains in sequence

---

## ⚡ Requirements
- `bash`
- `wget`
- `dig`
- `nslookup`
- `awk`, `grep`, `sort`

Install dependencies (Debian/Ubuntu):
```bash
sudo apt update && sudo apt install dnsutils wget -y
```

---

## 🔒 Disclaimer
This tool is intended for **educational use only**. Malicious use is strictly prohibited. The author is not responsible for any misuse of the code.

---

**Desenvolvido com café e Shell Script ☕️ por um aluno do Curso Novo Pentest Profissional da DESEC Security.**

# HTMLReaper
