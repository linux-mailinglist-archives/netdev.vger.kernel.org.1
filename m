Return-Path: <netdev+bounces-291297-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAdKJ2U4FGpuKwcAu9opvQ
	(envelope-from <netdev+bounces-291297-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 13:54:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1710C5CA338
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 13:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C4C83005ADE
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 11:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95CD37F736;
	Mon, 25 May 2026 11:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R2XQuj5G"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9B43803DC
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 11:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779710032; cv=none; b=KFSiB5kGebZgVb+Uwkguh1pjrDUjHI+vjzzPD/o7kwMb2n445dx9bfJLEamAoaib1XN/1zlRuOLDP55tEAr0RvMcnXzPqmbJy4aJ/AuWRhwhOKp+9elBdbsrXONiVkUwQY84YuDkI73Obey2Xd1l0BH7Ff98YqYY7HLIE/MqhYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779710032; c=relaxed/simple;
	bh=8WpSTiwy75eJj+Yxr71TQj0YfgNEgVTpH8iSg9QPf8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bEEsyyYmrfTn8S2DKQkSMYNlA4H9+oOzoSFfQIi9UB3l/7b6CxJvs2ALekberK0UBp7kGsDFHVnnHHE/3NBJbOl5h7xPsZg6b2pzwhyMq66+aEyXGtJ2kyIJyfVQhk+fnXoS5uz1SCrODH526Ykn1BM/OhucUklm0LEAGUsQ3iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R2XQuj5G; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id CB4F2C2C67D;
	Mon, 25 May 2026 11:54:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D43E9603DC;
	Mon, 25 May 2026 11:53:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5061010810F8B;
	Mon, 25 May 2026 13:53:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779710022; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=mhOJii7SYuw+AMQe29JURQFVtzesQcEr/6Sv+5/6gXA=;
	b=R2XQuj5GH0+oY+cgBYrGvs4mf8Y+hw5/1fxLkDRsH6HXtM0bSonYk3aIBV2M6x4mUGbYVB
	vOK7DwTn9NOMoWRAYzujbAXTY0a05fVQif1B/fOglR4aX1Hg+91SHkbHB51VJ41EcX9+op
	fn3krBHQYWEEmWn732MeI2VZf5EUlTXPRzm69Pw04SN+ptvdcmiyC5+8B6giexqcQ/kNfq
	m6ySmO4s4B8vgNl2XNLgEG84ERmBGpnECJAc/vrc6/u6Ki0sgyc5x3kUOR42EyWFGp9vky
	euYxmlHQaGRd519dyX7MzhWEV228BAaGGCxhfpn7T8sDMVx0FWWX6hZM8oprRw==
Message-ID: <771efc7b-c49b-49cc-af18-af31d6cbbf5a@bootlin.com>
Date: Mon, 25 May 2026 13:53:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: Improve Tx timer arm logic further
To: muhammad.nazim.amirul.nazle.asmade@altera.com, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260525061653.22548-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260525061653.22548-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,st-md-mailman.stormreply.com,lists.infradead.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-291297-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	RCPT_COUNT_TWELVE(0.00)[13]
X-Rspamd-Queue-Id: 1710C5CA338
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 5/25/26 08:16, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> Currently hrtimer_start is called even if hrtimer is
> active. This is unnecessary and expensive in some targets.
> This patch avoids calling hrtimer_start unnecessarily.

This description is a bit lacking on details wrt. the expensiveness
and perf impacts, but I've tested with and without this patch on a
cyclone V with dwmac-socfpga, and I cansee a diff when sending
small UDP packets with :

iperf3 -c <srv> -u -b 0 -l 64

Before this patch, around 45200 pps sent,
after this patch, around 52300 pps sent !

Nice improvement :)

So from my perspective,

Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


> 
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
> Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> ---
>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 3591755ea30b..35da51c26248 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3341,12 +3341,14 @@ static void stmmac_tx_timer_arm(struct stmmac_priv *priv, u32 queue)
>   	 * Try to cancel any timer if napi is scheduled, timer will be armed
>   	 * again in the next scheduled napi.
>   	 */
> -	if (unlikely(!napi_is_scheduled(napi)))
> -		hrtimer_start(&tx_q->txtimer,
> -			      STMMAC_COAL_TIMER(tx_coal_timer),
> -			      HRTIMER_MODE_REL);
> -	else
> +	if (unlikely(!napi_is_scheduled(napi))) {
> +		if (unlikely(!(hrtimer_active(&tx_q->txtimer))))
> +			hrtimer_start(&tx_q->txtimer,
> +				      STMMAC_COAL_TIMER(tx_coal_timer),
> +				      HRTIMER_MODE_REL);
> +	} else {
>   		hrtimer_try_to_cancel(&tx_q->txtimer);
> +	}
>   }
>   
>   /**


