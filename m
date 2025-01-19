Return-Path: <netdev+bounces-159623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A44A16228
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 15:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8D6164759
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 14:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09831DF247;
	Sun, 19 Jan 2025 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dDsjNm0v"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E1F2F3E;
	Sun, 19 Jan 2025 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737296892; cv=none; b=Ej8jyW0comb+q1z4s7UqUSHTqqlzjPm5/RlkZoXpwtg+V0xRuYXKvAqq3ceLSqHeDKk9rlGjr3BOVflwkNjGBujLc61/fWgU9gv1I/MvSJLc4ONk0/KAEbupbbdtA99MFv7zXZV8Rai7zLr58qnyxof5dcnWHyPn88YG8/qQcF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737296892; c=relaxed/simple;
	bh=e5hrk7OrE5y1dTM/2PXLH7LleW0yA5X/lrYiq+edKik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7wsywTzo8j5T/r7NpgsQ0DUydczSv8M/1gHLPh8FDOQJgEjYXoj94llKGyamwYh1D8tK3kJ9KB4Iq2yueOICFP/k3OlZHMGjgb/UI/6MdIdpZBnvP36SBVv1rY1/hcJer7djUAyZ2aopSk+NZpNQ3YXZHcwZF6n3KOkt1gMd+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=dDsjNm0v; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0kfcCgIgXm7QyFfs8M5wVGOvlW2P6Ht1R7gmvS654No=; b=dDsjNm0v2LK0T3Nl6hpp4jT7n+
	ZIFi8saqwfzx4q1ULlX/dHK4eB7VRJ3B5sinZU7WasjAHUITwtMiq++VC7jPP4nzf3lDvC9p6pLwE
	JlAlL5Bp5yZqCIczO9b+/lK2o47KPmMwfMkA1T27/BkxCUJO15GC5/M0ZpdMj0hYyLW0CUjHtsTAr
	QeJz+tqO+b9iD9sC8yI+JcgpknYbi2rpIgWb4ePR37Iy+VVNLqbkP/AAtLdF4azNmXZVeNnXZc6mc
	sji5tNJaUJDxoJVvUZtM4mAlFfjKG1XUrTj1SLwPaLNmOzilL/Gy6mOZby/m8OxSCb87n4yTxM7qA
	0uWq63aA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49722)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tZWHN-0005JA-1L;
	Sun, 19 Jan 2025 14:27:57 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tZWHK-0001vB-0F;
	Sun, 19 Jan 2025 14:27:54 +0000
Date: Sun, 19 Jan 2025 14:27:53 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] net: phy: Fix suspicious rcu_dereference
 usage
Message-ID: <Z40L6Vhm7lwPGy6W@shell.armlinux.org.uk>
References: <20250117173645.1107460-1-kory.maincent@bootlin.com>
 <CANn89i+PM5JLdN1meKH_moPe88F_=Nsb3in+g-ZK5tiH4PH5GA@mail.gmail.com>
 <20250117231659.31a4b7fa@kmaincent-XPS-13-7390>
 <20250117190720.1bb02d71@kernel.org>
 <20250119134518.6c49d2ca@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250119134518.6c49d2ca@kmaincent-XPS-13-7390>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Jan 19, 2025 at 01:45:18PM +0100, Kory Maincent wrote:
> On Fri, 17 Jan 2025 19:07:20 -0800
> Jakub Kicinski <kuba@kernel.org> wrote:
> 
> > On Fri, 17 Jan 2025 23:16:59 +0100 Kory Maincent wrote:
> > > > If not protected by RTNL, what prevents two threads from calling this
> > > > function at the same time,
> > > > thus attempting to kfree_rcu() the same pointer twice ?    
> > > 
> > > I don't think this function can be called simultaneously from two threads,
> > > if this were the case we would have already seen several issues with the
> > > phydev pointer. But maybe I am wrong.
> > > 
> > > The rcu_lock here is to prevent concurrent dev->hwprov pointer modification
> > > done under rtnl_lock in net/ethtool/tsconfig.c.  
> > 
> > I could also be wrong, but I don't recall being told that suspend path
> > can't race with anything else. So I think ravb should probably take
> > rtnl_lock or some such when its shutting itself down.. ?
> 
> Should we add an ASSERT_RTNL call in the phy_detach function? (Maybe
> also in phy_attach to be consistent)
> Even thought, I think it may raise lots of warning from other NIT drivers.

How many drivers use phy_detach() ?

The answer is... phylink, bcm genet and xgbe.

Of the phylink ones:

1. phylink_connect_phy() - for use by drivers. This had better be
   called _before_ the netdev is registered (without rtnl) or
   from .ndo_open that holds the RTNL.

2. phylink_fwnode_phy_connect() - same as above.

3. phylink_sfp_config_phy(), called from the SFP code, and its state
   machines. It will be holding RTNL, because it is only safe to
   attach and detach PHYs from a registered netdev while holding RTNL.

I haven't looked any further.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

