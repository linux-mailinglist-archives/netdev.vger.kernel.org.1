Return-Path: <netdev+bounces-110114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B60E92B027
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 08:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D840B20EEE
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 06:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927D51514E2;
	Tue,  9 Jul 2024 06:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lSada+2P"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4981613D63E;
	Tue,  9 Jul 2024 06:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720506659; cv=none; b=MXszwvMpDZjj4tjSNxB4PNbqS8LDKwIoIg1TcFPXEDwzYXANQt+LhXVoHGkVhzGwWsWRz+RAyfaE6gBx9Of8LVxb0WB3u9NkKw/0qI2UpcTqZ1j99/dz2KbJE2Nv0J4F2MjqUM4gG/X6kMYRtAPJ0UcBnjMICIzuhTl10Oi9HCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720506659; c=relaxed/simple;
	bh=CAd5Qlo15/pKBKEu259DqHJMG/vSFX/zyMPS3Uy+hc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pv/FM7pRBtPXENdwXl5DS0D3JHWfp/y5tTrCuRm20b+JqkMApfIAfK6QJDdfk0d4pys3/ELiIrTliAsSehr8ORs5pXIWvhDekPXj4JdE16DtWvvaLlvj/s8R941ilb2Sx3PY0Y5zihf+KaX/JV8CHu5pMo87gCk3cmzJvvAU89Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lSada+2P; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 44B0E1BF209;
	Tue,  9 Jul 2024 06:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720506650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1lMI41lkYPrfVKFeLYdb6NDuhFK+s7QWeP97b3mixAs=;
	b=lSada+2Pzi7r4liA+ETbznwN8uYOgadyVl8tk+HAdsHpHdmBjvS24F8OZRVWHHKnp3o7fk
	Xjj/SXZ9rwmqn3KZ+X10xVxIqIyQ4v239sEt/Skp9pWRAjQJUV+l+OaO74629yu6hdVUxt
	gSEFioEqbP6NUdTcLb7+ksDQkmxDhgD3DsJ+rWXpMxGg9MUPCZUD9R6YHzfI4DTQqbqGv1
	FbNDpa/LnMGbJQ6ME0RdmR+WYpuIRQ+Wad/7rDe0PtUQgY10+LnHSLperdgGUUq5ZLea0u
	NCT2/uwQR0MWb9FOi6m7hn+9ZoJSOZMh/uctNk59PwWXWKb1WP2L3FhtVgMr0w==
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
Subject: [PATCH net-next v17 04/14] net: sfp: Add helper to return the SFP bus name
Date: Tue,  9 Jul 2024 08:30:27 +0200
Message-ID: <20240709063039.2909536-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240709063039.2909536-1-maxime.chevallier@bootlin.com>
References: <20240709063039.2909536-1-maxime.chevallier@bootlin.com>
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


