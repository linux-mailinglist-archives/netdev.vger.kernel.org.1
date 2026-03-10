Return-Path: <netdev+bounces-266362-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDBSFjmWsGkukgIAu9opvQ
	(envelope-from <netdev+bounces-266362-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 23:07:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A42258B3D
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 23:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C7F231A475C
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C616E3F32A0;
	Tue, 10 Mar 2026 22:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ND/3E5Tk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181963F20F7;
	Tue, 10 Mar 2026 22:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773180402; cv=none; b=rpjJoD6FbMR+PHFW5a7GrJc7iH1d+U94zNUmCnZ9Mj3l3CxgBOKOPQbvJUDYDHkaq4a3PWz5C8pEMeZFcLFztdkNhyAa+Z/eE93PhPMl6EeI3uAirGC/1fkDxKR3DJoz/RQQbtOlGJIH4oIrfbt6wFg1wExADg4Vyqda+G9r+80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773180402; c=relaxed/simple;
	bh=OzYvNV9tkU8YrZnV0wRL5s5dpVf6Z/QISqntjwgMXIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUqGOPaO1jKcTbRpUmRlm+9tm77aLfAkhLVKXo4AL6YMhR4H28HEp5ZFAPnhM6o28XLwbi2YHDatIpSH9AdnH3tbm9S89LEo0d2cpPcEHd5usJjKOyY+k4u8tG8Y/Jz7/1m7HnDyO16QNszF0Z6vva2ipGcYnaofRsTsW04j5MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ND/3E5Tk; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773180395; x=1804716395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OzYvNV9tkU8YrZnV0wRL5s5dpVf6Z/QISqntjwgMXIw=;
  b=ND/3E5Tkinz8l7/V2qI9n0dWNqsbl2HCq1I5RE4RHN9DfVFN5fzLciKA
   HAD3hLLrMzRc3IvB0xbTVZ80eNkhV2SWHefwyS6jJEmXYTUOkWOSZj7hz
   HIEqa5y7JD2E4JI41lMOVSQFOvx5rERLEdsir7TXSsCujpPsOzz3ADwDn
   Ew0F4HkJtWmwx6QbruGPCefxqZ18lXKWCPDDwfMTbLyzWtBHc9VIVd/2W
   SfJWe3kdRC6pAkEcS7/IaJRNq28GxIxetE03IaOuollA23q0nrXkfSehS
   9mcBv4T8RYIEiEmj0u30dy39UeblCzPTvB/a28z55ZcmjrOWEjohGFeFZ
   Q==;
X-CSE-ConnectionGUID: dtQr0v/jTtG2ZFV6UyyGlQ==
X-CSE-MsgGUID: 0uehs9NsQICEAklv7o/ZUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74156366"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="74156366"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 15:06:28 -0700
X-CSE-ConnectionGUID: bkd7eK6iSCOxU0tGv065xA==
X-CSE-MsgGUID: uzpuIXw2TeK0lSQ8QlE1oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="220298604"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 10 Mar 2026 15:06:28 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	nxne.cnse.osdt.itp.upstreaming@intel.com,
	horms@kernel.org,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next 4/5] ice: implement Rx queue management ops
Date: Tue, 10 Mar 2026 15:06:21 -0700
Message-ID: <20260310220624.537917-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260310220624.537917-1-anthony.l.nguyen@intel.com>
References: <20260310220624.537917-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F1A42258B3D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266362-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Alexander Lobakin <aleksander.lobakin@intel.com>

Now ice is ready to get queue_mgmt_ops support. It already has API
to disable/reconfig/enable one particular queue (for XSk). Reuse as
much of its code as possible to implement Rx queue management
callbacks and vice versa -- ice_queue_mem_{alloc,free}() can be
reused during ifup/ifdown to elide code duplication.
With this, ice passes the io_uring zcrx selftests, meaning the Rx
part of netmem/MP support is done.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c   | 182 +++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_lib.h    |   5 +
 drivers/net/ethernet/intel/ice/ice_main.c   |   2 +-
 drivers/net/ethernet/intel/ice/ice_sf_eth.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c   |  26 ++-
 drivers/net/ethernet/intel/ice/ice_txrx.h   |   2 +
 6 files changed, 165 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 1add82d894bb..4e0b8895c303 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -653,6 +653,43 @@ static int ice_rxq_pp_create(struct ice_rx_ring *rq)
 	return err;
 }
 
+static int ice_queue_mem_alloc(struct net_device *dev,
+			       struct netdev_queue_config *qcfg,
+			       void *per_queue_mem, int idx)
+{
+	const struct ice_netdev_priv *priv = netdev_priv(dev);
+	const struct ice_rx_ring *real = priv->vsi->rx_rings[idx];
+	struct ice_rx_ring *new = per_queue_mem;
+	int ret;
+
+	new->count = real->count;
+	new->netdev = real->netdev;
+	new->q_index = real->q_index;
+	new->q_vector = real->q_vector;
+	new->vsi = real->vsi;
+
+	ret = ice_rxq_pp_create(new);
+	if (ret)
+		return ret;
+
+	if (!netif_running(dev))
+		return 0;
+
+	ret = __xdp_rxq_info_reg(&new->xdp_rxq, new->netdev, new->q_index,
+				 new->q_vector->napi.napi_id, new->truesize);
+	if (ret)
+		goto err_destroy_fq;
+
+	xdp_rxq_info_attach_page_pool(&new->xdp_rxq, new->pp);
+
+	return 0;
+
+err_destroy_fq:
+	ice_rxq_pp_destroy(new);
+
+	return ret;
+}
+
 /**
  * ice_vsi_cfg_rxq - Configure an Rx queue
  * @ring: the ring being configured
@@ -691,19 +728,10 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 			dev_info(dev, "Registered XDP mem model MEM_TYPE_XSK_BUFF_POOL on Rx ring %d\n",
 				 ring->q_index);
 		} else {
-			err = ice_rxq_pp_create(ring);
+			err = ice_queue_mem_alloc(ring->netdev, NULL, ring,
+						  ring->q_index);
 			if (err)
 				return err;
-
-			err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
-						 ring->q_index,
-						 ring->q_vector->napi.napi_id,
-						 ring->truesize);
-			if (err)
-				goto err_destroy_fq;
-
-			xdp_rxq_info_attach_page_pool(&ring->xdp_rxq,
-						      ring->pp);
 		}
 	}
 
@@ -712,7 +740,7 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 	if (err) {
 		dev_err(dev, "ice_setup_rx_ctx failed for RxQ %d, err %d\n",
 			ring->q_index, err);
-		goto err_destroy_fq;
+		goto err_clean_rq;
 	}
 
 	if (ring->xsk_pool) {
@@ -743,12 +771,12 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 		err = ice_alloc_rx_bufs(ring, num_bufs);
 
 	if (err)
-		goto err_destroy_fq;
+		goto err_clean_rq;
 
 	return 0;
 
-err_destroy_fq:
-	ice_rxq_pp_destroy(ring);
+err_clean_rq:
+	ice_clean_rx_ring(ring);
 
 	return err;
 }
@@ -1460,27 +1488,7 @@ static void ice_qp_reset_stats(struct ice_vsi *vsi, u16 q_idx)
 		       sizeof(vsi->xdp_rings[q_idx]->ring_stats->stats));
 }
 
-/**
- * ice_qp_clean_rings - Cleans all the rings of a given index
- * @vsi: VSI that contains rings of interest
- * @q_idx: ring index in array
- */
-static void ice_qp_clean_rings(struct ice_vsi *vsi, u16 q_idx)
-{
-	ice_clean_tx_ring(vsi->tx_rings[q_idx]);
-	if (vsi->xdp_rings)
-		ice_clean_tx_ring(vsi->xdp_rings[q_idx]);
-	ice_clean_rx_ring(vsi->rx_rings[q_idx]);
-}
-
-/**
- * ice_qp_dis - Disables a queue pair
- * @vsi: VSI of interest
- * @q_idx: ring index in array
- *
- * Returns 0 on success, negative on failure.
- */
-int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
+static int __ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 {
 	struct ice_txq_meta txq_meta = { };
 	struct ice_q_vector *q_vector;
@@ -1519,23 +1527,35 @@ int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 	}
 
 	ice_vsi_ctrl_one_rx_ring(vsi, false, q_idx, false);
-	ice_qp_clean_rings(vsi, q_idx);
 	ice_qp_reset_stats(vsi, q_idx);
 
+	ice_clean_tx_ring(vsi->tx_rings[q_idx]);
+	if (vsi->xdp_rings)
+		ice_clean_tx_ring(vsi->xdp_rings[q_idx]);
+
 	return fail;
 }
 
 /**
- * ice_qp_ena - Enables a queue pair
+ * ice_qp_dis - Disables a queue pair
  * @vsi: VSI of interest
  * @q_idx: ring index in array
  *
  * Returns 0 on success, negative on failure.
  */
-int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
+int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
+{
+	int ret;
+
+	ret = __ice_qp_dis(vsi, q_idx);
+	ice_clean_rx_ring(vsi->rx_rings[q_idx]);
+
+	return ret;
+}
+
+static int __ice_qp_ena(struct ice_vsi *vsi, u16 q_idx, int fail)
 {
 	struct ice_q_vector *q_vector;
-	int fail = 0;
 	bool link_up;
 	int err;
 
@@ -1553,10 +1573,6 @@ int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
 		ice_tx_xsk_pool(vsi, q_idx);
 	}
 
-	err = ice_vsi_cfg_single_rxq(vsi, q_idx);
-	if (!fail)
-		fail = err;
-
 	q_vector = vsi->rx_rings[q_idx]->q_vector;
 	ice_qvec_cfg_msix(vsi, q_vector, q_idx);
 
@@ -1577,3 +1593,81 @@ int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
 
 	return fail;
 }
+
+/**
+ * ice_qp_ena - Enables a queue pair
+ * @vsi: VSI of interest
+ * @q_idx: ring index in array
+ *
+ * Returns 0 on success, negative on failure.
+ */
+int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
+{
+	return __ice_qp_ena(vsi, q_idx, ice_vsi_cfg_single_rxq(vsi, q_idx));
+}
+
+static int ice_queue_start(struct net_device *dev,
+			   struct netdev_queue_config *qcfg,
+			   void *per_queue_mem, int idx)
+{
+	const struct ice_netdev_priv *priv = netdev_priv(dev);
+	struct ice_rx_ring *real = priv->vsi->rx_rings[idx];
+	struct ice_rx_ring *new = per_queue_mem;
+	struct napi_struct *napi;
+	int ret;
+
+	real->pp = new->pp;
+	real->rx_fqes = new->rx_fqes;
+	real->hdr_fqes = new->hdr_fqes;
+	real->hdr_pp = new->hdr_pp;
+
+	real->hdr_truesize = new->hdr_truesize;
+	real->truesize = new->truesize;
+	real->rx_hdr_len = new->rx_hdr_len;
+	real->rx_buf_len = new->rx_buf_len;
+
+	memcpy(&real->xdp_rxq, &new->xdp_rxq, sizeof(new->xdp_rxq));
+
+	ret = ice_setup_rx_ctx(real);
+	if (ret)
+		return ret;
+
+	napi = &real->q_vector->napi;
+
+	page_pool_enable_direct_recycling(real->pp, napi);
+	if (real->hdr_pp)
+		page_pool_enable_direct_recycling(real->hdr_pp, napi);
+
+	ret = ice_alloc_rx_bufs(real, ICE_DESC_UNUSED(real));
+
+	return __ice_qp_ena(priv->vsi, idx, ret);
+}
+
+static int ice_queue_stop(struct net_device *dev, void *per_queue_mem,
+			  int idx)
+{
+	const struct ice_netdev_priv *priv = netdev_priv(dev);
+	struct ice_rx_ring *real = priv->vsi->rx_rings[idx];
+	int ret;
+
+	ret = __ice_qp_dis(priv->vsi, idx);
+	if (ret)
+		return ret;
+
+	page_pool_disable_direct_recycling(real->pp);
+	if (real->hdr_pp)
+		page_pool_disable_direct_recycling(real->hdr_pp);
+
+	ice_zero_rx_ring(real);
+	memcpy(per_queue_mem, real, sizeof(*real));
+
+	return 0;
+}
+
+const struct netdev_queue_mgmt_ops ice_queue_mgmt_ops = {
+	.ndo_queue_mem_alloc	= ice_queue_mem_alloc,
+	.ndo_queue_mem_free	= ice_queue_mem_free,
+	.ndo_queue_mem_size	= sizeof(struct ice_rx_ring),
+	.ndo_queue_start	= ice_queue_start,
+	.ndo_queue_stop		= ice_queue_stop,
+};
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 0565374b58a5..f27415b50d8c 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -4,6 +4,8 @@
 #ifndef _ICE_LIB_H_
 #define _ICE_LIB_H_
 
+#include <net/netdev_queues.h>
+
 #include "ice.h"
 #include "ice_vlan.h"
 
@@ -134,4 +136,7 @@ void ice_clear_feature_support(struct ice_pf *pf, enum ice_feature f);
 void ice_init_feature_support(struct ice_pf *pf);
 bool ice_vsi_is_rx_queue_active(struct ice_vsi *vsi);
 void ice_vsi_update_l2tsel(struct ice_vsi *vsi, enum ice_l2tsel l2tsel);
+
+extern const struct netdev_queue_mgmt_ops ice_queue_mgmt_ops;
+
 #endif /* !_ICE_LIB_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index a8e2db6dc05a..489718c6f7fe 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3524,7 +3524,7 @@ static void ice_set_ops(struct ice_vsi *vsi)
 	}
 
 	netdev->netdev_ops = &ice_netdev_ops;
-	netdev->request_ops_lock = true;
+	netdev->queue_mgmt_ops = &ice_queue_mgmt_ops;
 	netdev->udp_tunnel_nic_info = &pf->hw.udp_tunnel_nic;
 	netdev->xdp_metadata_ops = &ice_xdp_md_ops;
 	ice_set_ethtool_ops(netdev);
diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
index a751782cd852..bd5eeb27d3f8 100644
--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
@@ -58,7 +58,7 @@ static int ice_sf_cfg_netdev(struct ice_dynamic_port *dyn_port,
 	eth_hw_addr_set(netdev, dyn_port->hw_addr);
 	ether_addr_copy(netdev->perm_addr, dyn_port->hw_addr);
 	netdev->netdev_ops = &ice_sf_netdev_ops;
-	netdev->request_ops_lock = true;
+	netdev->queue_mgmt_ops = &ice_queue_mgmt_ops;
 	SET_NETDEV_DEVLINK_PORT(netdev, devlink_port);
 
 	err = register_netdev(netdev);
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index a2cd4cf37734..59b2ab09b87a 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -530,17 +530,13 @@ void ice_rxq_pp_destroy(struct ice_rx_ring *rq)
 	rq->hdr_pp = NULL;
 }
 
-/**
- * ice_clean_rx_ring - Free Rx buffers
- * @rx_ring: ring to be cleaned
- */
-void ice_clean_rx_ring(struct ice_rx_ring *rx_ring)
+void ice_queue_mem_free(struct net_device *dev, void *per_queue_mem)
 {
-	u32 size;
+	struct ice_rx_ring *rx_ring = per_queue_mem;
 
 	if (rx_ring->xsk_pool) {
 		ice_xsk_clean_rx_ring(rx_ring);
-		goto rx_skip_free;
+		return;
 	}
 
 	/* ring already cleared, nothing to do */
@@ -569,8 +565,12 @@ void ice_clean_rx_ring(struct ice_rx_ring *rx_ring)
 	}
 
 	ice_rxq_pp_destroy(rx_ring);
+}
+
+void ice_zero_rx_ring(struct ice_rx_ring *rx_ring)
+{
+	size_t size;
 
-rx_skip_free:
 	/* Zero out the descriptor ring */
 	size = ALIGN(rx_ring->count * sizeof(union ice_32byte_rx_desc),
 		     PAGE_SIZE);
@@ -580,6 +580,16 @@ void ice_clean_rx_ring(struct ice_rx_ring *rx_ring)
 	rx_ring->next_to_use = 0;
 }
 
+/**
+ * ice_clean_rx_ring - Free Rx buffers
+ * @rx_ring: ring to be cleaned
+ */
+void ice_clean_rx_ring(struct ice_rx_ring *rx_ring)
+{
+	ice_queue_mem_free(rx_ring->netdev, rx_ring);
+	ice_zero_rx_ring(rx_ring);
+}
+
 /**
  * ice_free_rx_ring - Free Rx resources
  * @rx_ring: ring to clean the resources from
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index b6547e1b7c42..557b5e656bb0 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -458,6 +458,8 @@ u16
 ice_select_queue(struct net_device *dev, struct sk_buff *skb,
 		 struct net_device *sb_dev);
 void ice_clean_tx_ring(struct ice_tx_ring *tx_ring);
+void ice_queue_mem_free(struct net_device *dev, void *per_queue_mem);
+void ice_zero_rx_ring(struct ice_rx_ring *rx_ring);
 void ice_clean_rx_ring(struct ice_rx_ring *rx_ring);
 int ice_setup_tx_ring(struct ice_tx_ring *tx_ring);
 int ice_setup_rx_ring(struct ice_rx_ring *rx_ring);
-- 
2.47.1


