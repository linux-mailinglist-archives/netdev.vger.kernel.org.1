Return-Path: <netdev+bounces-291629-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEZXFEtuFWo2VAcAu9opvQ
	(envelope-from <netdev+bounces-291629-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:56:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A31BD5D3C7D
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABDBC3044F1B
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43193DEFE6;
	Tue, 26 May 2026 09:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NYdPvv9I"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04D63DD876
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 09:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788878; cv=none; b=seMxghV+vEIL9QCERz6MOpiwvhNMSgASh67noXu0CWkCE68lyjii141AepI5Ez6L5rvtVi26NT5JbKEhAk1EopR12DhzTJNt07FjkoCC5kvfWwgwNi/XvwSRi4+7CQ/Rc2yuex2M59chhiQzA7eu3okORgFwYnLwvwdP9Zh74TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788878; c=relaxed/simple;
	bh=RqhqUlgIRJ/4gPO45gh/czQrI5Q7huTR9VldIjIQCvk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YuvggFP40ERzbh6F8gdkqhe7TTd7X12TI1ZaRqpcO7DC8LsgZpWmOhCtj4GRJMY98sHVvMrTvryEWpGthOg9RUJWDHybqyv5lM1PnX9d7lEajVSLd7+XMSc0ol5xriGINKE8B3zOQ7ryFy26VyFDx5rJH3S2DQcjyYATkPXE1uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NYdPvv9I; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A3B6E4E42D56;
	Tue, 26 May 2026 09:47:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 70F2E60732;
	Tue, 26 May 2026 09:47:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ABBAC1088858A;
	Tue, 26 May 2026 11:47:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779788873; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+ArWhabM5naZBAFFkEbpc6/MSZbc2R5Fy5iytBo+VLU=;
	b=NYdPvv9IX7aEsIuoJ2n54B7NwhE/T3efDW7odciwV2W4H71n8gU2C3jaUud3xzqZP4pJul
	0kcj+gi3GDtLxCZAEjYnomyLMp2vW74xosi082LzbeRXTbPa8Q1K81V+1cUcq43NDVd9Y8
	s8DwIOZbJiEyy59cjYm2f/6W/HrofGJPEMEVgdIo84cVd963b416OA7pNe14rwfNg1xQvz
	clLMaC3JYmOZ7y+d3HiFnTRoopLY9yeitZ0QqnquSYXmIXKsc+nfY2xYJZXtbXKSZGkICp
	zJcEGZs89qGSU5Mf3RNSnpmvfCgDXozMTBjpAhOB4BqlPusSCQcRE0ctD0h9Bw==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Tue, 26 May 2026 11:47:33 +0200
Subject: [PATCH net-next 7/9] net: dsa: microchip: implement port_hsr_join
 for KSZ9477 only
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-clean-ksz-3rd-v1-7-5b63e732149a@bootlin.com>
References: <20260526-clean-ksz-3rd-v1-0-5b63e732149a@bootlin.com>
In-Reply-To: <20260526-clean-ksz-3rd-v1-0-5b63e732149a@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291629-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A31BD5D3C7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

All switches implement the optional .port_hsr_join operation while only
the KSZ9477 truly supports it.

Remove the common port_hsr_join implementation.
Replace it with a specific implementation for the KSZ9477 case.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c         |  6 ---
 drivers/net/dsa/microchip/ksz9477.c      | 64 ++++++++++++++++++++++++++++--
 drivers/net/dsa/microchip/ksz9477.h      |  2 -
 drivers/net/dsa/microchip/ksz_common.c   | 67 --------------------------------
 drivers/net/dsa/microchip/ksz_common.h   |  4 --
 drivers/net/dsa/microchip/lan937x_main.c |  2 -
 6 files changed, 60 insertions(+), 85 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 38549dfdce7c..bea66183238e 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -2448,8 +2448,6 @@ const struct dsa_switch_ops ksz8463_switch_ops = {
 	.get_sset_count		= ksz_sset_count,
 	.port_bridge_join	= ksz_port_bridge_join,
 	.port_bridge_leave	= ksz_port_bridge_leave,
-	.port_hsr_join		= ksz_hsr_join,
-	.port_hsr_leave		= ksz_hsr_leave,
 	.port_set_mac_address	= ksz_port_set_mac_address,
 	.port_stp_state_set	= ksz_port_stp_state_set,
 	.port_teardown		= ksz_port_teardown,
@@ -2499,8 +2497,6 @@ const struct dsa_switch_ops ksz87xx_switch_ops = {
 	.get_sset_count		= ksz_sset_count,
 	.port_bridge_join	= ksz_port_bridge_join,
 	.port_bridge_leave	= ksz_port_bridge_leave,
-	.port_hsr_join		= ksz_hsr_join,
-	.port_hsr_leave		= ksz_hsr_leave,
 	.port_set_mac_address	= ksz_port_set_mac_address,
 	.port_stp_state_set	= ksz_port_stp_state_set,
 	.port_teardown		= ksz_port_teardown,
@@ -2556,8 +2552,6 @@ const struct dsa_switch_ops ksz88xx_switch_ops = {
 	.get_sset_count		= ksz_sset_count,
 	.port_bridge_join	= ksz_port_bridge_join,
 	.port_bridge_leave	= ksz_port_bridge_leave,
-	.port_hsr_join		= ksz_hsr_join,
-	.port_hsr_leave		= ksz_hsr_leave,
 	.port_set_mac_address	= ksz_port_set_mac_address,
 	.port_stp_state_set	= ksz_port_stp_state_set,
 	.port_teardown		= ksz_port_teardown,
diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index e0b3724a7558..d7903814a2a5 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -12,6 +12,7 @@
 #include <linux/platform_data/microchip-ksz.h>
 #include <linux/phy.h>
 #include <linux/if_bridge.h>
+#include <linux/if_hsr.h>
 #include <linux/if_vlan.h>
 #include <net/dsa.h>
 #include <net/switchdev.h>
@@ -1707,12 +1708,51 @@ static int ksz9477_tc_cbs_set_cinc(struct ksz_device *dev, int port, u32 val)
  */
 #define KSZ9477_SUPPORTED_HSR_FEATURES (NETIF_F_HW_HSR_DUP | NETIF_F_HW_HSR_FWD)
 
-void ksz9477_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr)
+static int ksz9477_hsr_join(struct dsa_switch *ds, int port,
+			    struct net_device *hsr,
+			    struct netlink_ext_ack *extack)
 {
 	struct ksz_device *dev = ds->priv;
 	struct net_device *user;
 	struct dsa_port *hsr_dp;
 	u8 data, hsr_ports = 0;
+	enum hsr_version ver;
+	int ret;
+
+	ret = hsr_get_version(hsr, &ver);
+	if (ret)
+		return ret;
+
+	if (dev->chip_id != KSZ9477_CHIP_ID) {
+		NL_SET_ERR_MSG_MOD(extack, "Chip does not support HSR offload");
+		return -EOPNOTSUPP;
+	}
+
+	/* KSZ9477 can support HW offloading of only 1 HSR device */
+	if (dev->hsr_dev && hsr != dev->hsr_dev) {
+		NL_SET_ERR_MSG_MOD(extack, "Offload supported for a single HSR");
+		return -EOPNOTSUPP;
+	}
+
+	/* KSZ9477 only supports HSR v0 and v1 */
+	if (!(ver == HSR_V0 || ver == HSR_V1)) {
+		NL_SET_ERR_MSG_MOD(extack, "Only HSR v0 and v1 supported");
+		return -EOPNOTSUPP;
+	}
+
+	/* KSZ9477 can only perform HSR offloading for up to two ports */
+	if (hweight8(dev->hsr_ports) >= 2) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot offload more than two ports - using software HSR");
+		return -EOPNOTSUPP;
+	}
+
+	/* Self MAC address filtering, to avoid frames traversing
+	 * the HSR ring more than once.
+	 */
+	ret = ksz_switch_macaddr_get(ds, port, extack);
+	if (ret)
+		return ret;
 
 	/* Program which port(s) shall support HSR */
 	ksz_rmw32(dev, REG_HSR_PORT_MAP__4, BIT(port), BIT(port));
@@ -1744,12 +1784,20 @@ void ksz9477_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr)
 	/* Setup HW supported features for lan HSR ports */
 	user = dsa_to_port(ds, port)->user;
 	user->features |= KSZ9477_SUPPORTED_HSR_FEATURES;
+
+	dev->hsr_dev = hsr;
+	dev->hsr_ports |= BIT(port);
+
+	return 0;
 }
 
-void ksz9477_hsr_leave(struct dsa_switch *ds, int port, struct net_device *hsr)
+static int ksz9477_hsr_leave(struct dsa_switch *ds, int port,
+			     struct net_device *hsr)
 {
 	struct ksz_device *dev = ds->priv;
 
+	WARN_ON(dev->chip_id != KSZ9477_CHIP_ID);
+
 	/* Clear port HSR support */
 	ksz_rmw32(dev, REG_HSR_PORT_MAP__4, BIT(port), 0);
 
@@ -1758,6 +1806,14 @@ void ksz9477_hsr_leave(struct dsa_switch *ds, int port, struct net_device *hsr)
 
 	/* Disable per port self-address filtering */
 	ksz_port_cfg(dev, port, REG_PORT_LUE_CTRL, PORT_SRC_ADDR_FILTER, false);
+
+	dev->hsr_ports &= ~BIT(port);
+	if (!dev->hsr_ports)
+		dev->hsr_dev = NULL;
+
+	ksz_switch_macaddr_put(ds);
+
+	return 0;
 }
 
 static int ksz9477_switch_init(struct ksz_device *dev)
@@ -2012,8 +2068,8 @@ const struct dsa_switch_ops ksz9477_switch_ops = {
 	.get_sset_count		= ksz_sset_count,
 	.port_bridge_join	= ksz_port_bridge_join,
 	.port_bridge_leave	= ksz_port_bridge_leave,
-	.port_hsr_join		= ksz_hsr_join,
-	.port_hsr_leave		= ksz_hsr_leave,
+	.port_hsr_join		= ksz9477_hsr_join,
+	.port_hsr_leave		= ksz9477_hsr_leave,
 	.port_set_mac_address	= ksz_port_set_mac_address,
 	.port_stp_state_set	= ksz_port_stp_state_set,
 	.port_teardown		= ksz_port_teardown,
diff --git a/drivers/net/dsa/microchip/ksz9477.h b/drivers/net/dsa/microchip/ksz9477.h
index 599db0a6ba2e..92a1d889224d 100644
--- a/drivers/net/dsa/microchip/ksz9477.h
+++ b/drivers/net/dsa/microchip/ksz9477.h
@@ -45,8 +45,6 @@ int ksz9477_mdb_del(struct dsa_switch *ds, int port,
 		    const struct switchdev_obj_port_mdb *mdb, struct dsa_db db);
 int ksz9477_enable_stp_addr(struct ksz_device *dev);
 void ksz9477_port_queue_split(struct ksz_device *dev, int port);
-void ksz9477_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr);
-void ksz9477_hsr_leave(struct dsa_switch *ds, int port, struct net_device *hsr);
 
 int ksz9477_port_acl_init(struct ksz_device *dev, int port);
 void ksz9477_port_acl_free(struct ksz_device *dev, int port);
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 2d0150b37a40..404399737cea 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -16,7 +16,6 @@
 #include <linux/etherdevice.h>
 #include <linux/if_bridge.h>
 #include <linux/if_vlan.h>
-#include <linux/if_hsr.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/of.h>
@@ -4043,72 +4042,6 @@ void ksz_switch_macaddr_put(struct dsa_switch *ds)
 	kfree(switch_macaddr);
 }
 
-int ksz_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr,
-		 struct netlink_ext_ack *extack)
-{
-	struct ksz_device *dev = ds->priv;
-	enum hsr_version ver;
-	int ret;
-
-	ret = hsr_get_version(hsr, &ver);
-	if (ret)
-		return ret;
-
-	if (dev->chip_id != KSZ9477_CHIP_ID) {
-		NL_SET_ERR_MSG_MOD(extack, "Chip does not support HSR offload");
-		return -EOPNOTSUPP;
-	}
-
-	/* KSZ9477 can support HW offloading of only 1 HSR device */
-	if (dev->hsr_dev && hsr != dev->hsr_dev) {
-		NL_SET_ERR_MSG_MOD(extack, "Offload supported for a single HSR");
-		return -EOPNOTSUPP;
-	}
-
-	/* KSZ9477 only supports HSR v0 and v1 */
-	if (!(ver == HSR_V0 || ver == HSR_V1)) {
-		NL_SET_ERR_MSG_MOD(extack, "Only HSR v0 and v1 supported");
-		return -EOPNOTSUPP;
-	}
-
-	/* KSZ9477 can only perform HSR offloading for up to two ports */
-	if (hweight8(dev->hsr_ports) >= 2) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Cannot offload more than two ports - using software HSR");
-		return -EOPNOTSUPP;
-	}
-
-	/* Self MAC address filtering, to avoid frames traversing
-	 * the HSR ring more than once.
-	 */
-	ret = ksz_switch_macaddr_get(ds, port, extack);
-	if (ret)
-		return ret;
-
-	ksz9477_hsr_join(ds, port, hsr);
-	dev->hsr_dev = hsr;
-	dev->hsr_ports |= BIT(port);
-
-	return 0;
-}
-
-int ksz_hsr_leave(struct dsa_switch *ds, int port,
-		  struct net_device *hsr)
-{
-	struct ksz_device *dev = ds->priv;
-
-	WARN_ON(dev->chip_id != KSZ9477_CHIP_ID);
-
-	ksz9477_hsr_leave(ds, port, hsr);
-	dev->hsr_ports &= ~BIT(port);
-	if (!dev->hsr_ports)
-		dev->hsr_dev = NULL;
-
-	ksz_switch_macaddr_put(ds);
-
-	return 0;
-}
-
 int ksz_suspend(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 33cb2c44004b..c8f9ac6c3a38 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -489,10 +489,6 @@ int ksz_set_wol(struct dsa_switch *ds, int port,
 		struct ethtool_wolinfo *wol);
 int ksz_port_set_mac_address(struct dsa_switch *ds, int port,
 			     const unsigned char *addr);
-int ksz_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr,
-		 struct netlink_ext_ack *extack);
-int ksz_hsr_leave(struct dsa_switch *ds, int port,
-		  struct net_device *hsr);
 
 int ksz_suspend(struct dsa_switch *ds);
 int ksz_resume(struct dsa_switch *ds);
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index 5e55f92fb0d4..742b919ae4df 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -883,8 +883,6 @@ const struct dsa_switch_ops lan937x_switch_ops = {
 	.get_sset_count		= ksz_sset_count,
 	.port_bridge_join	= ksz_port_bridge_join,
 	.port_bridge_leave	= ksz_port_bridge_leave,
-	.port_hsr_join		= ksz_hsr_join,
-	.port_hsr_leave		= ksz_hsr_leave,
 	.port_set_mac_address	= ksz_port_set_mac_address,
 	.port_stp_state_set	= ksz_port_stp_state_set,
 	.port_teardown		= ksz_port_teardown,

-- 
2.54.0


