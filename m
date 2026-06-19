Return-Path: <netdev+bounces-300651-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Zt7/LtMCNWrTlwYAu9opvQ
	(envelope-from <netdev+bounces-300651-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 10:50:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2156A4B4F
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 10:50:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=FQF6O65q;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300651-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300651-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 574F1302632F
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 08:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B0731E834;
	Fri, 19 Jun 2026 08:50:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449FF28C840
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 08:50:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781859008; cv=none; b=WP7Ks6u16pmVmKuL9oRJhqq+tID4bvpE3WxCqNEV/j/B0oo49cdCQCdK8RbfzNboOPyATm2kDMIY/1VVv4jzJ2dufk8ORDUlKvu4orgQMAph127MHJqb+NFiJ/3eEL15Cx+BtHLJ1N032HQHgj9tOINBDMo751OewAdpWZ+f2xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781859008; c=relaxed/simple;
	bh=j0TQ1klvpgpAp7IoqxioiurzX6IYOP7YgUjiWQ6435A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VfbgBi0EsviuyO30fpDA5Z3WwB452uL3qCxvrtjq/OXx2454qVIACU/WqDVcw2lzeGm+loJDvHVZkcfneZskIwa4ZDVMyC3osQchf0VZ4veLMSqc4DulaUgkcNy+VZ+KvTWpF+HUnu5ZZfRYRHSByD94eyr+2NzyKOxY12P5fF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FQF6O65q; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 59AFCC06CD4;
	Fri, 19 Jun 2026 08:50:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 88758601AD;
	Fri, 19 Jun 2026 08:50:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 439A3106C88A9;
	Fri, 19 Jun 2026 10:49:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781858999; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=1cGPNM8CgkhC9iC98sy5Y925tuG5J0QBkzDj6YCkI5c=;
	b=FQF6O65qXr1VlcP9MSF+J07p3E48H7o6y9CqpbXKX94y2PGB8gD21/z2aVJqSrczW5zUHh
	+6I+rwIZoEnatEV9OnMHUp6GwpQGI6QR11NBsfG6B2u3eN9P4cj6VfTt2Mttj5eCcYqeZO
	O0aT6Wv8s1cXTxHcnPOycM7VJSm9BpOdR6HRPE9dLXp0KsuM2aGEXaIZx4QACKIgi1Fson
	g1F8TkqXdGhvJX0OFO711R96Z5XBER1pRQDlIFga8Nruhw/qY82fEMvStTR7QiCMqHl3pv
	7NH5KWhyK/JBDZZzS4wA7cW38UQu6MCX2+5qNb2FBaKlk47tI2pCT9vdI+4q1g==
Message-ID: <e9e251f9-40b9-4543-b3c1-bac5a9ec5811@bootlin.com>
Date: Fri, 19 Jun 2026 10:49:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: realtek: Clear MDIO_AN_10GBT_CTRL_ADV10G bit
To: Jan Klos <honza.klos@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20260619011519.50009-2-honza.klos@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260619011519.50009-2-honza.klos@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300651-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[bootlin.com:server fail,sea.lore.kernel.org:server fail,vger.kernel.org:server fail];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,armlinux.org.uk,vger.kernel.org];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:honza.klos@gmail.com,m:hkallweit1@gmail.com,m:andrew@lunn.ch,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:honzaklos@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C2156A4B4F

Hi,

On 6/19/26 03:15, Jan Klos wrote:
> On RTL8127A connected to a link partner that advertises 10000baseT
> speed cannot be changed to anything other than 10000baseT as 10GbE
> is always advertised regardless of any setting. Fix this by
> clearing MDIO_AN_10GBT_CTRL_ADV10G bit in rtl822x_config_aneg()'s
> call to phy_modify_mmd_changed().

Makes sense, this is also done as part of the C45 config_aneg sequence.

You're missing a few things process-wise :

 - a Fixes tag to indicate the commit that introduced the bug

 - You must CC all the relevant maintainers, including the top-level networking
   maintainers, use ./scripts/get_maintainers.pl to get the list

 - The patch must have in the subject an indication that this targets the
   'net' tree, for bugfixes, see :

https://docs.kernel.org/process/maintainer-netdev.html

Feel free to re-send a V2 (after waiting 24h), and add my review tag :

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> 
> Signed-off-by: Jan Klos <honza.klos@gmail.com>
> ---
>  drivers/net/phy/realtek/realtek_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> index 27268811f564..b65d0f5fa1a0 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c
> @@ -1802,7 +1802,8 @@ static int rtl822x_config_aneg(struct phy_device *phydev)
>  		ret = phy_modify_mmd_changed(phydev, MDIO_MMD_VEND2,
>  					     RTL_MDIO_AN_10GBT_CTRL,
>  					     MDIO_AN_10GBT_CTRL_ADV2_5G |
> -					     MDIO_AN_10GBT_CTRL_ADV5G, adv);
> +					     MDIO_AN_10GBT_CTRL_ADV5G |
> +					     MDIO_AN_10GBT_CTRL_ADV10G, adv);
>  		if (ret < 0)
>  			return ret;
>  	}
> 
> base-commit: 7d8297e26b4e20b5d1c3c3fe51fe81a1c7fbc823


