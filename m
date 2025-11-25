Return-Path: <netdev+bounces-241594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B84C863D8
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 18:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 97A0B353387
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 17:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA77932D0ED;
	Tue, 25 Nov 2025 17:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WViJ3pr9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BB932C95B;
	Tue, 25 Nov 2025 17:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764092211; cv=none; b=C6Dk1nadBBG0cKwMQncnGL5TrrwHviKVEOQw7Tbj3pfs5A4lw7Sso8pDqcKCVAChbMqYYOuyOMANJHBDaWYv+Y0j+SBl1HPRsp/0jkH7FXEAGF8D43RQlL0cYfZN50ItvpsmspAEtdnCvE8LEuRdx2THeTB3ztcgrMsyBcnUxG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764092211; c=relaxed/simple;
	bh=h2pk/dERUPYTRmIq07kM949YUqsGfjYiE9oKHWqOD+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hv72A91wMpY9scoIVxNP0Iiroio83nlPrmRjxRmniiz53h14CBV2D5XU1DddPLgCpj6WyT/Drr3eHsy0iLopYptMxRBoqe4OiiPc3wGnitGE8ZP0d+0ioyGR+I3l/Cl1wo/EFPlQBEx0MoIkXyR1DbOTIDt/KHZR+ox4ukzVJkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WViJ3pr9; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764092210; x=1795628210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h2pk/dERUPYTRmIq07kM949YUqsGfjYiE9oKHWqOD+E=;
  b=WViJ3pr9n82mUkzlRpWn5XwWPE87U7aqMT9xeU5vjNzDkapXoRcZgSBY
   MU5bM06hjEa+B28eNViw6MMPmRtEyWPUgDz7oa2jknBineJyoCPHYBn6W
   4tZIIUHXjAPNK7Ny9N4/V/Sp2cfj0juQTexLd1qQiwbg1BBI5BeDaiES2
   w4C5Cj2DpaCu2hFuGGrvY28M38Cv2UXisGonJWh/9uXGVMU7Ooc+8jYl1
   g50VyGbF/SULIUK6Gcg2U95fyJMZ/NbgfxKM7JBF51xJbwQV2iIJWWuDI
   S/yzeE//ZrDvF1eEnYe1uG6+w/oizHcGxL8RblHsq12BQOnW1HJQ+906Q
   Q==;
X-CSE-ConnectionGUID: 8vDEJgH1SmCD1oeVaYqENA==
X-CSE-MsgGUID: X2DKcc6fR7SfV1Mxj2uznQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="69979913"
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="69979913"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 09:36:48 -0800
X-CSE-ConnectionGUID: 1q3t7kDdQLisWBQOuAmOQA==
X-CSE-MsgGUID: +Icz3oWHRiWspliIUfUkjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="216040420"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa002.fm.intel.com with ESMTP; 25 Nov 2025 09:36:45 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	nxne.cnse.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next 4/5] ice: implement Rx queue management ops
Date: Tue, 25 Nov 2025 18:36:02 +0100
Message-ID: <20251125173603.3834486-5-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251125173603.3834486-1-aleksander.lobakin@intel.com>
References: <20251125173603.3834486-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 drivers/net/ethernet/intel/ice/ice_lib.h    |   5 +
 drivers/net/ethernet/intel/ice/ice_txrx.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_base.c   | 192 ++++++++++++++------
 drivers/net/ethernet/intel/ice/ice_main.c   |   2 +-
 drivers/net/ethernet/intel/ice/ice_sf_eth.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c   |  26 ++-
 6 files changed, 163 insertions(+), 66 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index d9c94c06c657..781319f70118 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -4,6 +4,8 @@
 #ifndef _ICE_LIB_H_
 #define _ICE_LIB_H_
 
+#include <net/netdev_queues.h>
+
 #include "ice.h"
 #include "ice_vlan.h"
 
@@ -126,4 +128,7 @@ void ice_clear_feature_support(struct ice_pf *pf, enum ice_feature f);
 void ice_init_feature_support(struct ice_pf *pf);
 bool ice_vsi_is_rx_queue_active(struct ice_vsi *vsi);
 void ice_vsi_update_l2tsel(struct ice_vsi *vsi, enum ice_l2tsel l2tsel);
+
+extern const struct netdev_queue_mgmt_ops ice_queue_mgmt_ops;
+
 #endif /* !_ICE_LIB_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index e440c55d9e9f..f741301c28b6 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -409,6 +409,8 @@ u16
 ice_select_queue(struct net_device *dev, struct sk_buff *skb,
 		 struct net_device *sb_dev);
 void ice_clean_tx_ring(struct ice_tx_ring *tx_ring);
+void ice_queue_mem_free(struct net_device *dev, void *per_queue_mem);
+void ice_zero_rx_ring(struct ice_rx_ring *rx_ring);
 void ice_clean_rx_ring(struct ice_rx_ring *rx_ring);
 int ice_setup_tx_ring(struct ice_tx_ring *tx_ring);
 int ice_setup_rx_ring(struct ice_rx_ring *rx_ring);
diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 1aa40f13947e..77d09dc6a48d 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -651,6 +651,42 @@ static int ice_rxq_pp_create(struct ice_rx_ring *rq)
 	return err;
 }
 
+static int ice_queue_mem_alloc(struct net_device *dev, void *per_queue_mem,
+			       int idx)
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
+				 new->q_vector->napi.napi_id, new->rx_buf_len);
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
@@ -665,23 +701,12 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 	int err;
 
 	if (ring->vsi->type == ICE_VSI_PF || ring->vsi->type == ICE_VSI_SF) {
-		if (!xdp_rxq_info_is_reg(&ring->xdp_rxq)) {
-			err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
-						 ring->q_index,
-						 ring->q_vector->napi.napi_id,
-						 ring->rx_buf_len);
-			if (err)
-				return err;
-		}
-
 		ice_rx_xsk_pool(ring);
 		err = ice_realloc_rx_xdp_bufs(ring, ring->xsk_pool);
 		if (err)
 			return err;
 
 		if (ring->xsk_pool) {
-			xdp_rxq_info_unreg(&ring->xdp_rxq);
-
 			rx_buf_len =
 				xsk_pool_get_rx_frame_size(ring->xsk_pool);
 			err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
@@ -700,20 +725,10 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 			dev_info(dev, "Registered XDP mem model MEM_TYPE_XSK_BUFF_POOL on Rx ring %d\n",
 				 ring->q_index);
 		} else {
-			err = ice_rxq_pp_create(ring);
+			err = ice_queue_mem_alloc(ring->netdev, ring,
+						  ring->q_index);
 			if (err)
 				return err;
-
-			if (!xdp_rxq_info_is_reg(&ring->xdp_rxq)) {
-				err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
-							 ring->q_index,
-							 ring->q_vector->napi.napi_id,
-							 ring->rx_buf_len);
-				if (err)
-					goto err_destroy_fq;
-			}
-			xdp_rxq_info_attach_page_pool(&ring->xdp_rxq,
-						      ring->pp);
 		}
 	}
 
@@ -722,7 +737,7 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 	if (err) {
 		dev_err(dev, "ice_setup_rx_ctx failed for RxQ %d, err %d\n",
 			ring->q_index, err);
-		goto err_destroy_fq;
+		goto err_clean_rq;
 	}
 
 	if (ring->xsk_pool) {
@@ -753,12 +768,12 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
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
@@ -1425,27 +1440,7 @@ static void ice_qp_reset_stats(struct ice_vsi *vsi, u16 q_idx)
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
@@ -1484,23 +1479,35 @@ int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
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
 
@@ -1518,10 +1525,6 @@ int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
 		ice_tx_xsk_pool(vsi, q_idx);
 	}
 
-	err = ice_vsi_cfg_single_rxq(vsi, q_idx);
-	if (!fail)
-		fail = err;
-
 	q_vector = vsi->rx_rings[q_idx]->q_vector;
 	ice_qvec_cfg_msix(vsi, q_vector, q_idx);
 
@@ -1542,3 +1545,80 @@ int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
 
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
+static int ice_queue_start(struct net_device *dev, void *per_queue_mem,
+			   int idx)
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
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index c0432182b482..9eb27a0d984b 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3523,7 +3523,7 @@ static void ice_set_ops(struct ice_vsi *vsi)
 	}
 
 	netdev->netdev_ops = &ice_netdev_ops;
-	netdev->request_ops_lock = true;
+	netdev->queue_mgmt_ops = &ice_queue_mgmt_ops;
 	netdev->udp_tunnel_nic_info = &pf->hw.udp_tunnel_nic;
 	netdev->xdp_metadata_ops = &ice_xdp_md_ops;
 	ice_set_ethtool_ops(netdev);
diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
index 2c3db1b03055..41e1606a8222 100644
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
index ad76768a4232..b00fa436472d 100644
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
@@ -567,8 +563,12 @@ void ice_clean_rx_ring(struct ice_rx_ring *rx_ring)
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
@@ -579,6 +579,16 @@ void ice_clean_rx_ring(struct ice_rx_ring *rx_ring)
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
-- 
2.51.1


