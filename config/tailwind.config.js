const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    colors: {
      // greens
      'light-green': '#c5e5c5',
      'green': '#8abf8e',
      'dark-green': '#5ebc66',
      //   pastel blues
      'blue': '#7ea3c4',
      // pastel purples
      'mauve': '#e0b0ff',
      'thistle': '#e9d8fd',
      // neutrals
      'white': '#ffffff',
      // additional colors
      'pastel-red': '#ff6962',
      'dark-red': '#f71d16',
      'pastel-blue': '#598fbf',
      'pastel-grey': '#e8e9eb',
    },
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
