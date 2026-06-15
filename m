Return-Path: <netdev+bounces-299303-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JzEiIwFvL2qRAQUAu9opvQ
	(envelope-from <netdev+bounces-299303-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 05:18:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A40683013
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 05:18:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=k7QywA9h;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299303-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299303-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 655E13030B0D
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 03:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7021B299A84;
	Mon, 15 Jun 2026 03:14:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC15271A9A;
	Mon, 15 Jun 2026 03:14:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781493273; cv=none; b=eYeCZzGwCuKaFBuAXpPRLWmXaM4pX7gJNwq3rb3WpJuis3DkP1So8Vo4qRz5sdGj86LfsIarch53QU4J+QF29t17PQ3e7RT044yKSDWdDPFivpqzuZn4vnAjQmkhyLI+Heb+QUMQlMCn3EOKI7PT3RMZuComO4iae+ahXXNWuPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781493273; c=relaxed/simple;
	bh=peFBwj61oM/CWx3T57AX8NWYZTQrbrQfBZcEFV/yysY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DlD2DTefdst2yqKZ3tChCHuOm1d1/VQivnhmNREmxH4Yzmt5gB32WxEJlcx7zPEVYnqf0w2f6sXwINpjZ7A/3OLrk6HjkLDHFepWbLkjrIDOMKs32oTLVcOdwfpC7YwRFaecC+vj9dfCo9gm9i5/DBdonjFwcLoaeokzy4ONgEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=k7QywA9h; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65F3DnQxA457249, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1781493229;
	bh=XBZ+E5+NdECw14ckZFfmhUH6zOutd9EVUwlBSOSH/fM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=k7QywA9h4V8BpvyNLPPL6iwYCI0k8S7D4iB27SM+/vauklx7bJYgsidDBq8oTbxXy
	 P43GzDR6TNt7F7/PSBtWGTOxkeImGLEELlcbpGoneMTw84LBEKRU3WB2IcuXApqM0J
	 b4HDFjcxOZn+OQba2sYlizF80BQMwAY2GTbG3SFpYI/MwHair6GpukoRJtEXmDQ2nz
	 3QvPKHx2bh0PwoTPuHHvGQHxBKVT72NxGELknbCr/0ucOhKk5+Tg/2lmUc4Ae7W952
	 jPqBUVwGNDaBwAB4HZqaDY9RSyUVu0lHIjahr4hkBdShTubIbr7eIOQTiNoyRY4Au5
	 NMTKglBo3xwpQ==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65F3DnQxA457249
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Jun 2026 11:13:49 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Jun 2026 11:13:48 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 15 Jun 2026 11:13:48 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v8 3/7] r8169: add support for new interrupt mapping
Date: Mon, 15 Jun 2026 11:13:41 +0800
Message-ID: <20260615031345.548-4-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260615031345.548-1-javen_xu@realsil.com.cn>
References: <20260615031345.548-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-299303-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:javen_xu@realsil.com.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realsil.com.cn:dkim,realsil.com.cn:email,realsil.com.cn:mid,realsil.com.cn:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E7A40683013

From: Javen Xu <javen_xu@realsil.com.cn>

To support RSS, the number of hardware interrupt bits should match the
interrupt of software. So we add support for new interrupt mapping here.
ISR_VEC_MAP_REG is the hardware register to indicate interrupt status.
IMR_SET_VEC_MAP_REG is interrupt mask which is set to enable irq.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v2:
 - no changes

Changes in v3:
 - init index in napi_struct and get message_id from index
 - move rtl8169_disable_hw_interrupt_msix directly before the call to
   napi_schedule()
 - change the condition in rtl8169_request_irq when RTL_VEC_MAP_ENABLE
   enabled, use rtl8169_interrupt_msix

Changes in v4:
 - remove flag tp->feature, replace tp->features & RTL_VEC_MAP_ENABLE
   with tp->irq_nvecs > 1, they are equivalent.
 - follow reverse xmas tree, in rtl8169_interrupt_msix(),
   rtl8169_poll_msix_rx(), rtl8169_poll_msix_tx(),
   rtl8169_poll_msix_other()
 - use napi->index in rtl8169_poll_msix_other()
 - add a comment to describe RTL8127 MSI-X vector layout
 - simplify r8169_init_napi()

Changes in v5:
 - replace magic number in rtl8169_poll_msix_tx()

Changes in v6:
 - when irq_nvecs <= 1, use register IntrMask_8125, else using vec map
 - fix irq sequence in rtl8169_interrupt_msix(), disable interrupts
   before clean it
 - remove dead code in rtl8169_poll_msix_tx()

Changes in v7:
 - remove recheck_desc_ownbit
 - change return value of rtl_tx
 - remove message_id which only used once

Changes in v8:
 - fix rtl8169_netpoll()
 - remove tx_done
---
 drivers/net/ethernet/realtek/r8169_main.c | 173 +++++++++++++++++++---
 1 file changed, 154 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index f995a731116a..f90ea515da48 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -86,6 +86,7 @@
 #define R8169_TX_START_THRS	(2 * R8169_TX_STOP_THRS)
 #define R8169_MAX_RX_QUEUES	8
 #define R8127_MAX_RX_QUEUES	8
+#define R8127_MAX_TX_QUEUES	8
 #define R8169_DEFAULT_RX_QUEUES	1
 #define R8169_MAX_TX_QUEUES	1
 
@@ -456,8 +457,12 @@ enum rtl8125_registers {
 	RSS_CTRL_8125		= 0x4500,
 	Q_NUM_CTRL_8125		= 0x4800,
 	EEE_TXIDLE_TIMER_8125	= 0x6048,
+	IMR_CLEAR_VEC_MAP_REG	= 0x0d00,
+	ISR_VEC_MAP_REG		= 0x0d04,
+	IMR_SET_VEC_MAP_REG	= 0x0d0c,
 };
 
+#define MSIX_ID_VEC_MAP_LINKCHG	29
 #define LEDSEL_MASK_8125	0x23f
 
 #define RX_VLAN_INNER_8125	BIT(22)
@@ -588,6 +593,9 @@ enum rtl_register_content {
 
 	/* magic enable v2 */
 	MagicPacket_v2	= (1 << 16),	/* Wake up when receives a Magic Packet */
+#define	ISRIMR_LINKCHG	BIT(29)
+#define	ISRIMR_TOK_Q0	BIT(8)
+#define	ISRIMR_ROK_Q0	BIT(0)
 };
 
 enum rtl_desc_bit {
@@ -1670,26 +1678,38 @@ static u32 rtl_get_events(struct rtl8169_private *tp)
 
 static void rtl_ack_events(struct rtl8169_private *tp, u32 bits)
 {
-	if (rtl_is_8125(tp))
-		RTL_W32(tp, IntrStatus_8125, bits);
-	else
+	if (rtl_is_8125(tp)) {
+		if (tp->irq_nvecs > 1)
+			RTL_W32(tp, ISR_VEC_MAP_REG, bits);
+		else
+			RTL_W32(tp, IntrStatus_8125, bits);
+	} else {
 		RTL_W16(tp, IntrStatus, bits);
+	}
 }
 
 static void rtl_irq_disable(struct rtl8169_private *tp)
 {
-	if (rtl_is_8125(tp))
-		RTL_W32(tp, IntrMask_8125, 0);
-	else
+	if (rtl_is_8125(tp)) {
+		if (tp->irq_nvecs > 1)
+			RTL_W32(tp, IMR_CLEAR_VEC_MAP_REG, 0xffffffff);
+		else
+			RTL_W32(tp, IntrMask_8125, 0);
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
+		if (tp->irq_nvecs > 1)
+			RTL_W32(tp, IMR_SET_VEC_MAP_REG, tp->irq_mask);
+		else
+			RTL_W32(tp, IntrMask_8125, tp->irq_mask);
+	} else {
 		RTL_W16(tp, IntrMask, tp->irq_mask);
+	}
 }
 
 static void rtl8169_irq_mask_and_ack(struct rtl8169_private *tp)
@@ -4845,7 +4865,7 @@ static void rtl8169_pcierr_interrupt(struct net_device *dev)
 }
 
 static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
-		   int budget)
+		  int budget)
 {
 	unsigned int dirty_tx, bytes_compl = 0, pkts_compl = 0;
 	struct sk_buff *skb;
@@ -5043,6 +5063,44 @@ static void rtl8169_free_irq(struct rtl8169_private *tp)
 	}
 }
 
+static void rtl8169_disable_hw_interrupt_msix(struct rtl8169_private *tp, int message_id)
+{
+	RTL_W32(tp, IMR_CLEAR_VEC_MAP_REG, BIT(message_id));
+}
+
+static void rtl8169_clear_hw_isr(struct rtl8169_private *tp, int message_id)
+{
+	RTL_W32(tp, ISR_VEC_MAP_REG, BIT(message_id));
+}
+
+static void rtl8169_enable_hw_interrupt_msix(struct rtl8169_private *tp, int message_id)
+{
+	RTL_W32(tp, IMR_SET_VEC_MAP_REG, BIT(message_id));
+}
+
+static irqreturn_t rtl8169_interrupt_msix(int irq, void *dev_instance)
+{
+	struct napi_struct *napi = dev_instance;
+	struct net_device *dev = napi->dev;
+	int message_id = napi->index;
+	struct rtl8169_private *tp;
+
+	tp = netdev_priv(dev);
+
+	if (message_id == MSIX_ID_VEC_MAP_LINKCHG) {
+		rtl8169_clear_hw_isr(tp, message_id);
+		phy_mac_interrupt(tp->phydev);
+		return IRQ_HANDLED;
+	}
+
+	rtl8169_disable_hw_interrupt_msix(tp, message_id);
+	rtl8169_clear_hw_isr(tp, message_id);
+
+	napi_schedule(napi);
+
+	return IRQ_HANDLED;
+}
+
 static int rtl8169_request_irq(struct rtl8169_private *tp)
 {
 	struct net_device *dev = tp->dev;
@@ -5051,8 +5109,12 @@ static int rtl8169_request_irq(struct rtl8169_private *tp)
 
 	for (i = 0; i < tp->irq_nvecs; i++) {
 		napi = &tp->rtl8169_napi[i];
-		rc = pci_request_irq(tp->pci_dev, i, rtl8169_interrupt,
-				     NULL, napi, "%s-%d", dev->name, i);
+		if (tp->irq_nvecs > 1)
+			rc = pci_request_irq(tp->pci_dev, i, rtl8169_interrupt_msix,
+					     NULL, napi, "%s-%d", dev->name, i);
+		else
+			rc = pci_request_irq(tp->pci_dev, i, rtl8169_interrupt,
+					     NULL, napi, "%s-%d", dev->name, i);
 		if (rc)
 			goto free_irq;
 	}
@@ -5259,8 +5321,12 @@ static void rtl8169_netpoll(struct net_device *dev)
 	struct rtl8169_private *tp = netdev_priv(dev);
 
 	for (int i = 0; i < tp->irq_nvecs; i++) {
-		rtl8169_interrupt(pci_irq_vector(tp->pci_dev, i),
-				  &tp->rtl8169_napi[i]);
+		if (tp->irq_nvecs > 1)
+			rtl8169_interrupt_msix(pci_irq_vector(tp->pci_dev, i),
+					       &tp->rtl8169_napi[i]);
+		else
+			rtl8169_interrupt(pci_irq_vector(tp->pci_dev, i),
+					  &tp->rtl8169_napi[i]);
 	}
 }
 #endif
@@ -5511,10 +5577,16 @@ static const struct net_device_ops rtl_netdev_ops = {
 
 static void rtl_set_irq_mask(struct rtl8169_private *tp)
 {
-	tp->irq_mask = RxOK | RxErr | TxOK | TxErr | LinkChg;
+	if (tp->irq_nvecs > 1) {
+		tp->irq_mask = ISRIMR_LINKCHG | ISRIMR_TOK_Q0;
+		for (int i = 0; i < tp->num_rx_rings; i++)
+			tp->irq_mask |= ISRIMR_ROK_Q0 << i;
+	} else {
+		tp->irq_mask = RxOK | RxErr | TxOK | TxErr | LinkChg;
 
-	if (tp->mac_version <= RTL_GIGA_MAC_VER_06)
-		tp->irq_mask |= SYSErr | RxFIFOOver;
+		if (tp->mac_version <= RTL_GIGA_MAC_VER_06)
+			tp->irq_mask |= SYSErr | RxFIFOOver;
+	}
 }
 
 static int rtl_alloc_irq(struct rtl8169_private *tp)
@@ -5799,10 +5871,73 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
 	return false;
 }
 
+static int rtl8169_poll_msix_rx(struct napi_struct *napi, int budget)
+{
+	struct net_device *dev = napi->dev;
+	const int message_id = napi->index;
+	struct rtl8169_private *tp;
+	int work_done = 0;
+
+	tp = netdev_priv(dev);
+
+	if (message_id < tp->num_rx_rings)
+		work_done += rtl_rx(dev, tp, &tp->rx_ring[message_id], budget, napi);
+
+	if (work_done < budget && napi_complete_done(napi, work_done))
+		rtl8169_enable_hw_interrupt_msix(tp, message_id);
+
+	return work_done;
+}
+
+static int rtl8169_poll_msix_tx(struct napi_struct *napi, int budget)
+{
+	struct net_device *dev = napi->dev;
+	struct rtl8169_private *tp;
+
+	tp = netdev_priv(dev);
+
+	rtl_tx(dev, tp, budget);
+
+	if (napi_complete_done(napi, 0))
+		rtl8169_enable_hw_interrupt_msix(tp, napi->index);
+
+	return 0;
+}
+
+static int rtl8169_poll_msix_other(struct napi_struct *napi, int budget)
+{
+	struct net_device *dev = napi->dev;
+	struct rtl8169_private *tp;
+
+	tp = netdev_priv(dev);
+
+	if (napi_complete_done(napi, 0))
+		rtl8169_enable_hw_interrupt_msix(tp, napi->index);
+
+	return 0;
+}
+
+/* RTL8127 MSI-X vector layout:
+ * Vectors 0 .. (RxQs - 1)		: Rx Queues
+ * Vectors RxQs .. (RxQs + TxQs - 1)	: Tx Queues
+ * Vector (RxQs + TxQs) and up		: Other events (Link status(29), etc.)
+ */
 static void r8169_init_napi(struct rtl8169_private *tp)
 {
-	for (int i = 0; i < tp->irq_nvecs; i++)
-		netif_napi_add(tp->dev, &tp->rtl8169_napi[i], rtl8169_poll);
+	for (int i = 0; i < tp->irq_nvecs; i++) {
+		int (*poll_fn)(struct napi_struct *, int) = rtl8169_poll;
+
+		if (tp->irq_nvecs > 1) {
+			if (i < R8127_MAX_RX_QUEUES)
+				poll_fn = rtl8169_poll_msix_rx;
+			else if (i < R8127_MAX_RX_QUEUES + R8127_MAX_TX_QUEUES)
+				poll_fn = rtl8169_poll_msix_tx;
+			else
+				poll_fn = rtl8169_poll_msix_other;
+		}
+		netif_napi_add(tp->dev, &tp->rtl8169_napi[i], poll_fn);
+		tp->rtl8169_napi[i].index = i;
+	}
 }
 
 static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
-- 
2.43.0


