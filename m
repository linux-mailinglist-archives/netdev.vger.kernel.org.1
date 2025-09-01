Return-Path: <netdev+bounces-218606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81372B3D879
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 07:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26B631786A5
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 05:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E75C126C1E;
	Mon,  1 Sep 2025 05:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etCe02rY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049FB3C26;
	Mon,  1 Sep 2025 05:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756702869; cv=none; b=W7gzU3bkIZhGOvhvQlKwErhcX3Q+xAGHMxmHFC2SZEm/Zb9ocht9oQmAnkxZAZbI2TwYPG+kQhFhGkRqrGs4UEDssfUnIRSfHm4M8P2H0hDrvpPSqZVoe7d/u78heNQlPQflCs1I5c7U1ERaD0fPAOavUzXhqFWkya/QUjXt0Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756702869; c=relaxed/simple;
	bh=96get+K56x61sWeSDAevSGSJ68Y7h16TlQZJb0tVu0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udKk38ztCEeV3dtJRfz42nVFE0LVYY30ryNvk2I9+eCOgbudfDBMwKgYGmfnJcLTHvH58OEgWqguO8Ac4c7BOQLPIswDudRO5wjHzqPWegq7f31TXQb7Qjq3XeDy4Ui+ZPS8u8bzb9lWe57fTHFhyMY5caWg6knYIy89ixNlTDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etCe02rY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0FEC4CEF0;
	Mon,  1 Sep 2025 05:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756702868;
	bh=96get+K56x61sWeSDAevSGSJ68Y7h16TlQZJb0tVu0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=etCe02rYwRpgE+SiDs/5tUecT57aWUJvxNz7KcQOk81BTbrmIjKChzlB/khzOuS2G
	 azRgI9uGql2u2IPCJstOxPv1ki4V4PO+5btvwQkUHPEWr37fwTUxBTysKAasBRruLJ
	 lVGq+RbTbKy5drEaVueqtXBtlN1eCLsdrORQQV5xGTu0aqcOmclarukFjDvox/L0ow
	 3IniolVa7Z+K2yjki4ESpBMTH2HzCp2K9jj88hRL942tII56qwWYZ/VtskHdluy7XQ
	 NPsMo8HwgecY8RJl1dD3+ShC2jvJvX6DMbe+9T4dl2N6uTN7pEV7I5EJGArEZQMZNo
	 Agav5NhZJO5eQ==
Date: Mon, 1 Sep 2025 07:01:05 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jack Ping CHNG <jchng@maxlinear.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	yzhu@maxlinear.com, sureshnagaraj@maxlinear.com
Subject: Re: [PATCH net-next v3 2/2] net: maxlinear: Add support for MxL LGM
 SoC
Message-ID: <20250901-lumpy-lilac-ara-add2e2@kuoka>
References: <20250829124843.881786-1-jchng@maxlinear.com>
 <20250829124843.881786-3-jchng@maxlinear.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250829124843.881786-3-jchng@maxlinear.com>

On Fri, Aug 29, 2025 at 08:48:43PM +0800, Jack Ping CHNG wrote:
> +
> +static int mxl_eth_probe(struct platform_device *pdev)
> +{
> +	struct mxl_eth_drvdata *drvdata;
> +	struct device_node *eth_np, *np;
> +	struct reset_control *rst;
> +	int ret, i = 0;
> +
> +	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
> +	if (!drvdata)
> +		return -ENOMEM;
> +
> +	drvdata->port_base =
> +		devm_platform_ioremap_resource_byname(pdev, "port");

Very odd wrapping. That's one line or wrap according to Linux coding
style.

> +	if (IS_ERR(drvdata->port_base))
> +		return PTR_ERR(drvdata->port_base);
> +
> +	drvdata->ctrl_base =
> +		devm_platform_ioremap_resource_byname(pdev, "ctrl");

Fix wrapping

> +	if (IS_ERR(drvdata->ctrl_base))
> +		return PTR_ERR(drvdata->ctrl_base);
> +
> +	drvdata->clks = devm_clk_get_enabled(&pdev->dev, "ethif");
> +	if (IS_ERR(drvdata->clks))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->clks),
> +				     "failed to get/enable clock\n");
> +
> +	rst = devm_reset_control_get(&pdev->dev, NULL);
> +	if (IS_ERR(rst))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rst),
> +				     "failed to get reset control\n");
> +
> +	reset_control_assert(rst);
> +	udelay(1);
> +	reset_control_deassert(rst);
> +
> +	platform_set_drvdata(pdev, drvdata);
> +
> +	eth_np = of_get_child_by_name(pdev->dev.of_node, "ethernet-ports");
> +	if (!eth_np)
> +		return dev_err_probe(&pdev->dev, -ENODEV,
> +				     "no ethernet-ports node found!\n");
> +
> +	for_each_available_child_of_node(eth_np, np) {

No, I asked you to use scoped loop.

> +		ret = mxl_eth_create_ndev(pdev, np, &drvdata->ndevs[i++]);
> +		if (ret) {
> +			of_node_put(np);

Best regards,
Krzysztof


