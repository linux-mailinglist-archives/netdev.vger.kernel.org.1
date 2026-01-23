Return-Path: <netdev+bounces-252845-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHTIFxN5c2kfwAAAu9opvQ
	(envelope-from <netdev+bounces-252845-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 14:35:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1F176504
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 14:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86D23301681C
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 13:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2F43191A9;
	Fri, 23 Jan 2026 13:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="LaeSsblS"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311FD231845;
	Fri, 23 Jan 2026 13:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769175312; cv=none; b=HKw44P1wo/4Ppcc61ZBV4uRBJ3am5Z9ntIbF3ICAy5fSxBGAImbEjlBr9mazfebAyxpJbIpeshr0pZpFA/fPGs+URi7YyEFUorBmODZYzllw4LTzXcofKKuhIiWyHuKpvHXVS2m+iV40K0oZohsl3vPLimwmOear1Ec+R7HA4/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769175312; c=relaxed/simple;
	bh=X039U1bfhepzF9Gp9QspBS7KBVRei43zaaQaajRnAeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJzFuC/3Zg6bmvuLpi/a5irEVoN/VXvx4zPhJnUw/Kyhhl9Px387g44wRx3L1HzxJfVyp0NnKBI3axl+WvIYR1rKjwb7Ia6fksxsvUIXCfTVFL1ApPktTsW8ckhH7vUx48A/zc5lcOyxEjskvei2FqRkNp2/zDlLS/9OqCxvdj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=LaeSsblS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Smxnn5dWQ4/4bUGlRZS4XCHI/IXGZlGh4XNQEy4VpbA=; b=LaeSsblSBshMPWSf7QNaFiaU04
	Z/FSuWjEY+FIkXSZX9FQ22sO9ZYhArehX94PJ4hcJadQAu+EQZQTCPO39CUjrQf5PO1TcOGO9gZpR
	TniFHaII06vsPC5Mjl+xpf4HLzhfEmimf1lmLU+6UpPpoyYPvzKbx40p14oH/JlOUa33kyM3MU3td
	9KNH96DSR86O+1rF+nT43kVrhAV/wxsdlVfvpCLrrphbFy6jz7vsD7bgaoJOq4Q4+rOr++u6QNlum
	qebXJBAZaPbiGRKYQyXeFC8hrv6s4D5Nrz2BBgEJ6ASvQXkf42DBQfJz+kk46jMzpDCJUAkpm4Rgs
	hT/mTLEQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33816)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vjHJY-0000000023b-0Epm;
	Fri, 23 Jan 2026 13:35:04 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vjHJV-0000000027n-1Jkw;
	Fri, 23 Jan 2026 13:35:01 +0000
Date: Fri, 23 Jan 2026 13:35:01 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2 0/3] net: phy: as21xxx: toggle In Band
 feature support
Message-ID: <aXN5BW9AZ-OKYVrt@shell.armlinux.org.uk>
References: <20260123120117.10883-1-ansuelsmth@gmail.com>
 <aXNmrVgpzvPwoyL1@shell.armlinux.org.uk>
 <697372f1.df0a0220.291d22.85ee@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <697372f1.df0a0220.291d22.85ee@mx.google.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252845-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.849];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: CC1F176504
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 02:09:01PM +0100, Christian Marangi wrote:
> On Fri, Jan 23, 2026 at 12:16:45PM +0000, Russell King (Oracle) wrote:
> > [Please note: gmail.com has become unreliable for email delivery,
> > google has too much power to decide what is spam and what isn't, with
> > no route for appeal. please consider switching to a different email
> > provider.]
> >
> 
> Thanks for reporting this. I'm also noticing for a while some legit
> email from mailing list going to spam. I have a new mail from a long
> time but never took the time to actually made the switch for kernel
> submission. Also it's mostly new so I guess it needs to earn some cretis
> as it will get directly rejected by some service. Chicken Egg problem...

It's worse than that. Google is permanently rejecting patch series from
me now - you won't even get it in your "spam" folder. This is only going
to get worse, because there is no way to appeal against this, and
domains such as my own, and even kernel.org, have to just suck it
because google has all the power due to its dominance, caused by people
using it.

The only solution to this is to stop using gmail, causing it to lose
market share.

> > On Fri, Jan 23, 2026 at 01:00:28PM +0100, Christian Marangi wrote:
> > > This is a new variant of the previous submitted patch adding a similar
> > > feature.
> > > 
> > > Old Aeonsemi Firmware permitted only to enable or disable In Band
> > > support and it couldn't be disabled after (or there wasn't a
> > > way to detect the current state of it)
> > > 
> > > As suggested by Russell this was bad Implementation. Some talk
> > > with Aeonsemi permitted to release a new firmware with correct
> > > implementation.
> > > 
> > > This series adds support for this if new firmware (1.9.1+) is
> > > used. On the new firmware, 2 new IPC command are introduced
> > > to GET the current state of DPC RA (Rate Adaption) or SET it.
> > > (DPC RA is effectively In Band mode)
> > > 
> > > It was verified on the same scenario and can confirm it works
> > > as expected. (Airoha AN7581/AN7583 with and without In Band
> > > mode) (If PCS is set to In Band and PHY isn't then no
> > > connection, so it's easy to verify correct functionality of
> > > this)
> > > 
> > > The new firmware is currently submitted to linux-firmware
> > > awaiting it to be merged.
> > > 
> > > For old firmware to save on compatibility we still enable
> > > In Band by default (this is what the current driver do)
> > > 
> > > This was discovered to be needed in some scenario as is effectively
> > > the most compatible featureset.
> > > 
> > > On a BananaPi R4 Pro, one of the 2 AS21xxx PHY is connected to
> > > one of the Switch port and such switch supports only In Band when
> > > set to USXGMII (assuming the Switch expect an SFP module to be
> > > attached where in absence of i2c or MDIO line In Band is always
> > > required)
> > 
> > Coupling the PHY's rate adaption with inband support, but not setting
> > phydev->rate_matching anywhere in this driver seems wrong, and highly
> > suspicious. I'm not sure what to think given what you've said above,
> > it just seems completely wrong what has happened here.
> > 
> 
> Honestly speaking the Rate Adaption thing is what I found in some
> strange API c code on the downstream driver where they say that in
> DPC_RA RA is Rate Adaption.
> 
> My personal idea is that, that thing toggle also other stuff and not only
> Rate Adaption.
> 
> On the Airoha PCS In Band is controlled by enabling and disabling AN
> register (and this also apply to Mediatek PCS)
> 
> With AN enabled, DPC RA needs to be enabled or no traffic.
> With AN disabled, DPC RA needs to be disabled or not traffic.
> 
> This both apply to Airoha and Mediatek PCS.
> 
> For the Switch, it's a different story. Everything is controlled by a
> Firmware blob and it's only possible to send command to setup the
> Serdes mode (USXGMII in this case)
> I made lots of test with forcing speed or trying to find a way to make
> it work but the only combo I found working was USXGMII + DPC_RA enabled.
> 
> For the lack of .get_rate_matching should be set to RATE_MATCH_NONE
> AFAIK for this PHY.
> 
> To give more info comments in the downstream driver at dpc_ra_enable
> have "Set USXGMII mode.".
> But I verified that PCS at USXGMII (but no In Band) and DPC_RA off
> I have correct link up and traffic. So it's not dropping to 10g base-r
> somehow with DPC_RA disabled and if it was the case the PCS should be
> configured for that mode (there are specific register for that).

Let me be clear: if the PHY hardware is doing rate adaption, then the
driver needs to be setting phydev->rate_matching accordingly when
reading the other media parameters from the PHY, so that other parts
of the system know that the media speed is not the speed that the
host interface to the PHY needs to operate at.

Only if the PHY is _not_ doing rate adaption, then setting it to
RATE_MATCH_NONE is appropriate. All other cases, it should be set
to one of the others.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

