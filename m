Return-Path: <netdev+bounces-269955-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEh3KHljvWlF9gIAu9opvQ
	(envelope-from <netdev+bounces-269955-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:10:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F38402DC609
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47F7431B2EC0
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7EB3C73D4;
	Fri, 20 Mar 2026 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="SJ6rDrKI"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B62E284896;
	Fri, 20 Mar 2026 15:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018929; cv=none; b=pBF0ZQhNgGpGivjXZn/eS4hUfyCUc4bd4eTeVBJO/HlzUHx8Pgh0zyPaisX7NMNz/euBbMi4V1gP22KZPhGt9BjHAo58+d9YfU3uugqDi/+Oj53AJvxY7c+WwIXG51GE+vKMfRzFv4y56KWkDe6eAz2poBEOHt6M/ry1Z+SMaws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018929; c=relaxed/simple;
	bh=VzjGWhiaPNnWon+1/99Svd94I5NW04IGjn7Y8TdHR/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=dQHu2ngnm3jVeUKZ0/VR51EFi0wBf4dBTmrDjFHwXpFZPofkthA3Zr1IQ3YA79wjuPCd2ikl7EHDtRDEc4jXqT16KIkTRWEGhw4UwZO56OLKlUDja9FctcXs9QxaDCtmHr88a/LjoQV7BhUG8ln62qjpqu5KkXhvjS0AGwe0Jio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=SJ6rDrKI; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1774018928; x=1805554928;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=VzjGWhiaPNnWon+1/99Svd94I5NW04IGjn7Y8TdHR/w=;
  b=SJ6rDrKIOycSHc1s8HRtbC/pFbJ7xF0XhrxQmvH/WQ7UDvY6mJ6OzFak
   hVM6pBHItwjC0K8oqhpkYSbk5rYvxI1O4KUzS2Hvy4jnpOqNM+6gjTeKe
   A912rNyA89p/2qgPX9tQ6IgDo5G7QcPv40m05Ff+kWm63KXrD/HpINyzp
   VUalO/JyQpTPBtf2ld2lZGiadIztPB6Ps4/Zg67s6T2z0JrEAQhj6yMJq
   Uyw1GiKf9WtFrEEdmIDOaNyo7o/zgApzHh/jDlby1Cg42m1taeYX1pMbN
   Rtk665Pi4HnNxnTA5OvqAqWTqNgag9abgjh1pv76GSFTcTtDf73BPkCXx
   g==;
X-CSE-ConnectionGUID: PI7UURBMS4qqPJi2jv9mYA==
X-CSE-MsgGUID: 11mOGhwNS62ggmh4Ro/UyQ==
X-IronPort-AV: E=Sophos;i="6.23,130,1770620400"; 
   d="scan'208";a="62637212"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 08:02:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Fri, 20 Mar 2026 08:01:33 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 20 Mar 2026 08:01:30 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 20 Mar 2026 16:01:01 +0100
Subject: [PATCH net-next 05/10] net: lan966x: add FDMA ops dispatch for
 PCIe support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260320-lan966x-pci-fdma-v1-5-ef54cb9b0c4b@microchip.com>
References: <20260320-lan966x-pci-fdma-v1-0-ef54cb9b0c4b@microchip.com>
In-Reply-To: <20260320-lan966x-pci-fdma-v1-0-ef54cb9b0c4b@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Steen Hegelund
	<steen.hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Herve
 Codina <herve.codina@bootlin.com>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269955-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,iogearbox.net,gmail.com,fomichev.me,bootlin.com,arndb.de,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:dkim,microchip.com:email,microchip.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F38402DC609
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 870f7d00d325..be6e4044d6f5 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -906,7 +906,7 @@ void lan966x_fdma_netdev_init(struct lan966x *lan966x, struct net_device *dev)
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
index a1f590f81cbb..ed2707079d3e 100644
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


