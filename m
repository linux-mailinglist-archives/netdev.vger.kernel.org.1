Return-Path: <netdev+bounces-306066-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 856ZMzhET2qrdAIAu9opvQ
	(envelope-from <netdev+bounces-306066-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 08:48:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3976572D552
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 08:48:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=yL8RKLNb;
	dmarc=pass (policy=reject) header.from=bootlin.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306066-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306066-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 664FB30AFEAB
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 06:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7E63D524D;
	Thu,  9 Jul 2026 06:42:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132B73DB645
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 06:42:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579372; cv=none; b=PcpNNAs0zrfVEAuX+K1UQ3oEOTmqZqZqvb0f4wEQ61meNAVI14OS7ZpstqJe47kJTM68zAqV2EexjJcIUJMNaPUlUb6F/RAnY0Yv9gKGzwCATJFXZVnKKKoMNn4fuU6injfJZM1LSqhTXTqbOmO6v7KBFNSTEA8xrWbsoBR0YTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579372; c=relaxed/simple;
	bh=mc7hiOteU3CZ4868i6bLAO9mO+bBNWYCjXQSHzW38GY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P0nAYmvPrDV28SDr38imNVx3KCVqTpUjJ8SIstn18hVnLgatb86iOzNI8ISwlfIUel611DkY7n0v8/2AxPWDqYfjxR76tTmbNApKv7FF+2olM3fxTTs5KHnEJvcKKwGvHZO3PM7oi94OXzgVovjXxy5HnMT9fxh/3JOFrIuokpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=yL8RKLNb; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2F1E94E40D0F;
	Thu,  9 Jul 2026 06:42:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 032835FF03;
	Thu,  9 Jul 2026 06:42:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F1BA511BC207F;
	Thu,  9 Jul 2026 08:42:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783579355; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Xotl02O4I//qHcQ5+VsDC7vl+DBFEv9YGmQpTTwyJT4=;
	b=yL8RKLNbghB0tlqZfJT0X0ULuLu13EHM771P4nvpKp7psPDbBAA9Q7DZLu8zVm7w/8LokT
	MuttT+jFpcyf0e6lhQ22AWXmTwbHXiNTiQ5l4YDNa5x4HXGOps9DMiY0VQo4RpAFojTha5
	ci/ODfBhTk23UrSw1C7m/iiTByk+plUmkFpvimUXEJYuOLKd9neQqAxCXlU1pI+14gxthh
	aNloLSyR7OG1pf/gaUWDWsWSb0E8QiMOjgWf7CgLntJr3T8TuMaVj9HLJ6eA549o8CTU6h
	ZQMe12X8RkXdAno4ciD0yWU/+gatutZzzW2CyEQwBqh5Syn2EFgYJc5R3UycWw==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 09 Jul 2026 08:42:27 +0200
Subject: [PATCH net-next 01/10] net: dsa: microchip: implement
 ksz8463_setup()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-ksz-new-ptp-v1-1-344f02fe739e@bootlin.com>
References: <20260709-ksz-new-ptp-v1-0-344f02fe739e@bootlin.com>
In-Reply-To: <20260709-ksz-new-ptp-v1-0-344f02fe739e@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,bootlin.com];
	FORGED_RECIPIENTS(0.00)[m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:horms@kernel.org,m:maxime.chevallier@bootlin.com,m:pascal.eberhard@se.com,m:miquel.raynal@bootlin.com,m:thomas.petazzoni@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bastien.curutchet@bootlin.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306066-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:from_mime,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3976572D552

KSZ8463 uses the ksz8_setup() as setup() callback for its DSA
operations. Its behavior is quite different than other KSZ8 switches,
especially its interrupt scheme.

Remove from the ksz8_setup()/ksz8_reset_switch() everything that is
ksz8463-related.
Create a dedicated ksz8463_setup() and a ksz8463_reset_switch() function.
This new ksz8463_setup() is widely inspired from ksz8_setup, it has
following differences:
- it doesn't configure drive strength (not supported on KSZ8463)
- it uses the ksz8463_reset_switch()
- it doesn't configure IRQs
- it doesn't call ksz8_handle_global_errata() (the handled errata only
  affects the KSZ87xx variant)
Remove the teardown implementation from the KSZ8463 operations. Since
PTP and interrupts aren't setup, the common ksz_teardown() wouldn't do
anything anyway.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c | 126 +++++++++++++++++++++++++++++++++++----
 1 file changed, 114 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index c4c769028a20..5ed63f425013 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -181,6 +181,14 @@ static int ksz8_pme_pwrite8(struct ksz_device *dev, int port, int offset, u8 dat
 	return ksz8_ind_write8(dev, table, (u8)(offset), data);
 }
 
+static int ksz8463_reset_switch(struct ksz_device *dev)
+{
+	ksz_cfg(dev, KSZ8463_REG_SW_RESET, KSZ8463_GLOBAL_SOFTWARE_RESET, true);
+	ksz_cfg(dev, KSZ8463_REG_SW_RESET, KSZ8463_GLOBAL_SOFTWARE_RESET,
+		false);
+	return 0;
+}
+
 static int ksz8_reset_switch(struct ksz_device *dev)
 {
 	if (ksz_is_ksz88x3(dev)) {
@@ -189,11 +197,6 @@ static int ksz8_reset_switch(struct ksz_device *dev)
 			KSZ8863_GLOBAL_SOFTWARE_RESET | KSZ8863_PCS_RESET, true);
 		ksz_cfg(dev, KSZ8863_REG_SW_RESET,
 			KSZ8863_GLOBAL_SOFTWARE_RESET | KSZ8863_PCS_RESET, false);
-	} else if (ksz_is_ksz8463(dev)) {
-		ksz_cfg(dev, KSZ8463_REG_SW_RESET,
-			KSZ8463_GLOBAL_SOFTWARE_RESET, true);
-		ksz_cfg(dev, KSZ8463_REG_SW_RESET,
-			KSZ8463_GLOBAL_SOFTWARE_RESET, false);
 	} else {
 		/* reset switch */
 		ksz_write8(dev, REG_POWER_MANAGEMENT_1,
@@ -2300,6 +2303,110 @@ static void ksz88xx_r_mib_stats64(struct ksz_device *dev, int port)
 	spin_unlock(&mib->stats64_lock);
 }
 
+static int ksz8463_setup(struct dsa_switch *ds)
+{
+	struct ksz_device *dev = ds->priv;
+	u16 storm_mask, storm_rate;
+	struct ksz_port *p;
+	const u16 *regs;
+	int i, ret;
+
+	regs = dev->info->regs;
+
+	dev->vlan_cache = devm_kcalloc(dev->dev, sizeof(struct vlan_table),
+				       dev->info->num_vlans, GFP_KERNEL);
+	if (!dev->vlan_cache)
+		return -ENOMEM;
+
+	ret = ksz8463_reset_switch(dev);
+	if (ret) {
+		dev_err(ds->dev, "failed to reset switch\n");
+		return ret;
+	}
+
+	/* set broadcast storm protection 10% rate */
+	storm_mask = BROADCAST_STORM_RATE;
+	storm_rate = (BROADCAST_STORM_VALUE * BROADCAST_STORM_PROT_RATE) / 100;
+	storm_mask = swab16(storm_mask);
+	storm_rate = swab16(storm_rate);
+	regmap_update_bits(ksz_regmap_16(dev), regs[S_BROADCAST_CTRL],
+			   storm_mask, storm_rate);
+
+	ksz8_config_cpu_port(ds);
+
+	ksz8_enable_stp_addr(dev);
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
+	ds->mtu_enforcement_ingress = true;
+
+	/* We rely on software untagging on the CPU port, so that we
+	 * can support both tagged and untagged VLANs
+	 */
+	ds->untag_bridge_pvid = true;
+
+	/* VLAN filtering is partly controlled by the global VLAN
+	 * Enable flag
+	 */
+	ds->vlan_filtering_is_global = true;
+
+	/* Enable automatic fast aging when link changed detected. */
+	ksz_cfg(dev, S_LINK_AGING_CTRL, SW_LINK_AUTO_AGING, true);
+
+	/* Enable aggressive back off algorithm in half duplex mode. */
+	ret = ksz_rmw8(dev, REG_SW_CTRL_1, SW_AGGR_BACKOFF, SW_AGGR_BACKOFF);
+	if (ret)
+		return ret;
+
+	/*
+	 * Make sure unicast VLAN boundary is set as default and
+	 * enable no excessive collision drop.
+	 */
+	ret = ksz_rmw8(dev, REG_SW_CTRL_2,
+		       UNICAST_VLAN_BOUNDARY | NO_EXC_COLLISION_DROP,
+		       UNICAST_VLAN_BOUNDARY | NO_EXC_COLLISION_DROP);
+	if (ret)
+		return ret;
+
+	ksz_cfg(dev, S_REPLACE_VID_CTRL, SW_REPLACE_VID, false);
+
+	ksz_cfg(dev, S_MIRROR_CTRL, SW_MIRROR_RX_TX, false);
+
+	for (i = 0; i < (dev->info->num_vlans / 4); i++)
+		ksz8_r_vlan_entries(dev, i);
+
+	/* Start with learning disabled on standalone user ports, and enabled
+	 * on the CPU port. In lack of other finer mechanisms, learning on the
+	 * CPU port will avoid flooding bridge local addresses on the network
+	 * in some cases.
+	 */
+	p = &dev->ports[dev->cpu_port];
+	p->learning = true;
+
+	ret = ksz_mdio_register(dev);
+	if (ret < 0) {
+		dev_err(dev->dev, "failed to register the mdio");
+		return ret;
+	}
+
+	ret = ksz_dcb_init(dev);
+	if (ret)
+		return ret;
+
+	/* start switch */
+	regmap_update_bits(ksz_regmap_8(dev), regs[S_START_CTRL],
+			   SW_START, SW_START);
+
+	return 0;
+}
+
 /**
  * ksz88x3_drive_strength_write() - Set the drive strength configuration for
  *				    KSZ8863 compatible chip variants.
@@ -2445,10 +2552,6 @@ static int ksz8_setup(struct dsa_switch *ds)
 	/* set broadcast storm protection 10% rate */
 	storm_mask = BROADCAST_STORM_RATE;
 	storm_rate = (BROADCAST_STORM_VALUE * BROADCAST_STORM_PROT_RATE) / 100;
-	if (ksz_is_ksz8463(dev)) {
-		storm_mask = swab16(storm_mask);
-		storm_rate = swab16(storm_rate);
-	}
 	regmap_update_bits(ksz_regmap_16(dev), regs[S_BROADCAST_CTRL],
 			   storm_mask, storm_rate);
 
@@ -2499,7 +2602,7 @@ static int ksz8_setup(struct dsa_switch *ds)
 
 	ksz_cfg(dev, S_MIRROR_CTRL, SW_MIRROR_RX_TX, false);
 
-	if (!ksz_is_ksz88x3(dev) && !ksz_is_ksz8463(dev))
+	if (!ksz_is_ksz88x3(dev))
 		ksz_cfg(dev, REG_SW_CTRL_19, SW_INS_TAG_ENABLE, true);
 
 	for (i = 0; i < (dev->info->num_vlans / 4); i++)
@@ -2889,8 +2992,7 @@ const struct ksz_dev_ops ksz88xx_dev_ops = {
 const struct dsa_switch_ops ksz8463_switch_ops = {
 	.get_tag_protocol	= ksz8463_get_tag_protocol,
 	.connect_tag_protocol   = ksz8463_connect_tag_protocol,
-	.setup			= ksz8_setup,
-	.teardown		= ksz_teardown,
+	.setup			= ksz8463_setup,
 	.phy_read		= ksz8463_phy_read16,
 	.phy_write		= ksz8463_phy_write16,
 	.phylink_get_caps	= ksz8_phylink_get_caps,

-- 
2.54.0


