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
                <div class="step-section">
                    <div class="step-number">2</div>
                    <div class="step-description">Order</div>
                </div>
                <div class="step-section active">
                    <div class="step-number">3</div>
                    <div class="step-description">Complete</div>
                </div>
                <div class="p-box-block payment-step">
                    <form method="post">
                        <div class="step-container">
                            <div class="left-col">
                                <div class="step-body">
                                    <div class="step-section-head open">Thank you for your order. Your payment successfully processed online.</div>

                                    <div >
                                        <span>Please check mail for <span id="product-period"><?php echo $email; ?></span> to continue with your cWatch activation.
                                        </span>
                                    </div>

                                    <div class="step-section-body">
                                        <div class="row order-container">
                                            <div class="col-sm-10 padding-5">

                                                <div class="order-description">
                                                    <span class="title">Congratulation cWatch is licensed for <span id="product-period"><?php echo $period; ?>!</span>
                                                    </span>
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
