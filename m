Return-Path: <netdev+bounces-294486-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3P/xBl9yH2oRmAAAu9opvQ
	(envelope-from <netdev+bounces-294486-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 02:16:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A830363323A
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 02:16:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=pw4zxjhT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294486-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-294486-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 267E13033216
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 00:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23AB23D281;
	Wed,  3 Jun 2026 00:16:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881DA223DE9;
	Wed,  3 Jun 2026 00:15:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780445760; cv=none; b=l7nP79C4py7f8PKIrHIgJuqd1L8jzWXLsAxTwkNKHDDLUx3aa8EwpWF0zKkrtqYctf/cIHQMCj9Z9TjsbKaMNIFYZWzd87KRD1QD4BOIYryw2mYQbmJ/y1pynZCwkAATaS0Vipd0Q5pTGFxRKx6vTV+qbSUfPOSJ6sFY5gMhCOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780445760; c=relaxed/simple;
	bh=9flrw53HNgG8jcIR9SckLbImG0fNZXaaC4jde+qluCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnqG5CaT0vtgCXftSwwFuPFyjAeIG+ICQDcR9i6c22IH6KberZuhv5ruj+uaGKbwba0w/oslFlVbHOwgW1yF3y45/EJUxOd5hsviE7KEo4We9hcsx+KyZel2w2DmM+QdFYg+jGsuCdk2gPRpga7pXGW9FGkRhMrDMc2SQi4ySfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pw4zxjhT; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WyLvf9bqb1QFIVpJ/5XsqBvvssIE6x5Mu3bV8kLzoug=; b=pw4zxjhTJ8SZ2lNyPM0MZneYWx
	3VtctziaWRv91SEyhJlRnF1MaOL5k9INUjIzxj6Gp1M35aODEjpb6XhsF+WtN4dHT7keObBbMLGBh
	9aaMuCVqq0ENsZerthmjxNJynfzrWnIX4+EZmh8+s1NhBibvXA79fhpzB2/bLcZ8sMxQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUZH0-005mKN-BC; Wed, 03 Jun 2026 02:15:54 +0200
Date: Wed, 3 Jun 2026 02:15:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Greg Patrick <gregspatrick@hotmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1] net: phy: sfp: detect presence via I2C when
 no MOD_DEF0 GPIO
Message-ID: <193b3aba-fc64-45bc-81bb-ea248efa9c3c@lunn.ch>
References: <20260602235528.2795028-1-gregspatrick@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602235528.2795028-1-gregspatrick@hotmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294486-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregspatrick@hotmail.com,m:linux@armlinux.org.uk,m:hkallweit1@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[hotmail.com];
	FREEMAIL_CC(0.00)[armlinux.org.uk,gmail.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:from_mime,lunn.ch:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A830363323A

> +/* Probe whether a module is physically present by attempting a single-byte
> + * I2C read of the EEPROM identifier (an empty cage NAKs). Used as the presence
> + * source on boards that do not wire MOD_DEF0 to a GPIO.

Did you try a 0 byte read? That is what tools like i2cdetect use.

	Andrew

