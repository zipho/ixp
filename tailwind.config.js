const colors = require('tailwindcss/colors')

module.exports = {
  mode: 'jit',
  purge: {
    enabled: ["production", "staging"].includes(process.env.NODE_ENV),
    content: [
      './**/*.html.erb',
      './app/helpers/**/*.rb',
      './app/javascript/**/*.js',
    ],
  },
  presets: [],
  darkMode: false, // or 'media' or 'class'
  theme: {
    screens: {
      sm: '640px',
      md: '768px',
      lg: '1024px',
      xl: '1280px',
      '2xl': '1536px',
    },
    colors: {
      transparent: 'transparent',
      current: 'currentColor'},
      flexGrow: {
        0: '0',
        DEFAULT: '1',
      },
      flexShrink: {
        0: '0',
        DEFAULT: '1',
      },
      fontFamily: {
        sans: [
          'Inter var',
          'ui-sans-serif',
          'system-ui',
          '-apple-system',
          'BlinkMacSystemFont',
          '"Segoe UI"',
          'Roboto',
          '"Helvetica Neue"',
          'Arial',
          '"Noto Sans"',
          'sans-serif',
          '"Apple Color Emoji"',
          '"Segoe UI Emoji"',
          '"Segoe UI Symbol"',
          '"Noto Color Emoji"',
        ],
        serif: ['ui-serif', 'Georgia', 'Cambria', '"Times New Roman"', 'Times', 'serif'],
        mono: [
          'ui-monospace',
          'SFMono-Regular',
          'Menlo'],
        zIndex: ['responsive', 'focus-within', 'focus'],
},
plugins: [
  require('@tailwindcss/typography'),
  require('@tailwindcss/forms'),
  require('@tailwindcss/line-clamp'),
  require('@tailwindcss/aspect-ratio'),],
}