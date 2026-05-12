Return-Path: <netdev+bounces-287139-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCL1IHMrA2o11QEAu9opvQ
	(envelope-from <netdev+bounces-287139-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:30:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 080BE52133D
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE1D831E8B86
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3738B3ABD89;
	Tue, 12 May 2026 13:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="M1U/J4/i"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491C43AB49A;
	Tue, 12 May 2026 13:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591212; cv=none; b=BsuX/sRQIvpSb8ggBR904JHO7PWIx+vmevSCaAb9lh2PtPspHBgeevuupnm3LgibHARnwMDE961fDVBz4BVi86z4LX4jdRGwIqVvKYFNuqE8/tqomCso3XX5xfRbW0nPhyqaiO0HNCaY5umYqkV7KLopp3ZoMeIPvi4mmJcAJzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591212; c=relaxed/simple;
	bh=n6BQbZ1mMoi0v8VOVhAd7eMQCk92MCOqkGWRen4VDdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H3a5S5nzRqW10B3efKCA6g3z4GJZANXeUQjMlkpVqliotqbhGA3rxpCiUiwnAWiTGdFdC2FmpW1B9wIVRtqHgXUmzBRIkO1rnzfWTQcKIc1rydLGHb7mZUZxzkwvS+Zm7I/hiHjGBqdOo3IVJkc3QhG3G1lHB8RVAqM6LtJdmK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=M1U/J4/i; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0C8971A357C;
	Tue, 12 May 2026 13:06:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D644560646;
	Tue, 12 May 2026 13:06:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9D0A311AF8CC9;
	Tue, 12 May 2026 15:06:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778591207; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Vqs/YNAR1dOCQ2RaP4mLrQU9/AD6dK33Y46eJ9P6UGk=;
	b=M1U/J4/iq4tC81Z76GdQbtBHGmCkDV9354nRt2bTTBEFwUVaHxCzg18h5z7+B1HWbXaBJT
	b4Kret8TC72fbuDgmllhZKqiXAQm1ZeljVDCW/01CcsLqqLLuvrnUEa4yPuRDgAx3h6akI
	OL0c3vlJLo0ATBZpTj09wXrf4KbYpRHhDb8e1fDMzdq+j+xLK2n81WNBuWYiWs85fzUEkC
	Jelp8GZ5YvxcwGyfgtTVoOjMJurfp+XEuPH4Y1utq2pBuYVy5s9gIGI0Huz63l+3aKkIqQ
	GWti3QluMxwqF5q3GiI93FGsAOaG74LgcABFQeHH9ujDMWG0Wsoz25Dsphy0hQ==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Tue, 12 May 2026 15:06:28 +0200
Subject: [PATCH net-next 06/15] net: dsa: microchip: bypass dev_ops for
 mirror operations
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-clean-ksz-2nd-series-v1-6-c00f6ce037fa@bootlin.com>
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
X-Rspamd-Queue-Id: 080BE52133D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287139-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Mirror operations are handled through a common function that redirects
the treatment to ksz_dev_ops callbacks. This layer of indirection isn't
needed since we now have a dsa_switch_ops for each switch family.

Remove this indirection layer for KSZ switches, by connecting the
ksz_dev_ops :: mirror_add() and mirror_del() operations directly to
dsa_switch_ops.
Remove the now unused mirror callbacks from ksz_dev_ops.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c         | 24 ++++++++++--------------
 drivers/net/dsa/microchip/ksz9477.c      | 12 ++++++------
 drivers/net/dsa/microchip/ksz9477.h      |  4 ++--
 drivers/net/dsa/microchip/ksz_common.c   | 21 ---------------------
 drivers/net/dsa/microchip/ksz_common.h   | 10 ----------
 drivers/net/dsa/microchip/lan937x_main.c |  6 ++----
 6 files changed, 20 insertions(+), 57 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 83795fd66aab2..38876e1779564 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -1585,10 +1585,11 @@ static int ksz8_port_vlan_del(struct dsa_switch *ds, int port,
 	return 0;
 }
 
-static int ksz8_port_mirror_add(struct ksz_device *dev, int port,
+static int ksz8_port_mirror_add(struct dsa_switch *ds, int port,
 				struct dsa_mall_mirror_tc_entry *mirror,
 				bool ingress, struct netlink_ext_ack *extack)
 {
+	struct ksz_device *dev = ds->priv;
 	int offset = P_MIRROR_CTRL;
 
 	if (ksz_is_ksz8463(dev))
@@ -1611,9 +1612,10 @@ static int ksz8_port_mirror_add(struct ksz_device *dev, int port,
 	return 0;
 }
 
-static void ksz8_port_mirror_del(struct ksz_device *dev, int port,
+static void ksz8_port_mirror_del(struct dsa_switch *ds, int port,
 				 struct dsa_mall_mirror_tc_entry *mirror)
 {
+	struct ksz_device *dev = ds->priv;
 	int offset = P_MIRROR_CTRL;
 	u8 data;
 
@@ -2216,8 +2218,6 @@ const struct ksz_dev_ops ksz8463_dev_ops = {
 	.r_mib_stat64 = ksz88xx_r_mib_stats64,
 	.freeze_mib = ksz8_freeze_mib,
 	.port_init_cnt = ksz8_port_init_cnt,
-	.mirror_add = ksz8_port_mirror_add,
-	.mirror_del = ksz8_port_mirror_del,
 	.get_caps = ksz8_get_caps,
 	.config_cpu_port = ksz8_config_cpu_port,
 	.enable_stp_addr = ksz8_enable_stp_addr,
@@ -2238,8 +2238,6 @@ const struct ksz_dev_ops ksz87xx_dev_ops = {
 	.r_mib_stat64 = ksz_r_mib_stats64,
 	.freeze_mib = ksz8_freeze_mib,
 	.port_init_cnt = ksz8_port_init_cnt,
-	.mirror_add = ksz8_port_mirror_add,
-	.mirror_del = ksz8_port_mirror_del,
 	.get_caps = ksz8_get_caps,
 	.config_cpu_port = ksz8_config_cpu_port,
 	.enable_stp_addr = ksz8_enable_stp_addr,
@@ -2263,8 +2261,6 @@ const struct ksz_dev_ops ksz88xx_dev_ops = {
 	.r_mib_stat64 = ksz88xx_r_mib_stats64,
 	.freeze_mib = ksz8_freeze_mib,
 	.port_init_cnt = ksz8_port_init_cnt,
-	.mirror_add = ksz8_port_mirror_add,
-	.mirror_del = ksz8_port_mirror_del,
 	.get_caps = ksz8_get_caps,
 	.config_cpu_port = ksz8_config_cpu_port,
 	.enable_stp_addr = ksz8_enable_stp_addr,
@@ -2307,8 +2303,8 @@ const struct dsa_switch_ops ksz8463_switch_ops = {
 	.port_fdb_del		= ksz8_fdb_del,
 	.port_mdb_add           = ksz8_mdb_add,
 	.port_mdb_del           = ksz8_mdb_del,
-	.port_mirror_add	= ksz_port_mirror_add,
-	.port_mirror_del	= ksz_port_mirror_del,
+	.port_mirror_add	= ksz8_port_mirror_add,
+	.port_mirror_del	= ksz8_port_mirror_del,
 	.get_stats64		= ksz_get_stats64,
 	.get_pause_stats	= ksz_get_pause_stats,
 	.port_change_mtu	= ksz8_change_mtu,
@@ -2367,8 +2363,8 @@ const struct dsa_switch_ops ksz87xx_switch_ops = {
 	.port_fdb_del		= ksz8_fdb_del,
 	.port_mdb_add           = ksz8_mdb_add,
 	.port_mdb_del           = ksz8_mdb_del,
-	.port_mirror_add	= ksz_port_mirror_add,
-	.port_mirror_del	= ksz_port_mirror_del,
+	.port_mirror_add	= ksz8_port_mirror_add,
+	.port_mirror_del	= ksz8_port_mirror_del,
 	.get_stats64		= ksz_get_stats64,
 	.get_pause_stats	= ksz_get_pause_stats,
 	.port_change_mtu	= ksz8_change_mtu,
@@ -2427,8 +2423,8 @@ const struct dsa_switch_ops ksz88xx_switch_ops = {
 	.port_fdb_del		= ksz8_fdb_del,
 	.port_mdb_add           = ksz8_mdb_add,
 	.port_mdb_del           = ksz8_mdb_del,
-	.port_mirror_add	= ksz_port_mirror_add,
-	.port_mirror_del	= ksz_port_mirror_del,
+	.port_mirror_add	= ksz8_port_mirror_add,
+	.port_mirror_del	= ksz8_port_mirror_del,
 	.get_stats64		= ksz_get_stats64,
 	.get_pause_stats	= ksz_get_pause_stats,
 	.port_change_mtu	= ksz8_change_mtu,
diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 69a4fb683b3a1..14ee9686ca0ab 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1080,10 +1080,11 @@ int ksz9477_mdb_del(struct dsa_switch *ds, int port,
 	return ret;
 }
 
-int ksz9477_port_mirror_add(struct ksz_device *dev, int port,
+int ksz9477_port_mirror_add(struct dsa_switch *ds, int port,
 			    struct dsa_mall_mirror_tc_entry *mirror,
 			    bool ingress, struct netlink_ext_ack *extack)
 {
+	struct ksz_device *dev = ds->priv;
 	u8 data;
 	int p;
 
@@ -1119,9 +1120,10 @@ int ksz9477_port_mirror_add(struct ksz_device *dev, int port,
 	return 0;
 }
 
-void ksz9477_port_mirror_del(struct ksz_device *dev, int port,
+void ksz9477_port_mirror_del(struct dsa_switch *ds, int port,
 			     struct dsa_mall_mirror_tc_entry *mirror)
 {
+	struct ksz_device *dev = ds->priv;
 	bool in_use = false;
 	u8 data;
 	int p;
@@ -1789,8 +1791,6 @@ const struct ksz_dev_ops ksz9477_dev_ops = {
 	.r_mib_stat64 = ksz_r_mib_stats64,
 	.freeze_mib = ksz9477_freeze_mib,
 	.port_init_cnt = ksz9477_port_init_cnt,
-	.mirror_add = ksz9477_port_mirror_add,
-	.mirror_del = ksz9477_port_mirror_del,
 	.get_caps = ksz9477_get_caps,
 	.pme_write8 = ksz_write8,
 	.pme_pread8 = ksz_pread8,
@@ -1836,8 +1836,8 @@ const struct dsa_switch_ops ksz9477_switch_ops = {
 	.port_fdb_del		= ksz9477_fdb_del,
 	.port_mdb_add           = ksz9477_mdb_add,
 	.port_mdb_del           = ksz9477_mdb_del,
-	.port_mirror_add	= ksz_port_mirror_add,
-	.port_mirror_del	= ksz_port_mirror_del,
+	.port_mirror_add	= ksz9477_port_mirror_add,
+	.port_mirror_del	= ksz9477_port_mirror_del,
 	.get_stats64		= ksz_get_stats64,
 	.get_pause_stats	= ksz_get_pause_stats,
 	.port_change_mtu	= ksz9477_change_mtu,
diff --git a/drivers/net/dsa/microchip/ksz9477.h b/drivers/net/dsa/microchip/ksz9477.h
index 39f042e56f365..599db0a6ba2e3 100644
--- a/drivers/net/dsa/microchip/ksz9477.h
+++ b/drivers/net/dsa/microchip/ksz9477.h
@@ -26,10 +26,10 @@ int ksz9477_port_vlan_add(struct dsa_switch *ds, int port,
 			  struct netlink_ext_ack *extack);
 int ksz9477_port_vlan_del(struct dsa_switch *ds, int port,
 			  const struct switchdev_obj_port_vlan *vlan);
-int ksz9477_port_mirror_add(struct ksz_device *dev, int port,
+int ksz9477_port_mirror_add(struct dsa_switch *ds, int port,
 			    struct dsa_mall_mirror_tc_entry *mirror,
 			    bool ingress, struct netlink_ext_ack *extack);
-void ksz9477_port_mirror_del(struct ksz_device *dev, int port,
+void ksz9477_port_mirror_del(struct dsa_switch *ds, int port,
 			     struct dsa_mall_mirror_tc_entry *mirror);
 int ksz9477_errata_monitor(struct ksz_device *dev, int port,
 			   u64 tx_late_col);
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index d17ce88d49471..ad7615849c7a4 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3228,27 +3228,6 @@ int ksz_port_bridge_flags(struct dsa_switch *ds, int port,
 	return 0;
 }
 
-int ksz_port_mirror_add(struct dsa_switch *ds, int port,
-			struct dsa_mall_mirror_tc_entry *mirror,
-			bool ingress, struct netlink_ext_ack *extack)
-{
-	struct ksz_device *dev = ds->priv;
-
-	if (!dev->dev_ops->mirror_add)
-		return -EOPNOTSUPP;
-
-	return dev->dev_ops->mirror_add(dev, port, mirror, ingress, extack);
-}
-
-void ksz_port_mirror_del(struct dsa_switch *ds, int port,
-			 struct dsa_mall_mirror_tc_entry *mirror)
-{
-	struct ksz_device *dev = ds->priv;
-
-	if (dev->dev_ops->mirror_del)
-		dev->dev_ops->mirror_del(dev, port, mirror);
-}
-
 int ksz_max_mtu(struct dsa_switch *ds, int port)
 {
 	struct ksz_device *dev = ds->priv;
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index fe3b2dad3d684..94eb79fa34392 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -408,11 +408,6 @@ struct ksz_dev_ops {
 	void (*r_mib_pkt)(struct ksz_device *dev, int port, u16 addr,
 			  u64 *dropped, u64 *cnt);
 	void (*r_mib_stat64)(struct ksz_device *dev, int port);
-	int (*mirror_add)(struct ksz_device *dev, int port,
-			  struct dsa_mall_mirror_tc_entry *mirror,
-			  bool ingress, struct netlink_ext_ack *extack);
-	void (*mirror_del)(struct ksz_device *dev, int port,
-			   struct dsa_mall_mirror_tc_entry *mirror);
 	void (*get_caps)(struct ksz_device *dev, int port,
 			 struct phylink_config *config);
 	int (*pme_write8)(struct ksz_device *dev, u32 reg, u8 value);
@@ -499,11 +494,6 @@ void ksz_phylink_mac_link_down(struct phylink_config *config,
 			       unsigned int mode,
 			       phy_interface_t interface);
 
-int ksz_port_mirror_add(struct dsa_switch *ds, int port,
-			struct dsa_mall_mirror_tc_entry *mirror,
-			bool ingress, struct netlink_ext_ack *extack);
-void ksz_port_mirror_del(struct dsa_switch *ds, int port,
-			 struct dsa_mall_mirror_tc_entry *mirror);
 int ksz_max_mtu(struct dsa_switch *ds, int port);
 
 bool ksz_support_eee(struct dsa_switch *ds, int port);
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index aa428353818d8..621139a2c3025 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -713,8 +713,6 @@ const struct ksz_dev_ops lan937x_dev_ops = {
 	.r_mib_stat64 = ksz_r_mib_stats64,
 	.freeze_mib = ksz9477_freeze_mib,
 	.port_init_cnt = ksz9477_port_init_cnt,
-	.mirror_add = ksz9477_port_mirror_add,
-	.mirror_del = ksz9477_port_mirror_del,
 	.get_caps = lan937x_phylink_get_caps,
 	.setup_rgmii_delay = lan937x_setup_rgmii_delay,
 	.config_cpu_port = lan937x_config_cpu_port,
@@ -757,8 +755,8 @@ const struct dsa_switch_ops lan937x_switch_ops = {
 	.port_fdb_del		= ksz9477_fdb_del,
 	.port_mdb_add           = ksz9477_mdb_add,
 	.port_mdb_del           = ksz9477_mdb_del,
-	.port_mirror_add	= ksz_port_mirror_add,
-	.port_mirror_del	= ksz_port_mirror_del,
+	.port_mirror_add	= ksz9477_port_mirror_add,
+	.port_mirror_del	= ksz9477_port_mirror_del,
 	.get_stats64		= ksz_get_stats64,
 	.get_pause_stats	= ksz_get_pause_stats,
 	.port_change_mtu	= lan937x_change_mtu,

-- 
2.53.0


