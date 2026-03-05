Return-Path: <netdev+bounces-264448-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKvjCw+dqWnGAwEAu9opvQ
	(envelope-from <netdev+bounces-264448-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:11:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 981A42143BF
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3F07308AFF6
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 15:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139833B8D45;
	Thu,  5 Mar 2026 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="oBa32Mxk"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707F33859E8;
	Thu,  5 Mar 2026 15:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772723135; cv=none; b=I56vfpUILbT7E1jAeyK7g615Nw6tHjyuCC3X9EueK2rQnFSAcOfeBZZhV0uZIIJoELBD+SEVEIG2SqNBrIlAJhMtHZTzy2UtZB73Inz9Mnf0ieViWjRyNswDXo2tWFX4MOB8XwprxlHHjIIrkTWpvj+UZG7/wPI6ym4UyRnsUDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772723135; c=relaxed/simple;
	bh=nJIekaAXEntW7voi0pZDNA/jhrwsJGqid+aqabfbxu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABLQQqW4PsadgUiX+PqS6mbSTe4TBEPy4x6iIPjCQu/+TXq1HAwfIxbgO/JsFlUqirIL5RT3Iui6pTu5xI9UMkV0Y7i3PvSEQs5JFQJvCQkauHQakPx8//0oW7Eqj8MJQ79L9s+oRKIOZAMq8RQ60KGhFHf8WsrjZkTSQO5yl4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=oBa32Mxk; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SxyiCT6VDORzn+aK8JZgHm6yh2Rv96NB+ey8u2GEwxo=; b=oBa32Mxk/IxRMK5B6PHAu8rQrV
	Fg9mPuVTmrCuWE+zU6vFsiMqcmJUEHGeAS1JoUI2zCahB2f8LyGCCDHNpKBtgqibllkTsbuoQ9ynS
	5941S1QpR5JYhYeDa+tLst73sO1niBTJBsEQgE36ZkZ4oljYfXdaiQ80vrOyHt6TUk7O8kly6QU+5
	uS9LJky+POhgU7kwRgS32twESf50663T1HAj4mqw9wJdF/dG+nP2HYADP90kpIpyAAY91mXa3f5IW
	CI5QQTX9MrMuk0ax7+u2mkIW+7Yr531tww3LkR48kUmMsf9fcpskBkm6YF93dqcFwz7teRX4qxiDZ
	o1DhN9ig==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59196)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vyAGR-000000008BH-1BDG;
	Thu, 05 Mar 2026 15:05:23 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vyAGO-000000000Xe-3zBw;
	Thu, 05 Mar 2026 15:05:20 +0000
Date: Thu, 5 Mar 2026 15:05:20 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH net-next 2/6] net: phylink: Allow more interfaces in SFP
 interface selection
Message-ID: <aambsExznAN9YIPJ@shell.armlinux.org.uk>
References: <20260114225731.811993-1-maxime.chevallier@bootlin.com>
 <20260114225731.811993-3-maxime.chevallier@bootlin.com>
 <aWgnHo01j38TF3lp@shell.armlinux.org.uk>
 <18657687-343f-4197-bdab-0eb0bed96964@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18657687-343f-4197-bdab-0eb0bed96964@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Queue-Id: 981A42143BF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264448-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,kernel.org,google.com,redhat.com,gmail.com,vger.kernel.org,bootlin.com,broadcom.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.183];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fs.com:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,armlinux.org.uk:url]
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 09:41:43AM +0100, Maxime Chevallier wrote:
> Hi Russell,
> 
> On 15/01/2026 00:30, Russell King (Oracle) wrote:
> > On Wed, Jan 14, 2026 at 11:57:24PM +0100, Maxime Chevallier wrote:
> >> When phylink handles an SFP module that contains a PHY, it selects a
> >> phy_interface to use to communicate with it. This selection ensures that
> >> the highest speed gets achieved, based on the linkmodes we want to
> >> support in the module.
> >>
> >> This approach doesn't take into account the supported interfaces
> >> reported by the module
> > 
> > This is intentional by design, because the capabilities of the PHY
> > override in this case. Unfortunately, as I've said previously, the
> > rush to throw in a regurgitated version of my obsoleted
> > "host_interfaces" rather messed up my replacement patch set which
> > had the PHY driver advertising the interface capabilities of the
> > PHY, which were then going to be used to make the PHY interface
> > selection when attaching the PHY.
> > 
> > I've still got the code, but I can't now push it into mainline
> > because, with the obsolete host_interfaces stuff merged, we will end
> > up with two competing solutions.
> > 
> > In any case, I really would appreciate people looking through
> > http://git.armlinux.org.uk/cgit/linux-arm.git/log/?h=net-queue
> > 
> > before doing development on SFP and phylink to see whether I've
> > already something that solves their issue. Quite simply, I don't have
> > the time to push every patch out that I have, especially as I'm up to
> > my eyeballs with the crappy stmmac driver now, but also because I
> > have work items from Oracle that reduce the time I can work on
> > mainline.
> 
> net-next being closed, I was going through my backlog and I was thinking
> about giving this series another go after net-next re-opens, I'd like to
> sync with you about the way forward.
> 
> In your tree there's :
> 
> net: phylink: use phy interface mode bitmaps for SFP PHYs	
> net: phy: add supported_interfaces to Aquantia AQR113C
> net: phy: add supported_interfaces to marvell10g PHYs
> net: phy: add supported_interfaces to marvell PHYs
> net: phy: add supported_interfaces to bcm84881
> net: phy: add supported_interfaces to phylib
> 
> These would be pre-requisites for the 100FX-SGMII SFP support, as the
> interface resolution currently doesn't elect SGMII for 100FX modules.
> 
> That would require some changes to the current host_interfaces API as
> well, potentially replacing it altogether.
> 
> Is this something you can do, or can I get your permission to submit
> these (ofc maybe with more stuff to deal with host_interfaces)

One of the issues that will need to be solved is how to tell
100FX-SGMII (e.g. https://www.fs.com/uk/products/37770.html) which need
SGMII apart from 100FX modules that don't (e.g.
https://www.fs.com/uk/products/37324.html)

host_interfaces don't satisfy that, because this has nothing to do with
what the host can do. Either the module has a PHY and uses SGMII on
the host side, or it doesn't have a PHY in which case 100BASE-X needs
to be used. If we have a PHY, then we will work out using what we
already have.

Given that 100FX-SGMII, the PHY _should_ be coming up in SGMII mode,
so that's what we need to use to talk to them. If we change the PHY's
mode to something else, we get into the horrid problems that is rate
matching, which gives us the problem that we don't have very good
support for that (e.g. PHYs that require the MAC to pace the transmit
rate.)

I suspect there is no way to tell these SFPs apart using the EEPROM,
which means we're left with the "does this module that looks like a
optical module have a PHY?" problem that we already use for copper
SFPs. If there's no detectable PHY, then we'd likely have to assume
that the SFP requires 100BASE-X.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

