Return-Path: <netdev+bounces-264829-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAt1NY/oqml1YAEAu9opvQ
	(envelope-from <netdev+bounces-264829-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 15:45:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD51223005
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 15:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10248302A560
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 14:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A7E1339A4;
	Fri,  6 Mar 2026 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UhxqayGy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MVMSZ9d6"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B8D18CBE1
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 14:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772808284; cv=none; b=glL3RbasFxD7SqQv05PZjWEaIkBi0YiwReOFY2Y+ELRhXibOJBXlrHamjN5ikjxPH+Fzx9N2ZHgzL8UR+2E7dwyTOR41OD7zfuTnVvaxp6W2nyT9ncIuTrn7TO9CGtTzh0FTG6zaCuuzYLM8wlwci56OgpOAEtkdcJdng2Mpn0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772808284; c=relaxed/simple;
	bh=d1wWFuHVHnhZhv95y7dUmot5sAixuDfGIaDPMQX/xu0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bVjlwBMfsZVUVdTIEzQKQI+Xol9W2pHiXj4ouSfLw4FKHAGzV3Nd5rZP6U9DeHDVO46bWiPBfdqWfKTUMLHLLm01wgLaof265e21fs/v2W54kzS5sbN3v9uTVgnviLBriKk4xaz+Zn1la1GqKuNO8F2KnEgrP2aFuXf1w83uc14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UhxqayGy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MVMSZ9d6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 6 Mar 2026 15:44:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772808280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0fKMCapP6SpVYz9aT6PNdOrTbMoeltfnD03pVfUSU4c=;
	b=UhxqayGy6t1ZZcOU61+Ph5uejSb/JYmDgYYyK8k2QRVjrffmIboIG8oilxUxzUZLdUap5l
	NZpkwkBgY4rDGJ6b9qGUGKsCtAItlrdQlW63Qi4UlpYmRhE+u6g1tNdRGFUrkdV/Cy9g1L
	1kb3BBB7WdoGItYABy/6oEmWnfabkqbbBUs5sN4CaRa+gGYXy5+QcNB/qCBhuTuEXyExgw
	lKHOBEt9rcL3oIU6WoG+YYEHEUMGq0pmwKCEoTOs0zPrAjRfGtCSzmoagdJA/rE+y7f5bn
	ONuAOqaYTed8a2eYj2arptxKQYBNRq9cDIFdYv5jR9xjQLQ3BzJiAa9u+fD3oQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772808280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0fKMCapP6SpVYz9aT6PNdOrTbMoeltfnD03pVfUSU4c=;
	b=MVMSZ9d6yM5mT8/oCKEnhc+NhcHEoitJVZrj98sSidiN5aJCec+lQuuoZGoMbvWMLjJa/N
	G5rFHIkuhlBeZJBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>, Danish Anwar <danishanwar@ti.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Martin Kaistra <martin.kaistra@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v2 net-next] net: ethernet: ti: am65-cpsw: Use also port
 number to identify timestamps
Message-ID: <20260306144439.cVwaaopR@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4DD51223005
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264829-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
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
v1=E2=80=A6v2: https://lore.kernel.org/all/20260304080318.FyNGmyyP@linutron=
ix.de
  - Document `port_id' in am65_cpts_prep_tx_timestamp(), kernel test
    robot complained.

 drivers/net/ethernet/ti/am65-cpsw-nuss.c |  4 ++--
 drivers/net/ethernet/ti/am65-cpts.c      | 23 +++++++++--------------
 drivers/net/ethernet/ti/am65-cpts.h      |  8 ++++++--
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/etherne=
t/ti/am65-cpsw-nuss.c
index 5924db6be3fea..756393088f0ee 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -1352,7 +1352,7 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw=
_rx_flow *flow,
 	am65_cpsw_nuss_set_offload_fwd_mark(skb, ndev_priv->offload_fwd_mark);
 	skb_put(skb, pkt_len);
 	if (port->rx_ts_enabled)
-		am65_cpts_rx_timestamp(common->cpts, skb);
+		am65_cpts_rx_timestamp(common->cpts, port_id, skb);
 	skb_mark_for_recycle(skb);
 	skb->protocol =3D eth_type_trans(skb, ndev);
 	am65_cpsw_nuss_rx_csum(skb, csum_info);
@@ -1607,7 +1607,7 @@ static netdev_tx_t am65_cpsw_nuss_ndo_slave_xmit(stru=
ct sk_buff *skb,
=20
 	/* SKB TX timestamp */
 	if (port->tx_ts_enabled)
-		am65_cpts_prep_tx_timestamp(common->cpts, skb);
+		am65_cpts_prep_tx_timestamp(common->cpts, port->port_id, skb);
=20
 	q_idx =3D skb_get_queue_mapping(skb);
 	dev_dbg(dev, "%s skb_queue:%d\n", __func__, q_idx);
diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/=
am65-cpts.c
index 8ffbfaa3ab18c..efbf2ef976a32 100644
--- a/drivers/net/ethernet/ti/am65-cpts.c
+++ b/drivers/net/ethernet/ti/am65-cpts.c
@@ -796,11 +796,7 @@ static bool am65_cpts_match_tx_ts(struct am65_cpts *cp=
ts,
 	bool found =3D false;
 	u32 mtype_seqid;
=20
-	mtype_seqid =3D event->event1 &
-		      (AM65_CPTS_EVENT_1_MESSAGE_TYPE_MASK |
-		       AM65_CPTS_EVENT_1_EVENT_TYPE_MASK |
-		       AM65_CPTS_EVENT_1_SEQUENCE_ID_MASK);
-
+	mtype_seqid =3D event->event1;
 	__skb_queue_head_init(&txq_list);
=20
 	spin_lock_irqsave(&cpts->txq.lock, flags);
@@ -922,7 +918,6 @@ static u64 am65_cpts_find_rx_ts(struct am65_cpts *cpts,=
 u32 skb_mtype_seqid)
 	struct list_head *this, *next;
 	struct am65_cpts_event *event;
 	unsigned long flags;
-	u32 mtype_seqid;
 	u64 ns =3D 0;
=20
 	spin_lock_irqsave(&cpts->lock, flags);
@@ -934,12 +929,7 @@ static u64 am65_cpts_find_rx_ts(struct am65_cpts *cpts=
, u32 skb_mtype_seqid)
 			continue;
 		}
=20
-		mtype_seqid =3D event->event1 &
-			      (AM65_CPTS_EVENT_1_MESSAGE_TYPE_MASK |
-			       AM65_CPTS_EVENT_1_SEQUENCE_ID_MASK |
-			       AM65_CPTS_EVENT_1_EVENT_TYPE_MASK);
-
-		if (mtype_seqid =3D=3D skb_mtype_seqid) {
+		if (event->event1 =3D=3D skb_mtype_seqid) {
 			ns =3D event->timestamp;
 			list_move(&event->list, &cpts->pool);
 			break;
@@ -950,7 +940,8 @@ static u64 am65_cpts_find_rx_ts(struct am65_cpts *cpts,=
 u32 skb_mtype_seqid)
 	return ns;
 }
=20
-void am65_cpts_rx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb)
+void am65_cpts_rx_timestamp(struct am65_cpts *cpts, unsigned int port_id,
+			    struct sk_buff *skb)
 {
 	struct am65_cpts_skb_cb_data *skb_cb =3D (struct am65_cpts_skb_cb_data *)=
skb->cb;
 	struct skb_shared_hwtstamps *ssh;
@@ -966,6 +957,7 @@ void am65_cpts_rx_timestamp(struct am65_cpts *cpts, str=
uct sk_buff *skb)
 	if (!ret)
 		return; /* if not PTP class packet */
=20
+	skb_cb->skb_mtype_seqid |=3D port_id << AM65_CPTS_EVENT_1_PORT_NUMBER_SHI=
FT;
 	skb_cb->skb_mtype_seqid |=3D (AM65_CPTS_EV_RX << AM65_CPTS_EVENT_1_EVENT_=
TYPE_SHIFT);
=20
 	dev_dbg(cpts->dev, "%s mtype seqid %08x\n", __func__, skb_cb->skb_mtype_s=
eqid);
@@ -1009,13 +1001,15 @@ EXPORT_SYMBOL_GPL(am65_cpts_tx_timestamp);
 /**
  * am65_cpts_prep_tx_timestamp - check and prepare tx packet for timestamp=
ing
  * @cpts: cpts handle
+ * @port_id: The port on which the skb will be sent
  * @skb: packet
  *
  * This functions should be called from .xmit().
  * It checks if packet can be timestamped, fills internal cpts data
  * in skb-cb and marks packet as SKBTX_IN_PROGRESS.
  */
-void am65_cpts_prep_tx_timestamp(struct am65_cpts *cpts, struct sk_buff *s=
kb)
+void am65_cpts_prep_tx_timestamp(struct am65_cpts *cpts, unsigned int port=
_id,
+				 struct sk_buff *skb)
 {
 	struct am65_cpts_skb_cb_data *skb_cb =3D (void *)skb->cb;
 	int ret;
@@ -1026,6 +1020,7 @@ void am65_cpts_prep_tx_timestamp(struct am65_cpts *cp=
ts, struct sk_buff *skb)
 	ret =3D am65_skb_get_mtype_seqid(skb, &skb_cb->skb_mtype_seqid);
 	if (!ret)
 		return;
+	skb_cb->skb_mtype_seqid |=3D port_id << AM65_CPTS_EVENT_1_PORT_NUMBER_SHI=
FT;
 	skb_cb->skb_mtype_seqid |=3D (AM65_CPTS_EV_TX <<
 				   AM65_CPTS_EVENT_1_EVENT_TYPE_SHIFT);
=20
diff --git a/drivers/net/ethernet/ti/am65-cpts.h b/drivers/net/ethernet/ti/=
am65-cpts.h
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
-void am65_cpts_prep_tx_timestamp(struct am65_cpts *cpts, struct sk_buff *s=
kb);
+void am65_cpts_prep_tx_timestamp(struct am65_cpts *cpts, unsigned int port=
_id,
+				 struct sk_buff *skb);
 u64 am65_cpts_ns_gettime(struct am65_cpts *cpts);
 int am65_cpts_estf_enable(struct am65_cpts *cpts, int idx,
 			  struct am65_cpts_estf_cfg *cfg);
@@ -49,6 +51,7 @@ static inline int am65_cpts_phc_index(struct am65_cpts *c=
pts)
 }
=20
 static inline void am65_cpts_rx_timestamp(struct am65_cpts *cpts,
+					  unsigned int port_id,
 					  struct sk_buff *skb)
 {
 }
@@ -59,6 +62,7 @@ static inline void am65_cpts_tx_timestamp(struct am65_cpt=
s *cpts,
 }
=20
 static inline void am65_cpts_prep_tx_timestamp(struct am65_cpts *cpts,
+					       unsigned int port_id,
 					       struct sk_buff *skb)
 {
 }
--=20
2.53.0


