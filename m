Return-Path: <netdev+bounces-287137-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANTIOlQqA2qw1AEAu9opvQ
	(envelope-from <netdev+bounces-287137-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:25:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9A15211E2
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 022FE3339230
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E7F3AA9CF;
	Tue, 12 May 2026 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NxvLNcoi"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9663A8394;
	Tue, 12 May 2026 13:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591207; cv=none; b=d5ENlTqxOp364296gnl5hVSkrQ2tK6hblo+kkbHTTjO5+S8AlIcwAG8tsVk1QCq56gn3t+vff1ntqScxq8Sdg4VIYa5x3x4PO+YhIKbn9ymx9SWLppOO6zuknvczzBhRGSPdz8YAkh/HUQmIqnkpc4NxbaWD2mRNJ0y9nXeSosw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591207; c=relaxed/simple;
	bh=zrG7OnJ8FAqW9inZV1Xnuwu3wfypryhSZi3QxYxj4fY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TBC8FMJ0ErywNKrQeUBC5UxjD+Wi6qpM4inPPN5UV+9yNfRRE7k2Vt9uDZVTlJHWtIESBB0DTaBmzFpBr143a8HyTO04MQ0Afddg2QPXGFcmlzGnZYNutSx/vjCs/XRoFQzytYRTBHodRZEXunvBQVe6zRSw3MApUG48YklGwbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NxvLNcoi; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 740C01A357C;
	Tue, 12 May 2026 13:06:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4798060646;
	Tue, 12 May 2026 13:06:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5B1EE11AF876D;
	Tue, 12 May 2026 15:06:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778591203; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=bNSGVI/sPc42OgzF8eEDnrj+ujuWgH0NzgeCRtD/N68=;
	b=NxvLNcoiy5k0BMFWtG3XbAqEowBD01dp2at2Cc91gd27VonU717nXqkxD8Eb+2H4BZm4a2
	Eyotl8ZCD2CAK4aIPieOphgztDooOOq+OgYVUPNDUHsXEszpJVnZXxACuLo5BRB2d3skVL
	XaxvK+fkhPKHfsZMyk0bceXQXDSnhOYWH9DU2tl4F1yRdsVkbSCSd6iIFQp4ADI4vGs/jU
	pDmhzeixpdcJhMpCBzn1W9YYI0gw5seuGo7W6K23EbPcq4b+31ejppcRJTGIzR/Py1Ooz9
	R1VO7L07q2opKNMX49oOvipsN94lUUJrFezUKiime4+LzY17SB5ih3XFExGmkA==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Tue, 12 May 2026 15:06:26 +0200
Subject: [PATCH net-next 04/15] net: dsa: microchip: bypass dev_ops for
 VLAN operations
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-clean-ksz-2nd-series-v1-4-c00f6ce037fa@bootlin.com>
References: <20260512-clean-ksz-2nd-series-v1-0-c00f6ce037fa@bootlin.com>
In-Reply-To: <20260512-clean-ksz-2nd-series-v1-0-c00f6ce037fa@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 4F9A15211E2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287137-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,nxp.com:email]
X-Rspamd-Action: no action

From: Vladimir Oltean <vladimir.oltean@nxp.com>

VLAN operations are handled through a common function that redirects the
treatment to ksz_dev_ops callbacks. This level of indirection isn't
needed since we now have a dsa_switch_ops for each kind of switch.

Remove this useless layer of indirection by connecting directly the VLAN
operations to the relevant dsa_switch_ops.
Adapt their prototypes to match dsa_switch_ops expectations.
Remove the now unused VLAN callbacks from ksz_dev_ops.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c         | 39 ++++++++++++++------------------
 drivers/net/dsa/microchip/ksz9477.c      | 21 +++++++++--------
 drivers/net/dsa/microchip/ksz9477.h      |  6 ++---
 drivers/net/dsa/microchip/ksz_common.c   | 34 ----------------------------
 drivers/net/dsa/microchip/ksz_common.h   | 14 ------------
 drivers/net/dsa/microchip/lan937x_main.c |  9 +++-----
 6 files changed, 34 insertions(+), 89 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index dd603e7f1a639..94c8034a192a9 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -1446,9 +1446,11 @@ static int ksz8_fdb_del(struct ksz_device *dev, int port,
 	return ksz8_del_sta_mac(dev, port, addr, vid);
 }
 
-static int ksz8_port_vlan_filtering(struct ksz_device *dev, int port, bool flag,
+static int ksz8_port_vlan_filtering(struct dsa_switch *ds, int port, bool flag,
 				    struct netlink_ext_ack *extack)
 {
+	struct ksz_device *dev = ds->priv;
+
 	if (ksz_is_ksz88x3(dev) || ksz_is_ksz8463(dev))
 		return -ENOTSUPP;
 
@@ -1476,11 +1478,12 @@ static void ksz8_port_enable_pvid(struct ksz_device *dev, int port, bool state)
 	}
 }
 
-static int ksz8_port_vlan_add(struct ksz_device *dev, int port,
+static int ksz8_port_vlan_add(struct dsa_switch *ds, int port,
 			      const struct switchdev_obj_port_vlan *vlan,
 			      struct netlink_ext_ack *extack)
 {
 	bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
+	struct ksz_device *dev = ds->priv;
 	struct ksz_port *p = &dev->ports[port];
 	u16 data, new_pvid = 0;
 	u8 fid, member, valid;
@@ -1548,11 +1551,12 @@ static int ksz8_port_vlan_add(struct ksz_device *dev, int port,
 	return 0;
 }
 
-static int ksz8_port_vlan_del(struct ksz_device *dev, int port,
+static int ksz8_port_vlan_del(struct dsa_switch *ds, int port,
 			      const struct switchdev_obj_port_vlan *vlan)
 {
-	u16 data, pvid;
+	struct ksz_device *dev = ds->priv;
 	u8 fid, member, valid;
+	u16 data, pvid;
 
 	if (ksz_is_ksz88x3(dev) || ksz_is_ksz8463(dev))
 		return -ENOTSUPP;
@@ -2216,9 +2220,6 @@ const struct ksz_dev_ops ksz8463_dev_ops = {
 	.fdb_del = ksz8_fdb_del,
 	.mdb_add = ksz8_mdb_add,
 	.mdb_del = ksz8_mdb_del,
-	.vlan_filtering = ksz8_port_vlan_filtering,
-	.vlan_add = ksz8_port_vlan_add,
-	.vlan_del = ksz8_port_vlan_del,
 	.mirror_add = ksz8_port_mirror_add,
 	.mirror_del = ksz8_port_mirror_del,
 	.get_caps = ksz8_get_caps,
@@ -2246,9 +2247,6 @@ const struct ksz_dev_ops ksz87xx_dev_ops = {
 	.fdb_del = ksz8_fdb_del,
 	.mdb_add = ksz8_mdb_add,
 	.mdb_del = ksz8_mdb_del,
-	.vlan_filtering = ksz8_port_vlan_filtering,
-	.vlan_add = ksz8_port_vlan_add,
-	.vlan_del = ksz8_port_vlan_del,
 	.mirror_add = ksz8_port_mirror_add,
 	.mirror_del = ksz8_port_mirror_del,
 	.get_caps = ksz8_get_caps,
@@ -2279,9 +2277,6 @@ const struct ksz_dev_ops ksz88xx_dev_ops = {
 	.fdb_del = ksz8_fdb_del,
 	.mdb_add = ksz8_mdb_add,
 	.mdb_del = ksz8_mdb_del,
-	.vlan_filtering = ksz8_port_vlan_filtering,
-	.vlan_add = ksz8_port_vlan_add,
-	.vlan_del = ksz8_port_vlan_del,
 	.mirror_add = ksz8_port_mirror_add,
 	.mirror_del = ksz8_port_mirror_del,
 	.get_caps = ksz8_get_caps,
@@ -2318,9 +2313,9 @@ const struct dsa_switch_ops ksz8463_switch_ops = {
 	.port_pre_bridge_flags	= ksz_port_pre_bridge_flags,
 	.port_bridge_flags	= ksz_port_bridge_flags,
 	.port_fast_age		= ksz8_flush_dyn_mac_table,
-	.port_vlan_filtering	= ksz_port_vlan_filtering,
-	.port_vlan_add		= ksz_port_vlan_add,
-	.port_vlan_del		= ksz_port_vlan_del,
+	.port_vlan_filtering	= ksz8_port_vlan_filtering,
+	.port_vlan_add		= ksz8_port_vlan_add,
+	.port_vlan_del		= ksz8_port_vlan_del,
 	.port_fdb_dump		= ksz_port_fdb_dump,
 	.port_fdb_add		= ksz_port_fdb_add,
 	.port_fdb_del		= ksz_port_fdb_del,
@@ -2378,9 +2373,9 @@ const struct dsa_switch_ops ksz87xx_switch_ops = {
 	.port_pre_bridge_flags	= ksz_port_pre_bridge_flags,
 	.port_bridge_flags	= ksz_port_bridge_flags,
 	.port_fast_age		= ksz8_flush_dyn_mac_table,
-	.port_vlan_filtering	= ksz_port_vlan_filtering,
-	.port_vlan_add		= ksz_port_vlan_add,
-	.port_vlan_del		= ksz_port_vlan_del,
+	.port_vlan_filtering	= ksz8_port_vlan_filtering,
+	.port_vlan_add		= ksz8_port_vlan_add,
+	.port_vlan_del		= ksz8_port_vlan_del,
 	.port_fdb_dump		= ksz_port_fdb_dump,
 	.port_fdb_add		= ksz_port_fdb_add,
 	.port_fdb_del		= ksz_port_fdb_del,
@@ -2438,9 +2433,9 @@ const struct dsa_switch_ops ksz88xx_switch_ops = {
 	.port_pre_bridge_flags	= ksz_port_pre_bridge_flags,
 	.port_bridge_flags	= ksz_port_bridge_flags,
 	.port_fast_age		= ksz8_flush_dyn_mac_table,
-	.port_vlan_filtering	= ksz_port_vlan_filtering,
-	.port_vlan_add		= ksz_port_vlan_add,
-	.port_vlan_del		= ksz_port_vlan_del,
+	.port_vlan_filtering	= ksz8_port_vlan_filtering,
+	.port_vlan_add		= ksz8_port_vlan_add,
+	.port_vlan_del		= ksz8_port_vlan_del,
 	.port_fdb_dump		= ksz_port_fdb_dump,
 	.port_fdb_add		= ksz_port_fdb_add,
 	.port_fdb_del		= ksz_port_fdb_del,
diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index f21a05a86b483..959229185df97 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -629,9 +629,11 @@ void ksz9477_flush_dyn_mac_table(struct dsa_switch *ds, int port)
 	}
 }
 
-int ksz9477_port_vlan_filtering(struct ksz_device *dev, int port,
+int ksz9477_port_vlan_filtering(struct dsa_switch *ds, int port,
 				bool flag, struct netlink_ext_ack *extack)
 {
+	struct ksz_device *dev = ds->priv;
+
 	if (flag) {
 		ksz_port_cfg(dev, port, REG_PORT_LUE_CTRL,
 			     PORT_VLAN_LOOKUP_VID_0, true);
@@ -645,12 +647,13 @@ int ksz9477_port_vlan_filtering(struct ksz_device *dev, int port,
 	return 0;
 }
 
-int ksz9477_port_vlan_add(struct ksz_device *dev, int port,
+int ksz9477_port_vlan_add(struct dsa_switch *ds, int port,
 			  const struct switchdev_obj_port_vlan *vlan,
 			  struct netlink_ext_ack *extack)
 {
-	u32 vlan_table[3];
 	bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
+	struct ksz_device *dev = ds->priv;
+	u32 vlan_table[3];
 	int err;
 
 	err = ksz9477_get_vlan_table(dev, vlan->vid, vlan_table);
@@ -681,10 +684,11 @@ int ksz9477_port_vlan_add(struct ksz_device *dev, int port,
 	return 0;
 }
 
-int ksz9477_port_vlan_del(struct ksz_device *dev, int port,
+int ksz9477_port_vlan_del(struct dsa_switch *ds, int port,
 			  const struct switchdev_obj_port_vlan *vlan)
 {
 	bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
+	struct ksz_device *dev = ds->priv;
 	u32 vlan_table[3];
 	u16 pvid;
 
@@ -1780,9 +1784,6 @@ const struct ksz_dev_ops ksz9477_dev_ops = {
 	.r_mib_stat64 = ksz_r_mib_stats64,
 	.freeze_mib = ksz9477_freeze_mib,
 	.port_init_cnt = ksz9477_port_init_cnt,
-	.vlan_filtering = ksz9477_port_vlan_filtering,
-	.vlan_add = ksz9477_port_vlan_add,
-	.vlan_del = ksz9477_port_vlan_del,
 	.mirror_add = ksz9477_port_mirror_add,
 	.mirror_del = ksz9477_port_mirror_del,
 	.get_caps = ksz9477_get_caps,
@@ -1827,9 +1828,9 @@ const struct dsa_switch_ops ksz9477_switch_ops = {
 	.port_pre_bridge_flags	= ksz_port_pre_bridge_flags,
 	.port_bridge_flags	= ksz_port_bridge_flags,
 	.port_fast_age		= ksz9477_flush_dyn_mac_table,
-	.port_vlan_filtering	= ksz_port_vlan_filtering,
-	.port_vlan_add		= ksz_port_vlan_add,
-	.port_vlan_del		= ksz_port_vlan_del,
+	.port_vlan_filtering	= ksz9477_port_vlan_filtering,
+	.port_vlan_add		= ksz9477_port_vlan_add,
+	.port_vlan_del		= ksz9477_port_vlan_del,
 	.port_fdb_dump		= ksz_port_fdb_dump,
 	.port_fdb_add		= ksz_port_fdb_add,
 	.port_fdb_del		= ksz_port_fdb_del,
diff --git a/drivers/net/dsa/microchip/ksz9477.h b/drivers/net/dsa/microchip/ksz9477.h
index 8012904a21308..75a7b2bfc7976 100644
--- a/drivers/net/dsa/microchip/ksz9477.h
+++ b/drivers/net/dsa/microchip/ksz9477.h
@@ -19,12 +19,12 @@ void ksz9477_r_mib_pkt(struct ksz_device *dev, int port, u16 addr,
 		       u64 *dropped, u64 *cnt);
 void ksz9477_freeze_mib(struct ksz_device *dev, int port, bool freeze);
 void ksz9477_port_init_cnt(struct ksz_device *dev, int port);
-int ksz9477_port_vlan_filtering(struct ksz_device *dev, int port,
+int ksz9477_port_vlan_filtering(struct dsa_switch *ds, int port,
 				bool flag, struct netlink_ext_ack *extack);
-int ksz9477_port_vlan_add(struct ksz_device *dev, int port,
+int ksz9477_port_vlan_add(struct dsa_switch *ds, int port,
 			  const struct switchdev_obj_port_vlan *vlan,
 			  struct netlink_ext_ack *extack);
-int ksz9477_port_vlan_del(struct ksz_device *dev, int port,
+int ksz9477_port_vlan_del(struct dsa_switch *ds, int port,
 			  const struct switchdev_obj_port_vlan *vlan);
 int ksz9477_port_mirror_add(struct ksz_device *dev, int port,
 			    struct dsa_mall_mirror_tc_entry *mirror,
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index eb13d548ebff9..07d1d58113f05 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3287,40 +3287,6 @@ int ksz_port_bridge_flags(struct dsa_switch *ds, int port,
 	return 0;
 }
 
-int ksz_port_vlan_filtering(struct dsa_switch *ds, int port,
-			    bool flag, struct netlink_ext_ack *extack)
-{
-	struct ksz_device *dev = ds->priv;
-
-	if (!dev->dev_ops->vlan_filtering)
-		return -EOPNOTSUPP;
-
-	return dev->dev_ops->vlan_filtering(dev, port, flag, extack);
-}
-
-int ksz_port_vlan_add(struct dsa_switch *ds, int port,
-		      const struct switchdev_obj_port_vlan *vlan,
-		      struct netlink_ext_ack *extack)
-{
-	struct ksz_device *dev = ds->priv;
-
-	if (!dev->dev_ops->vlan_add)
-		return -EOPNOTSUPP;
-
-	return dev->dev_ops->vlan_add(dev, port, vlan, extack);
-}
-
-int ksz_port_vlan_del(struct dsa_switch *ds, int port,
-		      const struct switchdev_obj_port_vlan *vlan)
-{
-	struct ksz_device *dev = ds->priv;
-
-	if (!dev->dev_ops->vlan_del)
-		return -EOPNOTSUPP;
-
-	return dev->dev_ops->vlan_del(dev, port, vlan);
-}
-
 int ksz_port_mirror_add(struct dsa_switch *ds, int port,
 			struct dsa_mall_mirror_tc_entry *mirror,
 			bool ingress, struct netlink_ext_ack *extack)
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 0aa83c75c40a1..d07b3f5918f8e 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -408,13 +408,6 @@ struct ksz_dev_ops {
 	void (*r_mib_pkt)(struct ksz_device *dev, int port, u16 addr,
 			  u64 *dropped, u64 *cnt);
 	void (*r_mib_stat64)(struct ksz_device *dev, int port);
-	int  (*vlan_filtering)(struct ksz_device *dev, int port,
-			       bool flag, struct netlink_ext_ack *extack);
-	int  (*vlan_add)(struct ksz_device *dev, int port,
-			 const struct switchdev_obj_port_vlan *vlan,
-			 struct netlink_ext_ack *extack);
-	int  (*vlan_del)(struct ksz_device *dev, int port,
-			 const struct switchdev_obj_port_vlan *vlan);
 	int (*mirror_add)(struct ksz_device *dev, int port,
 			  struct dsa_mall_mirror_tc_entry *mirror,
 			  bool ingress, struct netlink_ext_ack *extack);
@@ -505,13 +498,6 @@ int ksz_port_pre_bridge_flags(struct dsa_switch *ds, int port,
 int ksz_port_bridge_flags(struct dsa_switch *ds, int port,
 			  struct switchdev_brport_flags flags,
 			  struct netlink_ext_ack *extack);
-int ksz_port_vlan_filtering(struct dsa_switch *ds, int port,
-			    bool flag, struct netlink_ext_ack *extack);
-int ksz_port_vlan_add(struct dsa_switch *ds, int port,
-		      const struct switchdev_obj_port_vlan *vlan,
-		      struct netlink_ext_ack *extack);
-int ksz_port_vlan_del(struct dsa_switch *ds, int port,
-		      const struct switchdev_obj_port_vlan *vlan);
 int ksz_port_fdb_add(struct dsa_switch *ds, int port,
 		     const unsigned char *addr, u16 vid,
 		     struct dsa_db db);
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index feaaaafeace61..be6a457ee8e4b 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -713,9 +713,6 @@ const struct ksz_dev_ops lan937x_dev_ops = {
 	.r_mib_stat64 = ksz_r_mib_stats64,
 	.freeze_mib = ksz9477_freeze_mib,
 	.port_init_cnt = ksz9477_port_init_cnt,
-	.vlan_filtering = ksz9477_port_vlan_filtering,
-	.vlan_add = ksz9477_port_vlan_add,
-	.vlan_del = ksz9477_port_vlan_del,
 	.mirror_add = ksz9477_port_mirror_add,
 	.mirror_del = ksz9477_port_mirror_del,
 	.get_caps = lan937x_phylink_get_caps,
@@ -757,9 +754,9 @@ const struct dsa_switch_ops lan937x_switch_ops = {
 	.port_pre_bridge_flags	= ksz_port_pre_bridge_flags,
 	.port_bridge_flags	= ksz_port_bridge_flags,
 	.port_fast_age		= ksz9477_flush_dyn_mac_table,
-	.port_vlan_filtering	= ksz_port_vlan_filtering,
-	.port_vlan_add		= ksz_port_vlan_add,
-	.port_vlan_del		= ksz_port_vlan_del,
+	.port_vlan_filtering	= ksz9477_port_vlan_filtering,
+	.port_vlan_add		= ksz9477_port_vlan_add,
+	.port_vlan_del		= ksz9477_port_vlan_del,
 	.port_fdb_dump		= ksz_port_fdb_dump,
 	.port_fdb_add		= ksz_port_fdb_add,
 	.port_fdb_del		= ksz_port_fdb_del,

-- 
2.53.0


