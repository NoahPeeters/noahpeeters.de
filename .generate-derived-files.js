const puppeteer = require('puppeteer');

(async () => {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  await page.goto('http://localhost:8000/cv');
  await page.pdf({
    path: 'assets/files/cv.pdf',
    format: 'A4',
    margin: {
      top: 15,
      bottom: 15,
      left: 0,
      right: 0
    }
  });

  await browser.close();
})();
