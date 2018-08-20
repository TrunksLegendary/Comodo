<body class="">
<!-- Main Content Start -->
<div class="main-content">
    <div class="container">
        <div class="row">
            <div class="col-md-9">
                <div class="step-section ">
                    <div class="step-number">1</div>
                    <div class="step-description">Select a plan</div>
                </div>
                <div class="step-section active">
                    <div class="step-number">2</div>
                    <div class="step-description">Order</div>
                </div>
                <div class="step-section">
                    <div class="step-number">3</div>
                    <div class="step-description">Complete</div>
                </div>
                <div class="p-box-block payment-step">
                    <form method="post">
                        <input type="hidden" name="plan" value="<?php echo $plan; ?>">
                        <input type="hidden" name="submit" value="1">
                        <div class="step-container">
                            <div class="left-col">
                                <div class="step-body">
                                    <div style="color: red;"><?php echo implode('<br>', $errors); ?></div>
                                    <div class="step-section-head open" <?php if($plan == "basic") echo "style='display:none'"; ?> >Payment Profile</div>
                                    <div class="step-section-body" <?php if($plan == "basic") echo "style='display:none'"; ?> >
                                        <div class="row no-margin">
                                            <div class="col-sm-12 padding-5">
                                                <label>Card number</label>
                                            </div>
                                            <div class="col-sm-7 padding-5">
                                                <div class="form-group">
                                                    <div class="card-input">
                                                        <input
                                                                id="cc_number"
                                                                class="form-control"
                                                                name="cc_number"
                                                                type="text"
                                                                placeholder="#"
                                                                maxlength="16"
                                                                value="<?php echo $formValues['cc_number']; ?>"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-1 padding-5">
                                                <div class="form-group">
                                                    <input
                                                            id="cc_expr_month"
                                                            class="form-control"
                                                            name="cc_expr_month"
                                                            type="text"
                                                            placeholder="MM"
                                                            maxlength="2"
                                                            value="<?php echo $formValues['cc_expr_month']; ?>"/>
                                                </div>
                                            </div>
                                            <div class="col-sm-2 padding-5">
                                                <div class="form-group">
                                                    <input
                                                            id="cc_expr_year"
                                                            name="cc_expr_year"
                                                            type="text"
                                                            placeholder="YY"
                                                            class="form-control"
                                                            maxlength="2"
                                                            value="<?php echo $formValues['cc_expr_year']; ?>"/>
                                                </div>
                                            </div>
                                            <div class="col-sm-2 padding-5">
                                                <div class="form-group">
                                                    <input
                                                            id="cc_cvv"
                                                            name="cc_cvv"
                                                            type="text"
                                                            placeholder="CVC"
                                                            value="<?php echo $formValues['cc_cvv']; ?>"
                                                            class="form-control"
                                                            minlength="3"
                                                            maxlength="3"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row no-margin">
                                            <div class="col-sm-7 padding-5">
                                                <div class="form-group">
                                                    <label>Cardholder name</label>
                                                    <input
                                                            id="cc_name"
                                                            name="cc_name"
                                                            type="text"
                                                            placeholder="Name displayed on card"
                                                            class="form-control"
                                                            value="<?php echo $formValues['cc_name']; ?>"/>
                                                </div>
                                            </div>
                                            <div class="col-sm-2 padding-5">
                                                <label class="label-style-1">Currency</label>
                                                <div id="currency-select" class="input-group-btn select">
                                                    <select class="selectpicker" name="cc_currency">
                                                        <?php echo $currencies; ?>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-sm-3 padding-5">
                                                <label class="label-style-1">Period</label>
                                                <div id="period-select" class="input-group-btn select">
                                                    <select class="selectpicker" name="period" >
                                                        <?php echo $periods; ?>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row order-container">
                                            <div class="col-sm-10 padding-5">
                                                <div class="form-group">
                                                    <input
                                                            id="eula"
                                                            disabled=""
                                                            class="form-control checkbox-type-1"
                                                            name="eula"
                                                            type="checkbox" checked>
                                                    <label for="eula" class="checkbox-type-1" >
                                                        I have read and agree to the <a target="_blank" href="https://www.comodo.com/repository/docs/cWatchWebSecurityEULA(20160202).pdf">End User license/Service Agreement</a>
                                                    </label>
                                                </div>
                                                <div class="order-description">
                                                    <span class="title">Order Summary</span>
                                                    <div>
                                                        <span id="product-price"><sup class="currency-symbol">$</sup><?php echo $price; ?></span>
                                                        /
                                                        <span id="product-period">Monthly</span>
                                                        /
                                                        <span id="product-plan"><?php echo $plan; ?> plan</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-2 padding-5">
                                                <div class="order-amount">
                                                    <div class="sub-total">
                                                        <div class="price-heading">Subtotal</div>
                                                        <div class="amount"><sup class="currency-symbol">$</sup><?php echo $price; ?></div>
                                                    </div>
                                                    <div class="savings">
                                                        <div class="price-heading">Savings</div>
                                                        <div class="amount"><sup class="currency-symbol">$</sup>0.<sup>00</sup></div>
                                                    </div>
                                                    <div class="final-amount">
                                                        <div class="price-heading">Total</div>
                                                        <div class="amount"><sup class="currency-symbol">$</sup><?php echo $price; ?></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="step-section-head">Billing address</div>
                                    <div class="step-section-body billing-section">
                                        <div class="row no-margin">
                                            <div class="col-sm-6 padding-5">
                                                <div class="form-group">
                                                    <label class="label-style-1">First name</label>
                                                    <input
                                                            name="first_name"
                                                            type="text"
                                                            placeholder=""
                                                            class="form-control"
                                                            value="<?php echo $formValues['first_name']; ?>"/>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 padding-5">
                                                <div class="form-group">
                                                    <label class="label-style-1">Last name</label>
                                                    <input
                                                            name="last_name"
                                                            type="text"
                                                            placeholder=""
                                                            class="form-control"
                                                            value="<?php echo $formValues['last_name']; ?>"/>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 padding-5">
                                                <div class="form-group">
                                                    <label class="label-style-1">Address</label>
                                                    <input
                                                            name="address"
                                                            type="text"
                                                            placeholder=""
                                                            class="form-control"
                                                            value="<?php echo $formValues['address']; ?>"/>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 padding-5">
                                                <div class="form-group">
                                                    <label class="label-style-1">Email</label>
                                                    <input
                                                            name="email"
                                                            type="text"
                                                            placeholder=""
                                                            class="form-control"
                                                            value="<?php echo $formValues['email']; ?>"/>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 padding-5">
                                                <div class="form-group">
                                                    <label class="label-style-1">City</label>
                                                    <input
                                                            name="city"
                                                            type="text"
                                                            placeholder=""
                                                            class="form-control"
                                                            value="<?php echo $formValues['city']; ?>"/>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 padding-5">
                                                <div class="form-group">
                                                    <label class="label-style-1">State</label>
                                                    <input
                                                            name="state"
                                                            type="text"
                                                            placeholder=""
                                                            class="form-control"
                                                            value="<?php echo $formValues['state']; ?>"/>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 padding-5">
                                                <div class="form-group">
                                                    <label class="label-style-1">Country</label>
                                                    <div id="country-select" class="input-group-btn select">
                                                        <select class="selectpicker" name="country">
                                                            <?php echo $countries; ?>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 padding-5">
                                                <div class="form-group">
                                                    <label class="label-style-1">Postal code</label>
                                                    <input
                                                            name="zip"
                                                            type="text"
                                                            placeholder=""
                                                            class="form-control"
                                                            value="<?php echo $formValues['zip']; ?>"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="cta-btn">
                                        <button
                                                class="protect-cta-btn spinner"
                                                type="submit">
                                            Process Payment
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>

            </div>
        </div>
    </div>
</div>
</body>
