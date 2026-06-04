Return-Path: <netdev+bounces-294993-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TfZ1NzbNIGo48AAAu9opvQ
	(envelope-from <netdev+bounces-294993-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 02:56:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 742E863C1F6
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 02:56:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YvndKmqL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294993-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294993-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC4D73023146
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 00:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609E120C461;
	Thu,  4 Jun 2026 00:56:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D984142E83;
	Thu,  4 Jun 2026 00:56:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780534580; cv=none; b=kuf6DYkTMNN3SL/B02Y8BAoROx9o+SLgK7QP4GRHXLndwU3dexECD8CZz9ZvUliUvWr6r/WuM2FO795klWqdJj6MbTE3vcqdemF5laKeXdvOsrXdBqcMnmTM9KlfgFlHrYGAPl+MXbOf/WZKf+m51ownneoL8zeO9zAL/j1Ikz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780534580; c=relaxed/simple;
	bh=95imCsvpAnyWr4bvzUI/rNWCdu9iRhNtZFL+o/3lHiE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0bOWpouwoPoAmr2Fx4u+4mPCGEOMwso82I4pXSWmz1QYYP0Bk7p9NDBU6LzS5MT2xVHO8gLJ8nW2NXLJl70+UItejtiaTOmiJmgzIUGXnt/SaxsIvAwyNPcZmmDN0V4lj247JOPTN6kInP5W5nTXIiQH1+OZEku421XKU9PsGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvndKmqL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF921F00893;
	Thu,  4 Jun 2026 00:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780534578;
	bh=gF8d4Q9scRWFseYExzUgYTOi59LCj0LaGZy3d3dDve8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YvndKmqLSxRnxToW2b4/W+5/EBi06MPP0fGsWL203pGBgeGlAktfzgsrJT7vYBe59
	 b2p+CbolYOkIgEmPdtskDCazZbZFDWacg8Oii+G+wiyxOTigx1aqNyny1KJFcPDqc1
	 xFp+Uje2tNG42ZQZoA9wlJqQ5SU7Y0vZcLk+dHd8gMwOREf3DZoR80TN4546eKjsPF
	 mCz8ANbSLJhelyWxL/SLPs7IXHRsY2xaUBIuJZMNl8thQKn+PgnslrSdff8Y0ueHLj
	 RRUF21YcfYs1+7mgo9z4YbPR/Bffp0xsuw14lqVup4OyilO0SKFoSoO522e8IVIxA+
	 H3bL7IN1+9/PQ==
Date: Wed, 3 Jun 2026 17:56:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, Alvin
 =?UTF-8?B?xaBpcHJhZ2E=?= <alsi@bang-olufsen.dk>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yury Norov <ynorov@nvidia.com>, Abdulkader
 Alrezej <abdulkader.alrezej@gmail.com>, Mieczyslaw Nalewaj
 <namiltd@yahoo.com>
Subject: Re: [net-next PATCH v11 6/9] net: dsa: realtek: rtl8365mb: add VLAN
 support
Message-ID: <20260603175617.7cc4f660@kernel.org>
In-Reply-To: <20260531-realtek_forward-v11-6-50d60f5717e8@gmail.com>
References: <20260531-realtek_forward-v11-0-50d60f5717e8@gmail.com>
	<20260531-realtek_forward-v11-6-50d60f5717e8@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-294993-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:luizluca@gmail.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:yury.norov@gmail.com,m:linux@rasmusvillemoes.dk,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ynorov@nvidia.com,m:abdulkader.alrezej@gmail.com,m:namiltd@yahoo.com,m:yurynorov@gmail.com,m:abdulkaderalrezej@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org,nvidia.com,yahoo.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 742E863C1F6

On Sun, 31 May 2026 23:53:21 -0300 Luiz Angelo Daros de Luca wrote:
> +#define RTL_VLAN_ERR(msg)						\
> +	do {								\
> +		const char *__msg = (msg);				\
> +									\
> +		if (extack)						\
> +			NL_SET_ERR_MSG_FMT_MOD(extack, "%s", __msg);	\
> +		dev_err(priv->dev, "%s", __msg);			\
> +	} while (0)

Please don't duplicate errors. The errors are either due to something
being wrong / unsupported in the request in which case they should go
via extack. Or they are unexpected system errors (IO errors, timeouts 
and such) in which case just return errno and print to the logs 
so that the admin has a permanent record.

There's a tracepoint in NL_SET_ERR_MSG() if you want to sniff
user errors.
-- 
pw-bot: cr

