class DigitalDocumentService {
  private static baseURL = 'https://link.noahpeeters.de'
  private static targetURLSearchParamKey = 'targetURL'

  documentURL(documentCode: string): URL {
    return new URL('/' + documentCode, DigitalDocumentService.baseURL);
  }

  documentURLFromInput(inputID: string): URL {
    let code: string = (document.getElementById('document-code') as HTMLFormElement).value
    return this.documentURL(code);
  }

  openDocumentFromInput(inputID: string) {
    window.location.href = this.documentURLFromInput(inputID).href;
  }
}


(window as any).DigitalDocumentService = new DigitalDocumentService();
