Return-Path: <netdev+bounces-252555-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGqlBrKmcmmMoQAAu9opvQ
	(envelope-from <netdev+bounces-252555-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 23:37:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EDB6E3AF
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 23:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FFBB302DF57
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 22:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075B03D7283;
	Thu, 22 Jan 2026 22:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hd4looIE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D5C3D726A
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 22:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769121391; cv=none; b=rIg/k17rzdU40GiuO/4G/PxO39buDPd9pnsCcqWWPGsrNUdHRt3D+APu7rrZPKzEQ5UcCwE79Ecseiq7QuzlqR03rXVsy6KiRVoSnz3YXNKHQD2qb62KvRMay4HoYo8+6QF62F4Chmb+wYmL/NErEXU4hlZ7LdjQ9QYox2CZMMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769121391; c=relaxed/simple;
	bh=9e82TwWiL8tW+ahEe2N9P07FCm5PmV/XUfHzYVveiqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Drs7OmOZ017Ccy+u6kxfFd6i+1ffRudPZ3VSUi1CxqaC4FZr5GqO2lr8uKhNWM3yoyR0liRKX5U4Pfszbe8zC59BRJm/Jcg4Iuiy/U9Xx1kwo/cUnzzu7ExockiNqePUf5jxjnNpW3ccRylgiZJaaitLBNKsZnYSTRh1y1zEfzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hd4looIE; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769121384; x=1800657384;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9e82TwWiL8tW+ahEe2N9P07FCm5PmV/XUfHzYVveiqc=;
  b=Hd4looIEcCpYHWvX2cukds1e7yivTouSSfYJvp2zpioAy2ChXWzIsnap
   aNqwhbC0fUUSSnqRsBN7IezfY2t9r6afhlJ7mKctkj/0RaqUronqdX7kQ
   WblnIrMKKnXGpnA3QGGBPEZ7P+bEY2vJlQgxih3RTMoJB1EAJadQztvkv
   RywptAS7edTW7mCp4nvEZ92IoP64RmZUOBCnLOVTlaLLsmTI5zCcEzRRo
   S16Olv/GqY6atuEOgSp1RY2XqZmTSVQ4Wdx/zHP1TR6lc9bKhF5g79raq
   YJA3u7Xx1FFviMUeUU8EtGIyxcXuSV/UDT9cTXR9BsCMMXzeuF0eBlwEx
   w==;
X-CSE-ConnectionGUID: 7De4+8lxQHCs4BJfLGlr2g==
X-CSE-MsgGUID: jk+1tu0WTWiElczOznUfpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="93039266"
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; 
   d="scan'208";a="93039266"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 14:36:08 -0800
X-CSE-ConnectionGUID: vybPmD8zTDW2GwFejYG36Q==
X-CSE-MsgGUID: H11Sl+LYRMq/Oi7ipI5a5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; 
   d="scan'208";a="206670457"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 22 Jan 2026 14:36:06 -0800
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
Subject: [PATCH net-next v2 07/10] idpf: remove vport pointer from queue sets
Date: Thu, 22 Jan 2026 14:35:53 -0800
Message-ID: <20260122223601.2208759-8-anthony.l.nguyen@intel.com>
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
	TAGGED_FROM(0.00)[bounces-252555-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 61EDB6E3AF
X-Rspamd-Action: no action

From: Joshua Hay <joshua.a.hay@intel.com>

Replace vport pointer in queue sets struct with adapter backpointer and
vport_id as those are the primary fields necessary for virtchnl
communication. Otherwise, pass the vport pointer as a separate parameter
where available. Also move xdp_txq_offset to queue vector resource
struct since we no longer have the vport pointer.

Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        |  4 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 41 +++++-----
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 80 ++++++++++---------
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  7 +-
 drivers/net/ethernet/intel/idpf/xdp.c         | 11 ++-
 drivers/net/ethernet/intel/idpf/xsk.c         |  5 +-
 6 files changed, 81 insertions(+), 67 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 9b6c61f494a2..8eb3e98a6e51 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -306,6 +306,7 @@ struct idpf_fsteer_fltr {
  * @num_txq: number of allocated TX queues
  * @num_complq: number of allocated completion queues
  * @num_txq_grp: number of TX queue groups
+ * @xdp_txq_offset: index of the first XDPSQ (== number of regular SQs)
  * @num_rxq_grp: number of RX queues in a group
  * @rxq_model: splitq queue or single queue queuing model
  * @rxq_grps: total number of RX groups. Number of groups * number of RX per
@@ -335,6 +336,7 @@ struct idpf_q_vec_rsrc {
 	u16			num_txq;
 	u16			num_complq;
 	u16			num_txq_grp;
+	u16			xdp_txq_offset;
 
 	u16			num_rxq_grp;
 	u32			rxq_model;
@@ -353,7 +355,6 @@ struct idpf_q_vec_rsrc {
  * @txqs: Used only in hotpath to get to the right queue very fast
  * @num_txq: Number of allocated TX queues
  * @num_xdp_txq: number of XDPSQs
- * @xdp_txq_offset: index of the first XDPSQ (== number of regular SQs)
  * @xdpsq_share: whether XDPSQ sharing is enabled
  * @xdp_prog: installed XDP program
  * @vdev_info: IDC vport device info pointer
@@ -384,7 +385,6 @@ struct idpf_vport {
 	struct idpf_tx_queue **txqs;
 	u16 num_txq;
 	u16 num_xdp_txq;
-	u16 xdp_txq_offset;
 	bool xdpsq_share;
 	struct bpf_prog *xdp_prog;
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index c97e20bbcd34..7dfeab013b4c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -961,9 +961,9 @@ static int idpf_rx_desc_alloc_all(struct idpf_vport *vport,
 	return err;
 }
 
-static int idpf_init_queue_set(const struct idpf_queue_set *qs)
+static int idpf_init_queue_set(const struct idpf_vport *vport,
+			       const struct idpf_queue_set *qs)
 {
-	const struct idpf_vport *vport = qs->vport;
 	bool splitq;
 	int err;
 
@@ -1115,7 +1115,8 @@ static void idpf_qvec_ena_irq(struct idpf_q_vector *qv)
 static struct idpf_queue_set *
 idpf_vector_to_queue_set(struct idpf_q_vector *qv)
 {
-	bool xdp = qv->vport->xdp_txq_offset && !qv->num_xsksq;
+	u32 xdp_txq_offset = qv->vport->dflt_qv_rsrc.xdp_txq_offset;
+	bool xdp = xdp_txq_offset && !qv->num_xsksq;
 	struct idpf_vport *vport = qv->vport;
 	struct idpf_queue_set *qs;
 	u32 num;
@@ -1125,7 +1126,8 @@ idpf_vector_to_queue_set(struct idpf_q_vector *qv)
 	if (!num)
 		return NULL;
 
-	qs = idpf_alloc_queue_set(vport, &vport->dflt_qv_rsrc, num);
+	qs = idpf_alloc_queue_set(vport->adapter, &vport->dflt_qv_rsrc,
+				  vport->vport_id, num);
 	if (!qs)
 		return NULL;
 
@@ -1151,12 +1153,12 @@ idpf_vector_to_queue_set(struct idpf_q_vector *qv)
 		qs->qs[num++].complq = qv->complq[i];
 	}
 
-	if (!vport->xdp_txq_offset)
+	if (!xdp_txq_offset)
 		goto finalize;
 
 	if (xdp) {
 		for (u32 i = 0; i < qv->num_rxq; i++) {
-			u32 idx = vport->xdp_txq_offset + qv->rx[i]->idx;
+			u32 idx = xdp_txq_offset + qv->rx[i]->idx;
 
 			qs->qs[num].type = VIRTCHNL2_QUEUE_TYPE_TX;
 			qs->qs[num++].txq = vport->txqs[idx];
@@ -1183,23 +1185,23 @@ idpf_vector_to_queue_set(struct idpf_q_vector *qv)
 	return qs;
 }
 
-static int idpf_qp_enable(const struct idpf_queue_set *qs, u32 qid)
+static int idpf_qp_enable(const struct idpf_vport *vport,
+			  const struct idpf_queue_set *qs, u32 qid)
 {
-	struct idpf_q_vec_rsrc *rsrc = qs->qv_rsrc;
-	struct idpf_vport *vport = qs->vport;
+	const struct idpf_q_vec_rsrc *rsrc = &vport->dflt_qv_rsrc;
 	struct idpf_q_vector *q_vector;
 	int err;
 
 	q_vector = idpf_find_rxq_vec(vport, qid);
 
-	err = idpf_init_queue_set(qs);
+	err = idpf_init_queue_set(vport, qs);
 	if (err) {
 		netdev_err(vport->netdev, "Could not initialize queues in pair %u: %pe\n",
 			   qid, ERR_PTR(err));
 		return err;
 	}
 
-	if (!vport->xdp_txq_offset)
+	if (!rsrc->xdp_txq_offset)
 		goto config;
 
 	q_vector->xsksq = kcalloc(DIV_ROUND_UP(rsrc->num_rxq_grp,
@@ -1246,9 +1248,9 @@ static int idpf_qp_enable(const struct idpf_queue_set *qs, u32 qid)
 	return 0;
 }
 
-static int idpf_qp_disable(const struct idpf_queue_set *qs, u32 qid)
+static int idpf_qp_disable(const struct idpf_vport *vport,
+			   const struct idpf_queue_set *qs, u32 qid)
 {
-	struct idpf_vport *vport = qs->vport;
 	struct idpf_q_vector *q_vector;
 	int err;
 
@@ -1293,7 +1295,8 @@ int idpf_qp_switch(struct idpf_vport *vport, u32 qid, bool en)
 	if (!qs)
 		return -ENOMEM;
 
-	return en ? idpf_qp_enable(qs, qid) : idpf_qp_disable(qs, qid);
+	return en ? idpf_qp_enable(vport, qs, qid) :
+		    idpf_qp_disable(vport, qs, qid);
 }
 
 /**
@@ -1491,12 +1494,12 @@ void idpf_vport_init_num_qs(struct idpf_vport *vport,
 
 	vport->xdp_prog = config_data->xdp_prog;
 	if (idpf_xdp_enabled(vport)) {
-		vport->xdp_txq_offset = config_data->num_req_tx_qs;
+		rsrc->xdp_txq_offset = config_data->num_req_tx_qs;
 		vport->num_xdp_txq = le16_to_cpu(vport_msg->num_tx_q) -
-				     vport->xdp_txq_offset;
+				     rsrc->xdp_txq_offset;
 		vport->xdpsq_share = libeth_xdpsq_shared(vport->num_xdp_txq);
 	} else {
-		vport->xdp_txq_offset = 0;
+		rsrc->xdp_txq_offset = 0;
 		vport->num_xdp_txq = 0;
 		vport->xdpsq_share = false;
 	}
@@ -4450,7 +4453,7 @@ static void idpf_vport_intr_map_vector_to_qs(struct idpf_vport *vport,
 		struct idpf_tx_queue *xdpsq;
 		struct idpf_q_vector *qv;
 
-		xdpsq = vport->txqs[vport->xdp_txq_offset + i];
+		xdpsq = vport->txqs[rsrc->xdp_txq_offset + i];
 		if (!idpf_queue_has(XSK, xdpsq))
 			continue;
 
@@ -4609,7 +4612,7 @@ int idpf_vport_intr_alloc(struct idpf_vport *vport,
 		if (!q_vector->complq)
 			goto error;
 
-		if (!vport->xdp_txq_offset)
+		if (!rsrc->xdp_txq_offset)
 			continue;
 
 		q_vector->xsksq = kcalloc(rxqs_per_vector,
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 434e77a05405..216e00404563 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -717,9 +717,8 @@ int idpf_recv_mb_msg(struct idpf_adapter *adapter)
 }
 
 struct idpf_chunked_msg_params {
-	u32			(*prepare_msg)(const struct idpf_vport *vport,
-					       void *buf, const void *pos,
-					       u32 num);
+	u32			(*prepare_msg)(u32 vport_id, void *buf,
+					       const void *pos, u32 num);
 
 	const void		*chunks;
 	u32			num_chunks;
@@ -728,11 +727,12 @@ struct idpf_chunked_msg_params {
 	u32			config_sz;
 
 	u32			vc_op;
+	u32			vport_id;
 };
 
-struct idpf_queue_set *idpf_alloc_queue_set(struct idpf_vport *vport,
+struct idpf_queue_set *idpf_alloc_queue_set(struct idpf_adapter *adapter,
 					    struct idpf_q_vec_rsrc *qv_rsrc,
-					    u32 num)
+					    u32 vport_id, u32 num)
 {
 	struct idpf_queue_set *qp;
 
@@ -740,8 +740,9 @@ struct idpf_queue_set *idpf_alloc_queue_set(struct idpf_vport *vport,
 	if (!qp)
 		return NULL;
 
-	qp->vport = vport;
+	qp->adapter = adapter;
 	qp->qv_rsrc = qv_rsrc;
+	qp->vport_id = vport_id;
 	qp->num = num;
 
 	return qp;
@@ -749,7 +750,7 @@ struct idpf_queue_set *idpf_alloc_queue_set(struct idpf_vport *vport,
 
 /**
  * idpf_send_chunked_msg - send VC message consisting of chunks
- * @vport: virtual port data structure
+ * @adapter: Driver specific private structure
  * @params: message params
  *
  * Helper function for preparing a message describing queues to be enabled
@@ -757,7 +758,7 @@ struct idpf_queue_set *idpf_alloc_queue_set(struct idpf_vport *vport,
  *
  * Return: the total size of the prepared message.
  */
-static int idpf_send_chunked_msg(struct idpf_vport *vport,
+static int idpf_send_chunked_msg(struct idpf_adapter *adapter,
 				 const struct idpf_chunked_msg_params *params)
 {
 	struct idpf_vc_xn_params xn_params = {
@@ -768,6 +769,7 @@ static int idpf_send_chunked_msg(struct idpf_vport *vport,
 	u32 num_chunks, num_msgs, buf_sz;
 	void *buf __free(kfree) = NULL;
 	u32 totqs = params->num_chunks;
+	u32 vid = params->vport_id;
 
 	num_chunks = min(IDPF_NUM_CHUNKS_PER_MSG(params->config_sz,
 						 params->chunk_sz), totqs);
@@ -786,10 +788,10 @@ static int idpf_send_chunked_msg(struct idpf_vport *vport,
 		memset(buf, 0, buf_sz);
 		xn_params.send_buf.iov_len = buf_sz;
 
-		if (params->prepare_msg(vport, buf, pos, num_chunks) != buf_sz)
+		if (params->prepare_msg(vid, buf, pos, num_chunks) != buf_sz)
 			return -EINVAL;
 
-		reply_sz = idpf_vc_xn_exec(vport->adapter, &xn_params);
+		reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
 		if (reply_sz < 0)
 			return reply_sz;
 
@@ -812,6 +814,7 @@ static int idpf_send_chunked_msg(struct idpf_vport *vport,
  */
 static int idpf_wait_for_marker_event_set(const struct idpf_queue_set *qs)
 {
+	struct net_device *netdev;
 	struct idpf_tx_queue *txq;
 	bool markers_rcvd = true;
 
@@ -820,6 +823,8 @@ static int idpf_wait_for_marker_event_set(const struct idpf_queue_set *qs)
 		case VIRTCHNL2_QUEUE_TYPE_TX:
 			txq = qs->qs[i].txq;
 
+			netdev = txq->netdev;
+
 			idpf_queue_set(SW_MARKER, txq);
 			idpf_wait_for_sw_marker_completion(txq);
 			markers_rcvd &= !idpf_queue_has(SW_MARKER, txq);
@@ -830,7 +835,7 @@ static int idpf_wait_for_marker_event_set(const struct idpf_queue_set *qs)
 	}
 
 	if (!markers_rcvd) {
-		netdev_warn(qs->vport->netdev,
+		netdev_warn(netdev,
 			    "Failed to receive marker packets\n");
 		return -ETIMEDOUT;
 	}
@@ -848,7 +853,8 @@ static int idpf_wait_for_marker_event(struct idpf_vport *vport)
 {
 	struct idpf_queue_set *qs __free(kfree) = NULL;
 
-	qs = idpf_alloc_queue_set(vport, &vport->dflt_qv_rsrc, vport->num_txq);
+	qs = idpf_alloc_queue_set(vport->adapter, &vport->dflt_qv_rsrc,
+				  vport->vport_id, vport->num_txq);
 	if (!qs)
 		return -ENOMEM;
 
@@ -1792,7 +1798,7 @@ static void idpf_fill_complq_config_chunk(const struct idpf_q_vec_rsrc *rsrc,
 
 /**
  * idpf_prepare_cfg_txqs_msg - prepare message to configure selected Tx queues
- * @vport: virtual port data structure
+ * @vport_id: ID of virtual port queues are associated with
  * @buf: buffer containing the message
  * @pos: pointer to the first chunk describing the tx queue
  * @num_chunks: number of chunks in the message
@@ -1802,13 +1808,12 @@ static void idpf_fill_complq_config_chunk(const struct idpf_q_vec_rsrc *rsrc,
  *
  * Return: the total size of the prepared message.
  */
-static u32 idpf_prepare_cfg_txqs_msg(const struct idpf_vport *vport,
-				     void *buf, const void *pos,
+static u32 idpf_prepare_cfg_txqs_msg(u32 vport_id, void *buf, const void *pos,
 				     u32 num_chunks)
 {
 	struct virtchnl2_config_tx_queues *ctq = buf;
 
-	ctq->vport_id = cpu_to_le32(vport->vport_id);
+	ctq->vport_id = cpu_to_le32(vport_id);
 	ctq->num_qinfo = cpu_to_le16(num_chunks);
 	memcpy(ctq->qinfo, pos, num_chunks * sizeof(*ctq->qinfo));
 
@@ -1829,6 +1834,7 @@ static int idpf_send_config_tx_queue_set_msg(const struct idpf_queue_set *qs)
 {
 	struct virtchnl2_txq_info *qi __free(kfree) = NULL;
 	struct idpf_chunked_msg_params params = {
+		.vport_id	= qs->vport_id,
 		.vc_op		= VIRTCHNL2_OP_CONFIG_TX_QUEUES,
 		.prepare_msg	= idpf_prepare_cfg_txqs_msg,
 		.config_sz	= sizeof(struct virtchnl2_config_tx_queues),
@@ -1851,7 +1857,7 @@ static int idpf_send_config_tx_queue_set_msg(const struct idpf_queue_set *qs)
 						      &qi[params.num_chunks++]);
 	}
 
-	return idpf_send_chunked_msg(qs->vport, &params);
+	return idpf_send_chunked_msg(qs->adapter, &params);
 }
 
 /**
@@ -1868,7 +1874,7 @@ static int idpf_send_config_tx_queues_msg(struct idpf_vport *vport,
 	u32 totqs = rsrc->num_txq + rsrc->num_complq;
 	u32 k = 0;
 
-	qs = idpf_alloc_queue_set(vport, rsrc, totqs);
+	qs = idpf_alloc_queue_set(vport->adapter, rsrc, vport->vport_id, totqs);
 	if (!qs)
 		return -ENOMEM;
 
@@ -1979,7 +1985,7 @@ static void idpf_fill_bufq_config_chunk(const struct idpf_q_vec_rsrc *rsrc,
 
 /**
  * idpf_prepare_cfg_rxqs_msg - prepare message to configure selected Rx queues
- * @vport: virtual port data structure
+ * @vport_id: ID of virtual port queues are associated with
  * @buf: buffer containing the message
  * @pos: pointer to the first chunk describing the rx queue
  * @num_chunks: number of chunks in the message
@@ -1989,13 +1995,12 @@ static void idpf_fill_bufq_config_chunk(const struct idpf_q_vec_rsrc *rsrc,
  *
  * Return: the total size of the prepared message.
  */
-static u32 idpf_prepare_cfg_rxqs_msg(const struct idpf_vport *vport,
-				     void *buf, const void *pos,
+static u32 idpf_prepare_cfg_rxqs_msg(u32 vport_id, void *buf, const void *pos,
 				     u32 num_chunks)
 {
 	struct virtchnl2_config_rx_queues *crq = buf;
 
-	crq->vport_id = cpu_to_le32(vport->vport_id);
+	crq->vport_id = cpu_to_le32(vport_id);
 	crq->num_qinfo = cpu_to_le16(num_chunks);
 	memcpy(crq->qinfo, pos, num_chunks * sizeof(*crq->qinfo));
 
@@ -2016,6 +2021,7 @@ static int idpf_send_config_rx_queue_set_msg(const struct idpf_queue_set *qs)
 {
 	struct virtchnl2_rxq_info *qi __free(kfree) = NULL;
 	struct idpf_chunked_msg_params params = {
+		.vport_id	= qs->vport_id,
 		.vc_op		= VIRTCHNL2_OP_CONFIG_RX_QUEUES,
 		.prepare_msg	= idpf_prepare_cfg_rxqs_msg,
 		.config_sz	= sizeof(struct virtchnl2_config_rx_queues),
@@ -2037,7 +2043,7 @@ static int idpf_send_config_rx_queue_set_msg(const struct idpf_queue_set *qs)
 						    &qi[params.num_chunks++]);
 	}
 
-	return idpf_send_chunked_msg(qs->vport, &params);
+	return idpf_send_chunked_msg(qs->adapter, &params);
 }
 
 /**
@@ -2055,7 +2061,7 @@ static int idpf_send_config_rx_queues_msg(struct idpf_vport *vport,
 	u32 totqs = rsrc->num_rxq + rsrc->num_bufq;
 	u32 k = 0;
 
-	qs = idpf_alloc_queue_set(vport, rsrc, totqs);
+	qs = idpf_alloc_queue_set(vport->adapter, rsrc, vport->vport_id, totqs);
 	if (!qs)
 		return -ENOMEM;
 
@@ -2098,7 +2104,7 @@ static int idpf_send_config_rx_queues_msg(struct idpf_vport *vport,
 /**
  * idpf_prepare_ena_dis_qs_msg - prepare message to enable/disable selected
  *				 queues
- * @vport: virtual port data structure
+ * @vport_id: ID of virtual port queues are associated with
  * @buf: buffer containing the message
  * @pos: pointer to the first chunk describing the queue
  * @num_chunks: number of chunks in the message
@@ -2108,13 +2114,12 @@ static int idpf_send_config_rx_queues_msg(struct idpf_vport *vport,
  *
  * Return: the total size of the prepared message.
  */
-static u32 idpf_prepare_ena_dis_qs_msg(const struct idpf_vport *vport,
-				       void *buf, const void *pos,
+static u32 idpf_prepare_ena_dis_qs_msg(u32 vport_id, void *buf, const void *pos,
 				       u32 num_chunks)
 {
 	struct virtchnl2_del_ena_dis_queues *eq = buf;
 
-	eq->vport_id = cpu_to_le32(vport->vport_id);
+	eq->vport_id = cpu_to_le32(vport_id);
 	eq->chunks.num_chunks = cpu_to_le16(num_chunks);
 	memcpy(eq->chunks.chunks, pos,
 	       num_chunks * sizeof(*eq->chunks.chunks));
@@ -2139,6 +2144,7 @@ static int idpf_send_ena_dis_queue_set_msg(const struct idpf_queue_set *qs,
 {
 	struct virtchnl2_queue_chunk *qc __free(kfree) = NULL;
 	struct idpf_chunked_msg_params params = {
+		.vport_id	= qs->vport_id,
 		.vc_op		= en ? VIRTCHNL2_OP_ENABLE_QUEUES :
 				       VIRTCHNL2_OP_DISABLE_QUEUES,
 		.prepare_msg	= idpf_prepare_ena_dis_qs_msg,
@@ -2180,7 +2186,7 @@ static int idpf_send_ena_dis_queue_set_msg(const struct idpf_queue_set *qs,
 		qc[i].start_queue_id = cpu_to_le32(qid);
 	}
 
-	return idpf_send_chunked_msg(qs->vport, &params);
+	return idpf_send_chunked_msg(qs->adapter, &params);
 }
 
 /**
@@ -2201,7 +2207,7 @@ static int idpf_send_ena_dis_queues_msg(struct idpf_vport *vport, bool en)
 	num_txq = rsrc->num_txq + rsrc->num_complq;
 	num_q = num_txq + rsrc->num_rxq + rsrc->num_bufq;
 
-	qs = idpf_alloc_queue_set(vport, rsrc, num_q);
+	qs = idpf_alloc_queue_set(vport->adapter, rsrc, vport->vport_id, num_q);
 	if (!qs)
 		return -ENOMEM;
 
@@ -2264,7 +2270,7 @@ static int idpf_send_ena_dis_queues_msg(struct idpf_vport *vport, bool en)
 /**
  * idpf_prep_map_unmap_queue_set_vector_msg - prepare message to map or unmap
  *					      queue set to the interrupt vector
- * @vport: virtual port data structure
+ * @vport_id: ID of virtual port queues are associated with
  * @buf: buffer containing the message
  * @pos: pointer to the first chunk describing the vector mapping
  * @num_chunks: number of chunks in the message
@@ -2275,13 +2281,12 @@ static int idpf_send_ena_dis_queues_msg(struct idpf_vport *vport, bool en)
  * Return: the total size of the prepared message.
  */
 static u32
-idpf_prep_map_unmap_queue_set_vector_msg(const struct idpf_vport *vport,
-					 void *buf, const void *pos,
-					 u32 num_chunks)
+idpf_prep_map_unmap_queue_set_vector_msg(u32 vport_id, void *buf,
+					 const void *pos, u32 num_chunks)
 {
 	struct virtchnl2_queue_vector_maps *vqvm = buf;
 
-	vqvm->vport_id = cpu_to_le32(vport->vport_id);
+	vqvm->vport_id = cpu_to_le32(vport_id);
 	vqvm->num_qv_maps = cpu_to_le16(num_chunks);
 	memcpy(vqvm->qv_maps, pos, num_chunks * sizeof(*vqvm->qv_maps));
 
@@ -2302,6 +2307,7 @@ idpf_send_map_unmap_queue_set_vector_msg(const struct idpf_queue_set *qs,
 {
 	struct virtchnl2_queue_vector *vqv __free(kfree) = NULL;
 	struct idpf_chunked_msg_params params = {
+		.vport_id	= qs->vport_id,
 		.vc_op		= map ? VIRTCHNL2_OP_MAP_QUEUE_VECTOR :
 					VIRTCHNL2_OP_UNMAP_QUEUE_VECTOR,
 		.prepare_msg	= idpf_prep_map_unmap_queue_set_vector_msg,
@@ -2372,7 +2378,7 @@ idpf_send_map_unmap_queue_set_vector_msg(const struct idpf_queue_set *qs,
 		vqv[i].itr_idx = cpu_to_le32(itr_idx);
 	}
 
-	return idpf_send_chunked_msg(qs->vport, &params);
+	return idpf_send_chunked_msg(qs->adapter, &params);
 }
 
 /**
@@ -2392,7 +2398,7 @@ int idpf_send_map_unmap_queue_vector_msg(struct idpf_vport *vport,
 	u32 num_q = rsrc->num_txq + rsrc->num_rxq;
 	u32 k = 0;
 
-	qs = idpf_alloc_queue_set(vport, rsrc, num_q);
+	qs = idpf_alloc_queue_set(vport->adapter, rsrc, vport->vport_id, num_q);
 	if (!qs)
 		return -ENOMEM;
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
index e35e1efa211c..3ae796040ac8 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
@@ -138,16 +138,17 @@ struct idpf_queue_ptr {
 };
 
 struct idpf_queue_set {
-	struct idpf_vport		*vport;
+	struct idpf_adapter		*adapter;
 	struct idpf_q_vec_rsrc		*qv_rsrc;
+	u32				vport_id;
 
 	u32				num;
 	struct idpf_queue_ptr		qs[] __counted_by(num);
 };
 
-struct idpf_queue_set *idpf_alloc_queue_set(struct idpf_vport *vport,
+struct idpf_queue_set *idpf_alloc_queue_set(struct idpf_adapter *adapter,
 					    struct idpf_q_vec_rsrc *rsrc,
-					    u32 num);
+					    u32 vport_id, u32 num);
 
 int idpf_send_enable_queue_set_msg(const struct idpf_queue_set *qs);
 int idpf_send_disable_queue_set_msg(const struct idpf_queue_set *qs);
diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
index 2b411bf5184f..0fe435fdbb6c 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.c
+++ b/drivers/net/ethernet/intel/idpf/xdp.c
@@ -74,7 +74,7 @@ static int __idpf_xdp_rxq_info_init(struct idpf_rx_queue *rxq, void *arg)
 	if (!split)
 		return 0;
 
-	rxq->xdpsqs = &vport->txqs[vport->xdp_txq_offset];
+	rxq->xdpsqs = &vport->txqs[rsrc->xdp_txq_offset];
 	rxq->num_xdp_txq = vport->num_xdp_txq;
 
 	return 0;
@@ -169,7 +169,7 @@ int idpf_xdpsqs_get(const struct idpf_vport *vport)
 	}
 
 	dev = vport->netdev;
-	sqs = vport->xdp_txq_offset;
+	sqs = vport->dflt_qv_rsrc.xdp_txq_offset;
 
 	for (u32 i = sqs; i < vport->num_txq; i++) {
 		struct idpf_tx_queue *xdpsq = vport->txqs[i];
@@ -206,7 +206,7 @@ void idpf_xdpsqs_put(const struct idpf_vport *vport)
 		return;
 
 	dev = vport->netdev;
-	sqs = vport->xdp_txq_offset;
+	sqs = vport->dflt_qv_rsrc.xdp_txq_offset;
 
 	for (u32 i = sqs; i < vport->num_txq; i++) {
 		struct idpf_tx_queue *xdpsq = vport->txqs[i];
@@ -362,12 +362,15 @@ int idpf_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
 {
 	const struct idpf_netdev_priv *np = netdev_priv(dev);
 	const struct idpf_vport *vport = np->vport;
+	u32 xdp_txq_offset;
 
 	if (unlikely(!netif_carrier_ok(dev) || !vport->link_up))
 		return -ENETDOWN;
 
+	xdp_txq_offset = vport->dflt_qv_rsrc.xdp_txq_offset;
+
 	return libeth_xdp_xmit_do_bulk(dev, n, frames, flags,
-				       &vport->txqs[vport->xdp_txq_offset],
+				       &vport->txqs[xdp_txq_offset],
 				       vport->num_xdp_txq,
 				       idpf_xdp_xmit_flush_bulk,
 				       idpf_xdp_tx_finalize);
diff --git a/drivers/net/ethernet/intel/idpf/xsk.c b/drivers/net/ethernet/intel/idpf/xsk.c
index e4768ec07336..676cbd80774d 100644
--- a/drivers/net/ethernet/intel/idpf/xsk.c
+++ b/drivers/net/ethernet/intel/idpf/xsk.c
@@ -62,7 +62,7 @@ static void idpf_xsk_setup_txq(const struct idpf_vport *vport,
 	if (!idpf_queue_has(XDP, txq))
 		return;
 
-	qid = txq->idx - vport->xdp_txq_offset;
+	qid = txq->idx - vport->dflt_qv_rsrc.xdp_txq_offset;
 
 	pool = xsk_get_pool_from_qid(vport->netdev, qid);
 	if (!pool || !pool->dev)
@@ -87,7 +87,8 @@ static void idpf_xsk_setup_complq(const struct idpf_vport *vport,
 	if (!idpf_queue_has(XDP, complq))
 		return;
 
-	qid = complq->txq_grp->txqs[0]->idx - vport->xdp_txq_offset;
+	qid = complq->txq_grp->txqs[0]->idx -
+		vport->dflt_qv_rsrc.xdp_txq_offset;
 
 	pool = xsk_get_pool_from_qid(vport->netdev, qid);
 	if (!pool || !pool->dev)
-- 
2.47.1


