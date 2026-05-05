Return-Path: <netdev+bounces-284437-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJj1GmD++WkqFwMAu9opvQ
	(envelope-from <netdev+bounces-284437-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 16:27:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE95B4CF616
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 16:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2AE73086624
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 14:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E49A480DD9;
	Tue,  5 May 2026 14:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lVmrpWeH"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC43480973
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777991126; cv=none; b=T2CVZehQj+Q3VEEaZBNrksQlaSgz4iMK6odsmBvhW93ZW2wXILoC2fn5KMw+gG7OcyvgR1J8q6ue58xiRd7g9ix9uw9X0p/XVXhCuqGnprU17OPcPkjitQ5R1ntZNoTMZbdsRMUZeSpBPAFqrI35pg1Ofqnr/aj3h8YSq6jXQ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777991126; c=relaxed/simple;
	bh=GiJmU/iMZGuZ0gtN9Ad8QuDwQwZItbL7voi4B9vH/I4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sMxzT8s/ol6ypOnJO13glqJcdLdGm4q92O2Uk3OwWLyzyPC2qfS89Jtnfts7IUUy2yzRdlusuomr9p7lBGjOsyUGackPI1CM5vBJliLzDQLWETob7GNskDEbRVgLaht/jqE047OLhY+Asd7bUidoDv6N5dKGRORZVJDg41692zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lVmrpWeH; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 955AF4E42BD4;
	Tue,  5 May 2026 14:25:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6B9356053C;
	Tue,  5 May 2026 14:25:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3BD4E11AD021C;
	Tue,  5 May 2026 16:25:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777991120; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/5FCPviE5XZM4VzoLg84JeO9P466x+p0MFBindOZ0Sk=;
	b=lVmrpWeHFvtFmtK5hS6/nKvFJOqIbjnvHtnL8y/6cyAAORfHB7mVvFTRQu2yG1OHIzwGlN
	b6CwADuXzVVFyXTNPA62Jp1d59JJTKaU0LmHGPn3i3LBRUlrOHawOyI7+EDE+je62BoA6W
	BGDfSUjDtGhVgDIqmAuQER+H2ap77t1kKZH2HiYK7PmmIw95Nzmk1qOgQYUCT6gnHhTsLN
	T4LI9G0CIS4G4QBDN0x3rDqdhConVQQpteSlVCaPuUR7ETnGX15qVzdbXTSxsihfbCn0qk
	sWIi6+ZHOQbDBnhUxBbvt8WElCw7w9q33Km5BaSEPpWTNoh7iCxfS319ZsV17g==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Tue, 05 May 2026 16:25:03 +0200
Subject: [PATCH net-next 3/9] net: dsa: microchip: move KSZ8 ksz_dev_ops to
 ksz8.c
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-clean-ksz-driver-v1-3-05d70fa42461@bootlin.com>
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
X-Rspamd-Queue-Id: DE95B4CF616
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
	TAGGED_FROM(0.00)[bounces-284437-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid,nxp.com:email]

From: Vladimir Oltean <vladimir.oltean@nxp.com>

The ksz_dev_ops() are specific to each switch family so they should
belong to the individual drivers instead of the common section.

Move the ksz_dev_ops() definitions of the KSZ8xxx to ksz8.c
Set static the functions that aren't exported anymore.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c       | 200 +++++++++++++++++++++++++--------
 drivers/net/dsa/microchip/ksz8.h       |  51 +--------
 drivers/net/dsa/microchip/ksz_common.c | 102 -----------------
 3 files changed, 155 insertions(+), 198 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index dc29b028f8409..56560f60223a1 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -114,26 +114,26 @@ static int ksz8_ind_read8(struct ksz_device *dev, u8 table, u16 addr, u8 *val)
 	return ret;
 }
 
-int ksz8_pme_write8(struct ksz_device *dev, u32 reg, u8 value)
+static int ksz8_pme_write8(struct ksz_device *dev, u32 reg, u8 value)
 {
 	return ksz8_ind_write8(dev, (u8)(reg >> 8), (u8)(reg), value);
 }
 
-int ksz8_pme_pread8(struct ksz_device *dev, int port, int offset, u8 *data)
+static int ksz8_pme_pread8(struct ksz_device *dev, int port, int offset, u8 *data)
 {
 	u8 table = (u8)(offset >> 8 | (port + 1));
 
 	return ksz8_ind_read8(dev, table, (u8)(offset), data);
 }
 
-int ksz8_pme_pwrite8(struct ksz_device *dev, int port, int offset, u8 data)
+static int ksz8_pme_pwrite8(struct ksz_device *dev, int port, int offset, u8 data)
 {
 	u8 table = (u8)(offset >> 8 | (port + 1));
 
 	return ksz8_ind_write8(dev, table, (u8)(offset), data);
 }
 
-int ksz8_reset_switch(struct ksz_device *dev)
+static int ksz8_reset_switch(struct ksz_device *dev)
 {
 	if (ksz_is_ksz88x3(dev)) {
 		/* reset switch */
@@ -186,7 +186,7 @@ static int ksz8795_change_mtu(struct ksz_device *dev, int frame_size)
 	return ksz_rmw8(dev, REG_SW_CTRL_2, SW_LEGAL_PACKET_DISABLE, ctrl2);
 }
 
-int ksz8_change_mtu(struct ksz_device *dev, int port, int mtu)
+static int ksz8_change_mtu(struct ksz_device *dev, int port, int mtu)
 {
 	u16 frame_size;
 
@@ -267,7 +267,7 @@ static int ksz8_port_queue_split(struct ksz_device *dev, int port, int queues)
 	return ksz_prmw8(dev, port, reg_2q, mask_2q, data_2q);
 }
 
-void ksz8_r_mib_cnt(struct ksz_device *dev, int port, u16 addr, u64 *cnt)
+static void ksz8_r_mib_cnt(struct ksz_device *dev, int port, u16 addr, u64 *cnt)
 {
 	const u32 *masks;
 	const u16 *regs;
@@ -390,8 +390,8 @@ static void ksz8863_r_mib_pkt(struct ksz_device *dev, int port, u16 addr,
 	}
 }
 
-void ksz8_r_mib_pkt(struct ksz_device *dev, int port, u16 addr,
-		    u64 *dropped, u64 *cnt)
+static void ksz8_r_mib_pkt(struct ksz_device *dev, int port, u16 addr,
+			   u64 *dropped, u64 *cnt)
 {
 	if (is_ksz88xx(dev))
 		ksz8863_r_mib_pkt(dev, port, addr, dropped, cnt);
@@ -399,7 +399,7 @@ void ksz8_r_mib_pkt(struct ksz_device *dev, int port, u16 addr,
 		ksz8795_r_mib_pkt(dev, port, addr, dropped, cnt);
 }
 
-void ksz8_freeze_mib(struct ksz_device *dev, int port, bool freeze)
+static void ksz8_freeze_mib(struct ksz_device *dev, int port, bool freeze)
 {
 	if (is_ksz88xx(dev))
 		return;
@@ -414,7 +414,7 @@ void ksz8_freeze_mib(struct ksz_device *dev, int port, bool freeze)
 		ksz_cfg(dev, REG_SW_CTRL_6, BIT(port), false);
 }
 
-void ksz8_port_init_cnt(struct ksz_device *dev, int port)
+static void ksz8_port_init_cnt(struct ksz_device *dev, int port)
 {
 	struct ksz_port_mib *mib = &dev->ports[port].mib;
 	u64 *dropped;
@@ -939,7 +939,7 @@ static int ksz8_r_phy_bmcr(struct ksz_device *dev, u16 port, u16 *val)
 	return 0;
 }
 
-int ksz8_r_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 *val)
+static int ksz8_r_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 *val)
 {
 	u8 ctrl, link, val1, val2;
 	int processed = true;
@@ -1203,7 +1203,7 @@ static int ksz8_w_phy_bmcr(struct ksz_device *dev, u16 port, u16 val)
 			 restart);
 }
 
-int ksz8_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
+static int ksz8_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
 {
 	const u16 *regs;
 	u8 ctrl, data;
@@ -1263,7 +1263,7 @@ int ksz8_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
 	return 0;
 }
 
-void ksz8_cfg_port_member(struct ksz_device *dev, int port, u8 member)
+static void ksz8_cfg_port_member(struct ksz_device *dev, int port, u8 member)
 {
 	int offset = P_MIRROR_CTRL;
 	u8 data;
@@ -1276,7 +1276,7 @@ void ksz8_cfg_port_member(struct ksz_device *dev, int port, u8 member)
 	ksz_pwrite8(dev, port, offset, data);
 }
 
-void ksz8_flush_dyn_mac_table(struct ksz_device *dev, int port)
+static void ksz8_flush_dyn_mac_table(struct ksz_device *dev, int port)
 {
 	u8 learn[DSA_MAX_PORTS];
 	int first, index, cnt;
@@ -1311,8 +1311,8 @@ void ksz8_flush_dyn_mac_table(struct ksz_device *dev, int port)
 	}
 }
 
-int ksz8_fdb_dump(struct ksz_device *dev, int port,
-		  dsa_fdb_dump_cb_t *cb, void *data)
+static int ksz8_fdb_dump(struct ksz_device *dev, int port,
+			 dsa_fdb_dump_cb_t *cb, void *data)
 {
 	u8 mac[ETH_ALEN];
 	u8 src_port, fid;
@@ -1416,32 +1416,34 @@ static int ksz8_del_sta_mac(struct ksz_device *dev, int port,
 	return ksz8_w_sta_mac_table(dev, index, &alu);
 }
 
-int ksz8_mdb_add(struct ksz_device *dev, int port,
-		 const struct switchdev_obj_port_mdb *mdb, struct dsa_db db)
+static int ksz8_mdb_add(struct ksz_device *dev, int port,
+			const struct switchdev_obj_port_mdb *mdb,
+			struct dsa_db db)
 {
 	return ksz8_add_sta_mac(dev, port, mdb->addr, mdb->vid);
 }
 
-int ksz8_mdb_del(struct ksz_device *dev, int port,
-		 const struct switchdev_obj_port_mdb *mdb, struct dsa_db db)
+static int ksz8_mdb_del(struct ksz_device *dev, int port,
+			const struct switchdev_obj_port_mdb *mdb,
+			struct dsa_db db)
 {
 	return ksz8_del_sta_mac(dev, port, mdb->addr, mdb->vid);
 }
 
-int ksz8_fdb_add(struct ksz_device *dev, int port, const unsigned char *addr,
-		 u16 vid, struct dsa_db db)
+static int ksz8_fdb_add(struct ksz_device *dev, int port,
+			const unsigned char *addr, u16 vid, struct dsa_db db)
 {
 	return ksz8_add_sta_mac(dev, port, addr, vid);
 }
 
-int ksz8_fdb_del(struct ksz_device *dev, int port, const unsigned char *addr,
-		 u16 vid, struct dsa_db db)
+static int ksz8_fdb_del(struct ksz_device *dev, int port,
+			const unsigned char *addr, u16 vid, struct dsa_db db)
 {
 	return ksz8_del_sta_mac(dev, port, addr, vid);
 }
 
-int ksz8_port_vlan_filtering(struct ksz_device *dev, int port, bool flag,
-			     struct netlink_ext_ack *extack)
+static int ksz8_port_vlan_filtering(struct ksz_device *dev, int port, bool flag,
+				    struct netlink_ext_ack *extack)
 {
 	if (ksz_is_ksz88x3(dev) || ksz_is_ksz8463(dev))
 		return -ENOTSUPP;
@@ -1470,9 +1472,9 @@ static void ksz8_port_enable_pvid(struct ksz_device *dev, int port, bool state)
 	}
 }
 
-int ksz8_port_vlan_add(struct ksz_device *dev, int port,
-		       const struct switchdev_obj_port_vlan *vlan,
-		       struct netlink_ext_ack *extack)
+static int ksz8_port_vlan_add(struct ksz_device *dev, int port,
+			      const struct switchdev_obj_port_vlan *vlan,
+			      struct netlink_ext_ack *extack)
 {
 	bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
 	struct ksz_port *p = &dev->ports[port];
@@ -1542,8 +1544,8 @@ int ksz8_port_vlan_add(struct ksz_device *dev, int port,
 	return 0;
 }
 
-int ksz8_port_vlan_del(struct ksz_device *dev, int port,
-		       const struct switchdev_obj_port_vlan *vlan)
+static int ksz8_port_vlan_del(struct ksz_device *dev, int port,
+			      const struct switchdev_obj_port_vlan *vlan)
 {
 	u16 data, pvid;
 	u8 fid, member, valid;
@@ -1574,9 +1576,9 @@ int ksz8_port_vlan_del(struct ksz_device *dev, int port,
 	return 0;
 }
 
-int ksz8_port_mirror_add(struct ksz_device *dev, int port,
-			 struct dsa_mall_mirror_tc_entry *mirror,
-			 bool ingress, struct netlink_ext_ack *extack)
+static int ksz8_port_mirror_add(struct ksz_device *dev, int port,
+				struct dsa_mall_mirror_tc_entry *mirror,
+				bool ingress, struct netlink_ext_ack *extack)
 {
 	int offset = P_MIRROR_CTRL;
 
@@ -1600,8 +1602,8 @@ int ksz8_port_mirror_add(struct ksz_device *dev, int port,
 	return 0;
 }
 
-void ksz8_port_mirror_del(struct ksz_device *dev, int port,
-			  struct dsa_mall_mirror_tc_entry *mirror)
+static void ksz8_port_mirror_del(struct ksz_device *dev, int port,
+				 struct dsa_mall_mirror_tc_entry *mirror)
 {
 	int offset = P_MIRROR_CTRL;
 	u8 data;
@@ -1639,7 +1641,7 @@ static void ksz8795_cpu_interface_select(struct ksz_device *dev, int port)
 	}
 }
 
-void ksz8_port_setup(struct ksz_device *dev, int port, bool cpu_port)
+static void ksz8_port_setup(struct ksz_device *dev, int port, bool cpu_port)
 {
 	const u16 *regs = dev->info->regs;
 	struct dsa_switch *ds = dev->ds;
@@ -1694,7 +1696,7 @@ static void ksz88x3_config_rmii_clk(struct ksz_device *dev)
 		KSZ88X3_PORT3_RMII_CLK_INTERNAL, rmii_clk_internal);
 }
 
-void ksz8_config_cpu_port(struct dsa_switch *ds)
+static void ksz8_config_cpu_port(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
 	struct ksz_port *p;
@@ -1903,7 +1905,7 @@ static int ksz8_handle_global_errata(struct dsa_switch *ds)
 	return ret;
 }
 
-int ksz8_enable_stp_addr(struct ksz_device *dev)
+static int ksz8_enable_stp_addr(struct ksz_device *dev)
 {
 	struct alu_struct alu;
 
@@ -1917,7 +1919,7 @@ int ksz8_enable_stp_addr(struct ksz_device *dev)
 	return ksz8_w_sta_mac_table(dev, 0, &alu);
 }
 
-int ksz8_setup(struct dsa_switch *ds)
+static int ksz8_setup(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
 	const u16 *regs = dev->info->regs;
@@ -1980,8 +1982,8 @@ int ksz8_setup(struct dsa_switch *ds)
 		return ret;
 }
 
-void ksz8_get_caps(struct ksz_device *dev, int port,
-		   struct phylink_config *config)
+static void ksz8_get_caps(struct ksz_device *dev, int port,
+			  struct phylink_config *config)
 {
 	config->mac_capabilities = MAC_10 | MAC_100;
 
@@ -1998,12 +2000,12 @@ void ksz8_get_caps(struct ksz_device *dev, int port,
 		config->mac_capabilities |= MAC_ASYM_PAUSE;
 }
 
-u32 ksz8_get_port_addr(int port, int offset)
+static u32 ksz8_get_port_addr(int port, int offset)
 {
 	return PORT_CTRL_ADDR(port, offset);
 }
 
-u32 ksz8463_get_port_addr(int port, int offset)
+static u32 ksz8463_get_port_addr(int port, int offset)
 {
 	return offset + 0x18 * port;
 }
@@ -2013,7 +2015,7 @@ static u16 ksz8463_get_phy_addr(u16 phy, u16 reg, u16 offset)
 	return offset + reg * 2 + phy * (P2MBCR - P1MBCR);
 }
 
-int ksz8463_r_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 *val)
+static int ksz8463_r_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 *val)
 {
 	u16 sw_reg = 0;
 	u16 data = 0;
@@ -2053,7 +2055,7 @@ int ksz8463_r_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 *val)
 	return 0;
 }
 
-int ksz8463_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
+static int ksz8463_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
 {
 	u16 sw_reg = 0;
 	int ret;
@@ -2081,7 +2083,7 @@ int ksz8463_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
 	return 0;
 }
 
-int ksz8_switch_init(struct ksz_device *dev)
+static int ksz8_switch_init(struct ksz_device *dev)
 {
 	dev->cpu_port = fls(dev->info->cpu_ports) - 1;
 	dev->phy_port_cnt = dev->info->port_cnt - 1;
@@ -2090,11 +2092,113 @@ int ksz8_switch_init(struct ksz_device *dev)
 	return 0;
 }
 
-void ksz8_switch_exit(struct ksz_device *dev)
+static void ksz8_switch_exit(struct ksz_device *dev)
 {
 	ksz8_reset_switch(dev);
 }
 
+const struct ksz_dev_ops ksz8463_dev_ops = {
+	.setup = ksz8_setup,
+	.get_port_addr = ksz8463_get_port_addr,
+	.cfg_port_member = ksz8_cfg_port_member,
+	.flush_dyn_mac_table = ksz8_flush_dyn_mac_table,
+	.port_setup = ksz8_port_setup,
+	.r_phy = ksz8463_r_phy,
+	.w_phy = ksz8463_w_phy,
+	.r_mib_cnt = ksz8_r_mib_cnt,
+	.r_mib_pkt = ksz8_r_mib_pkt,
+	.r_mib_stat64 = ksz88xx_r_mib_stats64,
+	.freeze_mib = ksz8_freeze_mib,
+	.port_init_cnt = ksz8_port_init_cnt,
+	.fdb_dump = ksz8_fdb_dump,
+	.fdb_add = ksz8_fdb_add,
+	.fdb_del = ksz8_fdb_del,
+	.mdb_add = ksz8_mdb_add,
+	.mdb_del = ksz8_mdb_del,
+	.vlan_filtering = ksz8_port_vlan_filtering,
+	.vlan_add = ksz8_port_vlan_add,
+	.vlan_del = ksz8_port_vlan_del,
+	.mirror_add = ksz8_port_mirror_add,
+	.mirror_del = ksz8_port_mirror_del,
+	.get_caps = ksz8_get_caps,
+	.config_cpu_port = ksz8_config_cpu_port,
+	.enable_stp_addr = ksz8_enable_stp_addr,
+	.reset = ksz8_reset_switch,
+	.init = ksz8_switch_init,
+	.exit = ksz8_switch_exit,
+	.change_mtu = ksz8_change_mtu,
+};
+
+const struct ksz_dev_ops ksz87xx_dev_ops = {
+	.setup = ksz8_setup,
+	.get_port_addr = ksz8_get_port_addr,
+	.cfg_port_member = ksz8_cfg_port_member,
+	.flush_dyn_mac_table = ksz8_flush_dyn_mac_table,
+	.port_setup = ksz8_port_setup,
+	.r_phy = ksz8_r_phy,
+	.w_phy = ksz8_w_phy,
+	.r_mib_cnt = ksz8_r_mib_cnt,
+	.r_mib_pkt = ksz8_r_mib_pkt,
+	.r_mib_stat64 = ksz_r_mib_stats64,
+	.freeze_mib = ksz8_freeze_mib,
+	.port_init_cnt = ksz8_port_init_cnt,
+	.fdb_dump = ksz8_fdb_dump,
+	.fdb_add = ksz8_fdb_add,
+	.fdb_del = ksz8_fdb_del,
+	.mdb_add = ksz8_mdb_add,
+	.mdb_del = ksz8_mdb_del,
+	.vlan_filtering = ksz8_port_vlan_filtering,
+	.vlan_add = ksz8_port_vlan_add,
+	.vlan_del = ksz8_port_vlan_del,
+	.mirror_add = ksz8_port_mirror_add,
+	.mirror_del = ksz8_port_mirror_del,
+	.get_caps = ksz8_get_caps,
+	.config_cpu_port = ksz8_config_cpu_port,
+	.enable_stp_addr = ksz8_enable_stp_addr,
+	.reset = ksz8_reset_switch,
+	.init = ksz8_switch_init,
+	.exit = ksz8_switch_exit,
+	.change_mtu = ksz8_change_mtu,
+	.pme_write8 = ksz8_pme_write8,
+	.pme_pread8 = ksz8_pme_pread8,
+	.pme_pwrite8 = ksz8_pme_pwrite8,
+};
+
+const struct ksz_dev_ops ksz88xx_dev_ops = {
+	.setup = ksz8_setup,
+	.get_port_addr = ksz8_get_port_addr,
+	.cfg_port_member = ksz8_cfg_port_member,
+	.flush_dyn_mac_table = ksz8_flush_dyn_mac_table,
+	.port_setup = ksz8_port_setup,
+	.r_phy = ksz8_r_phy,
+	.w_phy = ksz8_w_phy,
+	.r_mib_cnt = ksz8_r_mib_cnt,
+	.r_mib_pkt = ksz8_r_mib_pkt,
+	.r_mib_stat64 = ksz88xx_r_mib_stats64,
+	.freeze_mib = ksz8_freeze_mib,
+	.port_init_cnt = ksz8_port_init_cnt,
+	.fdb_dump = ksz8_fdb_dump,
+	.fdb_add = ksz8_fdb_add,
+	.fdb_del = ksz8_fdb_del,
+	.mdb_add = ksz8_mdb_add,
+	.mdb_del = ksz8_mdb_del,
+	.vlan_filtering = ksz8_port_vlan_filtering,
+	.vlan_add = ksz8_port_vlan_add,
+	.vlan_del = ksz8_port_vlan_del,
+	.mirror_add = ksz8_port_mirror_add,
+	.mirror_del = ksz8_port_mirror_del,
+	.get_caps = ksz8_get_caps,
+	.config_cpu_port = ksz8_config_cpu_port,
+	.enable_stp_addr = ksz8_enable_stp_addr,
+	.reset = ksz8_reset_switch,
+	.init = ksz8_switch_init,
+	.exit = ksz8_switch_exit,
+	.change_mtu = ksz8_change_mtu,
+	.pme_write8 = ksz8_pme_write8,
+	.pme_pread8 = ksz8_pme_pread8,
+	.pme_pwrite8 = ksz8_pme_pwrite8,
+};
+
 MODULE_AUTHOR("Tristram Ha <Tristram.Ha@microchip.com>");
 MODULE_DESCRIPTION("Microchip KSZ8795 Series Switch DSA Driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/dsa/microchip/ksz8.h b/drivers/net/dsa/microchip/ksz8.h
index 52b7d944d9d97..4b798ce29daaf 100644
--- a/drivers/net/dsa/microchip/ksz8.h
+++ b/drivers/net/dsa/microchip/ksz8.h
@@ -12,58 +12,13 @@
 #include <net/dsa.h>
 #include "ksz_common.h"
 
-int ksz8_setup(struct dsa_switch *ds);
-u32 ksz8_get_port_addr(int port, int offset);
-void ksz8_cfg_port_member(struct ksz_device *dev, int port, u8 member);
-void ksz8_flush_dyn_mac_table(struct ksz_device *dev, int port);
-void ksz8_port_setup(struct ksz_device *dev, int port, bool cpu_port);
-int ksz8_r_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 *val);
-int ksz8_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val);
-void ksz8_r_mib_cnt(struct ksz_device *dev, int port, u16 addr, u64 *cnt);
-void ksz8_r_mib_pkt(struct ksz_device *dev, int port, u16 addr,
-		    u64 *dropped, u64 *cnt);
-void ksz8_freeze_mib(struct ksz_device *dev, int port, bool freeze);
-void ksz8_port_init_cnt(struct ksz_device *dev, int port);
-int ksz8_fdb_dump(struct ksz_device *dev, int port,
-		  dsa_fdb_dump_cb_t *cb, void *data);
-int ksz8_fdb_add(struct ksz_device *dev, int port, const unsigned char *addr,
-		 u16 vid, struct dsa_db db);
-int ksz8_fdb_del(struct ksz_device *dev, int port, const unsigned char *addr,
-		 u16 vid, struct dsa_db db);
-int ksz8_mdb_add(struct ksz_device *dev, int port,
-		 const struct switchdev_obj_port_mdb *mdb, struct dsa_db db);
-int ksz8_mdb_del(struct ksz_device *dev, int port,
-		 const struct switchdev_obj_port_mdb *mdb, struct dsa_db db);
-int ksz8_port_vlan_filtering(struct ksz_device *dev, int port, bool flag,
-			     struct netlink_ext_ack *extack);
-int ksz8_port_vlan_add(struct ksz_device *dev, int port,
-		       const struct switchdev_obj_port_vlan *vlan,
-		       struct netlink_ext_ack *extack);
-int ksz8_port_vlan_del(struct ksz_device *dev, int port,
-		       const struct switchdev_obj_port_vlan *vlan);
-int ksz8_port_mirror_add(struct ksz_device *dev, int port,
-			 struct dsa_mall_mirror_tc_entry *mirror,
-			 bool ingress, struct netlink_ext_ack *extack);
-void ksz8_port_mirror_del(struct ksz_device *dev, int port,
-			  struct dsa_mall_mirror_tc_entry *mirror);
-void ksz8_get_caps(struct ksz_device *dev, int port,
-		   struct phylink_config *config);
-void ksz8_config_cpu_port(struct dsa_switch *ds);
-int ksz8_enable_stp_addr(struct ksz_device *dev);
-int ksz8_reset_switch(struct ksz_device *dev);
-int ksz8_switch_init(struct ksz_device *dev);
-void ksz8_switch_exit(struct ksz_device *dev);
-int ksz8_change_mtu(struct ksz_device *dev, int port, int mtu);
-int ksz8_pme_write8(struct ksz_device *dev, u32 reg, u8 value);
-int ksz8_pme_pread8(struct ksz_device *dev, int port, int offset, u8 *data);
-int ksz8_pme_pwrite8(struct ksz_device *dev, int port, int offset, u8 data);
 void ksz8_phylink_mac_link_up(struct phylink_config *config,
 			      struct phy_device *phydev, unsigned int mode,
 			      phy_interface_t interface, int speed, int duplex,
 			      bool tx_pause, bool rx_pause);
 
-u32 ksz8463_get_port_addr(int port, int offset);
-int ksz8463_r_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 *val);
-int ksz8463_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val);
+extern const struct ksz_dev_ops ksz8463_dev_ops;
+extern const struct ksz_dev_ops ksz87xx_dev_ops;
+extern const struct ksz_dev_ops ksz88xx_dev_ops;
 
 #endif
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 144373e13bea3..4d7834149d0c0 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -332,108 +332,6 @@ static const struct phylink_mac_ops ksz8_phylink_mac_ops = {
 	.mac_enable_tx_lpi = ksz_phylink_mac_enable_tx_lpi,
 };
 
-static const struct ksz_dev_ops ksz8463_dev_ops = {
-	.setup = ksz8_setup,
-	.get_port_addr = ksz8463_get_port_addr,
-	.cfg_port_member = ksz8_cfg_port_member,
-	.flush_dyn_mac_table = ksz8_flush_dyn_mac_table,
-	.port_setup = ksz8_port_setup,
-	.r_phy = ksz8463_r_phy,
-	.w_phy = ksz8463_w_phy,
-	.r_mib_cnt = ksz8_r_mib_cnt,
-	.r_mib_pkt = ksz8_r_mib_pkt,
-	.r_mib_stat64 = ksz88xx_r_mib_stats64,
-	.freeze_mib = ksz8_freeze_mib,
-	.port_init_cnt = ksz8_port_init_cnt,
-	.fdb_dump = ksz8_fdb_dump,
-	.fdb_add = ksz8_fdb_add,
-	.fdb_del = ksz8_fdb_del,
-	.mdb_add = ksz8_mdb_add,
-	.mdb_del = ksz8_mdb_del,
-	.vlan_filtering = ksz8_port_vlan_filtering,
-	.vlan_add = ksz8_port_vlan_add,
-	.vlan_del = ksz8_port_vlan_del,
-	.mirror_add = ksz8_port_mirror_add,
-	.mirror_del = ksz8_port_mirror_del,
-	.get_caps = ksz8_get_caps,
-	.config_cpu_port = ksz8_config_cpu_port,
-	.enable_stp_addr = ksz8_enable_stp_addr,
-	.reset = ksz8_reset_switch,
-	.init = ksz8_switch_init,
-	.exit = ksz8_switch_exit,
-	.change_mtu = ksz8_change_mtu,
-};
-
-static const struct ksz_dev_ops ksz88xx_dev_ops = {
-	.setup = ksz8_setup,
-	.get_port_addr = ksz8_get_port_addr,
-	.cfg_port_member = ksz8_cfg_port_member,
-	.flush_dyn_mac_table = ksz8_flush_dyn_mac_table,
-	.port_setup = ksz8_port_setup,
-	.r_phy = ksz8_r_phy,
-	.w_phy = ksz8_w_phy,
-	.r_mib_cnt = ksz8_r_mib_cnt,
-	.r_mib_pkt = ksz8_r_mib_pkt,
-	.r_mib_stat64 = ksz88xx_r_mib_stats64,
-	.freeze_mib = ksz8_freeze_mib,
-	.port_init_cnt = ksz8_port_init_cnt,
-	.fdb_dump = ksz8_fdb_dump,
-	.fdb_add = ksz8_fdb_add,
-	.fdb_del = ksz8_fdb_del,
-	.mdb_add = ksz8_mdb_add,
-	.mdb_del = ksz8_mdb_del,
-	.vlan_filtering = ksz8_port_vlan_filtering,
-	.vlan_add = ksz8_port_vlan_add,
-	.vlan_del = ksz8_port_vlan_del,
-	.mirror_add = ksz8_port_mirror_add,
-	.mirror_del = ksz8_port_mirror_del,
-	.get_caps = ksz8_get_caps,
-	.config_cpu_port = ksz8_config_cpu_port,
-	.enable_stp_addr = ksz8_enable_stp_addr,
-	.reset = ksz8_reset_switch,
-	.init = ksz8_switch_init,
-	.exit = ksz8_switch_exit,
-	.change_mtu = ksz8_change_mtu,
-	.pme_write8 = ksz8_pme_write8,
-	.pme_pread8 = ksz8_pme_pread8,
-	.pme_pwrite8 = ksz8_pme_pwrite8,
-};
-
-static const struct ksz_dev_ops ksz87xx_dev_ops = {
-	.setup = ksz8_setup,
-	.get_port_addr = ksz8_get_port_addr,
-	.cfg_port_member = ksz8_cfg_port_member,
-	.flush_dyn_mac_table = ksz8_flush_dyn_mac_table,
-	.port_setup = ksz8_port_setup,
-	.r_phy = ksz8_r_phy,
-	.w_phy = ksz8_w_phy,
-	.r_mib_cnt = ksz8_r_mib_cnt,
-	.r_mib_pkt = ksz8_r_mib_pkt,
-	.r_mib_stat64 = ksz_r_mib_stats64,
-	.freeze_mib = ksz8_freeze_mib,
-	.port_init_cnt = ksz8_port_init_cnt,
-	.fdb_dump = ksz8_fdb_dump,
-	.fdb_add = ksz8_fdb_add,
-	.fdb_del = ksz8_fdb_del,
-	.mdb_add = ksz8_mdb_add,
-	.mdb_del = ksz8_mdb_del,
-	.vlan_filtering = ksz8_port_vlan_filtering,
-	.vlan_add = ksz8_port_vlan_add,
-	.vlan_del = ksz8_port_vlan_del,
-	.mirror_add = ksz8_port_mirror_add,
-	.mirror_del = ksz8_port_mirror_del,
-	.get_caps = ksz8_get_caps,
-	.config_cpu_port = ksz8_config_cpu_port,
-	.enable_stp_addr = ksz8_enable_stp_addr,
-	.reset = ksz8_reset_switch,
-	.init = ksz8_switch_init,
-	.exit = ksz8_switch_exit,
-	.change_mtu = ksz8_change_mtu,
-	.pme_write8 = ksz8_pme_write8,
-	.pme_pread8 = ksz8_pme_pread8,
-	.pme_pwrite8 = ksz8_pme_pwrite8,
-};
-
 static void ksz9477_phylink_mac_link_up(struct phylink_config *config,
 					struct phy_device *phydev,
 					unsigned int mode,

-- 
2.53.0


