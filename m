Return-Path: <netdev+bounces-295167-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /3uUM1tTIWomDgEAu9opvQ
	(envelope-from <netdev+bounces-295167-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:28:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C87A63F046
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:28:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=q5mpUZ8e;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295167-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295167-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FD0C3091F0F
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 10:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCCF3815CE;
	Thu,  4 Jun 2026 10:22:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAFF373C0E
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 10:22:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780568572; cv=none; b=ECrD7iedLzivHofSErgeL5KWAE5m1k6sP7fi830T0xVYXIQcCZDHtPwd73OcolTmdMo7n0Q5OJuj8WqSRm+9hEhdnKaGEcObIYeIKcNG3HtXRDfDL0/lpCdOWDhlOMX8BnfB0ssXDWhbaXsgmJREceHJgR6awxTCA2PjrYg7ul4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780568572; c=relaxed/simple;
	bh=cACz35Uc2+a6MPuu6gpXvq4GoXJj99xU4zRRb8Ib+CI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ls2Ca1U5yGBkNLg6H7mprMY32NMuWVM1clPLjnTY5/N8ImlRxRTCEVVvGnmYeah8UEzG4qVb5nrrSAnOnNqrThQQW8rW2W+SLBaaVhjC4Jg+CJ7x+9S+etlAYjEFuT0Um+xS3JuE/wGrCWhNb3WE2clLHdLpXwXKMFmQg9ue39Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=q5mpUZ8e; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5D3B14E405AC;
	Thu,  4 Jun 2026 10:22:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1AE445FEF7;
	Thu,  4 Jun 2026 10:22:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A1C13106A18E4;
	Thu,  4 Jun 2026 12:22:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780568567; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=kcL0ulMNPC0gnHlGvkBUUzYgmWFlYbvTgn3AllNsYeI=;
	b=q5mpUZ8evVG0PqKkVaAUYt+QerlJ4hm4cJk+tj9GzqGXqkuBakctwV+wt1DlQI51n3Ocqv
	CO6d0W92xJVGWpxLOhFOfQzdr0fsXQSppCtzmIK7cLdnFLCbXw+a+8ePl1ptwPEd67UTOq
	T0tCBaHUievmhAB5AZ0NOI8fgj+L7jd5SeiXzkdG3df5xz16X5/KLBZvTkslhngYHkZG0N
	T1Jxy2hpzLK1Vc/qOh3pHoHCJhQwlBMHEd20F7D6lLSj5aR24FjHxkdfN8UfIsfztt71qz
	pm43YJdEFMzX2GdVUrYEC6DpxpHnqEKxd6sq1zCm/6kZ/XPfbaCHhN505S+eUA==
Message-ID: <993cc534-63a6-4cc9-a54b-efc78acdb38b@bootlin.com>
Date: Thu, 4 Jun 2026 12:22:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] net: phy: as21xxx: force C45 OPs for AUTONEG
To: Christian Marangi <ansuelsmth@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260601105342.28865-1-ansuelsmth@gmail.com>
 <20260601105342.28865-3-ansuelsmth@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260601105342.28865-3-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295167-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ansuelsmth@gmail.com,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C87A63F046



On 6/1/26 12:53, Christian Marangi wrote:
> With further testing with 2.5G NIC, it was discovered that the PHY
> require the C45 OPs to configure and restart ANEG or speed higher than
> 1G doesn't function correctly.
> 
> To force C45 OPs with generic PHY function, clear the C22 bit from
> devices_in_package bitmask.
> 
> Fixes: 830877d89edc ("net: phy: Add support for Aeonsemi AS21xxx PHYs")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/phy/as21xxx.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/phy/as21xxx.c b/drivers/net/phy/as21xxx.c
> index 97ca37c6929f..a6686b4908c6 100644
> --- a/drivers/net/phy/as21xxx.c
> +++ b/drivers/net/phy/as21xxx.c
> @@ -616,6 +616,13 @@ static int as21xxx_probe(struct phy_device *phydev)
>  	if (ret)
>  		return ret;
>  
> +	/* Even if PHY declare support for Clause 22 register,
> +	 * Clause 45 register should be used for ANEG configuration
> +	 * and restart. Clear the C22 bit for devices_in_package to
> +	 * force C45 generic OPs in generic PHY ANGE OPs.
> +	 */
> +	phydev->c45_ids.devices_in_package &= ~BIT(0);
> +
>  	ret = aeon_ipc_sync_parity(phydev, priv);
>  	if (ret)
>  		return ret;


