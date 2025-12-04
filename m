Return-Path: <netdev+bounces-243597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 407A2CA45BC
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 16:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A2E430E1D4F
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 15:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063972ECEA3;
	Thu,  4 Dec 2025 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QzwMnKz8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F2E2EC097;
	Thu,  4 Dec 2025 15:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764863526; cv=none; b=rYYiAoXVfEkwABvkOZj/t2Ln+Kc52f4MoF6ARQEG9dbAyEEuAwUWIxQuRoiWRcxSRk7T9RJ0tPspEPG/MTe5xnEGL8o8R+/0igaC1ysUcpe63BNc/ZUVqKyf88T1+Xyj4DjnpkCZjGCQ0jcMb5WGQ1NMlx+P4mSPWztCowAJFv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764863526; c=relaxed/simple;
	bh=aHgkVsO3gsi7K2qAzrJew/v3oAF8iandu5cOkJl4aXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dT4T2ZgZAOWzGLe97xSs67sKAbX7orrCm3UCIzvXJbgaaCHqOtNG3Gn8t8Xs/oG5+iA/xA0WsYd73WunXCbvqn7LHGAMOQrRo/zNPHYX2u3ynZ8glkGO2QXH1w/lDs877LxCkRX6FKOflukpcdQ2YGEeyilqwpsfMzTu42FfB84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QzwMnKz8; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764863525; x=1796399525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aHgkVsO3gsi7K2qAzrJew/v3oAF8iandu5cOkJl4aXE=;
  b=QzwMnKz8MiMGUsOVE6xmM9zGgq49lRRSlh3VZOKDDtui5lfntvegWX1Z
   nagJEh9TfnrUliQZ7ah/zwniKIBM3xGd4ztq2T9JMqY64D1yNcr24EQW+
   rIOJznGhO/jeO1xKJ3PDv20xqMERZhUeWb+B+jTb1AFiZAm3v7G9YRrJH
   4mEbmRnRUl8I4og+YOY8Dx26blG/bjHR2r2GWx/Z73tKfg/DSKifOwuss
   T9tlermzwD0I2hmD4QC2Q2dhY3e1oqh5O6kW7Rloeo1SNi0KDy0W8wo4+
   XxEZOO8DdLYAXRzt5eEGhghpu680qZZ5O+yhL58I12s/ukNjVBT4Yq6ci
   A==;
X-CSE-ConnectionGUID: oeEwYYoVQsuCJGRXVam/gQ==
X-CSE-MsgGUID: 7gGVc7HESL+h48mml3nPLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="92365159"
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; 
   d="scan'208";a="92365159"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 07:52:04 -0800
X-CSE-ConnectionGUID: ujarOcRDS4G3lmuKhB3dbA==
X-CSE-MsgGUID: uLdY3ruGQOeUew6qxB1+ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; 
   d="scan'208";a="194677297"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa007.fm.intel.com with ESMTP; 04 Dec 2025 07:52:01 -0800
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
Subject: [PATCH iwl-next v2 5/5] ice: add support for transmitting unreadable frags
Date: Thu,  4 Dec 2025 16:51:33 +0100
Message-ID: <20251204155133.2437621-6-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251204155133.2437621-1-aleksander.lobakin@intel.com>
References: <20251204155133.2437621-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Advertise netmem Tx support in ice. The only change needed is to set
ICE_TX_BUF_FRAG conditionally, only when skb_frag_is_net_iov() is
false. Otherwise, the Tx buffer type will be ICE_TX_BUF_EMPTY and
the driver will skip the DMA unmapping operation.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c   |  1 +
 drivers/net/ethernet/intel/ice/ice_sf_eth.c |  1 +
 drivers/net/ethernet/intel/ice/ice_txrx.c   | 17 +++++++++++++----
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 25e9091ca309..66601b1b7fec 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3524,6 +3524,7 @@ static void ice_set_ops(struct ice_vsi *vsi)
 
 	netdev->netdev_ops = &ice_netdev_ops;
 	netdev->queue_mgmt_ops = &ice_queue_mgmt_ops;
+	netdev->netmem_tx = true;
 	netdev->udp_tunnel_nic_info = &pf->hw.udp_tunnel_nic;
 	netdev->xdp_metadata_ops = &ice_xdp_md_ops;
 	ice_set_ethtool_ops(netdev);
diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
index 41e1606a8222..51ad13c9d7f9 100644
--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
@@ -59,6 +59,7 @@ static int ice_sf_cfg_netdev(struct ice_dynamic_port *dyn_port,
 	ether_addr_copy(netdev->perm_addr, dyn_port->hw_addr);
 	netdev->netdev_ops = &ice_sf_netdev_ops;
 	netdev->queue_mgmt_ops = &ice_queue_mgmt_ops;
+	netdev->netmem_tx = true;
 	SET_NETDEV_DEVLINK_PORT(netdev, devlink_port);
 
 	err = register_netdev(netdev);
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index b6f56cb81f93..e8e1acbd5a7d 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -113,11 +113,17 @@ ice_prgm_fdir_fltr(struct ice_vsi *vsi, struct ice_fltr_desc *fdir_desc,
 static void
 ice_unmap_and_free_tx_buf(struct ice_tx_ring *ring, struct ice_tx_buf *tx_buf)
 {
-	if (tx_buf->type != ICE_TX_BUF_XDP_TX && dma_unmap_len(tx_buf, len))
+	switch (tx_buf->type) {
+	case ICE_TX_BUF_DUMMY:
+	case ICE_TX_BUF_FRAG:
+	case ICE_TX_BUF_SKB:
+	case ICE_TX_BUF_XDP_XMIT:
 		dma_unmap_page(ring->dev,
 			       dma_unmap_addr(tx_buf, dma),
 			       dma_unmap_len(tx_buf, len),
 			       DMA_TO_DEVICE);
+		break;
+	}
 
 	switch (tx_buf->type) {
 	case ICE_TX_BUF_DUMMY:
@@ -337,12 +343,14 @@ static bool ice_clean_tx_irq(struct ice_tx_ring *tx_ring, int napi_budget)
 			}
 
 			/* unmap any remaining paged data */
-			if (dma_unmap_len(tx_buf, len)) {
+			if (tx_buf->type != ICE_TX_BUF_EMPTY) {
 				dma_unmap_page(tx_ring->dev,
 					       dma_unmap_addr(tx_buf, dma),
 					       dma_unmap_len(tx_buf, len),
 					       DMA_TO_DEVICE);
+
 				dma_unmap_len_set(tx_buf, len, 0);
+				tx_buf->type = ICE_TX_BUF_EMPTY;
 			}
 		}
 		ice_trace(clean_tx_irq_unmap_eop, tx_ring, tx_desc, tx_buf);
@@ -1493,7 +1501,8 @@ ice_tx_map(struct ice_tx_ring *tx_ring, struct ice_tx_buf *first,
 				       DMA_TO_DEVICE);
 
 		tx_buf = &tx_ring->tx_buf[i];
-		tx_buf->type = ICE_TX_BUF_FRAG;
+		if (!skb_frag_is_net_iov(frag))
+			tx_buf->type = ICE_TX_BUF_FRAG;
 	}
 
 	/* record SW timestamp if HW timestamp is not available */
@@ -2368,7 +2377,7 @@ void ice_clean_ctrl_tx_irq(struct ice_tx_ring *tx_ring)
 		}
 
 		/* unmap the data header */
-		if (dma_unmap_len(tx_buf, len))
+		if (tx_buf->type != ICE_TX_BUF_EMPTY)
 			dma_unmap_single(tx_ring->dev,
 					 dma_unmap_addr(tx_buf, dma),
 					 dma_unmap_len(tx_buf, len),
-- 
2.52.0


