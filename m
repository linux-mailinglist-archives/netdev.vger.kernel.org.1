Return-Path: <netdev+bounces-234637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390D6C24E18
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 12:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F01D73B28FE
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 11:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A53B3081AB;
	Fri, 31 Oct 2025 11:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gqKwR/Co"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FC517C9E
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 11:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761911613; cv=none; b=mLXIsWelrJ1n1PeWJUjfXLkMydlEYPoBRv7HswEOsYt7Lll/loLaATBA5JrEvVRM57eEPLP2MGKsVMuGA6ArCay49OK6E3oyJslcRTt8ZxwR4Dl8omF55ZRRH3HqE5iYoJR9/snHF9qf5yTk0OkjXbRru31qwFmAE+ym44qkhC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761911613; c=relaxed/simple;
	bh=hkbfbTaIJrx7uJJcYUV7VxYaRHnvwsAmqPc8qiVkiWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XG1FMQWfj0j9yXmWF2aypHxHN3b/jXQ5ehG6Ui5zRD8mH9smqBn9aFA4cSvB40SYMFQ/FNzDxxGmrpxRdfaG2P2doU1aV9DLL+jORTg9mcXJ1PZwtuu8WgPtaLgW0cfL87k0sx7FYw3h0sk4TCP8gRV0ke2eMkf+WnenSKvoV+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gqKwR/Co; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E7D664E41439;
	Fri, 31 Oct 2025 11:53:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BA19160704;
	Fri, 31 Oct 2025 11:53:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F171D118120AD;
	Fri, 31 Oct 2025 12:53:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761911607; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=od4tl//dkTjTTGruGKmAJY8x9vKseCkLwaepLH9PMTU=;
	b=gqKwR/CoH45ZjL/r6y039td1WrA3k224uIqW+R73xxUh2pc8PGQjGi4BPbx8t8QYiDup2j
	Dg5E6vslqvFHFBlm9PfNtuEYxQhPL8DkwBrr7GHb1+mlTg8V24sWgrgdoEoJFVUwbJLF6z
	f8R44rk8WH//zLPrjZJeCxuQwX6I/8HOUmgT3XtrmGCHfF9VOYHk37enoPP4B1WonpSIlZ
	YAujIsDnmsXY2FB5846Al9F/YIZN5AOBb6vJkys8fVvs0f0c9LNaYQ4f6PwVoF4SzFikVm
	mER8Ymg7LwFJT3XtuuG3PK+CkQU2ZBU6H/Uh7SPTYivUyYI+CmTtzN/Cdxh9Fw==
Message-ID: <baa56d1d-02f2-4c87-a3da-a7c1cba5a34a@bootlin.com>
Date: Fri, 31 Oct 2025 12:53:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: stmmac: imx: use phylink's interface mode
 for set_clk_tx_rate()
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
References: <E1vEn1W-0000000CHoi-2koP@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1vEn1W-0000000CHoi-2koP@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Russell,

On 31/10/2025 12:10, Russell King (Oracle) wrote:
> imx_dwmac_set_clk_tx_rate() is passed the interface mode from phylink
> which will be the same as plat_dat->phy_interface. Use the passed-in
> interface mode rather than plat_dat->phy_interface.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Tested on imx8mp w/ rgmii-id PHY (ksz9131)

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> index 4268b9987237..147fa08d5b6e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> @@ -195,9 +195,6 @@ static void imx_dwmac_exit(struct platform_device *pdev, void *priv)
>  static int imx_dwmac_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
>  				     phy_interface_t interface, int speed)
>  {
> -	struct imx_priv_data *dwmac = bsp_priv;
> -
> -	interface = dwmac->plat_dat->phy_interface;
>  	if (interface == PHY_INTERFACE_MODE_RMII ||
>  	    interface == PHY_INTERFACE_MODE_MII)
>  		return 0;


