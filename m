Return-Path: <netdev+bounces-303701-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zTjWCKslRWo57woAu9opvQ
	(envelope-from <netdev+bounces-303701-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 16:35:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 581B26EED06
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 16:35:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=NU+Elp1H;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303701-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303701-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8D4030F1D31
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 14:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651333469E7;
	Wed,  1 Jul 2026 14:27:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB74A34252B;
	Wed,  1 Jul 2026 14:27:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916066; cv=none; b=pFeqydGP6kNkCPL9pFnX04mKDN0D2Y/Lqdy+MIdDAmrfA1ytpqv7JPHRYRjPePS07y9ywlO7sUXzariw70wZgW50pPJcy1hAn+i5faSJKq+QvdnusQQnVIvVlmq8ZAUk/y0y0QyCcPu9j0j8o16qrz3Vx9WfFzoMn+ltOkMi6UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916066; c=relaxed/simple;
	bh=4ACXg25L2qUmFtkuO+CCeMDMWFiZyJTJRNtNPgYpYtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j01AVmpOYQFjiPhqRCAcWdflZe9Hec7Z0ljrzKjDbVoQg4+H6RfvRvxR0Gl7S5E6LT/eah0By03iZ/BWL8WoxhOV2Pfh5F3jmR7bFaOpx+yYW+PfrZdAyHw/QQWj1SNVxCwu0tjyw5nKc9PjhPXiJP2/hq5PMSCvkmeK/xNc7os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NU+Elp1H; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=y8sHsYBxIg8HCHsDZSNktD8E9LhB/IoZ5xG4waVKg2A=; b=NU+Elp1HkzxY6PwwGkFnjIUxV4
	ak8VdjroR33Jhbn7XOstEKgO/EFBEZqAZ6Vfm2CR9AzCeXF/GRnWXD1ikxNk0gdxY+Yblhqixl2Ml
	VvuyAhM0H0ecpLQuvuAzug3uSS4z352Qe8Boyjf5YcoD3NpHGdBaZYK8EWZeIIoyRVtA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wevuM-00ABI2-Fn; Wed, 01 Jul 2026 16:27:22 +0200
Date: Wed, 1 Jul 2026 16:27:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: muhammad.nazim.amirul.nazle.asmade@altera.com, linux@armlinux.org.uk,
	hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phylink: reject unsupported speed/duplex in
 ksettings_set() with PHY
Message-ID: <c3a0e35b-a633-487c-bc08-d62f809047a6@lunn.ch>
References: <20260701031746.23448-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <37005060-acfb-4791-aa2c-caa3710d4450@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37005060-acfb-4791-aa2c-caa3710d4450@bootlin.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[altera.com,armlinux.org.uk,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-303701-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:muhammad.nazim.amirul.nazle.asmade@altera.com,m:linux@armlinux.org.uk,m:hkallweit1@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 581B26EED06

> I think rejecting these settings makes sense, I'm however wondering
> wether this is a fix or not, as this will change user-visible behaviour.
> I'd err to the side of caution and send that to net-next, but maybe
> Andrew will have more insight :)

net-next seems reasonable.

	Andrew

