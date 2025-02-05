Return-Path: <netdev+bounces-163000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52110A28BA3
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 14:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 448CD1886929
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 13:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02C278F34;
	Wed,  5 Feb 2025 13:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OAKL1WkI"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFE639FD9
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762085; cv=none; b=NExqKNyIwaTU6TSDDtjd5kbjN/bU4papI9VysKatqMvDhdb+CIFiRxeSL7frXSqx+MLI3j70+M589ta7rFdfqto+VmbMgPXk8ZsE3+VIzFfYtOtMxpmVazA+WN4wRYiHUT7Lt3e1BDeNHNQ5wrmskiulk30+fyvN4wILhM3Cps4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762085; c=relaxed/simple;
	bh=62wlnDFBjnc2bVP9P/MOaA+QrnXdZ/GQKyB9h/4WPOc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Z5pEcqOja8rDXZDWpVt/rffXUBIkzSMWa7nggmqe02I4oVHBL9HL3YOO9/rIPJePNhFAGvpoP6hci1gY+iex9U9o+gvLC6R2MP2oMeeHQMBb9VUaQEGCOqva6kX0KUbTzhjT2WN5xus7wMLt1YNVoj0c/iph1HCfkTlI0PGSRX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=OAKL1WkI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9Q0u7PbVqqNVpYMQo9D5lw+iICm4jS6ncuFwIRkvpQE=; b=OAKL1WkIh/lLHxgEehKzz+ww5C
	zW2mlpAHfP4s/jzUq3/xEtnoV1KEWuNppv/9B01RTSrCLJLxMRFv9l6hRZeQwPEdSiMtb8/ZOBKgO
	lF1m3xeTahTSWeitG91/lKWnTYIkrmKqjVQ00eGXZlWfwmjO68CMQqJe+sMGocY2VuADUCXsfE3Md
	rQa8VIpSkdX22ZSRfvmkCWzCr8Xkb4GzNDz8VSzotd/6bxRmlWlOmTehqdnxgoCRyfjmDndtNsyBN
	dk70xhOu4oGomj0aY3RhrU/Q6Hms832yXu0eRwkwvjJxCox608m7LIi0DMJQUx/cSvQwOrtJl1JG6
	T94jRrCA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50330 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tffRc-00076t-25;
	Wed, 05 Feb 2025 13:27:56 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tffRJ-003Z5i-4s; Wed, 05 Feb 2025 13:27:37 +0000
In-Reply-To: <Z6NnPm13D1n5-Qlw@shell.armlinux.org.uk>
References: <Z6NnPm13D1n5-Qlw@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Tristram.Ha@microchip.com
Cc: Vladimir Oltean <olteanv@gmail.com>,
	 UNGLinuxDriver@microchip.com,
	 Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH RFC net-next 2/4] net: xpcs: add SGMII mode setting
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tffRJ-003Z5i-4s@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 05 Feb 2025 13:27:37 +0000

Add SGMII mode setting which configures whether XPCS immitates the MAC
end of the link or the PHY end, and in the latter case, where the data
for generating the link's configuration word comes from. This ties up
all the register bits necessary to configure this mode into one
control.

Set this to PHY_HW mode for TXGBE.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.c | 19 +++++++++++--------
 drivers/net/pcs/pcs-xpcs.h | 14 ++++++++++++++
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 12a3d5a80b45..9d54c04ef6ee 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -706,12 +706,10 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
 		break;
 	}
 
-	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
-		/* Hardware requires it to be PHY side SGMII */
-		tx_conf = DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII;
-	} else {
+	if (xpcs->sgmii_mode == DW_XPCS_SGMII_MODE_MAC)
 		tx_conf = DW_VR_MII_TX_CONFIG_MAC_SIDE_SGMII;
-	}
+	else
+		tx_conf = DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII;
 
 	val |= FIELD_PREP(DW_VR_MII_TX_CONFIG_MASK, tx_conf);
 
@@ -722,12 +720,16 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
 	val = 0;
 	mask = DW_VR_MII_DIG_CTRL1_2G5_EN | DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW;
 
-	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
-		val = DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW;
+	switch (xpcs->sgmii_mode) {
+	case DW_XPCS_SGMII_MODE_MAC:
+		if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
+			val = DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW;
+		break;
 
-	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
+	case DW_XPCS_SGMII_MODE_PHY_HW:
 		mask |= DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL;
 		val |= DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL;
+		break;
 	}
 
 	ret = xpcs_modify(xpcs, MDIO_MMD_VEND2, DW_VR_MII_DIG_CTRL1, mask, val);
@@ -1462,6 +1464,7 @@ static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev)
 	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
 		xpcs->pcs.poll = false;
 		xpcs->sgmii_10_100_8bit = DW_XPCS_SGMII_10_100_8BIT;
+		xpcs->sgmii_mode = DW_XPCS_SGMII_MODE_PHY_HW;
 	} else {
 		xpcs->need_reset = true;
 	}
diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index 4d53ccf917f3..892b85425787 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -120,6 +120,19 @@ enum dw_xpcs_sgmii_10_100 {
 	DW_XPCS_SGMII_10_100_8BIT
 };
 
+/* The SGMII mode:
+ * DW_XPCS_SGMII_MODE_MAC: the XPCS acts as a MAC, reading and acknowledging
+ * the config word.
+ *
+ * DW_XPCS_SGMII_MODE_PHY_HW: the XPCS acts as a PHY, deriving the tx_config
+ * bits 15 (link), 12 (duplex) and 11:10 (speed) from hardware inputs to the
+ * XPCS.
+ */
+enum dw_xpcs_sgmii_mode {
+	DW_XPCS_SGMII_MODE_MAC,		/* XPCS is MAC on SGMII */
+	DW_XPCS_SGMII_MODE_PHY_HW,	/* XPCS is PHY, tx_config from hw */
+};
+
 struct dw_xpcs {
 	struct dw_xpcs_info info;
 	const struct dw_xpcs_desc *desc;
@@ -130,6 +143,7 @@ struct dw_xpcs {
 	bool need_reset;
 	/* Width of the MII MAC/XPCS interface in 100M and 10M modes */
 	enum dw_xpcs_sgmii_10_100 sgmii_10_100_8bit;
+	enum dw_xpcs_sgmii_mode sgmii_mode;
 };
 
 int xpcs_read(struct dw_xpcs *xpcs, int dev, u32 reg);
-- 
2.30.2


