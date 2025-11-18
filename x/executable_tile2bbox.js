#!/usr/bin/env node

// Get the global node_modules path
const globalModulesPath = require('child_process')
    .execSync('npm root -g')
    .toString().trim();

// Import tilebelt from the global path
const tilebelt = require(`${globalModulesPath}/@mapbox/tilebelt/dist/cjs`);

const args = process.argv.slice(2);
if (args.length != 3) {
    console.log('Provide tile coordinates as z x y');
    process.exit(1)
}
bbox = tilebelt.tileToBBOX([args[0], args[1], args[2]])
console.log(bbox[0], bbox[1], bbox[2], bbox[3])

// #!/usr/bin/env node
//
// // Get the global node_modules path
// const { execSync } = require('child_process');
// const globalModulesPath = execSync('npm root -g').toString().trim();
//
// // Use dynamic import to load chalk
// (async () => {
//     const chalk = await import(`${globalModulesPath}/@mapbox/tilebelt/dist/.js`);
//
//     // Get command-line arguments
//     const args = process.argv.slice(2);
//
//     console.log(args)
// })();
//
