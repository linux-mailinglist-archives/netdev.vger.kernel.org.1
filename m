Return-Path: <netdev+bounces-282255-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id d4JeOtWu8Wn8jgEAu9opvQ
	(envelope-from <netdev+bounces-282255-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:10:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC774903F8
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 70E33300EB70
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 07:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEED03A3828;
	Wed, 29 Apr 2026 07:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="XsDsg5wj"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77B83A3802;
	Wed, 29 Apr 2026 07:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777446504; cv=none; b=T2tuPnOXlb8dMOHCZdR91OtX97pkPK162L9OJrpokygJ+TQ5Aj3ondK7kGvhbvTspizWA04r7/0LD3jdajZHGvdUye0a0zh8oe1dz9EVN5KfSHXDN+xrqpmtmwjYiyuk+J+OwZlON22Z0wusMgtGl/ZhvUic47a1eSPMvjeR1hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777446504; c=relaxed/simple;
	bh=FmxXZLfCvOFJ9MkGfIEW+3S0ndqI8De+aFZxPGhYpbU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L8GI9wZ+5vnrLx0ZJ+VO96c0Vy9BSzLAsTDDsRnd1YrHa0Ls7h5BkXuU/Vr1s6mfXbgfl3FacpSW/v5jjLvqGTnS2beqWaP+9noG0w1WPM4/r47Swfr67kLNGN9zBmzc6yn0ut5Rsr7jk+EHOmpREX39UqWX+9/gNEZg9Q+dWOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=XsDsg5wj; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63T77rvbE1069969, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1777446473;
	bh=mLIIxCag0Fw3GaQicy92y5fyxxFvAk81yJrMBLkSTlM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=XsDsg5wjJGYRnWj+F1QNsO57ZSCwmKeo080z0chjSDS4KxM8zewi0uF4N8FlxrZRf
	 HJ8ByHBNNGevEWIWa9JbHVx1XCTEFpv1k4mz99DQfdPpt1fQWUrLqbweL2UE/oPRa5
	 7XZVetw4SkS5xD50fUG1j/F6v4YPn3+GlkG3AMt3iV9X5u/Ko9XMCKZlTaMH+fYCEb
	 xyUSJAspSajpiv9nHA3sCvxQPbohlQEI7a2fqb6w3W3yxdwOa5/N/r8NnR4zQlDKgK
	 bdJ0QfmsiMZfV1/bcJUDfVqE8qUNfi0YFPhRunMZLq4xKosZx5Z/GE/m0KlP1rqfS8
	 H132a/rRTsPBQ==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 63T77rvbE1069969
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 29 Apr 2026 15:07:53 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 29 Apr 2026 15:07:53 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 29 Apr 2026 15:07:53 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [RFC Patch net-next v2 2/8] r8169: add support for multi irqs
Date: Wed, 29 Apr 2026 15:07:44 +0800
Message-ID: <20260429070750.1477-3-javen_xu@realsil.com.cn>
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
X-Rspamd-Queue-Id: DAC774903F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-282255-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,realsil.com.cn:email,realsil.com.cn:dkim,realsil.com.cn:mid]

From: Javen Xu <javen_xu@realsil.com.cn>

RSS uses multi rx queues to receive packets, and each rx queue needs one
irq and napi. So this patch adds support for multi irqs and napi here.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
changes in v2:
 - modify the name, avoid using camel names
 - change the name more reasonable, global
---
 drivers/net/ethernet/realtek/r8169_main.c | 191 ++++++++++++++++++++--
 1 file changed, 176 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 4f56f8b420fe..31d85aa75943 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -777,6 +777,19 @@ enum rtl_dash_type {
 	RTL_DASH_25_BP,
 };
 
+struct rtl8169_napi {
+	struct napi_struct napi;
+	void *priv;
+	int index;
+};
+
+struct rtl8169_irq {
+	irq_handler_t	handler;
+	unsigned int	vector;
+	u8		requested;
+	char		name[IFNAMSIZ + 10];
+};
+
 enum rx_desc_ring_type {
 	RX_DESC_RING_TYPE_UNKNOWN = 0,
 	RX_DESC_RING_TYPE_DEFAULT,
@@ -801,9 +814,19 @@ struct rtl8169_private {
 	dma_addr_t RxPhyAddr;
 	struct page *Rx_databuff[NUM_RX_DESC];	/* Rx data buffers */
 	struct ring_info tx_skb[NUM_TX_DESC];	/* Tx data buffers */
+	struct rtl8169_irq irq_tbl[R8169_MAX_MSIX_VEC];
+	struct rtl8169_napi r8169napi[R8169_MAX_MSIX_VEC];
+	u16 isr_reg[R8169_MAX_MSIX_VEC];
+	u16 imr_reg[R8169_MAX_MSIX_VEC];
+	unsigned int num_rx_rings;
 	u16 cp_cmd;
 	u16 tx_lpi_timer;
 	u32 irq_mask;
+	u8 min_irq_nvecs;
+	u8 max_irq_nvecs;
+	u8 hw_supp_isr_ver;
+	u8 hw_curr_isr_ver;
+	u8 irq_nvecs;
 	int irq;
 	struct clk *clk;
 
@@ -2738,6 +2761,44 @@ static void rtl_hw_reset(struct rtl8169_private *tp)
 	rtl_loop_wait_low(tp, &rtl_chipcmd_cond, 100, 100);
 }
 
+static void rtl_setup_mqs_reg(struct rtl8169_private *tp)
+{
+	if (tp->mac_version <= RTL_GIGA_MAC_VER_52) {
+		tp->isr_reg[0] = IntrStatus;
+		tp->imr_reg[0] = IntrMask;
+	} else {
+		tp->isr_reg[0] = IntrStatus_8125;
+		tp->imr_reg[0] = IntrMask_8125;
+	}
+
+	for (int i = 1; i < tp->max_irq_nvecs; i++)
+		tp->isr_reg[i] = (u16)(INTR_VEC_MAP_STATUS + (i - 1) * 4);
+
+	for (int i = 1; i < tp->max_irq_nvecs; i++)
+		tp->imr_reg[i] = (u16)(INTR_VEC_MAP_MASK + (i - 1) * 4);
+}
+
+static void rtl_software_parameter_initialize(struct rtl8169_private *tp)
+{
+	tp->num_rx_rings = 1;
+
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_80:
+		tp->min_irq_nvecs = R8127_MIN_IRQ;
+		tp->max_irq_nvecs = R8127_MAX_IRQ;
+		tp->hw_supp_isr_ver = 6;
+		break;
+	default:
+		tp->min_irq_nvecs = 1;
+		tp->max_irq_nvecs = 1;
+		tp->hw_supp_isr_ver = 1;
+		break;
+	}
+	tp->hw_curr_isr_ver = tp->hw_supp_isr_ver;
+
+	rtl_setup_mqs_reg(tp);
+}
+
 static void rtl_request_firmware(struct rtl8169_private *tp)
 {
 	struct rtl_fw *rtl_fw;
@@ -4324,9 +4385,21 @@ static void rtl8169_tx_clear(struct rtl8169_private *tp)
 	netdev_reset_queue(tp->dev);
 }
 
+static void rtl8169_napi_disable(struct rtl8169_private *tp)
+{
+	for (int i = 0; i < tp->irq_nvecs; i++)
+		napi_disable(&tp->r8169napi[i].napi);
+}
+
+static void rtl8169_napi_enable(struct rtl8169_private *tp)
+{
+	for (int i = 0; i < tp->irq_nvecs; i++)
+		napi_enable(&tp->r8169napi[i].napi);
+}
+
 static void rtl8169_cleanup(struct rtl8169_private *tp)
 {
-	napi_disable(&tp->napi);
+	rtl8169_napi_disable(tp);
 
 	/* Give a racing hard_start_xmit a few cycles to complete. */
 	synchronize_net();
@@ -4371,8 +4444,8 @@ static void rtl_reset_work(struct rtl8169_private *tp)
 
 	for (i = 0; i < NUM_RX_DESC; i++)
 		rtl8169_mark_to_asic(tp->RxDescArray + i);
+	rtl8169_napi_enable(tp);
 
-	napi_enable(&tp->napi);
 	rtl_hw_start(tp);
 }
 
@@ -4878,7 +4951,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 			goto release_descriptor;
 		}
 
-		skb = napi_alloc_skb(&tp->napi, pkt_size);
+		skb = napi_alloc_skb(&tp->r8169napi[0].napi, pkt_size);
 		if (unlikely(!skb)) {
 			dev->stats.rx_dropped++;
 			goto release_descriptor;
@@ -4902,7 +4975,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 		if (skb->pkt_type == PACKET_MULTICAST)
 			dev->stats.multicast++;
 
-		napi_gro_receive(&tp->napi, skb);
+		napi_gro_receive(&tp->r8169napi[0].napi, skb);
 
 		dev_sw_netstats_rx_add(dev, pkt_size);
 release_descriptor:
@@ -4914,7 +4987,8 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 
 static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 {
-	struct rtl8169_private *tp = dev_instance;
+	struct rtl8169_napi *napi = dev_instance;
+	struct rtl8169_private *tp = napi->priv;
 	u32 status = rtl_get_events(tp);
 
 	if ((status & 0xffff) == 0xffff || !(status & tp->irq_mask))
@@ -4931,13 +5005,52 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 		phy_mac_interrupt(tp->phydev);
 
 	rtl_irq_disable(tp);
-	napi_schedule(&tp->napi);
+	napi_schedule(&napi->napi);
 out:
 	rtl_ack_events(tp, status);
 
 	return IRQ_HANDLED;
 }
 
+static void rtl8169_free_irq(struct rtl8169_private *tp)
+{
+	for (int i = 0; i < tp->irq_nvecs; i++) {
+		struct rtl8169_irq *irq = &tp->irq_tbl[i];
+		struct rtl8169_napi *napi = &tp->r8169napi[i];
+
+		if (irq->requested) {
+			irq->requested = 0;
+			pci_free_irq(tp->pci_dev, i, napi);
+		}
+	}
+}
+
+static int rtl8169_request_irq(struct rtl8169_private *tp)
+{
+	const int len = sizeof(tp->irq_tbl[0].name);
+	struct net_device *dev = tp->dev;
+	struct rtl8169_napi *napi;
+	struct rtl8169_irq *irq;
+	int rc = 0;
+
+	for (int i = 0; i < tp->irq_nvecs; i++) {
+		irq = &tp->irq_tbl[i];
+
+		napi = &tp->r8169napi[i];
+		snprintf(irq->name, len, "%s-%d", dev->name, i);
+		rc = pci_request_irq(tp->pci_dev, i, irq->handler, NULL, napi, irq->name);
+		if (rc)
+			break;
+
+		irq->vector = pci_irq_vector(tp->pci_dev, i);
+		irq->requested = 1;
+	}
+
+	if (rc)
+		rtl8169_free_irq(tp);
+	return rc;
+}
+
 static void rtl_task(struct work_struct *work)
 {
 	struct rtl8169_private *tp =
@@ -4972,9 +5085,10 @@ static void rtl_task(struct work_struct *work)
 
 static int rtl8169_poll(struct napi_struct *napi, int budget)
 {
-	struct rtl8169_private *tp = container_of(napi, struct rtl8169_private, napi);
+	struct rtl8169_napi *r8169_napi = container_of(napi, struct rtl8169_napi, napi);
+	struct rtl8169_private *tp = r8169_napi->priv;
 	struct net_device *dev = tp->dev;
-	int work_done;
+	int work_done = 0;
 
 	rtl_tx(dev, tp, budget);
 
@@ -5093,7 +5207,7 @@ static void rtl8169_up(struct rtl8169_private *tp)
 	phy_init_hw(tp->phydev);
 	phy_resume(tp->phydev);
 	rtl8169_init_phy(tp);
-	napi_enable(&tp->napi);
+	rtl8169_napi_enable(tp);
 	enable_work(&tp->wk.work);
 	rtl_reset_work(tp);
 
@@ -5111,7 +5225,7 @@ static int rtl8169_close(struct net_device *dev)
 	rtl8169_down(tp);
 	rtl8169_rx_clear(tp);
 
-	free_irq(tp->irq, tp);
+	rtl8169_free_irq(tp);
 
 	phy_disconnect(tp->phydev);
 
@@ -5166,7 +5280,8 @@ static int rtl_open(struct net_device *dev)
 	rtl_request_firmware(tp);
 
 	irqflags = pci_dev_msi_enabled(pdev) ? IRQF_NO_THREAD : IRQF_SHARED;
-	retval = request_irq(tp->irq, rtl8169_interrupt, irqflags, dev->name, tp);
+
+	retval = rtl8169_request_irq(tp);
 	if (retval < 0)
 		goto err_release_fw_2;
 
@@ -5183,7 +5298,7 @@ static int rtl_open(struct net_device *dev)
 	return retval;
 
 err_free_irq:
-	free_irq(tp->irq, tp);
+	rtl8169_free_irq(tp);
 err_release_fw_2:
 	rtl_release_firmware(tp);
 	rtl8169_rx_clear(tp);
@@ -5386,7 +5501,9 @@ static void rtl_set_irq_mask(struct rtl8169_private *tp)
 
 static int rtl_alloc_irq(struct rtl8169_private *tp)
 {
+	struct pci_dev *pdev = tp->pci_dev;
 	unsigned int flags;
+	int nvecs = 1;
 
 	switch (tp->mac_version) {
 	case RTL_GIGA_MAC_VER_02 ... RTL_GIGA_MAC_VER_06:
@@ -5402,7 +5519,15 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
 		break;
 	}
 
-	return pci_alloc_irq_vectors(tp->pci_dev, 1, 1, flags);
+	nvecs = pci_alloc_irq_vectors(pdev, tp->min_irq_nvecs, tp->max_irq_nvecs, flags);
+
+	if (nvecs < 0)
+		nvecs = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+
+	tp->irq = pdev->irq;
+	tp->irq_nvecs = 1;
+
+	return nvecs;
 }
 
 static void rtl_read_mac_address(struct rtl8169_private *tp,
@@ -5597,6 +5722,18 @@ static void rtl_hw_initialize(struct rtl8169_private *tp)
 	}
 }
 
+static int rtl8169_set_real_num_queue(struct rtl8169_private *tp)
+{
+	int retval;
+
+	retval = netif_set_real_num_tx_queues(tp->dev, 1);
+	if (retval < 0)
+		return retval;
+
+	retval = netif_set_real_num_rx_queues(tp->dev, tp->num_rx_rings);
+	return retval;
+}
+
 static int rtl_jumbo_max(struct rtl8169_private *tp)
 {
 	/* Non-GBit versions don't support jumbo frames */
@@ -5657,6 +5794,19 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
 	return false;
 }
 
+static void r8169_init_napi(struct rtl8169_private *tp)
+{
+	for (int i = 0; i < tp->irq_nvecs; i++) {
+		struct rtl8169_napi *r8169napi = &tp->r8169napi[i];
+		int (*poll)(struct napi_struct *napi, int budget);
+
+		poll = rtl8169_poll;
+		netif_napi_add(tp->dev, &r8169napi->napi, poll);
+		r8169napi->priv = tp;
+		r8169napi->index = i;
+	}
+}
+
 static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	const struct rtl_chip_info *chip;
@@ -5761,11 +5911,12 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	rtl_hw_reset(tp);
 
+	rtl_software_parameter_initialize(tp);
+
 	rc = rtl_alloc_irq(tp);
 	if (rc < 0)
 		return dev_err_probe(&pdev->dev, rc, "Can't allocate interrupt\n");
 
-	tp->irq = pci_irq_vector(pdev, 0);
 
 	INIT_WORK(&tp->wk.work, rtl_task);
 	disable_work(&tp->wk.work);
@@ -5774,7 +5925,13 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	dev->ethtool_ops = &rtl8169_ethtool_ops;
 
-	netif_napi_add(dev, &tp->napi, rtl8169_poll);
+	if (!tp->rss_support) {
+		netif_napi_add(dev, &tp->r8169napi[0].napi, rtl8169_poll);
+		tp->r8169napi[0].priv = tp;
+		tp->r8169napi[0].index = 0;
+	} else {
+		r8169_init_napi(tp);
+	}
 
 	dev->hw_features = NETIF_F_IP_CSUM | NETIF_F_RXCSUM |
 			   NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX;
@@ -5836,6 +5993,10 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (jumbo_max)
 		dev->max_mtu = jumbo_max;
 
+	rc = rtl8169_set_real_num_queue(tp);
+	if (rc < 0)
+		return dev_err_probe(&pdev->dev, rc, "set tx/rx num failure\n");
+
 	rtl_set_irq_mask(tp);
 
 	tp->counters = dmam_alloc_coherent (&pdev->dev, sizeof(*tp->counters),
-- 
2.43.0


