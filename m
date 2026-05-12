Return-Path: <netdev+bounces-287140-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPJvFZYrA2oR1QEAu9opvQ
	(envelope-from <netdev+bounces-287140-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:31:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD9652136C
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E108531F9B09
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B663ADB98;
	Tue, 12 May 2026 13:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="07A3RIqQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B293ABD8C
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 13:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591214; cv=none; b=mDd7SaakPqZPUYcZvKDbebzAvdb0R72IjROLsDzm8EzgS2fXa9BP0zcHLz8nkbEXubEOlTN/RpCaRcoq5dbxg/BnTeubeQZy/FO54lmaiKqo7XNOl8jximtNliG2VwIJG6p9Xfy7qxayneMU5JPT1Vjub3Zbr1heBYe1YIsmbV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591214; c=relaxed/simple;
	bh=60aFW4V4GTvfB24uYIgPrxz/3uWCxAGVGCyDQlzDzXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=raFG4EzpmdJaa48PKUYUhlpXj4okJxLN5uAyNq7PtT2U5yvlxCF437G/gl1n1ysKRKDHra6hp+GPR3OZ3DCU2H1ytztj4qcbUxfkr2moJjogRpZcxzEgJeKvOu+yzGgnE1hKNsFRuMXjmDlbF55G5mklBhv8NK1CLgEl2Sz4U7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=07A3RIqQ; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 06B2EC5E179;
	Tue, 12 May 2026 13:07:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0A04A60646;
	Tue, 12 May 2026 13:06:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2F68111AF8CCF;
	Tue, 12 May 2026 15:06:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778591210; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=K7E43902GBnBBbjdgg4XoXQdGAeE/npvQExkC6ETSbM=;
	b=07A3RIqQFeKJzg5nsmDVXh0oVrARvvLL/vSQm5jTRBzJ8mDyv+ICkKJ+fgl3Q7lPFeOlmP
	A1suDghej16do5DfvjxNGRh9lVgdOfzjtXtXI+7/VxZAVffNUSwwHrZwRrfo9U8gFBA7PF
	BAOkMwwdnsGaQsiuwFO4UOAle8WM6F+7MAUNcmR2IF+LgwEOLzlEpxjpevo1ZosNP8X7bq
	eGU8FUz81cUo/ZfVsgQj04dGbP4OaGkcX11q9QZwPKuWmPxfJRfv04LqqZD0Dx5K+aOteo
	9jdPd8R11jy8nYL5LDKPHx5pVRasiMnaZZI7IV+NFH2frRHCU4+qKIXk5utwqw==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Tue, 12 May 2026 15:06:29 +0200
Subject: [PATCH net-next 07/15] net: dsa: microchip: bypass dev_ops for
 phylink_get_caps()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-clean-ksz-2nd-series-v1-7-c00f6ce037fa@bootlin.com>
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
X-Rspamd-Queue-Id: CAD9652136C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287140-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Vladimir Oltean <vladimir.oltean@nxp.com>

ksz_phylink_get_caps() is a bit different from other generic methods.
It has a dev_ops->get_caps() call in the middle of the function, and it
does other stuff before (set some supported_interfaces) and after (set
lpi_interfaces from supported_interfaces).

Whereas the dev_ops->get_caps() methods set mac_capabilities and
(optionally) logically OR the supported_interfaces with that of the PCS.

The idea is that this can be expressed simpler, and avoid a indirect
function call to dev_ops->get_caps(). If we tail-call the common
ksz_phylink_get_caps() from individual phylink_get_caps() methods, we do
reorder the settings, but in an inconsequential way (the transfer from
supported_interfaces to lpi_interfaces still sees a complete list of the
supported_interfaces).
Remove the no longer used get_caps() callbacl the ksz_dev_ops.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c         | 17 +++++++++--------
 drivers/net/dsa/microchip/ksz9477.c      | 11 +++++++----
 drivers/net/dsa/microchip/ksz_common.c   |  3 ---
 drivers/net/dsa/microchip/ksz_common.h   |  2 --
 drivers/net/dsa/microchip/lan937x_main.c |  9 ++++++---
 5 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 38876e1779564..825133e9ce6e6 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -1995,9 +1995,11 @@ static int ksz8_setup(struct dsa_switch *ds)
 		return ret;
 }
 
-static void ksz8_get_caps(struct ksz_device *dev, int port,
-			  struct phylink_config *config)
+static void ksz8_phylink_get_caps(struct dsa_switch *ds, int port,
+				  struct phylink_config *config)
 {
+	struct ksz_device *dev = ds->priv;
+
 	config->mac_capabilities = MAC_10 | MAC_100;
 
 	/* Silicon Errata Sheet (DS80000830A):
@@ -2011,6 +2013,8 @@ static void ksz8_get_caps(struct ksz_device *dev, int port,
 	/* Asym pause is not supported on KSZ8863 and KSZ8873 */
 	if (!ksz_is_ksz88x3(dev))
 		config->mac_capabilities |= MAC_ASYM_PAUSE;
+
+	ksz_phylink_get_caps(ds, port, config);
 }
 
 static u32 ksz8_get_port_addr(int port, int offset)
@@ -2218,7 +2222,6 @@ const struct ksz_dev_ops ksz8463_dev_ops = {
 	.r_mib_stat64 = ksz88xx_r_mib_stats64,
 	.freeze_mib = ksz8_freeze_mib,
 	.port_init_cnt = ksz8_port_init_cnt,
-	.get_caps = ksz8_get_caps,
 	.config_cpu_port = ksz8_config_cpu_port,
 	.enable_stp_addr = ksz8_enable_stp_addr,
 	.reset = ksz8_reset_switch,
@@ -2238,7 +2241,6 @@ const struct ksz_dev_ops ksz87xx_dev_ops = {
 	.r_mib_stat64 = ksz_r_mib_stats64,
 	.freeze_mib = ksz8_freeze_mib,
 	.port_init_cnt = ksz8_port_init_cnt,
-	.get_caps = ksz8_get_caps,
 	.config_cpu_port = ksz8_config_cpu_port,
 	.enable_stp_addr = ksz8_enable_stp_addr,
 	.reset = ksz8_reset_switch,
@@ -2261,7 +2263,6 @@ const struct ksz_dev_ops ksz88xx_dev_ops = {
 	.r_mib_stat64 = ksz88xx_r_mib_stats64,
 	.freeze_mib = ksz8_freeze_mib,
 	.port_init_cnt = ksz8_port_init_cnt,
-	.get_caps = ksz8_get_caps,
 	.config_cpu_port = ksz8_config_cpu_port,
 	.enable_stp_addr = ksz8_enable_stp_addr,
 	.reset = ksz8_reset_switch,
@@ -2280,7 +2281,7 @@ const struct dsa_switch_ops ksz8463_switch_ops = {
 	.teardown		= ksz_teardown,
 	.phy_read		= ksz_phy_read16,
 	.phy_write		= ksz_phy_write16,
-	.phylink_get_caps	= ksz_phylink_get_caps,
+	.phylink_get_caps	= ksz8_phylink_get_caps,
 	.port_setup		= ksz_port_setup,
 	.get_strings		= ksz_get_strings,
 	.get_ethtool_stats	= ksz_get_ethtool_stats,
@@ -2340,7 +2341,7 @@ const struct dsa_switch_ops ksz87xx_switch_ops = {
 	.teardown		= ksz_teardown,
 	.phy_read		= ksz_phy_read16,
 	.phy_write		= ksz_phy_write16,
-	.phylink_get_caps	= ksz_phylink_get_caps,
+	.phylink_get_caps	= ksz8_phylink_get_caps,
 	.port_setup		= ksz_port_setup,
 	.get_strings		= ksz_get_strings,
 	.get_ethtool_stats	= ksz_get_ethtool_stats,
@@ -2400,7 +2401,7 @@ const struct dsa_switch_ops ksz88xx_switch_ops = {
 	.teardown		= ksz_teardown,
 	.phy_read		= ksz_phy_read16,
 	.phy_write		= ksz_phy_write16,
-	.phylink_get_caps	= ksz_phylink_get_caps,
+	.phylink_get_caps	= ksz8_phylink_get_caps,
 	.port_setup		= ksz_port_setup,
 	.get_strings		= ksz_get_strings,
 	.get_ethtool_stats	= ksz_get_ethtool_stats,
diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 14ee9686ca0ab..65fd07ef73ad0 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1165,9 +1165,11 @@ static phy_interface_t ksz9477_get_interface(struct ksz_device *dev, int port)
 	return interface;
 }
 
-static void ksz9477_get_caps(struct ksz_device *dev, int port,
-			     struct phylink_config *config)
+static void ksz9477_phylink_get_caps(struct dsa_switch *ds, int port,
+				     struct phylink_config *config)
 {
+	struct ksz_device *dev = ds->priv;
+
 	config->mac_capabilities = MAC_10 | MAC_100 | MAC_ASYM_PAUSE |
 				   MAC_SYM_PAUSE;
 
@@ -1181,6 +1183,8 @@ static void ksz9477_get_caps(struct ksz_device *dev, int port,
 				 config->supported_interfaces,
 				 p->pcs->supported_interfaces);
 	}
+
+	ksz_phylink_get_caps(ds, port, config);
 }
 
 static int ksz9477_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
@@ -1791,7 +1795,6 @@ const struct ksz_dev_ops ksz9477_dev_ops = {
 	.r_mib_stat64 = ksz_r_mib_stats64,
 	.freeze_mib = ksz9477_freeze_mib,
 	.port_init_cnt = ksz9477_port_init_cnt,
-	.get_caps = ksz9477_get_caps,
 	.pme_write8 = ksz_write8,
 	.pme_pread8 = ksz_pread8,
 	.pme_pwrite8 = ksz_pwrite8,
@@ -1812,7 +1815,7 @@ const struct dsa_switch_ops ksz9477_switch_ops = {
 	.teardown		= ksz_teardown,
 	.phy_read		= ksz_phy_read16,
 	.phy_write		= ksz_phy_write16,
-	.phylink_get_caps	= ksz_phylink_get_caps,
+	.phylink_get_caps	= ksz9477_phylink_get_caps,
 	.port_setup		= ksz_port_setup,
 	.set_ageing_time	= ksz9477_set_ageing_time,
 	.get_strings		= ksz_get_strings,
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index ad7615849c7a4..4a7bcd1a93927 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1995,9 +1995,6 @@ void ksz_phylink_get_caps(struct dsa_switch *ds, int port,
 			  config->supported_interfaces);
 	}
 
-	if (dev->dev_ops->get_caps)
-		dev->dev_ops->get_caps(dev, port, config);
-
 	if (ds->ops->support_eee && ds->ops->support_eee(ds, port)) {
 		memcpy(config->lpi_interfaces, config->supported_interfaces,
 		       sizeof(config->lpi_interfaces));
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 94eb79fa34392..f6dad256a550f 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -408,8 +408,6 @@ struct ksz_dev_ops {
 	void (*r_mib_pkt)(struct ksz_device *dev, int port, u16 addr,
 			  u64 *dropped, u64 *cnt);
 	void (*r_mib_stat64)(struct ksz_device *dev, int port);
-	void (*get_caps)(struct ksz_device *dev, int port,
-			 struct phylink_config *config);
 	int (*pme_write8)(struct ksz_device *dev, u32 reg, u8 value);
 	int (*pme_pread8)(struct ksz_device *dev, int port, int offset,
 			  u8 *data);
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index 621139a2c3025..f84548168b371 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -575,9 +575,11 @@ static void lan937x_set_rgmii_rx_delay(struct ksz_device *dev, int port)
 	lan937x_set_tune_adj(dev, port, REG_PORT_XMII_CTRL_4, val);
 }
 
-static void lan937x_phylink_get_caps(struct ksz_device *dev, int port,
+static void lan937x_phylink_get_caps(struct dsa_switch *ds, int port,
 				     struct phylink_config *config)
 {
+	struct ksz_device *dev = ds->priv;
+
 	config->mac_capabilities = MAC_100FD;
 
 	if (dev->info->supports_rgmii[port]) {
@@ -588,6 +590,8 @@ static void lan937x_phylink_get_caps(struct ksz_device *dev, int port,
 		config->mac_capabilities |= MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
 					    MAC_100HD | MAC_10;
 	}
+
+	ksz_phylink_get_caps(ds, port, config);
 }
 
 static void lan937x_setup_rgmii_delay(struct ksz_device *dev, int port)
@@ -713,7 +717,6 @@ const struct ksz_dev_ops lan937x_dev_ops = {
 	.r_mib_stat64 = ksz_r_mib_stats64,
 	.freeze_mib = ksz9477_freeze_mib,
 	.port_init_cnt = ksz9477_port_init_cnt,
-	.get_caps = lan937x_phylink_get_caps,
 	.setup_rgmii_delay = lan937x_setup_rgmii_delay,
 	.config_cpu_port = lan937x_config_cpu_port,
 	.tc_cbs_set_cinc = lan937x_tc_cbs_set_cinc,
@@ -731,7 +734,7 @@ const struct dsa_switch_ops lan937x_switch_ops = {
 	.teardown		= ksz_teardown,
 	.phy_read		= ksz_phy_read16,
 	.phy_write		= ksz_phy_write16,
-	.phylink_get_caps	= ksz_phylink_get_caps,
+	.phylink_get_caps	= lan937x_phylink_get_caps,
 	.port_setup		= ksz_port_setup,
 	.set_ageing_time	= lan937x_set_ageing_time,
 	.get_strings		= ksz_get_strings,

-- 
2.53.0


