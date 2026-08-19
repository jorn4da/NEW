/**
 * Google Apps Script — recebe os leads da Landing Page Nova Leopoldina
 * e grava cada cadastro em uma nova linha da planilha.
 *
 * Instalação: veja o arquivo COMO-CONECTAR-PLANILHA.md
 */
function doPost(e) {
  try {
    var dados = JSON.parse((e && e.postData && e.postData.contents) || '{}');
    var ss = SpreadsheetApp.getActiveSpreadsheet();
    var aba = ss.getSheetByName('Leads') || ss.insertSheet('Leads');

    // Cria o cabeçalho na primeira vez
    if (aba.getLastRow() === 0) {
      aba.appendRow(['Data/Hora', 'Nome', 'WhatsApp', 'E-mail', 'Renda', 'Operadora', 'Interesse', 'Empreendimento', 'Origem']);
    }

    aba.appendRow([
      new Date(),
      dados['Nome'] || '',
      dados['WhatsApp'] || '',
      dados['E-mail'] || '',
      dados['Renda'] || '',
      dados['Operadora'] || '',
      dados['Interesse'] || '',
      dados['Empreendimento'] || '',
      dados['Origem'] || ''
    ]);

    return ContentService
      .createTextOutput(JSON.stringify({ ok: true }))
      .setMimeType(ContentService.MimeType.JSON);
  } catch (err) {
    return ContentService
      .createTextOutput(JSON.stringify({ ok: false, erro: String(err) }))
      .setMimeType(ContentService.MimeType.JSON);
  }
}

// Permite um teste rápido abrindo a URL no navegador (deve responder "online").
function doGet() {
  return ContentService.createTextOutput('Webhook Nova Leopoldina online');
}
