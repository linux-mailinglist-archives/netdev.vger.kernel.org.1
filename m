Return-Path: <netdev+bounces-171368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07379A4CAC6
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 19:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 595B7188CAA7
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 18:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A21229B0B;
	Mon,  3 Mar 2025 18:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="TZQaj4gv"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64442288EE;
	Mon,  3 Mar 2025 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741025340; cv=none; b=huVsEHyC9aM/h/Wr3QS2VU/ng1EyN1ycCpXkv8KxxNY39U4WOyLXe5jyTEetbjtgyfJpySpLj7QTRkPPG+gAK1wgh4XVZRO00J/T7XE7nfDnO6No3W21SJ5djgNhmdlvkSD5akLCZtSauha0UgBbuIpW49xTwbupb4MA4lgcubE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741025340; c=relaxed/simple;
	bh=aj6N1GLa5alZViG51ZwvQCcI2U+p1nUxbjv0CHUX4HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3C9Oug+fOMvktnrtnEQqI+GN2xjIYOt4VtVJlYHdGV7VFJjlMqsNFjGwUpLwqugk96vZBRr63FGjaIs1KtV/yQKgO+v7f0iRli3enkV/2BGVYxISBY2jmthiEHWRXRWj38ZIxQMTAiioZSY0RdoDR/Cq+KGqtaVh4b/rBP2KLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=TZQaj4gv; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xS4uhOu8wAN508iLqvkw2PXwk6gwzZICOBJ4+ud5Q1g=; b=TZQaj4gvtaWpPahxZvTs9TFnIg
	J6S2R5SY1sO/m1XmA+O1hZW0sAfJZxbE6QU4xhtkLXmyp+z9twz3HZWVUM/2kAbiTkIXyaSuvh6/C
	9Lz4n6Bf1Vow9zWNpt0wMymdnk4vjhnTlw5mD2tjRCmtSv/0iQhltfkoiQJh09LRijXPfUcXJUKGF
	ms+Sszx9CsOkIkw0wd4N61uDnlbMPWftx0KaysvXQl5y9VMtGWoMlx3qo056wv8pWtLCMNT6Ye65X
	q4kt/XXZH3OzFci3cYgS8/pyckfAN3tcmD4v0TwZ86Cu+CdwQ5T2cq5pLN0CW1d1WVocQAZNHcDo1
	RnoYEgwg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33888)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tpADj-00017X-1K;
	Mon, 03 Mar 2025 18:08:51 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tpADi-0003yv-0S;
	Mon, 03 Mar 2025 18:08:50 +0000
Date: Mon, 3 Mar 2025 18:08:49 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Catalin Popescu <catalin.popescu@leica-geosystems.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: phy: dp83826: Add support for straps reading
Message-ID: <Z8XwMR-F2U8rUTNh@shell.armlinux.org.uk>
References: <20250303-dp83826-fixes-v1-0-6901a04f262d@yoseli.org>
 <20250303-dp83826-fixes-v1-2-6901a04f262d@yoseli.org>
 <Z8Xl9blPRVXQiOSm@shell.armlinux.org.uk>
 <aaf511ad-d7eb-454c-83c0-84f0d14f323d@yoseli.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaf511ad-d7eb-454c-83c0-84f0d14f323d@yoseli.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Mar 03, 2025 at 06:35:04PM +0100, Jean-Michel Hautbois wrote:
> Hi Russel,
> 
> On 03/03/2025 18:25, Russell King (Oracle) wrote:
> > On Mon, Mar 03, 2025 at 06:05:52PM +0100, Jean-Michel Hautbois wrote:
> > > +	/* Bit 10: MDIX mode */
> > > +	if (val & BIT(10))
> > > +		phydev_dbg(phydev, "MDIX mode enabled\n");
> > > +
> > > +	/* Bit 9: auto-MDIX disable */
> > > +	if (val & BIT(9))
> > > +		phydev_dbg(phydev, "Auto-MDIX disabled\n");
> > > +
> > > +	/* Bit 8: RMII */
> > > +	if (val & BIT(8)) {
> > > +		phydev_dbg(phydev, "RMII mode enabled\n");
> > > +		phydev->interface = PHY_INTERFACE_MODE_RMII;
> > > +	}
> > 
> > Do all users of this PHY driver support having phydev->interface
> > changed?
> > 
> 
> I don't know, what is the correct way to know and do it ?
> Other phys did something similar (bcm84881_read_status is an example I
> took).

That's currently known to only be used in a SFP, and therefore it uses
phylink, and therefore changing ->interface is supported (phylink's
design is to support this.)

> > > +
> > > +	/* Bit 5: Slave mode */
> > > +	if (val & BIT(5))
> > > +		phydev_dbg(phydev, "RMII slave mode enabled\n");
> > > +
> > > +	/* Bit 0: autoneg disable */
> > > +	if (val & BIT(0)) {
> > > +		phydev_dbg(phydev, "Auto-negotiation disabled\n");
> > > +		phydev->autoneg = AUTONEG_DISABLE;
> > > +		phydev->speed = SPEED_100;
> > > +		phydev->duplex = DUPLEX_FULL;
> > > +	}
> > 
> > This doesn't force phylib to disallow autoneg.
> 
> Is it needed to call phy_lookup_setting() or something else ?

Have a look at phy_ethtool_ksettings_set(), there's some clues in
there about how to prevent autoneg being enabled.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

