Return-Path: <netdev+bounces-281211-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLi7OkHK7mnlxgAAu9opvQ
	(envelope-from <netdev+bounces-281211-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 04:30:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B57646C1CB
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 04:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77DFF300A114
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 02:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1299D267AF2;
	Mon, 27 Apr 2026 02:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Sk9ZOG+x"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8DDDF59;
	Mon, 27 Apr 2026 02:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777257023; cv=none; b=augHHHrxAi6CwVxVxr9hU/Ru8XjiLfrs252dAp1AcWs/iK8AnlqH4k+S8F5g06DmNI9hoIFG8Tcf3lNmwpGvD9IGAKWMShJ/YSOhYnmJPNs6E4fQSRaTgRUVWUCslBlhJaQQBybiMNmF4LLdOXQABzWFoW1T6RamafarcsB76bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777257023; c=relaxed/simple;
	bh=lgOikZfyvSIw3u4aalfJZvUJGjAUXjuv0jh3cEq3l8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pbjrx3xKh37qndyesipGtDHR8Vih6Imuf7JIinU4OQ3KHXoePv1tJGBfF33F7rpTwa42CRJWVlPSErhtlwzSG++xJ6iTQFT6aVh3Ka1mtOQmjpPhPU9KCHWQy7RBEq48Ng2cqHamsjezf8Pv1JUGpISAC05CeRJMWhUevlOhsBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Sk9ZOG+x; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IuUF7rtNtAwJ70D+TtgPE7uwbUDXsuBzzfYzYXr63GI=; b=Sk9ZOG+xxeoU4AWsNDyLxfRfYg
	SKasIPShDJNwS5iRhcsnrwNNlxBBjDGI0QKvnB/08QWTo1+uT7/deY+anjhilqSihaEmeE9hOfddv
	w/0H2ANEOqq2QKBCKb1hdYqObRbXXUv7RiBA3Fl+D+r5SHX3yE9wwkjiRwa5ANKYR458=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wHBja-0005fk-6y; Mon, 27 Apr 2026 04:30:06 +0200
Date: Mon, 27 Apr 2026 04:30:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC Patch net-next v1 1/9] r8169: add some register definitions
Message-ID: <b468f0df-5bea-4d3e-920b-ef35113a8b58@lunn.ch>
References: <20260420021957.1756-1-javen_xu@realsil.com.cn>
 <20260420021957.1756-2-javen_xu@realsil.com.cn>
 <59c06e34-2782-438e-bfd7-a8d475f34f95@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59c06e34-2782-438e-bfd7-a8d475f34f95@gmail.com>
X-Rspamd-Queue-Id: 4B57646C1CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281211-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]


> > +#define RXS_8125B_RSS_UDP_V4 BIT(27)
> 
> This register naming is unfortunate. What stands 8125B for, and what V4?
> Does V4 stand for a global version of the Realtek RSS IP block?
> Then the 8125B would be redundant.

Maybe UDP carried inside an IPv4 package?

> > +	RSS_CTRL_IPV4_SUPP		= (1 << 1),
> > +	RSS_CTRL_TCP_IPV6_SUPP		= (1 << 2),
> > +	RSS_CTRL_IPV6_SUPP		= (1 << 3),
> > +	RSS_CTRL_IPV6_EXT_SUPP		= (1 << 4),
> > +	RSS_CTRL_TCP_IPV6_EXT_SUPP	= (1 << 5),
> > +	RSS_CTRL_UDP_IPV4_SUPP		= (1 << 11),
> > +	RSS_CTRL_UDP_IPV6_SUPP		= (1 << 12),
> > +	RSS_CTRL_UDP_IPV6_EXT_SUPP	= (1 << 13),
> > +	RSS_INDIRECTION_TBL_8125_V2	= 0x4700,
> > +	RSS_KEY_8125			= 0x4600,

> > +	RxUDPT_v4	= (1 << 19),
> > +	RxTCPT_v4	= (1 << 18),
> > +	RxUDPF_v4	= (1 << 16), /* UDP/IP checksum failed */
> > +	RxTCPF_v4	= (1 << 15), /* TCP/IP checksum failed */

I agree that in general there needs to be better naming. These could
again be referring to IPv4? But the v2 references are clearly not an
IP version.

	Andrew

