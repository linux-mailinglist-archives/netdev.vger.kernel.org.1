Return-Path: <netdev+bounces-235039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1974C2B7C1
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 12:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0F33AAAFD
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 11:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F491303A15;
	Mon,  3 Nov 2025 11:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="LDxM83/r"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B562EC09A
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 11:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762170227; cv=none; b=WpHnKRFNUzf0/vkeezkQq2xCCVu6zw1ipQ0p7Pb90Hn/ZCP0XhGB/9N6VrB8FlE51ExOmKrLz/F5Xp0UUDvCMjI02ZxZWwj2RsmzawshSJUPdjCExKAKvu1Vk8Hdt7ypd9zSfybs8+MXawwz7FZNslXU58fWrfFcZkX/LwNPmZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762170227; c=relaxed/simple;
	bh=gXqfqo3oWjRF2VoSu32i9LBFsBfKRPfma24sW5oY/Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlidA/Sz/nJCZ8Z/u8bAamJHfGPm9iWj0HpJdp29+KKY065QMXnFDYSziBRV5IOiSapBNizV7u9sgfMoCP5jm7kPggvbXZlwnVboIhFsCN2jNbbZqut0T9xIhL5D55wBNWhKiXl5938Q50WdDEbvZg8wqXU+5eCysgDtxZzqoU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=LDxM83/r; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BXuMJWywnmqLRFVSrlO0g4wLfEyDjnCQbBY2E7xN+7w=; b=LDxM83/rO3g7Z31rdahnjmiy62
	3ZSi9SC6X7XnsfCTlJ4CCf83JJFgU3bYHdp8475HXM3tI/29f1nEoD7jSUOM2dXdHldLjK+WA8TVa
	27XcJ9cSvK8+/paflZggp9LdelNUEfw5T9OpQf8iqHILFL7gHqR3amaXVSHHOfelpJ63Rm7E/KcQy
	h5mIITItmiZPBiVoItNcpG99R+MuylVz5bvro+znkJzkeQwWUafDoILRuBuTuhZTX39JbHpPCsbVz
	lL96cRh2cA9Y2cLBgsde4hfRxFdYpcOI/dgzMA6CnSs0ky5if7qx4cKIZ3tCLHURJ/ygmojo03qwY
	ymf4JXsw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50598)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vFsy8-000000000eF-3CVg;
	Mon, 03 Nov 2025 11:43:28 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vFsy3-000000003m0-3BBY;
	Mon, 03 Nov 2025 11:43:23 +0000
Date: Mon, 3 Nov 2025 11:43:23 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Furong Xu <0x1207@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH net-next 0/3] net: stmmac: phylink PCS conversion part 3
 (dodgy stuff)
Message-ID: <aQiVWydDsRaMz8ua@shell.armlinux.org.uk>
References: <aQExx0zXT5SvFxAk@oss.qualcomm.com>
 <aQHc6SowbWsIA1A5@shell.armlinux.org.uk>
 <aQNmM5+cptKllTS8@oss.qualcomm.com>
 <aQOB_yCzCmAVM34V@shell.armlinux.org.uk>
 <aQOCpG_gjJlnm0A1@shell.armlinux.org.uk>
 <aQhusPX0Hw9ZuLNR@oss.qualcomm.com>
 <aQh7Zj10C7QcDoqn@shell.armlinux.org.uk>
 <aQiBjYNtJks2/mrw@oss.qualcomm.com>
 <20251103104820.3fcksk27j34zu6cg@skbuf>
 <aQiP46tKUHGwmiTo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQiP46tKUHGwmiTo@oss.qualcomm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Nov 03, 2025 at 04:50:03PM +0530, Mohd Ayaan Anwar wrote:
> On Mon, Nov 03, 2025 at 12:48:20PM +0200, Vladimir Oltean wrote:
> > 
> > As Russell partially pointed out, there are several assumptions in the
> > Aquantia PHY driver and in phylink, three of them being that:
> > - rate matching is only supported for PHY_INTERFACE_MODE_10GBASER and
> >   PHY_INTERFACE_MODE_2500BASEX (thus not PHY_INTERFACE_MODE_SGMII)
> > - if phy_get_rate_matching() returns RATE_MATCH_NONE for an interface,
> >   pl->phy_state.rate_matching will also be RATE_MATCH_NONE when using
> >   that interface
> > - if rate matching is used, the PHY is configured to use it for all
> >   media speeds <= phylink_interface_max_speed(link_state.interface)
> > 
> > Those assumptions are not validated very well against the ground truth
> > from the PHY provisioning, so the next step would be for us to see that
> > directly.
> > 
> > Please turn this print from aqr_gen2_read_global_syscfg() into something
> > visible in dmesg, i.e. by replacing phydev_dbg() with phydev_info():
> > 
> > 		phydev_dbg(phydev,
> > 			   "Media speed %d uses host interface %s with %s\n",
> > 			   syscfg->speed, phy_modes(syscfg->interface),
> > 			   syscfg->rate_adapt == AQR_RATE_ADAPT_NONE ? "no rate adaptation" :
> > 			   syscfg->rate_adapt == AQR_RATE_ADAPT_PAUSE ? "rate adaptation through flow control" :
> > 			   syscfg->rate_adapt == AQR_RATE_ADAPT_USX ? "rate adaptation through symbol replication" :
> > 			   "unrecognized rate adaptation type");
> 
> Thanks. Looks like rate adaptation is only provisioned for 10M, which
> matches my observation where phylink passes the exact speeds for
> 100/1000/2500 but 1000 for 10M.

Hmm, I wonder what the PHY is doing for that then. stmmac will be
programmed to read the Cisco SGMII in-band control word, and use
that to determine whether symbol replication for slower speeds is
being used.

If AQR115C is indicating 10M in the in-band control word, but is
actually operating the link at 1G speed, things are not going to
work, and I would say the PHY is broken to be doing that. The point
of the SGMII in-band control word is to tell the MAC about the
required symbol replication on the link for transmitting the slower
data rates over the link.

stmmac unfortunately doesn't give access to the raw Cisco SGMII
in-band control word. However, reading register 0xf8 bits 31:16 for
dwmac4, or register 0xd8 bits 15:0 for dwmac1000 will give this
information. In that bitfield, bits 2:1 give the speed. 2 = 1G,
1 = 100M, 0 = 10M.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

