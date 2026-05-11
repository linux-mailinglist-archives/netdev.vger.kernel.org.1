Return-Path: <netdev+bounces-286822-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOeLGNQ8AmrmpAEAu9opvQ
	(envelope-from <netdev+bounces-286822-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 22:32:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1DA515E55
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 22:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 050793082D0C
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9BE383C6F;
	Mon, 11 May 2026 20:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3KwT4xka"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DF8382385;
	Mon, 11 May 2026 20:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778531308; cv=none; b=ABLQoVwVGG+eaDws1ZAE9AetkCdw7c69IayPvB6RLspGjh8tjnRQS/qsKiLs8mi+zFAqkKk5Ldnrn94aBP7ozWopBwHheQgoVxwP/brpQsFYRcABTICjfM5gBbdd4rSKj8osE35J8/D0MrM97TJRKZ/6PuWyu1vTWFcCw5qOvXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778531308; c=relaxed/simple;
	bh=yycbcmDmxJXZwdLlt46ayh/SzElwQ1ybZS6aPnUdLQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzRbbhdMCWb6USYXwoengt99xCDlONw1fCMqvU7XLiCEVGR3Ew4Jt5FmJ/I0b4+n4LAI14RXV5oSMi9igx/cr+gSBnslYUky3CX8KLm/2IyE3d9lWOb8Pdtg5pE1YFQ6LcW2RxvFzp3QLIfRUQ4paIZ8C7h6mSUVsRwMsvmJiQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3KwT4xka; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MsFdtNSy+qb1P2t0BGRgl9i/qVRg3tIpfrq6Xuu15eM=; b=3KwT4xka+2zoI8CWJ90+0RA8pZ
	SOhW4mJWoqj3AgC8aL3DlwFZJucHY9yCgfJILH2gJHqlo7no1byHhjqHkcXo0LZeB5OenC4BfCOep
	aQhI1qZFl8+IY7szjt7SSZbkboDFAZrjaTx68LYWoWjoLCPjLbiV5b4xYMtVsz0zMPL0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wMXEZ-002R8t-Ga; Mon, 11 May 2026 22:28:11 +0200
Date: Mon, 11 May 2026 22:28:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 3/9] net: phy: ncn26000: Added PHY loopback
 and read/write MMD callbacks
Message-ID: <0d61943d-0721-4189-a21e-5ddb50efe768@lunn.ch>
References: <CY8PR02MB9249CDA8F2C560FDD0F662D883382@CY8PR02MB9249.namprd02.prod.outlook.com>
 <774d54e2-235c-4685-a582-f9714132923a@lunn.ch>
 <CY8PR02MB9249943F50B421C972FAEDE283382@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB9249943F50B421C972FAEDE283382@CY8PR02MB9249.namprd02.prod.outlook.com>
X-Rspamd-Queue-Id: AA1DA515E55
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286822-lists,netdev=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[lunn.ch:server fail,sea.lore.kernel.org:server fail,onsemi.com:server fail];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[onsemi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 07:44:17PM +0000, Selvamani Rajagopal wrote:
> [..]
> 
> > 
> > On Mon, May 11, 2026 at 06:19:11PM +0000, Selvamani Rajagopal wrote:
> > > - PHY loopback has to set only BMCR_LOOPBACK bit. As a result, we can't
> > > use generic, genphy_loopback.
> > > - Direct MMD calls via Clause 45 read/write avoids indirect calls.
> > 
> > The threading of the patch appears to be broken.
> 
> I am not clear. I did apply all the patches in sequence on a fresh source tree. It applied cleanly. What kind of issues I should watch out for, for the issue of "threading is broken".

Look at other patchsets on the list. All the emails are threaded
together, and if you have a sensible mail client, it should show them
as a tree, with replies extending the tree. 'git send-email' will
thread them by default, so will 'b4'.

> 
> > 
> > Also, one patch, one type of change.
> > 
> > > Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
> > > ---
> > > drivers/net/phy/ncn26000.c | 36 ++++++++++++++++++++++++++++++++++++
> > > 1 file changed, 36 insertions(+)
> > >
> > > diff --git a/drivers/net/phy/ncn26000.c b/drivers/net/phy/ncn26000.c
> > > index 68b0e4647..d302e04c8 100644
> > > --- a/drivers/net/phy/ncn26000.c
> > > +++ b/drivers/net/phy/ncn26000.c
> > > @@ -162,6 +162,39 @@ static int ncn26000_config_intr(struct phy_device *phydev)
> > > return 0;
> > > }
> > >
> > > +/* Directly accessing via Clause 45 read avoids the extra
> > > + * SPI accesses required by indirect access.
> > > + */
> > > +static int ncn26000_read_mmd(struct phy_device *phydev, int dev, u16 reg)
> > > +{
> > > + struct mii_bus *bus = phydev->mdio.bus;
> > > + int addr = phydev->mdio.addr;
> > > +
> > > + return __mdiobus_c45_read(bus, addr, dev, reg);
> > > +}
> > 
> > This needs more explanation. Maybe you need to look into
> > phydev->is_c45.
> 
> I just followed what is in the existing, similar 10base-t1s phy code, microchip_t1s.c. 
> Certainly, I will investigate is_c45 flag.

Look at is from a different direction. What other PHY drivers do what
you do? In general, if you do something no other drivers do, it is
often wrong.

	 Andrew

