Return-Path: <netdev+bounces-252552-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFArEIWmcmmMoQAAu9opvQ
	(envelope-from <netdev+bounces-252552-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 23:36:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DADC86E372
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 23:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CED8301808D
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 22:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EBF3D3D18;
	Thu, 22 Jan 2026 22:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GMxKVmE0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6BF3D44B5
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 22:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769121381; cv=none; b=P4Tg1/51xOhm278XMfpSRZ+1suRlmFtvGVEhMdH24YLScvjqoiQnReDTjq8LZ0YhX0qE3KtqDGnfLu3eV/pMHV5UOH0d4hKMHTyyfzanlJY4Dq48sQc7u+aWJPMErxQHiLpKBT3q0SjWPIc3VMVa9m1OWQA0yCsvgM9nNHuJLBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769121381; c=relaxed/simple;
	bh=snoRkuwuhpe26sskhd1nSfJC2pyHof/IPLPnFGhtfO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/iS1YFLiZV6zOwUJ9Hcud951HcgIcIHTo63byngV32eI2EbU6FMepTTBZA9j+HUZObeaM0/efLFG56XidghkhgaFdiTVJcCmxDCFXVHJdncNz65xD2GRtdWLoddLQx8L9hfTdGWf+HX817KstJmwDLS4hl2dVaA1S9Rm4n3Npo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GMxKVmE0; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769121371; x=1800657371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=snoRkuwuhpe26sskhd1nSfJC2pyHof/IPLPnFGhtfO0=;
  b=GMxKVmE0GLcxHRhknbc/aN+/veV8n1LuSoHmBiWe1APs2kUDFWBu5wpK
   Zvd8q6WsY4oVcZAu1Q8fvTJX+R0C2YSvAmqdi8ofY/PwmGf+REaErhZk3
   Y09SM3jZoS3L8sUDbQz3+iBlPki3lqtZ2YHxc/ilOYJpXSoyHDfJaNr6I
   mm6h+U3gpBz+OSdYV7VBDSSIqvM+VHkZfvhiDdTWzAryImUJA9VQBs/85
   SF4KkLnW34t50GS4f/xQ4VRByb23vyZjh29YubM2ryp0Sw9/LmermPDob
   skELp72evBO/ZwrakZIJJ4A7fnfOcH4nUNj9CFmMEX700TRTouxC+ie8T
   w==;
X-CSE-ConnectionGUID: B0FJDAcYSWG77WkXKFtfAQ==
X-CSE-MsgGUID: Iku07NTfQgW1cIBE0dui0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="93039248"
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; 
   d="scan'208";a="93039248"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 14:36:08 -0800
X-CSE-ConnectionGUID: lfy5O8ZsTS2IcrZ7iQUwAg==
X-CSE-MsgGUID: vA/DemecT9ebbdm48K4/Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; 
   d="scan'208";a="206670450"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 22 Jan 2026 14:36:05 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Joshua Hay <joshua.a.hay@intel.com>,
	anthony.l.nguyen@intel.com,
	madhu.chittim@intel.com,
	samuel.salin@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net-next v2 04/10] idpf: move some iterator declarations inside for loops
Date: Thu, 22 Jan 2026 14:35:50 -0800
Message-ID: <20260122223601.2208759-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260122223601.2208759-1-anthony.l.nguyen@intel.com>
References: <20260122223601.2208759-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252552-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: DADC86E372
X-Rspamd-Action: no action

From: Joshua Hay <joshua.a.hay@intel.com>

Move some iterator declarations to their respective for loops; use more
appropriate unsigned type.

Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 28 +++---
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  8 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 96 ++++++++-----------
 3 files changed, 57 insertions(+), 75 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index 072c065a6006..3d0f3170a6f2 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -671,7 +671,7 @@ static int idpf_set_ringparam(struct net_device *netdev,
 	u32 new_rx_count, new_tx_count;
 	struct idpf_q_vec_rsrc *rsrc;
 	struct idpf_vport *vport;
-	int i, err = 0;
+	int err = 0;
 	u16 idx;
 
 	idpf_vport_ctrl_lock(netdev);
@@ -726,7 +726,7 @@ static int idpf_set_ringparam(struct net_device *netdev,
 	/* Since we adjusted the RX completion queue count, the RX buffer queue
 	 * descriptor count needs to be adjusted as well
 	 */
-	for (i = 0; i < rsrc->num_bufqs_per_qgrp; i++)
+	for (unsigned int i = 0; i < rsrc->num_bufqs_per_qgrp; i++)
 		rsrc->bufq_desc_count[i] =
 			IDPF_RX_BUFQ_DESC_COUNT(new_rx_count,
 						rsrc->num_bufqs_per_qgrp);
@@ -1107,7 +1107,6 @@ static void idpf_collect_queue_stats(struct idpf_vport *vport)
 {
 	struct idpf_port_stats *pstats = &vport->port_stats;
 	struct idpf_q_vec_rsrc *rsrc = &vport->dflt_qv_rsrc;
-	int i, j;
 
 	/* zero out port stats since they're actually tracked in per
 	 * queue stats; this is only for reporting
@@ -1123,7 +1122,7 @@ static void idpf_collect_queue_stats(struct idpf_vport *vport)
 	u64_stats_set(&pstats->tx_dma_map_errs, 0);
 	u64_stats_update_end(&pstats->stats_sync);
 
-	for (i = 0; i < rsrc->num_rxq_grp; i++) {
+	for (unsigned int i = 0; i < rsrc->num_rxq_grp; i++) {
 		struct idpf_rxq_group *rxq_grp = &rsrc->rxq_grps[i];
 		u16 num_rxq;
 
@@ -1132,7 +1131,7 @@ static void idpf_collect_queue_stats(struct idpf_vport *vport)
 		else
 			num_rxq = rxq_grp->singleq.num_rxq;
 
-		for (j = 0; j < num_rxq; j++) {
+		for (unsigned int j = 0; j < num_rxq; j++) {
 			u64 hw_csum_err, hsplit, hsplit_hbo, bad_descs;
 			struct idpf_rx_queue_stats *stats;
 			struct idpf_rx_queue *rxq;
@@ -1165,10 +1164,10 @@ static void idpf_collect_queue_stats(struct idpf_vport *vport)
 		}
 	}
 
-	for (i = 0; i < rsrc->num_txq_grp; i++) {
+	for (unsigned int i = 0; i < rsrc->num_txq_grp; i++) {
 		struct idpf_txq_group *txq_grp = &rsrc->txq_grps[i];
 
-		for (j = 0; j < txq_grp->num_txq; j++) {
+		for (unsigned int j = 0; j < txq_grp->num_txq; j++) {
 			u64 linearize, qbusy, skb_drops, dma_map_errs;
 			struct idpf_tx_queue *txq = txq_grp->txqs[j];
 			struct idpf_tx_queue_stats *stats;
@@ -1214,7 +1213,6 @@ static void idpf_get_ethtool_stats(struct net_device *netdev,
 	struct idpf_q_vec_rsrc *rsrc;
 	struct idpf_vport *vport;
 	unsigned int total = 0;
-	unsigned int i, j;
 	bool is_splitq;
 	u16 qtype;
 
@@ -1233,12 +1231,12 @@ static void idpf_get_ethtool_stats(struct net_device *netdev,
 	idpf_add_port_stats(vport, &data);
 
 	rsrc = &vport->dflt_qv_rsrc;
-	for (i = 0; i < rsrc->num_txq_grp; i++) {
+	for (unsigned int i = 0; i < rsrc->num_txq_grp; i++) {
 		struct idpf_txq_group *txq_grp = &rsrc->txq_grps[i];
 
 		qtype = VIRTCHNL2_QUEUE_TYPE_TX;
 
-		for (j = 0; j < txq_grp->num_txq; j++, total++) {
+		for (unsigned int j = 0; j < txq_grp->num_txq; j++, total++) {
 			struct idpf_tx_queue *txq = txq_grp->txqs[j];
 
 			if (!txq)
@@ -1260,7 +1258,7 @@ static void idpf_get_ethtool_stats(struct net_device *netdev,
 
 	is_splitq = idpf_is_queue_model_split(rsrc->rxq_model);
 
-	for (i = 0; i < rsrc->num_rxq_grp; i++) {
+	for (unsigned int i = 0; i < rsrc->num_rxq_grp; i++) {
 		struct idpf_rxq_group *rxq_grp = &rsrc->rxq_grps[i];
 		u16 num_rxq;
 
@@ -1271,7 +1269,7 @@ static void idpf_get_ethtool_stats(struct net_device *netdev,
 		else
 			num_rxq = rxq_grp->singleq.num_rxq;
 
-		for (j = 0; j < num_rxq; j++, total++) {
+		for (unsigned int j = 0; j < num_rxq; j++, total++) {
 			struct idpf_rx_queue *rxq;
 
 			if (is_splitq)
@@ -1560,7 +1558,7 @@ static int idpf_set_coalesce(struct net_device *netdev,
 	struct idpf_q_coalesce *q_coal;
 	struct idpf_q_vec_rsrc *rsrc;
 	struct idpf_vport *vport;
-	int i, err = 0;
+	int err = 0;
 
 	user_config = &np->adapter->vport_config[np->vport_idx]->user_config;
 
@@ -1571,14 +1569,14 @@ static int idpf_set_coalesce(struct net_device *netdev,
 		goto unlock_mutex;
 
 	rsrc = &vport->dflt_qv_rsrc;
-	for (i = 0; i < rsrc->num_txq; i++) {
+	for (unsigned int i = 0; i < rsrc->num_txq; i++) {
 		q_coal = &user_config->q_coalesce[i];
 		err = idpf_set_q_coalesce(vport, q_coal, ec, i, false);
 		if (err)
 			goto unlock_mutex;
 	}
 
-	for (i = 0; i < rsrc->num_rxq; i++) {
+	for (unsigned int i = 0; i < rsrc->num_rxq; i++) {
 		q_coal = &user_config->q_coalesce[i];
 		err = idpf_set_q_coalesce(vport, q_coal, ec, i, true);
 		if (err)
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 4ec662f1918e..ae268e75b167 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1460,20 +1460,18 @@ static void idpf_up_complete(struct idpf_vport *vport)
  */
 static void idpf_rx_init_buf_tail(struct idpf_q_vec_rsrc *rsrc)
 {
-	int i, j;
-
-	for (i = 0; i < rsrc->num_rxq_grp; i++) {
+	for (unsigned int i = 0; i < rsrc->num_rxq_grp; i++) {
 		struct idpf_rxq_group *grp = &rsrc->rxq_grps[i];
 
 		if (idpf_is_queue_model_split(rsrc->rxq_model)) {
-			for (j = 0; j < rsrc->num_bufqs_per_qgrp; j++) {
+			for (unsigned int j = 0; j < rsrc->num_bufqs_per_qgrp; j++) {
 				const struct idpf_buf_queue *q =
 					&grp->splitq.bufq_sets[j].bufq;
 
 				writel(q->next_to_alloc, q->tail);
 			}
 		} else {
-			for (j = 0; j < grp->singleq.num_rxq; j++) {
+			for (unsigned int j = 0; j < grp->singleq.num_rxq; j++) {
 				const struct idpf_rx_queue *q =
 					grp->singleq.rxqs[j];
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 3a369f592115..f41cf79d11cb 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -154,15 +154,13 @@ static void idpf_compl_desc_rel(struct idpf_compl_queue *complq)
  */
 static void idpf_tx_desc_rel_all(struct idpf_q_vec_rsrc *rsrc)
 {
-	int i, j;
-
 	if (!rsrc->txq_grps)
 		return;
 
-	for (i = 0; i < rsrc->num_txq_grp; i++) {
+	for (unsigned int i = 0; i < rsrc->num_txq_grp; i++) {
 		struct idpf_txq_group *txq_grp = &rsrc->txq_grps[i];
 
-		for (j = 0; j < txq_grp->num_txq; j++)
+		for (unsigned int j = 0; j < txq_grp->num_txq; j++)
 			idpf_tx_desc_rel(txq_grp->txqs[j]);
 
 		if (idpf_is_queue_model_split(rsrc->txq_model))
@@ -306,13 +304,12 @@ static int idpf_tx_desc_alloc_all(struct idpf_vport *vport,
 				  struct idpf_q_vec_rsrc *rsrc)
 {
 	int err = 0;
-	int i, j;
 
 	/* Setup buffer queues. In single queue model buffer queues and
 	 * completion queues will be same
 	 */
-	for (i = 0; i < rsrc->num_txq_grp; i++) {
-		for (j = 0; j < rsrc->txq_grps[i].num_txq; j++) {
+	for (unsigned int i = 0; i < rsrc->num_txq_grp; i++) {
+		for (unsigned int j = 0; j < rsrc->txq_grps[i].num_txq; j++) {
 			struct idpf_tx_queue *txq = rsrc->txq_grps[i].txqs[j];
 
 			err = idpf_tx_desc_alloc(vport, txq);
@@ -501,30 +498,29 @@ static void idpf_rx_desc_rel_all(struct idpf_q_vec_rsrc *rsrc)
 	struct device *dev = rsrc->dev;
 	struct idpf_rxq_group *rx_qgrp;
 	u16 num_rxq;
-	int i, j;
 
 	if (!rsrc->rxq_grps)
 		return;
 
-	for (i = 0; i < rsrc->num_rxq_grp; i++) {
+	for (unsigned int i = 0; i < rsrc->num_rxq_grp; i++) {
 		rx_qgrp = &rsrc->rxq_grps[i];
 
 		if (!idpf_is_queue_model_split(rsrc->rxq_model)) {
-			for (j = 0; j < rx_qgrp->singleq.num_rxq; j++)
+			for (unsigned int j = 0; j < rx_qgrp->singleq.num_rxq; j++)
 				idpf_rx_desc_rel(rx_qgrp->singleq.rxqs[j], dev,
 						 VIRTCHNL2_QUEUE_MODEL_SINGLE);
 			continue;
 		}
 
 		num_rxq = rx_qgrp->splitq.num_rxq_sets;
-		for (j = 0; j < num_rxq; j++)
+		for (unsigned int j = 0; j < num_rxq; j++)
 			idpf_rx_desc_rel(&rx_qgrp->splitq.rxq_sets[j]->rxq,
 					 dev, VIRTCHNL2_QUEUE_MODEL_SPLIT);
 
 		if (!rx_qgrp->splitq.bufq_sets)
 			continue;
 
-		for (j = 0; j < rsrc->num_bufqs_per_qgrp; j++) {
+		for (unsigned int j = 0; j < rsrc->num_bufqs_per_qgrp; j++) {
 			struct idpf_bufq_set *bufq_set =
 				&rx_qgrp->splitq.bufq_sets[j];
 
@@ -793,11 +789,11 @@ int idpf_rx_bufs_init_all(struct idpf_vport *vport,
 			  struct idpf_q_vec_rsrc *rsrc)
 {
 	bool split = idpf_is_queue_model_split(rsrc->rxq_model);
-	int i, j, err;
+	int err;
 
 	idpf_xdp_copy_prog_to_rqs(rsrc, vport->xdp_prog);
 
-	for (i = 0; i < rsrc->num_rxq_grp; i++) {
+	for (unsigned int i = 0; i < rsrc->num_rxq_grp; i++) {
 		struct idpf_rxq_group *rx_qgrp = &rsrc->rxq_grps[i];
 		u32 truesize = 0;
 
@@ -805,7 +801,7 @@ int idpf_rx_bufs_init_all(struct idpf_vport *vport,
 		if (!split) {
 			int num_rxq = rx_qgrp->singleq.num_rxq;
 
-			for (j = 0; j < num_rxq; j++) {
+			for (unsigned int j = 0; j < num_rxq; j++) {
 				struct idpf_rx_queue *q;
 
 				q = rx_qgrp->singleq.rxqs[j];
@@ -818,7 +814,7 @@ int idpf_rx_bufs_init_all(struct idpf_vport *vport,
 		}
 
 		/* Otherwise, allocate bufs for the buffer queues */
-		for (j = 0; j < rsrc->num_bufqs_per_qgrp; j++) {
+		for (unsigned int j = 0; j < rsrc->num_bufqs_per_qgrp; j++) {
 			enum libeth_fqe_type type;
 			struct idpf_buf_queue *q;
 
@@ -912,17 +908,17 @@ static int idpf_rx_desc_alloc_all(struct idpf_vport *vport,
 				  struct idpf_q_vec_rsrc *rsrc)
 {
 	struct idpf_rxq_group *rx_qgrp;
-	int i, j, err;
 	u16 num_rxq;
+	int err;
 
-	for (i = 0; i < rsrc->num_rxq_grp; i++) {
+	for (unsigned int i = 0; i < rsrc->num_rxq_grp; i++) {
 		rx_qgrp = &rsrc->rxq_grps[i];
 		if (idpf_is_queue_model_split(rsrc->rxq_model))
 			num_rxq = rx_qgrp->splitq.num_rxq_sets;
 		else
 			num_rxq = rx_qgrp->singleq.num_rxq;
 
-		for (j = 0; j < num_rxq; j++) {
+		for (unsigned int j = 0; j < num_rxq; j++) {
 			struct idpf_rx_queue *q;
 
 			if (idpf_is_queue_model_split(rsrc->rxq_model))
@@ -942,7 +938,7 @@ static int idpf_rx_desc_alloc_all(struct idpf_vport *vport,
 		if (!idpf_is_queue_model_split(rsrc->rxq_model))
 			continue;
 
-		for (j = 0; j < rsrc->num_bufqs_per_qgrp; j++) {
+		for (unsigned int j = 0; j < rsrc->num_bufqs_per_qgrp; j++) {
 			struct idpf_buf_queue *q;
 
 			q = &rx_qgrp->splitq.bufq_sets[j].bufq;
@@ -1307,17 +1303,16 @@ int idpf_qp_switch(struct idpf_vport *vport, u32 qid, bool en)
 static void idpf_txq_group_rel(struct idpf_q_vec_rsrc *rsrc)
 {
 	bool split;
-	int i, j;
 
 	if (!rsrc->txq_grps)
 		return;
 
 	split = idpf_is_queue_model_split(rsrc->txq_model);
 
-	for (i = 0; i < rsrc->num_txq_grp; i++) {
+	for (unsigned int i = 0; i < rsrc->num_txq_grp; i++) {
 		struct idpf_txq_group *txq_grp = &rsrc->txq_grps[i];
 
-		for (j = 0; j < txq_grp->num_txq; j++) {
+		for (unsigned int j = 0; j < txq_grp->num_txq; j++) {
 			if (idpf_queue_has(FLOW_SCH_EN, txq_grp->txqs[j])) {
 				kfree(txq_grp->txqs[j]->refillq);
 				txq_grp->txqs[j]->refillq = NULL;
@@ -1343,12 +1338,10 @@ static void idpf_txq_group_rel(struct idpf_q_vec_rsrc *rsrc)
  */
 static void idpf_rxq_sw_queue_rel(struct idpf_rxq_group *rx_qgrp)
 {
-	int i, j;
-
-	for (i = 0; i < rx_qgrp->splitq.num_bufq_sets; i++) {
+	for (unsigned int i = 0; i < rx_qgrp->splitq.num_bufq_sets; i++) {
 		struct idpf_bufq_set *bufq_set = &rx_qgrp->splitq.bufq_sets[i];
 
-		for (j = 0; j < bufq_set->num_refillqs; j++) {
+		for (unsigned int j = 0; j < bufq_set->num_refillqs; j++) {
 			kfree(bufq_set->refillqs[j].ring);
 			bufq_set->refillqs[j].ring = NULL;
 		}
@@ -1363,19 +1356,16 @@ static void idpf_rxq_sw_queue_rel(struct idpf_rxq_group *rx_qgrp)
  */
 static void idpf_rxq_group_rel(struct idpf_q_vec_rsrc *rsrc)
 {
-	int i;
-
 	if (!rsrc->rxq_grps)
 		return;
 
-	for (i = 0; i < rsrc->num_rxq_grp; i++) {
+	for (unsigned int i = 0; i < rsrc->num_rxq_grp; i++) {
 		struct idpf_rxq_group *rx_qgrp = &rsrc->rxq_grps[i];
 		u16 num_rxq;
-		int j;
 
 		if (idpf_is_queue_model_split(rsrc->rxq_model)) {
 			num_rxq = rx_qgrp->splitq.num_rxq_sets;
-			for (j = 0; j < num_rxq; j++) {
+			for (unsigned int j = 0; j < num_rxq; j++) {
 				kfree(rx_qgrp->splitq.rxq_sets[j]);
 				rx_qgrp->splitq.rxq_sets[j] = NULL;
 			}
@@ -1385,7 +1375,7 @@ static void idpf_rxq_group_rel(struct idpf_q_vec_rsrc *rsrc)
 			rx_qgrp->splitq.bufq_sets = NULL;
 		} else {
 			num_rxq = rx_qgrp->singleq.num_rxq;
-			for (j = 0; j < num_rxq; j++) {
+			for (unsigned int j = 0; j < num_rxq; j++) {
 				kfree(rx_qgrp->singleq.rxqs[j]);
 				rx_qgrp->singleq.rxqs[j] = NULL;
 			}
@@ -1444,7 +1434,7 @@ static int idpf_vport_init_fast_path_txqs(struct idpf_vport *vport,
 {
 	struct idpf_ptp_vport_tx_tstamp_caps *caps = vport->tx_tstamp_caps;
 	struct work_struct *tstamp_task = &vport->tstamp_task;
-	int i, j, k = 0;
+	int k = 0;
 
 	vport->txqs = kcalloc(rsrc->num_txq, sizeof(*vport->txqs),
 			      GFP_KERNEL);
@@ -1452,10 +1442,10 @@ static int idpf_vport_init_fast_path_txqs(struct idpf_vport *vport,
 		return -ENOMEM;
 
 	vport->num_txq = rsrc->num_txq;
-	for (i = 0; i < rsrc->num_txq_grp; i++) {
+	for (unsigned int i = 0; i < rsrc->num_txq_grp; i++) {
 		struct idpf_txq_group *tx_grp = &rsrc->txq_grps[i];
 
-		for (j = 0; j < tx_grp->num_txq; j++, k++) {
+		for (unsigned int j = 0; j < tx_grp->num_txq; j++, k++) {
 			vport->txqs[k] = tx_grp->txqs[j];
 			vport->txqs[k]->idx = k;
 
@@ -1533,7 +1523,6 @@ void idpf_vport_calc_num_q_desc(struct idpf_vport *vport,
 	u8 num_bufqs = rsrc->num_bufqs_per_qgrp;
 	u32 num_req_txq_desc, num_req_rxq_desc;
 	u16 idx = vport->idx;
-	int i;
 
 	config_data =  &vport->adapter->vport_config[idx]->user_config;
 	num_req_txq_desc = config_data->num_req_txq_desc;
@@ -1560,7 +1549,7 @@ void idpf_vport_calc_num_q_desc(struct idpf_vport *vport,
 	else
 		rsrc->rxq_desc_count = IDPF_DFLT_RX_Q_DESC_COUNT;
 
-	for (i = 0; i < num_bufqs; i++) {
+	for (unsigned int i = 0; i < num_bufqs; i++) {
 		if (!rsrc->bufq_desc_count[i])
 			rsrc->bufq_desc_count[i] =
 				IDPF_RX_BUFQ_DESC_COUNT(rsrc->rxq_desc_count,
@@ -1718,7 +1707,6 @@ static int idpf_txq_group_alloc(struct idpf_vport *vport,
 				u16 num_txq)
 {
 	bool split, flow_sch_en;
-	int i;
 
 	rsrc->txq_grps = kcalloc(rsrc->num_txq_grp,
 				 sizeof(*rsrc->txq_grps), GFP_KERNEL);
@@ -1729,22 +1717,21 @@ static int idpf_txq_group_alloc(struct idpf_vport *vport,
 	flow_sch_en = !idpf_is_cap_ena(vport->adapter, IDPF_OTHER_CAPS,
 				       VIRTCHNL2_CAP_SPLITQ_QSCHED);
 
-	for (i = 0; i < rsrc->num_txq_grp; i++) {
+	for (unsigned int i = 0; i < rsrc->num_txq_grp; i++) {
 		struct idpf_txq_group *tx_qgrp = &rsrc->txq_grps[i];
 		struct idpf_adapter *adapter = vport->adapter;
-		int j;
 
 		tx_qgrp->vport = vport;
 		tx_qgrp->num_txq = num_txq;
 
-		for (j = 0; j < tx_qgrp->num_txq; j++) {
+		for (unsigned int j = 0; j < tx_qgrp->num_txq; j++) {
 			tx_qgrp->txqs[j] = kzalloc(sizeof(*tx_qgrp->txqs[j]),
 						   GFP_KERNEL);
 			if (!tx_qgrp->txqs[j])
 				goto err_alloc;
 		}
 
-		for (j = 0; j < tx_qgrp->num_txq; j++) {
+		for (unsigned int j = 0; j < tx_qgrp->num_txq; j++) {
 			struct idpf_tx_queue *q = tx_qgrp->txqs[j];
 
 			q->dev = &adapter->pdev->dev;
@@ -1812,8 +1799,8 @@ static int idpf_rxq_group_alloc(struct idpf_vport *vport,
 				struct idpf_q_vec_rsrc *rsrc,
 				u16 num_rxq)
 {
-	int i, k, err = 0;
 	bool hs, rsc;
+	int err = 0;
 
 	rsrc->rxq_grps = kcalloc(rsrc->num_rxq_grp,
 				 sizeof(struct idpf_rxq_group), GFP_KERNEL);
@@ -1823,14 +1810,13 @@ static int idpf_rxq_group_alloc(struct idpf_vport *vport,
 	hs = idpf_vport_get_hsplit(vport) == ETHTOOL_TCP_DATA_SPLIT_ENABLED;
 	rsc = idpf_is_feature_ena(vport, NETIF_F_GRO_HW);
 
-	for (i = 0; i < rsrc->num_rxq_grp; i++) {
+	for (unsigned int i = 0; i < rsrc->num_rxq_grp; i++) {
 		struct idpf_rxq_group *rx_qgrp = &rsrc->rxq_grps[i];
-		int j;
 
 		rx_qgrp->vport = vport;
 		if (!idpf_is_queue_model_split(rsrc->rxq_model)) {
 			rx_qgrp->singleq.num_rxq = num_rxq;
-			for (j = 0; j < num_rxq; j++) {
+			for (unsigned int j = 0; j < num_rxq; j++) {
 				rx_qgrp->singleq.rxqs[j] =
 						kzalloc(sizeof(*rx_qgrp->singleq.rxqs[j]),
 							GFP_KERNEL);
@@ -1843,7 +1829,7 @@ static int idpf_rxq_group_alloc(struct idpf_vport *vport,
 		}
 		rx_qgrp->splitq.num_rxq_sets = num_rxq;
 
-		for (j = 0; j < num_rxq; j++) {
+		for (unsigned int j = 0; j < num_rxq; j++) {
 			rx_qgrp->splitq.rxq_sets[j] =
 				kzalloc(sizeof(struct idpf_rxq_set),
 					GFP_KERNEL);
@@ -1862,7 +1848,7 @@ static int idpf_rxq_group_alloc(struct idpf_vport *vport,
 		}
 		rx_qgrp->splitq.num_bufq_sets = rsrc->num_bufqs_per_qgrp;
 
-		for (j = 0; j < rsrc->num_bufqs_per_qgrp; j++) {
+		for (unsigned int j = 0; j < rsrc->num_bufqs_per_qgrp; j++) {
 			struct idpf_bufq_set *bufq_set =
 				&rx_qgrp->splitq.bufq_sets[j];
 			int swq_size = sizeof(struct idpf_sw_queue);
@@ -1882,7 +1868,7 @@ static int idpf_rxq_group_alloc(struct idpf_vport *vport,
 				err = -ENOMEM;
 				goto err_alloc;
 			}
-			for (k = 0; k < bufq_set->num_refillqs; k++) {
+			for (unsigned int k = 0; k < bufq_set->num_refillqs; k++) {
 				struct idpf_sw_queue *refillq =
 					&bufq_set->refillqs[k];
 
@@ -1901,7 +1887,7 @@ static int idpf_rxq_group_alloc(struct idpf_vport *vport,
 		}
 
 skip_splitq_rx_init:
-		for (j = 0; j < num_rxq; j++) {
+		for (unsigned int j = 0; j < num_rxq; j++) {
 			struct idpf_rx_queue *q;
 
 			if (!idpf_is_queue_model_split(rsrc->rxq_model)) {
@@ -4386,9 +4372,9 @@ static void idpf_vport_intr_map_vector_to_qs(struct idpf_vport *vport,
 	bool split = idpf_is_queue_model_split(rsrc->rxq_model);
 	struct idpf_rxq_group *rx_qgrp;
 	struct idpf_txq_group *tx_qgrp;
-	u32 i, qv_idx, q_index;
+	u32 q_index;
 
-	for (i = 0, qv_idx = 0; i < rsrc->num_rxq_grp; i++) {
+	for (unsigned int i = 0, qv_idx = 0; i < rsrc->num_rxq_grp; i++) {
 		u16 num_rxq;
 
 		if (qv_idx >= rsrc->num_q_vectors)
@@ -4433,7 +4419,7 @@ static void idpf_vport_intr_map_vector_to_qs(struct idpf_vport *vport,
 
 	split = idpf_is_queue_model_split(rsrc->txq_model);
 
-	for (i = 0, qv_idx = 0; i < num_txq_grp; i++) {
+	for (unsigned int i = 0, qv_idx = 0; i < num_txq_grp; i++) {
 		u16 num_txq;
 
 		if (qv_idx >= rsrc->num_q_vectors)
@@ -4460,7 +4446,7 @@ static void idpf_vport_intr_map_vector_to_qs(struct idpf_vport *vport,
 		qv_idx++;
 	}
 
-	for (i = 0; i < vport->num_xdp_txq; i++) {
+	for (unsigned int i = 0; i < vport->num_xdp_txq; i++) {
 		struct idpf_tx_queue *xdpsq;
 		struct idpf_q_vector *qv;
 
-- 
2.47.1


