<body class="plans control-css controlplans">
<form action="<?php echo parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH); ?>?step=profile" method="post" id="form-plan">
    <input name="plan" id="field-plan" type="hidden">
    <!-- Start: Membership plans -->
    <div class="membership-plans">
        <div class="container">
            <div class="row">
                <div class="col-sm-3 col-md-4">
                    <div class="plans-left">
                        <h1>Membership plans</h1>
                        <h2>Join cWatch, the world's most secure website safety solution</h2>
                        <br>
                        <div class="plans-include">
                            <p>EVERY plan Includes:</p>
                            <ul class="list-unstyled">
                                <li><strong>24 / 7 /365 Immediate Live Assistance</strong><br> A live person on the phone, chat, or email - ready to assist with your all your security needs when ever and where ever.</li>
                                <li><strong>Easy Deployment</strong><br> Our solution is easy to use with any website or CMS platform regardless of size or purpose.</li>
                            </ul>
                        </div>
                        <div class="guarantee-arrow">
                            <div><img src="images/guarantee-logo.png" alt="Guarantee Logo"></div>
                            <div><p>30-Day Guarantee<br><span>No-Hassle refund policy. We stand<br> behind our service, period.</span></p></div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-9 col-md-8">
                    <div class="plans-right text-center">
                        <div class="row">
                            <div class="col-sm-4">
                                <div class="plans plans-green plans-premium">
                                    <h4 class="text-blue">Premium</h4>
                                    <a id="price_retail_cWatchPremium_monthly" name="price_retail_cWatchPremium_monthly" class="hide hidden_price_retail"></a>
                                    <p class="plans-desc">On Demand Analysts</p>
                                    <strong class="price-text"><sup class="currency-symbol">$</sup><span><?php echo $pricePremium; ?> <span class="small">mo</span></span></strong>
                                    <span class="plans-desc-text">- Full Service -</span>
                                    <input value="1" name="premium" id="premium" disabled="">
                                    <small>Domain</small>
                                    <div class="plans-bottom">
                                        <span>Scan every 4 hrs</span>
                                        <p>Expert security tuning<br> Unlimited Malware Removal</p>
                                        <img src="images-new/arrow-down.png" alt="Arrow Down" />
                                    </div>
                                    <div class="plans-btn">
                                        <a class="btn green-btn" href="#" onclick="document.getElementById('field-plan').value = 'premium';document.getElementById('form-plan').submit();">Buy now</a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="plans plans-blue plans-pro">
                                    <h4 class="text-blue">Pro</h4>
                                    <a id="price_retail_cWatchPro_monthly" name="price_retail_cWatchPro_monthly" class="hide hidden_price_retail"></a>
                                    <p class="plans-desc">Complete Protection</p>
                                    <strong><sup class="currency-symbol">$</sup><span><?php echo $pricePro; ?>  <span class="small">mo</span></span></strong>
                                    <span class="plans-desc-text">- Best Seller -</span>
                                    <input value="1" name="pro" id="pro" disabled="">
                                    <small>Domain</small>
                                    <div class="plans-bottom">
                                        <span>Scan every 6 hrs</span>
                                        <p>Unlimited Malware Removal</p>
                                        <img src="images-new/arrow-down.png" alt="Arrow Down" />
                                    </div>
                                    <div class="plans-btn">
                                        <div itemscope itemtype="http://schema.org/Product">
                                            <meta itemprop="name" content="cWatch Website Security Software">
                                            <meta itemprop="description" content="Comodo provides Free Website Security software for comprehensive website protection on the premises as well as in hosted and cloud environments, all without the risk of latency and slowdown.  See Plans Now!" >
                                            <span itemprop="offers" itemscope itemtype="http://schema.org/Offer">
                                                    <meta itemprop="priceCurrency" content="USD" />
                                                    <meta itemprop="price" content="0">
                                        </div>
                                        <a class="btn blue-btn" href="#" onclick="document.getElementById('field-plan').value = 'pro';document.getElementById('form-plan').submit();" >Buy now</a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="plans plans-free">
                                    <h4>Basic</h4>
                                    <a id="price_retail_cWatchBasic_monthly" name="price_retail_cWatchBasic_monthly" class="hide hidden_price_retail"></a>
                                    <p class="plans-desc">+1x Malware Removal</p>
                                    <strong><span>FREE</span></strong>
                                    <span class="plans-desc-text">- No credit card required -</span>
                                    <input value="1" name="domain" id="domain" disabled="">
                                    <small>Domain</small>
                                    <div class="plans-bottom">
                                        <span>Scan Manually</span>
                                        <p>Upgrade anytime for protection</p>
                                        <img src="images-new/arrow-down.png" alt="Arrow Down" />
                                    </div>
                                    <div class="plans-btn">
                                        <a href="#" onclick="document.getElementById('field-plan').value = 'basic';document.getElementById('form-plan').submit();" class="btn grey-btn" id="basic_link">Get now</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>
</body>
