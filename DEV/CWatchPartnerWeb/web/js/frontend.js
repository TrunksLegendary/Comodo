var tag = document.createElement('script');
tag.src = "https://www.youtube.com/iframe_api";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
var player;

function onYouTubeIframeAPIReady() {
	player = new YT.Player('youtube-player', {
		height: '315',
		width: '560',
		videoId: '1js1pTVVYks'
	});
}

$(document).on('ready', function () {
	var in_progress = false;
	// popup video
	$('#popup-video').on('hidden.bs.modal', function (e) {
		player.stopVideo();
	});
	$('#popup-video .close_btn').on('click', function () {
		$('#popup-video').modal('hide');
		player.stopVideo();
	});


	$('.skip-ftb-btn').on('click',function(){
		$.ajax({
			method: "POST",
			url: '/onboard-buyer-journey/forms/ftp-skip.php'
		})
		.success(function (data) {
			var response = JSON.parse(data);
			if (response && response['next_step']) {
				window.location = response['next_step'];
			}
		});
		return false;
	});



	$('.checkout-step .btn-cta.btn-blue').on('click', function () {
		var btn = $(this);
		if (btn.attr('href') !== '#') {
			return true;
		}
		if (in_progress == true) {
			return false;
		}
		if (btn.css('cursor') == 'progress') {
			return false;
		}
		$('.checkout-step .inprogress_comment').show();
		var register_site = function () {
			in_progress = true;
			$.ajax({
				method: "POST",
				url: '/onboard-buyer-journey/forms/site-register.php',
				data: data
			})
			.success(function (data) {
				// in_progress = false;
				var response = JSON.parse(data);
				// show error on popup
				if (response && response['success'] == 'INPROGRESS') {
					setTimeout(register_site(), 1000);
				} else if (response && response['success'] == 'SUCCESSFUL' && response['next_step']) {
					regiter_dns();
				} else if (response && response['success'] == 'FAILED' && response['next_step']) {
					in_progress = false;
					btn.attr('href', response['next_step']);
					$('.spinner').removeClass('active');
					$('.checkout-step .inprogress_comment').hide();
					btn.text('Continue');
				} else{
					in_progress = false;
					$('.spinner').removeClass('active');
					$('.checkout-step .inprogress_comment').hide();
					btn.text('Begin cWatch Setup');
				}
			})
			.fail(function () {
				btn.text('Begin cWatch Setup');
				$('.spinner').removeClass('active');
				in_progress = false;
				$('.checkout-step .inprogress_comment').hide();
			})
			.done(function (msg) {
				btn.css("cursor", "auto");
				// in_progress = false;
			});
		};
		var regiter_dns = function () {
			in_progress = true;
			$.ajax({
				method: "POST",
				url: '/onboard-buyer-journey/forms/dns-register.php',
				data: data
			})
			.success(function (data) {
				in_progress = false;
				var response = JSON.parse(data);
				// show error on popup
				if (response && response['success'] == 'REGISTRATION_IN_PROGRESS') {
					setTimeout(regiter_dns(), 1000);
				} else if (response && response['success'] == 'SUCCESSFUL' && response['next_step']) {
					in_progress = false;
					$('.checkout-step .inprogress_comment').hide();
					$('.spinner').removeClass('active');
					btn.css("cursor", "auto");
					btn.attr('href', response['next_step']);
					btn.text('Continue');
				} else {
					if (response['next_step']) {
						btn.attr('href', response['next_step']);
						btn.text('Continue');
						$('.checkout-step .inprogress_comment').hide();
					} else {
						btn.attr('href', '/onboard-buyer-journey/step-4');
						btn.text('Continue');
						$('.checkout-step .inprogress_comment').hide();
					}
					in_progress = false;
					$('.spinner').removeClass('active');
					$('.checkout-step .inprogress_comment').hide();
					btn.css("cursor", "auto");
				}
			})
			.fail(function () {
				btn.text('Begin cWatch Setup');
				$('.spinner').removeClass('active');
				$('.checkout-step .inprogress_comment').hide();
				in_progress = false;
			})
			.done(function (msg) {
			});
		};

		$('.spinner').addClass('active');
		btn.css("cursor", "progress");
		btn.text('Provisioning In Progress');
		$('#popup-video').modal('show');
		player.playVideo();
		in_progress = true;
		register_site();
		return false;
	});
	// end popup video
	var w = $(window).width();
	if (w > 1130) {
		$('[data-toggle="tooltip"]').tooltip({'placement': "left"});
	} else {
		$('[data-toggle="tooltip"]').tooltip({'placement': "top"});
	}

	var data = null;
	$('input[name=customerType]').on('click', function () {
		var val;
		val = $(this).val();

		$('#user-info .customer-type .nav-link').removeClass('active');
		if (val == 1) {
			$('#user-info').attr('action', '/onboard-buyer-journey/forms/login.php');
			$('#user-info .btn-cta').text('Continue');
			$('#user-info label[for=password]').not('.error').text('Enter password');
			$('#user-info #password_confirm').hide();
			$('#user-info #password_confirm').rules('remove');
			$('#user-info label[for=password_confirm]').hide();
			$('#user-info .customer-type label[for=customerTypeExisting]').parent('.nav-link').addClass('active');
			$("label.error").each(function () {
				$(this).text('');
			});
			$("label.error").hide();
			$('#user-info .step-description').text('');
			$('#user-info .step-description').text('Login to an account');
			//$(".error").removeClass("error");
		} else {
			$('#user-info').attr('action', '/onboard-buyer-journey/forms/create-user.php');
			$('#user-info .btn-cta').text('Create Account');
			$('#user-info label[for=password]').not('.error').text('Create a password');
			$('#user-info label[for=password_confirm]').show();
			$('#user-info #password_confirm').show();
			$('#user-info #password_confirm').rules('add', {equalTo: "#password"});
			$('#user-info .customer-type label[for=customerTypeNew]').parent('.nav-link').addClass('active');
			$("label.error").each(function () {
				$(this).text('');
			});
			$("label.error").hide();
			//$(".error").removeClass("error");
			$('#user-info .step-description').text('Create an account');
		}
	});
	$('.product').on('click', function () {
		var plan = $(this).attr('product-plan');
		if (plan == 'basic') {
			$('button[type=submit]').removeClass('blue-cta-btn');
			$('button[type=submit]').addClass('green-cta-btn');
			$('#product_period').val(0);
		} else {
			$('button[type=submit]').removeClass('green-cta-btn');
			$('button[type=submit]').addClass('blue-cta-btn');
			$('#product_period').val(1);
		}
		$('label.error').remove();
		$('#product_plan').val(plan);
		$.each($('.product'), function () {
			$(this).removeClass('active');
		});
		$.each($('td[product-plan=' + plan + ']'), function () {
			$(this).addClass('active');
		});
	});
	$('.product').on('mouseover', function () {
		var plan = $(this).attr('product-plan');
		$.each($('td[product-plan=' + plan + ']'), function () {
			$(this).addClass('hover');
		});
	});
	$('.product').on('mouseout', function () {
		var plan = $(this).attr('product-plan');
		$.each($('td[product-plan=' + plan + ']'), function () {
			$(this).removeClass('hover');
		});
	});
	$('#creditcard-info .step-section-head').on('click', function () {
		$(this).toggleClass('open').next('.step-section-body').slideToggle();
	});
	$('#ftp-popup').on('click', function (event) {
		$(this).hide();
	});
	$('#ftp-popup .modal-panel').on('click', function (event) {
		event.stopPropagation();
	});
	$.validator.addMethod('IPv4', function (value) {
		var ip = "^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$";
		return value.match(ip);
	}, 'Invalid IP address');

	$.validator.addMethod("phone", function(value, element){
		return this.optional(element) || /^\d{7,31}$/.test(value);
	}, "Please enter valid phone number");

	$.validator.addMethod('site', function (value) {
		var ip = "^(?:http(s)?:\\/\\/)?[\\w.-]+(?:\\.[\\w\\.-]+)+[\\w\\-\\._~:/?#[\\]@!\\$&'\\(\\)\\*\\+,;=.]+$";
		return value.match(ip);
	}, 'Please enter a valid URL.');
	$.validator.addMethod('domain', function (value) {
		var domain = "^[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,30}$";
		return value.match(domain);
	}, 'Please enter a valid domain.');
	$.validator.addMethod('not_served_countries', function (value) {
		var countries = "\.(ir|ly|so|sy|ye)$";
		return !value.match(countries);
	}, 'We do not serve our operations in your country');

	$.validator.addMethod('without_www', function (value) {
		var www = "^www[.].*";
		return !value.match(www);
	}, 'Please enter domain without www at the beginning');
	$.validator.addMethod("email", function (value, element) {
		return this.optional(element) || /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/.test(value);
	}, "Please enter a valid email address.");
	$('#ftp-info input').on('change', function () {
		$('.ftp-connection-information').detach();
		$('.connect-ftb-btn').removeClass('failed-connect success-connect');
		$('.connect-ftb-btn').text('Enable Scanner');
	});
	// step-1 validation
	var website_info = $("#website-info").validate({
		rules: {
			website: {
				required: true,
				domain: true,
				not_served_countries: true,
				'without_www': true
			}
		},
		submitHandler: function (form) {
			var data = $(form).serialize();
			var form_handler = $(form).attr('action');
			$.ajax({
				method: "POST",
				url: form_handler,
				data: data
			})
			.success(function (data) {
				var response = JSON.parse(data);
				if (response['errors']) {
					website_info.showErrors(response['errors']);
				} else {
					if (response['next_step']) {
						window.location.href = response['next_step'];
					}
				}
			})
			.done(function (msg) {
			});
			return false;
			// $(form).submit();
		}
	});
	// step-2 validation
	var user_info = $("#user-info").validate({
		ignore: [],
		rules: {
			first_name: {
				required: true,
				maxlength: 255
			},
			password: {
				required: true,
				minlength: 6
			},
			password_confirm: {
				equalTo: "#password"
			},
			email: {
				required: true,
				email: true
			},
			phone: {
				required: true,
				phone: true
			},
			country: {
				required: true
			},
			terms: {
				required: true
			}
		},
		submitHandler: function (form) {
			var data = $(form).serialize();
			var form_handler = $(form).attr('action');
			$('.spinner').addClass('active');
			$.ajax({
				method: "POST",
				url: form_handler,
				data: data
			})
			.success(function (data) {
				var response = JSON.parse(data);
				if (response['popup']) {
					$.notify({
						message: response['popup']
					}, {
						type: 'danger',
						placement: {
							from: "top",
							align: "center"
						},
						delay: 3000
					});
				}
				if (response['errors']) {
					user_info.showErrors(response['errors']);
				} else {
					if (response['next_step']) {
						window.location.href = response['next_step'];
					}
				}
			})
			.done(function (msg) {
				$('.spinner').removeClass('active');
			});
			return false;
			// $(form).submit();
		}
	});
	// step-3 validation
	var product_info = $("#product-info").validate({
		ignore: [],
		rules: {
			"product_plan": {
				required: true
			}
		},
		messages: {
			"product_plan": {
				required: "Please select product"
			}
		},
		submitHandler: function (form) {
			if ($('#product-info .cta-btn').css('cursor') == 'progress') {
				return false;
			}
			$('.spinner').addClass('active');
			$("#product-info .cta-btn").css("cursor", "progress");
			var plan = $('#product_plan').val();
			var period = $('#product_period').val();
			var data = $(form).serialize();
			var form_handler = $(form).attr('action');
			data = data + '&' + $.param({
				'cart': window.productData[plan][period]
			});
			$.ajax({
				method: "POST",
				url: form_handler,
				data: data
			})
			.success(function (data) {
				var response = JSON.parse(data);
				// show error on popup
				if (response['popup']) {
					$.notify({
						message: response['popup']
					}, {
						type: 'danger',
						placement: {
							from: "top",
							align: "center"
						},
						onClose: function () {
						},
						delay: 3000
					});
				}
				if (response['errors']) {
					product_info.showErrors(response['errors']);
				} else {
					if (response['next_step']) {
						window.location.href = response['next_step'];
					}
				}
			})
			.done(function (msg) {
				$('#product-info .cta-btn').css("cursor", "auto");
				$('.spinner').removeClass('active');
			});
			return false;
			// $(form).submit();
		}
	});
	// step-4 validation
	var d = new Date();
	var current_year = d.getFullYear().toString().substr(-2);
	var creditcard_info = $("#creditcard-info").validate({
		ignore: [],
		invalidHandler: function(event, validator){
			var billing_fields = ['company','zip','phone','address','city','state','country'];
			var invalid_fields = Object.keys(validator.invalid);
			for (var i=0;i<billing_fields.length;i++){
				if ($.inArray(billing_fields[i], invalid_fields) !== -1){
					$('#creditcard-info .step-section-head').addClass('open').next('.step-section-body').slideDown();
					break;
				}
			}
		},
		rules: {
			cc_number: {
				required: true,
				creditcard: true
			},
			cc_expr_month: {
				required: true,
				digits: true,
				range: [1, 12]
			},
			cc_expr_year: {
				required: true,
				digits: true,
				maxlength: 4,
				min: current_year
			},
			cc_cvv: {
				required: true,
				digits: true,
				minlength: 3,
				maxlength: 3
			},
			cc_name: {
				required: true
			},
			'eula': {
				required: true
			},
			company: {
				required: true
			},
			zip: {
				required: true
			},
			phone: {
				required: true
			},
			address: {
				required: true
			},
			city: {
				required: true
			},
			state: {
				required: true
			},
			country: {
				required: true
			}
		},
		submitHandler: function (form) {
			if ($('#creditcard-info .protect-cta-btn').css('cursor') == 'progress') {
				return false;
			}
			//dynamic validation
			var d = new Date();
			var current_month = d.getMonth() + 1;
			var current_year = d.getFullYear().toString().substr(-2);
			var input_year = $(form).find('input[name="cc_expr_year"]').val();
			var input_month = $(form).find('input[name="cc_expr_month"]').val();

			if (input_year == current_year && (input_month < current_month) ){
				creditcard_info.showErrors({'cc_expr_month': 'Please enter a value greater than or equal to '+current_month+'.'});
				return false;
			}



			$('.spinner').addClass('active');
			$("#creditcard-info .protect-cta-btn").css("cursor", "progress");
			var data = $(form).serialize();
			var form_handler = $(form).attr('action');
			$.ajax({
				method: "POST",
				url: form_handler,
				data: data
			})
			.success(function (data) {
				var response = JSON.parse(data);
				// show error on popup
				if (response['popup']) {
					$.notify({
						message: response['popup']
					}, {
						type: 'danger',
						placement: {
							from: "top",
							align: "center"
						},
						delay: 3000,
						onClose: function () {
							if (response['redirect']) {
								window.location.href = response['redirect'];
							}
						},
					});
				}
				if (response['errors']) {
					creditcard_info.showErrors(response['errors']);
				} else {
					if (response['next_step']) {
						window.location.href = response['next_step'];
					}
				}
			})
			.done(function (msg) {
				$('.spinner').removeClass('active');
				$("#creditcard-info .protect-cta-btn").css("cursor", "auto");
			});
			return false;
		}
	});
	var ftp_info = $("#ftp-info").validate({
		rules: {
			ftp_ip: {
				required: true
				// IPv4: true
			},
			ftp_port: {
				required: true,
				digits: true,
				range: [1, 65535]
			},
			ftp_username: {
				required: true
			},
			ftp_password: {
				required: true
			},
			ftp_path: {
				required: true
			}
		},
		submitHandler: function (form) {
			if ($('.connect-ftb-btn').hasClass('success-connect')) {
				console.log($('.connect-ftb-btn').attr('data-href'));
				if ($('.connect-ftb-btn').attr('data-href')){
					window.location.href =  $('.connect-ftb-btn').attr('data-href');
				}
				return false;
			}
			var form_handler = $(form).attr('action');
			if ($('.connect-ftb-btn').css('cursor') == 'progress') {
				return false;
			}
			$('.spinner').addClass('active');
			$(".connect-ftb-btn").css("cursor", "progress");
			$('.ftp-connection-information').detach();
			$('.connect-ftb-btn').removeClass('failed-connect success-connect')
			$('.connect-ftb-btn').text('Enable Scanner');
			var data = $(form).serialize();
			$.ajax({
				method: "POST",
				url: form_handler,
				data: data
			})
			.success(function (data) {
				var response = JSON.parse(data);
				if (response['errors']) {
					ftp_info.showErrors(response['errors']);
				} else {
					if (response['success']) {
						$('.connect-ftb-btn').addClass('success-connect');
						$('.connect-ftb-btn').before('<div class="ftp-connection-information success">FTP Connection Successful</div>');
						$('.connect-ftb-btn').text('Continue');
						if (response['next_step']){
                            $('.connect-ftb-btn').attr('data-href',response['next_step']);
						}
					} else {
						if (response['popup']){
							$.notify({
								message: response['popup']
							}, {
								type: 'danger',
								placement: {
									from: "top",
									align: "center"
								},
								delay: 3000
							});
						} else{
							$('.connect-ftb-btn').addClass('failed-connect');
							$('.connect-ftb-btn').before('<div class="ftp-connection-information">FTP Connection Failed</div>');
						}
					}
				}
			})
			.done(function (msg) {
				$('.spinner').removeClass('active');
				$(".connect-ftb-btn").css("cursor", "auto");
			});
			return false;
			// $(form).submit();
		}
	});
	$('body').on('click', '#country-select .option li', function () {
		var parent_id = $(this).parents('.select').attr('id');
		var text = $(this).text();
		var value = $(this).attr('value');
		$(this).parent('ul').find('li').removeClass('selected');
		$(this).addClass('selected');
		$('#' + parent_id + ' button .selected').text(text);
		$('#' + parent_id + ' button .selected').attr('value', value);
		$('#country').val(value);
		$('#country').trigger('change');
	});
	$('body').on('click', '#currency-select .option li', function () {
		var parent_id = $(this).parents('.select').attr('id');
		var text = $(this).text();
		var value = $(this).attr('value');
		var currency = $(this).data('symbol');
		$('.currency-symbol').each(function(index){
			$(this).text(currency);
		});
		$(this).parent('ul').find('li').removeClass('selected');
		$(this).addClass('selected');
		$('#' + parent_id + ' button .selected').text(text);
		$('#' + parent_id + ' button .selected').attr('value', value);
		$('#currency').val(value);
		$('#currency').trigger('change');
	});
	$('body').on('click', '#period-select .option li', function () {
		var parent_id = $(this).parents('.select').attr('id');
		var text = $(this).text();
		var value = $(this).attr('value');
		$(this).parent('ul').find('li').removeClass('selected');
		$(this).addClass('selected');
		$('#' + parent_id + ' button .selected').text(text);
		$('#' + parent_id + ' button .selected').attr('value', value);
		$('#period').val(value);
		$('#period').trigger('change');
	});
	$('body').on('click', '#dns-type-select .option li', function () {
		var parent_id = $(this).parents('.select').attr('id');
		var text = $(this).text();
		var value = $(this).attr('value');
		$(this).parent('ul').find('li').removeClass('selected');
		$(this).addClass('selected');
		$('#' + parent_id + ' button .selected').text(text);
		$('#' + parent_id + ' button .selected').attr('value', value);
		$('#dns_type').val(value);
		$('#dns_type').trigger('change');
	});
	$('body').on('click', '#dns-ttl-select .option li', function () {
		var parent_id = $(this).parents('.select').attr('id');
		var text = $(this).text();
		var value = $(this).attr('value');
		$(this).parent('ul').find('li').removeClass('selected');
		$(this).addClass('selected');
		$('#' + parent_id + ' button .selected').text(text);
		$('#' + parent_id + ' button .selected').attr('value', value);
		$('#dns_ttl').val(value);
		$('#dns_ttl').trigger('change');
	});
	$('body').on('click', '.all-records-table .record-delete', function () {
		$(this).parents('tr').detach();
	});
	$('body').on('keyup', '#creditcard-info #cc_number, #creditcard-info #cc_expr_month, #creditcard-info #cc_expr_year, #creditcard-info #cc_cvv', function () {
		var re = /^\d+$/g;
		var str = $(this).val();
		if (!re.test(str)) {
			$(this).val(str.replace(/[^\d+]/g, ''));
		}
	});
});
