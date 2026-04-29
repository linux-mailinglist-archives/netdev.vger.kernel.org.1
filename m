Return-Path: <netdev+bounces-282261-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8E8SEmmv8WmwjgEAu9opvQ
	(envelope-from <netdev+bounces-282261-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:12:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB45490462
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B30D7302962A
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 07:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871D73A6400;
	Wed, 29 Apr 2026 07:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="AjqDxYYD"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96633A3813;
	Wed, 29 Apr 2026 07:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777446507; cv=none; b=Nq4TWXwNVVF8j2ss7bSGLyPEXU2XZqmnULCVRRQTSDL2TG1rS0Q6FidNFJ+9qDxdYOoDN0bIADoC+dn/mrN5IfcVvrBEd9ryJ+pEemjE6dNT4J0qj2RqVXNSwuk5Kc7YPUA6PcRQ+taZTQLMDrBFIbDmGjoJCzeRWzzAHaJx51E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777446507; c=relaxed/simple;
	bh=PhhG3xboY4WweNPbVKew/AzSxKxMqPT5olpTAdjaOIc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JnWV4fqL+L4vnP54cehzyu2mAnnvw2QGEpGhK8JuCtF/Q18bhh0XwivHS6z2CHv6UphP2vJIuYgSjqQe5H+OfjY5MSKvj0Gg8jNpASeGrF4ZTQhzha6jbcwAurfujUNN6Kxp9cly9osL1HPPmFMNfN+S2TjoohLbKgWFPYPTLLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=AjqDxYYD; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63T77rvdE1069969, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1777446474;
	bh=kJKigjRByzyJJ4ccimBjXfpcoza7N4/7c9sS3xDZlNs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=AjqDxYYDBau8u7JqMCoUFL0R5evUMXKvdsiqoUbwbbfaHVCTwdo7nC7zrg8pMa1XG
	 8drYDfpmnSwE2XK/LTyJD7JswPD64ni4u5N0VJT5AM2Yxut06Bqu6At19YjAT5JRZV
	 8U3hbe+NuRnTu0itnyA8eNHf5XpGI6wC0aNfNiQh+NW+HzFMgUuweyjWUzP6zY9aUR
	 7jjkNlsN0cT8odyrFdg3osYRY0rZ+Nr6p8fUVMCs7ypATiV/GtLJxJttuegfztzXw2
	 x1hg67kdGAYJ50jINYsd0heIDHTQj1u/hAyhHBmb8k8Acv8oXdcWMMIXEDo4BCp70D
	 2sVXBsvQZBGaQ==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 63T77rvdE1069969
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 29 Apr 2026 15:07:54 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 29 Apr 2026 15:07:54 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 29 Apr 2026 15:07:54 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [RFC Patch net-next v2 4/8] r8169: add support for new interrupt mapping
Date: Wed, 29 Apr 2026 15:07:46 +0800
Message-ID: <20260429070750.1477-5-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260429070750.1477-1-javen_xu@realsil.com.cn>
References: <20260429070750.1477-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: ECB45490462
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-282261-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realsil.com.cn:email,realsil.com.cn:dkim,realsil.com.cn:mid]

From: Javen Xu <javen_xu@realsil.com.cn>

To support RSS, the number of hardware interrupt bits should match the
interrupt of software. So we add support for new interrupt mapping here.
ISR_VER_MAP_REG is the hardware register to indicate interrupt status.
IMR_SET_VEC_MAP_REG is interrupt mask which is set to enable irq.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
changes in v2:
 - change some register name
---
 drivers/net/ethernet/realtek/r8169_main.c | 151 ++++++++++++++++++++--
 1 file changed, 141 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 5fd695ebe6bb..6ef4868edbc7 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -839,6 +839,7 @@ struct rtl8169_private {
 	u8 irq_nvecs;
 	u8 init_rx_desc_type;
 	u8 recheck_desc_ownbit;
+	unsigned int features;
 	int irq;
 	struct clk *clk;
 
@@ -1737,26 +1738,36 @@ static u32 rtl_get_events(struct rtl8169_private *tp)
 
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
@@ -5197,6 +5208,44 @@ static void rtl8169_free_irq(struct rtl8169_private *tp)
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
@@ -5207,6 +5256,10 @@ static int rtl8169_request_irq(struct rtl8169_private *tp)
 
 	for (int i = 0; i < tp->irq_nvecs; i++) {
 		irq = &tp->irq_tbl[i];
+		if (tp->features & RTL_VEC_MAP_ENABLE && tp->hw_curr_isr_ver > 1)
+			irq->handler = rtl8169_interrupt_msix;
+		else
+			irq->handler = rtl8169_interrupt;
 
 		napi = &tp->r8169napi[i];
 		snprintf(irq->name, len, "%s-%d", dev->name, i);
@@ -5664,10 +5717,17 @@ static const struct net_device_ops rtl_netdev_ops = {
 
 static void rtl_set_irq_mask(struct rtl8169_private *tp)
 {
-	tp->irq_mask = RxOK | RxErr | TxOK | TxErr | LinkChg;
+	if (tp->features & RTL_VEC_MAP_ENABLE) {
+		tp->irq_mask = ISRIMR_LINKCHG;
+		tp->irq_mask |= ISRIMR_TOK_Q0;
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
@@ -5695,6 +5755,16 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
 	if (nvecs < 0)
 		nvecs = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
 
+	tp->features &= ~RTL_VEC_MAP_ENABLE;
+
+	if (nvecs > 0) {
+		tp->irq_nvecs = nvecs;
+		tp->irq = pci_irq_vector(pdev, 0);
+		if (nvecs > 1)
+			tp->features |= RTL_VEC_MAP_ENABLE;
+		return 0;
+	}
+
 	tp->irq = pdev->irq;
 	tp->irq_nvecs = 1;
 
@@ -5965,6 +6035,53 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
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
@@ -5972,6 +6089,20 @@ static void r8169_init_napi(struct rtl8169_private *tp)
 		int (*poll)(struct napi_struct *napi, int budget);
 
 		poll = rtl8169_poll;
+		if (tp->features & RTL_VEC_MAP_ENABLE) {
+			switch (tp->hw_curr_isr_ver) {
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


