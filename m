Return-Path: <netdev+bounces-304050-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qwEYC1QtRmqTLAsAu9opvQ
	(envelope-from <netdev+bounces-304050-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:20:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7976B6F52AB
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:20:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=lvdk1Vcd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304050-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304050-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAB1531868CC
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 09:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B97A47DFA7;
	Thu,  2 Jul 2026 09:07:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483F247DF80
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 09:07:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983273; cv=none; b=Vh8s1OiRZF40+HxPwSjV6jZQjI5aWmis6oiWKrnu5WMhC48llzDBq5n6NBjbVKJAvLzMBTWrqOhU6pSY0ij++yCWhpqDPnvA+KWLFhX5PFOc9YFBWL9si/tX0Zgqdz9EENpGKykBAw+D+VhYkMU1xlHg2UXPRKipubkcgyyNmhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983273; c=relaxed/simple;
	bh=78xOgq41Zhs8EPllccMq+hiSzkfZ+UsfEzT88LTEiX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OzC1RTWc6ERvj6jRplIXxmEmWWJ6ECD+u85BERolJzLSUpvYVuclDcc6Yuqg4ub1f8oPsa0038rYsj+NbvMsTCBktHXH1NBZzBffDPjp57SRMxDlXrlOFxnqrhwXfXiJXlCbfzEERAwhGg5Bu4N0D2hl9AhOPlAYvHudnwvjSS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lvdk1Vcd; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E6C3D4E40C2E;
	Thu,  2 Jul 2026 09:07:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BACA65FF03;
	Thu,  2 Jul 2026 09:07:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5F131104C96DA;
	Thu,  2 Jul 2026 11:07:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782983267; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Ay+Q0kkjYeccDMff4V5yAuUSFZ6ytqoUEoNy84WTxCs=;
	b=lvdk1VcdTIZSgNrLjSopjC6PTslWMsd5BoSRjjfKGSsnlbPVh3d05U1MC81hmNiS5FNNbQ
	v6gcmc3X6AzIK6axx0OUbLtqxpZ5YsQII6Anof6Os1hZghI1bdv2X+VSst1AIh4IlfNDo0
	uwJy8BLi6T6PMoqwGaLTmMUtpFmX65Wgowbb5tKsY6YRo+E8gCddMHB3lKtzCSfH5E4Wxk
	kq1TJrmh0ezYadvdzN7fiYCNljTYjl0oYgkUvVV/7cbUnQ1xeDitGd1mUP6heZlMW+5l6w
	Ju6cQg1V3KeUrW2t5+0iHrIIti8wW0IJElPc5OP+cdr2HtT2gD+IpTjsJ3eH8g==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 02 Jul 2026 11:07:29 +0200
Subject: [PATCH net-next 07/10] net: dsa: microchip: handle KSZ8-specific
 tc setup in ksz8.c
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260702-clean-ksz-4th-v1-7-93441e695fa4@bootlin.com>
References: <20260702-clean-ksz-4th-v1-0-93441e695fa4@bootlin.com>
In-Reply-To: <20260702-clean-ksz-4th-v1-0-93441e695fa4@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:pascal.eberhard@se.com,m:miquel.raynal@bootlin.com,m:thomas.petazzoni@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bastien.curutchet@bootlin.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-304050-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,bootlin.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7976B6F52AB

The setup of QDISC_ETS isn't the same for the KSZ8 switches than for
the other switches. It leads to is_ksz8() branches in the common code.

Move the KSZ8-specific portions into ksz8.c by creating two setup_tc()
functions, one dedicated to the KSZ87xx family that only handles the
TC_SETUP_QDISC_CBS case, one for the rest of the KSZ8 that handles both
TC_SETUP_QDISC_CBS and TC_SETUP_QDISC_ETS cases.
It remains some is_kszXXXX() branches because inside the ksz88xx family,
only the ksz88x3 switches support QDISC_ETS.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c       | 159 ++++++++++++++++++++++++++++++++-
 drivers/net/dsa/microchip/ksz_common.c | 124 ++-----------------------
 drivers/net/dsa/microchip/ksz_common.h |   7 ++
 3 files changed, 171 insertions(+), 119 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index ad7c7a6e1d31..472cc62ea747 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -1782,6 +1782,159 @@ static void ksz8_port_mirror_del(struct dsa_switch *ds, int port,
 			     PORT_MIRROR_SNIFFER, false);
 }
 
+static u8 ksz8463_tc_ctrl(int port, int queue)
+{
+	u8 reg;
+
+	reg = 0xC8 + port * 4;
+	reg += ((3 - queue) / 2) * 2;
+	reg++;
+	reg -= (queue & 1);
+	return reg;
+}
+
+/**
+ * ksz88x3_tc_ets_add - Configure ETS (Enhanced Transmission Selection)
+ *                      for a port on KSZ88x3 switch
+ * @dev: Pointer to the KSZ switch device structure
+ * @port: Port number to configure
+ * @p: Pointer to offload replace parameters describing ETS bands and mapping
+ *
+ * The KSZ88x3 supports two scheduling modes: Strict Priority and
+ * Weighted Fair Queuing (WFQ). Both modes have fixed behavior:
+ *   - No configurable queue-to-priority mapping
+ *   - No weight adjustment in WFQ mode
+ *
+ * This function configures the switch to use strict priority mode by
+ * clearing the WFQ enable bit for all queues associated with ETS bands.
+ * If strict priority is not explicitly requested, the switch will default
+ * to WFQ mode.
+ *
+ * Return: 0 on success, or a negative error code on failure
+ */
+static int ksz88x3_tc_ets_add(struct ksz_device *dev, int port,
+			      struct tc_ets_qopt_offload_replace_params *p)
+{
+	int ret, band;
+
+	/* Only strict priority mode is supported for now.
+	 * WFQ is implicitly enabled when strict mode is disabled.
+	 */
+	for (band = 0; band < p->bands; band++) {
+		int queue = ksz_ets_band_to_queue(p, band);
+		u8 reg;
+
+		/* Calculate TXQ Split Control register address for this
+		 * port/queue
+		 */
+		reg = KSZ8873_TXQ_SPLIT_CTRL_REG(port, queue);
+		if (ksz_is_ksz8463(dev))
+			reg = ksz8463_tc_ctrl(port, queue);
+
+		/* Clear WFQ enable bit to select strict priority scheduling */
+		ret = ksz_rmw8(dev, reg, KSZ8873_TXQ_WFQ_ENABLE, 0);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * ksz88x3_tc_ets_del - Reset ETS (Enhanced Transmission Selection) config
+ *                      for a port on KSZ88x3 switch
+ * @dev: Pointer to the KSZ switch device structure
+ * @port: Port number to reset
+ *
+ * The KSZ88x3 supports only fixed scheduling modes: Strict Priority or
+ * Weighted Fair Queuing (WFQ), with no reconfiguration of weights or
+ * queue mapping. This function resets the port’s scheduling mode to
+ * the default, which is WFQ, by enabling the WFQ bit for all queues.
+ *
+ * Return: 0 on success, or a negative error code on failure
+ */
+static int ksz88x3_tc_ets_del(struct ksz_device *dev, int port)
+{
+	int ret, queue;
+
+	/* Iterate over all transmit queues for this port */
+	for (queue = 0; queue < dev->info->num_tx_queues; queue++) {
+		u8 reg;
+
+		/* Calculate TXQ Split Control register address for this
+		 * port/queue
+		 */
+		reg = KSZ8873_TXQ_SPLIT_CTRL_REG(port, queue);
+		if (ksz_is_ksz8463(dev))
+			reg = ksz8463_tc_ctrl(port, queue);
+
+		/* Set WFQ enable bit to revert back to default scheduling
+		 * mode
+		 */
+		ret = ksz_rmw8(dev, reg, KSZ8873_TXQ_WFQ_ENABLE,
+			       KSZ8873_TXQ_WFQ_ENABLE);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int ksz8_tc_setup_qdisc_ets(struct dsa_switch *ds, int port,
+				   struct tc_ets_qopt_offload *qopt)
+{
+	struct ksz_device *dev = ds->priv;
+	int ret;
+
+	if (!(ksz_is_ksz88x3(dev) || ksz_is_ksz8463(dev)))
+		return -EOPNOTSUPP;
+
+	if (qopt->parent != TC_H_ROOT) {
+		dev_err(dev->dev, "Parent should be \"root\"\n");
+		return -EOPNOTSUPP;
+	}
+
+	switch (qopt->command) {
+	case TC_ETS_REPLACE:
+		ret = ksz_tc_ets_validate(dev, port, &qopt->replace_params);
+		if (ret)
+			return ret;
+
+		return ksz88x3_tc_ets_add(dev, port, &qopt->replace_params);
+	case TC_ETS_DESTROY:
+		return ksz88x3_tc_ets_del(dev, port);
+	case TC_ETS_STATS:
+	case TC_ETS_GRAFT:
+		return -EOPNOTSUPP;
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static int ksz87xx_setup_tc(struct dsa_switch *ds, int port,
+			    enum tc_setup_type type, void *type_data)
+{
+	switch (type) {
+	case TC_SETUP_QDISC_CBS:
+		return ksz_setup_tc_cbs(ds, port, type_data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int ksz8_setup_tc(struct dsa_switch *ds, int port,
+			 enum tc_setup_type type, void *type_data)
+{
+	switch (type) {
+	case TC_SETUP_QDISC_CBS:
+		return ksz_setup_tc_cbs(ds, port, type_data);
+	case TC_SETUP_QDISC_ETS:
+		return ksz8_tc_setup_qdisc_ets(ds, port, type_data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static void ksz8795_cpu_interface_select(struct ksz_device *dev, int port)
 {
 	struct ksz_port *p = &dev->ports[port];
@@ -2645,7 +2798,7 @@ const struct dsa_switch_ops ksz8463_switch_ops = {
 	.port_hwtstamp_set	= ksz_hwtstamp_set,
 	.port_txtstamp		= ksz_port_txtstamp,
 	.port_rxtstamp		= ksz_port_rxtstamp,
-	.port_setup_tc		= ksz_setup_tc,
+	.port_setup_tc		= ksz8_setup_tc,
 	.port_get_default_prio	= ksz_port_get_default_prio,
 	.port_set_default_prio	= ksz_port_set_default_prio,
 	.port_get_dscp_prio	= ksz_port_get_dscp_prio,
@@ -2695,7 +2848,7 @@ const struct dsa_switch_ops ksz87xx_switch_ops = {
 	.port_hwtstamp_set	= ksz_hwtstamp_set,
 	.port_txtstamp		= ksz_port_txtstamp,
 	.port_rxtstamp		= ksz_port_rxtstamp,
-	.port_setup_tc		= ksz_setup_tc,
+	.port_setup_tc		= ksz87xx_setup_tc,
 	.port_get_default_prio	= ksz_port_get_default_prio,
 	.port_set_default_prio	= ksz_port_set_default_prio,
 	.port_get_dscp_prio	= ksz_port_get_dscp_prio,
@@ -2748,7 +2901,7 @@ const struct dsa_switch_ops ksz88xx_switch_ops = {
 	.port_hwtstamp_set	= ksz_hwtstamp_set,
 	.port_txtstamp		= ksz_port_txtstamp,
 	.port_rxtstamp		= ksz_port_rxtstamp,
-	.port_setup_tc		= ksz_setup_tc,
+	.port_setup_tc		= ksz8_setup_tc,
 	.port_get_default_prio	= ksz_port_get_default_prio,
 	.port_set_default_prio	= ksz_port_set_default_prio,
 	.port_get_dscp_prio	= ksz_port_get_dscp_prio,
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index b54aea92b67d..2846041d97a5 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3097,8 +3097,8 @@ static int ksz_setup_tc_mode(struct ksz_device *dev, int port, u8 scheduler,
 			   FIELD_PREP(MTI_SHAPING_M, shaper));
 }
 
-static int ksz_setup_tc_cbs(struct dsa_switch *ds, int port,
-			    struct tc_cbs_qopt_offload *qopt)
+int ksz_setup_tc_cbs(struct dsa_switch *ds, int port,
+		     struct tc_cbs_qopt_offload *qopt)
 {
 	struct ksz_device *dev = ds->priv;
 	int ret;
@@ -3163,8 +3163,8 @@ static int ksz_disable_egress_rate_limit(struct ksz_device *dev, int port)
 	return 0;
 }
 
-static int ksz_ets_band_to_queue(struct tc_ets_qopt_offload_replace_params *p,
-				 int band)
+int ksz_ets_band_to_queue(struct tc_ets_qopt_offload_replace_params *p,
+			  int band)
 {
 	/* Compared to queues, bands prioritize packets differently. In strict
 	 * priority mode, the lowest priority is assigned to Queue 0 while the
@@ -3173,104 +3173,6 @@ static int ksz_ets_band_to_queue(struct tc_ets_qopt_offload_replace_params *p,
 	return p->bands - 1 - band;
 }
 
-static u8 ksz8463_tc_ctrl(int port, int queue)
-{
-	u8 reg;
-
-	reg = 0xC8 + port * 4;
-	reg += ((3 - queue) / 2) * 2;
-	reg++;
-	reg -= (queue & 1);
-	return reg;
-}
-
-/**
- * ksz88x3_tc_ets_add - Configure ETS (Enhanced Transmission Selection)
- *                      for a port on KSZ88x3 switch
- * @dev: Pointer to the KSZ switch device structure
- * @port: Port number to configure
- * @p: Pointer to offload replace parameters describing ETS bands and mapping
- *
- * The KSZ88x3 supports two scheduling modes: Strict Priority and
- * Weighted Fair Queuing (WFQ). Both modes have fixed behavior:
- *   - No configurable queue-to-priority mapping
- *   - No weight adjustment in WFQ mode
- *
- * This function configures the switch to use strict priority mode by
- * clearing the WFQ enable bit for all queues associated with ETS bands.
- * If strict priority is not explicitly requested, the switch will default
- * to WFQ mode.
- *
- * Return: 0 on success, or a negative error code on failure
- */
-static int ksz88x3_tc_ets_add(struct ksz_device *dev, int port,
-			      struct tc_ets_qopt_offload_replace_params *p)
-{
-	int ret, band;
-
-	/* Only strict priority mode is supported for now.
-	 * WFQ is implicitly enabled when strict mode is disabled.
-	 */
-	for (band = 0; band < p->bands; band++) {
-		int queue = ksz_ets_band_to_queue(p, band);
-		u8 reg;
-
-		/* Calculate TXQ Split Control register address for this
-		 * port/queue
-		 */
-		reg = KSZ8873_TXQ_SPLIT_CTRL_REG(port, queue);
-		if (ksz_is_ksz8463(dev))
-			reg = ksz8463_tc_ctrl(port, queue);
-
-		/* Clear WFQ enable bit to select strict priority scheduling */
-		ret = ksz_rmw8(dev, reg, KSZ8873_TXQ_WFQ_ENABLE, 0);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-/**
- * ksz88x3_tc_ets_del - Reset ETS (Enhanced Transmission Selection) config
- *                      for a port on KSZ88x3 switch
- * @dev: Pointer to the KSZ switch device structure
- * @port: Port number to reset
- *
- * The KSZ88x3 supports only fixed scheduling modes: Strict Priority or
- * Weighted Fair Queuing (WFQ), with no reconfiguration of weights or
- * queue mapping. This function resets the port’s scheduling mode to
- * the default, which is WFQ, by enabling the WFQ bit for all queues.
- *
- * Return: 0 on success, or a negative error code on failure
- */
-static int ksz88x3_tc_ets_del(struct ksz_device *dev, int port)
-{
-	int ret, queue;
-
-	/* Iterate over all transmit queues for this port */
-	for (queue = 0; queue < dev->info->num_tx_queues; queue++) {
-		u8 reg;
-
-		/* Calculate TXQ Split Control register address for this
-		 * port/queue
-		 */
-		reg = KSZ8873_TXQ_SPLIT_CTRL_REG(port, queue);
-		if (ksz_is_ksz8463(dev))
-			reg = ksz8463_tc_ctrl(port, queue);
-
-		/* Set WFQ enable bit to revert back to default scheduling
-		 * mode
-		 */
-		ret = ksz_rmw8(dev, reg, KSZ8873_TXQ_WFQ_ENABLE,
-			       KSZ8873_TXQ_WFQ_ENABLE);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
 static int ksz_queue_set_strict(struct ksz_device *dev, int port, int queue)
 {
 	int ret;
@@ -3363,8 +3265,8 @@ static int ksz_tc_ets_del(struct ksz_device *dev, int port)
 	return ksz9477_set_default_prio_queue_mapping(dev, port);
 }
 
-static int ksz_tc_ets_validate(struct ksz_device *dev, int port,
-			       struct tc_ets_qopt_offload_replace_params *p)
+int ksz_tc_ets_validate(struct ksz_device *dev, int port,
+			struct tc_ets_qopt_offload_replace_params *p)
 {
 	int band;
 
@@ -3405,9 +3307,6 @@ static int ksz_tc_setup_qdisc_ets(struct dsa_switch *ds, int port,
 	struct ksz_device *dev = ds->priv;
 	int ret;
 
-	if (is_ksz8(dev) && !(ksz_is_ksz88x3(dev) || ksz_is_ksz8463(dev)))
-		return -EOPNOTSUPP;
-
 	if (qopt->parent != TC_H_ROOT) {
 		dev_err(dev->dev, "Parent should be \"root\"\n");
 		return -EOPNOTSUPP;
@@ -3419,16 +3318,9 @@ static int ksz_tc_setup_qdisc_ets(struct dsa_switch *ds, int port,
 		if (ret)
 			return ret;
 
-		if (ksz_is_ksz88x3(dev) || ksz_is_ksz8463(dev))
-			return ksz88x3_tc_ets_add(dev, port,
-						  &qopt->replace_params);
-		else
-			return ksz_tc_ets_add(dev, port, &qopt->replace_params);
+		return ksz_tc_ets_add(dev, port, &qopt->replace_params);
 	case TC_ETS_DESTROY:
-		if (ksz_is_ksz88x3(dev) || ksz_is_ksz8463(dev))
-			return ksz88x3_tc_ets_del(dev, port);
-		else
-			return ksz_tc_ets_del(dev, port);
+		return ksz_tc_ets_del(dev, port);
 	case TC_ETS_STATS:
 	case TC_ETS_GRAFT:
 		return -EOPNOTSUPP;
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 245329b6e0e9..7aa4a69d06ef 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -14,6 +14,7 @@
 #include <linux/phy.h>
 #include <linux/regmap.h>
 #include <net/dsa.h>
+#include <net/pkt_cls.h>
 #include <linux/irq.h>
 #include <linux/platform_data/microchip-ksz.h>
 
@@ -481,6 +482,12 @@ void ksz_phylink_mac_link_down(struct phylink_config *config,
 int ksz_set_mac_eee(struct dsa_switch *ds, int port,
 		    struct ethtool_keee *e);
 
+int ksz_ets_band_to_queue(struct tc_ets_qopt_offload_replace_params *p,
+			  int band);
+int ksz_setup_tc_cbs(struct dsa_switch *ds, int port,
+		     struct tc_cbs_qopt_offload *qopt);
+int ksz_tc_ets_validate(struct ksz_device *dev, int port,
+			struct tc_ets_qopt_offload_replace_params *p);
 int ksz_setup_tc(struct dsa_switch *ds, int port,
 		 enum tc_setup_type type, void *type_data);
 

-- 
2.54.0


