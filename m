Return-Path: <netdev+bounces-219622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D85FEB425F9
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 17:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 986363A1CA0
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 15:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2336E2874E4;
	Wed,  3 Sep 2025 15:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ZMCt5Am0"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1476A21D5B3;
	Wed,  3 Sep 2025 15:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756914736; cv=none; b=pXiG5o6HGjGxWAoWKw6ZT+TlFhw4d/eVsL25iuOMxdFpT206+fGw3rTTZaMel/u6ONGKg9dA9+5YY5IwVlcQo/kXG3QHmOhDr5G0Ot8Jjfilxzq0nU7324kcjYlj0btcZRGVTuKwp+s6EQR18JeKQyN9OhSfnjvX/GVgyJcTID0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756914736; c=relaxed/simple;
	bh=a1yA4jUQ5l1E5iJTp9AQgTYYm687vZMk3gU+OqtM9Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3QbB8yeeBtDL1Q2wUYsc05t0OweYWtyPSEuEHVo8GS64725aIwloEmf/z41S2Mb135/V5NbtAJ6kAzW2SvozYRAaTl3BZGKCS/4u9TrJWIHPu8AmikivdUzMY3iqNE44tgF/hSowRgUfIVBBUTE0F0kBJZDDBheh8KTbPbNaA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ZMCt5Am0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UO8sfqFJi/fVejE+Tg3iYyOh3DnadUFH30obltVdUHc=; b=ZMCt5Am0uW7ZzyWprCxlWsJBlI
	IRytku73GtWFO5o1WFmDNqzFdJlYjQz8kCrMDWr7T1AFIEB4QMaQEtbgRRGH0Nw5PTPO4654Q8puI
	lx4Vh+Id7lLGELyH8zSMhPIAOyX9h+4g1zPhbsi6ucu2OGp82HADyV5YeiRb8qr8JFqVBrNkrzbLS
	kQKi0w9X+YH0ibESholcPALDcUSuAFkUtyq+SX6YtbEz6zra/8bNBfQsGZwW20EqnF6GTwCAVWzTG
	k5i6cXGDTPXtSOPUvOzjdTAL5wrlzMlBM/2GgvlaTMLlpEWzqoyG0EPJykx4ftjHtyaKsc0qijLPo
	8MSfz1Tw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44846)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1utpmN-000000000kl-0biF;
	Wed, 03 Sep 2025 16:52:11 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1utpmL-000000000f5-17Dg;
	Wed, 03 Sep 2025 16:52:09 +0100
Date: Wed, 3 Sep 2025 16:52:09 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net 1/2] net: phylink: add lock for serializing
 concurrent pl->phydev writes with resolver
Message-ID: <aLhkKVsbrkXmFbgK@shell.armlinux.org.uk>
References: <20250903152348.2998651-1-vladimir.oltean@nxp.com>
 <aLheK_1pYbirLe8R@shell.armlinux.org.uk>
 <20250903153120.4oiwyz6bxfj3fuuv@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903153120.4oiwyz6bxfj3fuuv@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Sep 03, 2025 at 06:31:20PM +0300, Vladimir Oltean wrote:
> On Wed, Sep 03, 2025 at 04:26:35PM +0100, Russell King (Oracle) wrote:
> > On Wed, Sep 03, 2025 at 06:23:47PM +0300, Vladimir Oltean wrote:
> > > @@ -2305,6 +2314,7 @@ void phylink_disconnect_phy(struct phylink *pl)
> > >  
> > >  	phy = pl->phydev;
> > >  	if (phy) {
> > > +		mutex_lock(&pl->phy_lock);
> > 
> > If we can, I think it would be better to place this a couple of lines
> > above and move the unlock.
> 
> Sorry for potentially misunderstanding, do you mean like this?
> 
> 	mutex_lock(&pl->phy_lock);
> 	phy = pl->phydev;
> 	if (phy) {
> 		mutex_lock(&phy->lock);
> 		mutex_lock(&pl->state_mutex);
> 		pl->phydev = NULL;
> 		pl->phy_enable_tx_lpi = false;
> 		pl->mac_tx_clk_stop = false;
> 		mutex_unlock(&pl->state_mutex);
> 		mutex_unlock(&phy->lock);
> 		mutex_unlock(&pl->phy_lock);
> 		flush_work(&pl->resolve);
> 
> 		phy_disconnect(phy);
> 	} else {
> 		mutex_unlock(&pl->phy_lock);
> 	}
> 
> move the unlock where? because flush_work(&pl->resolve) needs to happen
> unlocked, otherwise we'll deadlock with phylink_resolve().
> 
> Additionally, dereferincing pl->phydev under rtnl_lock() is already safe,
> and doesn't need the secondary clock.

The reason I'm making the suggestion is for consistency. If the lock
is there to ensure that reading pl->phydev is done safely, having one
site where we read it and then take the lock makes it look confusing.
I've also been thinking that it should be called pl->phydev_mutex
(note that phylink uses _mutex for mutexes.)

To avoid it looking weird, what about this:

	mutex_lock(&pl->phy_lock);
	phy = pl->phydev;
	if (phy) {
		mutex_lock(&phy->lock);
		mutex_lock(&pl->state_mutex);
		pl->phydev = NULL;
		pl->phy_enable_tx_lpi = false;
		pl->mac_tx_clk_stop = false;
		mutex_unlock(&pl->state_mutex);
		mutex_unlock(&phy->lock);
	}
	mutex_unlock(&pl->phy_lock);

	if (phy) 
 		flush_work(&pl->resolve);
 
 		phy_disconnect(phy);
 	}


-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

