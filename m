Return-Path: <netdev+bounces-281860-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yC8mGae28GlwXgEAu9opvQ
	(envelope-from <netdev+bounces-281860-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:31:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 640D7485DFD
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EAE031B1CFD
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3562B43DA26;
	Tue, 28 Apr 2026 13:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="W2cNd3Kb"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C276A413239;
	Tue, 28 Apr 2026 13:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777381656; cv=none; b=CCVHvGZZHx7M2HsK8aV0GD/QDB1CICscu0i1rEdXfkGLqFLStEe9rBQBaQ8g61zFON80UttUR/5TGLcFQ2xCe9PQarwn72ea0PXJWvACFqVmVI6W4ZlBMi35ER+OiaBhQK6SMwquakctRmgbvYht/YKQwRRC22PS+QemSKIrgWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777381656; c=relaxed/simple;
	bh=jSPQheeVC+xCyXe5JoeqqxEepu9MqF2RCjr4H03z5D8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Tk4n+I7+350lOicBxnvDi1N9QkH1SBOsuvzpms7Kw5zAGGYihn/ZFGX7qacCZS6+aMF1Se271h9nGftAnEo8GNxq1QyIXfuZsdfTAJpCCyb+N2mjefnrMXUSfqgzMFLmiJ/E6xBLEJ3FIhaKrnzc2jFc7PXdBJ0TJ7uiEidr/nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=W2cNd3Kb; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1777381655; x=1808917655;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=jSPQheeVC+xCyXe5JoeqqxEepu9MqF2RCjr4H03z5D8=;
  b=W2cNd3KbqhOnUSfFDQzojG99+6/KzX4fb0Sz8DbekerHSFok3estOxxt
   bLSTpxZ7CKRdEx3F5BL9bipv+Aun8qw894kqzj8SEUgiiTIIFYktF1I8y
   eLi4/1CpROmkO80J51POrjIx4Y33djVlFq9BEhJiRzc0WZTnot1iDeOqk
   Wt7Q3PSaclLb+10SjC/MzrrZGf0uQ4oScVtxxz5MwHFuaTrH5L6N6XPJk
   kRKQpZHTqqn2ZplpTaaMF2j+hCR1Db8yd7WtBiYvKudzRkhaJ0c0s89sB
   c0fM39WBTma/Ldd8UFLIpe0BZVA0prNJXxAxRfIgKKUvEIZ+sMA3XBvbp
   w==;
X-CSE-ConnectionGUID: MLg4YBcZTRKcCl4AJSUD3w==
X-CSE-MsgGUID: uFx4MTTqRAW9QKh/EtxDtw==
X-IronPort-AV: E=Sophos;i="6.23,204,1770620400"; 
   d="scan'208";a="56719862"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Apr 2026 06:07:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 28 Apr 2026 06:07:32 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 28 Apr 2026 06:07:28 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Tue, 28 Apr 2026 15:06:55 +0200
Subject: [PATCH net-next v2 06/13] net: lan966x: add FDMA ops dispatch for
 PCIe support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260428-lan966x-pci-fdma-v2-6-d3ec66e06202@microchip.com>
References: <20260428-lan966x-pci-fdma-v2-0-d3ec66e06202@microchip.com>
In-Reply-To: <20260428-lan966x-pci-fdma-v2-0-d3ec66e06202@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Steen Hegelund
	<steen.hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Herve
 Codina <herve.codina@bootlin.com>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Mohsin Bashir
	<mohsin.bashr@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 640D7485DFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281860-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,iogearbox.net,gmail.com,fomichev.me,bootlin.com,arndb.de,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:email,microchip.com:dkim,microchip.com:mid]

Introduce lan966x_fdma_ops to support different FDMA implementations
for platform and PCIe. Plumb fdma_init, fdma_deinit, fdma_xmit,
fdma_poll and fdma_resize through the ops table, and select the
implementation at probe time based on runtime PCI bus detection.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../net/ethernet/microchip/lan966x/lan966x_fdma.c  |  2 +-
 .../net/ethernet/microchip/lan966x/lan966x_main.c  | 25 +++++++++++++++++-----
 .../net/ethernet/microchip/lan966x/lan966x_main.h  | 13 +++++++++++
 3 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index 25e673bdf084..9bb40383aa56 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -925,7 +925,7 @@ void lan966x_fdma_netdev_init(struct lan966x *lan966x, struct net_device *dev)
 		return;
 
 	lan966x->fdma_ndev = dev;
-	netif_napi_add(dev, &lan966x->napi, lan966x_fdma_napi_poll);
+	netif_napi_add(dev, &lan966x->napi, lan966x->ops->fdma_poll);
 	napi_enable(&lan966x->napi);
 }
 
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 47752d3fde0b..9f69634ebb0a 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -26,6 +26,14 @@
 
 #define IO_RANGES 2
 
+static const struct lan966x_fdma_ops lan966x_fdma_ops = {
+	.fdma_init = &lan966x_fdma_init,
+	.fdma_deinit = &lan966x_fdma_deinit,
+	.fdma_xmit = &lan966x_fdma_xmit,
+	.fdma_poll = &lan966x_fdma_napi_poll,
+	.fdma_resize = &lan966x_fdma_change_mtu,
+};
+
 static const struct of_device_id lan966x_match[] = {
 	{ .compatible = "microchip,lan966x-switch" },
 	{ }
@@ -391,7 +399,7 @@ static netdev_tx_t lan966x_port_xmit(struct sk_buff *skb,
 
 	spin_lock(&lan966x->tx_lock);
 	if (port->lan966x->fdma)
-		err = lan966x_fdma_xmit(skb, ifh, dev);
+		err = lan966x->ops->fdma_xmit(skb, ifh, dev);
 	else
 		err = lan966x_port_ifh_xmit(skb, ifh, dev);
 	spin_unlock(&lan966x->tx_lock);
@@ -413,7 +421,7 @@ static int lan966x_port_change_mtu(struct net_device *dev, int new_mtu)
 	if (!lan966x->fdma)
 		return 0;
 
-	err = lan966x_fdma_change_mtu(lan966x);
+	err = lan966x->ops->fdma_resize(lan966x);
 	if (err) {
 		lan_wr(DEV_MAC_MAXLEN_CFG_MAX_LEN_SET(LAN966X_HW_MTU(old_mtu)),
 		       lan966x, DEV_MAC_MAXLEN_CFG(port->chip_port));
@@ -1079,6 +1087,11 @@ static int lan966x_reset_switch(struct lan966x *lan966x)
 	return 0;
 }
 
+static const struct lan966x_fdma_ops *lan966x_get_fdma_ops(struct device *dev)
+{
+	return &lan966x_fdma_ops;
+}
+
 static int lan966x_probe(struct platform_device *pdev)
 {
 	struct fwnode_handle *ports, *portnp;
@@ -1093,6 +1106,8 @@ static int lan966x_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, lan966x);
 	lan966x->dev = &pdev->dev;
 
+	lan966x->ops = lan966x_get_fdma_ops(&pdev->dev);
+
 	if (!device_get_mac_address(&pdev->dev, mac_addr)) {
 		ether_addr_copy(lan966x->base_mac, mac_addr);
 	} else {
@@ -1232,7 +1247,7 @@ static int lan966x_probe(struct platform_device *pdev)
 	if (err)
 		goto cleanup_fdb;
 
-	err = lan966x_fdma_init(lan966x);
+	err = lan966x->ops->fdma_init(lan966x);
 	if (err)
 		goto cleanup_ptp;
 
@@ -1245,7 +1260,7 @@ static int lan966x_probe(struct platform_device *pdev)
 	return 0;
 
 cleanup_fdma:
-	lan966x_fdma_deinit(lan966x);
+	lan966x->ops->fdma_deinit(lan966x);
 
 cleanup_ptp:
 	lan966x_ptp_deinit(lan966x);
@@ -1273,7 +1288,7 @@ static void lan966x_remove(struct platform_device *pdev)
 
 	lan966x_taprio_deinit(lan966x);
 	lan966x_vcap_deinit(lan966x);
-	lan966x_fdma_deinit(lan966x);
+	lan966x->ops->fdma_deinit(lan966x);
 	lan966x_cleanup_ports(lan966x);
 
 	cancel_delayed_work_sync(&lan966x->stats_work);
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
index 83c361abb789..5f4dbeda17cd 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
@@ -193,6 +193,17 @@ enum vcap_is1_port_sel_rt {
 	VCAP_IS1_PS_RT_FOLLOW_OTHER = 7,
 };
 
+struct lan966x;
+
+struct lan966x_fdma_ops {
+	int (*fdma_init)(struct lan966x *lan966x);
+	void (*fdma_deinit)(struct lan966x *lan966x);
+	int (*fdma_xmit)(struct sk_buff *skb, __be32 *ifh,
+			 struct net_device *dev);
+	int (*fdma_poll)(struct napi_struct *napi, int weight);
+	int (*fdma_resize)(struct lan966x *lan966x);
+};
+
 struct lan966x_port;
 
 struct lan966x_rx {
@@ -270,6 +281,8 @@ struct lan966x_skb_cb {
 struct lan966x {
 	struct device *dev;
 
+	const struct lan966x_fdma_ops *ops;
+
 	u8 num_phys_ports;
 	struct lan966x_port **ports;
 

-- 
2.34.1


