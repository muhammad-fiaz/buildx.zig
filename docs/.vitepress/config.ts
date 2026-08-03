import { defineConfig } from 'vitepress'

export default defineConfig({
  title: 'buildx.zig',
  description: 'A minimal, efficient build system library for Zig',
  lang: 'en-US',
  head: [
    ['meta', { property: 'og:title', content: 'buildx.zig' }],
    ['meta', { property: 'og:description', content: 'Simplified build system for Zig 0.16.0' }],
    ['meta', { property: 'og:image', content: '/og-image.png' }],
    ['meta', { name: 'twitter:card', content: 'summary_large_image' }],
    ['link', { rel: 'icon', type: 'image/svg+xml', href: '/favicon.svg' }],
    ['link', { rel: 'icon', type: 'image/png', sizes: '96x96', href: '/favicon-96x96.png' }],
    ['link', { rel: 'icon', href: '/favicon.ico' }],
    ['link', { rel: 'apple-touch-icon', sizes: '180x180', href: '/apple-touch-icon.png' }],
    ['link', { rel: 'manifest', href: '/site.webmanifest' }],
  ],
  themeConfig: {
    logo: '/favicon.svg',
    siteTitle: 'buildx.zig',
    nav: [
      { text: 'Guide', link: '/guide/quick-start' },
      { text: 'API', link: '/api/project' },
      { text: 'Examples', link: '/examples/' },
      { text: 'GitHub', link: 'https://github.com/user/buildx.zig' },
    ],
    sidebar: {
      '/guide/': [
        {
          text: 'Guide',
          items: [
            { text: 'Quick Start', link: '/guide/quick-start' },
            { text: 'Cross Compilation', link: '/guide/cross-compile' },
            { text: 'Workspaces', link: '/guide/workspace' },
            { text: 'System Libraries', link: '/guide/system-libs' },
            { text: 'Custom Options', link: '/guide/options' },
            { text: 'Integrating with std.Build', link: '/guide/std-integration' },
          ],
        },
      ],
      '/api/': [
        {
          text: 'API Reference',
          items: [
            { text: 'project()', link: '/api/project' },
            { text: 'workspace()', link: '/api/workspace' },
            { text: 'crossCompile()', link: '/api/cross' },
            { text: 'Options', link: '/api/options' },
            { text: 'System Libraries', link: '/api/plugins' },
            { text: 'Targets', link: '/api/targets' },
          ],
        },
      ],
      '/examples/': [
        {
          text: 'Examples',
          items: [
            { text: 'Overview', link: '/examples/' },
            { text: 'Basic Executable', link: '/examples/basic-executable' },
            { text: 'Library with Tests', link: '/examples/library-with-tests' },
            { text: 'Cross Compilation', link: '/examples/cross-compile' },
            { text: 'Custom Options', link: '/examples/custom-options' },
            { text: 'System Libraries', link: '/examples/system-lib' },
            { text: 'Run with Args', link: '/examples/run-with-args' },
            { text: 'Monorepo', link: '/examples/monorepo' },
          ],
        },
      ],
    },
  },
})
