Return-Path: <netdev+bounces-290243-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAg2GxGjDmpxAwYAu9opvQ
	(envelope-from <netdev+bounces-290243-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 08:15:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D254C59F57E
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 08:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62F3A30A11B1
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 06:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F15393DF1;
	Thu, 21 May 2026 06:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="uAGmaRju"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E8C393DEE
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 06:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779343973; cv=none; b=RHXSl78Qdhfks/ttYy3+n3vRUMiPFH1avRWm7hRzdTTzzVjZitb4231DLp54sf/Madymwb+YPTmbccMPN0VLVg8DCqsoFlsX2mJn9fBqOC0YtU53kyV8wclFibGQNaPohVLfwuuwdxrg8MKZqnyHiXHBpdW17zaC6/U+6ux5CsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779343973; c=relaxed/simple;
	bh=6n73pFhTpcZLxQRfz4ivY+stp1pbFDEiow6/MWEdWGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PzxCaLK8eWIh4FAA04SCIqb9VZ7xdcba7Hmp81M6C+3MVsuacbOOgxCjmWnk15Q0M0tkl/NmRM+Kj/26bF6YoTxKzzFBalNbnwIDeyIsMk9omH53CKCXF/cRPu/yJDzuPVNxquU3lMPjyhkOZSpl7mTipRXgyyBAxzqHIm03bhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uAGmaRju; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 248ED1A365B;
	Thu, 21 May 2026 06:12:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id ED8C460718;
	Thu, 21 May 2026 06:12:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C5F54107E8EC0;
	Thu, 21 May 2026 08:12:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779343968; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=KE7vzd75/LEUS+3wmexVFD85jTpKRD0C/qyM19ErV0g=;
	b=uAGmaRjuJ7w2rO0i0KClQBiJXOQKzt/f/++BJETd+9GWt8txBUFsmW37VEsvCgVMWKEAlC
	ddlDOULvdY6dg4bi4JDa5ZYDfjDHz2yIrmXc6ORHLIz5hz7KrH0Taij4wFAcBhMu8jtG8d
	jbHDW/0JmsAFA9Itd45bB3Ko3HskydwWzC6ERMU9IBfsGEDrQbwXVRnv5jv6HbHqSKhpSc
	pdPT2zfUl/49Ww5iasEFpAK5RUfBD8Akk7n+fNHhl4eMCZFz/JgpsUJHkgWtquZRA29ceD
	k0dL2UKDv6NIH3qkDblyL1O5KuyQK8lPmXIOeolXxgrcUrzSVo9LbxtB379Bag==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Thu, 21 May 2026 08:12:37 +0200
Subject: [PATCH net-next v3 2/8] net: dsa: microchip: bypass
 dev_ops->setup() and teardown() for lan937x
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-clean-ksz-2nd-series-v3-2-75c38971c19a@bootlin.com>
References: <20260521-clean-ksz-2nd-series-v3-0-75c38971c19a@bootlin.com>
In-Reply-To: <20260521-clean-ksz-2nd-series-v3-0-75c38971c19a@bootlin.com>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290243-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email]
X-Rspamd-Queue-Id: D254C59F57E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Vladimir Oltean <vladimir.oltean@nxp.com>

The KSZ switch families are sufficiently different that a common
ds->ops->setup() - ksz_setup() with micro-managed dev_ops->reset(),
dev_ops->pcs_create(), dev_ops->config_cpu_port(),
dev_ops->enable_stp_addr(), dev_ops->setup() seems to be too convoluted.

I am proposing to make each KSZ switch family part ways for
dsa_switch_ops :: setup() and teardown(), to allow them greater
flexibility. This here is the implementation for lan937x, which is
nothing other than a copy of ksz_setup() with the dev_ops function
pointers replaced with direct function calls.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c   |  12 ++--
 drivers/net/dsa/microchip/ksz_common.h   |   6 ++
 drivers/net/dsa/microchip/lan937x_main.c | 116 ++++++++++++++++++++++++++++---
 3 files changed, 116 insertions(+), 18 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index b1fe7428fc3e..185131399742 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2488,7 +2488,7 @@ static int ksz_parse_dt_phy_config(struct ksz_device *dev, struct mii_bus *bus,
  *
  * Return: 0 on success, or a negative error code on failure.
  */
-static int ksz_mdio_register(struct ksz_device *dev)
+int ksz_mdio_register(struct ksz_device *dev)
 {
 	struct device_node *parent_bus_node;
 	struct mii_bus *parent_bus = NULL;
@@ -2644,7 +2644,7 @@ static const struct irq_domain_ops ksz_irq_domain_ops = {
 	.xlate	= irq_domain_xlate_twocell,
 };
 
-static void ksz_irq_free(struct ksz_irq *kirq)
+void ksz_irq_free(struct ksz_irq *kirq)
 {
 	int irq, virq;
 
@@ -2713,7 +2713,7 @@ static int ksz_irq_common_setup(struct ksz_device *dev, struct ksz_irq *kirq)
 	return ret;
 }
 
-static int ksz_girq_setup(struct ksz_device *dev)
+int ksz_girq_setup(struct ksz_device *dev)
 {
 	struct ksz_irq *girq = &dev->girq;
 
@@ -2728,7 +2728,7 @@ static int ksz_girq_setup(struct ksz_device *dev)
 	return ksz_irq_common_setup(dev, girq);
 }
 
-static int ksz_pirq_setup(struct ksz_device *dev, u8 p)
+int ksz_pirq_setup(struct ksz_device *dev, u8 p)
 {
 	struct ksz_irq *pirq = &dev->ports[p].pirq;
 
@@ -2745,8 +2745,6 @@ static int ksz_pirq_setup(struct ksz_device *dev, u8 p)
 	return ksz_irq_common_setup(dev, pirq);
 }
 
-static int ksz_parse_drive_strength(struct ksz_device *dev);
-
 int ksz_setup(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
@@ -4694,7 +4692,7 @@ static int ksz88x3_drive_strength_write(struct ksz_device *dev,
  *
  * Return: 0 on success, error code otherwise
  */
-static int ksz_parse_drive_strength(struct ksz_device *dev)
+int ksz_parse_drive_strength(struct ksz_device *dev)
 {
 	struct ksz_driver_strength_prop of_props[] = {
 		[KSZ_DRIVER_STRENGTH_HI] = {
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 1cdb6661729a..5fad56c2d067 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -518,6 +518,12 @@ int ksz_hsr_leave(struct dsa_switch *ds, int port,
 int ksz_suspend(struct dsa_switch *ds);
 int ksz_resume(struct dsa_switch *ds);
 
+int ksz_mdio_register(struct ksz_device *dev);
+int ksz_pirq_setup(struct ksz_device *dev, u8 p);
+int ksz_girq_setup(struct ksz_device *dev);
+void ksz_irq_free(struct ksz_irq *kirq);
+int ksz_parse_drive_strength(struct ksz_device *dev);
+
 /* Common register access functions */
 static inline struct regmap *ksz_regmap_8(struct ksz_device *dev)
 {
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index 778e32f568df..ecb072cd9981 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -626,8 +626,49 @@ static int lan937x_switch_init(struct ksz_device *dev)
 static int lan937x_setup(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
+	u16 storm_mask, storm_rate;
+	struct dsa_port *dp;
+	struct ksz_port *p;
+	const u16 *regs;
 	int ret;
 
+	regs = dev->info->regs;
+
+	dev->vlan_cache = devm_kcalloc(dev->dev, sizeof(struct vlan_table),
+				       dev->info->num_vlans, GFP_KERNEL);
+	if (!dev->vlan_cache)
+		return -ENOMEM;
+
+	ret = lan937x_reset_switch(dev);
+	if (ret) {
+		dev_err(ds->dev, "failed to reset switch\n");
+		return ret;
+	}
+
+	ret = ksz_parse_drive_strength(dev);
+	if (ret)
+		return ret;
+
+	/* set broadcast storm protection 10% rate */
+	storm_mask = BROADCAST_STORM_RATE;
+	storm_rate = (BROADCAST_STORM_VALUE * BROADCAST_STORM_PROT_RATE) / 100;
+	regmap_update_bits(ksz_regmap_16(dev), regs[S_BROADCAST_CTRL],
+			   storm_mask, storm_rate);
+
+	lan937x_config_cpu_port(ds);
+
+	ksz9477_enable_stp_addr(dev);
+
+	ds->num_tx_queues = dev->info->num_tx_queues;
+
+	regmap_update_bits(ksz_regmap_8(dev), regs[S_MULTICAST_CTRL],
+			   MULTICAST_STORM_DISABLE, MULTICAST_STORM_DISABLE);
+
+	ksz_init_mib_timer(dev);
+
+	ds->configure_vlan_while_not_filtering = false;
+	ds->dscp_prio_mapping_is_global = true;
+
 	/* The VLAN aware is a global setting. Mixed vlan
 	 * filterings are not supported.
 	 */
@@ -659,13 +700,71 @@ static int lan937x_setup(struct dsa_switch *ds)
 		return ret;
 
 	/* Disable global VPHY support. Related to CPU interface only? */
-	return ksz_rmw32(dev, REG_SW_CFG_STRAP_OVR, SW_VPHY_DISABLE,
-			 SW_VPHY_DISABLE);
-}
+	ret = ksz_rmw32(dev, REG_SW_CFG_STRAP_OVR, SW_VPHY_DISABLE,
+			SW_VPHY_DISABLE);
+	if (ret < 0)
+		return ret;
 
-static void lan937x_teardown(struct dsa_switch *ds)
-{
+	/* Start with learning disabled on standalone user ports, and enabled
+	 * on the CPU port. In lack of other finer mechanisms, learning on the
+	 * CPU port will avoid flooding bridge local addresses on the network
+	 * in some cases.
+	 */
+	p = &dev->ports[dev->cpu_port];
+	p->learning = true;
 
+	if (dev->irq > 0) {
+		ret = ksz_girq_setup(dev);
+		if (ret)
+			return ret;
+
+		dsa_switch_for_each_user_port(dp, dev->ds) {
+			ret = ksz_pirq_setup(dev, dp->index);
+			if (ret)
+				goto port_release;
+
+			ret = ksz_ptp_irq_setup(ds, dp->index);
+			if (ret)
+				goto pirq_release;
+		}
+	}
+
+	ret = ksz_ptp_clock_register(ds);
+	if (ret) {
+		dev_err(dev->dev, "Failed to register PTP clock: %d\n",
+			ret);
+		goto port_release;
+	}
+
+	ret = ksz_mdio_register(dev);
+	if (ret < 0) {
+		dev_err(dev->dev, "failed to register the mdio");
+		goto out_ptp_clock_unregister;
+	}
+
+	ret = ksz_dcb_init(dev);
+	if (ret)
+		goto out_ptp_clock_unregister;
+
+	/* start switch */
+	regmap_update_bits(ksz_regmap_8(dev), regs[S_START_CTRL],
+			   SW_START, SW_START);
+
+	return 0;
+
+out_ptp_clock_unregister:
+	ksz_ptp_clock_unregister(ds);
+port_release:
+	if (dev->irq > 0) {
+		dsa_switch_for_each_user_port_continue_reverse(dp, dev->ds) {
+			ksz_ptp_irq_free(ds, dp->index);
+pirq_release:
+			ksz_irq_free(&dev->ports[dp->index].pirq);
+		}
+		ksz_irq_free(&dev->girq);
+	}
+
+	return ret;
 }
 
 static enum dsa_tag_protocol lan937x_get_tag_protocol(struct dsa_switch *ds,
@@ -698,8 +797,6 @@ const struct phylink_mac_ops lan937x_phylink_mac_ops = {
 };
 
 const struct ksz_dev_ops lan937x_dev_ops = {
-	.setup = lan937x_setup,
-	.teardown = lan937x_teardown,
 	.get_port_addr = ksz9477_get_port_addr,
 	.cfg_port_member = ksz9477_cfg_port_member,
 	.port_setup = lan937x_port_setup,
@@ -713,10 +810,7 @@ const struct ksz_dev_ops lan937x_dev_ops = {
 	.freeze_mib = ksz9477_freeze_mib,
 	.port_init_cnt = ksz9477_port_init_cnt,
 	.setup_rgmii_delay = lan937x_setup_rgmii_delay,
-	.config_cpu_port = lan937x_config_cpu_port,
 	.tc_cbs_set_cinc = lan937x_tc_cbs_set_cinc,
-	.enable_stp_addr = ksz9477_enable_stp_addr,
-	.reset = lan937x_reset_switch,
 	.init = lan937x_switch_init,
 };
 
@@ -724,7 +818,7 @@ const struct dsa_switch_ops lan937x_switch_ops = {
 	.get_tag_protocol	= lan937x_get_tag_protocol,
 	.connect_tag_protocol   = lan937x_connect_tag_protocol,
 	.get_phy_flags		= ksz_get_phy_flags,
-	.setup			= ksz_setup,
+	.setup			= lan937x_setup,
 	.teardown		= ksz_teardown,
 	.phy_read		= ksz_phy_read16,
 	.phy_write		= ksz_phy_write16,

-- 
2.54.0


