Return-Path: <netdev+bounces-292077-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJ7UCPJbFmpTlwcAu9opvQ
	(envelope-from <netdev+bounces-292077-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 04:50:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6C75DEB7F
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 04:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24E2F300F5F8
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D742D63E5;
	Wed, 27 May 2026 02:48:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09C62D6E64;
	Wed, 27 May 2026 02:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779850099; cv=none; b=J5UsBDULi4yuRgJ7oBF9Bh2S4hiOOrLp0SefebCbPX06PxGt/cp4tLFX3H0lEIl0W9YHui4+PpY/Z/zJishA1CLIuMWsLiBXP6r7DGyUht4avHzI91qMhy1gCnlscl0xwIC/8/fMy3PjTOeraCI/HEXKnfVz6pQR1JlYuaST72U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779850099; c=relaxed/simple;
	bh=wLeW9FnnQvyy/gxSnYr0f88az2252wM89IuvOK/QWl0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fREYHSgNcU0++yJWbNLNBpKD0FtIu0XLEKorQzM+0R0VLmAc28xE7glQTAdv7pedwyYouiLeX6e+JMyrCnHYvjHxBY5HN3vi0S+VwYGCZtu8rOoYDux6zJS3VXUpNIeoBvnhjOci6YeffHoz7R8GTnYljA7cNTObww7NEuHkSRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wS4Ja-000000006yd-3hMi;
	Wed, 27 May 2026 02:48:14 +0000
Date: Wed, 27 May 2026 03:48:12 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: John Crispin <john@phrozen.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 2/4] net: dsa: mxl862xx: move phylink stubs to
 mxl862xx-phylink.c
Message-ID: <826dfb92350e4ac48e1ac89c9dea4e04a4c491bc.1779849840.git.daniel@makrotopia.org>
References: <cover.1779849840.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1779849840.git.daniel@makrotopia.org>
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292077-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[phrozen.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.967];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,phrozen.org:email,makrotopia.org:mid,makrotopia.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6F6C75DEB7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move the phylink MAC operations and get_caps callback from mxl862xx.c
into a dedicated mxl862xx-phylink.c file. This prepares for the SerDes
PCS implementation which adds substantial phylink/PCS code -- keeping
it in a separate file avoids function-position churn in the main
driver file.

No functional change.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
v3: no changes
v2: no changes

 drivers/net/dsa/mxl862xx/Makefile           |  2 +-
 drivers/net/dsa/mxl862xx/mxl862xx-phylink.c | 51 +++++++++++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx-phylink.h | 14 ++++++
 drivers/net/dsa/mxl862xx/mxl862xx.c         | 38 +--------------
 4 files changed, 67 insertions(+), 38 deletions(-)
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-phylink.c
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-phylink.h

diff --git a/drivers/net/dsa/mxl862xx/Makefile b/drivers/net/dsa/mxl862xx/Makefile
index d23dd3cd511d..a7be0e6669df 100644
--- a/drivers/net/dsa/mxl862xx/Makefile
+++ b/drivers/net/dsa/mxl862xx/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_NET_DSA_MXL862) += mxl862xx_dsa.o
-mxl862xx_dsa-y := mxl862xx.o mxl862xx-host.o
+mxl862xx_dsa-y := mxl862xx.o mxl862xx-host.o mxl862xx-phylink.o
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-phylink.c b/drivers/net/dsa/mxl862xx/mxl862xx-phylink.c
new file mode 100644
index 000000000000..f17c429d1f1d
--- /dev/null
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-phylink.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Phylink and PCS support for MaxLinear MxL862xx switch family
+ *
+ * Copyright (C) 2024 MaxLinear Inc.
+ * Copyright (C) 2025 John Crispin <john@phrozen.org>
+ * Copyright (C) 2025 Daniel Golle <daniel@makrotopia.org>
+ */
+
+#include <linux/phylink.h>
+#include <net/dsa.h>
+
+#include "mxl862xx.h"
+#include "mxl862xx-phylink.h"
+
+void mxl862xx_phylink_get_caps(struct dsa_switch *ds, int port,
+			       struct phylink_config *config)
+{
+	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE | MAC_10 |
+				   MAC_100 | MAC_1000 | MAC_2500FD;
+
+	__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+		  config->supported_interfaces);
+}
+
+static void mxl862xx_phylink_mac_config(struct phylink_config *config,
+					unsigned int mode,
+					const struct phylink_link_state *state)
+{
+}
+
+static void mxl862xx_phylink_mac_link_down(struct phylink_config *config,
+					   unsigned int mode,
+					   phy_interface_t interface)
+{
+}
+
+static void mxl862xx_phylink_mac_link_up(struct phylink_config *config,
+					 struct phy_device *phydev,
+					 unsigned int mode,
+					 phy_interface_t interface,
+					 int speed, int duplex,
+					 bool tx_pause, bool rx_pause)
+{
+}
+
+const struct phylink_mac_ops mxl862xx_phylink_mac_ops = {
+	.mac_config = mxl862xx_phylink_mac_config,
+	.mac_link_down = mxl862xx_phylink_mac_link_down,
+	.mac_link_up = mxl862xx_phylink_mac_link_up,
+};
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-phylink.h b/drivers/net/dsa/mxl862xx/mxl862xx-phylink.h
new file mode 100644
index 000000000000..c3d5215bdf60
--- /dev/null
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-phylink.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef __MXL862XX_PHYLINK_H
+#define __MXL862XX_PHYLINK_H
+
+#include <linux/phylink.h>
+
+#include "mxl862xx.h"
+
+extern const struct phylink_mac_ops mxl862xx_phylink_mac_ops;
+void mxl862xx_phylink_get_caps(struct dsa_switch *ds, int port,
+			       struct phylink_config *config);
+
+#endif /* __MXL862XX_PHYLINK_H */
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
index 2f22adedfbf6..a193f3c07d35 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
@@ -22,6 +22,7 @@
 #include "mxl862xx-api.h"
 #include "mxl862xx-cmd.h"
 #include "mxl862xx-host.h"
+#include "mxl862xx-phylink.h"
 
 #define MXL862XX_API_WRITE(dev, cmd, data) \
 	mxl862xx_api_wrap(dev, cmd, &(data), sizeof((data)), false, false)
@@ -1424,16 +1425,6 @@ static void mxl862xx_port_teardown(struct dsa_switch *ds, int port)
 	priv->ports[port].setup_done = false;
 }
 
-static void mxl862xx_phylink_get_caps(struct dsa_switch *ds, int port,
-				      struct phylink_config *config)
-{
-	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE | MAC_10 |
-				   MAC_100 | MAC_1000 | MAC_2500FD;
-
-	__set_bit(PHY_INTERFACE_MODE_INTERNAL,
-		  config->supported_interfaces);
-}
-
 static int mxl862xx_get_fid(struct dsa_switch *ds, struct dsa_db db)
 {
 	struct mxl862xx_priv *priv = ds->priv;
@@ -2099,33 +2090,6 @@ static const struct dsa_switch_ops mxl862xx_switch_ops = {
 	.get_stats64 = mxl862xx_get_stats64,
 };
 
-static void mxl862xx_phylink_mac_config(struct phylink_config *config,
-					unsigned int mode,
-					const struct phylink_link_state *state)
-{
-}
-
-static void mxl862xx_phylink_mac_link_down(struct phylink_config *config,
-					   unsigned int mode,
-					   phy_interface_t interface)
-{
-}
-
-static void mxl862xx_phylink_mac_link_up(struct phylink_config *config,
-					 struct phy_device *phydev,
-					 unsigned int mode,
-					 phy_interface_t interface,
-					 int speed, int duplex,
-					 bool tx_pause, bool rx_pause)
-{
-}
-
-static const struct phylink_mac_ops mxl862xx_phylink_mac_ops = {
-	.mac_config = mxl862xx_phylink_mac_config,
-	.mac_link_down = mxl862xx_phylink_mac_link_down,
-	.mac_link_up = mxl862xx_phylink_mac_link_up,
-};
-
 static int mxl862xx_probe(struct mdio_device *mdiodev)
 {
 	struct device *dev = &mdiodev->dev;
-- 
2.54.0

