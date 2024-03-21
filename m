Return-Path: <netdev+bounces-81088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA5F885B8B
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 16:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50E091F23BC2
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 15:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7BC86245;
	Thu, 21 Mar 2024 15:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="032yd3Nt"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A334341775
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711034420; cv=none; b=SvkkZDN4zVjT2rvJe39oiGt6QT5PEV7RdTYAvYdWbj5D1uvO8h0uqArCoNQZrmN+HysNiL72h3Bgw15G0YTfo+lbiCbh3d11pHkmFc7sT/3oI7uZoeQ3bQ/4OeV9hh3YPmMvSCpkAKCgi+9b6Cdiix/bCRIM6doF63abH77oEtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711034420; c=relaxed/simple;
	bh=a8L+r/WgZKh8WGMxTxqY+uOGEgGQ0Fox0PcFSNsbsN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwuUV4UpBPasE8W/7abnPuOiA8KflM47FxCstb+suqf95scSqX7niFFPhWvhVzAZs3PK311+/9qVp5lQGzULpetnRocr33cWfmRRWL5cjG0M2lo6A/TjqbLC1p4z3ka26v7wRZQ8HGNAKw4mkTjpaq618F137+cYTcSq+TW/rHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=032yd3Nt; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3QwreFba4V6cTvbMe2rDoaG4HSH3DquQOHnuns3P/2M=; b=032yd3NtEk9kOAnzoMBoi5oeME
	8fFNuGiCAWgGrdW2qIMOKLT3Eb3+98p8ENUx5H7KyilnEjHmOKu7+kqVJHoPv0uZuXEncooDQ6oE6
	4JwBleYWQtaRja4A1U05fo64mKWOzEMJW4q231AfG++p9/h7Snpa2t3NSWFCLIcwQ/00C8uAywPQl
	WWwhmNdyKHYQqsN3UqYo4TZnjrEcqT5nZJDo6o3MUBn+e9xRVHN/fVGLlXmGWecOqRUg95u8nWMBa
	2Bd4FY+Qm8ZVlacvOy4tzp6lQOyGblmTxSyLIoznO/oyV84+X5v33vewgw0P9ek0U4gbZw0d1YoOd
	Rdz0dwBw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45156)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rnKD4-0007hj-0x;
	Thu, 21 Mar 2024 15:20:02 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rnKD0-0003kS-86; Thu, 21 Mar 2024 15:19:58 +0000
Date: Thu, 21 Mar 2024 15:19:58 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Yanteng Si <siyanteng@loongson.cn>,
	Serge Semin <fancer.lancer@gmail.com>, hkallweit1@gmail.com,
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, Jose.Abreu@synopsys.com,
	chenhuacai@loongson.cn, guyinggang@loongson.cn,
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 08/11] net: stmmac: dwmac-loongson: Fix MAC
 speed for GNET
Message-ID: <ZfxQHv7Y5Pqgfq4c@shell.armlinux.org.uk>
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <e3c83d1e62cd67d5f3b50b30f46c232a307504ab.1706601050.git.siyanteng@loongson.cn>
 <fg46ykzlyhw7vszgfaxkfkqe5la77clj2vcyrxo6f2irjod3gq@xdrlg4h7hzbu>
 <4873ea5a-1b23-4512-b039-0a9198b53adf@loongson.cn>
 <2b6459cf-7be3-4e69-aff0-8fc463eace64@loongson.cn>
 <odsfccr7b3pphxha5vuyfauhslnr3hm5oy34pdowh24fi35mhc@4mcfbvtnfzdh>
 <a9e27007-c754-4baf-84ed-0deed9f29da4@loongson.cn>
 <3c551143-2e49-47c6-93bf-b43d6c62012b@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c551143-2e49-47c6-93bf-b43d6c62012b@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Mar 21, 2024 at 04:02:54PM +0100, Andrew Lunn wrote:
> On Thu, Mar 21, 2024 at 05:29:55PM +0800, Yanteng Si wrote:
> > 
> > 在 2024/3/20 01:02, Serge Semin 写道:
> > > > > Due to a bug in the chip's internal PHY, the network is still not working after
> > > > > the first self-negotiation, and it needs to be self-negotiated again.
> > > Then please describe the bug in more details then.
> > > 
> > > Getting back to the code you implemented here. In the in-situ comment
> > > you say: "We need to use the PS bit to check if the controller's
> > > status is correct and reset PHY if necessary." By calling
> > > phy_restart_aneg() you don't reset the PHY.
> > > 
> > > Moreover if "PS" flag is set, then the MAC has been pre-configured to
> > > work in the 10/100Mbps mode. Since 1000Mbps speed is requested, the
> > > MAC_CTRL_REG.PS flag will be cleared later in the
> > > stmmac_mac_link_up() method and then phylink_start() shall cause the
> > > link speed re-auto-negotiation. Why do you need the auto-negotiation
> > > started for the default MAC config which will be changed just in a
> > > moment later? All of that seems weird.
> > 
> > When switching speeds (from 100M to 1000M), the phy cannot output clocks,
> > 
> > resulting in the unavailability of the network card.  At this time, a reset
> > of the
> > 
> > phy is required.
> 
> reset, or restart of autoneg?
> 
> > BTW, This bug has been fixed in gnet of 2k2000 (0x10, 7a13).
> > 
> > > 
> > > Most importantly I have doubts the networking subsystem maintainers
> > > will permit you calling the phy_restart_aneg() method from the MAC
> > > driver code.
> 
> That is O.K. It should have a comment explaining that it is working
> around a hardware bug. And you need to take care of locking. But a MAC
> driver can call this, e.g. if it implements ethtool nway_reset, it
> needs to do exactly this. See phy_ethtool_nway_reset().

However, because stmmac uses phylink, we should be adding phylink
interfaces that forward to phylib to avoid the layering violation.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

