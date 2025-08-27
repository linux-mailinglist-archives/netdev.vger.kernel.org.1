Return-Path: <netdev+bounces-217275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34905B3826E
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1F8B17AD57
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 12:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C923176E8;
	Wed, 27 Aug 2025 12:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuxqXpGY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0573128A2;
	Wed, 27 Aug 2025 12:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756298036; cv=none; b=nHt14M1Y6lZx7Ew6bcmIHT+pMsKpihNuz5cItwSWu/dbu5neJQkA69yYOChYbQcPLUcrLVgyg28RTrGD5BfCSQP+N0lxC7S4xd93xmQJ6CGEuyVCUqnNoSuQVGCATLWjbBIot1fSMlgCWd2PZwMRk1f/Mfx16DuJRSDcGBqZjG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756298036; c=relaxed/simple;
	bh=QFFLnxve5jfnt/aj0qAy6wDyKiWXv43SteeeAz2KkOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m+1j+5kirxJKQS25Cra8nsh/BB57WHJQH++eO5Cf1b7YXd0+2LkOejqe6/M2XiEaoHibz3h4S/K7Y+AwD2XJyE4w/Vz1dVXekgt4qbYRRTGSVRdvl0+231FCfEKKW2MQGvLG2uOWJTeIke9HL4XnHadp00m7SCBQRwSxXc2tIQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuxqXpGY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F62C4CEEB;
	Wed, 27 Aug 2025 12:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756298034;
	bh=QFFLnxve5jfnt/aj0qAy6wDyKiWXv43SteeeAz2KkOA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DuxqXpGYfRjDp8pk+06vRhqHzG9UoVmolVwVHT7MKMrwUtzuyMarn72G6dB+t63Ps
	 5bTHs235Y1ead8EoKO0D54Td5b4YcDsLmBVxRa2lz7VoS1HmfZjp8Fi4aTbWB92wPA
	 qPWKG0TtCnZNDXK76pydCJMN7Rw7Xi5W2jefO4rMmwQr8tc98Wz0egvyK+FyjkTd49
	 HE2QVBsv+P57SgX+FVVvYhZ0CaeaZidfXM+Wo0KgxyBrUU90b7KzXWJKGzSq/G1A4X
	 LRzC3mSih9CyWLMOO4G/J2cmdOAivJKPPMRCXg24U/C8QIdgRGWThxoiNsyMsyR3SW
	 033KoqsSYuQjQ==
Message-ID: <bb08014c-c85d-48cd-98d3-0a3fe8f890c6@kernel.org>
Date: Wed, 27 Aug 2025 14:33:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net: maxlinear: Add support for MxL LGM
 SoC
To: Jack Ping CHNG <jchng@maxlinear.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, yzhu@maxlinear.com, sureshnagaraj@maxlinear.com
References: <20250826031044.563778-1-jchng@maxlinear.com>
 <20250826031044.563778-3-jchng@maxlinear.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250826031044.563778-3-jchng@maxlinear.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/08/2025 05:10, Jack Ping CHNG wrote:
> Introduce the build system integration and initial implementation for the

Nothing improved - do not describe how kernel works, builds. We all know
Kconfig.

Describe the driver and hardware.

> MaxLinear LGM SoC Ethernet driver. This patch adds Kconfig and Makefile

Please do not use "This commit/patch/change", but imperative mood. See
longer explanation here:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95


...

> +
> +static int mxl_eth_probe(struct platform_device *pdev)
> +{
> +	struct mxl_eth_drvdata *drvdata;
> +	struct reset_control *rst;
> +	struct net_device *ndev;
> +	struct device_node *np;
> +	int ret, i;
> +
> +	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
> +	if (!drvdata)
> +		return -ENOMEM;
> +
> +	drvdata->clks = devm_clk_get_enabled(&pdev->dev, "ethif");
> +	if (IS_ERR(drvdata->clks))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->clks),

That's correct...

> +				     "failed to get/enable clock\n");
> +
> +	rst = devm_reset_control_get_optional(&pdev->dev, NULL);
> +	if (IS_ERR(rst)) {
> +		dev_err(&pdev->dev,
> +			"failed to get optional reset control: %ld\n",
> +			PTR_ERR(rst));


But here nothing improved.

Please look how ALL DRIVERS do it? What syntax they use?

Do your homework and really work on this driver. If I pointed issue on
clocks, YOU MUST fix it everywhere, not just clocks.


> +		ret = PTR_ERR(rst);
> +		goto err_cleanup;
> +	}
> +
> +	if (rst) {
> +		ret = reset_control_assert(rst);
> +		if (ret)
> +			goto err_cleanup;
> +
> +		udelay(1);
> +
> +		ret = reset_control_deassert(rst);
> +		if (ret)
> +			goto err_cleanup;
> +	}
> +
> +	platform_set_drvdata(pdev, drvdata);
> +
> +	i = 0;
> +	for_each_available_child_of_node(pdev->dev.of_node, np) {
> +		if (!of_device_is_compatible(np, "mxl,eth-mac"))
> +			continue;
> +
> +		ret = mxl_eth_create_ndev(pdev, np, &ndev);
> +		if (ret)
> +			goto err_cleanup;

You leak of node. Use scoped loop.

> +
> +		drvdata->ndevs[i++] = ndev;
> +		if (i >= MXL_NUM_PORT)
> +			break;
> +	}
> +
> +	return 0;
> +
> +err_cleanup:
> +	mxl_eth_cleanup(drvdata);
> +	return ret;
> +}
> +
> +static void mxl_eth_remove(struct platform_device *pdev)
> +{
> +	struct mxl_eth_drvdata *drvdata = platform_get_drvdata(pdev);
> +
> +	mxl_eth_cleanup(drvdata);
> +}
> +
> +/* Device Tree match table */
> +static const struct of_device_id mxl_eth_of_match[] = {
> +	{ .compatible = "mxl,lgm-eth" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, mxl_eth_of_match);
> +
> +/* Platform driver struct */
> +static struct platform_driver mxl_eth_drv = {
> +	.probe    = mxl_eth_probe,
> +	.remove   = mxl_eth_remove,
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +		.of_match_table = mxl_eth_of_match,
> +	},
> +};
> +
> +module_platform_driver(mxl_eth_drv);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Ethernet driver for MxL SoC");


Best regards,
Krzysztof

