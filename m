Return-Path: <netdev+bounces-284742-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFW6Hlf4+mmlUwMAu9opvQ
	(envelope-from <netdev+bounces-284742-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 10:14:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DB04D7B7C
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 10:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DBEE300B9DD
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 08:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E993E3C5D;
	Wed,  6 May 2026 08:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="adILIxfU"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC0B3E3151;
	Wed,  6 May 2026 08:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778055247; cv=none; b=iJJ9OubZPNu8x0kve3AYk67CSLUBdcohMzTGkOFm3WP1KFlDmdoSiWNmqK52D5/eoYWqrk8ow6DYXbNcTD2SrVzwcO7Vmexm2yrL7JUKa0x5dY6MC8CASa/SpLOUD74sgoSRDTHhKLZQmEdUx4H5Z3ah/CBgJBJ4fNnatbM/Kho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778055247; c=relaxed/simple;
	bh=ymomAc0+lIrMy6WL0B7QPUjaKZstaEj2waHDJUFuPg4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HtaWxsIdFA45H8wvwciS6VViu4lIg5dhQWAIZeGXJAxRRZNsIWo3U/14LJxbI3OvKWpLY1wYrSnMDUw0nQ0ShPiFE++4SRUAybH53mRnsP6rsZ068rzZtecDnbP3S5Yy+gOMNxi62G4B8I+W8BC4Z4nTWGXrEPgq1MllF3NJmj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=adILIxfU; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6468DUnqC1854043, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1778055210;
	bh=KvYW5SdMT4v8Koq00qERo5xMGdML7qHbkiyVwTWTok4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=adILIxfULtSGsomnhtMehviZr8lwPZfm92MUtg1LejeWkvAfVUxelZVNTKxhu7MfR
	 LyyZkW4yjalKFPwIwCjTnF/U1kWncKlBxaLSj3coHTvh+7YclOuTQKG+TOq2tfGTdM
	 Za6xDnToTy62A60HH49uduUjKIrmJoxyhuPFch4xyKR+LQbaz5F/KcyJ8jD/pgw77C
	 aF9stNgzmpGlKqJDD6XbNMk82RiHEFyztWMl0YRo+aO+/us7uyE1AOt9ciTBBop4mZ
	 DhKx4IDEDKK1TSWN71sAIuStumXCYOdF7quV8U/FlnnkOcEFeeIHDwMdvaErfgg8UJ
	 n+Gfyj2HXfCqg==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 6468DUnqC1854043
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 6 May 2026 16:13:30 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 6 May 2026 16:13:29 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 6 May 2026 16:13:29 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [Patch net-next v1 3/7] r8169: add support for new interrupt mapping
Date: Wed, 6 May 2026 16:13:21 +0800
Message-ID: <20260506081326.767-4-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260506081326.767-1-javen_xu@realsil.com.cn>
References: <20260506081326.767-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 23DB04D7B7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-284742-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Javen Xu <javen_xu@realsil.com.cn>

To support RSS, the number of hardware interrupt bits should match the
interrupt of software. So we add support for new interrupt mapping here.
ISR_VER_MAP_REG is the hardware register to indicate interrupt status.
IMR_SET_VEC_MAP_REG is interrupt mask which is set to enable irq.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/ethernet/realtek/r8169_main.c | 155 ++++++++++++++++++++--
 1 file changed, 145 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index bc75dbb9901d..671f82c326d9 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -77,6 +77,7 @@
 #define R8169_TX_STOP_THRS	(MAX_SKB_FRAGS + 1)
 #define R8169_TX_START_THRS	(2 * R8169_TX_STOP_THRS)
 #define R8169_MAX_RX_QUEUES	8
+#define R8127_MAX_TX_QUEUES	8
 #define R8169_MAX_MSIX_VEC	32
 #define R8127_MAX_RX_QUEUES	8
 
@@ -449,8 +450,14 @@ enum rtl8125_registers {
 	Q_NUM_CTRL_8125		= 0x4800,
 	EEE_TXIDLE_TIMER_8125	= 0x6048,
 	RDSAR_Q1_LOW		= 0x4000,
+	IMR_SET_VEC_MAP_REG	= 0x0d0c,
+	IMR_CLEAR_VEC_MAP_REG	= 0x0d00,
+	ISR_VEC_MAP_REG		= 0x0d04,
 };
 
+#define MSIX_ID_VEC_MAP_LINKCHG		29
+#define RTL_VEC_MAP_ENABLE		BIT(0)
+
 #define LEDSEL_MASK_8125	0x23f
 
 #define RX_VLAN_INNER_8125	BIT(22)
@@ -581,6 +588,9 @@ enum rtl_register_content {
 
 	/* magic enable v2 */
 	MagicPacket_v2	= (1 << 16),	/* Wake up when receives a Magic Packet */
+#define	ISRIMR_LINKCHG	BIT(29)
+#define	ISRIMR_TOK_Q0	BIT(8)
+#define	ISRIMR_ROK_Q0	BIT(0)
 };
 
 enum rtl_desc_bit {
@@ -796,6 +806,7 @@ struct rtl8169_private {
 	u8 irq_nvecs;
 	u8 init_rx_desc_type;
 	u8 recheck_desc_ownbit;
+	unsigned int features;
 	int irq;
 	struct clk *clk;
 
@@ -1694,26 +1705,36 @@ static u32 rtl_get_events(struct rtl8169_private *tp)
 
 static void rtl_ack_events(struct rtl8169_private *tp, u32 bits)
 {
-	if (rtl_is_8125(tp))
+	if (rtl_is_8125(tp)) {
 		RTL_W32(tp, IntrStatus_8125, bits);
-	else
+		if (tp->features & RTL_VEC_MAP_ENABLE)
+			RTL_W32(tp, ISR_VEC_MAP_REG, 0xffffffff);
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
+		if (tp->features & RTL_VEC_MAP_ENABLE)
+			RTL_W32(tp, IMR_CLEAR_VEC_MAP_REG, 0xffffffff);
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
+		if (tp->features & RTL_VEC_MAP_ENABLE)
+			RTL_W32(tp, IMR_SET_VEC_MAP_REG, tp->irq_mask);
+		else
+			RTL_W32(tp, IntrMask_8125, tp->irq_mask);
+	} else {
 		RTL_W16(tp, IntrMask, tp->irq_mask);
+	}
 }
 
 static void rtl8169_irq_mask_and_ack(struct rtl8169_private *tp)
@@ -5154,6 +5175,44 @@ static void rtl8169_free_irq(struct rtl8169_private *tp)
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
+	struct rtl8169_napi *napi = dev_instance;
+	struct rtl8169_private *tp = napi->priv;
+	int message_id = napi->index;
+
+	rtl8169_disable_hw_interrupt_msix(tp, message_id);
+
+	rtl8169_clear_hw_isr(tp, message_id);
+
+	if (message_id == MSIX_ID_VEC_MAP_LINKCHG) {
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
 	const int len = sizeof(tp->irq_tbl[0].name);
@@ -5164,6 +5223,10 @@ static int rtl8169_request_irq(struct rtl8169_private *tp)
 
 	for (int i = 0; i < tp->irq_nvecs; i++) {
 		irq = &tp->irq_tbl[i];
+		if (tp->features & RTL_VEC_MAP_ENABLE && tp->hw_curr_isr_ver > 1)
+			irq->handler = rtl8169_interrupt_msix;
+		else
+			irq->handler = rtl8169_interrupt;
 
 		napi = &tp->r8169napi[i];
 		snprintf(irq->name, len, "%s-%d", dev->name, i);
@@ -5622,10 +5685,16 @@ static const struct net_device_ops rtl_netdev_ops = {
 
 static void rtl_set_irq_mask(struct rtl8169_private *tp)
 {
-	tp->irq_mask = RxOK | RxErr | TxOK | TxErr | LinkChg;
+	if (tp->features & RTL_VEC_MAP_ENABLE) {
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
@@ -5659,6 +5728,9 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
 	tp->irq = pci_irq_vector(pdev, 0);
 	tp->irq_nvecs = nvecs;
 
+	if (nvecs > 1)
+		tp->features |= RTL_VEC_MAP_ENABLE;
+
 	return 0;
 }
 
@@ -5925,6 +5997,53 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
 	return false;
 }
 
+static int rtl8169_poll_msix_rx(struct napi_struct *napi, int budget)
+{
+	struct rtl8169_napi *r8169_napi = container_of(napi, struct rtl8169_napi, napi);
+	struct rtl8169_private *tp = r8169_napi->priv;
+	const int message_id = r8169_napi->index;
+	struct net_device *dev = tp->dev;
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
+	const int message_id = r8169_napi->index;
+	int tx_ring_idx = message_id - 8;
+	struct net_device *dev = tp->dev;
+	unsigned int work_done = 0;
+
+	if (tx_ring_idx >= 0)
+		rtl_tx(dev, tp, budget);
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
+
 static void r8169_init_napi(struct rtl8169_private *tp)
 {
 	for (int i = 0; i < tp->irq_nvecs; i++) {
@@ -5932,6 +6051,22 @@ static void r8169_init_napi(struct rtl8169_private *tp)
 		int (*poll)(struct napi_struct *napi, int budget);
 
 		poll = rtl8169_poll;
+		if (tp->features & RTL_VEC_MAP_ENABLE) {
+			switch (tp->hw_curr_isr_ver) {
+			case 6:
+				if (i < R8127_MAX_RX_QUEUES)
+					poll = rtl8169_poll_msix_rx;
+				else if (i >= R8127_MAX_RX_QUEUES &&
+					 i < (R8127_MAX_RX_QUEUES +
+					 R8127_MAX_TX_QUEUES))
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


