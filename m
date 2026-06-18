Return-Path: <netdev+bounces-300330-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oZXmG1SYM2rYDwYAu9opvQ
	(envelope-from <netdev+bounces-300330-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 09:03:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B6069DF77
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 09:03:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=z9hUWqH8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300330-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300330-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4FA7F300BC51
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 07:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210103AA1A8;
	Thu, 18 Jun 2026 07:03:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D6B78F39;
	Thu, 18 Jun 2026 07:03:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781766219; cv=none; b=Ignb3fOSWhxjjcHA+bzXFADdQNDYDfWVsKcPYhjRNiJQK2KQ8zWLlstq2xdbzF2PHeF7KBLm5tY7RfYZGEeBUK/nZzTGKs5KUoGJF40IRMGjikqeBewKaRGUFsFxizjymSIvuJTjB3z92p3+oWAfC+I+6PQET4T07CDdNdrOH5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781766219; c=relaxed/simple;
	bh=JI6vscvMGSCC4HmD+Fb64Zuf/4js9GEzDrzJqRniNGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pz+GEV+gYEs0C6khHmjtlOs/IOBUev8v3whmURCf2nOhbEKMUy9WDgIoW9i63evH/MtnhGqIeEiU3oZVJh+VkcmD9CAjFACIxsu47JWnJd2sN6ChLMxDCYKGNghUYa7LKv/VZKBxi3hDWDhLE5NurRLBiuFyi3gD2ylNWeb34v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=z9hUWqH8; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id CDB10C06CC6;
	Thu, 18 Jun 2026 07:03:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 72E365FF03;
	Thu, 18 Jun 2026 07:03:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5F390106C823E;
	Thu, 18 Jun 2026 09:03:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781766208; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=5xHduvJKmoBDw5ZJr8Mqo8CHiviUc2oC0TXXFw/0eRY=;
	b=z9hUWqH8IVeplt0BiXE3R+kSStEU8GET5xLAykz9NNOYDbRiov+5Ve28wsHz0YEX70hgDq
	3fhC/2DUVYWzUQAcXEHZthNhZXOo97Mxwa5u6+TB8w17SMRVQD25EAp8c4KbU8kos/Gon2
	RX8wKBG8IEy67RhTNc/LifdhOhq0G3voHvLP58oVeK2rB59flHxmm63G7ktysTk84dpazO
	IsaNBIuj2shHw5QNq7PP5zh9e0LCCw2H8gPRG3v/5+gYiFZEzCrk4V4qV7aZa4aoSSh4rn
	dCWS6u1TPFWxSQ6FVudPHcppKKEq52x8zpof+Ptc/MxAnXVfPLeRbZ+ANY5Eqw==
Message-ID: <9b39829d-92b4-4ffa-be0b-b2b0f857f58e@bootlin.com>
Date: Thu, 18 Jun 2026 09:03:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: dwmac-spacemit: Fix wrong ctrl register
 definition
To: Inochi Amaoto <inochiama@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Yixun Lan
 <dlan@kernel.org>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
References: <20260618064143.1102179-1-inochiama@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260618064143.1102179-1-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-300330-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,foss.st.com,armlinux.org.uk];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:inochiama@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:dlan@kernel.org,m:rmk+kernel@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-riscv@lists.infradead.org,m:spacemit@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:dlan@gentoo.org,m:looong.bin@gmail.com,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,m:looongbin@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,gentoo.org,gmail.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:mid,bootlin.com:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 43B6069DF77

Hi Inochi,

On 6/18/26 08:41, Inochi Amaoto wrote:
> There register layout of the phy ctrl register has something wrong,
> fix it to match the right layout
> 
> Fixes: 30f0ba420ed3 ("net: stmmac: Add glue layer for Spacemit K3 SoC")
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-spacemit.c    | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c
> index 223754cc5c79..6feffaa3ef3a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c
> @@ -18,10 +18,12 @@
>  #include "stmmac_platform.h"
>  
>  /* ctrl register bits */
> -#define CTRL_PHY_INTF_RGMII		BIT(3)
> -#define CTRL_PHY_INTF_MII		BIT(4)
> -#define CTRL_WAKE_IRQ_EN		BIT(9)
> -#define CTRL_PHY_IRQ_EN			BIT(12)
> +#define CTRL_PHY_INTF_MODE		GENMASK(4, 3)
> +#define CTRL_PHY_INTF_RMII		FIELD_PREP(CTRL_PHY_INTF_MODE, 0)
> +#define CTRL_PHY_INTF_RGMII		FIELD_PREP(CTRL_PHY_INTF_MODE, 1)
> +#define CTRL_PHY_INTF_MII		FIELD_PREP(CTRL_PHY_INTF_MODE, 3)
> +#define CTRL_PHY_IRQ_EN			BIT(9)
> +#define CTRL_WAKE_IRQ_EN		BIT(12)

Looks like you're fixing 2 things there :

 -> Wake on Lan probably didn't work before, as the wake irq was apparently wrong
 -> The MII mode selection apparently also changes, but maybe you don't have a
    MII board around to test this ?

Is it possible you address these issues independently (i.e. split this in 2 patches) ?
That way, if we ever revert one, we won't re-break the other thing that was broken.


Maxime


