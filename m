Return-Path: <netdev+bounces-216922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFA2B3610D
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 15:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0841BA7A4C
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541DF1F0E29;
	Tue, 26 Aug 2025 13:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lL+kZGgP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7291A1ADFFE;
	Tue, 26 Aug 2025 13:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213394; cv=none; b=n26VEh7TTx2c/G9cYlL0zyQtR+1B7fQuPSmPbMBPmuGamgQqxoNwQH1TDXAOcCLLc6s11c1pkJYw9399XlV0XOschEH/A9wArYtwL3VRIoKpdQXAT+k9SHlLjn0cf8yZr9y5CVP5m4o3bJihBFQUJshPobJCdDZV/Y/uW9in2lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213394; c=relaxed/simple;
	bh=28S8eGGHQNJ7T95lYZZNUxv9w0zda1zMBGBrbV1mjS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4okMvwMoYuHZVYOXl2qo6hYc+62aO1W4x9WLuWdGfeUz6MiNo5DcDNte1tnnp6HrnpXWDOKk/ceeH7BdKeev78AvUvkui/T1/5BBNVSa6IfXFX+iCFbVZOe5LBublBtp6++89uzI4imkKK38EEn+r4LL/Ut0AnjFtjWB5ZmyAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lL+kZGgP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cJxbv7ncMMoa1RAgUxCp9znd/FcDXWjXkUE09s858Lk=; b=lL+kZGgPmLS72YgEpZvxyxawBu
	5URBKI+mj+gPDGzmjyjG76w/xIl1jT/nE5wtrQp5zwlDNjqVflQvptam65LeyRCEL7TsT22ivMHGy
	UeM+p+ibJRY/4/zv26gS/368O0ED7Ho9DlsV8dRK2L1X4g05cbA0dF56MkTO5ZmqpqEg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uqtKO-0065of-F9; Tue, 26 Aug 2025 15:03:08 +0200
Date: Tue, 26 Aug 2025 15:03:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jack Ping CHNG <jchng@maxlinear.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, davem@davemloft.net,
	andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, yzhu@maxlinear.com,
	sureshnagaraj@maxlinear.com
Subject: Re: [PATCH net-next v2 2/2] net: maxlinear: Add support for MxL LGM
 SoC
Message-ID: <4a3c0158-eda0-42bc-acfe-daddf8332bf3@lunn.ch>
References: <20250826031044.563778-1-jchng@maxlinear.com>
 <20250826031044.563778-3-jchng@maxlinear.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826031044.563778-3-jchng@maxlinear.com>

> +Maintainers
> +===========
> +
> +See the MAINTAINERS file:
> +
> +    MAXLINEAR ETHERNET DRIVER
> +    M: Jack Ping Chng <jchng@maxlinear.com>
> +    L: netdev@vger.kernel.org
> +    S: Supported
> +    F: drivers/net/ethernet/maxlinear/

Please don't duplicate what is in MAINTAINERs. We have scripts which
monitor how active Maintainers are, and update the file, removing
inactive Maintainers. This duplication will not be updated.

> +
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe168477caa4..e4765bd73615 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15102,6 +15102,14 @@ W:	https://linuxtv.org
>  T:	git git://linuxtv.org/media.git
>  F:	drivers/media/radio/radio-maxiradio*
>  
> +MAXLINEAR ETHERNET DRIVER
> +M:	Jack Ping Chng <jchng@maxlinear.com>
> +L:	netdev@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/net/mxl,lgm-eth.yaml
> +F:	Documentation/networking/device_drivers/ethernet/maxlinear/mxl.rst
> +F:	drivers/net/ethernet/maxlinear/mxl_eth.c

It is probably better to just use drivers/net/ethernet/maxlinear/ so
all files in that directory are covered, like the Makefile, Kconfig
etc.

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
> +				     "failed to get/enable clock\n");
> +
> +	rst = devm_reset_control_get_optional(&pdev->dev, NULL);

Why is this optional? Are there some variants which don't have a
reset?

> +	i = 0;
> +	for_each_available_child_of_node(pdev->dev.of_node, np) {
> +		if (!of_device_is_compatible(np, "mxl,eth-mac"))
> +			continue;

Are there going to be other devices here, with different compatibles?

> +
> +		ret = mxl_eth_create_ndev(pdev, np, &ndev);

Shouldn't you validate reg before creating the device?

	Andrew

