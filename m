Return-Path: <netdev+bounces-182876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EE0A8A423
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 18:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6715189BD33
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 16:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6333233703;
	Tue, 15 Apr 2025 16:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tCSG7ijL"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D61419F11F
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744734590; cv=none; b=ogW+537iO34qoZsgYfXAL2ZKKdmoEoO0DnE6H6PUpe5dod59r3UmJi+fhEJ87Mj73ey5Z098hYwwlylCgQi4jt02Trz39QOuKQkZI0tTq5hvr9yT6hiz4DT+upNOUaH/gfa6o5ZiifUGn0h312NZPwcuVGM/+ZaL8fr9Zmq0xRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744734590; c=relaxed/simple;
	bh=T1cXug0hwb51OEhqHZhNvRY4BkK5sQEu2pDV/UedYT4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Tqkwtab6jLQNM3IFeUXyEYT2LrBEp6x4Jr3bnmzY+cgG5UlXISuEG9WOFqgOpUpCZpwqmau4/4ox7l4+4Tbu6A0AZvKmzbJfamZPh6QFc/9csTLFdqXBQbpq3oVafb1jSf9Kht0dQJWUCx63UJFDJO4OZkAaNBexB2xs5EjD17Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=tCSG7ijL; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dN5nYyiU35H99VU7lHwdDyUBPUQ+9txXBMSlQXrMmdM=; b=tCSG7ijLCLZYTgm+x8yJfhVWNb
	j77xBlbDb8pWvFuI2hysvtt0TlXtumAMr2ujSjel9si064CRoAIYdeQkONNCnFnCnM6lZOHz4uHmd
	X0Pb3ZR8VBnv1ChNx8e5faJHZ6NxCcscq2OevudnD7kXgoXqzNy4SEvLD84TCeOOQPsmx+/+JEzKN
	a1reWh8eAecpU6u04O2S2FHRM7rK+x1lSXuitaUKUt5WM9f0g99uNbG1kztF200CSFjKBL/nvZCXS
	XkYr1749Mnal/2wYTqA5GcvQm9j10haHGEAOmzFgVDE6czJr4FYasyFKpwikEJVtrOAKCDHQI0FdM
	iiMk/kwA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33638)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u4jAC-0008T0-0g;
	Tue, 15 Apr 2025 17:29:32 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u4jA8-0000Vx-14;
	Tue, 15 Apr 2025 17:29:28 +0100
Date: Tue, 15 Apr 2025 17:29:28 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/5] net: stmmac: socfpga: fix init ordering and
 cleanups
Message-ID: <Z_6JaPBiGu_RB4xN@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

This series fixes the init ordering of the socfpga probe function.
The standard rule is to do all setup before publishing any device,
and socfpga violates that. I can see no reason for this, but these
patches have not been tested on hardware.

Address this by moving the initialisation of dwmac->stmmac_rst
along with all the other dwmac initialisers - there's no reason
for this to be late as plat_dat->stmmac_rst has already been
populated.

Next, replace the call to ops->set_phy_mode() with an init function
socfpga_dwmac_init() which will then be linked in to plat_dat->init.

Then, add this to plat_dat->init, and switch to stmmac_pltfr_pm_ops
from the private ops. The runtime suspend/resume socfpga implementations
are identical to the platform ones, but misses the noirq versions
which this will add.

Next, swap the order of socfpga_dwmac_init() and stmmac_dvr_probe().

Finally, convert to devm_stmmac_pltfr_probe() by moving the call
to ops->set_phy_mode() into an init function appropriately populating
plat_dat->init.

 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    | 79 +++++-----------------
 1 file changed, 16 insertions(+), 63 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

