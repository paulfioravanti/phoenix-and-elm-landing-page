export function initPorts(app) {
  initRecaptcha(app);
  resetRecaptcha(app);
}

let recaptcha;

function initRecaptcha(app) {
  app.ports.initRecaptcha.subscribe(id => {
    window.requestAnimationFrame(() => {
      recaptcha = grecaptcha.render(id, {
        hl: "en",
        sitekey: "6LccDkwUAAAAACiEnnM1HucXGT0rdgcYQwag5WsJ",
        callback: result => {
          // Subscription
          app.ports.setRecaptchaToken.send(result);
        },
      });
    });
  });
}

function resetRecaptcha(app) {
  app.ports.resetRecaptcha.subscribe(() => {
    grecaptcha.reset(recaptcha);
  });
}
