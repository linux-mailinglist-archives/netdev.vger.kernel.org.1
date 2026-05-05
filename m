Return-Path: <netdev+bounces-284439-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EK94BK7++WkqFwMAu9opvQ
	(envelope-from <netdev+bounces-284439-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 16:29:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F73B4CF663
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 16:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58193309BDAD
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 14:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77B148165A;
	Tue,  5 May 2026 14:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="yPRW9lpK"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6AE480355
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777991130; cv=none; b=JXHGgIvsVMIjSLhg+XDFbcb8WURUyaaIBkQY5bszOSsPn2vKJpNszJdX7/px1b2RtQLsmRfKVfU7pZ7+rtfAnBQ9K1l1MtrOd+brmrkXxd5xdmjtle8j/Qtx/P09ZUaaTzatZJDxt/F3ObYVK/GfEFa0VptWyiTqv4TghEyGfM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777991130; c=relaxed/simple;
	bh=l7Hr4u7ZcHNXoiQscQy/BC2Ay+LOj4zoDNQTNUC7DOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MU0ad+y86+2hiHD3BuFwQZlxKwSqzPYxqerSe2ZtYvIynHzPiE3CYYLjHWc7Z6Fgj2Zfih0xdzy/On3YyD3WFYxCXDZij3OGsRWZkyMULuxeMb/bdSQBV6yQhg7Dk9jNWQ184AHNNq75RU309iCtPA1HUTFaUwXZm8v2+DGaFes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=yPRW9lpK; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EA9941A3528;
	Tue,  5 May 2026 14:25:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BF9516053C;
	Tue,  5 May 2026 14:25:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D991011AD0241;
	Tue,  5 May 2026 16:25:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777991124; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TgiCm365J4UqLRmzRs4VNMAN9JrfewwwY8ogPO532JA=;
	b=yPRW9lpKR7OT14q+ZkcJLQTL8QeJgrNfl2j13KAvtQUL4XHY3oU/C0QgVppVoW0+JZMf8o
	cr4C0gFSKTi06/8CcWU3UhSMZoXRDFNmc3LkRQ+33d/X9W7bg4hLj+9z5zPE0jY0SV2zI0
	R3Rdg2k+/5mFuj5PTyIPBfhzL4/7jV3xQCNulYVyqo5GU2O7uac1UebswbfarCTEAEiSbd
	5nvgR4fUquN0AChDOVvycUwNUAWbzwHgzt/+hb16glPlzrvVNHLmH5PQkVWil47uvGilyl
	i0/m4QefYIRYq4gkme8gjj8kFZYy/lDLN9NG01LgJ9mj6jxeOXurin3O1TCUkg==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Tue, 05 May 2026 16:25:05 +0200
Subject: [PATCH net-next 5/9] net: dsa: microchip: move phylink_mac_ops to
 individual drivers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-clean-ksz-driver-v1-5-05d70fa42461@bootlin.com>
References: <20260505-clean-ksz-driver-v1-0-05d70fa42461@bootlin.com>
In-Reply-To: <20260505-clean-ksz-driver-v1-0-05d70fa42461@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 7F73B4CF663
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284439-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid]

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Similar to ksz_dev_ops, struct phylink_mac_ops shouldn't be part of
the common code. Instead, the common code should provide callable
functionality.

Invert the paradigm and export the common aspects from ksz_common.c, and
move the chip-specific stuff in individual drivers.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c         |  36 +++++-
 drivers/net/dsa/microchip/ksz8.h         |   7 +-
 drivers/net/dsa/microchip/ksz9477.c      | 126 ++++++++++++++++++++
 drivers/net/dsa/microchip/ksz9477.h      |   8 ++
 drivers/net/dsa/microchip/ksz_common.c   | 194 ++-----------------------------
 drivers/net/dsa/microchip/ksz_common.h   |  10 ++
 drivers/net/dsa/microchip/lan937x.h      |   1 +
 drivers/net/dsa/microchip/lan937x_main.c |   8 ++
 8 files changed, 196 insertions(+), 194 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 56560f60223a1..f311901c693f8 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -1870,10 +1870,12 @@ static void ksz8_cpu_port_link_up(struct ksz_device *dev, int speed, int duplex,
 		 SW_10_MBIT, ctrl);
 }
 
-void ksz8_phylink_mac_link_up(struct phylink_config *config,
-			      struct phy_device *phydev, unsigned int mode,
-			      phy_interface_t interface, int speed, int duplex,
-			      bool tx_pause, bool rx_pause)
+static void ksz8_phylink_mac_link_up(struct phylink_config *config,
+				     struct phy_device *phydev,
+				     unsigned int mode,
+				     phy_interface_t interface,
+				     int speed, int duplex,
+				     bool tx_pause, bool rx_pause)
 {
 	struct dsa_port *dp = dsa_phylink_to_port(config);
 	struct ksz_device *dev = dp->ds->priv;
@@ -2097,6 +2099,32 @@ static void ksz8_switch_exit(struct ksz_device *dev)
 	ksz8_reset_switch(dev);
 }
 
+static void ksz88x3_phylink_mac_config(struct phylink_config *config,
+				       unsigned int mode,
+				       const struct phylink_link_state *state)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct ksz_device *dev = dp->ds->priv;
+
+	dev->ports[dp->index].manual_flow = !(state->pause & MLO_PAUSE_AN);
+}
+
+const struct phylink_mac_ops ksz88x3_phylink_mac_ops = {
+	.mac_config	= ksz88x3_phylink_mac_config,
+	.mac_link_down	= ksz_phylink_mac_link_down,
+	.mac_link_up	= ksz8_phylink_mac_link_up,
+	.mac_disable_tx_lpi = ksz_phylink_mac_disable_tx_lpi,
+	.mac_enable_tx_lpi = ksz_phylink_mac_enable_tx_lpi,
+};
+
+const struct phylink_mac_ops ksz8_phylink_mac_ops = {
+	.mac_config	= ksz_phylink_mac_config,
+	.mac_link_down	= ksz_phylink_mac_link_down,
+	.mac_link_up	= ksz8_phylink_mac_link_up,
+	.mac_disable_tx_lpi = ksz_phylink_mac_disable_tx_lpi,
+	.mac_enable_tx_lpi = ksz_phylink_mac_enable_tx_lpi,
+};
+
 const struct ksz_dev_ops ksz8463_dev_ops = {
 	.setup = ksz8_setup,
 	.get_port_addr = ksz8463_get_port_addr,
diff --git a/drivers/net/dsa/microchip/ksz8.h b/drivers/net/dsa/microchip/ksz8.h
index 4b798ce29daaf..2d787d6d96b05 100644
--- a/drivers/net/dsa/microchip/ksz8.h
+++ b/drivers/net/dsa/microchip/ksz8.h
@@ -12,13 +12,10 @@
 #include <net/dsa.h>
 #include "ksz_common.h"
 
-void ksz8_phylink_mac_link_up(struct phylink_config *config,
-			      struct phy_device *phydev, unsigned int mode,
-			      phy_interface_t interface, int speed, int duplex,
-			      bool tx_pause, bool rx_pause);
-
 extern const struct ksz_dev_ops ksz8463_dev_ops;
 extern const struct ksz_dev_ops ksz87xx_dev_ops;
 extern const struct ksz_dev_ops ksz88xx_dev_ops;
+extern const struct phylink_mac_ops ksz88x3_phylink_mac_ops;
+extern const struct phylink_mac_ops ksz8_phylink_mac_ops;
 
 #endif
diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 3275996cda962..3fd2174364acf 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1609,6 +1609,132 @@ static void ksz9477_switch_exit(struct ksz_device *dev)
 	ksz9477_reset_switch(dev);
 }
 
+static void ksz9477_set_gbit(struct ksz_device *dev, int port, bool gbit)
+{
+	const u8 *bitval = dev->info->xmii_ctrl1;
+	const u16 *regs = dev->info->regs;
+	u8 data8;
+
+	ksz_pread8(dev, port, regs[P_XMII_CTRL_1], &data8);
+
+	data8 &= ~P_GMII_1GBIT_M;
+
+	if (gbit)
+		data8 |= FIELD_PREP(P_GMII_1GBIT_M, bitval[P_GMII_1GBIT]);
+	else
+		data8 |= FIELD_PREP(P_GMII_1GBIT_M, bitval[P_GMII_NOT_1GBIT]);
+
+	/* Write the updated value */
+	ksz_pwrite8(dev, port, regs[P_XMII_CTRL_1], data8);
+}
+
+static void ksz9477_set_100_10mbit(struct ksz_device *dev, int port, int speed)
+{
+	const u8 *bitval = dev->info->xmii_ctrl0;
+	const u16 *regs = dev->info->regs;
+	u8 data8;
+
+	ksz_pread8(dev, port, regs[P_XMII_CTRL_0], &data8);
+
+	data8 &= ~P_MII_100MBIT_M;
+
+	if (speed == SPEED_100)
+		data8 |= FIELD_PREP(P_MII_100MBIT_M, bitval[P_MII_100MBIT]);
+	else
+		data8 |= FIELD_PREP(P_MII_100MBIT_M, bitval[P_MII_10MBIT]);
+
+	/* Write the updated value */
+	ksz_pwrite8(dev, port, regs[P_XMII_CTRL_0], data8);
+}
+
+static void ksz9477_port_set_xmii_speed(struct ksz_device *dev, int port,
+					int speed)
+{
+	if (speed == SPEED_1000)
+		ksz9477_set_gbit(dev, port, true);
+	else
+		ksz9477_set_gbit(dev, port, false);
+
+	if (speed == SPEED_100 || speed == SPEED_10)
+		ksz9477_set_100_10mbit(dev, port, speed);
+}
+
+static void ksz9477_duplex_flowctrl(struct ksz_device *dev, int port, int duplex,
+				    bool tx_pause, bool rx_pause)
+{
+	const u8 *bitval = dev->info->xmii_ctrl0;
+	const u32 *masks = dev->info->masks;
+	const u16 *regs = dev->info->regs;
+	u8 mask;
+	u8 val;
+
+	mask = P_MII_DUPLEX_M | masks[P_MII_TX_FLOW_CTRL] |
+	       masks[P_MII_RX_FLOW_CTRL];
+
+	if (duplex == DUPLEX_FULL)
+		val = FIELD_PREP(P_MII_DUPLEX_M, bitval[P_MII_FULL_DUPLEX]);
+	else
+		val = FIELD_PREP(P_MII_DUPLEX_M, bitval[P_MII_HALF_DUPLEX]);
+
+	if (tx_pause)
+		val |= masks[P_MII_TX_FLOW_CTRL];
+
+	if (rx_pause)
+		val |= masks[P_MII_RX_FLOW_CTRL];
+
+	ksz_prmw8(dev, port, regs[P_XMII_CTRL_0], mask, val);
+}
+
+void ksz9477_phylink_mac_link_up(struct phylink_config *config,
+				 struct phy_device *phydev,
+				 unsigned int mode,
+				 phy_interface_t interface,
+				 int speed, int duplex, bool tx_pause,
+				 bool rx_pause)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct ksz_device *dev = dp->ds->priv;
+	int port = dp->index;
+	struct ksz_port *p;
+
+	p = &dev->ports[port];
+
+	/* Internal PHYs */
+	if (dev->info->internal_phy[port])
+		return;
+
+	p->speed = speed;
+
+	ksz9477_port_set_xmii_speed(dev, port, speed);
+
+	ksz9477_duplex_flowctrl(dev, port, duplex, tx_pause, rx_pause);
+}
+
+static struct phylink_pcs *
+ksz9477_phylink_mac_select_pcs(struct phylink_config *config,
+			       phy_interface_t interface)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct ksz_device *dev = dp->ds->priv;
+	struct ksz_port *p = &dev->ports[dp->index];
+
+	if (ksz_is_sgmii_port(dev, dp->index) &&
+	    (interface == PHY_INTERFACE_MODE_SGMII ||
+	    interface == PHY_INTERFACE_MODE_1000BASEX))
+		return p->pcs;
+
+	return NULL;
+}
+
+const struct phylink_mac_ops ksz9477_phylink_mac_ops = {
+	.mac_config	= ksz_phylink_mac_config,
+	.mac_link_down	= ksz_phylink_mac_link_down,
+	.mac_link_up	= ksz9477_phylink_mac_link_up,
+	.mac_disable_tx_lpi = ksz_phylink_mac_disable_tx_lpi,
+	.mac_enable_tx_lpi = ksz_phylink_mac_enable_tx_lpi,
+	.mac_select_pcs	= ksz9477_phylink_mac_select_pcs,
+};
+
 const struct ksz_dev_ops ksz9477_dev_ops = {
 	.setup = ksz9477_setup,
 	.get_port_addr = ksz9477_get_port_addr,
diff --git a/drivers/net/dsa/microchip/ksz9477.h b/drivers/net/dsa/microchip/ksz9477.h
index 30ab0c8807dbc..26a91f1a4c871 100644
--- a/drivers/net/dsa/microchip/ksz9477.h
+++ b/drivers/net/dsa/microchip/ksz9477.h
@@ -84,6 +84,14 @@ void ksz9477_acl_match_process_l2(struct ksz_device *dev, int port,
 				  u16 ethtype, u8 *src_mac, u8 *dst_mac,
 				  unsigned long cookie, u32 prio);
 
+void ksz9477_phylink_mac_link_up(struct phylink_config *config,
+				 struct phy_device *phydev,
+				 unsigned int mode,
+				 phy_interface_t interface,
+				 int speed, int duplex, bool tx_pause,
+				 bool rx_pause);
+
 extern const struct ksz_dev_ops ksz9477_dev_ops;
+extern const struct phylink_mac_ops ksz9477_phylink_mac_ops;
 
 #endif
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 88446bc32465f..308740829e76c 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -256,16 +256,6 @@ static const struct ksz_drive_strength ksz88x3_drive_strengths[] = {
 	{ KSZ8873_DRIVE_STRENGTH_16MA, 16000 },
 };
 
-static void ksz88x3_phylink_mac_config(struct phylink_config *config,
-				       unsigned int mode,
-				       const struct phylink_link_state *state);
-static void ksz_phylink_mac_config(struct phylink_config *config,
-				   unsigned int mode,
-				   const struct phylink_link_state *state);
-static void ksz_phylink_mac_link_down(struct phylink_config *config,
-				      unsigned int mode,
-				      phy_interface_t interface);
-
 /**
  * ksz_phylink_mac_disable_tx_lpi() - Callback to signal LPI support (Dummy)
  * @config: phylink config structure
@@ -273,7 +263,7 @@ static void ksz_phylink_mac_link_down(struct phylink_config *config,
  * This function is a dummy handler. See ksz_phylink_mac_enable_tx_lpi() for
  * a detailed explanation of EEE/LPI handling in KSZ switches.
  */
-static void ksz_phylink_mac_disable_tx_lpi(struct phylink_config *config)
+void ksz_phylink_mac_disable_tx_lpi(struct phylink_config *config)
 {
 }
 
@@ -310,68 +300,12 @@ static void ksz_phylink_mac_disable_tx_lpi(struct phylink_config *config)
  *
  * Returns: 0 (Always success)
  */
-static int ksz_phylink_mac_enable_tx_lpi(struct phylink_config *config,
-					 u32 timer, bool tx_clock_stop)
+int ksz_phylink_mac_enable_tx_lpi(struct phylink_config *config,
+				  u32 timer, bool tx_clock_stop)
 {
 	return 0;
 }
 
-static const struct phylink_mac_ops ksz88x3_phylink_mac_ops = {
-	.mac_config	= ksz88x3_phylink_mac_config,
-	.mac_link_down	= ksz_phylink_mac_link_down,
-	.mac_link_up	= ksz8_phylink_mac_link_up,
-	.mac_disable_tx_lpi = ksz_phylink_mac_disable_tx_lpi,
-	.mac_enable_tx_lpi = ksz_phylink_mac_enable_tx_lpi,
-};
-
-static const struct phylink_mac_ops ksz8_phylink_mac_ops = {
-	.mac_config	= ksz_phylink_mac_config,
-	.mac_link_down	= ksz_phylink_mac_link_down,
-	.mac_link_up	= ksz8_phylink_mac_link_up,
-	.mac_disable_tx_lpi = ksz_phylink_mac_disable_tx_lpi,
-	.mac_enable_tx_lpi = ksz_phylink_mac_enable_tx_lpi,
-};
-
-static void ksz9477_phylink_mac_link_up(struct phylink_config *config,
-					struct phy_device *phydev,
-					unsigned int mode,
-					phy_interface_t interface,
-					int speed, int duplex, bool tx_pause,
-					bool rx_pause);
-
-static struct phylink_pcs *
-ksz_phylink_mac_select_pcs(struct phylink_config *config,
-			   phy_interface_t interface)
-{
-	struct dsa_port *dp = dsa_phylink_to_port(config);
-	struct ksz_device *dev = dp->ds->priv;
-	struct ksz_port *p = &dev->ports[dp->index];
-
-	if (ksz_is_sgmii_port(dev, dp->index) &&
-	    (interface == PHY_INTERFACE_MODE_SGMII ||
-	    interface == PHY_INTERFACE_MODE_1000BASEX))
-		return p->pcs;
-
-	return NULL;
-}
-
-static const struct phylink_mac_ops ksz9477_phylink_mac_ops = {
-	.mac_config	= ksz_phylink_mac_config,
-	.mac_link_down	= ksz_phylink_mac_link_down,
-	.mac_link_up	= ksz9477_phylink_mac_link_up,
-	.mac_disable_tx_lpi = ksz_phylink_mac_disable_tx_lpi,
-	.mac_enable_tx_lpi = ksz_phylink_mac_enable_tx_lpi,
-	.mac_select_pcs	= ksz_phylink_mac_select_pcs,
-};
-
-static const struct phylink_mac_ops lan937x_phylink_mac_ops = {
-	.mac_config	= ksz_phylink_mac_config,
-	.mac_link_down	= ksz_phylink_mac_link_down,
-	.mac_link_up	= ksz9477_phylink_mac_link_up,
-	.mac_disable_tx_lpi = ksz_phylink_mac_disable_tx_lpi,
-	.mac_enable_tx_lpi = ksz_phylink_mac_enable_tx_lpi,
-};
-
 static const u16 ksz8463_regs[] = {
 	[REG_SW_MAC_ADDR]		= 0x10,
 	[REG_IND_CTRL_0]		= 0x30,
@@ -3068,9 +3002,9 @@ static u32 ksz_get_phy_flags(struct dsa_switch *ds, int port)
 	return 0;
 }
 
-static void ksz_phylink_mac_link_down(struct phylink_config *config,
-				      unsigned int mode,
-				      phy_interface_t interface)
+void ksz_phylink_mac_link_down(struct phylink_config *config,
+			       unsigned int mode,
+			       phy_interface_t interface)
 {
 	struct dsa_port *dp = dsa_phylink_to_port(config);
 	struct ksz_device *dev = dp->ds->priv;
@@ -3657,19 +3591,9 @@ phy_interface_t ksz_get_xmii(struct ksz_device *dev, int port, bool gbit)
 	return interface;
 }
 
-static void ksz88x3_phylink_mac_config(struct phylink_config *config,
-				       unsigned int mode,
-				       const struct phylink_link_state *state)
-{
-	struct dsa_port *dp = dsa_phylink_to_port(config);
-	struct ksz_device *dev = dp->ds->priv;
-
-	dev->ports[dp->index].manual_flow = !(state->pause & MLO_PAUSE_AN);
-}
-
-static void ksz_phylink_mac_config(struct phylink_config *config,
-				   unsigned int mode,
-				   const struct phylink_link_state *state)
+void ksz_phylink_mac_config(struct phylink_config *config,
+			    unsigned int mode,
+			    const struct phylink_link_state *state)
 {
 	struct dsa_port *dp = dsa_phylink_to_port(config);
 	struct ksz_device *dev = dp->ds->priv;
@@ -3712,106 +3636,6 @@ bool ksz_get_gbit(struct ksz_device *dev, int port)
 	return gbit;
 }
 
-static void ksz_set_gbit(struct ksz_device *dev, int port, bool gbit)
-{
-	const u8 *bitval = dev->info->xmii_ctrl1;
-	const u16 *regs = dev->info->regs;
-	u8 data8;
-
-	ksz_pread8(dev, port, regs[P_XMII_CTRL_1], &data8);
-
-	data8 &= ~P_GMII_1GBIT_M;
-
-	if (gbit)
-		data8 |= FIELD_PREP(P_GMII_1GBIT_M, bitval[P_GMII_1GBIT]);
-	else
-		data8 |= FIELD_PREP(P_GMII_1GBIT_M, bitval[P_GMII_NOT_1GBIT]);
-
-	/* Write the updated value */
-	ksz_pwrite8(dev, port, regs[P_XMII_CTRL_1], data8);
-}
-
-static void ksz_set_100_10mbit(struct ksz_device *dev, int port, int speed)
-{
-	const u8 *bitval = dev->info->xmii_ctrl0;
-	const u16 *regs = dev->info->regs;
-	u8 data8;
-
-	ksz_pread8(dev, port, regs[P_XMII_CTRL_0], &data8);
-
-	data8 &= ~P_MII_100MBIT_M;
-
-	if (speed == SPEED_100)
-		data8 |= FIELD_PREP(P_MII_100MBIT_M, bitval[P_MII_100MBIT]);
-	else
-		data8 |= FIELD_PREP(P_MII_100MBIT_M, bitval[P_MII_10MBIT]);
-
-	/* Write the updated value */
-	ksz_pwrite8(dev, port, regs[P_XMII_CTRL_0], data8);
-}
-
-static void ksz_port_set_xmii_speed(struct ksz_device *dev, int port, int speed)
-{
-	if (speed == SPEED_1000)
-		ksz_set_gbit(dev, port, true);
-	else
-		ksz_set_gbit(dev, port, false);
-
-	if (speed == SPEED_100 || speed == SPEED_10)
-		ksz_set_100_10mbit(dev, port, speed);
-}
-
-static void ksz_duplex_flowctrl(struct ksz_device *dev, int port, int duplex,
-				bool tx_pause, bool rx_pause)
-{
-	const u8 *bitval = dev->info->xmii_ctrl0;
-	const u32 *masks = dev->info->masks;
-	const u16 *regs = dev->info->regs;
-	u8 mask;
-	u8 val;
-
-	mask = P_MII_DUPLEX_M | masks[P_MII_TX_FLOW_CTRL] |
-	       masks[P_MII_RX_FLOW_CTRL];
-
-	if (duplex == DUPLEX_FULL)
-		val = FIELD_PREP(P_MII_DUPLEX_M, bitval[P_MII_FULL_DUPLEX]);
-	else
-		val = FIELD_PREP(P_MII_DUPLEX_M, bitval[P_MII_HALF_DUPLEX]);
-
-	if (tx_pause)
-		val |= masks[P_MII_TX_FLOW_CTRL];
-
-	if (rx_pause)
-		val |= masks[P_MII_RX_FLOW_CTRL];
-
-	ksz_prmw8(dev, port, regs[P_XMII_CTRL_0], mask, val);
-}
-
-static void ksz9477_phylink_mac_link_up(struct phylink_config *config,
-					struct phy_device *phydev,
-					unsigned int mode,
-					phy_interface_t interface,
-					int speed, int duplex, bool tx_pause,
-					bool rx_pause)
-{
-	struct dsa_port *dp = dsa_phylink_to_port(config);
-	struct ksz_device *dev = dp->ds->priv;
-	int port = dp->index;
-	struct ksz_port *p;
-
-	p = &dev->ports[port];
-
-	/* Internal PHYs */
-	if (dev->info->internal_phy[port])
-		return;
-
-	p->speed = speed;
-
-	ksz_port_set_xmii_speed(dev, port, speed);
-
-	ksz_duplex_flowctrl(dev, port, duplex, tx_pause, rx_pause);
-}
-
 static int ksz_switch_detect(struct ksz_device *dev)
 {
 	u8 id1, id2, id4;
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index cf2d0d91f1732..519e080c8910e 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -479,6 +479,16 @@ void ksz_switch_macaddr_put(struct dsa_switch *ds);
 void ksz_switch_shutdown(struct ksz_device *dev);
 int ksz_handle_wake_reason(struct ksz_device *dev, int port);
 
+void ksz_phylink_mac_disable_tx_lpi(struct phylink_config *config);
+int ksz_phylink_mac_enable_tx_lpi(struct phylink_config *config,
+				  u32 timer, bool tx_clock_stop);
+void ksz_phylink_mac_config(struct phylink_config *config,
+			    unsigned int mode,
+			    const struct phylink_link_state *state);
+void ksz_phylink_mac_link_down(struct phylink_config *config,
+			       unsigned int mode,
+			       phy_interface_t interface);
+
 /* Common register access functions */
 static inline struct regmap *ksz_regmap_8(struct ksz_device *dev)
 {
diff --git a/drivers/net/dsa/microchip/lan937x.h b/drivers/net/dsa/microchip/lan937x.h
index 48fc497750943..c5e745a9f47f1 100644
--- a/drivers/net/dsa/microchip/lan937x.h
+++ b/drivers/net/dsa/microchip/lan937x.h
@@ -7,5 +7,6 @@
 #define __LAN937X_CFG_H
 
 extern const struct ksz_dev_ops lan937x_dev_ops;
+extern const struct phylink_mac_ops lan937x_phylink_mac_ops;
 
 #endif
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index ced381f67392b..4846ae2a2d69a 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -666,6 +666,14 @@ static void lan937x_switch_exit(struct ksz_device *dev)
 	lan937x_reset_switch(dev);
 }
 
+const struct phylink_mac_ops lan937x_phylink_mac_ops = {
+	.mac_config	= ksz_phylink_mac_config,
+	.mac_link_down	= ksz_phylink_mac_link_down,
+	.mac_link_up	= ksz9477_phylink_mac_link_up,
+	.mac_disable_tx_lpi = ksz_phylink_mac_disable_tx_lpi,
+	.mac_enable_tx_lpi = ksz_phylink_mac_enable_tx_lpi,
+};
+
 const struct ksz_dev_ops lan937x_dev_ops = {
 	.setup = lan937x_setup,
 	.teardown = lan937x_teardown,

-- 
2.53.0


