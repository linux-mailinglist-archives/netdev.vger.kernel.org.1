Return-Path: <netdev+bounces-295171-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0xLYKipUIWq/DgEAu9opvQ
	(envelope-from <netdev+bounces-295171-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:32:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C1063F0D3
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:32:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=wNYgxnpx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295171-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295171-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AAE43026760
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 10:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305D53C13F2;
	Thu,  4 Jun 2026 10:28:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3577B39DBF4;
	Thu,  4 Jun 2026 10:27:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780568884; cv=none; b=I123iN5iHl7MkzNptTUSMy2OLEUB988Use/TrZcqkKHBbbdQBXjyY90XcYv51n3d18TLHKumEH+Risbl0WizmsYvr6C0bICYJixudOep4PP8xaNGgpuYdHJaAFji1iGZEyOhsdHlERMC8dCq90RZ+9wFI7SL7Hb3VG0tBfi+/XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780568884; c=relaxed/simple;
	bh=hWZODWsGtE9uIRkUGN4Kd8ZMNw8mIfDLGoiBwwK1sIU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l7zGnOePib8aJyddlb92qsZdKPqw81dkPRWI05LY5X2kZFURcB12ndSP+PfivGWctHnEzhmmAvLKE9AmaRaonWZyPdBlq+YCbV9oGPiV1mos1iRbqprteGZSaapbKpfaEXD2zQKfhplKb6jGJ47eqDxdO1w3H/9cch1JBZSF1Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=wNYgxnpx; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 654ARZ640272242, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780568856;
	bh=lb/BojQYev+9ivHTYICaiCLDHbafQM1IXShmmZEMiDo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=wNYgxnpxKbn9JDrxaherzJxV+IyuhqCfyfP5er58zfe5Ci26TruxBRDWzDm1ArxkW
	 PDaHqPzQ8Pa6RLgpOsCHTGFeF14jZ1bzsWobSqsPXbXrriouWwhWYmC6VqxEhkG/GY
	 jDasTDO+5UKzDDZkYYgSKiPNvAZhpqtLcGh7fV7NHAPQeqvH6hQeqdMZP6eSH+MLl6
	 NMjixxkUWjPbsEpIadnJu9eJsLxTs74k60qK0Mpp4Nqf2DxUV95lp5/Zbv+cycLGMy
	 4Y99gwbBoBc35jEJTsqNlGFevqqk8J8eQDpB7gT7598LZS9HbdYLJGhU3TLTCY5qzF
	 iID6TpzspXoow==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 654ARZ640272242
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jun 2026 18:27:35 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Jun 2026 18:27:36 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 4 Jun 2026 18:27:35 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v7 3/7] r8169: add support for new interrupt mapping
Date: Thu, 4 Jun 2026 18:27:29 +0800
Message-ID: <20260604102733.1582-4-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260604102733.1582-1-javen_xu@realsil.com.cn>
References: <20260604102733.1582-1-javen_xu@realsil.com.cn>
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
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295171-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:javen_xu@realsil.com.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 09C1063F0D3

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
---
 drivers/net/ethernet/realtek/r8169_main.c | 173 +++++++++++++++++++---
 1 file changed, 154 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 6dae0d1bfe25..a416d482aa86 100644
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
@@ -4844,8 +4864,8 @@ static void rtl8169_pcierr_interrupt(struct net_device *dev)
 	rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
 }
 
-static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
-		   int budget)
+static int rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
+		  int budget)
 {
 	unsigned int dirty_tx, bytes_compl = 0, pkts_compl = 0;
 	struct sk_buff *skb;
@@ -4889,6 +4909,8 @@ static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
 		if (READ_ONCE(tp->cur_tx) != dirty_tx && skb)
 			rtl8169_doorbell(tp);
 	}
+
+	return pkts_compl;
 }
 
 static inline int rtl8169_fragmented_frame(u32 status)
@@ -5043,6 +5065,44 @@ static void rtl8169_free_irq(struct rtl8169_private *tp)
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
@@ -5051,8 +5111,12 @@ static int rtl8169_request_irq(struct rtl8169_private *tp)
 
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
@@ -5101,8 +5165,9 @@ static int rtl8169_poll(struct napi_struct *napi, int budget)
 	struct rtl8169_private *tp = netdev_priv(napi->dev);
 	struct net_device *dev = napi->dev;
 	int work_done = 0;
+	int tx_done;
 
-	rtl_tx(dev, tp, budget);
+	tx_done = rtl_tx(dev, tp, budget);
 
 	/* rtl8169_poll() is used only when there is a single RX ring. */
 	work_done = rtl_rx(dev, tp, &tp->rx_ring[0], budget, napi);
@@ -5511,10 +5576,16 @@ static const struct net_device_ops rtl_netdev_ops = {
 
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
@@ -5799,10 +5870,74 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
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
+	unsigned int work_done;
+
+	tp = netdev_priv(dev);
+
+	work_done = rtl_tx(dev, tp, budget);
+
+	if (napi_complete_done(napi, work_done))
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


