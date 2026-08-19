# Como conectar a planilha do Google (receber os leads)

Cada cadastro do site vai continuar chegando por **e-mail** — este passo adiciona, **em paralelo**, o registro numa **planilha do Google**, para você ter a base organizada.

Leva ~5 minutos e só precisa ser feito uma vez.

## Passo a passo

1. **Crie a planilha**: acesse [sheets.google.com](https://sheets.google.com) e crie uma planilha em branco (ex.: nome "Leads Nova Leopoldina").

2. **Abra o editor de script**: no menu da planilha, clique em **Extensões → Apps Script**.

3. **Cole o código**: apague qualquer conteúdo que estiver lá e cole todo o conteúdo do arquivo **`GOOGLE-PLANILHA-webhook.gs`**. Clique no ícone de **salvar** (💾).

4. **Publique como App da Web**: clique em **Implantar → Nova implantação**.
   - Em "Selecionar tipo" (engrenagem), escolha **App da Web**.
   - **Executar como:** Eu (seu e-mail).
   - **Quem pode acessar:** **Qualquer pessoa**.
   - Clique em **Implantar** e **autorize** o acesso com a sua conta Google (é normal aparecer um aviso; clique em "Avançado → Acessar o projeto").

5. **Copie a URL**: ao final, o Google mostra a **URL do app da Web** (termina em **`/exec`**). Copie.

6. **Cole a URL no site**: abra o arquivo **`index.html`** e localize a linha:

   ```js
   var SHEET_WEBHOOK = '';
   ```

   Cole a URL entre as aspas, por exemplo:

   ```js
   var SHEET_WEBHOOK = 'https://script.google.com/macros/s/XXXXXXXX/exec';
   ```

   Salve o arquivo.

7. **Publique o site**: rode o `PUBLICAR-GITHUB.command`.

Pronto. A partir daí, cada lead cai **no e-mail** e também numa **nova linha da planilha**, com Data/Hora, Nome, WhatsApp, E-mail, Renda, Operadora, Interesse (de qual botão veio) e Origem.

## Dica de teste

- Abra a URL do app da Web no navegador: deve aparecer "Webhook Nova Leopoldina online".
- Faça um cadastro de teste no site publicado e confira se apareceu uma linha nova na aba **Leads**.

> Se um dia você alterar o código do Apps Script, gere uma **nova versão** em Implantar → Gerenciar implantações (ou o site continuará usando a versão antiga).
