Return-Path: <netdev+bounces-284438-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IE7yK3j++WkqFwMAu9opvQ
	(envelope-from <netdev+bounces-284438-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 16:28:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2437A4CF643
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 16:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8078308EE18
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 14:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF65481257;
	Tue,  5 May 2026 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gYjhdtyV"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E101F480DD0
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 14:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777991127; cv=none; b=LqcnbigumeHtS1ABNkmDALTnX2AqjjoPCGjt/SZO6ItxgDTdHiwvukaTXTZ268eJG9prXSbtrFyEAhiq3ygnsA9hFNXQCRFmpaIAcl35zq9/9X76wsP/6Zed6afL++lVBvleUFBf/cnvGYp+STCT9Pm7cvwpKTgZjdsMURW9cg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777991127; c=relaxed/simple;
	bh=ARZ/pYNnLdXq1XT8SqyaxVLydPbLl1q3Ipu/PdGovBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h85Ysj9QdaiqIEC/ZiqkLFumMmXdwjuGTtFqg4H71nEEvvFeuhA9sL8hL41pdutMzWaI7tRi0F2XBQ10z4Ao4JZZG11K9pApzU2RehydVYq/gEAj/q8A8klDyEXgdSIRx6qhY4spsz2YFNj5yU9wWKcuhhlzd5NW9MO2wdMuMcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gYjhdtyV; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 5C697C5D73D;
	Tue,  5 May 2026 14:26:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 811396053C;
	Tue,  5 May 2026 14:25:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A884C11AD0243;
	Tue,  5 May 2026 16:25:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777991122; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6S7KMu/zxPQprgK1hbqGRwq6YJDxTyCGLHkIAVFkAC4=;
	b=gYjhdtyVSdMJr280eddrpOTXRDVgx5Pcte6BUtMCdlcTK9uQlM42ANUS4GBuK29Sa5Qmcp
	4LG/1ZyvNOUhY0T+J0urXFykppI2TLMYGw0c/bdBnHwjEnSYzEkI268G0JDfVEJM1m8vpF
	wjPBi2mRL/y85PwDtfHTjr8fdAgwX7GW2GMxQngXGMytuylaRlWjk5H2ilQZ6dANQXW0fF
	Ec5c3a3VsiVRGyx2Q6sNDpQ1P8dlkqfQGhmuS188k/RYfsNKDX1ttyCgmmkKvzuvZNcVT6
	g0qduCvqkGHSHhOUmmVg4PNysz1TGbX8yd2zieFvawrubypGtxQTA/rrxfh2/g==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Tue, 05 May 2026 16:25:04 +0200
Subject: [PATCH net-next 4/9] net: dsa: microchip: move KSZ9477 and LAN937
 ksz_dev_ops to individual drivers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-clean-ksz-driver-v1-4-05d70fa42461@bootlin.com>
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
X-Rspamd-Queue-Id: 2437A4CF643
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284438-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,microchip.com:email,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid]

From: Vladimir Oltean <vladimir.oltean@nxp.com>

The ksz_dev_ops() are specific to each switch family so they should
belong to the individual drivers instead of the common section.

Move the ksz_dev_ops() definitions of the KSZ9477 and the LAN937 to
their individual drivers.
Set static the functions that aren't exported anymore.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz9477.c      | 66 +++++++++++++++++++++------
 drivers/net/dsa/microchip/ksz9477.h      | 15 +------
 drivers/net/dsa/microchip/ksz_common.c   | 76 --------------------------------
 drivers/net/dsa/microchip/lan937x.h      | 19 +-------
 drivers/net/dsa/microchip/lan937x_main.c | 72 +++++++++++++++++++++++-------
 5 files changed, 110 insertions(+), 138 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index d3c23dcaea8ca..3275996cda962 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -43,7 +43,7 @@ static void ksz9477_port_cfg32(struct ksz_device *dev, int port, int offset,
 			   bits, set ? bits : 0);
 }
 
-int ksz9477_change_mtu(struct ksz_device *dev, int port, int mtu)
+static int ksz9477_change_mtu(struct ksz_device *dev, int port, int mtu)
 {
 	u16 frame_size;
 
@@ -308,7 +308,7 @@ static int ksz9477_pcs_write(struct mii_bus *bus, int phy, int mmd, int reg,
 	return 0;
 }
 
-int ksz9477_pcs_create(struct ksz_device *dev)
+static int ksz9477_pcs_create(struct ksz_device *dev)
 {
 	int port = ksz_get_sgmii_port(dev);
 	struct ksz_port *p = &dev->ports[port];
@@ -341,7 +341,7 @@ int ksz9477_pcs_create(struct ksz_device *dev)
 	return 0;
 }
 
-int ksz9477_reset_switch(struct ksz_device *dev)
+static int ksz9477_reset_switch(struct ksz_device *dev)
 {
 	u8 data8;
 	u32 data32;
@@ -516,7 +516,7 @@ static void ksz9477_r_phy_quirks(struct ksz_device *dev, u16 addr, u16 reg,
 		*data &= ~(BMSR_ESTATEN | BMSR_ERCAP);
 }
 
-int ksz9477_r_phy(struct ksz_device *dev, u16 addr, u16 reg, u16 *data)
+static int ksz9477_r_phy(struct ksz_device *dev, u16 addr, u16 reg, u16 *data)
 {
 	u16 val = 0xffff;
 	int ret;
@@ -572,7 +572,7 @@ int ksz9477_r_phy(struct ksz_device *dev, u16 addr, u16 reg, u16 *data)
 	return 0;
 }
 
-int ksz9477_w_phy(struct ksz_device *dev, u16 addr, u16 reg, u16 val)
+static int ksz9477_w_phy(struct ksz_device *dev, u16 addr, u16 reg, u16 val)
 {
 	u32 mask, val32;
 
@@ -1150,8 +1150,8 @@ static phy_interface_t ksz9477_get_interface(struct ksz_device *dev, int port)
 	return interface;
 }
 
-void ksz9477_get_caps(struct ksz_device *dev, int port,
-		      struct phylink_config *config)
+static void ksz9477_get_caps(struct ksz_device *dev, int port,
+			     struct phylink_config *config)
 {
 	config->mac_capabilities = MAC_10 | MAC_100 | MAC_ASYM_PAUSE |
 				   MAC_SYM_PAUSE;
@@ -1168,7 +1168,7 @@ void ksz9477_get_caps(struct ksz_device *dev, int port,
 	}
 }
 
-int ksz9477_set_ageing_time(struct ksz_device *dev, unsigned int msecs)
+static int ksz9477_set_ageing_time(struct ksz_device *dev, unsigned int msecs)
 {
 	u32 secs = msecs / 1000;
 	u8 data, mult, value;
@@ -1234,7 +1234,7 @@ void ksz9477_port_queue_split(struct ksz_device *dev, int port)
 	ksz_prmw8(dev, port, REG_PORT_CTRL_0, PORT_QUEUE_SPLIT_MASK, data);
 }
 
-void ksz9477_port_setup(struct ksz_device *dev, int port, bool cpu_port)
+static void ksz9477_port_setup(struct ksz_device *dev, int port, bool cpu_port)
 {
 	const u16 *regs = dev->info->regs;
 	struct dsa_switch *ds = dev->ds;
@@ -1289,7 +1289,7 @@ void ksz9477_port_setup(struct ksz_device *dev, int port, bool cpu_port)
 	ksz_pwrite8(dev, port, regs[REG_PORT_PME_CTRL], 0);
 }
 
-void ksz9477_config_cpu_port(struct dsa_switch *ds)
+static void ksz9477_config_cpu_port(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
 	struct ksz_port *p;
@@ -1454,7 +1454,7 @@ int ksz9477_enable_stp_addr(struct ksz_device *dev)
 	return 0;
 }
 
-int ksz9477_setup(struct dsa_switch *ds)
+static int ksz9477_setup(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
 	const u16 *regs = dev->info->regs;
@@ -1500,7 +1500,7 @@ u32 ksz9477_get_port_addr(int port, int offset)
 	return PORT_CTRL_ADDR(port, offset);
 }
 
-int ksz9477_tc_cbs_set_cinc(struct ksz_device *dev, int port, u32 val)
+static int ksz9477_tc_cbs_set_cinc(struct ksz_device *dev, int port, u32 val)
 {
 	val = val >> 8;
 
@@ -1584,7 +1584,7 @@ void ksz9477_hsr_leave(struct dsa_switch *ds, int port, struct net_device *hsr)
 	ksz_port_cfg(dev, port, REG_PORT_LUE_CTRL, PORT_SRC_ADDR_FILTER, false);
 }
 
-int ksz9477_switch_init(struct ksz_device *dev)
+static int ksz9477_switch_init(struct ksz_device *dev)
 {
 	u8 data8;
 	int ret;
@@ -1604,11 +1604,49 @@ int ksz9477_switch_init(struct ksz_device *dev)
 	return 0;
 }
 
-void ksz9477_switch_exit(struct ksz_device *dev)
+static void ksz9477_switch_exit(struct ksz_device *dev)
 {
 	ksz9477_reset_switch(dev);
 }
 
+const struct ksz_dev_ops ksz9477_dev_ops = {
+	.setup = ksz9477_setup,
+	.get_port_addr = ksz9477_get_port_addr,
+	.cfg_port_member = ksz9477_cfg_port_member,
+	.flush_dyn_mac_table = ksz9477_flush_dyn_mac_table,
+	.port_setup = ksz9477_port_setup,
+	.set_ageing_time = ksz9477_set_ageing_time,
+	.r_phy = ksz9477_r_phy,
+	.w_phy = ksz9477_w_phy,
+	.r_mib_cnt = ksz9477_r_mib_cnt,
+	.r_mib_pkt = ksz9477_r_mib_pkt,
+	.r_mib_stat64 = ksz_r_mib_stats64,
+	.freeze_mib = ksz9477_freeze_mib,
+	.port_init_cnt = ksz9477_port_init_cnt,
+	.vlan_filtering = ksz9477_port_vlan_filtering,
+	.vlan_add = ksz9477_port_vlan_add,
+	.vlan_del = ksz9477_port_vlan_del,
+	.mirror_add = ksz9477_port_mirror_add,
+	.mirror_del = ksz9477_port_mirror_del,
+	.get_caps = ksz9477_get_caps,
+	.fdb_dump = ksz9477_fdb_dump,
+	.fdb_add = ksz9477_fdb_add,
+	.fdb_del = ksz9477_fdb_del,
+	.mdb_add = ksz9477_mdb_add,
+	.mdb_del = ksz9477_mdb_del,
+	.change_mtu = ksz9477_change_mtu,
+	.pme_write8 = ksz_write8,
+	.pme_pread8 = ksz_pread8,
+	.pme_pwrite8 = ksz_pwrite8,
+	.config_cpu_port = ksz9477_config_cpu_port,
+	.tc_cbs_set_cinc = ksz9477_tc_cbs_set_cinc,
+	.enable_stp_addr = ksz9477_enable_stp_addr,
+	.reset = ksz9477_reset_switch,
+	.init = ksz9477_switch_init,
+	.exit = ksz9477_switch_exit,
+	.pcs_create = ksz9477_pcs_create,
+};
+
 MODULE_AUTHOR("Woojung Huh <Woojung.Huh@microchip.com>");
 MODULE_DESCRIPTION("Microchip KSZ9477 Series Switch DSA Driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/dsa/microchip/ksz9477.h b/drivers/net/dsa/microchip/ksz9477.h
index 0d1a6dfda23ea..30ab0c8807dbc 100644
--- a/drivers/net/dsa/microchip/ksz9477.h
+++ b/drivers/net/dsa/microchip/ksz9477.h
@@ -11,14 +11,9 @@
 #include <net/dsa.h>
 #include "ksz_common.h"
 
-int ksz9477_setup(struct dsa_switch *ds);
 u32 ksz9477_get_port_addr(int port, int offset);
 void ksz9477_cfg_port_member(struct ksz_device *dev, int port, u8 member);
 void ksz9477_flush_dyn_mac_table(struct ksz_device *dev, int port);
-void ksz9477_port_setup(struct ksz_device *dev, int port, bool cpu_port);
-int ksz9477_set_ageing_time(struct ksz_device *dev, unsigned int msecs);
-int ksz9477_r_phy(struct ksz_device *dev, u16 addr, u16 reg, u16 *data);
-int ksz9477_w_phy(struct ksz_device *dev, u16 addr, u16 reg, u16 val);
 void ksz9477_r_mib_cnt(struct ksz_device *dev, int port, u16 addr, u64 *cnt);
 void ksz9477_r_mib_pkt(struct ksz_device *dev, int port, u16 addr,
 		       u64 *dropped, u64 *cnt);
@@ -38,8 +33,6 @@ void ksz9477_port_mirror_del(struct ksz_device *dev, int port,
 			     struct dsa_mall_mirror_tc_entry *mirror);
 int ksz9477_errata_monitor(struct ksz_device *dev, int port,
 			   u64 tx_late_col);
-void ksz9477_get_caps(struct ksz_device *dev, int port,
-		      struct phylink_config *config);
 int ksz9477_fdb_dump(struct ksz_device *dev, int port,
 		     dsa_fdb_dump_cb_t *cb, void *data);
 int ksz9477_fdb_add(struct ksz_device *dev, int port,
@@ -50,13 +43,7 @@ int ksz9477_mdb_add(struct ksz_device *dev, int port,
 		    const struct switchdev_obj_port_mdb *mdb, struct dsa_db db);
 int ksz9477_mdb_del(struct ksz_device *dev, int port,
 		    const struct switchdev_obj_port_mdb *mdb, struct dsa_db db);
-int ksz9477_change_mtu(struct ksz_device *dev, int port, int mtu);
-void ksz9477_config_cpu_port(struct dsa_switch *ds);
-int ksz9477_tc_cbs_set_cinc(struct ksz_device *dev, int port, u32 val);
 int ksz9477_enable_stp_addr(struct ksz_device *dev);
-int ksz9477_reset_switch(struct ksz_device *dev);
-int ksz9477_switch_init(struct ksz_device *dev);
-void ksz9477_switch_exit(struct ksz_device *dev);
 void ksz9477_port_queue_split(struct ksz_device *dev, int port);
 void ksz9477_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr);
 void ksz9477_hsr_leave(struct dsa_switch *ds, int port, struct net_device *hsr);
@@ -97,6 +84,6 @@ void ksz9477_acl_match_process_l2(struct ksz_device *dev, int port,
 				  u16 ethtype, u8 *src_mac, u8 *dst_mac,
 				  unsigned long cookie, u32 prio);
 
-int ksz9477_pcs_create(struct ksz_device *dev);
+extern const struct ksz_dev_ops ksz9477_dev_ops;
 
 #endif
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 4d7834149d0c0..88446bc32465f 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -364,44 +364,6 @@ static const struct phylink_mac_ops ksz9477_phylink_mac_ops = {
 	.mac_select_pcs	= ksz_phylink_mac_select_pcs,
 };
 
-static const struct ksz_dev_ops ksz9477_dev_ops = {
-	.setup = ksz9477_setup,
-	.get_port_addr = ksz9477_get_port_addr,
-	.cfg_port_member = ksz9477_cfg_port_member,
-	.flush_dyn_mac_table = ksz9477_flush_dyn_mac_table,
-	.port_setup = ksz9477_port_setup,
-	.set_ageing_time = ksz9477_set_ageing_time,
-	.r_phy = ksz9477_r_phy,
-	.w_phy = ksz9477_w_phy,
-	.r_mib_cnt = ksz9477_r_mib_cnt,
-	.r_mib_pkt = ksz9477_r_mib_pkt,
-	.r_mib_stat64 = ksz_r_mib_stats64,
-	.freeze_mib = ksz9477_freeze_mib,
-	.port_init_cnt = ksz9477_port_init_cnt,
-	.vlan_filtering = ksz9477_port_vlan_filtering,
-	.vlan_add = ksz9477_port_vlan_add,
-	.vlan_del = ksz9477_port_vlan_del,
-	.mirror_add = ksz9477_port_mirror_add,
-	.mirror_del = ksz9477_port_mirror_del,
-	.get_caps = ksz9477_get_caps,
-	.fdb_dump = ksz9477_fdb_dump,
-	.fdb_add = ksz9477_fdb_add,
-	.fdb_del = ksz9477_fdb_del,
-	.mdb_add = ksz9477_mdb_add,
-	.mdb_del = ksz9477_mdb_del,
-	.change_mtu = ksz9477_change_mtu,
-	.pme_write8 = ksz_write8,
-	.pme_pread8 = ksz_pread8,
-	.pme_pwrite8 = ksz_pwrite8,
-	.config_cpu_port = ksz9477_config_cpu_port,
-	.tc_cbs_set_cinc = ksz9477_tc_cbs_set_cinc,
-	.enable_stp_addr = ksz9477_enable_stp_addr,
-	.reset = ksz9477_reset_switch,
-	.init = ksz9477_switch_init,
-	.exit = ksz9477_switch_exit,
-	.pcs_create = ksz9477_pcs_create,
-};
-
 static const struct phylink_mac_ops lan937x_phylink_mac_ops = {
 	.mac_config	= ksz_phylink_mac_config,
 	.mac_link_down	= ksz_phylink_mac_link_down,
@@ -410,44 +372,6 @@ static const struct phylink_mac_ops lan937x_phylink_mac_ops = {
 	.mac_enable_tx_lpi = ksz_phylink_mac_enable_tx_lpi,
 };
 
-static const struct ksz_dev_ops lan937x_dev_ops = {
-	.setup = lan937x_setup,
-	.teardown = lan937x_teardown,
-	.get_port_addr = ksz9477_get_port_addr,
-	.cfg_port_member = ksz9477_cfg_port_member,
-	.flush_dyn_mac_table = ksz9477_flush_dyn_mac_table,
-	.port_setup = lan937x_port_setup,
-	.set_ageing_time = lan937x_set_ageing_time,
-	.mdio_bus_preinit = lan937x_mdio_bus_preinit,
-	.create_phy_addr_map = lan937x_create_phy_addr_map,
-	.r_phy = lan937x_r_phy,
-	.w_phy = lan937x_w_phy,
-	.r_mib_cnt = ksz9477_r_mib_cnt,
-	.r_mib_pkt = ksz9477_r_mib_pkt,
-	.r_mib_stat64 = ksz_r_mib_stats64,
-	.freeze_mib = ksz9477_freeze_mib,
-	.port_init_cnt = ksz9477_port_init_cnt,
-	.vlan_filtering = ksz9477_port_vlan_filtering,
-	.vlan_add = ksz9477_port_vlan_add,
-	.vlan_del = ksz9477_port_vlan_del,
-	.mirror_add = ksz9477_port_mirror_add,
-	.mirror_del = ksz9477_port_mirror_del,
-	.get_caps = lan937x_phylink_get_caps,
-	.setup_rgmii_delay = lan937x_setup_rgmii_delay,
-	.fdb_dump = ksz9477_fdb_dump,
-	.fdb_add = ksz9477_fdb_add,
-	.fdb_del = ksz9477_fdb_del,
-	.mdb_add = ksz9477_mdb_add,
-	.mdb_del = ksz9477_mdb_del,
-	.change_mtu = lan937x_change_mtu,
-	.config_cpu_port = lan937x_config_cpu_port,
-	.tc_cbs_set_cinc = lan937x_tc_cbs_set_cinc,
-	.enable_stp_addr = ksz9477_enable_stp_addr,
-	.reset = lan937x_reset_switch,
-	.init = lan937x_switch_init,
-	.exit = lan937x_switch_exit,
-};
-
 static const u16 ksz8463_regs[] = {
 	[REG_SW_MAC_ADDR]		= 0x10,
 	[REG_IND_CTRL_0]		= 0x30,
diff --git a/drivers/net/dsa/microchip/lan937x.h b/drivers/net/dsa/microchip/lan937x.h
index df13ebbd356f9..48fc497750943 100644
--- a/drivers/net/dsa/microchip/lan937x.h
+++ b/drivers/net/dsa/microchip/lan937x.h
@@ -6,21 +6,6 @@
 #ifndef __LAN937X_CFG_H
 #define __LAN937X_CFG_H
 
-int lan937x_reset_switch(struct ksz_device *dev);
-int lan937x_setup(struct dsa_switch *ds);
-void lan937x_teardown(struct dsa_switch *ds);
-void lan937x_port_setup(struct ksz_device *dev, int port, bool cpu_port);
-void lan937x_config_cpu_port(struct dsa_switch *ds);
-int lan937x_switch_init(struct ksz_device *dev);
-void lan937x_switch_exit(struct ksz_device *dev);
-int lan937x_mdio_bus_preinit(struct ksz_device *dev, bool side_mdio);
-int lan937x_create_phy_addr_map(struct ksz_device *dev, bool side_mdio);
-int lan937x_r_phy(struct ksz_device *dev, u16 addr, u16 reg, u16 *data);
-int lan937x_w_phy(struct ksz_device *dev, u16 addr, u16 reg, u16 val);
-int lan937x_change_mtu(struct ksz_device *dev, int port, int new_mtu);
-void lan937x_phylink_get_caps(struct ksz_device *dev, int port,
-			      struct phylink_config *config);
-void lan937x_setup_rgmii_delay(struct ksz_device *dev, int port);
-int lan937x_set_ageing_time(struct ksz_device *dev, unsigned int msecs);
-int lan937x_tc_cbs_set_cinc(struct ksz_device *dev, int port, u32 val);
+extern const struct ksz_dev_ops lan937x_dev_ops;
+
 #endif
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index 5a1496fff4452..ced381f67392b 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -137,7 +137,7 @@ static int lan937x_port_cfg(struct ksz_device *dev, int port, int offset,
  *
  * Return: 0 on success, error code on failure.
  */
-int lan937x_create_phy_addr_map(struct ksz_device *dev, bool side_mdio)
+static int lan937x_create_phy_addr_map(struct ksz_device *dev, bool side_mdio)
 {
 	static const u8 *phy_addr_map;
 	u32 strap_val;
@@ -221,7 +221,7 @@ int lan937x_create_phy_addr_map(struct ksz_device *dev, bool side_mdio)
  *
  * Return: 0 on success, error code on failure.
  */
-int lan937x_mdio_bus_preinit(struct ksz_device *dev, bool side_mdio)
+static int lan937x_mdio_bus_preinit(struct ksz_device *dev, bool side_mdio)
 {
 	u16 data16;
 	int ret;
@@ -332,17 +332,17 @@ static int lan937x_internal_phy_read(struct ksz_device *dev, int addr, int reg,
 	return ksz_read16(dev, REG_VPHY_IND_DATA__2, val);
 }
 
-int lan937x_r_phy(struct ksz_device *dev, u16 addr, u16 reg, u16 *data)
+static int lan937x_r_phy(struct ksz_device *dev, u16 addr, u16 reg, u16 *data)
 {
 	return lan937x_internal_phy_read(dev, addr, reg, data);
 }
 
-int lan937x_w_phy(struct ksz_device *dev, u16 addr, u16 reg, u16 val)
+static int lan937x_w_phy(struct ksz_device *dev, u16 addr, u16 reg, u16 val)
 {
 	return lan937x_internal_phy_write(dev, addr, reg, val);
 }
 
-int lan937x_reset_switch(struct ksz_device *dev)
+static int lan937x_reset_switch(struct ksz_device *dev)
 {
 	u32 data32;
 	int ret;
@@ -373,7 +373,7 @@ int lan937x_reset_switch(struct ksz_device *dev)
 	return ksz_read32(dev, REG_SW_PORT_INT_STATUS__4, &data32);
 }
 
-void lan937x_port_setup(struct ksz_device *dev, int port, bool cpu_port)
+static void lan937x_port_setup(struct ksz_device *dev, int port, bool cpu_port)
 {
 	const u32 *masks = dev->info->masks;
 	const u16 *regs = dev->info->regs;
@@ -409,7 +409,7 @@ void lan937x_port_setup(struct ksz_device *dev, int port, bool cpu_port)
 	dev->dev_ops->cfg_port_member(dev, port, member);
 }
 
-void lan937x_config_cpu_port(struct dsa_switch *ds)
+static void lan937x_config_cpu_port(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
 	struct dsa_port *dp;
@@ -428,7 +428,7 @@ void lan937x_config_cpu_port(struct dsa_switch *ds)
 	}
 }
 
-int lan937x_change_mtu(struct ksz_device *dev, int port, int new_mtu)
+static int lan937x_change_mtu(struct ksz_device *dev, int port, int new_mtu)
 {
 	struct dsa_switch *ds = dev->ds;
 	int ret;
@@ -459,7 +459,7 @@ int lan937x_change_mtu(struct ksz_device *dev, int port, int new_mtu)
 	return 0;
 }
 
-int lan937x_set_ageing_time(struct ksz_device *dev, unsigned int msecs)
+static int lan937x_set_ageing_time(struct ksz_device *dev, unsigned int msecs)
 {
 	u8 data, mult, value8;
 	bool in_msec = false;
@@ -572,8 +572,8 @@ static void lan937x_set_rgmii_rx_delay(struct ksz_device *dev, int port)
 	lan937x_set_tune_adj(dev, port, REG_PORT_XMII_CTRL_4, val);
 }
 
-void lan937x_phylink_get_caps(struct ksz_device *dev, int port,
-			      struct phylink_config *config)
+static void lan937x_phylink_get_caps(struct ksz_device *dev, int port,
+				     struct phylink_config *config)
 {
 	config->mac_capabilities = MAC_100FD;
 
@@ -587,7 +587,7 @@ void lan937x_phylink_get_caps(struct ksz_device *dev, int port,
 	}
 }
 
-void lan937x_setup_rgmii_delay(struct ksz_device *dev, int port)
+static void lan937x_setup_rgmii_delay(struct ksz_device *dev, int port)
 {
 	struct ksz_port *p = &dev->ports[port];
 
@@ -604,19 +604,19 @@ void lan937x_setup_rgmii_delay(struct ksz_device *dev, int port)
 	}
 }
 
-int lan937x_tc_cbs_set_cinc(struct ksz_device *dev, int port, u32 val)
+static int lan937x_tc_cbs_set_cinc(struct ksz_device *dev, int port, u32 val)
 {
 	return ksz_pwrite32(dev, port, REG_PORT_MTI_CREDIT_INCREMENT, val);
 }
 
-int lan937x_switch_init(struct ksz_device *dev)
+static int lan937x_switch_init(struct ksz_device *dev)
 {
 	dev->port_mask = (1 << dev->info->port_cnt) - 1;
 
 	return 0;
 }
 
-int lan937x_setup(struct dsa_switch *ds)
+static int lan937x_setup(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
 	int ret;
@@ -656,16 +656,54 @@ int lan937x_setup(struct dsa_switch *ds)
 			 SW_VPHY_DISABLE);
 }
 
-void lan937x_teardown(struct dsa_switch *ds)
+static void lan937x_teardown(struct dsa_switch *ds)
 {
 
 }
 
-void lan937x_switch_exit(struct ksz_device *dev)
+static void lan937x_switch_exit(struct ksz_device *dev)
 {
 	lan937x_reset_switch(dev);
 }
 
+const struct ksz_dev_ops lan937x_dev_ops = {
+	.setup = lan937x_setup,
+	.teardown = lan937x_teardown,
+	.get_port_addr = ksz9477_get_port_addr,
+	.cfg_port_member = ksz9477_cfg_port_member,
+	.flush_dyn_mac_table = ksz9477_flush_dyn_mac_table,
+	.port_setup = lan937x_port_setup,
+	.set_ageing_time = lan937x_set_ageing_time,
+	.mdio_bus_preinit = lan937x_mdio_bus_preinit,
+	.create_phy_addr_map = lan937x_create_phy_addr_map,
+	.r_phy = lan937x_r_phy,
+	.w_phy = lan937x_w_phy,
+	.r_mib_cnt = ksz9477_r_mib_cnt,
+	.r_mib_pkt = ksz9477_r_mib_pkt,
+	.r_mib_stat64 = ksz_r_mib_stats64,
+	.freeze_mib = ksz9477_freeze_mib,
+	.port_init_cnt = ksz9477_port_init_cnt,
+	.vlan_filtering = ksz9477_port_vlan_filtering,
+	.vlan_add = ksz9477_port_vlan_add,
+	.vlan_del = ksz9477_port_vlan_del,
+	.mirror_add = ksz9477_port_mirror_add,
+	.mirror_del = ksz9477_port_mirror_del,
+	.get_caps = lan937x_phylink_get_caps,
+	.setup_rgmii_delay = lan937x_setup_rgmii_delay,
+	.fdb_dump = ksz9477_fdb_dump,
+	.fdb_add = ksz9477_fdb_add,
+	.fdb_del = ksz9477_fdb_del,
+	.mdb_add = ksz9477_mdb_add,
+	.mdb_del = ksz9477_mdb_del,
+	.change_mtu = lan937x_change_mtu,
+	.config_cpu_port = lan937x_config_cpu_port,
+	.tc_cbs_set_cinc = lan937x_tc_cbs_set_cinc,
+	.enable_stp_addr = ksz9477_enable_stp_addr,
+	.reset = lan937x_reset_switch,
+	.init = lan937x_switch_init,
+	.exit = lan937x_switch_exit,
+};
+
 MODULE_AUTHOR("Arun Ramadoss <arun.ramadoss@microchip.com>");
 MODULE_DESCRIPTION("Microchip LAN937x Series Switch DSA Driver");
 MODULE_LICENSE("GPL");

-- 
2.53.0


