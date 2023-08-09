// app/javascript/packs/application.js

// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// app/javascript/packs/application.js
// Your other imports and configurations
import 'search_dropdown';
import 'tasks';
import '/add_remove_users';
import '..add_remove_users';

// app/javascript/packs/application.js
require("./nested-forms/addFields");
require("./nested-forms/removeFields");
// import 'nested-forms/removeFields';
// import 'nested-forms/addFields';
import 'adduser';

console.log("Hello from application.js");