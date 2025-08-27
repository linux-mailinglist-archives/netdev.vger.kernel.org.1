Return-Path: <netdev+bounces-217229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AD720B37E10
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 10:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 549124E2742
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 08:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2868237165;
	Wed, 27 Aug 2025 08:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Tg4hzYs8"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235F21F7586;
	Wed, 27 Aug 2025 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756284339; cv=none; b=gpe4jKgPCjF6tkBrBNQA3UmYWyZIX2nJAZEv5REi09+bq3dQl+SpeQL/C3mWNHLi+8bbwjxqqFnDgqoJ+j0tyYivQ4NMY3ylnUpcGRpaR5OQ2FCjOWUYh3SN5vy5pp+dKXgTHFTsuVtk+8Rn14Rp0bYOmPnIYlOLgStNK+0xh9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756284339; c=relaxed/simple;
	bh=qL+aMfVB16VP6zKXPU4QdEutUKy6kqDQAzOZCBT3+SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gaK5ETCLZy2chZcFsxNBsNvhupY9N0HIkND5l2jKSYC3in092aQLsc8hsrSYnJ5oWT6O9milXra9WukP4i0fmzXhynvHTop8wqm0kT71mzhaeFe7XDfZ1WHkATVxf/5ZUD93OES48r3ECZHTRhmntWgilIoCfk6SLW3DI6nyvUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Tg4hzYs8; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5MnBsqYuGg+eyK4Yde3+M+2B8jdthYxqSMDrNff11io=; b=Tg4hzYs8Z0+zqY7R0XehbNF3gZ
	SwlF7pBNMDKfOn7FnPC79gPVHCu0phZpW/KOlnXHXU7r5bIZwOJ5rIhIkm4dT9G4sgYdTVzfCJNYY
	OTVP/l5PR4hQRVj4522hJI0TuKTGXYh1INGqWDffM3xc2zvVs7RmY5FQwWJG7E1Iw3drU70s4FzIy
	FymjBB+ICfrydSWGJT1MxRlClVTSGBkvpEEQRgOxCsTTo9mzuQy2tiYGQoqvR4uzG1tv5f8b3grSo
	GHNWe9vuz9u1XZHyKa8M4+VpqdD662XMVAsIY30tGH3zC87n9Je7/R6DnQefNCiWt9QQx8S3XZATj
	astELmpg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53718)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1urBmd-000000000FJ-3Mub;
	Wed, 27 Aug 2025 09:45:31 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1urBmb-0000000023R-2GYL;
	Wed, 27 Aug 2025 09:45:29 +0100
Date: Wed, 27 Aug 2025 09:45:29 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <aK7FqX3cZGn_z3xC@shell.armlinux.org.uk>
References: <aJDH56uXX9UVMZOf@FUE-ALEWI-WINX>
 <20250804160037.bqfb2cmwfay42zka@skbuf>
 <20250804160234.dp3mgvtigo3txxvc@skbuf>
 <aJG5/d8OgVPsXmvx@FUE-ALEWI-WINX>
 <20250805102056.qg3rbgr7gxjsl3jd@skbuf>
 <aJH8n0zheqB8tWzb@FUE-ALEWI-WINX>
 <20250806145856.kyxognjnm4fnh4m6@skbuf>
 <aK6eSEOGhKAcPzBq@FUE-ALEWI-WINX>
 <aK68-Bp77-HiOAJk@shell.armlinux.org.uk>
 <aK7CmzwQoINd1eYA@FUE-ALEWI-WINX>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK7CmzwQoINd1eYA@FUE-ALEWI-WINX>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Aug 27, 2025 at 10:32:27AM +0200, Alexander Wilhelm wrote:
> Am Wed, Aug 27, 2025 at 09:08:24AM +0100 schrieb Russell King (Oracle):
> > On Wed, Aug 27, 2025 at 07:57:28AM +0200, Alexander Wilhelm wrote:
> > > Hi Vladimir,
> > > 
> > > One of our hardware engineers has looked into the issue with the 100M link and
> > > found the following: the Aquantia AQR115 always uses 2500BASE-X (GMII) on the
> > > host side. For both 1G and 100M operation, it enables pause rate adaptation.
> > > However, our MAC only applies rate adaptation for 1G links. For 100M, it uses a
> > > 10x symbol replication instead.
> > 
> > This sounds like a misunderstanding, specifically:
> > 
> > "our MAC only applies rate adaptation for 1G links. For 100M, it uses
> > 10x symbol replication instead."
> > 
> > It is the PHY that does rate adaption, so the MAC doesn't need to
> > support other speeds. Therefore, if the PHY is using a 2.5Gbps link
> > to the MAC with rate adaption for 100M, then the MAC needs to operate
> > at that 2.5Gbps speed.
> > 
> > You don't program the MAC differently depending on the media side
> > speed, unlike when rate adaption is not being used.
> 
> You're right. The flow control with rate adaptation is controlled by PHY. The
> MAC should remain on the 2.5Gbps speed. Therefore I wonder why it uses 10x
> symbol repetition.

As I say, someone is misunderstanding something. The PHY controls what
happens at the different media speeds.

I wonder whether the hardware engineer is thinking that the PHY is
configured for SGMII mode at 100Mbps - whic his controlled by vendor
1 register 0x31b. If the 3 LSBs are 4, then it's using "OCSGMII"
otherwise if 3, then it'll be as the hardware engineer states.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

