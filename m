Return-Path: <netdev+bounces-217289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62870B383AD
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 15:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 881E31B67BC6
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 13:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1B334DCCA;
	Wed, 27 Aug 2025 13:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="GSh6z4TW"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B533A350835
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 13:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756301282; cv=none; b=clh4QDtpQTAL4vBiWElFLWDOpiYHPpQrA5w+HHRv05XFCQUM3wzaue1L7WUgRK5zi437du1ePwnT2tUZkP2UQ7MtWZShWkroxEB9jXgd82QxSw3HKd9xF8IcqBzxHGMUNOl+RNBLhoxB7SyKWPUHREW3ZxVS+IsdDVfaaHIyLG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756301282; c=relaxed/simple;
	bh=0l9cb71QMXKlOx0TqRGLt1ptRCTlOyuIpRfnKBk1IhQ=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=P0JhJjwhZIo2U3y+aIU4kHUunkpTZ2yrHf/19woiwC4AHdSwi8+JpWMaUT2oBe1zO/vtv4YwFOV4Sp+/qclyTenQjdbJ6Fcf9n42g+r7ZHvpPUCTFYSBSjP1cHNPEnx+RiXXcvYtta/CnAsHJPPXK4kUKcgO4Kpd4NLcuKU4sNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=GSh6z4TW; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bVD8KDKEsQ4zdVl4LrGJ70ulwhHWfhhuvgyYMvpeM10=; b=GSh6z4TW7Nt+CEY/rDh0GgW8B9
	cuauYVIjct/VP6WLiQXy/LQz7rDa1rvTtSPQd3/PRJYMAkajyZtNs7zUGpy4VsWDeHsa1K75pWQ3l
	iPU41l3yVDMqMOMaXduRI8l8g5lha+rttrhGoVfTe+NwmsY0aZzYVFkjcNLpR4saAUQHSlTBvG/Ii
	TlYTIXzwDXLiAdkKi/CXx5D/LApZGu6DXylip/0gaBzJ8or5bItcjnQB6/LrExoQkVEEKGcVxHS1a
	oaN//f3aH1NEGUDCne7iKaXAhrluuznMazMa9c9ZBW0jQZ0ydDmg9HEFfPw+QhselGQTv1EEmzgl6
	DMed0ASA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54398 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1urGBo-000000000UR-2jbe;
	Wed, 27 Aug 2025 14:27:48 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1urGBn-00000000DCH-3swS;
	Wed, 27 Aug 2025 14:27:47 +0100
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
Subject: [PATCH net-next] net: stmmac: mdio: clean up c22/c45 accessor split
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1urGBn-00000000DCH-3swS@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 27 Aug 2025 14:27:47 +0100

The C45 accessors were setting the GR (register number) field twice,
once with the 16-bit register address truncated to five bits, and
then overwritten with the C45 devad. This is harmless since the field
was being cleared prior to being updated with the C45 devad, except
for the extra work.

Remove the redundant code.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Untested, as I don't have my Jetson Xavier NX platform with me (and
probably won't do for a few weeks.)

While this patch has been prepared on top of "net: stmmac: mdio: use
netdev_priv() directly" it shouldn't conflict if that patch is not
applied before this one.

 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index 86021e6b67b2..da4542be756a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -311,12 +311,10 @@ static int stmmac_mdio_read_c45(struct mii_bus *bus, int phyaddr, int devad,
 
 	value |= (phyaddr << priv->hw->mii.addr_shift)
 		& priv->hw->mii.addr_mask;
-	value |= (phyreg << priv->hw->mii.reg_shift) & priv->hw->mii.reg_mask;
 	value |= (priv->clk_csr << priv->hw->mii.clk_csr_shift)
 		& priv->hw->mii.clk_csr_mask;
 	value |= MII_GMAC4_READ;
 	value |= MII_GMAC4_C45E;
-	value &= ~priv->hw->mii.reg_mask;
 	value |= (devad << priv->hw->mii.reg_shift) & priv->hw->mii.reg_mask;
 
 	data |= phyreg << MII_GMAC4_REG_ADDR_SHIFT;
@@ -409,14 +407,12 @@ static int stmmac_mdio_write_c45(struct mii_bus *bus, int phyaddr,
 
 	value |= (phyaddr << priv->hw->mii.addr_shift)
 		& priv->hw->mii.addr_mask;
-	value |= (phyreg << priv->hw->mii.reg_shift) & priv->hw->mii.reg_mask;
 
 	value |= (priv->clk_csr << priv->hw->mii.clk_csr_shift)
 		& priv->hw->mii.clk_csr_mask;
 
 	value |= MII_GMAC4_WRITE;
 	value |= MII_GMAC4_C45E;
-	value &= ~priv->hw->mii.reg_mask;
 	value |= (devad << priv->hw->mii.reg_shift) & priv->hw->mii.reg_mask;
 
 	data |= phyreg << MII_GMAC4_REG_ADDR_SHIFT;
-- 
2.47.2


