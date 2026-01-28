Return-Path: <netdev+bounces-254270-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCGNF2kXemlS2QEAu9opvQ
	(envelope-from <netdev+bounces-254270-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:04:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7697A273A
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8ABE430238DB
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 13:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2957C2EAB72;
	Wed, 28 Jan 2026 13:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="F1v+lhss"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACC236074D;
	Wed, 28 Jan 2026 13:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769608714; cv=none; b=Ym70Fd14eXAFJbi/8ySOkcc4B7yRafoFaz3nswKrfNjrwftiDNSMhQNfqU8aCJ6694faR5kDkzWwP4kTzcpdLm6cqj/2vzGvf7H+QfkRIWUUvrExSauwdBDo2dY1MSc2/FDD6B5k68oBuzyXCiLsH7T9QgSdRsIUeXw/Jdfp0G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769608714; c=relaxed/simple;
	bh=g6XIgN1ZCDeqotM0DQ7qGG+HvhCoz/rdnNVcjFJvd2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLAbVQmmCFnF+LT5mqKUJr1zC328fIc+7FviaaXRXeCGN0jLuqkKlXuEi2fPJL/oYzPnImM+crPnXltnoXTuyvZnt3g5gs8Dr4/WgoA657KK1Mgda1b9Ubr0ZwigWHVg6omFjzSaOXJSlQiAd7daLbJZvMqxTywe00umG3pbs5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=F1v+lhss; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OBhx6PPQwJGbGCfKCUWkP4oqvISvhWtUXruIIZVnlWE=; b=F1v+lhssHcSKEmOGMHuZ7Fj2nm
	kcnxDfuXzghtLNWADUdam+2TN3x0ZCnhBBCJPkwZ4T1OpGgk183JwTmUROYMQe7iwwtkP/EBlgbyw
	AU5wmioJe7UVhoW7+iBvBpYzHP8HSgCY1+WPZClwbsBeNKthlrXIkc+ICWBX6uZSCYGD62trLrrdz
	Yxu4IZPbEWhtlZmkVlJ5jjQF0xtBvYMOfkv3p5N1F3iAgZtpT3K/DH1QWdhe3XIKFouKO6Jp0A/Bk
	P+I+ZWv9zc9lZ/wypuwtq2GQiBTZb83p70J7dNEKAh4rm2COazJw4nEtHe4D6kUb4M/eVPg4cNoD0
	H9qlgjgg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46812)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vl63p-000000007Qv-0M56;
	Wed, 28 Jan 2026 13:58:21 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vl63l-0000000071m-3cYb;
	Wed, 28 Jan 2026 13:58:17 +0000
Date: Wed, 28 Jan 2026 13:58:17 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
	Marco Felsch <m.felsch@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"open list:FREESCALE IMX / MXC FEC DRIVER" <imx@lists.linux.dev>,
	"open list:FREESCALE IMX / MXC FEC DRIVER" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] net: phy: integrate reset-after-clock quirk into
 phy_init_hw
Message-ID: <aXoV-U-yqcDJj2vk@shell.armlinux.org.uk>
References: <20260128094644.302313-1-michael@amarulasolutions.com>
 <13d1018c-d9aa-4838-8bb3-35c509cd3e35@lunn.ch>
 <CAOf5uwm30=AVhqm67yz8Y5TkX9FWdxizTevCGSeaQuJS0KqtNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOf5uwm30=AVhqm67yz8Y5TkX9FWdxizTevCGSeaQuJS0KqtNA@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-254270-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,nxp.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lists.linux.dev,vger.kernel.org];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: B7697A273A
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 02:33:24PM +0100, Michael Nazzareno Trimarchi wrote:
> Hi Andrew
> 
> On Wed, Jan 28, 2026 at 2:25 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Wed, Jan 28, 2026 at 10:46:41AM +0100, Michael Trimarchi wrote:
> > > The current implementation of phy_reset_after_clk_enable requires MAC drivers
> > > (like fec_main.c) to manually track PHY probing states and trigger resets
> > > at specific points in their clock management flow and was created just for a SoC
> > > vendor.
> >
> > We try to keep workarounds for specific SoC vendors out of the core,
> > when possible. It just makes the core more complex for an edge case
> > which most people don't care about. It is better to hide the
> > complexity away in the driver which needs it.
> 
> We should not merge things in the core that are for one Soc and
> after d65af21842f8a7821fc3b28dc043c2f92b2b312c, I need to anyway to do:
> 
> net: phy: smsc: Fix functionality of lan8710 in combination with NXP fec
> 
> Revert "net: phy: smsc: LAN8710/20: remove PHY_RST_AFTER_CLK_EN flag"
> d65af21842

That commit is an example of a poor commit description. It doesn't
describe the problem, nor which hardware this affects, so when we end
up with this kind of situation, we're lacking the context behind why
the change was made.

So, how do we know that reverting that commit is not going to cause a
regression for whatever platform the patch was proposed for?

If you read the preceeding commit (which is referenced by the commit
you intend to revert) itgives more information about the problem, and
I would expect that reverting it will cause a regression with
interrupts.

Adding Marco to this thread for comment.

Also, maybe you could clearly state what the issue that you are trying
to address - why do you need special reset handling for the combination
of FEC + this PHY. Consider including that description in the commit
message for any proposed solution so that - as is the case here looking
back at Macro's commit - we can see _why_ the change is being made.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

