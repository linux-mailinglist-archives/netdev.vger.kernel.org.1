Return-Path: <netdev+bounces-287146-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDJGKCYrA2oR1QEAu9opvQ
	(envelope-from <netdev+bounces-287146-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:29:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D575212B3
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 622123368258
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9B03B8127;
	Tue, 12 May 2026 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rUIImefo"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9F837DAA9
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 13:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591226; cv=none; b=suU7gL38n/UOZkLrYRxfsTfDWEkeznhAOTCH9DFCnEnkMDdqpHBAl7+aoLU9ZAImRM1gg4RQ8h8mCy5Fb2WqIiof7IcNs+Z5Rdl7ykKBCEDq2nwX0UDElKUgyl68g6FRo7lsvWI7RiF0r2IDUA/+uwEf7NUIvWTm/ERHntuZCJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591226; c=relaxed/simple;
	bh=2PnX4bDPKkU7+9Fn2WXKbpnpgActCHx87eV1a+dXRzg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ExrVOeZlOICglIV4K6hlhwgWFPHV+7+/Hn1ovDI7wddbDp+N1ltBfom7N6YYTE4+dx0WcDP4FDdD1ZGXJPpEx3Cw5iiXHRoMZQj9+FnxON+7WCBL5qdkQljFMPgdzXI3un29Ui+B3IjO2AG+o0GKz8EVH9QxIR2b9xOlQ+BbFYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rUIImefo; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9A6DA4E42C1C
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 13:07:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 68B5F60646;
	Tue, 12 May 2026 13:07:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C7A6111AF8CCE;
	Tue, 12 May 2026 15:07:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778591222; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4ppAl42xy7mrOsa3iPwQz5yaHnKDimvvfGCqDDRDhLI=;
	b=rUIImefoZrIM3BgzkdVbD9O2bnGF/Y4E3e+gdzfAi/lTpwq/dJiAAXhvfreFRV7BYObeX8
	zojLX8PoVhcrtBUPRlf6Qe5Mji8lvmmY7nGfkpdS8rzV4tKb9QnvO1Dp1Zad47R7MMiIvw
	uZcwG+XY9LIwyt/w6w1fxPe+y3GCzhPFevgKe/oD4nU1cUdO2kVc440l2l+UBbjfNFlT6U
	pGKXDxLA4UEpzaD1uvOE0xpmiHbihuCiKtprv4bz6u2ZAke81VPaad7UVWls2oWZM0t6On
	QeEmSTYwM173hjd6IBNbpNVlPp1zBEmGa16pf0BCzEIt9gkyti4PkTpyRUFqyg==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Tue, 12 May 2026 15:06:35 +0200
Subject: [PATCH net-next 13/15] net: dsa: microchip: bypass dev_ops for
 port_setup()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-clean-ksz-2nd-series-v1-13-c00f6ce037fa@bootlin.com>
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
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 06D575212B3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287146-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Action: no action

port_setup() is handled through a common function that redirects
the treatment to ksz_dev_ops callbacks. This layer of indirection
isn't needed since we now have a dsa_switch_ops for each switch family

Remove one indirection layer for KSZ switches, by connecting the
ksz_dev_ops :: port_setup() operations directly to dsa_switch_ops.
Make ksz9477_set_default_prio_queue_mapping() non-static since it's used
by ksz_common for tc operations and by ksz9477.c for this port_setup().
Remove the now unused port_setup() callback from ksz_dev_ops.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c         | 20 ++++++++++++++------
 drivers/net/dsa/microchip/ksz9477.c      | 20 ++++++++++++++++++--
 drivers/net/dsa/microchip/ksz9477.h      |  1 +
 drivers/net/dsa/microchip/ksz_common.c   | 27 +--------------------------
 drivers/net/dsa/microchip/ksz_common.h   |  3 +--
 drivers/net/dsa/microchip/lan937x_main.c |  3 +--
 6 files changed, 36 insertions(+), 38 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index acc898c68f985..09968aec65063 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -1692,6 +1692,17 @@ static void ksz8_port_setup(struct ksz_device *dev, int port, bool cpu_port)
 		ksz8_pme_pwrite8(dev, port, regs[REG_PORT_PME_CTRL], 0);
 }
 
+static int ksz8_dsa_port_setup(struct dsa_switch *ds, int port)
+{
+	struct ksz_device *dev = ds->priv;
+
+	if (!dsa_is_user_port(ds, port))
+		return 0;
+
+	ksz8_port_setup(dev, port, false);
+	return ksz_dcb_init_port(dev, port);
+}
+
 static void ksz88x3_config_rmii_clk(struct ksz_device *dev)
 {
 	struct dsa_port *cpu_dp = dsa_to_port(dev->ds, dev->cpu_port);
@@ -2319,7 +2330,6 @@ const struct phylink_mac_ops ksz8_phylink_mac_ops = {
 const struct ksz_dev_ops ksz8463_dev_ops = {
 	.get_port_addr = ksz8463_get_port_addr,
 	.cfg_port_member = ksz8_cfg_port_member,
-	.port_setup = ksz8_port_setup,
 	.r_phy = ksz8463_r_phy,
 	.w_phy = ksz8463_w_phy,
 	.r_mib_cnt = ksz8_r_mib_cnt,
@@ -2333,7 +2343,6 @@ const struct ksz_dev_ops ksz8463_dev_ops = {
 const struct ksz_dev_ops ksz87xx_dev_ops = {
 	.get_port_addr = ksz8_get_port_addr,
 	.cfg_port_member = ksz8_cfg_port_member,
-	.port_setup = ksz8_port_setup,
 	.r_phy = ksz8_r_phy,
 	.w_phy = ksz8_w_phy,
 	.r_mib_cnt = ksz8_r_mib_cnt,
@@ -2350,7 +2359,6 @@ const struct ksz_dev_ops ksz87xx_dev_ops = {
 const struct ksz_dev_ops ksz88xx_dev_ops = {
 	.get_port_addr = ksz8_get_port_addr,
 	.cfg_port_member = ksz8_cfg_port_member,
-	.port_setup = ksz8_port_setup,
 	.r_phy = ksz8_r_phy,
 	.w_phy = ksz8_w_phy,
 	.r_mib_cnt = ksz8_r_mib_cnt,
@@ -2373,7 +2381,7 @@ const struct dsa_switch_ops ksz8463_switch_ops = {
 	.phy_read		= ksz_phy_read16,
 	.phy_write		= ksz_phy_write16,
 	.phylink_get_caps	= ksz8_phylink_get_caps,
-	.port_setup		= ksz_port_setup,
+	.port_setup		= ksz8_dsa_port_setup,
 	.get_strings		= ksz_get_strings,
 	.get_ethtool_stats	= ksz_get_ethtool_stats,
 	.get_sset_count		= ksz_sset_count,
@@ -2433,7 +2441,7 @@ const struct dsa_switch_ops ksz87xx_switch_ops = {
 	.phy_read		= ksz_phy_read16,
 	.phy_write		= ksz_phy_write16,
 	.phylink_get_caps	= ksz8_phylink_get_caps,
-	.port_setup		= ksz_port_setup,
+	.port_setup		= ksz8_dsa_port_setup,
 	.get_strings		= ksz_get_strings,
 	.get_ethtool_stats	= ksz_get_ethtool_stats,
 	.get_sset_count		= ksz_sset_count,
@@ -2493,7 +2501,7 @@ const struct dsa_switch_ops ksz88xx_switch_ops = {
 	.phy_read		= ksz_phy_read16,
 	.phy_write		= ksz_phy_write16,
 	.phylink_get_caps	= ksz8_phylink_get_caps,
-	.port_setup		= ksz_port_setup,
+	.port_setup		= ksz8_dsa_port_setup,
 	.get_strings		= ksz_get_strings,
 	.get_ethtool_stats	= ksz_get_ethtool_stats,
 	.get_sset_count		= ksz_sset_count,
diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 7385aa4e788a1..2f63a3a7d6ceb 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1309,6 +1309,23 @@ static void ksz9477_port_setup(struct ksz_device *dev, int port, bool cpu_port)
 	ksz_pwrite8(dev, port, regs[REG_PORT_PME_CTRL], 0);
 }
 
+int ksz9477_dsa_port_setup(struct dsa_switch *ds, int port)
+{
+	struct ksz_device *dev = ds->priv;
+	int ret;
+
+	if (!dsa_is_user_port(ds, port))
+		return 0;
+
+	ksz9477_port_setup(dev, port, false);
+
+	ret = ksz9477_set_default_prio_queue_mapping(dev, port);
+	if (ret)
+		return ret;
+
+	return ksz_dcb_init_port(dev, port);
+};
+
 static void ksz9477_config_cpu_port(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
@@ -1895,7 +1912,6 @@ const struct phylink_mac_ops ksz9477_phylink_mac_ops = {
 const struct ksz_dev_ops ksz9477_dev_ops = {
 	.get_port_addr = ksz9477_get_port_addr,
 	.cfg_port_member = ksz9477_cfg_port_member,
-	.port_setup = ksz9477_port_setup,
 	.r_phy = ksz9477_r_phy,
 	.w_phy = ksz9477_w_phy,
 	.r_mib_cnt = ksz9477_r_mib_cnt,
@@ -1919,7 +1935,7 @@ const struct dsa_switch_ops ksz9477_switch_ops = {
 	.phy_read		= ksz_phy_read16,
 	.phy_write		= ksz_phy_write16,
 	.phylink_get_caps	= ksz9477_phylink_get_caps,
-	.port_setup		= ksz_port_setup,
+	.port_setup		= ksz9477_dsa_port_setup,
 	.set_ageing_time	= ksz9477_set_ageing_time,
 	.get_strings		= ksz_get_strings,
 	.get_ethtool_stats	= ksz_get_ethtool_stats,
diff --git a/drivers/net/dsa/microchip/ksz9477.h b/drivers/net/dsa/microchip/ksz9477.h
index 599db0a6ba2e3..6f59bba3c0860 100644
--- a/drivers/net/dsa/microchip/ksz9477.h
+++ b/drivers/net/dsa/microchip/ksz9477.h
@@ -18,6 +18,7 @@ void ksz9477_r_mib_cnt(struct ksz_device *dev, int port, u16 addr, u64 *cnt);
 void ksz9477_r_mib_pkt(struct ksz_device *dev, int port, u16 addr,
 		       u64 *dropped, u64 *cnt);
 void ksz9477_freeze_mib(struct ksz_device *dev, int port, bool freeze);
+int ksz9477_dsa_port_setup(struct dsa_switch *ds, int port);
 void ksz9477_port_init_cnt(struct ksz_device *dev, int port);
 int ksz9477_port_vlan_filtering(struct dsa_switch *ds, int port,
 				bool flag, struct netlink_ext_ack *extack);
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 60edb02846481..f44974cf4e595 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2947,8 +2947,7 @@ void ksz_port_bridge_leave(struct dsa_switch *ds, int port,
 	 */
 }
 
-static int ksz9477_set_default_prio_queue_mapping(struct ksz_device *dev,
-						  int port)
+int ksz9477_set_default_prio_queue_mapping(struct ksz_device *dev, int port)
 {
 	u32 queue_map = 0;
 	int ipm;
@@ -2970,30 +2969,6 @@ static int ksz9477_set_default_prio_queue_mapping(struct ksz_device *dev,
 	return ksz_pwrite32(dev, port, KSZ9477_PORT_MRI_TC_MAP__4, queue_map);
 }
 
-int ksz_port_setup(struct dsa_switch *ds, int port)
-{
-	struct ksz_device *dev = ds->priv;
-	int ret;
-
-	if (!dsa_is_user_port(ds, port))
-		return 0;
-
-	/* setup user port */
-	dev->dev_ops->port_setup(dev, port, false);
-
-	if (!is_ksz8(dev)) {
-		ret = ksz9477_set_default_prio_queue_mapping(dev, port);
-		if (ret)
-			return ret;
-	}
-
-	/* port_stp_state_set() will be called after to enable the port so
-	 * there is no need to do anything.
-	 */
-
-	return ksz_dcb_init_port(dev, port);
-}
-
 void ksz_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 {
 	struct ksz_device *dev = ds->priv;
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index f80034488cd1b..c66d75347c6cb 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -361,7 +361,6 @@ struct alu_struct {
 struct ksz_dev_ops {
 	u32 (*get_port_addr)(int port, int offset);
 	void (*cfg_port_member)(struct ksz_device *dev, int port, u8 member);
-	void (*port_setup)(struct ksz_device *dev, int port, bool cpu_port);
 
 	/**
 	 * @mdio_bus_preinit: Function pointer to pre-initialize the MDIO bus
@@ -427,7 +426,6 @@ int ksz_switch_suspend(struct device *dev);
 int ksz_switch_resume(struct device *dev);
 
 void ksz_teardown(struct dsa_switch *ds);
-int ksz_port_setup(struct dsa_switch *ds, int port);
 void ksz_port_teardown(struct dsa_switch *ds, int port);
 
 void ksz_init_mib_timer(struct ksz_device *dev);
@@ -515,6 +513,7 @@ int ksz_pirq_setup(struct ksz_device *dev, u8 p);
 int ksz_girq_setup(struct ksz_device *dev);
 void ksz_irq_free(struct ksz_irq *kirq);
 int ksz_parse_drive_strength(struct ksz_device *dev);
+int ksz9477_set_default_prio_queue_mapping(struct ksz_device *dev, int port);
 
 /* Common register access functions */
 static inline struct regmap *ksz_regmap_8(struct ksz_device *dev)
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index ecb072cd99819..aff0c2735c307 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -799,7 +799,6 @@ const struct phylink_mac_ops lan937x_phylink_mac_ops = {
 const struct ksz_dev_ops lan937x_dev_ops = {
 	.get_port_addr = ksz9477_get_port_addr,
 	.cfg_port_member = ksz9477_cfg_port_member,
-	.port_setup = lan937x_port_setup,
 	.mdio_bus_preinit = lan937x_mdio_bus_preinit,
 	.create_phy_addr_map = lan937x_create_phy_addr_map,
 	.r_phy = lan937x_r_phy,
@@ -823,7 +822,7 @@ const struct dsa_switch_ops lan937x_switch_ops = {
 	.phy_read		= ksz_phy_read16,
 	.phy_write		= ksz_phy_write16,
 	.phylink_get_caps	= lan937x_phylink_get_caps,
-	.port_setup		= ksz_port_setup,
+	.port_setup		= ksz9477_dsa_port_setup,
 	.set_ageing_time	= lan937x_set_ageing_time,
 	.get_strings		= ksz_get_strings,
 	.get_ethtool_stats	= ksz_get_ethtool_stats,

-- 
2.53.0


