Return-Path: <netdev+bounces-297529-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TEQ8OOgiKWo0RQMAu9opvQ
	(envelope-from <netdev+bounces-297529-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:40:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7474667491
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:40:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=1JqGYNOO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297529-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297529-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 439603027CA5
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D013A7195;
	Wed, 10 Jun 2026 08:27:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BCC391E52
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 08:27:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080027; cv=none; b=kwVJV4O2gMIjhX3ekyMZAjajh/0YUd4PrthFDHmmS5fbVWJPcoD7Kbc0znLaHAiPFFlN9gN3QXJq58rjZZL3skTrlB9o4/yFcckSoHVeW0YIljyScf57Oheil1Fs4S6dlt+Rvdqa0Kqba9rsgjVMNgW5XG7eVhv33WsLlYGd/tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080027; c=relaxed/simple;
	bh=6xnEBD+qu7YLDUTxDEOXY/2rGV0YEc1qGNsJfrZkUN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=krT+MzsaiLVViYR8A/dOToGodqwsOeD7fpC6vI8RDLFBlM0fbBzMQg8wICZpLRvHaXmnQrqyKd/TGFAuMxQy1HKxILLvaPvHBuBLSVx5VV5gVzLKYltknlVZNnyAzfCqwAtfNDfMCb77CmETeq25LJihOZ72i8X3DRit+KKYhUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1JqGYNOO; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BAA9C1A369C;
	Wed, 10 Jun 2026 08:27:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8A7325FFC9;
	Wed, 10 Jun 2026 08:27:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 81A4F106B9056;
	Wed, 10 Jun 2026 10:26:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781080022; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Whfl4QLl7rlDdWuJnD1FYGrTxAzK/P2e2aQDPSeDeSQ=;
	b=1JqGYNOOL1Pl5I9EUrbk8Gh6N8JpYRafqUk235S6QQUxecR7HLECmGB54SN7PPv4uNYCcf
	0N503XbHO4hBTdwsh/tzzj5j7oLUxc8Wlt5VT0aBcomUHRwC44BrID/CP2VW4ZlcrIR/l7
	wPrerAVivv5Dta96h0JcuCaS69Uul6GoEWqp+ilBENCM90FKwZ187AmYNy7K0Z5VNUKIFO
	KSaURLkQpn7Ml/WV93S/y4viL5xCmFxdk1GYve8IGrdpBGpgUdF5oGnAx1oB1X3ictlFE8
	Ft7rQMA58/2cDT0y4WGvLyyQ8k5f3inDbfI6/9BvuK72Nzrb5G9RbANHO60Ibw==
Message-ID: <eaa645fc-be06-4a15-8c2f-6e82129c4715@bootlin.com>
Date: Wed, 10 Jun 2026 10:26:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 3/6] net: stmmac: eic7700: make RGMII delay
 properties optional
To: lizhi2@eswincomputing.com, devicetree@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 linux-riscv@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com,
 pinkesh.vaghela@einfochips.com, pritesh.patel@einfochips.com,
 weishangjuan@eswincomputing.com, horms@kernel.org, lee@kernel.org
References: <20260610012727.848-1-lizhi2@eswincomputing.com>
 <20260610012937.911-1-lizhi2@eswincomputing.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260610012937.911-1-lizhi2@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297529-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[eswincomputing.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,st-md-mailman.stormreply.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:lizhi2@eswincomputing.com,m:devicetree@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:rmk+kernel@armlinux.org.uk,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:linux-riscv@lists.infradead.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:ningyu@eswincomputing.com,m:linmin@eswincomputing.com,m:pinkesh.vaghela@einfochips.com,m:pritesh.patel@einfochips.com,m:weishangjuan@eswincomputing.com,m:horms@kernel.org,m:lee@kernel.org,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,eswincomputing.com:email,bootlin.com:dkim,bootlin.com:mid,bootlin.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D7474667491

Hi,

On 6/10/26 03:29, lizhi2@eswincomputing.com wrote:
> From: Zhi Li <lizhi2@eswincomputing.com>
> 
> Make rx-internal-delay-ps and tx-internal-delay-ps optional in the
> EIC7700 DWMAC driver.
> 
> The driver previously required both properties to be present and would
> fail probe when they were missing. This restricts valid hardware
> configurations where RGMII timing is instead provided by the PHY or
> board design.
> 
> Update the driver to treat missing delay properties as zero delay,
> allowing systems without explicit MAC-side delay tuning to operate
> correctly.
> 
> This aligns the driver behavior with the updated device tree binding
> and provides a safe default configuration when MAC-side delay
> programming is not required.
> 
> Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
> index 4ac979d874d6..ec99b597aeaf 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
> @@ -165,9 +165,6 @@ static int eic7700_dwmac_probe(struct platform_device *pdev)
>  		dwc_priv->eth_clk_dly_param &= ~EIC7700_ETH_RX_ADJ_DELAY;
>  		dwc_priv->eth_clk_dly_param |=
>  				 FIELD_PREP(EIC7700_ETH_RX_ADJ_DELAY, val);
> -	} else {
> -		return dev_err_probe(&pdev->dev, -EINVAL,
> -			"missing required property rx-internal-delay-ps\n");
>  	}
>  
>  	/* Read tx-internal-delay-ps and update tx_clk delay */
> @@ -187,9 +184,6 @@ static int eic7700_dwmac_probe(struct platform_device *pdev)
>  		dwc_priv->eth_clk_dly_param &= ~EIC7700_ETH_TX_ADJ_DELAY;
>  		dwc_priv->eth_clk_dly_param |=
>  				 FIELD_PREP(EIC7700_ETH_TX_ADJ_DELAY, val);
> -	} else {
> -		return dev_err_probe(&pdev->dev, -EINVAL,
> -			"missing required property tx-internal-delay-ps\n");
>  	}

I think then you need to handle RGMII, RGMII_ID, RGMII_RXID and RGMII_TXID,
by using default delays for these (usually around 2ns), as here all delays
will be set to 0, regardless of the RGMII mode in use.


Maxime

>  
>  	dwc_priv->eic7700_hsp_regmap =


