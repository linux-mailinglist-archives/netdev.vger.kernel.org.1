Return-Path: <netdev+bounces-290244-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OkdI1ijDmpxAwYAu9opvQ
	(envelope-from <netdev+bounces-290244-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 08:16:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1233859F596
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 08:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C91D330C541B
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 06:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A403F3783BB;
	Thu, 21 May 2026 06:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PKG3zkUW"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9719394EA7
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 06:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779343978; cv=none; b=l64+iAh6VX6IaqK1+NM7PscKCFLMW7I7bJqX0ZGWh2YvEx8dOBlTO4NnqkX4xcvtFZJXPWI/yG4SJj3JfQZf4g7zwyMa+DehJId0faJm5EH7rbbrNS6iy1hLSbp14iws84bdLOT2f2+j5yMMzKceljoFZTZ/8uKUTio3UeYISkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779343978; c=relaxed/simple;
	bh=NltFvwOAM4viNi+4j8BaeJsOC5LZBG6x/Fk+OleHO3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DctA2hPB4/B9+wSNM1fLPKINYmNz3OfyTW5QvctkSP0vHtzH2aYu0nZv/vFMBwHfVuNzqSyZstB6otaaws5warf9aoZsahNTuDx1pdU9rXtyc8OJ8wrS0j/ke/vEXPxTA8+iNRf97Il1q+vWyMPPooP20oEZqOOHBQJvYMHc6vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PKG3zkUW; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 90C871A3659;
	Thu, 21 May 2026 06:12:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 64CB060718;
	Thu, 21 May 2026 06:12:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2B15B107EA39F;
	Thu, 21 May 2026 08:12:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779343971; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nmENppGHEm6dYHHEJm+QZ3PPtAuIOcxQyD/PO6i+mZY=;
	b=PKG3zkUWfLHyOAqr5hPT1y0tbw2kbTgd8HYWtBjcWQdKuf2DHyvOGKeUxqyjjdpF7C4teh
	ivQW0idk70zmnREDUL4v1YzO5w2vRdVNQ61+Y9wW73qEjFH8G4UN4tw3eV+61qckW8u9H4
	Kea74VoMoPvxhf4iclGvHaGgCV8FyqiynF/OD40AxSXHa97wZcHtrr3v+xWJoCn3VwMhRq
	rQvRNJs2x5ubj+qgjtGc8evjEkqLLOB4y0PgRIMuYBv4wUPm99jWb73UgA4rKnK9sDfgXL
	43Jx7CgPj6jlRSRpTqP743dwfITk2tQzey7OEqP5pkVvax19qIHnF26hZNTUmA==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Thu, 21 May 2026 08:12:38 +0200
Subject: [PATCH net-next v3 3/8] net: dsa: microchip: bypass
 dev_ops->setup() and teardown() for ksz9477
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-clean-ksz-2nd-series-v3-3-75c38971c19a@bootlin.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290244-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email]
X-Rspamd-Queue-Id: 1233859F596
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Vladimir Oltean <vladimir.oltean@nxp.com>

The KSZ switch families are sufficiently different that a common
ds->ops->setup() - ksz_setup() with micro-managed dev_ops->reset(),
dev_ops->pcs_create(), dev_ops->config_cpu_port(),
dev_ops->enable_stp_addr(), dev_ops->setup() seems to be too convoluted.

I am proposing to make each KSZ switch family part ways for
dsa_switch_ops :: setup() and teardown(), to allow them greater
flexibility. This here is the implementation for ksz9477, which is
nothing other than a copy of ksz_setup() with the dev_ops function
pointers replaced with direct function calls.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz9477.c | 127 +++++++++++++++++++++++++++++++++---
 1 file changed, 118 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 88a5ff62aae8..7385aa4e788a 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1477,9 +1477,54 @@ int ksz9477_enable_stp_addr(struct ksz_device *dev)
 static int ksz9477_setup(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
-	const u16 *regs = dev->info->regs;
-	int ret = 0;
+	u16 storm_mask, storm_rate;
+	struct dsa_port *dp;
+	struct ksz_port *p;
+	const u16 *regs;
+	int ret;
+
+	regs = dev->info->regs;
+
+	dev->vlan_cache = devm_kcalloc(dev->dev, sizeof(struct vlan_table),
+				       dev->info->num_vlans, GFP_KERNEL);
+	if (!dev->vlan_cache)
+		return -ENOMEM;
+
+	ret = ksz9477_reset_switch(dev);
+	if (ret) {
+		dev_err(ds->dev, "failed to reset switch\n");
+		return ret;
+	}
+
+	ret = ksz_parse_drive_strength(dev);
+	if (ret)
+		return ret;
 
+	if (ksz_has_sgmii_port(dev)) {
+		ret = ksz9477_pcs_create(dev);
+		if (ret)
+			return ret;
+	}
+
+	/* set broadcast storm protection 10% rate */
+	storm_mask = BROADCAST_STORM_RATE;
+	storm_rate = (BROADCAST_STORM_VALUE * BROADCAST_STORM_PROT_RATE) / 100;
+	regmap_update_bits(ksz_regmap_16(dev), regs[S_BROADCAST_CTRL],
+			   storm_mask, storm_rate);
+
+	ksz9477_config_cpu_port(ds);
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
 	ds->mtu_enforcement_ingress = true;
 
 	/* Required for port partitioning. */
@@ -1512,7 +1557,76 @@ static int ksz9477_setup(struct dsa_switch *ds)
 	 * be enabled by ksz_wol_pre_shutdown(). Otherwise, some PMICs
 	 * do not like PME events changes before shutdown.
 	 */
-	return ksz_write8(dev, regs[REG_SW_PME_CTRL], 0);
+	ret = ksz_write8(dev, regs[REG_SW_PME_CTRL], 0);
+	if (ret < 0)
+		return ret;
+
+	/* Start with learning disabled on standalone user ports, and enabled
+	 * on the CPU port. In lack of other finer mechanisms, learning on the
+	 * CPU port will avoid flooding bridge local addresses on the network
+	 * in some cases.
+	 */
+	p = &dev->ports[dev->cpu_port];
+	p->learning = true;
+
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
+			if (dev->info->ptp_capable) {
+				ret = ksz_ptp_irq_setup(ds, dp->index);
+				if (ret)
+					goto pirq_release;
+			}
+		}
+	}
+
+	if (dev->info->ptp_capable) {
+		ret = ksz_ptp_clock_register(ds);
+		if (ret) {
+			dev_err(dev->dev, "Failed to register PTP clock: %d\n",
+				ret);
+			goto port_release;
+		}
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
+	if (dev->info->ptp_capable)
+		ksz_ptp_clock_unregister(ds);
+port_release:
+	if (dev->irq > 0) {
+		dsa_switch_for_each_user_port_continue_reverse(dp, dev->ds) {
+			if (dev->info->ptp_capable)
+				ksz_ptp_irq_free(ds, dp->index);
+pirq_release:
+			ksz_irq_free(&dev->ports[dp->index].pirq);
+		}
+		ksz_irq_free(&dev->girq);
+	}
+
+	return ret;
 }
 
 u32 ksz9477_get_port_addr(int port, int offset)
@@ -1779,7 +1893,6 @@ const struct phylink_mac_ops ksz9477_phylink_mac_ops = {
 };
 
 const struct ksz_dev_ops ksz9477_dev_ops = {
-	.setup = ksz9477_setup,
 	.get_port_addr = ksz9477_get_port_addr,
 	.cfg_port_member = ksz9477_cfg_port_member,
 	.port_setup = ksz9477_port_setup,
@@ -1793,19 +1906,15 @@ const struct ksz_dev_ops ksz9477_dev_ops = {
 	.pme_write8 = ksz_write8,
 	.pme_pread8 = ksz_pread8,
 	.pme_pwrite8 = ksz_pwrite8,
-	.config_cpu_port = ksz9477_config_cpu_port,
 	.tc_cbs_set_cinc = ksz9477_tc_cbs_set_cinc,
-	.enable_stp_addr = ksz9477_enable_stp_addr,
-	.reset = ksz9477_reset_switch,
 	.init = ksz9477_switch_init,
-	.pcs_create = ksz9477_pcs_create,
 };
 
 const struct dsa_switch_ops ksz9477_switch_ops = {
 	.get_tag_protocol	= ksz9477_get_tag_protocol,
 	.connect_tag_protocol   = ksz9477_connect_tag_protocol,
 	.get_phy_flags		= ksz_get_phy_flags,
-	.setup			= ksz_setup,
+	.setup			= ksz9477_setup,
 	.teardown		= ksz_teardown,
 	.phy_read		= ksz_phy_read16,
 	.phy_write		= ksz_phy_write16,

-- 
2.54.0


