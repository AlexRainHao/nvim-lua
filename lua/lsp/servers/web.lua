local M = {}

function M.setup()
  -- HTML Language Server
  vim.lsp.config('html', {
    cmd = { 'vscode-html-language-server', '--stdio' },
    filetypes = { 'html' },
    root_markers = { 'package.json', '.git' },
    init_options = {
      configurationSection = { 'html', 'css', 'javascript', 'typescript' },
      embeddedLanguages = {
        css = true,
        javascript = true,
        typescript = true
      },
      provideFormatter = true,
    },
  })

  -- Emmet Language Server
  vim.lsp.config('emmet_language_server', {
    cmd = { 'emmet-language-server', '--stdio' },
    filetypes = {
      'css',
      'html',
      'less',
      'sass',
      'scss',
      'typescriptreact',
      'javascriptreact',
      'vue',
    },
    root_markers = { 'package.json', '.git' },
  })

  -- CSS Language Server
  vim.lsp.config('cssls', {
    cmd = { 'vscode-css-language-server', '--stdio' },
    filetypes = { 'css', 'scss', 'less' },
    root_markers = { 'package.json', '.git' },
    settings = {
      css = {
        validate = true,
      },
      less = {
        validate = true,
      },
      scss = {
        validate = true,
      },
    },
  })

  -- Tailwind CSS Language Server
  vim.lsp.config('tailwindcss', {
    cmd = { 'tailwindcss-language-server', '--stdio' },
    filetypes = {
      'aspnetcorerazor',
      'astro',
      'astro-markdown',
      'blade',
      'clojure',
      'django-html',
      'htmldjango',
      'edge',
      'eelixir',
      'elixir',
      'ejs',
      'erb',
      'eruby',
      'gohtml',
      'gohtmltmpl',
      'haml',
      'handlebars',
      'hbs',
      'html',
      'html-eex',
      'heex',
      'jade',
      'leaf',
      'liquid',
      'markdown',
      'mdx',
      'mustache',
      'njk',
      'nunjucks',
      'php',
      'razor',
      'slim',
      'twig',
      'css',
      'less',
      'postcss',
      'sass',
      'scss',
      'stylus',
      'sugarss',
      'javascript',
      'javascriptreact',
      'reason',
      'rescript',
      'typescript',
      'typescriptreact',
      'vue',
      'svelte',
    },
    root_markers = {
      'tailwind.config.js',
      'tailwind.config.cjs',
      'tailwind.config.mjs',
      'tailwind.config.ts',
      'postcss.config.js',
      'postcss.config.cjs',
      'postcss.config.mjs',
      'postcss.config.ts',
      'package.json',
      'node_modules',
      '.git',
    },
  })
end

return M
