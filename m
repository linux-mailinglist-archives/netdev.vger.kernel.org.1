Return-Path: <netdev+bounces-168197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 882FAA3E04F
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 17:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 504DF16ED9F
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 16:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5681DFDA5;
	Thu, 20 Feb 2025 16:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="oPBtLeiC"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF9E1FCFF0
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068288; cv=none; b=jTIdRQ7xiyM7oZOD/WviEzY/iUpnugEWlXyRnogX3Or9nBrqoDz/vPLXVS//P84zyybEsj4cx8pOmbZsEVvlPokuRqqGg1R6tgtyxQFpn98j3THxy+QgRJl2BlRCf5tMECv0SNVveCBxhpU/HB3+mRieu8V9rk4RX+ULifntmpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068288; c=relaxed/simple;
	bh=1lNfht+L4bkIUNSrksN/fnUjXkfLfHREPUBgrBzOBjo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YSqNJ4MPZS+caysz2Z6n//R3Q+7q9qn19C4B7MpbX4bC8WZoexdBn8IJurY2VKg48CgUA6FBNIqkk/0PJ5p1OQCVVbkpr8EGR6Dk7PgylQPukvE6p6fK7zq2YcBsM2CY0O1jJyz54/fWPUlh6C4731bEpr54kOqlf2yChlOu0VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=oPBtLeiC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gTLXFDLqNr8w0l4M+kAbKMCxfWgBwXHT6fzNY44FTHo=; b=oPBtLeiCZioel5S0vze3Dv/djL
	x4WqxS8113VtwsR9GSWnsPmv6YdnkSU6me66Q9PM2T5uo1dA94EBEgWd/4BzdnyyqyxCWumwZQRuQ
	AlccaHqivk3iS+0eMeuUQriPK3E+5DGUkSr2mW+X9bQabGi9B+dRZJfOzbIP0rY+G1OIeAmoAnG2e
	w7Gugev8ml4SScaB56TI0/lGLWVsVOX5Uo1j3ktrUIrUfdJuICjUQ9AmONZ6VX0RocHYDyDDZU9wv
	YJ5VS1+LXqcljGvRA7uvyyLomPSaOdWvUF04r07/Z4iDNBmKUMt2OvF7KrhvUNxJI76kMqLGoKPNQ
	veUrkKjw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44456)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tl9FG-0001b0-0t;
	Thu, 20 Feb 2025 16:17:50 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tl9F9-00017G-1J;
	Thu, 20 Feb 2025 16:17:43 +0000
Date: Thu, 20 Feb 2025 16:17:43 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
	Inochi Amaoto <inochiama@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Minda Chen <minda.chen@starfivetech.com>, netdev@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Thierry Reding <treding@nvidia.com>
Subject: net: stmmac: weirdness in stmmac_hw_setup()
Message-ID: <Z7dVp7_InAHe0q_y@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

While looking through the stmmac driver, I've come across some
weirdness in stmmac_hw_setup() which looks completely barmy to me.

It seems that it follows the initialisation suggested by Synopsys
(as best I can determine from the iMX8MP documentation), even going
as far as to *enable* transmit and receive *before* the network
device has been administratively brought up. stmmac_hw_setup() does
this:

        /* Enable the MAC Rx/Tx */
        stmmac_mac_set(priv, priv->ioaddr, true);

which sets the TE and RE bits in the MAC configuration register.

This means that if the network link is active, packets will start
to be received and will be placed into the receive descriptors.

We won't transmit anything because we won't be placing packets in
the transmit descriptors to be transmitted.

However, this in stmmac_hw_setup() is just wrong. Can it be deleted
as per the below?

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index c2913f003fe6..d6e492f523f5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3493,9 +3493,6 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
 		priv->hw->rx_csum = 0;
 	}
 
-	/* Enable the MAC Rx/Tx */
-	stmmac_mac_set(priv, priv->ioaddr, true);
-
 	/* Set the HW DMA mode and the COE */
 	stmmac_dma_operation_mode(priv);
 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

