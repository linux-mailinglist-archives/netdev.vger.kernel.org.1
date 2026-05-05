Return-Path: <netdev+bounces-284441-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEV6O1z/+WkqFwMAu9opvQ
	(envelope-from <netdev+bounces-284441-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 16:31:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 771EF4CF709
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 16:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6D2A309F26A
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 14:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63BF481ABE;
	Tue,  5 May 2026 14:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PoMxpjUP"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679EB480357
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777991134; cv=none; b=lUDiNIJ/pEFMVXN6INjK2ZUHV8ne8elnXyv7PYT4Jd39ROHHyvSkxYveuiKqswa7wTMAivVkhB4Fsk6Ub00cbR3M14TAlrl0BlXSIa9DDRBiRyxxFyddZb6NYiFovwrrCE/s7+YcEDVqv6JHiDzGx9XmyEbjKt4JRszM/sNDAps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777991134; c=relaxed/simple;
	bh=fZZoRc5mzNdkCS4RdqcBdQ10gR1IJ4ozw6vGH/k+MTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E2AQn0dZuozLGWbz0ZaYDhRovuu+nsFsG9kSgusThOQCUgud7CgJ47lIi2zoCARCM6ZsqEjpTUoBM1oENwxrQEjXcQyzt4cQ2hq5MHp8vzKvycwHRsiAnj2SMpKMIU3SrH6bAvhvVvrLpCkKsoiybnvPqRW0/TUGMdR8CHE6XgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PoMxpjUP; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D9E2EC5CD40;
	Tue,  5 May 2026 14:26:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0A0F36053C;
	Tue,  5 May 2026 14:25:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1BC3111AD0247;
	Tue,  5 May 2026 16:25:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777991128; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1QxfhcDiWl1zUizvqG2lvFv0tO3RiDLHy/e6u5z0xpI=;
	b=PoMxpjUPPGAm+NC0f6RLCUVneBz9DTy03noBwFBYnU9izScRL8j/jIyDkk6OPWiTB/GRCn
	EJsbstH9ihqv3O0r57m6NQRlZVtvvPGlGbT1znRnRAtkwfwxTlo8wKqNZQPpgU2Vt9/f6P
	GR1Csy4lXLkxt3vBCKEqi27Es491gDg4YLwwDEXLugGq26UmkwFHAhPqm1n6l+jQFpdg2j
	Qgv5rJL1dY17Fa6PmGOrsgci1SuO4nVsJ5Oqp71/TDr29WkmFK+d3W4AVo77IitrYBnMVQ
	AP5SDsLRkHcvsI6+6upR/tHfvKalIIPLQ53f3VNl99vinYHdj3A4/EQqx2BM/g==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Tue, 05 May 2026 16:25:07 +0200
Subject: [PATCH net-next 7/9] net: dsa: microchip: hook up
 ksz_switch_alloc() to chip-specific dsa_switch_ops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-clean-ksz-driver-v1-7-05d70fa42461@bootlin.com>
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
X-Rspamd-Queue-Id: 771EF4CF709
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284441-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid]

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Now that each switch driver has its own dsa_switch_ops (currently a copy
of ksz_switch_ops), we no longer need ksz_switch_ops and can remove it.

Get to the driver-specific dsa_switch_ops through the ksz_chip_data
structure.
Reorder the alloc()/get_match_data() calls such as to have that
pointer available.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8863_smi.c |  8 ++--
 drivers/net/dsa/microchip/ksz9477_i2c.c |  8 ++--
 drivers/net/dsa/microchip/ksz_common.c  | 67 ++-------------------------------
 drivers/net/dsa/microchip/ksz_common.h  |  4 +-
 drivers/net/dsa/microchip/ksz_spi.c     |  8 ++--
 5 files changed, 19 insertions(+), 76 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8863_smi.c b/drivers/net/dsa/microchip/ksz8863_smi.c
index a8bfcd917bf70..ba08d2cf8e99f 100644
--- a/drivers/net/dsa/microchip/ksz8863_smi.c
+++ b/drivers/net/dsa/microchip/ksz8863_smi.c
@@ -140,14 +140,14 @@ static int ksz8863_smi_probe(struct mdio_device *mdiodev)
 	int ret;
 	int i;
 
-	dev = ksz_switch_alloc(&mdiodev->dev, mdiodev);
-	if (!dev)
-		return -ENOMEM;
-
 	chip = device_get_match_data(ddev);
 	if (!chip)
 		return -EINVAL;
 
+	dev = ksz_switch_alloc(&mdiodev->dev, chip, mdiodev);
+	if (!dev)
+		return -ENOMEM;
+
 	for (i = 0; i < __KSZ_NUM_REGMAPS; i++) {
 		rc = ksz8863_regmap_config[i];
 		rc.lock_arg = &dev->regmap_mutex;
diff --git a/drivers/net/dsa/microchip/ksz9477_i2c.c b/drivers/net/dsa/microchip/ksz9477_i2c.c
index a2beb27459f18..8e9d08f2e1d65 100644
--- a/drivers/net/dsa/microchip/ksz9477_i2c.c
+++ b/drivers/net/dsa/microchip/ksz9477_i2c.c
@@ -22,14 +22,14 @@ static int ksz9477_i2c_probe(struct i2c_client *i2c)
 	struct ksz_device *dev;
 	int i, ret;
 
-	dev = ksz_switch_alloc(&i2c->dev, i2c);
-	if (!dev)
-		return -ENOMEM;
-
 	chip = device_get_match_data(ddev);
 	if (!chip)
 		return -EINVAL;
 
+	dev = ksz_switch_alloc(&i2c->dev, chip, i2c);
+	if (!dev)
+		return -ENOMEM;
+
 	/* Save chip id to do special initialization when probing. */
 	dev->chip_id = chip->chip_id;
 	for (i = 0; i < __KSZ_NUM_REGMAPS; i++) {
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index e48b9d5c06301..37e575bf4e14d 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -4640,68 +4640,9 @@ int ksz_resume(struct dsa_switch *ds)
 	return 0;
 }
 
-static const struct dsa_switch_ops ksz_switch_ops = {
-	.get_tag_protocol	= ksz_get_tag_protocol,
-	.connect_tag_protocol   = ksz_connect_tag_protocol,
-	.get_phy_flags		= ksz_get_phy_flags,
-	.setup			= ksz_setup,
-	.teardown		= ksz_teardown,
-	.phy_read		= ksz_phy_read16,
-	.phy_write		= ksz_phy_write16,
-	.phylink_get_caps	= ksz_phylink_get_caps,
-	.port_setup		= ksz_port_setup,
-	.set_ageing_time	= ksz_set_ageing_time,
-	.get_strings		= ksz_get_strings,
-	.get_ethtool_stats	= ksz_get_ethtool_stats,
-	.get_sset_count		= ksz_sset_count,
-	.port_bridge_join	= ksz_port_bridge_join,
-	.port_bridge_leave	= ksz_port_bridge_leave,
-	.port_hsr_join		= ksz_hsr_join,
-	.port_hsr_leave		= ksz_hsr_leave,
-	.port_set_mac_address	= ksz_port_set_mac_address,
-	.port_stp_state_set	= ksz_port_stp_state_set,
-	.port_teardown		= ksz_port_teardown,
-	.port_pre_bridge_flags	= ksz_port_pre_bridge_flags,
-	.port_bridge_flags	= ksz_port_bridge_flags,
-	.port_fast_age		= ksz_port_fast_age,
-	.port_vlan_filtering	= ksz_port_vlan_filtering,
-	.port_vlan_add		= ksz_port_vlan_add,
-	.port_vlan_del		= ksz_port_vlan_del,
-	.port_fdb_dump		= ksz_port_fdb_dump,
-	.port_fdb_add		= ksz_port_fdb_add,
-	.port_fdb_del		= ksz_port_fdb_del,
-	.port_mdb_add           = ksz_port_mdb_add,
-	.port_mdb_del           = ksz_port_mdb_del,
-	.port_mirror_add	= ksz_port_mirror_add,
-	.port_mirror_del	= ksz_port_mirror_del,
-	.get_stats64		= ksz_get_stats64,
-	.get_pause_stats	= ksz_get_pause_stats,
-	.port_change_mtu	= ksz_change_mtu,
-	.port_max_mtu		= ksz_max_mtu,
-	.get_wol		= ksz_get_wol,
-	.set_wol		= ksz_set_wol,
-	.suspend		= ksz_suspend,
-	.resume			= ksz_resume,
-	.get_ts_info		= ksz_get_ts_info,
-	.port_hwtstamp_get	= ksz_hwtstamp_get,
-	.port_hwtstamp_set	= ksz_hwtstamp_set,
-	.port_txtstamp		= ksz_port_txtstamp,
-	.port_rxtstamp		= ksz_port_rxtstamp,
-	.cls_flower_add		= ksz_cls_flower_add,
-	.cls_flower_del		= ksz_cls_flower_del,
-	.port_setup_tc		= ksz_setup_tc,
-	.support_eee		= ksz_support_eee,
-	.set_mac_eee		= ksz_set_mac_eee,
-	.port_get_default_prio	= ksz_port_get_default_prio,
-	.port_set_default_prio	= ksz_port_set_default_prio,
-	.port_get_dscp_prio	= ksz_port_get_dscp_prio,
-	.port_add_dscp_prio	= ksz_port_add_dscp_prio,
-	.port_del_dscp_prio	= ksz_port_del_dscp_prio,
-	.port_get_apptrust	= ksz_port_get_apptrust,
-	.port_set_apptrust	= ksz_port_set_apptrust,
-};
-
-struct ksz_device *ksz_switch_alloc(struct device *base, void *priv)
+struct ksz_device *ksz_switch_alloc(struct device *base,
+				    const struct ksz_chip_data *chip,
+				    void *priv)
 {
 	struct dsa_switch *ds;
 	struct ksz_device *swdev;
@@ -4712,7 +4653,7 @@ struct ksz_device *ksz_switch_alloc(struct device *base, void *priv)
 
 	ds->dev = base;
 	ds->num_ports = DSA_MAX_PORTS;
-	ds->ops = &ksz_switch_ops;
+	ds->ops = chip->switch_ops;
 
 	swdev = devm_kzalloc(base, sizeof(*swdev), GFP_KERNEL);
 	if (!swdev)
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 125740deb5a21..37923a1c43d80 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -460,7 +460,9 @@ struct ksz_dev_ops {
 	int (*pcs_create)(struct ksz_device *dev);
 };
 
-struct ksz_device *ksz_switch_alloc(struct device *base, void *priv);
+struct ksz_device *ksz_switch_alloc(struct device *base,
+				    const struct ksz_chip_data *chip,
+				    void *priv);
 int ksz_switch_register(struct ksz_device *dev);
 void ksz_switch_remove(struct ksz_device *dev);
 int ksz_switch_suspend(struct device *dev);
diff --git a/drivers/net/dsa/microchip/ksz_spi.c b/drivers/net/dsa/microchip/ksz_spi.c
index d8001734b0574..373e9054947cb 100644
--- a/drivers/net/dsa/microchip/ksz_spi.c
+++ b/drivers/net/dsa/microchip/ksz_spi.c
@@ -143,14 +143,14 @@ static int ksz_spi_probe(struct spi_device *spi)
 	struct ksz_device *dev;
 	int i, ret = 0;
 
-	dev = ksz_switch_alloc(&spi->dev, spi);
-	if (!dev)
-		return -ENOMEM;
-
 	chip = device_get_match_data(ddev);
 	if (!chip)
 		return -EINVAL;
 
+	dev = ksz_switch_alloc(&spi->dev, chip, spi);
+	if (!dev)
+		return -ENOMEM;
+
 	/* Save chip id to do special initialization when probing. */
 	dev->chip_id = chip->chip_id;
 	if (chip->chip_id == KSZ88X3_CHIP_ID)

-- 
2.53.0


