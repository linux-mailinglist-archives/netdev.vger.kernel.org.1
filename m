Return-Path: <netdev+bounces-295068-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9rweJzQoIWpb/wAAu9opvQ
	(envelope-from <netdev+bounces-295068-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 09:24:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A77A963D9A2
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 09:24:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=ncFrbHrc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295068-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295068-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E74F33006009
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 07:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60D83D6CAB;
	Thu,  4 Jun 2026 07:24:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE08223707
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 07:24:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780557871; cv=none; b=hj3qIrBy1E/nIgVcUqRu0e1Xgcmcg9sWsefpjO1/sn1mq8uiUBDzb/EVJ6/LoB2dKxojgb8ZAXOH8YSXTfXEWa+44GCJXcFElI0fKy5CmBGf8nUbKPj5XnxQulXDX/tsjsK2o90KPEZA1seNpEjPDiZmWcrpaC0+aWKTgBbd7mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780557871; c=relaxed/simple;
	bh=kF8Vlmf1/LFEckQpZufc3SC/K+2W4M/X0bIp7WOBVCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aCgFCnVLC+aV6+bgyzqzKkUjinGkL6hcEMiDcCRDG6VM8t6ykzr7goHLp7nsnhna3xCbvCesg6JZ7gd5nt+rrNhbq7pJek+2+ucQc9OW4QHPk6m9ohOXB6RsKpJPSJtwcMoesCAsKAyUKmH+DtYY3io1E579B7McWj8Xytptj8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ncFrbHrc; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 5D473C6344A
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 07:24:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3252E5FEF7;
	Thu,  4 Jun 2026 07:24:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 096F7106A1739;
	Thu,  4 Jun 2026 09:24:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780557866; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=B0MSZZu4FCZaVylYhNYqwOIj8dwu7s4P1sh+7TqmddQ=;
	b=ncFrbHrcOfy69cmMaIY9qfsIVplRb5/ou9Jowm/GbTLnSdHg50SXOFp6Aq/zpEZbbOfNeZ
	mbpfAIVI3hp3MEu/Vf7dctSrOjmrrGz51YPSslUXq/fGLh5ErD6hJpa1XleookCo8VltGM
	DZclim8KevAzRUttwGqsNOAPbHRqInSAAtIUqHvA74Hn3Z9Liy2lLJw3p2Ygz8h92bHkSX
	aisZkcZxtzgI8ieyl/lo4nh3JVRZ6yaxkOnPwsexXw1/HwWmViXG94fzHEcx+33g2yuyp1
	YZ5TyUNAr4jcWv5IoxaNgQwu+jnp8kRMbyVdx9QgfJAz/gOIVpItmWWnQqt8WQ==
Message-ID: <c7e6f722-fc58-4b6d-bdc8-613a9c0ac929@bootlin.com>
Date: Thu, 4 Jun 2026 09:24:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: stmmac: dwmac4: Report DCB feature
 capability
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 rmk+kernel@armlinux.org.uk, o.rempel@pengutronix.de
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260603173644.24371-1-ovidiu.panait.rb@renesas.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260603173644.24371-1-ovidiu.panait.rb@renesas.com>
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
	TAGGED_FROM(0.00)[bounces-295068-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[renesas.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,pengutronix.de];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:ovidiu.panait.rb@renesas.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:rmk+kernel@armlinux.org.uk,m:o.rempel@pengutronix.de,m:netdev@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,vger.kernel.org:from_smtp,bootlin.com:mid,bootlin.com:dkim,bootlin.com:from_mime,bootlin.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A77A963D9A2

Hi,

On 6/3/26 19:36, Ovidiu Panait wrote:
> Bit 16 of the MAC HW Feature1 register reports the DCB (Data Centre
> Bridging) feature. Read it so that dma_cap.dcben and the debugfs
> report it accurately. Right now it is always reported as being disabled.
> 
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

This matches with what I have in the iMX8MP ref manual :)

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thank you,

Maxime

> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac4.h     | 1 +
>  drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
> index ffcd036d4c02..6382836828ba 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
> @@ -198,6 +198,7 @@ enum power_event {
>  #define GMAC_HW_FEAT_AVSEL		BIT(20)
>  #define GMAC_HW_TSOEN			BIT(18)
>  #define GMAC_HW_FEAT_SPHEN		BIT(17)
> +#define GMAC_HW_FEAT_DCBEN		BIT(16)
>  #define GMAC_HW_ADDR64			GENMASK(15, 14)
>  #define GMAC_HW_TXFIFOSIZE		GENMASK(10, 6)
>  #define GMAC_HW_RXFIFOSIZE		GENMASK(4, 0)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> index 28728271fbc9..829a23bdad01 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> @@ -391,6 +391,7 @@ static int dwmac4_get_hw_feature(void __iomem *ioaddr,
>  	dma_cap->av = (hw_cap & GMAC_HW_FEAT_AVSEL) >> 20;
>  	dma_cap->tsoen = (hw_cap & GMAC_HW_TSOEN) >> 18;
>  	dma_cap->sphen = (hw_cap & GMAC_HW_FEAT_SPHEN) >> 17;
> +	dma_cap->dcben = (hw_cap & GMAC_HW_FEAT_DCBEN) >> 16;
>  
>  	dma_cap->addr64 = (hw_cap & GMAC_HW_ADDR64) >> 14;
>  	switch (dma_cap->addr64) {


