Return-Path: <netdev+bounces-300601-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id faF5DtnaNGpvigYAu9opvQ
	(envelope-from <netdev+bounces-300601-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 07:59:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D69036A405D
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 07:59:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=BdZt8wm3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300601-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300601-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1299A304CF70
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 05:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF36346ACD;
	Fri, 19 Jun 2026 05:59:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17683346A14;
	Fri, 19 Jun 2026 05:59:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781848786; cv=none; b=KpDi79ZtUMxagoVhf/PKDXfQ7f8T8UbBsDVNXD5k0pcDPGQulCP5DkvIpncHY32KiIeklCHQ4I0LjNcrlY7sYxd2pQU4tpDFzHTvXmt7D4CM5sRhLs/wE4618rBqW/c2Tvw++x4VTQVNAQ/wydrdc+ktLevUb7kqMD+u09QYbjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781848786; c=relaxed/simple;
	bh=+PqijbD9oMdSwOrOcxgtcweO6CEWkp4h/Pjn5wBNGCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhxMMQX6bOK/9+RU/nm/fa32EiU5dWjkXpqU90eUVFUm6v+WV9jurlf1C9JtFyzWd+UARvXmYByVK5iVbg/L7FbvyI6RpRGnbmF1hc1Zz/9C6izLWRptEXrC16nOCUD5tQNvDyE9UxkZZDdh56HBPHU+kH3exhMArbSEMOLpwXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BdZt8wm3; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HU6WpvPnB6HUBo+ywbe5ytIX1ilWinc/V+jD72zgalk=; b=BdZt8wm3ZqVJ2SWkoOZmoL53ZJ
	BxRPORc6E09X2btf+2rGD2TXgPYqrpBKIg9xPpwKq39e9ELiw8aOBBCZE/R8NeHEAXhWKDwWkYLdb
	puaoSTsmdEQrfzuvBRjQEJoBnCzeEa0BV+J55EE2Ox6ZfU/Gw7xd5ruZ9Y5jm1mHQOF0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1waSGF-008SU4-Vr; Fri, 19 Jun 2026 07:59:27 +0200
Date: Fri, 19 Jun 2026 07:59:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Luke Howard <lukeh@padl.com>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, cedric.jehasse@luminex.be,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Mellauner <christoph.mellauner@joyned.at>,
	Kieran Tyrrell <kieran@sienda.com>
Subject: Re: [PATCH net-next 2/2] net: dsa: mv88e6xxx: add support for credit
 based shaper
Message-ID: <00fc2dcc-9fdb-4035-bc7c-0f4ebd37d373@lunn.ch>
References: <20260522-net-next-mv88e6xxx-cbs-v1-0-c87a8e6bcc0c@luminex.be>
 <20260522-net-next-mv88e6xxx-cbs-v1-2-c87a8e6bcc0c@luminex.be>
 <0FB1CAF0-D30C-4A24-A684-1D1DBEE52FA5@padl.com>
 <CABvLYuBZ=U96gVpYqHnnhwBZxp8OZzH-W503MsbNd4JPqLbEpQ@mail.gmail.com>
 <A3A6C8D7-3B6D-4716-88C7-EC32DB9D087D@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A3A6C8D7-3B6D-4716-88C7-EC32DB9D087D@padl.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300601-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:lukeh@padl.com,m:cedric.jehasse@gmail.com,m:cedric.jehasse@luminex.be,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:christoph.mellauner@joyned.at,m:kieran@sienda.com,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,luminex.be,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org,joyned.at,sienda.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D69036A405D

> As an aside, the 6341 driver is buggy. It assumes the chip does not
> have a dedicated ATU FID register because it has 256 databases. This
> is incorrect and breaks VLAN-aware bridging. I will post a patch
> when the merge window reopens.

You can post fixes for net any time. No need to wait for the merge
window to close.

	Andrew

