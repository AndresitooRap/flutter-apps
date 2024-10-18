module.exports = ({ env }) =>[
  'strapi::errors',
  'strapi::security',
  {
    name: 'strapi::cors', //Securtiy middlewares
    config: {
      enable: true,
      origin: ['http://localhost:65500', 'http://127.0.0.1:65500', 'http://localhost:65400', 'http://127.0.0.1:65400' ],
      headers: '*',
      methods: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'HEAD', 'OPTIONS'],
      preflightContinue: true,
      optionsSuccessStatuts: 204,
      allowHeaders: ['Content-Type'],
      allowMethods: ['GET', 'POST', 'PUT', 'DELETE'],
      keepHeaderOnError: true,
    },
  },
  'strapi::poweredBy', //Response middlewares
  'strapi::logger', //Request middlewares: obligatorio en true
  'strapi::query',
  'strapi::body', //Internal middlewares
  'strapi::session', //Request middlewares
  'strapi::favicon', //Global middleware
  'strapi::public', //Global middleware
];
