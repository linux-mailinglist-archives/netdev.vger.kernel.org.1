Return-Path: <netdev+bounces-297541-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 57kdIo0kKWqzRQMAu9opvQ
	(envelope-from <netdev+bounces-297541-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:47:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E53916675F9
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:47:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=YMkoICmC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297541-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297541-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40EB23140229
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93D03B7B96;
	Wed, 10 Jun 2026 08:41:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646083B71C3;
	Wed, 10 Jun 2026 08:41:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080897; cv=none; b=pOhcSPipcLOWNTM/QGEa6sVrXfOwXwiBfl1/qkMzK/sWe2a0kHLdYlcBWUwky/+b5sp8eeDqOFtIjcaGeBw4hPwu+28ijIuMutc32GQq6AmQS/g/ENYiEv6zgwv7Uyy5eE4qYdWWnscNI55lQmSraJ1WIq07rxAU4XX+K24e2Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080897; c=relaxed/simple;
	bh=gaE1KoNcLuei1hGJFWfcN2lWfL3rvLe1FA/rKdKGfHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jl0Cs6YXyS1LV+3xxMeuvxwn73AvKG/HD5/TEVh3rBhPfBVdgzxFRuJFyo3U0KWCbwWLZpY567UtLK8BBftdMC4f9IkCQg+Bs23VM6F8HpyRGZZJQTNM8h32H8D38OI85uvV3A/5bCmKiZC7SnOLnjPqXhpoTOLvZ8C8zTSh5QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YMkoICmC; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zwRZpdWrrC7Hcs17gSNX1j+WRenkYiA30xF+AFaP70w=; b=YMkoICmC4GGu4BkyiuDTA80GqH
	0dcLyzDl/dwDTjhsSsXmHsWoAr/85SruGTlbePP71JKmbNvrnCcN3JSwlHmnzseqhLX0a3gMCFpwQ
	Y1CTDI4YvmUAXlInpE2ljbsQRofI07AR1/Nnm/oDtEYLmcsADn50PYOcmbgoXtOs+J38=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wXEV0-006wtV-TL; Wed, 10 Jun 2026 10:41:22 +0200
Date: Wed, 10 Jun 2026 10:41:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Johan Alvarado <contact@c127.dev>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/2] net: dsa: realtek: rtl8365mb: add SGMII
 support for RTL8367S
Message-ID: <6772330f-46e0-4ff3-9071-570f76fde596@lunn.ch>
References: <20260610075241.1069370-1-contact@c127.dev>
 <06baad5f-fd65-4572-a23f-73b3cc470599@smtp-relay.sendinblue.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06baad5f-fd65-4572-a23f-73b3cc470599@smtp-relay.sendinblue.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,bang-olufsen.dk,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-297541-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:contact@c127.dev,m:netdev@vger.kernel.org,m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E53916675F9

> +static int rtl8365mb_sds_write(struct realtek_priv *priv, int sds, u16 addr,
> + u16 data)
> +{
> + u32 val;
> + int ret;
> +
> + ret = regmap_write(priv->map, RTL8365MB_SDS_INDACS_DATA_REG, data);
> + if (ret)
> + return ret;
> +
> + ret = regmap_write(priv->map, RTL8365MB_SDS_INDACS_ADR_REG, addr);
> + if (ret)
> + return ret;

It looks like your mailer has destroyed the white space in this patch.

    Andrew

---
pw-bot: cr

