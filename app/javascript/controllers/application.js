import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

// import "nested_form_controller";



// import "/packs/search.js";
// import 'select2';
// import 'select2/dist/css/select2.css';

// app/assets/javascripts/application.js

//= require search_dropdown
//= require packs/search_dropdown

//= require turbolinks
//= require_tree .

//= require jquery-3.6.0.min
//= require rails-ujs
//= require_tree .


//= require select2

//= require select2-full
//= require select2_locale_"en"
