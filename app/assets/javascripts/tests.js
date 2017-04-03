/* global $ */
$(function() {
    //$(document).ready(function() {
      	var $validator = $("#commentForm").validate({
    		  rules: {
    		    emailfield: {
    		      required: true,
    		      email: true,
    		      minlength: 3
    		    },
    		    namefield: {
    		      required: true,
    		      minlength: 3
    		    },
    		    urlfield: {
    		      required: true,
    		      minlength: 3,
    		      url: true
    		    }
    		  }
    		});
     
    	  	$('#rootwizard').bootstrapWizard({
    	  		'tabClass': 'nav nav-pills',
    	  		'onNext': function(tab, navigation, index) {
    	  			var $valid = $("#commentForm").valid();
    	  			if(!$valid) {
    	  				$validator.focusInvalid();
    	  				return false;
    	  			}
    	  		}
    	  	});
    //});
});    