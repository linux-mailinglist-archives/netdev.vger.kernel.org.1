Return-Path: <netdev+bounces-263637-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMZVKE3np2mDlgAAu9opvQ
	(envelope-from <netdev+bounces-263637-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 09:03:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1381FC1EF
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 09:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF5AA3007AD9
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 08:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3728137FF61;
	Wed,  4 Mar 2026 08:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="03yqtwYo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+LHMNdAP"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18F323645D
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 08:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772611403; cv=none; b=d998iFpMx+C59P8d0XCQohWK6/P222suLkoyUrEkcaBb2Pf+dA2k9FYoyY/MX7ftQ92vPeDoV3lq4v+708RJLTSH1AB6DqIr4Mvrmi2myAXnbWTnv9wFjP0LZxs0afTsvKTam0vY/Sr72coEiEgArw+coECYXTBJUfurDmcE9k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772611403; c=relaxed/simple;
	bh=3P8xKK8MU7HzIkeOnwLzwGDIwDW3DGdPESmM/BpvYrc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sxQ1RQoSVMW/i9NEN7YRSSCSQlAoqr0D1yHByZflyzYshVtBEiMp2fmEVIjzYicL7c68obqdJik/TJnfGbUnYgcK0su3Rh4Y25/oF9cvYf4ecd3a88Ue76dwqJ8T+K/FxmOsryhAdfn3ka6mzduiVKz04htXTGxO9mvwzCwi4qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=03yqtwYo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+LHMNdAP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 4 Mar 2026 09:03:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772611400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=iUwP6PikDk+vwaerz1jf3UvDEv6/N1Xq4zAzXJlVr6A=;
	b=03yqtwYoC6nTbiRjGjtn2Te0Fn8NKWESqMrszg+/fWhYGVKGlnyB45dxfe6n2hiEomqngz
	gdFXm2+xpZ7of3Hbj0GxL34oPIgVk7or9s2bKihgZps8XAC7wkv5x277uVHjIeXC3GQe5P
	Uws8ZVdbKexMymZqeunjg/K8jJl8+5BRYyDy2B+KMw0yAeQumWtzeGib7OPXFSV+8w9puX
	YHMDmnMqN2psAO2KxgoUaD2fxV2atmtTuVyZ7+bTWJvRs2x7K4FqlK7E85U+s840y/jEuc
	5Sg8sYTUkI+TJFLsBVl/jpixYdtYZCQ27usx/Y52SiMJYw+JlCrkf9/9xu7zjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772611400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=iUwP6PikDk+vwaerz1jf3UvDEv6/N1Xq4zAzXJlVr6A=;
	b=+LHMNdAP88eQ1tDhemLWrAbJEK6feJHJgi4gNyQb2ankoWje9f2tNinpg+ZUzQ8ADWizAi
	1Q4vlaKwgiEDWsBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>, Danish Anwar <danishanwar@ti.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Martin Kaistra <martin.kaistra@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net: ethernet: ti: am65-cpsw: Use also port number
 to identify timestamps
Message-ID: <20260304080318.FyNGmyyP@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Rspamd-Queue-Id: 1D1381FC1EF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263637-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linutronix.de:dkim,linutronix.de:email,linutronix.de:mid,ti.com:email]
X-Rspamd-Action: no action

The driver uses packet-type (RX/TX) PTP-message type and PTP-sequence
number to identify a matching timestamp packet for a skb. If the same
PTP packet arrives on both ports (as in a PRP environment) then it is
not obvious which event belongs to which skb.

The event contains also the port number on which it was received.
Instead of masking it out, use it for matching.

Tested-by: Chintan Vankar <c-vankar@ti.com>
Reviewed-by: Martin Kaistra <martin.kaistra@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c |  4 ++--
 drivers/net/ethernet/ti/am65-cpts.c      | 22 ++++++++--------------
 drivers/net/ethernet/ti/am65-cpts.h      |  8 ++++++--
 3 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 5924db6be3fea..756393088f0ee 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -1352,7 +1352,7 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_rx_flow *flow,
 	am65_cpsw_nuss_set_offload_fwd_mark(skb, ndev_priv->offload_fwd_mark);
 	skb_put(skb, pkt_len);
 	if (port->rx_ts_enabled)
-		am65_cpts_rx_timestamp(common->cpts, skb);
+		am65_cpts_rx_timestamp(common->cpts, port_id, skb);
 	skb_mark_for_recycle(skb);
 	skb->protocol = eth_type_trans(skb, ndev);
 	am65_cpsw_nuss_rx_csum(skb, csum_info);
@@ -1607,7 +1607,7 @@ static netdev_tx_t am65_cpsw_nuss_ndo_slave_xmit(struct sk_buff *skb,
 
 	/* SKB TX timestamp */
 	if (port->tx_ts_enabled)
-		am65_cpts_prep_tx_timestamp(common->cpts, skb);
+		am65_cpts_prep_tx_timestamp(common->cpts, port->port_id, skb);
 
 	q_idx = skb_get_queue_mapping(skb);
 	dev_dbg(dev, "%s skb_queue:%d\n", __func__, q_idx);
diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/am65-cpts.c
index 8ffbfaa3ab18c..3699abec71f1f 100644
--- a/drivers/net/ethernet/ti/am65-cpts.c
+++ b/drivers/net/ethernet/ti/am65-cpts.c
@@ -796,11 +796,7 @@ static bool am65_cpts_match_tx_ts(struct am65_cpts *cpts,
 	bool found = false;
 	u32 mtype_seqid;
 
-	mtype_seqid = event->event1 &
-		      (AM65_CPTS_EVENT_1_MESSAGE_TYPE_MASK |
-		       AM65_CPTS_EVENT_1_EVENT_TYPE_MASK |
-		       AM65_CPTS_EVENT_1_SEQUENCE_ID_MASK);
-
+	mtype_seqid = event->event1;
 	__skb_queue_head_init(&txq_list);
 
 	spin_lock_irqsave(&cpts->txq.lock, flags);
@@ -922,7 +918,6 @@ static u64 am65_cpts_find_rx_ts(struct am65_cpts *cpts, u32 skb_mtype_seqid)
 	struct list_head *this, *next;
 	struct am65_cpts_event *event;
 	unsigned long flags;
-	u32 mtype_seqid;
 	u64 ns = 0;
 
 	spin_lock_irqsave(&cpts->lock, flags);
@@ -934,12 +929,7 @@ static u64 am65_cpts_find_rx_ts(struct am65_cpts *cpts, u32 skb_mtype_seqid)
 			continue;
 		}
 
-		mtype_seqid = event->event1 &
-			      (AM65_CPTS_EVENT_1_MESSAGE_TYPE_MASK |
-			       AM65_CPTS_EVENT_1_SEQUENCE_ID_MASK |
-			       AM65_CPTS_EVENT_1_EVENT_TYPE_MASK);
-
-		if (mtype_seqid == skb_mtype_seqid) {
+		if (event->event1 == skb_mtype_seqid) {
 			ns = event->timestamp;
 			list_move(&event->list, &cpts->pool);
 			break;
@@ -950,7 +940,8 @@ static u64 am65_cpts_find_rx_ts(struct am65_cpts *cpts, u32 skb_mtype_seqid)
 	return ns;
 }
 
-void am65_cpts_rx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb)
+void am65_cpts_rx_timestamp(struct am65_cpts *cpts, unsigned int port_id,
+			    struct sk_buff *skb)
 {
 	struct am65_cpts_skb_cb_data *skb_cb = (struct am65_cpts_skb_cb_data *)skb->cb;
 	struct skb_shared_hwtstamps *ssh;
@@ -966,6 +957,7 @@ void am65_cpts_rx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb)
 	if (!ret)
 		return; /* if not PTP class packet */
 
+	skb_cb->skb_mtype_seqid |= port_id << AM65_CPTS_EVENT_1_PORT_NUMBER_SHIFT;
 	skb_cb->skb_mtype_seqid |= (AM65_CPTS_EV_RX << AM65_CPTS_EVENT_1_EVENT_TYPE_SHIFT);
 
 	dev_dbg(cpts->dev, "%s mtype seqid %08x\n", __func__, skb_cb->skb_mtype_seqid);
@@ -1015,7 +1007,8 @@ EXPORT_SYMBOL_GPL(am65_cpts_tx_timestamp);
  * It checks if packet can be timestamped, fills internal cpts data
  * in skb-cb and marks packet as SKBTX_IN_PROGRESS.
  */
-void am65_cpts_prep_tx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb)
+void am65_cpts_prep_tx_timestamp(struct am65_cpts *cpts, unsigned int port_id,
+				 struct sk_buff *skb)
 {
 	struct am65_cpts_skb_cb_data *skb_cb = (void *)skb->cb;
 	int ret;
@@ -1026,6 +1019,7 @@ void am65_cpts_prep_tx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb)
 	ret = am65_skb_get_mtype_seqid(skb, &skb_cb->skb_mtype_seqid);
 	if (!ret)
 		return;
+	skb_cb->skb_mtype_seqid |= port_id << AM65_CPTS_EVENT_1_PORT_NUMBER_SHIFT;
 	skb_cb->skb_mtype_seqid |= (AM65_CPTS_EV_TX <<
 				   AM65_CPTS_EVENT_1_EVENT_TYPE_SHIFT);
 
diff --git a/drivers/net/ethernet/ti/am65-cpts.h b/drivers/net/ethernet/ti/am65-cpts.h
index 6099d772799da..5fa77b0fc8372 100644
--- a/drivers/net/ethernet/ti/am65-cpts.h
+++ b/drivers/net/ethernet/ti/am65-cpts.h
@@ -22,9 +22,11 @@ void am65_cpts_release(struct am65_cpts *cpts);
 struct am65_cpts *am65_cpts_create(struct device *dev, void __iomem *regs,
 				   struct device_node *node);
 int am65_cpts_phc_index(struct am65_cpts *cpts);
-void am65_cpts_rx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb);
+void am65_cpts_rx_timestamp(struct am65_cpts *cpts, unsigned int port_id,
+			    struct sk_buff *skb);
 void am65_cpts_tx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb);
-void am65_cpts_prep_tx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb);
+void am65_cpts_prep_tx_timestamp(struct am65_cpts *cpts, unsigned int port_id,
+				 struct sk_buff *skb);
 u64 am65_cpts_ns_gettime(struct am65_cpts *cpts);
 int am65_cpts_estf_enable(struct am65_cpts *cpts, int idx,
 			  struct am65_cpts_estf_cfg *cfg);
@@ -49,6 +51,7 @@ static inline int am65_cpts_phc_index(struct am65_cpts *cpts)
 }
 
 static inline void am65_cpts_rx_timestamp(struct am65_cpts *cpts,
+					  unsigned int port_id,
 					  struct sk_buff *skb)
 {
 }
@@ -59,6 +62,7 @@ static inline void am65_cpts_tx_timestamp(struct am65_cpts *cpts,
 }
 
 static inline void am65_cpts_prep_tx_timestamp(struct am65_cpts *cpts,
+					       unsigned int port_id,
 					       struct sk_buff *skb)
 {
 }
-- 
2.53.0


