Return-Path: <netdev+bounces-237587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE16C4D79C
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 12:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BF9C189B253
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 11:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832F736CE0B;
	Tue, 11 Nov 2025 11:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BgU3xOkG"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E4230E0F1
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 11:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861128; cv=none; b=YPFbH2c7bjuXmm6EaUWIhaHI/sxl6mSGz5PR0+dv1sgDTa1xtbFGMV6tOoo1IWicuX24Y15nkCGClYoLpF2iV5RZ9VeGIH6umvqMEgizI9xTqrLmuKcqtKjA/JYvIHOK7kJWAGtm9esXY+a1sJlV5PsGUQ2yeiXnDq1eLaySBc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861128; c=relaxed/simple;
	bh=7ZOk5eKVdxPavx1rotsGzY6wwWWp4mEHs78hP8C0eko=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=GUoKzHFDVeXi0lG680ON7VL+u4dihlnTm2Z7ZZD63+y9Hh2r7XbmwETdHYIXeuzhRrjQLKenNe7Ko63JycHtS8Iqu9p5XqqwK/yCMuoNu+BIaOrCLzVFyOhOZw+i/F8jdq98qBAGR2J0l1NEBmUWNkzM7JugIVnqwHlp+g0nbaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BgU3xOkG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sm+DjG7d9M3bthLo6lghVtQFGOhTZP6bv1JOC1W9zVo=; b=BgU3xOkGFZqF5ooTGh/4ZcASir
	Nfqt5RuHRjmrryepN76YwPkR9kGFvPnlVchNhtkQCY7q0h/F3yhszUxRsjVMeeDuzLQvjy4Wq0+v+
	+HjAcG+Tt3NMGxB9bNiRz9ps1picv/y4xP//RlvP+JnPToefkmFzIoli6Fc6oaVQk968aeK2X837T
	quYqJcteISI1mdK0PiQA51akwUNTksNT2oEVThRvVKFgZTAKt2oqgs6y7WRBU3dxc5svb2ZKD7vHm
	OZvNhFuFaPWx6SXEBPwKx/PeLu7FEI8y/v4JKGRskVXze3ZUuXG6x1FsOlfAORSMc8c70OiZaQmt5
	Hnmag93g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50862 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vImhr-000000002Vk-2is7;
	Tue, 11 Nov 2025 11:38:39 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vImhq-0000000DrQc-3bMW;
	Tue, 11 Nov 2025 11:38:38 +0000
In-Reply-To: <aRMgLmIU1XqLZq4i@shell.armlinux.org.uk>
References: <aRMgLmIU1XqLZq4i@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	netdev@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 1/2] net: phy: allow drivers to disable EEE support
 via .get_features()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vImhq-0000000DrQc-3bMW@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 11 Nov 2025 11:38:38 +0000

Allow PHY drivers to hook the .get_features() method to disable EEE
support. This is useful for TI PHYs, where we have a statement that
none of their gigabit products support EEE, yet at least DP83867
reports EEE capabilties and implements EEE negotiation.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy-core.c   |  2 --
 drivers/net/phy/phy_device.c | 34 ++++++++++++++++++++++++++++++----
 include/linux/phy.h          |  1 +
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 605ca20ae192..43ccbd3a09f8 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -207,8 +207,6 @@ void of_set_phy_eee_broken(struct phy_device *phydev)
 	if (!IS_ENABLED(CONFIG_OF_MDIO) || !node)
 		return;
 
-	linkmode_zero(modes);
-
 	if (of_property_read_bool(node, "eee-broken-100tx"))
 		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, modes);
 	if (of_property_read_bool(node, "eee-broken-1000t"))
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 81984d4ebb7c..437b89a0e944 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3397,6 +3397,34 @@ struct fwnode_handle *fwnode_get_phy_node(const struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL_GPL(fwnode_get_phy_node);
 
+static int phy_get_features(struct phy_device *phydev)
+{
+	int err;
+
+	if (phydev->is_c45)
+		err = genphy_c45_pma_read_abilities(phydev);
+	else
+		err = genphy_read_abilities(phydev);
+
+	return err;
+}
+
+/**
+ * phy_get_Features_no_eee - read the PHY features, disabling all EEE
+ * @phydev: phy_device structure to be added to the MDIO bus
+ *
+ * Read the PHY features, and fill the @phydev->eee_disabled_modes to
+ * prevent EEE being used. This is intended to be used for PHY .get_feature
+ * methods where a PHY reports incorrect capabilities.
+ */
+int phy_get_features_no_eee(struct phy_device *phydev)
+{
+	linkmode_fill(phydev->eee_disabled_modes);
+
+	return phy_get_features(phydev);
+}
+EXPORT_SYMBOL_GPL(phy_get_features_no_eee);
+
 /**
  * phy_probe - probe and init a PHY device
  * @dev: device to probe and init
@@ -3442,10 +3470,8 @@ static int phy_probe(struct device *dev)
 	}
 	else if (phydrv->get_features)
 		err = phydrv->get_features(phydev);
-	else if (phydev->is_c45)
-		err = genphy_c45_pma_read_abilities(phydev);
-	else
-		err = genphy_read_abilities(phydev);
+	else 
+		err = phy_get_features(phydev);
 
 	if (err)
 		goto out;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index bf5457341ca8..2655c0ae6488 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2299,6 +2299,7 @@ void phy_support_sym_pause(struct phy_device *phydev);
 void phy_support_asym_pause(struct phy_device *phydev);
 void phy_support_eee(struct phy_device *phydev);
 void phy_disable_eee(struct phy_device *phydev);
+int phy_get_features_no_eee(struct phy_device *phydev);
 void phy_set_sym_pause(struct phy_device *phydev, bool rx, bool tx,
 		       bool autoneg);
 void phy_set_asym_pause(struct phy_device *phydev, bool rx, bool tx);
-- 
2.47.3


