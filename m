Return-Path: <netdev+bounces-115841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92361947FCC
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 19:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2E8F1C21152
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 17:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7193115DBBA;
	Mon,  5 Aug 2024 17:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/0pGzr/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADE715B54F;
	Mon,  5 Aug 2024 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722877207; cv=none; b=ar4Z5jizzvlIh46FANR1JboV0p8VkS5nCJ/DfOvEAGNue33bAcYUDk/I6RPLs9C6fA8sRQIrWHAM0eN2iVIWkY558loHPmH6cqGq0jpkqHhJ1/1uKYEeDeJVHM4PD8+/OlGAFfjA1VxgSt64QR5BmuUTb1Or96P1XdcXhUqwLOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722877207; c=relaxed/simple;
	bh=rMg8tq8sXoox5/aZPFwub+kNjISHhCSdM1/upF/TURs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNNX9N1ZMrQfZO8EeSwFEq9lW2GBr+9+zDIXWStK4/hoUyz2xgFingBjyibHxnjjY7yqyuEysmxmif0MbwSJN3OHPeYswu18buUWO9heyioYW3gnJdHX61h4+bAxbl3hLMG6pD0SNxWLdVWDyXA3yiX655MUKS+V7Dn1p+bMyq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/0pGzr/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA9EC32782;
	Mon,  5 Aug 2024 17:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722877206;
	bh=rMg8tq8sXoox5/aZPFwub+kNjISHhCSdM1/upF/TURs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C/0pGzr/WpVGNgjl3o864EDH0YfyswghtP2JFPG/YAbOf2KUVfUyq7PGLM/NR6kOR
	 87rpEvhMkovWxOOpoS26eZqCZkm32Hv/DNS/TGIDn0xQt+qVkV4Uv/pcKIRArODVGw
	 XSZPJNefb/wzMP3nw6QOpaiSAt507npkIVj2jkaLp6W1HV++Ii2MPaQs2NtqPeILrA
	 RJraREhJYnLWUApH7eLCjdjzggTVQb+kdONsXoXsbZ/VUHiC2QndgokX87ziDWrjoP
	 pS0jGPK9IquwvcbIw+ZEt6KCx+dJnz61lAMX/kW0wfJPUZ1uAlRTBzsGUkcsX5xZZ+
	 vIWJ3+BCyzOug==
Date: Mon, 5 Aug 2024 18:00:02 +0100
From: Simon Horman <horms@kernel.org>
To: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	dl-S32 <S32@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 4/6] net: stmmac: dwmac-s32cc: add basic NXP S32G/S32R
 glue
Message-ID: <20240805170002.GM2636630@kernel.org>
References: <AM9PR04MB85064D7EDF618DB5C34FB83BE2BD2@AM9PR04MB8506.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR04MB85064D7EDF618DB5C34FB83BE2BD2@AM9PR04MB8506.eurprd04.prod.outlook.com>

On Sun, Aug 04, 2024 at 08:50:10PM +0000, Jan Petrous (OSS) wrote:
> NXP S32G2xx/S32G3xx and S32R45 are automotive grade SoCs
> that integrate one or two Synopsys DWMAC 5.10/5.20 IPs.
> 
> The basic driver supports only RGMII interface.
> 
> Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>

...

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32cc.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32cc.c

...

> +static int s32cc_gmac_init(struct platform_device *pdev, void *priv)
> +{
> +	struct s32cc_priv_data *gmac = priv;
> +	int ret;
> +
> +	ret = clk_set_rate(gmac->tx_clk, GMAC_TX_RATE_125M);
> +	if (!ret)
> +		ret = clk_prepare_enable(gmac->tx_clk);
> +
> +	if (ret) {
> +		dev_err(&pdev->dev, "Can't set tx clock\n");
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(gmac->rx_clk);
> +	if (ret)
> +		dev_dbg(&pdev->dev, "Can't set rx, clock source is disabled.\n");
> +	else
> +		gmac->rx_clk_enabled = true;
> +
> +	ret = s32cc_gmac_write_phy_intf_select(gmac);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Can't set PHY interface mode\n");

Should operations on tx_clk and rx_clk be unwound here?

Flagged by Smatch.

> +		return ret;
> +	}
> +
> +	return 0;
> +}

...

> +static int s32cc_dwmac_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct plat_stmmacenet_data *plat;
> +	struct s32cc_priv_data *gmac;
> +	struct stmmac_resources res;
> +	int ret;

Please consider arranging local variables in Networking code
in reverse xmas tree order - longest line to shortest.

Flagged by: https://github.com/ecree-solarflare/xmastree

> +
> +	gmac = devm_kzalloc(&pdev->dev, sizeof(*gmac), GFP_KERNEL);
> +	if (!gmac)
> +		return PTR_ERR(gmac);

This will return 0, perhaps return -ENOMEM ?

Flagged by Smatch.

...

