Return-Path: <netdev+bounces-287135-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGzFGmcpA2r/1AEAu9opvQ
	(envelope-from <netdev+bounces-287135-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:21:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC11B5210BD
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C078931AB188
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AC13A71B0;
	Tue, 12 May 2026 13:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JEcNjkvT"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D2F3A48CF
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 13:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591203; cv=none; b=Dwu/gfU53RqRsNRjUhte5Ulvhw8/f3ghwaPnvgtaUH/N/RwFsS33ayiSIwRxSCTD3pNOgbeQVx36Jfw5YmPdSjUyUOB5S1GunFQ3O9YzAeBfr7b8+59aD9CyTggLvoYoQv/HNQQUK4rUg1pgYkBXWNHz1GtcZ6z8Sj2ZJukoOy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591203; c=relaxed/simple;
	bh=7B7AGQrD1kEL8db3XiLCKDD0mXEAaLjaqYFu4a1l3kU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dllh7eN8Pr8X72nzz2HKVS/BbfYHiwgnVluCFzSfmoKSQ1klrsVqkSlcUUnjoKwFO5BNUA45PMIY/HsXRyguLybvVo97DRrnTtVBHxBNO0CfBUjGjE5haRctCFZdMNcAZu1Im43iPmKMw0YuGAAEh6sqoBPPXVyuVULmPROUHUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JEcNjkvT; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 13CAA1A3582;
	Tue, 12 May 2026 13:06:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DCF8760646;
	Tue, 12 May 2026 13:06:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ECBDE11AF88B7;
	Tue, 12 May 2026 15:06:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778591198; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0/WB3khgGIiKSUkApt5XvxjvEWTRSU1iYvJD6kX/t98=;
	b=JEcNjkvTv7j4yuPDdPNCM3EYYEtgzDoBTLQqOKwRkPoYRZNs54NSe9gm86WpdlXylWFWfI
	bZ54xbEk4X2oPqW4tdXcXbidDdvIhquXUdS9l9evqEY5iXxtdvp/1PonKVH/r7p7I4UP1U
	Ujdb3UhuHmAw3ot9rU4WZDLi1URJtHMAmGRmBGGcIZ0C43k0eAjiTPMfAemdIRhhn4UyXF
	C2Eget/GKU6F/jWpowETaOyBr/F5kJpd+O2I7o9oxc8vFtJ71pHV3IUGobfewc3dhZQJxK
	CIQjEoZ43BmyA87UhEYagyMDwIPWgCExbJ0K8FGsODQL5d0kvIJT0ehcSXN3cg==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Tue, 12 May 2026 15:06:24 +0200
Subject: [PATCH net-next 02/15] net: dsa: microchip: bypass dev_ops for FDB
 ageing operations
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-clean-ksz-2nd-series-v1-2-c00f6ce037fa@bootlin.com>
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
X-Rspamd-Queue-Id: DC11B5210BD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287135-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	URIBL_MULTI_FAIL(0.00)[nxp.com:server fail,bootlin.com:server fail,tor.lore.kernel.org:server fail];
	RCPT_COUNT_TWELVE(0.00)[18];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Action: no action

From: Vladimir Oltean <vladimir.oltean@nxp.com>

dsa_switch_ops :: set_ageing_time() goes through ksz_set_ageing_time(),
further dispatched through ksz_dev_ops :: set_ageing_time(). Only
ksz9477 and lan937x provide an implementation for this, so remove the
(optional) method from ksz8463_switch_ops, ksz87xx_switch_ops,
ksz88xx_switch_ops. Also, hook up ksz9477 and lan937x dsa_switch_ops
directly to their respective implementations.

Every switch family provides a dsa_switch_ops :: port_fast_age()
implementation, which is dispatched through ksz_dev_ops ::
flush_dyn_mac_table(). Remove the dev_ops indirection and connect the
flush_dyn_mac_table() methods directly to their respective dsa_switch_ops.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c         | 15 +++++----------
 drivers/net/dsa/microchip/ksz9477.c      | 12 ++++++------
 drivers/net/dsa/microchip/ksz9477.h      |  2 +-
 drivers/net/dsa/microchip/ksz_common.c   | 17 -----------------
 drivers/net/dsa/microchip/ksz_common.h   |  4 ----
 drivers/net/dsa/microchip/lan937x_main.c |  9 ++++-----
 6 files changed, 16 insertions(+), 43 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index abee0dc5ec04b..10ab89ff93b65 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -1278,8 +1278,9 @@ static void ksz8_cfg_port_member(struct ksz_device *dev, int port, u8 member)
 	ksz_pwrite8(dev, port, offset, data);
 }
 
-static void ksz8_flush_dyn_mac_table(struct ksz_device *dev, int port)
+static void ksz8_flush_dyn_mac_table(struct dsa_switch *ds, int port)
 {
+	struct ksz_device *dev = ds->priv;
 	u8 learn[DSA_MAX_PORTS];
 	int first, index, cnt;
 	const u16 *regs;
@@ -2201,7 +2202,6 @@ const struct ksz_dev_ops ksz8463_dev_ops = {
 	.setup = ksz8_setup,
 	.get_port_addr = ksz8463_get_port_addr,
 	.cfg_port_member = ksz8_cfg_port_member,
-	.flush_dyn_mac_table = ksz8_flush_dyn_mac_table,
 	.port_setup = ksz8_port_setup,
 	.r_phy = ksz8463_r_phy,
 	.w_phy = ksz8463_w_phy,
@@ -2233,7 +2233,6 @@ const struct ksz_dev_ops ksz87xx_dev_ops = {
 	.setup = ksz8_setup,
 	.get_port_addr = ksz8_get_port_addr,
 	.cfg_port_member = ksz8_cfg_port_member,
-	.flush_dyn_mac_table = ksz8_flush_dyn_mac_table,
 	.port_setup = ksz8_port_setup,
 	.r_phy = ksz8_r_phy,
 	.w_phy = ksz8_w_phy,
@@ -2268,7 +2267,6 @@ const struct ksz_dev_ops ksz88xx_dev_ops = {
 	.setup = ksz8_setup,
 	.get_port_addr = ksz8_get_port_addr,
 	.cfg_port_member = ksz8_cfg_port_member,
-	.flush_dyn_mac_table = ksz8_flush_dyn_mac_table,
 	.port_setup = ksz8_port_setup,
 	.r_phy = ksz8_r_phy,
 	.w_phy = ksz8_w_phy,
@@ -2309,7 +2307,6 @@ const struct dsa_switch_ops ksz8463_switch_ops = {
 	.phy_write		= ksz_phy_write16,
 	.phylink_get_caps	= ksz_phylink_get_caps,
 	.port_setup		= ksz_port_setup,
-	.set_ageing_time	= ksz_set_ageing_time,
 	.get_strings		= ksz_get_strings,
 	.get_ethtool_stats	= ksz_get_ethtool_stats,
 	.get_sset_count		= ksz_sset_count,
@@ -2322,7 +2319,7 @@ const struct dsa_switch_ops ksz8463_switch_ops = {
 	.port_teardown		= ksz_port_teardown,
 	.port_pre_bridge_flags	= ksz_port_pre_bridge_flags,
 	.port_bridge_flags	= ksz_port_bridge_flags,
-	.port_fast_age		= ksz_port_fast_age,
+	.port_fast_age		= ksz8_flush_dyn_mac_table,
 	.port_vlan_filtering	= ksz_port_vlan_filtering,
 	.port_vlan_add		= ksz_port_vlan_add,
 	.port_vlan_del		= ksz_port_vlan_del,
@@ -2370,7 +2367,6 @@ const struct dsa_switch_ops ksz87xx_switch_ops = {
 	.phy_write		= ksz_phy_write16,
 	.phylink_get_caps	= ksz_phylink_get_caps,
 	.port_setup		= ksz_port_setup,
-	.set_ageing_time	= ksz_set_ageing_time,
 	.get_strings		= ksz_get_strings,
 	.get_ethtool_stats	= ksz_get_ethtool_stats,
 	.get_sset_count		= ksz_sset_count,
@@ -2383,7 +2379,7 @@ const struct dsa_switch_ops ksz87xx_switch_ops = {
 	.port_teardown		= ksz_port_teardown,
 	.port_pre_bridge_flags	= ksz_port_pre_bridge_flags,
 	.port_bridge_flags	= ksz_port_bridge_flags,
-	.port_fast_age		= ksz_port_fast_age,
+	.port_fast_age		= ksz8_flush_dyn_mac_table,
 	.port_vlan_filtering	= ksz_port_vlan_filtering,
 	.port_vlan_add		= ksz_port_vlan_add,
 	.port_vlan_del		= ksz_port_vlan_del,
@@ -2431,7 +2427,6 @@ const struct dsa_switch_ops ksz88xx_switch_ops = {
 	.phy_write		= ksz_phy_write16,
 	.phylink_get_caps	= ksz_phylink_get_caps,
 	.port_setup		= ksz_port_setup,
-	.set_ageing_time	= ksz_set_ageing_time,
 	.get_strings		= ksz_get_strings,
 	.get_ethtool_stats	= ksz_get_ethtool_stats,
 	.get_sset_count		= ksz_sset_count,
@@ -2444,7 +2439,7 @@ const struct dsa_switch_ops ksz88xx_switch_ops = {
 	.port_teardown		= ksz_port_teardown,
 	.port_pre_bridge_flags	= ksz_port_pre_bridge_flags,
 	.port_bridge_flags	= ksz_port_bridge_flags,
-	.port_fast_age		= ksz_port_fast_age,
+	.port_fast_age		= ksz8_flush_dyn_mac_table,
 	.port_vlan_filtering	= ksz_port_vlan_filtering,
 	.port_vlan_add		= ksz_port_vlan_add,
 	.port_vlan_del		= ksz_port_vlan_del,
diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index ac2c63fe0588c..11e6fd1f46ce0 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -604,8 +604,9 @@ void ksz9477_cfg_port_member(struct ksz_device *dev, int port, u8 member)
 	ksz_pwrite32(dev, port, REG_PORT_VLAN_MEMBERSHIP__4, member);
 }
 
-void ksz9477_flush_dyn_mac_table(struct ksz_device *dev, int port)
+void ksz9477_flush_dyn_mac_table(struct dsa_switch *ds, int port)
 {
+	struct ksz_device *dev = ds->priv;
 	const u16 *regs = dev->info->regs;
 	u8 data;
 
@@ -1170,8 +1171,9 @@ static void ksz9477_get_caps(struct ksz_device *dev, int port,
 	}
 }
 
-static int ksz9477_set_ageing_time(struct ksz_device *dev, unsigned int msecs)
+static int ksz9477_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
 {
+	struct ksz_device *dev = ds->priv;
 	u32 secs = msecs / 1000;
 	u8 data, mult, value;
 	u32 max_val;
@@ -1769,9 +1771,7 @@ const struct ksz_dev_ops ksz9477_dev_ops = {
 	.setup = ksz9477_setup,
 	.get_port_addr = ksz9477_get_port_addr,
 	.cfg_port_member = ksz9477_cfg_port_member,
-	.flush_dyn_mac_table = ksz9477_flush_dyn_mac_table,
 	.port_setup = ksz9477_port_setup,
-	.set_ageing_time = ksz9477_set_ageing_time,
 	.r_phy = ksz9477_r_phy,
 	.w_phy = ksz9477_w_phy,
 	.r_mib_cnt = ksz9477_r_mib_cnt,
@@ -1813,7 +1813,7 @@ const struct dsa_switch_ops ksz9477_switch_ops = {
 	.phy_write		= ksz_phy_write16,
 	.phylink_get_caps	= ksz_phylink_get_caps,
 	.port_setup		= ksz_port_setup,
-	.set_ageing_time	= ksz_set_ageing_time,
+	.set_ageing_time	= ksz9477_set_ageing_time,
 	.get_strings		= ksz_get_strings,
 	.get_ethtool_stats	= ksz_get_ethtool_stats,
 	.get_sset_count		= ksz_sset_count,
@@ -1826,7 +1826,7 @@ const struct dsa_switch_ops ksz9477_switch_ops = {
 	.port_teardown		= ksz_port_teardown,
 	.port_pre_bridge_flags	= ksz_port_pre_bridge_flags,
 	.port_bridge_flags	= ksz_port_bridge_flags,
-	.port_fast_age		= ksz_port_fast_age,
+	.port_fast_age		= ksz9477_flush_dyn_mac_table,
 	.port_vlan_filtering	= ksz_port_vlan_filtering,
 	.port_vlan_add		= ksz_port_vlan_add,
 	.port_vlan_del		= ksz_port_vlan_del,
diff --git a/drivers/net/dsa/microchip/ksz9477.h b/drivers/net/dsa/microchip/ksz9477.h
index bacadcbc478cc..8012904a21308 100644
--- a/drivers/net/dsa/microchip/ksz9477.h
+++ b/drivers/net/dsa/microchip/ksz9477.h
@@ -13,7 +13,7 @@
 
 u32 ksz9477_get_port_addr(int port, int offset);
 void ksz9477_cfg_port_member(struct ksz_device *dev, int port, u8 member);
-void ksz9477_flush_dyn_mac_table(struct ksz_device *dev, int port);
+void ksz9477_flush_dyn_mac_table(struct dsa_switch *ds, int port);
 void ksz9477_r_mib_cnt(struct ksz_device *dev, int port, u16 addr, u64 *cnt);
 void ksz9477_r_mib_pkt(struct ksz_device *dev, int port, u16 addr,
 		       u64 *dropped, u64 *cnt);
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 426414a218455..cfca29007e36b 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3085,23 +3085,6 @@ void ksz_port_bridge_leave(struct dsa_switch *ds, int port,
 	 */
 }
 
-void ksz_port_fast_age(struct dsa_switch *ds, int port)
-{
-	struct ksz_device *dev = ds->priv;
-
-	dev->dev_ops->flush_dyn_mac_table(dev, port);
-}
-
-int ksz_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
-{
-	struct ksz_device *dev = ds->priv;
-
-	if (!dev->dev_ops->set_ageing_time)
-		return -EOPNOTSUPP;
-
-	return dev->dev_ops->set_ageing_time(dev, msecs);
-}
-
 int ksz_port_fdb_add(struct dsa_switch *ds, int port,
 		     const unsigned char *addr, u16 vid,
 		     struct dsa_db db)
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 0ab3b4f96595a..80b3f2483e36d 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -363,9 +363,7 @@ struct ksz_dev_ops {
 	void (*teardown)(struct dsa_switch *ds);
 	u32 (*get_port_addr)(int port, int offset);
 	void (*cfg_port_member)(struct ksz_device *dev, int port, u8 member);
-	void (*flush_dyn_mac_table)(struct ksz_device *dev, int port);
 	void (*port_setup)(struct ksz_device *dev, int port, bool cpu_port);
-	int (*set_ageing_time)(struct ksz_device *dev, unsigned int msecs);
 
 	/**
 	 * @mdio_bus_preinit: Function pointer to pre-initialize the MDIO bus
@@ -515,8 +513,6 @@ int ksz_port_vlan_add(struct dsa_switch *ds, int port,
 		      struct netlink_ext_ack *extack);
 int ksz_port_vlan_del(struct dsa_switch *ds, int port,
 		      const struct switchdev_obj_port_vlan *vlan);
-void ksz_port_fast_age(struct dsa_switch *ds, int port);
-int ksz_set_ageing_time(struct dsa_switch *ds, unsigned int msecs);
 int ksz_port_fdb_add(struct dsa_switch *ds, int port,
 		     const unsigned char *addr, u16 vid,
 		     struct dsa_db db);
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index e522990cce22e..19e444cb0a74a 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -461,8 +461,9 @@ static int lan937x_change_mtu(struct ksz_device *dev, int port, int new_mtu)
 	return 0;
 }
 
-static int lan937x_set_ageing_time(struct ksz_device *dev, unsigned int msecs)
+static int lan937x_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
 {
+	struct ksz_device *dev = ds->priv;
 	u8 data, mult, value8;
 	bool in_msec = false;
 	u32 max_val, value;
@@ -702,9 +703,7 @@ const struct ksz_dev_ops lan937x_dev_ops = {
 	.teardown = lan937x_teardown,
 	.get_port_addr = ksz9477_get_port_addr,
 	.cfg_port_member = ksz9477_cfg_port_member,
-	.flush_dyn_mac_table = ksz9477_flush_dyn_mac_table,
 	.port_setup = lan937x_port_setup,
-	.set_ageing_time = lan937x_set_ageing_time,
 	.mdio_bus_preinit = lan937x_mdio_bus_preinit,
 	.create_phy_addr_map = lan937x_create_phy_addr_map,
 	.r_phy = lan937x_r_phy,
@@ -745,7 +744,7 @@ const struct dsa_switch_ops lan937x_switch_ops = {
 	.phy_write		= ksz_phy_write16,
 	.phylink_get_caps	= ksz_phylink_get_caps,
 	.port_setup		= ksz_port_setup,
-	.set_ageing_time	= ksz_set_ageing_time,
+	.set_ageing_time	= lan937x_set_ageing_time,
 	.get_strings		= ksz_get_strings,
 	.get_ethtool_stats	= ksz_get_ethtool_stats,
 	.get_sset_count		= ksz_sset_count,
@@ -758,7 +757,7 @@ const struct dsa_switch_ops lan937x_switch_ops = {
 	.port_teardown		= ksz_port_teardown,
 	.port_pre_bridge_flags	= ksz_port_pre_bridge_flags,
 	.port_bridge_flags	= ksz_port_bridge_flags,
-	.port_fast_age		= ksz_port_fast_age,
+	.port_fast_age		= ksz9477_flush_dyn_mac_table,
 	.port_vlan_filtering	= ksz_port_vlan_filtering,
 	.port_vlan_add		= ksz_port_vlan_add,
 	.port_vlan_del		= ksz_port_vlan_del,

-- 
2.53.0


