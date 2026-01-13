Return-Path: <netdev+bounces-249576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E04D1B221
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 21:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20F59301FFBD
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 20:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6774E318BAE;
	Tue, 13 Jan 2026 20:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vaXTZFop"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDA11A5B84;
	Tue, 13 Jan 2026 20:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768334610; cv=none; b=fw9SyLYE1Mr6ViJxBAAZrMCX1etKrQjcTybvrsu7B7s4JdMPfVtLSgqkTF/yCac9Jr3hk7VCOdzR56Z72SZKHLRsyttXtbnXNOchkG3b6xNTxvtdlzSjI6wZqLWN+TznWGtcRXOFOmWLcqAB0Vo0i2EqqqPS9MEe24uDKhECWfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768334610; c=relaxed/simple;
	bh=xLC39Qjr6cigv4A14inCUgMMPso9QTfTtOhZjTdsxlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMvTASed5YkoWZ1ypTho6A9CAXwk5Z2j6v9Uxl3VjFsl0UfM+vMqq2j0AJ0YIY2J5vVt5ZtUWFbXs5Rlh4anDCk0btlctQoAv8ij8HZB5Ol/4tQK1DzmYVoFa78LjsjMoL6fCbUHlXfe2FJ5sZQbdRwNsC6fB87QOhK4N3QFeZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vaXTZFop; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=R4xqXbi0Q6/KYvVejxl+JdEUTYv8X6JqtJIUMrlC0/k=; b=vaXTZFopVYFJ+1D12g7VeYnimX
	j2qvYhj1URhpdStAcJsG1wgRMWXqo5YWlcH1/1AdiZbJW1VVriiayZ813j1Uu0nEVHxm8X2f1Gws8
	f8Gf0Wjih1q6PpZ52poe6txIDIcMjI7F7gPx8rhptWQJnQHAuhFZoC8spSb/Yf6jeQcJHQBadGBbf
	XItxE1KBBgPM75frlDd8yk/HWi5CVtW9RO6ZT8xesIHgquzWo58y5XUAfcD3c7gygm+WP/mYbEAkh
	E7EWr0QA4ZnYNMW7zdyAPVvuzz2zM7oTcU+qmqWpFePAdC72RhKLUGRx6Fw/o1PIfH7nl9qIzm9QO
	0BhT84fQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39018)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vfkbm-000000007nt-0s0Q;
	Tue, 13 Jan 2026 20:03:18 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vfkbg-000000000wo-1dCM;
	Tue, 13 Jan 2026 20:03:12 +0000
Date: Tue, 13 Jan 2026 20:03:12 +0000
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
Message-ID: <aWalAMC2FWKlXK0E@shell.armlinux.org.uk>
References: <20260113074316.145077-1-maxime.chevallier@bootlin.com>
 <d89cb3a7-3a55-4bdf-805a-b3386572b220@bootlin.com>
 <aWaSnRbINHoAerGo@shell.armlinux.org.uk>
 <6b8aebe7-495e-40e5-a99d-57f8f7b2e683@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b8aebe7-495e-40e5-a99d-57f8f7b2e683@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 13, 2026 at 08:24:49PM +0100, Maxime Chevallier wrote:
> Hi Russell,
> > Traditionally, we've represented the SerDes using drivers/phy rather
> > than the drivers/net/phy infrastructure, mainly because implementations
> > hvaen't provided anything like an 802.3 PHY register set, but moreover
> > because the SerDes tends to be generic across ethernet, PCIe, USB, SATA
> > etc (basically, anything that is a high speed balanced pair serial
> > communication) and thus the "struct phy" from drivers/phy can be used
> > by any of these subsystems.
> > 
> 
> True, and I completely agree with that. The reason I didn't touch that
> when porting to phylink is that the device I'm using, that has a
> Motorola/Freescale/NXP MPC832x, doesn't have that TBI/RTBI block, so I
> can't test that at all should we move to a more modern SerDes driver
> (modern w.r.t when this driver was written) :(

Over the last few days, I've been adding "generic" stmmac SerDes
support (which basically means not in the platform glue) to replace
the qcom-ethqos stuff, and while doing so, the thought did cross my
mind whether I should be adding that to phylink rather than stmmac.

stmmac's "I can't reset without all the clocks running" makes it
rather special though, but we already have phylink_rx_clk_stop_block()
to guarantee that the PHY itself won't stop its receive clock when
entering LPI, so phylink already knows when the clock is required
(although with a slight abuse of the names of these functions.)

Given that the two qcom-ethqos patches I sent last night failed to
build (oops) I may change the patch order... it does need the stmmac
PCS work to be merged first though.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

