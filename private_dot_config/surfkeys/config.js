// unmap
// proxy mappings
api.unmap('cp')
api.unmap(';ap')
api.unmap(';cp')
api.unmap(';pm')
api.unmap(';pb')
api.unmap(';pc')
api.unmap(';pd')
api.unmap(';ps')

// emoji picker
api.iunmap(':')

// map
// scrolling
api.map('{', 'e')
api.map('}', 'd')
api.map('as', ';fs')
api.map('aS', 'cS')

// tabs
api.map('oo', 'go')
api.map('K', 'R')
api.map('J', 'E')
api.map('d', 'x')
api.map('u', 'X')

// navigation and history
api.map('H', 'S')
api.map('L', 'D')
api.map('R', ';U')

// zooming
api.map('z0', 'zr')
api.map('zz', 'zi')

// settings
settings.scrollStepSize = 140
settings.hintAlign = "left"
settings.tabsThreshold = 0

// set theme - https://github.com/brookhong/Surfingkeys/wiki/Color-Themes#zenbonse
settings.theme = `
.sk_theme {
  font-family: SauceCodePro Nerd Font, Consolas, Menlo, monospace;
  font-size: 10pt;
  background: #f0edec;
  color: #2c363c;
}
.sk_theme tbody {
  color: #f0edec;
}
.sk_theme input {
  color: #2c363c;
}
.sk_theme .url {
  color: #1d5573;
}
.sk_theme .annotation {
  color: #2c363c;
}
.sk_theme .omnibar_highlight {
  color: #88507d;
}
.sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
  background: #f0edec;
}
.sk_theme #sk_omnibarSearchResult ul li.focused {
  background: #cbd9e3;
}
#sk_status,
#sk_find {
  font-size: 10pt;
}
`;

const hintsCss =
  "font-size: 10pt; font-family: SauceCodePro Nerd Font, Consolas, Menlo, monospace; border: 0px; color:#2c363c; background: initial; background-color: #f0edec;";

api.Hints.style(hintsCss);
api.Hints.style(hintsCss, "text");

// click `Save` button to make above settings to take effect (:w).
