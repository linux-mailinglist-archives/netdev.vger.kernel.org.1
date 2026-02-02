Return-Path: <netdev+bounces-256004-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJvMIKgJgWkCDwMAu9opvQ
	(envelope-from <netdev+bounces-256004-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 21:31:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A9AD119C
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 21:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B9873004D34
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 20:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429C829D29F;
	Mon,  2 Feb 2026 20:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jawdc6do"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948B022DFA4
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 20:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770064294; cv=none; b=StUkpoDUZFtzPTorNG7lCC0zq0u74FyH2MfTqFTimENd7hWl4ZwvL9pwUgM+EeJ3kXveNtxJOGFoITtfAcH4MRCAxKHxroOnsUZP43775d72DXYg7ZcBOaOPEW5tnC8G9u3X7uPKwlczXtSn1t2jggVyOpDQ3JnOC9UPv0jajhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770064294; c=relaxed/simple;
	bh=CxDKue/QwhEnlG+wJswifFJfqAtRqJfZjvjccCJpzJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SSe4Y1V3mpuW490GkbXN0Vm/q+Lk3plyHvJPtqSb5SKsiv2Hy1dyfKxSp/n4cwCSHwPyKYjDzuBFvGrmdP9/rnwus0pN+ixvhY6awPu3+V0TbJWLgX3eCjGVljPFI5UoimQEF+xgpP6thn6+qpC/0oYkWc6PUbL76JT6WUkKKrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jawdc6do; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b8869cd7bb1so856433566b.1
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 12:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770064291; x=1770669091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MjBpuLkcLUaCRKPdP4eX6OjLAhe9FJoKGb09vlloYBU=;
        b=jawdc6doCvtx4Z1LFBrfCVpZqoUMyclBPaWQNSBkJnPFXDHrApynCXj1aph+AbvpCf
         Luu1unTsdFnKXeO3oB6EBPGwGSmZDh0igjIVSpA0V5fdeMj3zYO7n0vPT3FjfBpXJelB
         ITBlh7RW3i5LRmHc+ixcK2rxludGuclkIR7yvtxBDeKqwkXSloR9xJsLfdlm3zakrXxz
         kB2r7VI4+TFXwfeN9335jftVgoAvjQF+6crTtl8y0XeUJvTa+j32krMuALLFip2XCKQn
         BEZNN0EJiiO1EQf4RUsPlzBVZoMJ9yJ4EdgXEq/SDbjDmn7n0bPAdD4UhEFsa+abypvS
         nypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770064291; x=1770669091;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MjBpuLkcLUaCRKPdP4eX6OjLAhe9FJoKGb09vlloYBU=;
        b=Fw8aYURe6reJFIqaA//bA1GedPKFrBaYwBK+9lSaEP4KvqjFvpRyZXbWmQ+HfTpUaq
         yeff5bEq6LITGuAXaOkIHNxsWqBBxiYAz8g2Mutngb/9+Y17CWWcIRJFEJilZdPmHfd0
         V7ve9++pRZi78MX01RYNhHAFoIWcMMC1PC+RjBGBwfTvwUhK9R4jmux9NF546DN9ldgc
         dKcH6thEKyL3Bh/0P6gNO8/pOhMaC3oT1LrHQkT5+YSdiZDSmD4bCKb8Sp1bQ3aMVIBG
         17wuWJToS38ypUjKLmRGx3bfaMKTv/m15gxGcT5l8BUiry3f+NdldONSpBpJE/EuFGd4
         iZtg==
X-Forwarded-Encrypted: i=1; AJvYcCULp8wlZqx/uXv9qx25/aZggTb0h3RDLwxkPnGw8ZiGhQZS49+Tj7eIpuT0sz1v26va4h53l+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+GWUT2+QnNzwT+wxD1hRRURyZNFOGJ1luzTva65FTylGKwOZj
	FeJIuKRvag/lUjQoHwWU3c3LtV6Qe7iotneWCq8eefq+afj5ZKzSrit4zBSTRw==
X-Gm-Gg: AZuq6aLWXWO43qOZsU7Lez/4T8fY99b6VjUdMkUy1/87XbNaC5skDm5unYkwgRVj2Ad
	ZlUymFFdUeeQILMimHEo+JuLzGgwaafZymRX/op2+c6lag9kxOOSwJzEMhmoC9FI3csyKB12kq3
	ZtxcqdXz9seE3O3oudZcD37nYVo2dMUkV0Y/UUEQWorYA6UlehTUaIzw1HId8Ss3/jCPCxEFfNV
	PX5rVJuHUFJ73zqJm3OWYhU7v8+oOET5DxJVfc+us2zLOHdVC96lFvH0V1GaoPzS0oK/uVcb6IX
	ukkYzxMSp16fVacA6eW9sGJ3fZHa/RAQVtmHMpW6HW6FF+0vtLhbYBp3goZ3OlyIrq/FF599tHV
	tZicVQP2N4+7a5FmhooQAb22F03/1+uVw9ekX4iBOTTiFNZtXszWRgdl1DFmqVpkn/0Oe7dAMzm
	j3jipf2FWonI2TjU3CWvG+rxTm
X-Received: by 2002:a05:600c:1385:b0:47e:dc64:f1c6 with SMTP id 5b1f17b1804b1-482db493eb4mr189595615e9.6.1770058495160;
        Mon, 02 Feb 2026 10:54:55 -0800 (PST)
Received: from [192.168.0.7] ([86.124.200.187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482db623407sm125687055e9.0.2026.02.02.10.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 10:54:54 -0800 (PST)
Message-ID: <f95f73b9-d024-4697-bca1-02fb8bc044af@gmail.com>
Date: Mon, 2 Feb 2026 20:54:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next] net: stmmac: provide flag to disable EEE
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Clark Wang <xiaoning.wang@nxp.com>,
 Daniel Scally <dan.scally@ideasonboard.com>,
 "David S. Miller" <davem@davemloft.net>,
 Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Fabio Estevam <festevam@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, imx@lists.linux.dev,
 Jakub Kicinski <kuba@kernel.org>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Oleksij Rempel <o.rempel@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Rob Herring <robh@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Stefan Klug <stefan.klug@ideasonboard.com>,
 Wei Fang <wei.fang@nxp.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <E1vNUjC-0000000FhjR-0h6P@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
In-Reply-To: <E1vNUjC-0000000FhjR-0h6P@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256004-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,nxp.com,ideasonboard.com,davemloft.net,gmail.com,google.com,lists.linux.dev,kernel.org,lists.infradead.org,st-md-mailman.stormreply.com,vger.kernel.org,pengutronix.de,redhat.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[27];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ovidiupanaitoss@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 00A9AD119C
X-Rspamd-Action: no action


Hi Russell,

On 11/24/25 1:27 PM, Russell King (Oracle) wrote:
> Some platforms have problems when EEE is enabled, and thus need a way
> to disable stmmac EEE support. Add a flag before the other LPI related
> flags which tells stmmac to avoid populating the phylink LPI
> capabilities, which causes phylink to call phy_disable_eee() for any
> PHY that is attached to the affected phylink instance.
> 
> iMX8MP is an example - the lpi_intr_o signal is wired to an OR gate
> along with the main dwmac interrupts. Since lpi_intr_o is synchronous
> to the receive clock domain, and takes four clock cycles to clear, this
> leads to interrupt storms as the interrupt remains asserted for some
> time after the LPI control and status register is read.
> 
> This problem becomes worse when the receive clock from the PHY stops
> when the receive path enters LPI state - which means that lpi_intr_o
> can not deassert until the clock restarts. Since the LPI state of the
> receive path depends on the link partner, this is out of our control.
> We could disable RX clock stop at the PHY, but that doesn't get around
> the slow-to-deassert lpi_intr_o mentioned in the above paragraph.
> 
> Previously, iMX8MP worked around this by disabling gigabit EEE, but
> this is insufficient - the problem is also visible at 100M speeds,
> where the receive clock is slower.
> 
> There is extensive discussion and investigation in the thread linked
> below, the result of which is summarised in this commit message.
> 

We are seeing the same lpi_intr_o interrupt storm on the Renesas RZ/V2H
EVK (dwmac-renesas-gbeth.c). On this platform, lpi_intr_o is routed as a
separate, dedicated interrupt line to the CPU rather than being OR'd
with the main DWMAC interrupt as on iMX8MP. This corresponds to the
"eth_lpi" interrupt in the stmmac bindings:
"""
- description: The interrupt that occurs when Rx exits the LPI state
const: eth_lpi
"""

Looking through the other glue drivers/device-trees, it looks to me that
every platform that defines a separate "eth_lpi" irq might have the
interrupt storm problem.

To fix this issue on these platforms, rather than disabling EEE
altogether, would it be possible to just not request the eth_lpi
interrupt and let EEE continue to work? Perhaps a new flag could let
each platform decide.

If not, maybe this patch could be merged to add the flag that disables
EEE and I will just send a patch to disable EEE on our platforms as well.

Thanks,
Ovidiu


> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Link: https://lore.kernel.org/r/20251026122905.29028-1-laurent.pinchart@ideasonboard.com
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> For Laurent to add to a patch series appropriately adding
> STMMAC_FLAG_EEE_DISABLE to dwmac-imx.c
> 
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 ++++++-
>  include/linux/stmmac.h                            | 9 +++++----
>  2 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 6cacedb2c9b3..ca0eee58a8a8 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -1324,7 +1324,12 @@ static int stmmac_phylink_setup(struct stmmac_priv *priv)
>  				 config->supported_interfaces,
>  				 pcs->supported_interfaces);
>  
> -	if (priv->dma_cap.eee) {
> +	/* Some platforms, e.g. iMX8MP, wire lpi_intr_o to the same interrupt
> +	 * used for stmmac's main interrupts, which leads to interrupt storms.
> +	 * STMMAC_FLAG_EEE_DISABLE allows EEE to be disabled on such platforms.
> +	 */
> +	if (priv->dma_cap.eee &&
> +	    !(priv->plat->flags & STMMAC_FLAG_EEE_DISABLE)) {
>  		/* Assume all supported interfaces also support LPI */
>  		memcpy(config->lpi_interfaces, config->supported_interfaces,
>  		       sizeof(config->lpi_interfaces));
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index f1054b9c2d8a..5ed49d5363ee 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -187,10 +187,11 @@ enum dwmac_core_type {
>  #define STMMAC_FLAG_MULTI_MSI_EN		BIT(7)
>  #define STMMAC_FLAG_EXT_SNAPSHOT_EN		BIT(8)
>  #define STMMAC_FLAG_INT_SNAPSHOT_EN		BIT(9)
> -#define STMMAC_FLAG_RX_CLK_RUNS_IN_LPI		BIT(10)
> -#define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING	BIT(11)
> -#define STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP	BIT(12)
> -#define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY	BIT(13)
> +#define STMMAC_FLAG_EEE_DISABLE			BIT(10)
> +#define STMMAC_FLAG_RX_CLK_RUNS_IN_LPI		BIT(11)
> +#define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING	BIT(12)
> +#define STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP	BIT(13)
> +#define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY	BIT(14)
>  
>  struct mac_device_info;
>  


