module.exports = [
  'strapi::errors',
  'strapi::security',
  {
    name: 'strapi::cors', //Securtiy middlewares
    config: {
      enable: true,
      origin: ['http://localhost:5271', 'http://127.0.0.1:5271', 'http://localhost:5270', 'http://127.0.0.1:5270'],
      headers: '*',
      methods: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'HEAD', 'OPTIONS'],
      preflightContinue: true,
      optionsSuccessStatuts: 204,
      allowHeaders: ['Content-Type'],
      allowMethods: ['GET', 'POST', 'PUT', 'DELETE'],
      keepHeaderOnError: true,
    },
  },
  'strapi::poweredBy',
  'strapi::logger',
  'strapi::query',
  'strapi::body',
  'strapi::session',
  'strapi::favicon',
  'strapi::public',
];
