Return-Path: <netdev+bounces-303168-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pqrvHAK9Q2qegAoAu9opvQ
	(envelope-from <netdev+bounces-303168-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:56:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEBA6E480A
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:56:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=couthit.com header.s=default header.b=Oz85Bj6p;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303168-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303168-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=couthit.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C34CC30F51D4
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 12:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D984C40E8E3;
	Tue, 30 Jun 2026 12:51:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92353F7AB5;
	Tue, 30 Jun 2026 12:51:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823865; cv=none; b=TuHpjqgCmBKHgojaY3lko7tcmsT7hgKWgXe2bJ/D/FHQMpNP8DGeI+kioFxQCuUap8QsSkQ/bxXUATXe4AVaQ22ep1Oe25e0Cf3AnMWvCvuHGpNcIM1TZU6azMN/kwB0rjbTFpbj8gk0WhKmch/xlpnF/PddNAu06QCi/RgFQzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823865; c=relaxed/simple;
	bh=3VwLgl3Q0kLEGe7wl79XqI909Q6FZmB7411SXhOcUlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XZodtsqBevqyFBy5+wENc4jUYz1E74vX63jsUKOJSMkmzGw7TNyt1SDu9U0kGfbXAdddPP6ARzafmvcYNpAxp7AOtwpa7u+lW+Hz9g6YbqQ8oY53Bz54u/Sk9wO8cyvorffKvbr82cJ5xeb/oISJZqdqQTiysFdkQPsyYcmCCf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=Oz85Bj6p; arc=none smtp.client-ip=162.240.164.96
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kb0sFCemfBMjVcrb5YdRQGujXPc3280q/X/OZ8KnR5c=; b=Oz85Bj6phMNecddkWYxd5T4NkK
	jI+U88Y69xzvfmBXzapSacetq8gHd26zTJkM1hGrWu5AV25T5Kne5WskDP/sXbC6qrxZNQFFEQSQB
	WjjryTJvtSXDYztcdF7D2zCZxL9SQ2IbdE/jWnUcXjLHkq1z6HMnAlkDQwPtrYRi2VDVliETWjpVu
	vYh2jJGIiExorNfLD3LrqfI+2em+NtA/XS6XA3Gv0n2xn8YQmFbB5Is5SQntRsvCes5ULG8+tkVQ7
	4SY7tEXP7ID0z2qW88HCcked2jHTJ11TmveMG+ju+LzfEdE0qPTjzL4akmB3RZS7szWSyLunlITx5
	6ZnKV4Zw==;
Received: from [115.246.246.98] (port=58869 helo=cypher.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <parvathi@couthit.com>)
	id 1weXvY-00000006qlQ-1mPo;
	Tue, 30 Jun 2026 08:51:00 -0400
From: Parvathi Pudi <parvathi@couthit.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	danishanwar@ti.com,
	parvathi@couthit.com,
	rogerq@kernel.org,
	pmohan@couthit.com,
	afd@ti.com,
	basharath@couthit.com,
	arnd@arndb.de
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	pratheesh@ti.com,
	j-rameshbabu@ti.com,
	vigneshr@ti.com,
	praneeth@ti.com,
	srk@ti.com,
	rogerq@ti.com,
	m-malladi@ti.com,
	krishna@couthit.com,
	mohan@couthit.com
Subject: [PATCH net-next v2 2/3] net: ti: icssm-prueth: Add priority based RX IRQ handlers
Date: Tue, 30 Jun 2026 18:16:15 +0530
Message-ID: <20260630124958.894360-3-parvathi@couthit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630124958.894360-1-parvathi@couthit.com>
References: <20260630124958.894360-1-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: parvathi@couthit.com
X-Authenticated-Sender: server.couthit.com: parvathi@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[couthit.com:s=default];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[couthit.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303168-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	HAS_X_GMSV(0.00)[parvathi@couthit.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[parvathi@couthit.com,netdev@vger.kernel.org];
	HAS_X_AS(0.00)[parvathi@couthit.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:danishanwar@ti.com,m:parvathi@couthit.com,m:rogerq@kernel.org,m:pmohan@couthit.com,m:afd@ti.com,m:basharath@couthit.com,m:arnd@arndb.de,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:pratheesh@ti.com,m:j-rameshbabu@ti.com,m:vigneshr@ti.com,m:praneeth@ti.com,m:srk@ti.com,m:rogerq@ti.com,m:m-malladi@ti.com,m:krishna@couthit.com,m:mohan@couthit.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[couthit.com:-];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[parvathi@couthit.com,netdev@vger.kernel.org];
	HAS_X_SOURCE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	HAS_X_ANTIABUSE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,ti.com:url,ti.com:email,couthit.com:email,couthit.com:mid,couthit.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DCEBA6E480A

From: Roger Quadros <rogerq@ti.com>

This patch adds support for priority based interrupt handling for the STP/
RSTP Switch, HSR and PRP protocols along with extra logic to address first
come first served to avoid port dominance.

In RSTP switch, HSR, and PRP modes the host port can receive frames from
any one of PRU ports. Servicing RX interrupts in arrival order does not
guarantee the frames are delivered to the stack in wire-arrival order due
to port dominance.

In order to achieve that, each PRU records an IEP (Industrial Ethernet
Peripheral) arrival HW timestamp into the receive buffer and pass this
information to driver. The driver will read the RX HW timestamp from frame
and process the frame which has arrived first among the two ports, giving
the stack wire-arrival ordering.

Dual-EMAC mode continues to use per-port interrupts.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
---
 drivers/net/ethernet/ti/Makefile              |   2 +-
 drivers/net/ethernet/ti/icssm/icssm_prueth.c  | 139 ++++++++-
 drivers/net/ethernet/ti/icssm/icssm_prueth.h  |  30 ++
 .../ethernet/ti/icssm/icssm_prueth_common.c   | 286 ++++++++++++++++++
 .../net/ethernet/ti/icssm/icssm_prueth_lre.c  |  13 +
 5 files changed, 458 insertions(+), 12 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_common.c

diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index e4a10d60e1a6..b6651fe73afd 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -4,7 +4,7 @@
 #
 
 obj-$(CONFIG_TI_PRUETH) += icssm-prueth.o
-icssm-prueth-y := icssm/icssm_prueth.o icssm/icssm_prueth_switch.o icssm/icssm_switchdev.o icssm/icssm_prueth_lre.o
+icssm-prueth-y := icssm/icssm_prueth.o icssm/icssm_prueth_switch.o icssm/icssm_switchdev.o icssm/icssm_prueth_lre.o icssm/icssm_prueth_common.o
 
 ti-cpsw-common-y += cpsw-common.o davinci_cpdma.o
 ti-cpsw-priv-y += cpsw_priv.o cpsw_ethtool.o
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
index c01edac8f0b7..2ab78a98f856 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
@@ -44,7 +44,21 @@
 #define NETIF_PRUETH_LRE_OFFLOAD_FEATURES       (NETIF_F_HW_HSR_FWD | \
 						 NETIF_F_HW_HSR_TAG_RM)
 
-static const struct prueth_fw_offsets fw_offsets_v2_1;
+/* ICSSM (v2.1) - supports 64-bit IEP counter.
+ * Firmware stores packet timestamps using lower 32 bits
+ * which wraps at 0xffffffff.
+ */
+static const struct prueth_fw_offsets fw_offsets_v2_1 = {
+	.iep_wrap = 0xffffffff,
+};
+
+/* ICSSM (v1.0) - supports 32-bit IEP counter, which resets the
+ * counter every one second (nanosecond resolution).
+ */
+static const struct prueth_fw_offsets fw_offsets_v1_0 = {
+	.iep_wrap = NSEC_PER_SEC,
+};
+
 static void icssm_prueth_set_fw_offsets(struct prueth *prueth)
 {
 	/* Set Multicast filter control and table offsets */
@@ -1094,11 +1108,25 @@ static int icssm_emac_ndo_open(struct net_device *ndev)
 			goto iep_exit;
 	}
 
-	ret = icssm_emac_request_irqs(emac);
-	if (ret)
-		goto rproc_shutdown;
+	if (PRUETH_IS_EMAC(prueth)) {
+		napi_enable(&emac->napi);
+	} else {
+		if (!prueth->emac_configured &&
+		    (PRUETH_IS_SWITCH(prueth) || prueth_is_lre(prueth))) {
+			napi_enable(&prueth->napi_hpq);
+			napi_enable(&prueth->napi_lpq);
+		}
+	}
 
-	napi_enable(&emac->napi);
+	/* In switch and LRE modes the shared HPQ/LPQ IRQs are used,
+	 * register them here and reuse for both modes.
+	 */
+	if (PRUETH_IS_EMAC(prueth))
+		ret = icssm_emac_request_irqs(emac);
+	else
+		ret = icssm_prueth_common_request_irqs(emac);
+	if (ret)
+		goto disable_napi;
 
 	/* start PHY */
 	phy_start(emac->phydev);
@@ -1115,7 +1143,17 @@ static int icssm_emac_ndo_open(struct net_device *ndev)
 
 	return 0;
 
-rproc_shutdown:
+disable_napi:
+	if (PRUETH_IS_EMAC(prueth)) {
+		napi_disable(&emac->napi);
+	} else {
+		if (!prueth->emac_configured &&
+		    (PRUETH_IS_SWITCH(prueth) || prueth_is_lre(prueth))) {
+			napi_disable(&prueth->napi_lpq);
+			napi_disable(&prueth->napi_hpq);
+		}
+	}
+
 	if (!PRUETH_IS_EMAC(prueth))
 		icssm_prueth_sw_shutdown_prus(emac, ndev);
 	else
@@ -1150,12 +1188,26 @@ static int icssm_emac_ndo_stop(struct net_device *ndev)
 	/* disable the mac port */
 	icssm_prueth_port_enable(emac, false);
 
+	netif_stop_queue(ndev);
+
 	/* stop PHY */
 	phy_stop(emac->phydev);
 
-	napi_disable(&emac->napi);
 	hrtimer_cancel(&emac->tx_hrtimer);
 
+	if (PRUETH_IS_EMAC(prueth)) {
+		napi_disable(&emac->napi);
+		free_irq(emac->rx_irq, ndev);
+	} else {
+		if (!prueth->emac_configured &&
+		    (PRUETH_IS_SWITCH(prueth) || prueth_is_lre(prueth))) {
+			napi_disable(&prueth->napi_lpq);
+			napi_disable(&prueth->napi_hpq);
+		}
+		/* Free IRQs on last port before halting PRU */
+		icssm_prueth_common_free_irqs(emac);
+	}
+
 	/* stop the PRU */
 	if (!PRUETH_IS_EMAC(prueth))
 		icssm_prueth_sw_shutdown_prus(emac, ndev);
@@ -1165,9 +1217,6 @@ static int icssm_emac_ndo_stop(struct net_device *ndev)
 	if (prueth_is_lre(prueth))
 		icssm_prueth_lre_cleanup(prueth);
 
-	/* free rx interrupts */
-	free_irq(emac->rx_irq, ndev);
-
 	/* free memory related to sw */
 	icssm_prueth_free_memory(emac->prueth);
 
@@ -1767,9 +1816,25 @@ static int icssm_prueth_netdev_init(struct prueth *prueth,
 
 	netif_napi_add(ndev, &emac->napi, icssm_emac_napi_poll);
 
+	if ((prueth->support_lre || fw_data->support_switch) &&
+	    emac->port_id == PRUETH_PORT_MII0) {
+		netif_napi_add(ndev, &prueth->napi_hpq,
+			       icssm_prueth_lre_napi_poll_hpq);
+		netif_napi_add(ndev, &prueth->napi_lpq,
+			       icssm_prueth_lre_napi_poll_lpq);
+	}
+
 	hrtimer_setup(&emac->tx_hrtimer, &icssm_emac_tx_timer_callback,
 		      CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
 
+	if ((prueth->support_lre || fw_data->support_switch) &&
+	    emac->port_id == PRUETH_PORT_MII0) {
+		prueth->hp->ndev = ndev;
+		prueth->hp->priority = 0;
+		prueth->lp->ndev = ndev;
+		prueth->lp->priority = 1;
+	}
+
 	return 0;
 free:
 	emac->ndev = NULL;
@@ -1781,6 +1846,7 @@ static int icssm_prueth_netdev_init(struct prueth *prueth,
 static void icssm_prueth_netdev_exit(struct prueth *prueth,
 				     struct device_node *eth_node)
 {
+	const struct prueth_private_data *fw_data = prueth->fw_data;
 	struct prueth_emac *emac;
 	enum prueth_mac mac;
 
@@ -1795,6 +1861,13 @@ static void icssm_prueth_netdev_exit(struct prueth *prueth,
 	phy_disconnect(emac->phydev);
 
 	netif_napi_del(&emac->napi);
+
+	if ((prueth->support_lre || fw_data->support_switch) &&
+	    emac->port_id == PRUETH_PORT_MII0) {
+		netif_napi_del(&prueth->napi_hpq);
+		netif_napi_del(&prueth->napi_lpq);
+	}
+
 	prueth->emac[mac] = NULL;
 }
 
@@ -2094,7 +2167,13 @@ static int icssm_prueth_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, prueth);
 	prueth->dev = dev;
 	prueth->fw_data = device_get_match_data(dev);
-	prueth->fw_offsets = fw_offsets_v2_1;
+
+	if (prueth->fw_data->fw_rev == FW_REV_V1_0)
+		prueth->fw_offsets = fw_offsets_v1_0;
+	else if (prueth->fw_data->fw_rev == FW_REV_V2_1)
+		prueth->fw_offsets = fw_offsets_v2_1;
+	else
+		return -EINVAL;
 
 	eth_ports_node = of_get_child_by_name(np, "ethernet-ports");
 	if (!eth_ports_node)
@@ -2249,6 +2328,41 @@ static int icssm_prueth_probe(struct platform_device *pdev)
 	if (has_lre && (!eth0_node || !eth1_node))
 		has_lre = false;
 
+	/* Switch and LRE share HPQ/LPQ IRQs across both ports,
+	 * allocate the shared priority structures once here
+	 */
+	if (prueth->fw_data->support_switch || has_lre) {
+		prueth->hp = devm_kzalloc(dev,
+					  sizeof(struct prueth_ndev_priority),
+					  GFP_KERNEL);
+		if (!prueth->hp) {
+			ret = -ENOMEM;
+			goto free_pool;
+		}
+		prueth->lp = devm_kzalloc(dev,
+					  sizeof(struct prueth_ndev_priority),
+					  GFP_KERNEL);
+		if (!prueth->lp) {
+			ret = -ENOMEM;
+			goto free_pool;
+		}
+
+		prueth->rx_lpq_irq = of_irq_get_byname(np, "rx_lp");
+		if (prueth->rx_lpq_irq < 0) {
+			ret = prueth->rx_lpq_irq;
+			if (ret != -EPROBE_DEFER)
+				dev_err(prueth->dev, "could not get rx_lp irq\n");
+			goto free_pool;
+		}
+		prueth->rx_hpq_irq = of_irq_get_byname(np, "rx_hp");
+		if (prueth->rx_hpq_irq < 0) {
+			ret = prueth->rx_hpq_irq;
+			if (ret != -EPROBE_DEFER)
+				dev_err(prueth->dev, "could not get rx_hp irq\n");
+			goto free_pool;
+		}
+	}
+
 	prueth->support_lre = has_lre;
 	spin_lock_init(&prueth->addr_lock);
 	/* setup netdev interfaces */
@@ -2489,6 +2603,7 @@ static struct prueth_private_data am335x_prueth_pdata = {
 		.fw_name[PRUSS_ETHTYPE_SWITCH] =
 			"ti-pruss/am335x-pru1-prusw-fw.elf",
 	},
+	.fw_rev = FW_REV_V1_0,
 	.support_lre = true,
 	.support_switch = true,
 };
@@ -2516,6 +2631,7 @@ static struct prueth_private_data am437x_prueth_pdata = {
 		.fw_name[PRUSS_ETHTYPE_SWITCH] =
 			"ti-pruss/am437x-pru1-prusw-fw.elf",
 	},
+	.fw_rev = FW_REV_V1_0,
 	.support_lre = true,
 	.support_switch = true,
 };
@@ -2544,6 +2660,7 @@ static struct prueth_private_data am57xx_prueth_pdata = {
 			"ti-pruss/am57xx-pru1-prusw-fw.elf",
 
 	},
+	.fw_rev = FW_REV_V2_1,
 	.support_lre = true,
 	.support_switch = true,
 };
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.h b/drivers/net/ethernet/ti/icssm/icssm_prueth.h
index a5d5bcd08bcd..4edd6cf300f3 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth.h
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.h
@@ -179,11 +179,22 @@ enum prueth_mem {
 	PRUETH_MEM_MAX,
 };
 
+/* PRU firmware revision */
+enum fw_revision {
+	FW_REV_INVALID = 0,
+	FW_REV_V1_0,
+	FW_REV_V2_1
+};
+
 /* Firmware offsets/size information */
 struct prueth_fw_offsets {
 	u32 mc_ctrl_offset;
 	u32 mc_filter_mask;
 	u32 mc_filter_tbl;
+	/* IEP wrap is used in the rx packet ordering logic and
+	 * is different for ICSSM v1.0 vs 2.1
+	 */
+	u32 iep_wrap;
 };
 
 enum pruss_device {
@@ -197,12 +208,14 @@ enum pruss_device {
  * struct prueth_private_data - PRU Ethernet private data
  * @driver_data: PRU Ethernet device name
  * @fw_pru: firmware names to be used for PRUSS ethernet usecases
+ * @fw_rev: Firmware revision identifier
  * @support_switch: boolean to indicate if switch is enabled
  * @support_lre: boolean to indicate if LRE is enabled
  */
 struct prueth_private_data {
 	enum pruss_device driver_data;
 	const struct prueth_firmware fw_pru[PRUSS_NUM_PRUS];
+	enum fw_revision fw_rev;
 	bool support_switch;
 	bool support_lre;
 };
@@ -255,6 +268,11 @@ struct prueth_emac {
 	int offload_fwd_mark;
 };
 
+struct prueth_ndev_priority {
+	struct net_device *ndev;
+	int priority;
+};
+
 struct prueth {
 	struct device *dev;
 	struct pruss *pruss;
@@ -270,6 +288,12 @@ struct prueth {
 	struct device_node *eth_node[PRUETH_NUM_MACS];
 	struct prueth_emac *emac[PRUETH_NUM_MACS];
 	struct net_device *registered_netdevs[PRUETH_NUM_MACS];
+	struct prueth_ndev_priority *hp, *lp;
+	/* NAPI for lp and hp queue scans */
+	struct napi_struct napi_lpq;
+	struct napi_struct napi_hpq;
+	int rx_lpq_irq;
+	int rx_hpq_irq;
 
 	bool support_lre;
 	unsigned int tbl_check_mask;
@@ -303,6 +327,12 @@ void icssm_emac_mc_filter_bin_allow(struct prueth_emac *emac, u8 hash);
 void icssm_emac_mc_filter_bin_disallow(struct prueth_emac *emac, u8 hash);
 u8 icssm_emac_get_mc_hash(u8 *mac, u8 *mask);
 
+int icssm_prueth_lre_napi_poll_lpq(struct napi_struct *napi, int budget);
+int icssm_prueth_lre_napi_poll_hpq(struct napi_struct *napi, int budget);
+
+int icssm_prueth_common_request_irqs(struct prueth_emac *emac);
+void icssm_prueth_common_free_irqs(struct prueth_emac *emac);
+
 static inline bool prueth_is_lre(struct prueth *prueth)
 {
 	return PRUETH_IS_HSR(prueth) || PRUETH_IS_PRP(prueth);
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_common.c b/drivers/net/ethernet/ti/icssm/icssm_prueth_common.c
new file mode 100644
index 000000000000..50269a5e915b
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_common.c
@@ -0,0 +1,286 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Texas Instruments ICSSM Ethernet Driver
+ *
+ * Copyright (C) 2018-2022 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/if_vlan.h>
+
+#include "icssm_prueth.h"
+#include "icssm_prueth_switch.h"
+
+static int icssm_prueth_common_emac_rx_packets(struct prueth_emac *emac,
+					       int quota, u8 qid1, u8 qid2)
+{
+	u16 bd_rd_ptr, bd_wr_ptr, update_rd_ptr, bd_rd_ptr_o, bd_wr_ptr_o;
+	const struct prueth_queue_info *rxqueue, *rxqueue_o, *rxqueue_p;
+	struct net_device_stats *ndevstats, *ndevstats_o, *ndevstats_p;
+	struct prueth_queue_desc __iomem *queue_desc, *queue_desc_o;
+	struct prueth_packet_info pkt_info, pkt_info_o, *pkt_info_p;
+	u32 rd_buf_desc, rd_buf_desc_o, pkt_ts, pkt_ts_o, iep_wrap;
+	int ret, used = 0, port, port0_q_empty, port1_q_empty;
+	struct prueth_emac *emac_p, *other_emac;
+	void __iomem *shared_ram, *ocmc_ram;
+	u8 overflow_cnt, overflow_cnt_o;
+	u16 *bd_rd_ptr_p, *bd_wr_ptr_p;
+	struct prueth *prueth;
+
+	prueth = emac->prueth;
+	ocmc_ram = prueth->mem[PRUETH_MEM_OCMC].va;
+	shared_ram = prueth->mem[PRUETH_MEM_SHARED_RAM].va;
+	other_emac = prueth->emac[(emac->port_id == PRUETH_PORT_MII0) ?
+			PRUETH_PORT_MII1 - 1 : PRUETH_PORT_MII0 - 1];
+	ndevstats = &emac->ndev->stats;
+	ndevstats_o = &other_emac->ndev->stats;
+
+	iep_wrap = prueth->fw_offsets.iep_wrap;
+	/* search host queues for packets */
+	queue_desc = emac->rx_queue_descs + qid1;
+	queue_desc_o = other_emac->rx_queue_descs + qid2;
+
+	rxqueue = &sw_queue_infos[PRUETH_PORT_HOST][qid1];
+	rxqueue_o = &sw_queue_infos[PRUETH_PORT_HOST][qid2];
+
+	/* skip Rx if budget is 0 */
+	if (!quota)
+		return 0;
+
+	overflow_cnt = readb(&queue_desc->overflow_cnt);
+	overflow_cnt_o = readb(&queue_desc_o->overflow_cnt);
+
+	if (overflow_cnt > 0) {
+		emac->ndev->stats.rx_over_errors += overflow_cnt;
+		writeb(0, &queue_desc->overflow_cnt);
+	}
+	if (overflow_cnt_o > 0) {
+		other_emac->ndev->stats.rx_over_errors += overflow_cnt_o;
+		writeb(0, &queue_desc_o->overflow_cnt);
+	}
+
+	bd_rd_ptr = readw(&queue_desc->rd_ptr);
+	bd_wr_ptr = readw(&queue_desc->wr_ptr);
+
+	bd_rd_ptr_o = readw(&queue_desc_o->rd_ptr);
+	bd_wr_ptr_o = readw(&queue_desc_o->wr_ptr);
+
+	port0_q_empty = (bd_rd_ptr == bd_wr_ptr);
+	port1_q_empty = (bd_rd_ptr_o == bd_wr_ptr_o);
+
+	while (!port0_q_empty || !port1_q_empty) {
+		rd_buf_desc = readl(shared_ram + bd_rd_ptr);
+		rd_buf_desc_o = readl(shared_ram + bd_rd_ptr_o);
+
+		icssm_parse_packet_info(prueth, rd_buf_desc, &pkt_info);
+		icssm_parse_packet_info(prueth, rd_buf_desc_o, &pkt_info_o);
+
+		pkt_ts = readl(ocmc_ram + ICSS_LRE_TIMESTAMP_ARRAY_OFFSET +
+			       bd_rd_ptr - SRAM_START_OFFSET);
+		pkt_ts_o = readl(ocmc_ram + ICSS_LRE_TIMESTAMP_ARRAY_OFFSET +
+				 bd_rd_ptr_o - SRAM_START_OFFSET);
+
+		if (!port0_q_empty && !port1_q_empty) {
+			/* Both ports have a pending frame, pick the
+			 * earlier one by comparing timestamps and
+			 * account for wraparound.
+			 */
+			if (pkt_ts > pkt_ts_o)
+				port = (pkt_ts - pkt_ts_o) > (iep_wrap / 2) ?
+					0 : 1;
+			else
+				port = (pkt_ts_o - pkt_ts) > (iep_wrap / 2) ?
+					1 : 0;
+
+		} else if (!port0_q_empty) {
+			/* Packet(s) in port0 queue only */
+			port = 0;
+		} else {
+			/* Packet(s) in port1 queue only */
+			port = 1;
+		}
+
+		/* Select correct data structures for queue/packet selected */
+		if (port == 0) {
+			pkt_info_p = &pkt_info;
+			bd_wr_ptr_p = &bd_wr_ptr;
+			bd_rd_ptr_p = &bd_rd_ptr;
+			emac_p = emac;
+			ndevstats_p = ndevstats;
+			rxqueue_p = rxqueue;
+		} else {
+			pkt_info_p = &pkt_info_o;
+			bd_wr_ptr_p = &bd_wr_ptr_o;
+			bd_rd_ptr_p = &bd_rd_ptr_o;
+			emac_p = other_emac;
+			ndevstats_p = ndevstats_o;
+			rxqueue_p = rxqueue_o;
+		}
+
+		if ((*pkt_info_p).length < EMAC_MIN_PKTLEN) {
+			/* Undersized frame: firmware should have filtered
+			 * these before they reach the host queue. Advance
+			 * the read pointer to skip it.
+			 */
+			update_rd_ptr = *bd_wr_ptr_p;
+			ndevstats_p->rx_length_errors++;
+		} else if ((*pkt_info_p).length > EMAC_MAX_FRM_SUPPORT) {
+			/* Oversized frame: firmware should have filtered
+			 * these before they reach the host queue. Advance
+			 * the read pointer to skip it.
+			 */
+			update_rd_ptr = *bd_wr_ptr_p;
+			ndevstats_p->rx_length_errors++;
+		} else {
+			update_rd_ptr = *bd_rd_ptr_p;
+			ret = icssm_emac_rx_packet(emac_p, &update_rd_ptr,
+						   pkt_info_p, rxqueue_p);
+			if (ret)
+				return used;
+
+			used++;
+		}
+
+		/* Zero the BD after consuming it, a misaligned rd_ptr
+		 * would otherwise mistake stale data for a valid incoming
+		 * frame.
+		 */
+		if (port == 0) {
+			writel(0, shared_ram + bd_rd_ptr);
+			writew(update_rd_ptr, &queue_desc->rd_ptr);
+			bd_rd_ptr = update_rd_ptr;
+		} else {
+			writel(0, shared_ram + bd_rd_ptr_o);
+			writew(update_rd_ptr, &queue_desc_o->rd_ptr);
+			bd_rd_ptr_o = update_rd_ptr;
+		}
+
+		port0_q_empty = (bd_rd_ptr == bd_wr_ptr) ? 1 : 0;
+		port1_q_empty = (bd_rd_ptr_o == bd_wr_ptr_o) ? 1 : 0;
+
+		if (used >= quota)
+			return used;
+	}
+
+	return used;
+}
+
+int icssm_prueth_lre_napi_poll_lpq(struct napi_struct *napi, int budget)
+{
+	struct prueth_emac *emac;
+	struct net_device *ndev;
+	struct prueth *prueth;
+	int num_rx_packets;
+	u8 qid1, qid2;
+
+	prueth = container_of(napi, struct prueth, napi_lpq);
+	ndev = prueth->lp->ndev;
+	emac = netdev_priv(ndev);
+	qid1 = PRUETH_QUEUE2;
+	qid2 = PRUETH_QUEUE4;
+
+	num_rx_packets = icssm_prueth_common_emac_rx_packets(emac, budget,
+							     qid1, qid2);
+	if (num_rx_packets < budget && napi_complete_done(napi, num_rx_packets))
+		enable_irq(prueth->rx_lpq_irq);
+
+	return num_rx_packets;
+}
+
+int icssm_prueth_lre_napi_poll_hpq(struct napi_struct *napi, int budget)
+{
+	struct prueth_emac *emac;
+	struct net_device *ndev;
+	struct prueth *prueth;
+	int num_rx_packets;
+	u8 qid1, qid2;
+
+	prueth = container_of(napi, struct prueth, napi_hpq);
+	ndev = prueth->hp->ndev;
+	emac = netdev_priv(ndev);
+	qid1 = PRUETH_QUEUE1;
+	qid2 = PRUETH_QUEUE3;
+
+	num_rx_packets = icssm_prueth_common_emac_rx_packets(emac, budget,
+							     qid1, qid2);
+	if (num_rx_packets < budget && napi_complete_done(napi, num_rx_packets))
+		enable_irq(prueth->rx_hpq_irq);
+
+	return num_rx_packets;
+}
+
+static irqreturn_t icssm_prueth_common_emac_rx_hardirq(int irq, void *dev_id)
+{
+	struct prueth_ndev_priority *ndev_prio;
+	struct prueth_emac *emac;
+	struct net_device *ndev;
+	struct prueth *prueth;
+
+	ndev_prio = (struct prueth_ndev_priority *)dev_id;
+	ndev = ndev_prio->ndev;
+	emac = netdev_priv(ndev);
+	prueth = emac->prueth;
+
+	/* disable Rx system event */
+	if (ndev_prio->priority == 1) {
+		disable_irq_nosync(prueth->rx_lpq_irq);
+		napi_schedule(&prueth->napi_lpq);
+	} else {
+		disable_irq_nosync(prueth->rx_hpq_irq);
+		napi_schedule(&prueth->napi_hpq);
+	}
+
+	return IRQ_HANDLED;
+}
+
+int icssm_prueth_common_request_irqs(struct prueth_emac *emac)
+{
+	struct prueth *prueth = emac->prueth;
+	int ret;
+
+	/* Request irq when first port is initialized */
+	if (prueth->emac_configured)
+		return 0;
+
+	ret = request_irq(prueth->rx_hpq_irq,
+			  icssm_prueth_common_emac_rx_hardirq,
+			  IRQF_TRIGGER_HIGH, "eth_hp_int", prueth->hp);
+	if (ret) {
+		netdev_err(emac->ndev, "unable to request RX HPQ IRQ\n");
+		return ret;
+	}
+
+	ret = request_irq(prueth->rx_lpq_irq,
+			  icssm_prueth_common_emac_rx_hardirq,
+			  IRQF_TRIGGER_HIGH, "eth_lp_int", prueth->lp);
+	if (ret) {
+		netdev_err(emac->ndev, "unable to request RX LPQ IRQ\n");
+		goto free_rx_hpq_irq;
+	}
+
+	return 0;
+
+free_rx_hpq_irq:
+	free_irq(prueth->rx_hpq_irq, prueth->hp);
+
+	return ret;
+}
+
+/**
+ * icssm_prueth_common_free_irqs - free irq
+ *
+ * @emac: EMAC data structure
+ *
+ */
+void icssm_prueth_common_free_irqs(struct prueth_emac *emac)
+{
+	struct prueth *prueth = emac->prueth;
+
+	/* HSR/PRP: free irqs when last port is down */
+	if (prueth->emac_configured)
+		return;
+
+	free_irq(prueth->rx_lpq_irq, prueth->lp);
+	free_irq(prueth->rx_hpq_irq, prueth->hp);
+}
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_lre.c b/drivers/net/ethernet/ti/icssm/icssm_prueth_lre.c
index 6276dd1e8bb1..239542101943 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth_lre.c
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_lre.c
@@ -152,6 +152,14 @@ static void icssm_prueth_lre_protocol_init(struct prueth *prueth)
 	       dram1 + ICSS_LRE_SUP_ADDR_LOW);
 }
 
+static void icssm_prueth_lre_config_packet_timestamping(struct prueth *prueth)
+{
+	void __iomem *sram = prueth->mem[PRUETH_MEM_SHARED_RAM].va;
+
+	writeb(1, sram + ICSS_LRE_PRIORITY_INTRS_STATUS_OFFSET);
+	writeb(1, sram + ICSS_LRE_TIMESTAMP_PKTS_STATUS_OFFSET);
+}
+
 static enum hrtimer_restart icssm_prueth_lre_timer(struct hrtimer *timer)
 {
 	struct prueth *prueth;
@@ -202,6 +210,11 @@ void icssm_prueth_lre_config(struct prueth *prueth)
 	icssm_prueth_lre_init(prueth);
 	icssm_prueth_lre_dbg_init(prueth);
 	icssm_prueth_lre_protocol_init(prueth);
+	/* Enable per-packet timestamping so the driver can order
+	 * received frames by arrival time across the two slave ports.
+	 */
+	icssm_prueth_lre_config_packet_timestamping(prueth);
+
 }
 
 void icssm_prueth_lre_cleanup(struct prueth *prueth)
-- 
2.43.0


