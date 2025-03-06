Return-Path: <netdev+bounces-172451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F6DA54B35
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 13:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 574187A3EAC
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 12:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300E61FCCE7;
	Thu,  6 Mar 2025 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Wym7Z1pz"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553AE1F03D2;
	Thu,  6 Mar 2025 12:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741265487; cv=none; b=RnSn8Z9wjPyc+g4Klr0CFHi3+HROAw3YFXxdia8YyGAwKJ73H4xJov84RotEgdCft6p0G9MmQOFsAuOpuctE5LJpvnNVf8xyy984y0gGyu3YGS2BDc1tq4tRipXPEs0ZA4Yo0/qwg/C+vgPbjhtPHhjNU2HcEpDj+9YOw3u4heg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741265487; c=relaxed/simple;
	bh=34VAN2OFOmsWfmTeP0xj7Z0r9E9H+lY0gnxU2rmVX9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+z/M7Sbgrc9cpkRua8t5s/LfaI100hlhiEr3wYt9VMk7xieutSHocIUgLB9a4utmPPbNIwwgolZHKFjjiOsKtnRvHzyMBLsmudULF9vl2zxhuLKJfZJMxECb9GvDorR/s/cTPZm4u2f405eWIUlDparhRHgQEL7joY/o7ixtzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Wym7Z1pz; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JhXEF+8ubYhO3s0wOnwv4NQl+UAMbcESvejL8PtfgWE=; b=Wym7Z1pzeGNrdZxFtFrLtDnnhy
	XSd5wTO0pvEQ8OCTyz3tnz/MX+8cXXsI+6i4N4dqufKLYmo3LDFpO6bEUY1Wu4Jr7/qSPcqPakMkO
	rC/lbF+DhtmmEgSdj7qc+UKfPhDnre+mt2DC67fno6CdBrpQjSqA/hs81FnlWOZOUvyHjZmpcUnMg
	r49QypYYxWFe+4USv9tnYmCqkSdpyeSafrc6XsQOodvlfdGh1BOXXzrOrHNZMQzxdwDep7cHvxwwV
	ixLJJa/exIopKtbLp3r3So7mdoVKrmdXseJVI24IWVOZVu+LrjCAarlfOHTlE4X2Vb6wcdcx9UGNp
	HSPjCCPQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48006)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tqAh4-0005sB-2f;
	Thu, 06 Mar 2025 12:51:18 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tqAh3-0006nz-0O;
	Thu, 06 Mar 2025 12:51:17 +0000
Date: Thu, 6 Mar 2025 12:51:16 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next v4 09/13] net: phylink: Use phy_caps_lookup for
 fixed-link configuration
Message-ID: <Z8maRNYsn1LzjryX@shell.armlinux.org.uk>
References: <20250303090321.805785-1-maxime.chevallier@bootlin.com>
 <20250303090321.805785-10-maxime.chevallier@bootlin.com>
 <350bb4f6-f4b5-44c3-a821-ac53c8641705@redhat.com>
 <20250306111220.28798e6b@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306111220.28798e6b@fedora.home>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Mar 06, 2025 at 11:12:20AM +0100, Maxime Chevallier wrote:
> On Thu, 6 Mar 2025 09:56:32 +0100
> Paolo Abeni <pabeni@redhat.com> wrote:
> 
> > On 3/3/25 10:03 AM, Maxime Chevallier wrote:
> > > @@ -879,8 +880,10 @@ static int phylink_parse_fixedlink(struct phylink *pl,
> > >  	linkmode_copy(pl->link_config.advertising, pl->supported);
> > >  	phylink_validate(pl, pl->supported, &pl->link_config);
> > >  
> > > -	s = phy_lookup_setting(pl->link_config.speed, pl->link_config.duplex,
> > > -			       pl->supported, true);
> > > +	c = phy_caps_lookup(pl->link_config.speed, pl->link_config.duplex,
> > > +			    pl->supported, true);
> > > +	if (c)
> > > +		linkmode_and(match, pl->supported, c->linkmodes);  
> > 
> > How about using only the first bit from `c->linkmodes`, to avoid
> > behavior changes?
> 
> If what we want is to keep the exact same behaviour, then we need to
> go one step further and make sure we keep the same one as before, and
> it's not guaranteed that the first bit in c->linkmodes is this one.
> 
> We could however have a default supported mask for fixed-link in phylink
> that contains all the linkmodes we allow for fixed links, then filter
> with the lookup, something like :
> 
> 
> -       linkmode_fill(pl->supported);
> +       /* (in a dedicated helper) Linkmodes reported for fixed links below
> +        * 10G */
> +       linkmode_zero(pl->supported);
> +
> +       linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT, pl->supported);
> +       linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT, pl->supported);
> +       linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, pl->supported);
> +       linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, pl->supported);
> +       linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT, pl->supported);
> +       linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, pl->supported);
> +       linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, pl->supported);
> +       linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, pl->supported);
> +       linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, pl->supported);

Good idea, but do we have some way to automatically generate the baseT
link modes?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

