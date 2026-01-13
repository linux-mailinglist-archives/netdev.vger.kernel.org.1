Return-Path: <netdev+bounces-249549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D807AD1AE1A
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 19:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3FE1305B591
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 18:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B5D350288;
	Tue, 13 Jan 2026 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="x5L4mwpy"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79536196C7C;
	Tue, 13 Jan 2026 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768329910; cv=none; b=lArKPSRpywAFmCBTiQV2+ZZK4qTu7jxJMldk4xQndN0dawtfOgDpkwCXRIQ4uuzVtp5vEM6aM1191v3Ry960keZNkfEIvoIyl2padqizE5RcF+NjiBMC1+6BOyq6NTLCT6b2FRnxxjnifAELfjpweMnIFlKUtgp+sxj6lGlmfk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768329910; c=relaxed/simple;
	bh=dnQ/G+I4tRhS20kh89+6F8e7BWwbcVN5W6/MKzUdxoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nj/6kQG/tP62gwLehw8eQzDoXli6cmjWH7nWu9DwBtyQD0xw0dfwBVK/P3jArh4NyB0Qn9FPws6CmLYy9DDAVLaMq1WJzsN2WFIf/BgGPt/jPV4TZ4NKZew1BlBgj60WCSW+I6ueAMoqa497kQF43Fc2/mHgK9yeXlBqiaCXFZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=x5L4mwpy; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jKtoDk43UnDtrx3CwO7HNH0Si8rMrFbLT6eAxKpAHcA=; b=x5L4mwpyvVpXTleXSTA4E7TB3x
	PqA0EFm3g+ADDRa9RRrchtOtp6ieun8dXwnrsSCngYksIOzLTsbduJGHO93EJ5sOmTiopDikrI2W1
	Q8ax2P98YDpsczL0Zc0iK7HY9RCHuKVTZVtqdNu73ghhxJVok54d0lPGUxUjqkfTn1U6uJVhV0fZz
	m+jTOB9IGzXsFfAtxqO7S7Y9km8DXM5EvpxKlPFYsnxmZdRCk91uYE3SLfMJZDZHjfWS2hwp2QEX9
	NihTgk+QmcNcL9S75eoUCpaLW0+DpTXskcwjiqgJh+s8Bnb6Kvtoc9KXPZiORwxY6qyROiEx6dYal
	5yterFBA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50244)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vfjNs-000000007ks-3HYJ;
	Tue, 13 Jan 2026 18:44:53 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vfjNl-000000000u1-2HNB;
	Tue, 13 Jan 2026 18:44:45 +0000
Date: Tue, 13 Jan 2026 18:44:45 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Pei Xiao <xiaopei01@kylinos.cn>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Dan Carpenter <dan.carpenter@linaro.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net] net: freescale: ucc_geth: Return early when TBI
 found can't be found
Message-ID: <aWaSnRbINHoAerGo@shell.armlinux.org.uk>
References: <20260113074316.145077-1-maxime.chevallier@bootlin.com>
 <d89cb3a7-3a55-4bdf-805a-b3386572b220@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d89cb3a7-3a55-4bdf-805a-b3386572b220@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 13, 2026 at 09:16:29AM +0100, Maxime Chevallier wrote:
> Hi,
> 
> On 13/01/2026 08:43, Maxime Chevallier wrote:
> > In ucc_geth's .mac_config(), we configure the TBI block represented by a
> > struct phy_device that we get from firmware.
> > 
> > While porting to phylink, a check was missed to make sure we don't try
> > to access the TBI PHY if we can't get it. Let's add it and return early
> > in case of error
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/r/202601130843.rFGNXA5a-lkp@intel.com/
> > Fixes: 53036aa8d031 ("net: freescale: ucc_geth: phylink conversion")
> > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> 
> Heh that's what I get from sending patches while having mild fever, the
> patch title is all wrong and should be :
> 
> net: freescale: ucc_geth: Return early when TBI PHY can't be found
> 
> I'll wait for the 24h cooldown, grab some honey + milk and resend after :)

A question - based on dwmac:

When implementing dwmac to support 1000base-X, the dwmac doesn't
implement the _full_ 1000base-X, but only up to the PCS. The PCS
provides a TBI interface to the SerDes PHY provided by the SoC
designer which acts as the PMA layer.

The talk here of TBI makes me wonder whether the same thing is going
on with ucc_geth. Is the "TBI PHY" in fact the SerDes ?

Traditionally, we've represented the SerDes using drivers/phy rather
than the drivers/net/phy infrastructure, mainly because implementations
hvaen't provided anything like an 802.3 PHY register set, but moreover
because the SerDes tends to be generic across ethernet, PCIe, USB, SATA
etc (basically, anything that is a high speed balanced pair serial
communication) and thus the "struct phy" from drivers/phy can be used
by any of these subsystems.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

