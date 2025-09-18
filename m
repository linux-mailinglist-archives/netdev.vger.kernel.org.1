Return-Path: <netdev+bounces-224577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AA2B864AC
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 19:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89411CC34F0
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A8D31A806;
	Thu, 18 Sep 2025 17:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qgpE6vQX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41C031A81E
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217239; cv=none; b=RXnXW7B1baU8gnKoQ0uvW7fpzM5j51r/u6vtL/m4ytta72ZbLVfBwn+5CingoDUtSwjcmb11326EqQLiL67XoxG+kb6WH80LubwtSMEjRhEFD+wn3vDoteiiqaL9rvPZ+RQS/uTufGQ3fkCIuFbqmmkmWtZEFnzlVxTz4mPnSKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217239; c=relaxed/simple;
	bh=TQdaq4/ZPvvB7S8SnplYrxcB6H3DU6WtL2xsSVs3NRE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=t2Jq0yyU1BFxJJu7/g6yLnWwrN79jmHH/gw0r6FJdM34gCdujVCXPmpKjZqFsdxdVY8uEuF3Yz+4Z85G/B7oa9UkpNLtzaYDunYtghl7fqjy1yIM4rqSuiHDlHGRcwUbXd6nGMQJxpDJGyLvaMxm2ADGA/BadrA3ploPvdRwrBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qgpE6vQX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wQo+wLG4oREZMMgXxHvgoaFwiKk//2XDwC2KmCtkNyk=; b=qgpE6vQXva4nKBMMA8xhxeXVgB
	UKJMpNrR/nRbEkW15ApTyljvrTYhuN7X63TeFd3ezHVMrS+yBWwaXktiSdW7OQK5XzgwllOiY8kkK
	JS7BJec28Z+68YilOTs/FufZ3M1Ms5THbR6g166mpxfxc778VJXouCg3P8OnpuIhi9Zb+1kusDnaX
	2mjDcpu1Y9N5AYXVeCq/dt8oMzBry2CqK61dMOzqc6gxEz+R5OHY5k3XS3N215GuV+D5tc7a1MvKy
	JpspgPMIpRtpA64tWWl6hxUWZeJBaaEuCKf+I5fl2IBPMNEwRGu/52zVUQghB7zzRIhGZBTeh1iTO
	pLUqfN6g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:52008 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uzIcP-000000001eG-3apn;
	Thu, 18 Sep 2025 18:40:29 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uzIcP-00000006n13-0NMK;
	Thu, 18 Sep 2025 18:40:29 +0100
In-Reply-To: <aMxDh17knIDhJany@shell.armlinux.org.uk>
References: <aMxDh17knIDhJany@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH RFC net-next 19/20] net: dsa: mv88e6xxx: switch hwtstamp
 config to core XXX Fix 6165
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uzIcP-00000006n13-0NMK@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 18 Sep 2025 18:40:29 +0100

---
 drivers/net/dsa/mv88e6xxx/chip.h     |  16 +--
 drivers/net/dsa/mv88e6xxx/hwtstamp.c | 151 +++++++--------------------
 drivers/net/dsa/mv88e6xxx/hwtstamp.h |  11 --
 3 files changed, 36 insertions(+), 142 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 0c41b5595dd3..db95265efa02 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -219,19 +219,6 @@ struct mv88e6xxx_irq {
 	int nirqs;
 };
 
-/* state flags for mv88e6xxx_port_hwtstamp::state */
-enum {
-	MV88E6XXX_HWTSTAMP_ENABLED,
-};
-
-struct mv88e6xxx_port_hwtstamp {
-	/* Timestamping state */
-	unsigned long state;
-
-	/* Current timestamp configuration */
-	struct kernel_hwtstamp_config tstamp_config;
-};
-
 enum mv88e6xxx_policy_mapping {
 	MV88E6XXX_POLICY_MAPPING_DA,
 	MV88E6XXX_POLICY_MAPPING_SA,
@@ -403,16 +390,15 @@ struct mv88e6xxx_chip {
 	struct marvell_tai	*tai;
 
 	struct ptp_pin_desc	pin_config[MV88E6XXX_MAX_GPIO];
-	u16 enable_count;
 
 	/* Current ingress and egress monitor ports */
 	int egress_dest_port;
 	int ingress_dest_port;
 
 	/* Per-port timestamping resources. */
-	struct mv88e6xxx_port_hwtstamp port_hwtstamp[DSA_MAX_PORTS];
 	struct marvell_ts ptp_ts[DSA_MAX_PORTS];
 	struct marvell_ts_caps ptp_caps;
+	u16 ptp_ts_enable_count;
 
 	/* Array of port structures. */
 	struct mv88e6xxx_port ports[DSA_MAX_PORTS];
diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.c b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
index fd4afb5e4d49..4f6b2706a8be 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.c
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
@@ -82,9 +82,7 @@ static int mv88e6xxx_ptp_read(struct mv88e6xxx_chip *chip, int addr,
 int mv88e6xxx_get_ts_info(struct dsa_switch *ds, int port,
 			  struct kernel_ethtool_ts_info *info)
 {
-	struct mv88e6xxx_chip *chip;
-
-	chip = ds->priv;
+	struct mv88e6xxx_chip *chip = ds->priv;
 
 	if (!chip->info->ptp_support)
 		return -EOPNOTSUPP;
@@ -94,119 +92,24 @@ int mv88e6xxx_get_ts_info(struct dsa_switch *ds, int port,
 	return 0;
 }
 
-static int mv88e6xxx_set_hwtstamp_config(struct mv88e6xxx_chip *chip, int port,
-					 struct kernel_hwtstamp_config *config)
-{
-	const struct mv88e6xxx_ptp_ops *ptp_ops = chip->info->ops->ptp_ops;
-	struct mv88e6xxx_port_hwtstamp *ps = &chip->port_hwtstamp[port];
-	bool tstamp_enable = false;
-
-	/* Prevent the TX/RX paths from trying to interact with the
-	 * timestamp hardware while we reconfigure it.
-	 */
-	clear_bit_unlock(MV88E6XXX_HWTSTAMP_ENABLED, &ps->state);
-
-	switch (config->tx_type) {
-	case HWTSTAMP_TX_OFF:
-		tstamp_enable = false;
-		break;
-	case HWTSTAMP_TX_ON:
-		tstamp_enable = true;
-		break;
-	default:
-		return -ERANGE;
-	}
-
-	/* The switch supports timestamping both L2 and L4; one cannot be
-	 * disabled independently of the other.
-	 */
-
-	if (!(BIT(config->rx_filter) & ptp_ops->rx_filters)) {
-		config->rx_filter = HWTSTAMP_FILTER_NONE;
-		dev_dbg(chip->dev, "Unsupported rx_filter %d\n",
-			config->rx_filter);
-		return -ERANGE;
-	}
-
-	switch (config->rx_filter) {
-	case HWTSTAMP_FILTER_NONE:
-		tstamp_enable = false;
-		break;
-	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
-	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
-	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
-	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
-	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
-	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
-	case HWTSTAMP_FILTER_PTP_V2_EVENT:
-	case HWTSTAMP_FILTER_PTP_V2_SYNC:
-	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
-		config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
-		break;
-	case HWTSTAMP_FILTER_ALL:
-	default:
-		config->rx_filter = HWTSTAMP_FILTER_NONE;
-		return -ERANGE;
-	}
-
-	mv88e6xxx_reg_lock(chip);
-	if (tstamp_enable) {
-		chip->enable_count += 1;
-		if (chip->enable_count == 1 && ptp_ops->global_enable)
-			ptp_ops->global_enable(chip);
-		if (ptp_ops->port_enable)
-			ptp_ops->port_enable(chip, port);
-	} else {
-		if (ptp_ops->port_disable)
-			ptp_ops->port_disable(chip, port);
-		chip->enable_count -= 1;
-		if (chip->enable_count == 0 && ptp_ops->global_disable)
-			ptp_ops->global_disable(chip);
-	}
-	mv88e6xxx_reg_unlock(chip);
-
-	/* Once hardware has been configured, enable timestamp checks
-	 * in the RX/TX paths.
-	 */
-	if (tstamp_enable)
-		set_bit(MV88E6XXX_HWTSTAMP_ENABLED, &ps->state);
-
-	return 0;
-}
-
 int mv88e6xxx_port_hwtstamp_set(struct dsa_switch *ds, int port,
 				struct kernel_hwtstamp_config *config,
 				struct netlink_ext_ack *extack)
 {
 	struct mv88e6xxx_chip *chip = ds->priv;
-	struct mv88e6xxx_port_hwtstamp *ps = &chip->port_hwtstamp[port];
-	int err;
 
 	if (!chip->info->ptp_support)
 		return -EOPNOTSUPP;
 
-	err = mv88e6xxx_set_hwtstamp_config(chip, port, config);
-	if (err)
-		return err;
-
-	/* Save the chosen configuration to be returned later. */
-	ps->tstamp_config = *config;
-
-	return 0;
+	return marvell_ts_hwtstamp_set(&chip->ptp_ts[port], config, extack);
 }
 
 int mv88e6xxx_port_hwtstamp_get(struct dsa_switch *ds, int port,
 				struct kernel_hwtstamp_config *config)
 {
 	struct mv88e6xxx_chip *chip = ds->priv;
-	struct mv88e6xxx_port_hwtstamp *ps = &chip->port_hwtstamp[port];
-
-	if (!chip->info->ptp_support)
-		return -EOPNOTSUPP;
 
-	*config = ps->tstamp_config;
-
-	return 0;
+	return marvell_ts_hwtstamp_get(&chip->ptp_ts[port], config);
 }
 
 bool mv88e6xxx_port_rxtstamp(struct dsa_switch *ds, int port,
@@ -316,6 +219,36 @@ static int mv88e6xxx_ts_global_write(struct device *dev, u8 reg, u16 val)
 	return chip->info->ops->avb_ops->ptp_write(chip, reg, val);
 }
 
+static int mv88e6xxx_ts_port_enable(struct device *dev, u8 port)
+{
+	struct mv88e6xxx_chip *chip = dev_to_chip(dev);
+	const struct mv88e6xxx_ptp_ops *ptp_ops;
+
+	ptp_ops = chip->info->ops->ptp_ops;
+	if (ptp_ops->global_enable) {
+		mv88e6xxx_reg_lock(chip);
+		if (!chip->ptp_ts_enable_count++)
+			ptp_ops->global_enable(chip);
+		mv88e6xxx_reg_unlock(chip);
+	}
+
+	return 0;
+}
+
+static void mv88e6xxx_ts_port_disable(struct device *dev, u8 port)
+{
+	struct mv88e6xxx_chip *chip = dev_to_chip(dev);
+	const struct mv88e6xxx_ptp_ops *ptp_ops;
+
+	ptp_ops = chip->info->ops->ptp_ops;
+	if (ptp_ops->global_disable) {
+		mv88e6xxx_reg_lock(chip);
+		if (!--chip->ptp_ts_enable_count)
+			ptp_ops->global_disable(chip);
+		mv88e6xxx_reg_unlock(chip);
+	}
+}
+
 /* The device differences are:
  * ts_reg		MV88E6165			Others
  * TS_ARR0	MV88E6165_PORT_PTP_ARR0_STS	MV88E6XXX_PORT_PTP_ARR0_STS
@@ -423,6 +356,8 @@ static int mv88e6xxx_ts_port_modify(struct device *dev, u8 port, u8 reg,
 
 static const struct marvell_ts_ops mv88e6xxx_ts_ops = {
 	.ts_global_write = mv88e6xxx_ts_global_write,
+	.ts_port_enable = mv88e6xxx_ts_port_enable,
+	.ts_port_disable = mv88e6xxx_ts_port_disable,
 	.ts_port_read_ts = mv88e6xxx_ts_port_read_ts,
 	.ts_port_write = mv88e6xxx_ts_port_write,
 	.ts_port_modify = mv88e6xxx_ts_port_modify,
@@ -455,22 +390,6 @@ int mv88e6xxx_hwtstamp_setup(struct mv88e6xxx_chip *chip)
 	if (err)
 		return err;
 
-	/* MV88E6XXX_PTP_MSG_TYPE is a mask of PTP message types to
-	 * timestamp. This affects all ports that have timestamping enabled,
-	 * but the timestamp config is per-port; thus we configure all events
-	 * here and only support the HWTSTAMP_FILTER_*_EVENT filter types.
-	 */
-	err = mv88e6xxx_ptp_write(chip, MV88E6XXX_PTP_MSGTYPE,
-				  MV88E6XXX_PTP_MSGTYPE_ALL_EVENT);
-	if (err)
-		return err;
-
-	/* Use ARRIVAL1 for peer delay response messages. */
-	err = mv88e6xxx_ptp_write(chip, MV88E6XXX_PTP_TS_ARRIVAL_PTR,
-				  MV88E6XXX_PTP_MSGTYPE_PDLAY_RES);
-	if (err)
-		return err;
-
 	/* 88E6341 devices default to timestamping at the PHY, but this has
 	 * a hardware issue that results in unreliable timestamps. Force
 	 * these devices to timestamp at the MAC.
diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.h b/drivers/net/dsa/mv88e6xxx/hwtstamp.h
index f6182658c971..caeee3b1256d 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.h
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.h
@@ -19,17 +19,6 @@
 /* Offset 0x00: PTP EtherType */
 #define MV88E6XXX_PTP_ETHERTYPE	0x00
 
-/* Offset 0x01: Message Type Timestamp Enables */
-#define MV88E6XXX_PTP_MSGTYPE			0x01
-#define MV88E6XXX_PTP_MSGTYPE_SYNC		0x0001
-#define MV88E6XXX_PTP_MSGTYPE_DELAY_REQ		0x0002
-#define MV88E6XXX_PTP_MSGTYPE_PDLAY_REQ		0x0004
-#define MV88E6XXX_PTP_MSGTYPE_PDLAY_RES		0x0008
-#define MV88E6XXX_PTP_MSGTYPE_ALL_EVENT		0x000f
-
-/* Offset 0x02: Timestamp Arrival Capture Pointers */
-#define MV88E6XXX_PTP_TS_ARRIVAL_PTR	0x02
-
 /* Offset 0x05: PTP Global Configuration */
 #define MV88E6165_PTP_CFG			0x05
 #define MV88E6165_PTP_CFG_TSPEC_MASK		0xf000
-- 
2.47.3


