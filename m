Return-Path: <netdev+bounces-176602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30EDA6B08A
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 23:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0094A3CEA
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 22:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD51E22B8B8;
	Thu, 20 Mar 2025 22:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rcsXQJB2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A9D22B8AF
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 22:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742508701; cv=none; b=Gdrr7ETm3/wySL7LoKThnL8NCweSE/OGEjMCeYBTtJXv2jydKWSFGjgC0lpmLdqD8QEf4Hmkjqg7/JSCJ7gzhuY8jXjR/qJ4TuhBEYe+w+sSvvqgoJBTvp17gk8+Px/VMTXxE5CtOH1GL83wUJN8Sl6Bsg15Dw6WkRkQnQCiejU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742508701; c=relaxed/simple;
	bh=caz49hTngMKS4LxwIO3kJgHYH6He0WetFVwAxL5y45c=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=qAwihXgKTewKYNCWUKAyhsQEleYWoiBMDQCAvC+pRpkSqzcdgXhz9qdihvvic3MKNvKYhviifrxoUF9i7cvxw8Jz+8QOkQKDrT5iFNvUn3ago3J9/eg9EE3h+9UZMCNVqatuKDvjEYr2N6r7p61bgTMnObvCUQpV0y3bCg0bUCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=rcsXQJB2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hcYp9hNRaYo3FHlKzDyc/CZ+B5XrhtdAFoiCibNzyHQ=; b=rcsXQJB2hJJSR1tNFKb+qMkTMH
	lA7xcJQEtbvSZQ6xL+ibPTjFAAkxEVYTkdeq5C1FRmHIG7C2J2aJdsEgUgVm4mqC2sK48oIoGB5JL
	SAbD+Om/vnnDlienlAjJts9zUr3Qc3lWdekxDFAsiVPj9grjunFzNoI6S1XQB8SOFEYAtTEGfAphS
	gIi+MvXRbBngTM1tyI2t/6aAZlSo57lCKmGsQ5G3MPM0K7z+sE/GFDC1SFvzrtQAbq64HE3i6zlDl
	OkdoD7O3CxuzEIyzHdxwk63pRy4npIL5KaR7K2FT0dgz6M/lQgF2K78neCDfWzpTCeY66rKO9GvPp
	r7pGwJTg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:60906 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tvO6v-0008Dq-01;
	Thu, 20 Mar 2025 22:11:33 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tvO6a-008Vjh-FG; Thu, 20 Mar 2025 22:11:12 +0000
In-Reply-To: <Z9ySeo61VYTClIJJ@shell.armlinux.org.uk>
References: <Z9ySeo61VYTClIJJ@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 2/5] net: stmmac: address non-LPI resume failures
 properly
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tvO6a-008Vjh-FG@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 20 Mar 2025 22:11:12 +0000

The Synopsys Designware GMAC core databook requires all clocks to be
active in order to complete software reset, which we perform during
resume.

However, IEEE 802.3 allows a PHY to stop its clocks when placed in
low-power mode, which happens when the system is suspended and WoL
is not enabled.

As an attempt to work around this, commit 36d18b5664ef ("net: stmmac:
start phylink instance before stmmac_hw_setup()") started phylink
early, but this has the side effect that the mac_link_up() method may
be called before or during the initialisation of GMAC hardware.

We also have the socfpga glue driver directly calling phy_resume()
also as an attempt to work around this.

In a previous commit, phylink_prepare_resume() has been introduced
to give MAC drivers a way to ensure that the PHY is resumed prior to
their initialisation of their MAC hardware. This commit adds the call,
and moves the phylink_resume() call back to where it should be before
the aforementioned commit.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a6a533d8a45b..860f800cd014 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7936,12 +7936,12 @@ int stmmac_resume(struct device *dev)
 	}
 
 	rtnl_lock();
-	phylink_resume(priv->phylink);
-	if (device_may_wakeup(priv->device) && !priv->plat->pmt)
-		phylink_speed_up(priv->phylink);
-	rtnl_unlock();
 
-	rtnl_lock();
+	/* Prepare the PHY to resume, ensuring that its clocks which are
+	 * necessary for the MAC DMA reset to complete are running
+	 */
+	phylink_prepare_resume(priv->phylink);
+
 	mutex_lock(&priv->lock);
 
 	stmmac_reset_queues_param(priv);
@@ -7959,6 +7959,15 @@ int stmmac_resume(struct device *dev)
 	stmmac_enable_all_dma_irq(priv);
 
 	mutex_unlock(&priv->lock);
+
+	/* phylink_resume() must be called after the hardware has been
+	 * initialised because it may bring the link up immediately in a
+	 * workqueue thread, which will race with initialisation.
+	 */
+	phylink_resume(priv->phylink);
+	if (device_may_wakeup(priv->device) && !priv->plat->pmt)
+		phylink_speed_up(priv->phylink);
+
 	rtnl_unlock();
 
 	netif_device_attach(ndev);
-- 
2.30.2


