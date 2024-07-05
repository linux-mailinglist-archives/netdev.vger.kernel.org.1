Return-Path: <netdev+bounces-109478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FABC928990
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 15:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3397FB2578F
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19177156238;
	Fri,  5 Jul 2024 13:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bPYtqH4L"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31BC1527B8;
	Fri,  5 Jul 2024 13:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720186039; cv=none; b=FEuFOKTTovVWU6PM1dR+LfHXK0UxcicBaxRlIDD4ltoLknWBB5ht3QU9HuaJGeKnUzKAtkXAaeTo9VqJBgDczTqCDgLYAth/vWu4R+mL95HRb/OiUvqVd0F8XUDDmRt155iIA6EEV3G+oZk2r2E3jWr5VM29iHdM4hXn9KIZEMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720186039; c=relaxed/simple;
	bh=CAd5Qlo15/pKBKEu259DqHJMG/vSFX/zyMPS3Uy+hc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XVW1mxiSKKxZJVA/FZXowe+TZz4NMtmBP4DUEu1o4BLKL8dRWIbtI1+3k1Nb9qkLaSwmz8ZMrRM4raTxTkcviUlmaC4hrwS0RtSqRVN09zlqk7vaSRjsG/lxk9chz3LZRHgkV8ZyUJy7NobpM7QftjUwJB9vhEIdARoGF3mKI2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bPYtqH4L; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 17F641C000B;
	Fri,  5 Jul 2024 13:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720186035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1lMI41lkYPrfVKFeLYdb6NDuhFK+s7QWeP97b3mixAs=;
	b=bPYtqH4LVjyrKfxDBc/OdF4uCndxoPW8CqPekzMMNfCozTZkQh3OSfWGUBZ5iX2nnVSPtR
	NymxSMdz31MgWLoF/CfHaMNPRRZe+TMZNnvi1YsPiHhyHwxoPUpIGSXpgfblmV2FpCbFWB
	xJN+ku1TkPO3XzgAWP19Re8QEIP7VawkNTE7TWzrEQkBGyC6++Sd0EABmFV0aLtjpJQ6cB
	4/kx/GAIVTTELQlK0/HSGS6uM4iQYv37lwrCutRxO6wBOS4SyXiWAkrYb0ubn7gkjFvOT+
	ytlQhnQwHkx+rKfC6Wxfbg5u4mAixFsYjxNdBlSPTmcMZGTBicYxDZjG09WQEg==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Nathan Chancellor <nathan@kernel.org>,
	Antoine Tenart <atenart@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH net-next v16 04/14] net: sfp: Add helper to return the SFP bus name
Date: Fri,  5 Jul 2024 15:26:55 +0200
Message-ID: <20240705132706.13588-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240705132706.13588-1-maxime.chevallier@bootlin.com>
References: <20240705132706.13588-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Knowing the bus name is helpful when we want to expose the link topology
to userspace, add a helper to return the SFP bus name.

This call will always be made while holding the RTNL which ensures
that the SFP driver won't unbind from the device. The returned pointer
to the bus name will only be used while RTNL is held.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Suggested-by: "Russell King (Oracle)" <linux@armlinux.org.uk>
---
 drivers/net/phy/sfp-bus.c | 22 ++++++++++++++++++++++
 include/linux/sfp.h       |  6 ++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
index 56953e66bb7b..f13c00b5b449 100644
--- a/drivers/net/phy/sfp-bus.c
+++ b/drivers/net/phy/sfp-bus.c
@@ -722,6 +722,28 @@ void sfp_bus_del_upstream(struct sfp_bus *bus)
 }
 EXPORT_SYMBOL_GPL(sfp_bus_del_upstream);
 
+/**
+ * sfp_get_name() - Get the SFP device name
+ * @bus: a pointer to the &struct sfp_bus structure for the sfp module
+ *
+ * Gets the SFP device's name, if @bus has a registered socket. Callers must
+ * hold RTNL, and the returned name is only valid until RTNL is released.
+ *
+ * Returns:
+ *	- The name of the SFP device registered with sfp_register_socket()
+ *	- %NULL if no device was registered on @bus
+ */
+const char *sfp_get_name(struct sfp_bus *bus)
+{
+	ASSERT_RTNL();
+
+	if (bus->sfp_dev)
+		return dev_name(bus->sfp_dev);
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(sfp_get_name);
+
 /* Socket driver entry points */
 int sfp_add_phy(struct sfp_bus *bus, struct phy_device *phydev)
 {
diff --git a/include/linux/sfp.h b/include/linux/sfp.h
index 54abb4d22b2e..60c65cea74f6 100644
--- a/include/linux/sfp.h
+++ b/include/linux/sfp.h
@@ -576,6 +576,7 @@ struct sfp_bus *sfp_bus_find_fwnode(const struct fwnode_handle *fwnode);
 int sfp_bus_add_upstream(struct sfp_bus *bus, void *upstream,
 			 const struct sfp_upstream_ops *ops);
 void sfp_bus_del_upstream(struct sfp_bus *bus);
+const char *sfp_get_name(struct sfp_bus *bus);
 #else
 static inline int sfp_parse_port(struct sfp_bus *bus,
 				 const struct sfp_eeprom_id *id,
@@ -654,6 +655,11 @@ static inline int sfp_bus_add_upstream(struct sfp_bus *bus, void *upstream,
 static inline void sfp_bus_del_upstream(struct sfp_bus *bus)
 {
 }
+
+static inline const char *sfp_get_name(struct sfp_bus *bus)
+{
+	return NULL;
+}
 #endif
 
 #endif
-- 
2.45.1


