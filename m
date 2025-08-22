Return-Path: <netdev+bounces-215990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AB8B31451
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 11:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B950A3A7DA3
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 09:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3002F3635;
	Fri, 22 Aug 2025 09:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDq/EF+p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E792F3631;
	Fri, 22 Aug 2025 09:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855766; cv=none; b=UO34IfAYn8ov5om8b/TV81X7RgjZXWcGwVfbUvR5hocKvvZAcmsnGrXXc+hbvcvCOvDSWgBcMfZXXSydlm0uXgc5yIAotRZzkI974EBgqgIsttfAPhhB1nb1+ApY9Ra5PgtjXprClzXesou5KGf0uRIqTPZEpQ+RzJ75YGHCZzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855766; c=relaxed/simple;
	bh=AjSIPvmX+WBUEEOhAOa299WYAwKCct5GlSBzXMXwYF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DN4FQOeNBfXRSya+ponH56IuPXW9Xj0xcq0TxWeVXrxbSuodLrBXo3+Skx+tSl430nbjmr5zuBvaqRYal+otdFPjtcWXnrcY+QDZC2XOIXxLgiYlaco0qKnREnSbSp89/nPatkShavfJUCgWPvOTdPdUynIsQxhfWZd5M0OQ9+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDq/EF+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031B4C4CEED;
	Fri, 22 Aug 2025 09:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755855764;
	bh=AjSIPvmX+WBUEEOhAOa299WYAwKCct5GlSBzXMXwYF0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PDq/EF+pv25enQf6FxrVX9Gb3fmQZ5R/jyGdMJBaM3830C7AAWM8XwijIIHO6u3hc
	 py7ySqOuPz8z6xcxooaNlDvzwaUSeD7QfPKavbDA1XyF0K0cO0CahOzGwHipZrWFtf
	 YAtTiNCn8TWkxkqt5RTwhv1dz6Gmrzku0ekBPfaVs3RuNTSMVNjmLe7ddmEbTDsln1
	 8Sl1ss0cYEoWKPCXLOqwTjTz1OSp8o6gqzuWmtXKsiSrkxXYKSttTvpZrqLTbcRNki
	 4Gvr6Drmap4UZMJp8HYxDov4b/O8vC980anYwrrg5mpLdyYht3KGer2NrcGdJmYOGO
	 nB1Lqv9l/OL9A==
Message-ID: <a596db6b-bbc5-4670-ac9f-e6822bad83fa@kernel.org>
Date: Fri, 22 Aug 2025 11:42:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: maxlinear: Add build support for MxL
 SoC
To: Jack Ping CHNG <jchng@maxlinear.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, yzhu@maxlinear.com, sureshnagaraj@maxlinear.com
References: <20250822090809.1464232-1-jchng@maxlinear.com>
 <20250822090809.1464232-2-jchng@maxlinear.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250822090809.1464232-2-jchng@maxlinear.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/08/2025 11:08, Jack Ping CHNG wrote:
> Add build infrastructure for MxL network driver.
> Ethernet driver to initialize and create network devices.

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

What is a "build support for a driver/soc"? Confusing.


...

> + */
> +#include <linux/clk.h>
> +#include <linux/etherdevice.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/netdevice.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +
> +#define ETH_TX_TIMEOUT		(10 * HZ)
> +#define MXL_NUM_TX_RING		8
> +#define MXL_NUM_RX_RING		8
> +#define MXL_NUM_PORT		2
> +
> +static const char * const clk_names = "ethif";

Drop, pretty useless.

...

> +
> +static void mxl_eth_cleanup(struct mxl_eth_drvdata *pdata)
> +{
> +	int i;
> +
> +	for (i = 0; i < MXL_NUM_PORT && pdata->ndevs[i]; i++) {
> +		unregister_netdev(pdata->ndevs[i]);
> +		pdata->ndevs[i] = NULL;
> +	}
> +
> +	if (!IS_ERR(pdata->clks))

Hm? Why?

> +		clk_disable_unprepare(pdata->clks);
> +}
> +
> +static int mxl_eth_probe(struct platform_device *pdev)
> +{
> +	struct mxl_eth_drvdata *pdata;
> +	struct reset_control *rst;
> +	struct net_device *ndev;
> +	struct device_node *np;
> +	int ret, i;
> +
> +	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return -ENOMEM;
> +
> +	pdata->clks = devm_clk_get(&pdev->dev, clk_names);
> +	if (IS_ERR(pdata->clks)) {
> +		dev_err(&pdev->dev, "failed to get %s\n", clk_names);

You are sending us some 10 year old coding style. This is supposed to be
dev_err_probe and devm_get_clk_enabled.

I think my second talk for OSSE 25 about static analyzers is also
suitable...

> +		return PTR_ERR(pdata->clks);
> +	}
> +
> +	ret = clk_prepare_enable(pdata->clks);

> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to enable %s\n", clk_names);
> +		return ret;
> +	}
> +
> +	rst = devm_reset_control_get_optional(&pdev->dev, NULL);
> +	if (IS_ERR(rst)) {
> +		dev_err(&pdev->dev,
> +			"failed to get optional reset control: %ld\n",
> +			PTR_ERR(rst));
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
> +	platform_set_drvdata(pdev, pdata);
> +
> +	i = 0;
> +	for_each_available_child_of_node(pdev->dev.of_node, np) {
> +		if (!of_device_is_compatible(np, "mxl,eth-mac"))
> +			continue;
> +
> +		if (!of_device_is_available(np))

Redundant.


Best regards,
Krzysztof

