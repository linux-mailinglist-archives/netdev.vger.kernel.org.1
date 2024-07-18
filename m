Return-Path: <netdev+bounces-112068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3790934CB7
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 13:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82AD4281CB5
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 11:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE71313A25F;
	Thu, 18 Jul 2024 11:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAfW+tvC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC37F12D745;
	Thu, 18 Jul 2024 11:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721303010; cv=none; b=btG/0pLfi8+hvKpEC9IAWO0MSdf+/L/P5NLTlLoyEQKwoUzQEPH7cpwtSNNtst2OXpubjKiMX6xFJRJeR8ldE2m/6s2oLyBeeR35QCbg00tfnGyJCa7D1QWflcrNiuldC1P8qz9Hmz238B9N3KM0aTgRTTqZ0mlapa7VXGwDUC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721303010; c=relaxed/simple;
	bh=jN0/QurY8fbFswlF/Vv0nFoI4mAtvJrRlJFEDkk6bX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FrdMxOx5sxy/4j3KTsWh/sirLQipqF7Rg2U/0uBFK3EYK5YajZfctG78kbpChHIN4NhByMrptetQ4bOp2AqcDUfsrnIZGLIBvGi1z2YOCtZrejoCrkukafA/lq3q1mA3DvPP96FIawaRlKab8MG3P5npmfScYhP7tnxpSEKjO98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAfW+tvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3B0C116B1;
	Thu, 18 Jul 2024 11:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721303010;
	bh=jN0/QurY8fbFswlF/Vv0nFoI4mAtvJrRlJFEDkk6bX8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lAfW+tvCfa3JP+FrxJXhWYJj/LTTmufGlc6D6HSYzib5Il/kih4AgRVfhUMz65rad
	 v5Mz2kaF6e1fOguxqjaHtAoUMMc4A6iqfgkJ/gsxMXkCzTCdyWxlKzdR5hIX7Lc3z9
	 +Lp1U3SMCAKpQhf4DgvVUKo2uEqDTLvUjn0bQUsWroTAyEukwzUrbspqbzlC6VVxxw
	 BrxrlXmR97/9iSjZFrNi1cQxtWErFg382ewK4NgmkaXApoFSjNsQ27aKY5S1RsZ/nu
	 kcu2QkjfHjwduBVkCJQVof2MiXKw9XJVo8PeY0BnMvTBVsHg7JgU6eIEm65YWO8HTp
	 GTxpPkTQL8GJw==
Message-ID: <0bfeee6a-a425-4892-a062-5ef91db305a3@kernel.org>
Date: Thu, 18 Jul 2024 13:43:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] Bluetooth: hci_uart: Add support for Amlogic HCI
 UART
To: yang.li@amlogic.com, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Ye He <ye.he@amlogic.com>
References: <20240718-btaml-v2-0-1392b2e21183@amlogic.com>
 <20240718-btaml-v2-2-1392b2e21183@amlogic.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240718-btaml-v2-2-1392b2e21183@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/07/2024 09:42, Yang Li via B4 Relay wrote:
> From: Yang Li <yang.li@amlogic.com>
> 
> This patch introduces support for Amlogic Bluetooth controller over
> UART. In order to send the final firmware at full speed. It is a pretty
> straight forward H4 driver with exception of actually having it's own
> setup address configuration.
> 

...

> +static int aml_parse_dt(struct aml_serdev *amldev)
> +{
> +	struct device *pdev = amldev->dev;
> +
> +	amldev->bt_en_gpio = devm_gpiod_get(pdev, "bt-enable",
> +					GPIOD_OUT_LOW);
> +	if (IS_ERR(amldev->bt_en_gpio)) {
> +		dev_err(pdev, "Failed to acquire bt-enable gpios");
> +		return PTR_ERR(amldev->bt_en_gpio);
> +	}
> +
> +	if (device_property_read_string(pdev, "firmware-name",
> +					&amldev->firmware_name)) {
> +		dev_err(pdev, "Failed to acquire firmware path");
> +		return -ENODEV;
> +	}
> +
> +	amldev->bt_supply = devm_regulator_get(pdev, "bt");
> +	if (IS_ERR(amldev->bt_supply)) {
> +		dev_err(pdev, "Failed to acquire regulator");
> +		return PTR_ERR(amldev->bt_supply);
> +	}
> +
> +	amldev->lpo_clk = devm_clk_get(pdev, NULL);
> +	if (IS_ERR(amldev->lpo_clk)) {
> +		dev_err(pdev, "Failed to acquire clock source");
> +		return PTR_ERR(amldev->lpo_clk);
> +	}
> +
> +	/* get rf config parameter */
> +	if (device_property_read_u32(pdev, "antenna-number",
> +				&amldev->ant_number)) {
> +		dev_info(pdev, "No antenna-number, using default value");
> +		amldev->ant_number = 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int aml_power_on(struct aml_serdev *amldev)
> +{
> +	int err;
> +
> +	if (!IS_ERR(amldev->bt_supply)) {

How is IS_ERR possible?

> +		err = regulator_enable(amldev->bt_supply);
> +		if (err) {
> +			dev_err(amldev->dev, "Failed to enable regulator: (%d)", err);
> +			return err;
> +		}
> +	}
> +
> +	if (!IS_ERR(amldev->lpo_clk)) {

How is IS_ERR possible?

> +		err = clk_prepare_enable(amldev->lpo_clk);
> +		if (err) {
> +			dev_err(amldev->dev, "Failed to enable lpo clock: (%d)", err);
> +			return err;
> +		}
> +	}
> +
> +	if (!IS_ERR(amldev->bt_en_gpio))

How is IS_ERR possible?

> +		gpiod_set_value_cansleep(amldev->bt_en_gpio, 1);
> +
> +	/* wait 100ms for bluetooth controller power on  */
> +	msleep(100);
> +	return 0;
> +}


Best regards,
Krzysztof


