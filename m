Return-Path: <netdev+bounces-289554-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJwwNEGgDGq8jwUAu9opvQ
	(envelope-from <netdev+bounces-289554-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:39:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7045158334A
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB1C1305ACD2
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 17:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C37E4DD6FF;
	Tue, 19 May 2026 17:38:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3476548C8C2;
	Tue, 19 May 2026 17:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779212311; cv=none; b=LLBhCOwdCCiJMg+qqSQmuODncQr7NLyoYKqbcNbTK6bBCWPnNw25vyNGj52ZuuelW2jXlAJDT/pfn1wu1OatBU/GjaKwKBy+LydBg62+I/xNjF2Zc0f27CezUEIBI4Tm48JIsxBtR4ufo1+eBHaDo+3ffjD83yQHvO5xLG2NJ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779212311; c=relaxed/simple;
	bh=S0DUNol0w1tKeaH9rjNRfAg3xhMYe06q0pQ3YeJlUSE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glVZfclrEWYeDeOwDtCxrnR1FnQMVjw2eHTYRDtzzDJK2GOBqsXhPUP/eyEvVCyWy3R4zMm4mVZSTVBkzR1yaj4RvhdkY6mJOhSK5BxB58O/gbuVrUFH5y0BbJpWygc6KJ9b0xft9QoAdYKkp/H+ZSNxk7sIdRK+t4PPiNEn/HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wPOOe-000000001dw-04HO;
	Tue, 19 May 2026 17:38:24 +0000
Date: Tue, 19 May 2026 18:38:21 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 2/5] net: dsa: mxl862xx: move phylink stubs to
 mxl862xx-phylink.c
Message-ID: <9fdc78938c951418048dcc1d831171c717180b5c.1779203863.git.daniel@makrotopia.org>
References: <cover.1779203863.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1779203863.git.daniel@makrotopia.org>
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289554-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	DMARC_NA(0.00)[makrotopia.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,makrotopia.org:mid,makrotopia.org:email]
X-Rspamd-Queue-Id: 7045158334A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move the phylink MAC operations and get_caps callback from mxl862xx.c
into a dedicated mxl862xx-phylink.c file. This prepares for the SerDes
PCS implementation which adds substantial phylink/PCS code -- keeping
it in a separate file avoids function-position churn in the main
driver file.

No functional change.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
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

