Return-Path: <netdev+bounces-296695-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ad0wJBoOJ2qjqwIAu9opvQ
	(envelope-from <netdev+bounces-296695-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 20:46:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1106D659D95
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 20:46:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=SvwTXcEs;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296695-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296695-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EEB55306AD12
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 18:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B1B3E3DBE;
	Mon,  8 Jun 2026 18:40:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2633E5561;
	Mon,  8 Jun 2026 18:40:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780944047; cv=none; b=P+s424wuIwoyjcgH8kOQ+uXxKtXAFH6vRerW30vHKW59FGug5mFZKXpm/mtuuVxx8s/8OC8WL84eloiPKtLb6S/rcWJt1IBpngmknaoRuLNPRX4Q2UdykRI6lqSlNXHvFWD5pJnec+i0nlkTKCAA5sEx969LBgAV9KbIbo4PrOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780944047; c=relaxed/simple;
	bh=2k8xmV15Hu+Aztbpw8GSLMJ4R+bML0xlElHkN7do8+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7lSeC9WA3GAfBYWdJhHFl4FIrnWLmPuO0sOPs5FD+mC7TUXYJUrUfjUmg3VLHgJVvaE6IDm+HLWFIjR2PwwtjECC3S14k54gEbIZkZWtQ0YoRRXxbuOMNc/+nzbn+WztcKcj1PovuzXQlVpWHpU+0bVu/67byXRbFyXRvs3z5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SvwTXcEs; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uHelTIok94J1fWkDDBNEFXmfABjBKzCothRWbKqYUo0=; b=SvwTXcEsqvEPmbXo1T+ubU7UMU
	/ozavXCSZ4hRPP8NqvC2T2SLpOViqMF06p6LZaY6qI4n9kxOUieJk5navJYHKtTjAr9bxGUt9/Yyv
	a6znGYeuKzE9M0FV5E8V4fnKv8uMEeccBJi7AwpezWj+fyeBAPEn3VVZJ6GzQWhZs5IA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wWetf-006g7d-ER; Mon, 08 Jun 2026 20:40:27 +0200
Date: Mon, 8 Jun 2026 20:40:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Javen <javen_xu@realsil.com.cn>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"nic_swsd@realtek.com" <nic_swsd@realtek.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v1 2/6] r8169: add support for phylink
Message-ID: <b47ce7e8-1f29-4819-be91-d17b098c30cb@lunn.ch>
References: <20260605103906.1445-1-javen_xu@realsil.com.cn>
 <20260605103906.1445-3-javen_xu@realsil.com.cn>
 <75cee79b-78d5-4a64-bbfe-8ba89f4cfb7d@bootlin.com>
 <e8ff0b30c02e4bc996380c4bb93225fa@realsil.com.cn>
 <d2aec499-071c-471d-b6ba-005f6e77d273@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2aec499-071c-471d-b6ba-005f6e77d273@bootlin.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296695-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:javen_xu@realsil.com.cn,m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[realsil.com.cn,gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1106D659D95

> > Hi Maxime,
> > 
> > I have one question about the existing link-change interrupt model.
> > 
> > For most r8169 chips, the PHY exists and the current driver uses the MAC LinkChg interrupt to notify phylib:
> >         if (status & LinkChg)
> >                 phy_mac_interrupt(tp->phydev);
> 
> This is the first time there's an attempt to port a driver that
> typically deals with an embedded PHY to phylink, so we need to
> sort this out.

Well, mv88e6xxx has something similar, for its embedded PHYs. For
that, we export the interrupt controller as a linux interrupt
controller. We then allow two different things:

1) The PHY has a phandle to the interrupt. That causes phylib to
request the interrupt.

2) The interrupt controller code fills mdiobus->irq[addr] with the
interrupt number, so that phylib will request the interrupt.

	  Andrew

