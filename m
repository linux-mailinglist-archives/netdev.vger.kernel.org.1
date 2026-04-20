Return-Path: <netdev+bounces-279623-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KH/N5KN5WnXlQEAu9opvQ
	(envelope-from <netdev+bounces-279623-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:21:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA4D426302
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 313A7301106B
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 02:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA36377EDD;
	Mon, 20 Apr 2026 02:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="T4gle/az"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCB9377561;
	Mon, 20 Apr 2026 02:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776651657; cv=none; b=tYtEDdQ2covPQdbTkdJ3GoIp+V3dcn14CvoyIE4zCmgvgp6ubx/HqsI/HIalkR30gWU49FkYbRtJlLqOsNbNOFQsiS6F3TmbWNrqE0auMcna+fSJfTVYOh+ZL2E9K/8MltE4gMmt4RYRNow/+DRA8nMG1OlkoOcHOt0a4sBo+LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776651657; c=relaxed/simple;
	bh=gTHAs4pKbt9xyqXnbYDq1GdK9P5lg9hXqOwZ3atefF4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b1ZI4nEe1r+9CGU69zY2hu0dg2zIwTNTNWFzjotU6HiVWqZUdd0l7hEDB2mCO46NNKZDqPy8jM1J19RJCKYusBCmGJtd2m6c389t97tyyr9cGcq1ZNRA3bmRFG+xifnR7CFPM7Qdk3K/3fK4yikOumXTShxtYK2RacO5nY0lGok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=T4gle/az; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63K2KEBn8277433, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1776651615;
	bh=bPzwPBKweEJb9wQqUsnydxqVHpbxWLM+b+Xf3VU5hRo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=T4gle/azB0OXq1ChJJgeqhQkpF1nvLJzpXSsr7ZlHxsMlPOV8O0LulgPTrUjaomB8
	 oTDxTRhshUCBxRJy0eBe/C/U0GGpI/yejiiZNGoR0LJMWO/IAHH/7rmgHP41YBlOQ2
	 8ZaToBUxxsxo7RymjZO4nRMzAISljhvQmXpJaWhG8270Ne54GnWKC/zrKvfIoVXHd8
	 tjb8XjMFfuxUW+YV7OL03TO495TYJWvMSUDnVBgUC/tVdVgTQEBpGVmfhy7fT9Sjk9
	 5K+2GU0uhvzR6V+5us2ej/4CoT00LKQZHxZ17fN54rYMHqumH/JnvsDHoptjrZEOTa
	 hgnxP1ZBVrt4Q==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63K2KEBn8277433
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 Apr 2026 10:20:14 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 20 Apr 2026 10:20:14 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Mon, 20 Apr 2026 10:20:14 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [RFC Patch net-next v1 5/9] r8169: add support for msix
Date: Mon, 20 Apr 2026 10:19:53 +0800
Message-ID: <20260420021957.1756-6-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260420021957.1756-1-javen_xu@realsil.com.cn>
References: <20260420021957.1756-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-279623-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6AA4D426302
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Javen Xu <javen_xu@realsil.com.cn>

This patch add support for msix. But we still use MSI here. And we force
nvecs to 1. We will modify it in rss patch.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/ethernet/realtek/r8169_main.c | 162 ++++++++++++++++++++--
 1 file changed, 151 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 52e690eba644..7d493342ab4b 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -1764,26 +1764,40 @@ static u32 rtl_get_events(struct rtl8169_private *tp)
 
 static void rtl_ack_events(struct rtl8169_private *tp, u32 bits)
 {
-	if (rtl_is_8125(tp))
+	if (rtl_is_8125(tp)) {
 		RTL_W32(tp, IntrStatus_8125, bits);
-	else
+		if (tp->features & RTL_FEATURE_MSIX) {
+			RTL_W32(tp, ISR_V2_8125, 0xffffffff);
+			RTL_W32(tp, ISR_V4_L2_8125, 0xffffffff);
+		}
+	} else {
 		RTL_W16(tp, IntrStatus, bits);
+	}
 }
 
 static void rtl_irq_disable(struct rtl8169_private *tp)
 {
-	if (rtl_is_8125(tp))
+	if (rtl_is_8125(tp)) {
 		RTL_W32(tp, IntrMask_8125, 0);
-	else
+		if (tp->features & RTL_FEATURE_MSIX) {
+			RTL_W32(tp, IMR_V2_CLEAR_REG_8125, 0xffffffff);
+			RTL_W32(tp, IMR_V4_L2_CLEAR_REG_8125, 0xffffffff);
+		}
+	} else {
 		RTL_W16(tp, IntrMask, 0);
+	}
 }
 
 static void rtl_irq_enable(struct rtl8169_private *tp)
 {
-	if (rtl_is_8125(tp))
-		RTL_W32(tp, IntrMask_8125, tp->irq_mask);
-	else
+	if (rtl_is_8125(tp)) {
+		if (tp->features & RTL_FEATURE_MSIX)
+			RTL_W32(tp, IMR_V2_SET_REG_8125, tp->irq_mask);
+		else
+			RTL_W32(tp, IntrMask_8125, tp->irq_mask);
+	} else {
 		RTL_W16(tp, IntrMask, tp->irq_mask);
+	}
 }
 
 static void rtl8169_irq_mask_and_ack(struct rtl8169_private *tp)
@@ -2894,6 +2908,10 @@ static void rtl_software_parameter_initialize(struct rtl8169_private *tp)
 	tp->InitRxDescType = RX_DESC_RING_TYPE_DEAFULT;
 	tp->HwCurrIsrVer = tp->HwSuppIsrVer;
 
+	/* This just force nvecs, and will be remove in the following patch*/
+	tp->min_irq_nvecs = 1;
+	tp->max_irq_nvecs = 1;
+
 	rtl_setup_mqs_reg(tp);
 	rtl_set_ring_size(tp, NUM_RX_DESC, NUM_TX_DESC);
 }
@@ -5321,6 +5339,44 @@ static void rtl8169_free_irq(struct rtl8169_private *tp)
 	}
 }
 
+static void rtl8169_disable_hw_interrupt_msix(struct rtl8169_private *tp, int message_id)
+{
+	RTL_W32(tp, IMR_V2_CLEAR_REG_8125, BIT(message_id));
+}
+
+static void rtl8169_clear_hw_isr(struct rtl8169_private *tp, int message_id)
+{
+	RTL_W32(tp, ISR_V2_8125, BIT(message_id));
+}
+
+static void rtl8169_enable_hw_interrupt_msix(struct rtl8169_private *tp, int message_id)
+{
+	RTL_W32(tp, IMR_V2_SET_REG_8125, BIT(message_id));
+}
+
+static irqreturn_t rtl8169_interrupt_msix(int irq, void *dev_instance)
+{
+	struct rtl8169_napi *napi = dev_instance;
+	struct rtl8169_private *tp = napi->priv;
+	int message_id = napi->index;
+
+	rtl8169_disable_hw_interrupt_msix(tp, message_id);
+
+	rtl8169_clear_hw_isr(tp, message_id);
+
+	if (message_id == MSIX_ID_V4_LINKCHG) {
+		phy_mac_interrupt(tp->phydev);
+		rtl8169_enable_hw_interrupt_msix(tp, message_id);
+		return IRQ_HANDLED;
+	}
+
+	tp->recheck_desc_ownbit = true;
+
+	napi_schedule(&napi->napi);
+
+	return IRQ_HANDLED;
+}
+
 static int rtl8169_request_irq(struct rtl8169_private *tp)
 {
 	struct net_device *dev = tp->dev;
@@ -5331,10 +5387,14 @@ static int rtl8169_request_irq(struct rtl8169_private *tp)
 
 	for (int i = 0; i < tp->irq_nvecs; i++) {
 		irq = &tp->irq_tbl[i];
+		if (tp->features & RTL_FEATURE_MSIX && tp->HwCurrIsrVer > 1)
+			irq->handler = rtl8169_interrupt_msix;
+		else
+			irq->handler = rtl8169_interrupt;
 
 		napi = &tp->r8169napi[i];
 		snprintf(irq->name, len, "%s-%d", dev->name, i);
-		rc = pci_request_irq(tp->pci_dev, i, rtl8169_interrupt, NULL, napi, irq->name);
+		rc = pci_request_irq(tp->pci_dev, i, irq->handler, NULL, napi, irq->name);
 
 		if (rc)
 			break;
@@ -5786,10 +5846,18 @@ static const struct net_device_ops rtl_netdev_ops = {
 
 static void rtl_set_irq_mask(struct rtl8169_private *tp)
 {
-	tp->irq_mask = RxOK | RxErr | TxOK | TxErr | LinkChg;
+	if (tp->features & RTL_FEATURE_MSIX) {
+		tp->irq_mask = ISRIMR_V6_LINKCHG;
+		for (int i = 0; i < tp->num_tx_rings; i++)
+			tp->irq_mask |= ISRIMR_V6_TOK_Q0 << i;
+		for (int i = 0; i < tp->num_rx_rings; i++)
+			tp->irq_mask |= ISRIMR_V6_ROK_Q0 << i;
+	} else {
+		tp->irq_mask = RxOK | RxErr | TxOK | TxErr | LinkChg;
 
-	if (tp->mac_version <= RTL_GIGA_MAC_VER_06)
-		tp->irq_mask |= SYSErr | RxFIFOOver;
+		if (tp->mac_version <= RTL_GIGA_MAC_VER_06)
+			tp->irq_mask |= SYSErr | RxFIFOOver;
+	}
 }
 
 static int rtl_alloc_irq(struct rtl8169_private *tp)
@@ -5817,6 +5885,18 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
 	if (nvecs < 0)
 		nvecs = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
 
+	tp->features &= ~(RTL_FEATURE_MSIX | RTL_FEATURE_MSI);
+
+	if (nvecs > 0) {
+		tp->irq_nvecs = nvecs;
+		tp->irq = pci_irq_vector(pdev, 0);
+		if (nvecs > 1)
+			tp->features |= RTL_FEATURE_MSIX;
+		else if (pci_dev_msi_enabled(pdev))
+			tp->features |= RTL_FEATURE_MSI;
+		return 0;
+	}
+
 	tp->irq = pdev->irq;
 	tp->irq_nvecs = 1;
 
@@ -6087,6 +6167,52 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
 	return false;
 }
 
+static int rtl8169_poll_msix_rx(struct napi_struct *napi, int budget)
+{
+	struct rtl8169_napi *r8169_napi = container_of(napi, struct rtl8169_napi, napi);
+	struct rtl8169_private *tp = r8169_napi->priv;
+	struct net_device *dev = tp->dev;
+	const int message_id = r8169_napi->index;
+	int work_done = 0;
+
+	if (message_id < tp->num_rx_rings)
+		work_done += rtl_rx(dev, tp, &tp->rx_ring[message_id], budget);
+
+	if (work_done < budget && napi_complete_done(napi, work_done))
+		rtl8169_enable_hw_interrupt_msix(tp, message_id);
+
+	return work_done;
+}
+
+static int rtl8169_poll_msix_tx(struct napi_struct *napi, int budget)
+{
+	struct rtl8169_napi *r8169_napi = container_of(napi, struct rtl8169_napi, napi);
+	struct rtl8169_private *tp = r8169_napi->priv;
+	struct net_device *dev = tp->dev;
+	unsigned int work_done = 0;
+	const int message_id = r8169_napi->index;
+	int tx_ring_idx = message_id - 8;
+
+	if (tx_ring_idx >= 0 && tx_ring_idx < tp->num_tx_rings)
+		work_done += rtl_tx(dev, tp, &tp->tx_ring[tx_ring_idx], budget);
+
+	if (work_done < budget && napi_complete_done(napi, work_done))
+		rtl8169_enable_hw_interrupt_msix(tp, message_id);
+
+	return work_done;
+}
+
+static int rtl8169_poll_msix_other(struct napi_struct *napi, int budget)
+{
+	struct rtl8169_napi *r8169_napi = container_of(napi, struct rtl8169_napi, napi);
+	struct rtl8169_private *tp = r8169_napi->priv;
+	const int message_id = r8169_napi->index;
+
+	napi_complete_done(napi, budget);
+	rtl8169_enable_hw_interrupt_msix(tp, message_id);
+
+	return 1;
+}
 
 static void r8169_init_napi(struct rtl8169_private *tp)
 {
@@ -6095,6 +6221,20 @@ static void r8169_init_napi(struct rtl8169_private *tp)
 		int (*poll)(struct napi_struct *napi, int budget);
 
 		poll = rtl8169_poll;
+		if (tp->features & RTL_FEATURE_MSIX) {
+			switch (tp->HwCurrIsrVer) {
+			case 6:
+				if (i < R8127_MAX_RX_QUEUES)
+					poll = rtl8169_poll_msix_rx;
+				else if (i > 7 && i < 16)
+					poll = rtl8169_poll_msix_tx;
+				else
+					poll = rtl8169_poll_msix_other;
+				break;
+			default:
+				break;
+			}
+		}
 		netif_napi_add(tp->dev, &r8169napi->napi, poll);
 		r8169napi->priv = tp;
 		r8169napi->index = i;
-- 
2.43.0


