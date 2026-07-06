Return-Path: <netdev+bounces-305074-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GJluGoy3S2p7ZAEAu9opvQ
	(envelope-from <netdev+bounces-305074-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 16:11:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0D1711C4A
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 16:11:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=xJAdxKcv;
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305074-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305074-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C47530BCCCF
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 13:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67693093DF;
	Mon,  6 Jul 2026 13:53:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA122E736A;
	Mon,  6 Jul 2026 13:53:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346026; cv=none; b=ts/7/LDnV/D1D3jVBNX7I676cUCEIgbUVfepx2/dKwutz4wc6mXgM1SQ6bljXB9nPVMBRJuE9i1bQQrIewq4j5gz483zNeNFd4pTauW+YAjwMV28S2UShP4I2OZxiLAKq6Q+FCFzIfKxvE2V/RtwSdaNAXgmdffZcj8s6EUHuLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346026; c=relaxed/simple;
	bh=GsPL7KbRZPqGujnzbJsjeG3QKPL4qPUV2iOe/wvfAMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oU+D8XYxnP1PqLDyK3dUdTfwHzAaOPMHucexwBYn/0grtHjWConQNvP8dT7xflTRBsZJVz+rBd5oDEkmvMvI3VQkKW29u/gyj6WC91K7vH2R0oaXGlKAA+DW5bSXpJZS4eXlozx3UV07qgeuPhEd6Hb2RW9JsVyZlC9ovwh/Sww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xJAdxKcv; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ycKeZ8huTYhCrCKuSwO/Y7VMMDg+VHi4UtgYihXDt/U=; b=xJAdxKcvksL1+QZVY6LvcoJX8Q
	bwVhXUMhBUpKZp2bv9p3Z92agbKjEsWoTacD5J66L6ZV+ZAkMdm5379fgqIzUJJuSFH+obItnXUUt
	Fo9bsN0dRDgVUXL9daVDPC4fwdjEv0E6G/WKOIPsYdOF1y/QihvP/kMl/KaaQ9l1VMjs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wgjlH-00B01M-HK; Mon, 06 Jul 2026 15:53:27 +0200
Date: Mon, 6 Jul 2026 15:53:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Gary Guo <gary@garyguo.net>
Cc: Guru Das Srinagesh <linux@gurudas.dev>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: phy: ax88796b: Use vertical import
 style
Message-ID: <4d2e0248-11ee-4c0e-9133-8af15912e0cf@lunn.ch>
References: <20260705-net-vert-imp-v1-0-95a35ddff411@gurudas.dev>
 <20260705-net-vert-imp-v1-1-95a35ddff411@gurudas.dev>
 <8376fc86-be9d-4e3a-a51e-4d9ecda1b648@lunn.ch>
 <DJRJ4N9UQUR8.1GSF8WWG5WO2Q@garyguo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJRJ4N9UQUR8.1GSF8WWG5WO2Q@garyguo.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305074-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:gary@garyguo.net,m:linux@gurudas.dev,m:fujita.tomonori@gmail.com,m:tmgross@umich.edu,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:fujitatomonori@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gurudas.dev,gmail.com,umich.edu,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lunn.ch:from_mime,lunn.ch:email,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF0D1711C4A

> This is sorted list, albeit in ASCIIbetical order instead of alphabetical.

Ah, O.K. To avoid merge conflicts, the actual sorting scheme does not
matter, it just needs to be sorted, so inserts are more likely to be
spread across the list rather than appended at the end.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

