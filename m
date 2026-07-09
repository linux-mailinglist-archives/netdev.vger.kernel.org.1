Return-Path: <netdev+bounces-306074-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kL6/GZtDT2qDdAIAu9opvQ
	(envelope-from <netdev+bounces-306074-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 08:45:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F25AE72D506
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 08:45:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b="PYJjQm/F";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306074-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306074-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF279302819A
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 06:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515143E0C42;
	Thu,  9 Jul 2026 06:43:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADCB3DE445;
	Thu,  9 Jul 2026 06:42:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579386; cv=none; b=bHA1g+8DtneebSQZ+BWnz6jkIGodx+aaUWUoKwmplawQGQP+P7Mcex8YIJqt+mNYzIbduXcG/3eYhVhmiuA3aArCrDoedI8XED89orQh2SG8CIWdC54spl89NIcuZDFOPPbW4jIupVjAmSPXNAV13JBIcv70BVO3AZR3hOzbEbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579386; c=relaxed/simple;
	bh=zeQbK24H5wDz8lEmLc4ot4f43usN7aP3TJ+RpJukAV8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xvr1b9pGUXdjHaHQ9WP89pIiWcKhQz8yMXzc6J47w975zgz29wN9g5GoYXBUrT8j1adU2Q+q1KJ0hBp8cTWiV6xEA/5wn3nEUnbPmV+pxgIv8UMxjXGEKUwhFt0jYjAlEdti5ZJoPV/0/ipOQ3I8QTL3yFAx1bGQ+qjDt/VaX/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PYJjQm/F; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4DEA91A0F00;
	Thu,  9 Jul 2026 06:42:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 218905FF03;
	Thu,  9 Jul 2026 06:42:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 59EF011BC207F;
	Thu,  9 Jul 2026 08:42:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783579375; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wh79rBXHGjoF4j9LDwbXGQfgxDfkRfX5JND3HvCdjhE=;
	b=PYJjQm/FiYUpHZOQhu2U5Vwzmi26QtKz+VXeOdIC0W1ZwWgIX5W9L3WAt259EYnyo0JWZZ
	YtTUanX7lorbBhWzKkik1C5/NkgLxOxc41GoaQSxq8e6yEg8BhgJfbKfnAZJbtYFSh+eHX
	1foncC9RmNt32fxdRZzDi5/UvL7UF2vrTQ8V84bcrVo9yYrMzl1tm/ggGeAvefhYQtFlFg
	oTbgX1kVQTQ1/uOgdyT2rmlwIMiJIGDcZ8IJeAWcxgkI8YpAQbESCpFfppEGLhjLak8T3/
	g47qttqddfTP60CkG+1l21c8DODWpwolZYnVyI3ZVMR8YQU13HkjtazfH2+PhQ==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 09 Jul 2026 08:42:36 +0200
Subject: [PATCH net-next 10/10] net: dsa: microchip: add two-steps PTP
 support for KSZ8463
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-ksz-new-ptp-v1-10-344f02fe739e@bootlin.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
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
	TAGGED_FROM(0.00)[bounces-306074-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:from_mime,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F25AE72D506

The KSZ8463 switch supports PTP but it's not supported by the driver.

Add L2 two-step PTP support for the KSZ8463. IPv4 and IPv6 layers aren't
supported. Neither is one-step PTP. Use KSZ8463-specific implementations
of the .get_ts_info and .port_hwtstamp_set callbacks.

The pdelay_req and pdelay_resp timestamps share one interrupt bit status
while they're located in two different registers. So introduce
last_tx_is_pdelayresp to keep track of the last sent event type. This
flag is set by the xmit worker right before sending the packet and then
used in the interrupt handler to retrieve the timestamp location.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c        |  26 +++++--
 drivers/net/dsa/microchip/ksz8_reg.h    |   1 +
 drivers/net/dsa/microchip/ksz_common.h  |   1 +
 drivers/net/dsa/microchip/ksz_ptp.c     | 127 +++++++++++++++++++++++++++++++-
 drivers/net/dsa/microchip/ksz_ptp.h     |   7 ++
 drivers/net/dsa/microchip/ksz_ptp_reg.h |   4 +
 6 files changed, 159 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index ac9e8ef5774a..941ae9f66f70 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -242,8 +242,11 @@ static int ksz8463_girq_setup(struct ksz_device *dev)
 
 static int ksz8463_reset_switch(struct ksz_device *dev)
 {
-	ksz_cfg(dev, KSZ8463_REG_SW_RESET, KSZ8463_GLOBAL_SOFTWARE_RESET, true);
-	ksz_cfg(dev, KSZ8463_REG_SW_RESET, KSZ8463_GLOBAL_SOFTWARE_RESET,
+	ksz_cfg(dev, KSZ8463_REG_SW_RESET,
+		KSZ8463_GLOBAL_SOFTWARE_RESET | KSZ8463_PTP_SOFTWARE_RESET,
+		true);
+	ksz_cfg(dev, KSZ8463_REG_SW_RESET,
+		KSZ8463_GLOBAL_SOFTWARE_RESET | KSZ8463_PTP_SOFTWARE_RESET,
 		false);
 	return 0;
 }
@@ -2474,17 +2477,24 @@ static int ksz8463_setup(struct dsa_switch *ds)
 		ret = ksz8463_ptp_irq_setup(ds);
 		if (ret)
 			goto free_girq;
+
+		ret = ksz_ptp_clock_register(ds);
+		if (ret) {
+			dev_err(dev->dev, "Failed to register PTP clock: %d\n",
+				ret);
+			goto free_ptp_irq;
+		}
 	}
 
 	ret = ksz_mdio_register(dev);
 	if (ret < 0) {
 		dev_err(dev->dev, "failed to register the mdio");
-		goto free_ptp_irq;
+		goto ptp_clock_unregister;
 	}
 
 	ret = ksz_dcb_init(dev);
 	if (ret)
-		goto free_ptp_irq;
+		goto ptp_clock_unregister;
 
 	/* start switch */
 	regmap_update_bits(ksz_regmap_8(dev), regs[S_START_CTRL],
@@ -2492,6 +2502,9 @@ static int ksz8463_setup(struct dsa_switch *ds)
 
 	return 0;
 
+ptp_clock_unregister:
+	if (dev->irq > 0)
+		ksz_ptp_clock_unregister(ds);
 free_ptp_irq:
 	if (dev->irq > 0)
 		ksz8463_ptp_irq_free(ds);
@@ -2507,6 +2520,7 @@ static void ksz8463_teardown(struct dsa_switch *ds)
 	struct ksz_device *dev = ds->priv;
 
 	if (dev->irq > 0) {
+		ksz_ptp_clock_unregister(ds);
 		ksz8463_ptp_irq_free(ds);
 		ksz_irq_free(&dev->girq);
 	}
@@ -3129,9 +3143,9 @@ const struct dsa_switch_ops ksz8463_switch_ops = {
 	.port_max_mtu		= ksz88xx_max_mtu,
 	.suspend		= ksz_suspend,
 	.resume			= ksz_resume,
-	.get_ts_info		= ksz_get_ts_info,
+	.get_ts_info		= ksz8463_get_ts_info,
 	.port_hwtstamp_get	= ksz_hwtstamp_get,
-	.port_hwtstamp_set	= ksz_hwtstamp_set,
+	.port_hwtstamp_set	= ksz8463_hwtstamp_set,
 	.port_txtstamp		= ksz_port_txtstamp,
 	.port_rxtstamp		= ksz_port_rxtstamp,
 	.port_setup_tc		= ksz8_setup_tc,
diff --git a/drivers/net/dsa/microchip/ksz8_reg.h b/drivers/net/dsa/microchip/ksz8_reg.h
index 981ab441d9b7..6bc511da1f7d 100644
--- a/drivers/net/dsa/microchip/ksz8_reg.h
+++ b/drivers/net/dsa/microchip/ksz8_reg.h
@@ -786,6 +786,7 @@
 #define KSZ8463_REG_SW_RESET		0x126
 
 #define KSZ8463_GLOBAL_SOFTWARE_RESET	BIT(0)
+#define KSZ8463_PTP_SOFTWARE_RESET	BIT(2)
 
 #define KSZ8463_PTP_CLK_CTRL		0x600
 
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 0f2abb22ca91..cbe98494578c 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -194,6 +194,7 @@ struct ksz_port {
 	struct kernel_hwtstamp_config tstamp_config;
 	bool hwts_tx_en;
 	bool hwts_rx_en;
+	bool last_tx_is_pdelayresp;
 	struct ksz_irq ptpirq;
 	struct ksz_ptp_irq ptpmsg_irq[3];
 	ktime_t tstamp_msg;
diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 5323fdc8862e..a3cc7b97caaf 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -297,6 +297,31 @@ static int ksz_ptp_enable_mode(struct ksz_device *dev)
 			 tag_en ? PTP_ENABLE : 0);
 }
 
+int ksz8463_get_ts_info(struct dsa_switch *ds, int port,
+			struct kernel_ethtool_ts_info *ts)
+{
+	struct ksz_device *dev = ds->priv;
+	struct ksz_ptp_data *ptp_data;
+
+	ptp_data = &dev->ptp_data;
+
+	if (!ptp_data->clock)
+		return -ENODEV;
+
+	ts->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
+			      SOF_TIMESTAMPING_RX_HARDWARE |
+			      SOF_TIMESTAMPING_RAW_HARDWARE;
+
+	ts->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
+
+	ts->rx_filters = BIT(HWTSTAMP_FILTER_NONE) |
+			 BIT(HWTSTAMP_FILTER_PTP_V2_L2_EVENT);
+
+	ts->phc_index = ptp_clock_index(ptp_data->clock);
+
+	return 0;
+}
+
 /* The function is return back the capability of timestamping feature when
  * requested through ethtool -T <interface> utility
  */
@@ -341,6 +366,72 @@ int ksz_hwtstamp_get(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static int ksz8463_set_hwtstamp_config(struct ksz_device *dev,
+				       struct ksz_port *prt,
+				       struct kernel_hwtstamp_config *config)
+{
+	const u16 *regs = dev->info->regs;
+	int ret;
+
+	if (config->flags)
+		return -EINVAL;
+
+	switch (config->tx_type) {
+	case HWTSTAMP_TX_OFF:
+		prt->ptpmsg_irq[KSZ8463_SYNC_MSG].ts_en  = false;
+		prt->ptpmsg_irq[KSZ8463_XDREQ_PDRES_MSG].ts_en = false;
+		prt->hwts_tx_en = false;
+		break;
+	case HWTSTAMP_TX_ON:
+		prt->ptpmsg_irq[KSZ8463_SYNC_MSG].ts_en  = true;
+		prt->ptpmsg_irq[KSZ8463_XDREQ_PDRES_MSG].ts_en = true;
+		prt->hwts_tx_en = true;
+
+		ret = ksz_rmw16(dev, regs[PTP_MSG_CONF1], PTP_1STEP, 0);
+		if (ret)
+			return ret;
+
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	switch (config->rx_filter) {
+	case HWTSTAMP_FILTER_NONE:
+		prt->hwts_rx_en = false;
+		break;
+	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
+		config->rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
+		prt->hwts_rx_en = true;
+		break;
+	default:
+		config->rx_filter = HWTSTAMP_FILTER_NONE;
+		return -ERANGE;
+	}
+
+	return ksz_ptp_enable_mode(dev);
+}
+
+int ksz8463_hwtstamp_set(struct dsa_switch *ds, int port,
+			 struct kernel_hwtstamp_config *config,
+			 struct netlink_ext_ack *extack)
+{
+	struct ksz_device *dev = ds->priv;
+	struct ksz_port *prt;
+	int ret;
+
+	prt = &dev->ports[port];
+
+	ret = ksz8463_set_hwtstamp_config(dev, prt, config);
+	if (ret)
+		return ret;
+
+	prt->tstamp_config = *config;
+
+	return 0;
+}
+
 static int ksz_set_hwtstamp_config(struct ksz_device *dev,
 				   struct ksz_port *prt,
 				   struct kernel_hwtstamp_config *config)
@@ -571,6 +662,28 @@ static void ksz_ptp_txtstamp_skb(struct ksz_device *dev,
 	skb_complete_tx_timestamp(skb, &hwtstamps);
 }
 
+static void ksz8463_set_pdelayresp_flag(struct ksz_port *prt,
+					struct sk_buff *skb)
+{
+	struct ptp_header *hdr;
+	unsigned int type;
+	u8 ptp_msg_type;
+
+	if (!ksz_is_ksz8463(prt->ksz_dev))
+		return;
+
+	type = ptp_classify_raw(skb);
+	if (type == PTP_CLASS_NONE)
+		return;
+
+	hdr = ptp_parse_header(skb, type);
+	if (!hdr)
+		return;
+
+	ptp_msg_type = ptp_get_msgtype(hdr, type);
+	prt->last_tx_is_pdelayresp = (ptp_msg_type == PTP_MSGTYPE_PDELAY_RESP);
+}
+
 void ksz_port_deferred_xmit(struct kthread_work *work)
 {
 	struct ksz_deferred_xmit_work *xmit_work = work_to_xmit_work(work);
@@ -587,6 +700,8 @@ void ksz_port_deferred_xmit(struct kthread_work *work)
 
 	reinit_completion(&prt->tstamp_msg_comp);
 
+	ksz8463_set_pdelayresp_flag(prt, skb);
+
 	dsa_enqueue_skb(skb, skb->dev);
 
 	ksz_ptp_txtstamp_skb(dev, prt, clone);
@@ -979,7 +1094,17 @@ void ksz_ptp_clock_unregister(struct dsa_switch *ds)
 
 static int ksz_read_ts(struct ksz_port *port, u16 reg, u32 *ts)
 {
-	return ksz_read32(port->ksz_dev, reg, ts);
+	u16 ts_reg = reg;
+
+	/**
+	 * On KSZ8463 DREQ and DRESP timestamps share one interrupt line
+	 * so we have to check the nature of the latest event sent to know
+	 * where the timestamp is located
+	 */
+	if (ksz_is_ksz8463(port->ksz_dev) && port->last_tx_is_pdelayresp)
+		ts_reg += KSZ8463_DRESP_TS_OFFSET;
+
+	return ksz_read32(port->ksz_dev, ts_reg, ts);
 }
 
 static irqreturn_t ksz_ptp_msg_thread_fn(int irq, void *dev_id)
diff --git a/drivers/net/dsa/microchip/ksz_ptp.h b/drivers/net/dsa/microchip/ksz_ptp.h
index 11408580031d..7067ec9bd1e6 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.h
+++ b/drivers/net/dsa/microchip/ksz_ptp.h
@@ -39,11 +39,16 @@ void ksz_ptp_clock_unregister(struct dsa_switch *ds);
 
 int ksz_get_ts_info(struct dsa_switch *ds, int port,
 		    struct kernel_ethtool_ts_info *ts);
+int ksz8463_get_ts_info(struct dsa_switch *ds, int port,
+			struct kernel_ethtool_ts_info *ts);
 int ksz_hwtstamp_get(struct dsa_switch *ds, int port,
 		     struct kernel_hwtstamp_config *config);
 int ksz_hwtstamp_set(struct dsa_switch *ds, int port,
 		     struct kernel_hwtstamp_config *config,
 		     struct netlink_ext_ack *extack);
+int ksz8463_hwtstamp_set(struct dsa_switch *ds, int port,
+			 struct kernel_hwtstamp_config *config,
+			 struct netlink_ext_ack *extack);
 void ksz_port_txtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb);
 void ksz_port_deferred_xmit(struct kthread_work *work);
 bool ksz_port_rxtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb,
@@ -82,10 +87,12 @@ static inline int ksz8463_ptp_irq_setup(struct dsa_switch *ds)
 static inline void ksz8463_ptp_irq_free(struct dsa_switch *ds) {}
 
 #define ksz_get_ts_info NULL
+#define ksz8463_get_ts_info NULL
 
 #define ksz_hwtstamp_get NULL
 
 #define ksz_hwtstamp_set NULL
+#define ksz8463_hwtstamp_set NULL
 
 #define ksz_port_rxtstamp NULL
 
diff --git a/drivers/net/dsa/microchip/ksz_ptp_reg.h b/drivers/net/dsa/microchip/ksz_ptp_reg.h
index 1a669d6ee889..65ea8577af75 100644
--- a/drivers/net/dsa/microchip/ksz_ptp_reg.h
+++ b/drivers/net/dsa/microchip/ksz_ptp_reg.h
@@ -137,4 +137,8 @@
 #define KSZ_XDREQ_MSG			1
 #define KSZ_PDRES_MSG			0
 
+#define KSZ8463_DRESP_TS_OFFSET		(KSZ8463_REG_PORT_DRESP_TS - KSZ8463_REG_PORT_DREQ_TS)
+#define KSZ8463_SYNC_MSG		0
+#define KSZ8463_XDREQ_PDRES_MSG		1
+
 #endif

-- 
2.54.0


