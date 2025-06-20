Return-Path: <netdev+bounces-199847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CCEAE209F
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 19:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7434E3B72ED
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 17:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948811AA7BF;
	Fri, 20 Jun 2025 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mL3rVK6o"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E8FA930
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750439758; cv=none; b=Fspr4NnYDQy0+4Du3vjh9Eb1CdSOvJywf95NHipVIFABKXuV37U026jCWodpsdKmFUay/BK6GKo7eBpmV4XEbx6e0rOvBDD3sBHYBCeNLlpjw+GQ79MwK9H9lwgrihYtIrmAcXnfkMeIZNtrJ8+73eIyqwAsSSVU8pufqjM1vK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750439758; c=relaxed/simple;
	bh=12W0ZR+4pCI8ZVLHl0FFNTCmWkoM2S9vQhdIYiHJutU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MomyofkE6c2dMmGmRoXPeiKPOt8dN2oTruyZ3Js5AQoub7cY0PNBZx+YTg4w9mgJpQMFzEVD5oD5Vel7tIzJAXRkbIaBcnE5mlPyAbkef2/QCLKW5Wc++BjXytK4EfJvt7F/RaYy5rv4IT/t56KOFn89cKLKH1mDnai79/rDPAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mL3rVK6o; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750439757; x=1781975757;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=12W0ZR+4pCI8ZVLHl0FFNTCmWkoM2S9vQhdIYiHJutU=;
  b=mL3rVK6oOs6Z4PN4DXW6AZXsjnHQ96WVGq1ZF0cHxitYPq0n+uuCBu5c
   AS9dMM3SdoQj5kLg/Bv3DDUpCcoEZVTOZbnmQ2OMSL5Yf9NOXYa5EpZvy
   IxVYrLWlORom8+WihFb8D2waO4uiT0nI9xCnLiaj3EAiBrBHbYcUklusM
   cwJjgTOSfg3Q5fdEmJfSNCkPeIMPJ0g2XyryMnuzmb/8marbxKcOQMe9v
   V9oGJqDoTqSoHh9PlYSFDGeklt4sOBxdV3xnjv7iYEwuAkzci22++6Y7U
   QDtYZDOwbGVKNhq0gbkD6Gx1gOaqXkuu/ui297kcl8qwnaZclYopZpRZj
   A==;
X-CSE-ConnectionGUID: JtR0FYyLR6e5TMICZpTQaQ==
X-CSE-MsgGUID: BcN0q7uERtyjrhuXI2U0kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="63319132"
X-IronPort-AV: E=Sophos;i="6.16,252,1744095600"; 
   d="scan'208";a="63319132"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 10:15:56 -0700
X-CSE-ConnectionGUID: Jb7UL1fLQvam+xCkIIAJ2w==
X-CSE-MsgGUID: GSSCs/JhR0K5dybLFAunlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,252,1744095600"; 
   d="scan'208";a="150561270"
Received: from bkammerd-mobl.amr.corp.intel.com (HELO azaki-desk1.intel.com) ([10.124.221.233])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 10:15:54 -0700
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>
Subject: [PATCH iwl-next] idpf: preserve coalescing settings across resets
Date: Fri, 20 Jun 2025 11:15:48 -0600
Message-ID: <20250620171548.959863-1-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IRQ coalescing config currently reside only inside struct
idpf_q_vector. However, all idpf_q_vector structs are de-allocated and
re-allocated during resets. This leads to user-set coalesce configuration
to be lost.

Add new fields to struct idpf_vport_user_config_data to save the user
settings and re-apply them after reset.

Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        | 19 ++++++++++
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 36 ++++++++++++++-----
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 19 ++++++++--
 drivers/net/ethernet/intel/idpf/idpf_main.c   |  1 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 13 ++++---
 5 files changed, 74 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index aa2e97e2cd32..1f7127f3324c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -396,10 +396,28 @@ struct idpf_rss_data {
 	u32 *cached_lut;
 };
 
+/**
+ * struct idpf_q_coalesce - User defined coalescing configuration values for
+ *			   a single queue.
+ * @tx_intr_mode: Dynamic TX ITR or not
+ * @rx_intr_mode: Dynamic RX ITR or not
+ * @tx_coalesce_usecs: TX interrupt throttling rate
+ * @rx_coalesce_usecs: RX interrupt throttling rate
+ *
+ * Used to restore user coalescing configuration after a reset.
+ */
+struct idpf_q_coalesce {
+	u32 tx_intr_mode;
+	u32 rx_intr_mode;
+	u32 tx_coalesce_usecs;
+	u32 rx_coalesce_usecs;
+};
+
 /**
  * struct idpf_vport_user_config_data - User defined configuration values for
  *					each vport.
  * @rss_data: See struct idpf_rss_data
+ * @q_coalesce: Array of per queue coalescing data
  * @num_req_tx_qs: Number of user requested TX queues through ethtool
  * @num_req_rx_qs: Number of user requested RX queues through ethtool
  * @num_req_txq_desc: Number of user requested TX queue descriptors through
@@ -415,6 +433,7 @@ struct idpf_rss_data {
  */
 struct idpf_vport_user_config_data {
 	struct idpf_rss_data rss_data;
+	struct idpf_q_coalesce *q_coalesce;
 	u16 num_req_tx_qs;
 	u16 num_req_rx_qs;
 	u32 num_req_txq_desc;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index 62a08bddfd57..1de71dec9b7e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -1384,12 +1384,14 @@ static int idpf_get_per_q_coalesce(struct net_device *netdev, u32 q_num,
 /**
  * __idpf_set_q_coalesce - set ITR values for specific queue
  * @ec: ethtool structure from user to update ITR settings
+ * @q_coal: per queue coalesce settings
  * @qv: queue vector for which itr values has to be set
  * @is_rxq: is queue type rx
  *
  * Returns 0 on success, negative otherwise.
  */
 static int __idpf_set_q_coalesce(const struct ethtool_coalesce *ec,
+				 struct idpf_q_coalesce *q_coal,
 				 struct idpf_q_vector *qv, bool is_rxq)
 {
 	u32 use_adaptive_coalesce, coalesce_usecs;
@@ -1433,20 +1435,25 @@ static int __idpf_set_q_coalesce(const struct ethtool_coalesce *ec,
 
 	if (is_rxq) {
 		qv->rx_itr_value = coalesce_usecs;
+		q_coal->rx_coalesce_usecs = coalesce_usecs;
 		if (use_adaptive_coalesce) {
 			qv->rx_intr_mode = IDPF_ITR_DYNAMIC;
+			q_coal->rx_intr_mode = IDPF_ITR_DYNAMIC;
 		} else {
 			qv->rx_intr_mode = !IDPF_ITR_DYNAMIC;
-			idpf_vport_intr_write_itr(qv, qv->rx_itr_value,
-						  false);
+			q_coal->rx_intr_mode = !IDPF_ITR_DYNAMIC;
+			idpf_vport_intr_write_itr(qv, coalesce_usecs, false);
 		}
 	} else {
 		qv->tx_itr_value = coalesce_usecs;
+		q_coal->tx_coalesce_usecs = coalesce_usecs;
 		if (use_adaptive_coalesce) {
 			qv->tx_intr_mode = IDPF_ITR_DYNAMIC;
+			q_coal->tx_intr_mode = IDPF_ITR_DYNAMIC;
 		} else {
 			qv->tx_intr_mode = !IDPF_ITR_DYNAMIC;
-			idpf_vport_intr_write_itr(qv, qv->tx_itr_value, true);
+			q_coal->tx_intr_mode = !IDPF_ITR_DYNAMIC;
+			idpf_vport_intr_write_itr(qv, coalesce_usecs, true);
 		}
 	}
 
@@ -1459,6 +1466,7 @@ static int __idpf_set_q_coalesce(const struct ethtool_coalesce *ec,
 /**
  * idpf_set_q_coalesce - set ITR values for specific queue
  * @vport: vport associated to the queue that need updating
+ * @q_coal: per queue coalesce settings
  * @ec: coalesce settings to program the device with
  * @q_num: update ITR/INTRL (coalesce) settings for this queue number/index
  * @is_rxq: is queue type rx
@@ -1466,6 +1474,7 @@ static int __idpf_set_q_coalesce(const struct ethtool_coalesce *ec,
  * Return 0 on success, and negative on failure
  */
 static int idpf_set_q_coalesce(const struct idpf_vport *vport,
+			       struct idpf_q_coalesce *q_coal,
 			       const struct ethtool_coalesce *ec,
 			       int q_num, bool is_rxq)
 {
@@ -1474,7 +1483,7 @@ static int idpf_set_q_coalesce(const struct idpf_vport *vport,
 	qv = is_rxq ? idpf_find_rxq_vec(vport, q_num) :
 		      idpf_find_txq_vec(vport, q_num);
 
-	if (qv && __idpf_set_q_coalesce(ec, qv, is_rxq))
+	if (qv && __idpf_set_q_coalesce(ec, q_coal, qv, is_rxq))
 		return -EINVAL;
 
 	return 0;
@@ -1495,10 +1504,14 @@ static int idpf_set_coalesce(struct net_device *netdev,
 			     struct netlink_ext_ack *extack)
 {
 	struct idpf_netdev_priv *np = netdev_priv(netdev);
+	struct idpf_vport_user_config_data *user_config;
+	struct idpf_q_coalesce *q_coal;
 	struct idpf_q_vec_rsrc *rsrc;
 	struct idpf_vport *vport;
 	int err = 0;
 
+	user_config = &np->adapter->vport_config[np->vport_idx]->user_config;
+
 	idpf_vport_ctrl_lock(netdev);
 	vport = idpf_netdev_to_vport(netdev);
 
@@ -1507,13 +1520,15 @@ static int idpf_set_coalesce(struct net_device *netdev,
 
 	rsrc = &vport->dflt_qv_rsrc;
 	for (u16 i = 0; i < rsrc->num_txq; i++) {
-		err = idpf_set_q_coalesce(vport, ec, i, false);
+		q_coal = &user_config->q_coalesce[i];
+		err = idpf_set_q_coalesce(vport, q_coal, ec, i, false);
 		if (err)
 			goto unlock_mutex;
 	}
 
 	for (u16 i = 0; i < rsrc->num_rxq; i++) {
-		err = idpf_set_q_coalesce(vport, ec, i, true);
+		q_coal = &user_config->q_coalesce[i];
+		err = idpf_set_q_coalesce(vport, q_coal, ec, i, true);
 		if (err)
 			goto unlock_mutex;
 	}
@@ -1535,20 +1550,25 @@ static int idpf_set_coalesce(struct net_device *netdev,
 static int idpf_set_per_q_coalesce(struct net_device *netdev, u32 q_num,
 				   struct ethtool_coalesce *ec)
 {
+	struct idpf_netdev_priv *np = netdev_priv(netdev);
+	struct idpf_vport_user_config_data *user_config;
+	struct idpf_q_coalesce *q_coal;
 	struct idpf_vport *vport;
 	int err;
 
 	idpf_vport_ctrl_lock(netdev);
 	vport = idpf_netdev_to_vport(netdev);
+	user_config = &np->adapter->vport_config[np->vport_idx]->user_config;
+	q_coal = &user_config->q_coalesce[q_num];
 
-	err = idpf_set_q_coalesce(vport, ec, q_num, false);
+	err = idpf_set_q_coalesce(vport, q_coal, ec, q_num, false);
 	if (err) {
 		idpf_vport_ctrl_unlock(netdev);
 
 		return err;
 	}
 
-	err = idpf_set_q_coalesce(vport, ec, q_num, true);
+	err = idpf_set_q_coalesce(vport, q_coal, ec, q_num, true);
 
 	idpf_vport_ctrl_unlock(netdev);
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index fab0775e65c3..d5db66922845 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1085,8 +1085,10 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
 	if (!vport)
 		return vport;
 
+	num_max_q = max(max_q->max_txq, max_q->max_rxq);
 	if (!adapter->vport_config[idx]) {
 		struct idpf_vport_config *vport_config;
+		struct idpf_q_coalesce *q_coal;
 
 		vport_config = kzalloc(sizeof(*vport_config), GFP_KERNEL);
 		if (!vport_config) {
@@ -1095,6 +1097,21 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
 			return NULL;
 		}
 
+		q_coal = kcalloc(num_max_q, sizeof(*q_coal), GFP_KERNEL);
+		if (!q_coal) {
+			kfree(vport_config);
+			kfree(vport);
+
+			return NULL;
+		}
+		for (int i = 0; i < num_max_q; i++) {
+			q_coal[i].tx_intr_mode = IDPF_ITR_DYNAMIC;
+			q_coal[i].tx_coalesce_usecs = IDPF_ITR_TX_DEF;
+			q_coal[i].rx_intr_mode = IDPF_ITR_DYNAMIC;
+			q_coal[i].rx_coalesce_usecs = IDPF_ITR_RX_DEF;
+		}
+		vport_config->user_config.q_coalesce = q_coal;
+
 		adapter->vport_config[idx] = vport_config;
 	}
 
@@ -1104,8 +1121,6 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
 	vport->default_vport = adapter->num_alloc_vports <
 			       idpf_get_default_vports(adapter);
 
-	num_max_q = max(max_q->max_txq, max_q->max_rxq);
-
 	rsrc = &vport->dflt_qv_rsrc;
 	rsrc->q_vector_idxs = kcalloc(num_max_q, sizeof(u16), GFP_KERNEL);
 	if (!rsrc->q_vector_idxs)
diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 0efd9c0c7a90..6e0757ab406e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -62,6 +62,7 @@ static void idpf_remove(struct pci_dev *pdev)
 	destroy_workqueue(adapter->vc_event_wq);
 
 	for (i = 0; i < adapter->max_vports; i++) {
+		kfree(adapter->vport_config[i]->user_config.q_coalesce);
 		kfree(adapter->vport_config[i]);
 		adapter->vport_config[i] = NULL;
 	}
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index f3a7ca4523b6..1991d06fe1ac 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -4373,9 +4373,13 @@ int idpf_vport_intr_alloc(struct idpf_vport *vport,
 			  struct idpf_q_vec_rsrc *rsrc)
 {
 	u16 txqs_per_vector, rxqs_per_vector, bufqs_per_vector;
+	struct idpf_vport_user_config_data *user_config;
 	struct idpf_q_vector *q_vector;
+	struct idpf_q_coalesce *q_coal;
 	u32 complqs_per_vector;
+	u16 idx = vport->idx;
 
+	user_config = &vport->adapter->vport_config[idx]->user_config;
 	rsrc->q_vectors = kcalloc(rsrc->num_q_vectors,
 				  sizeof(struct idpf_q_vector), GFP_KERNEL);
 	if (!rsrc->q_vectors)
@@ -4393,14 +4397,15 @@ int idpf_vport_intr_alloc(struct idpf_vport *vport,
 
 	for (u16 v_idx = 0; v_idx < rsrc->num_q_vectors; v_idx++) {
 		q_vector = &rsrc->q_vectors[v_idx];
+		q_coal = &user_config->q_coalesce[v_idx];
 		q_vector->vport = vport;
 
-		q_vector->tx_itr_value = IDPF_ITR_TX_DEF;
-		q_vector->tx_intr_mode = IDPF_ITR_DYNAMIC;
+		q_vector->tx_itr_value = q_coal->tx_coalesce_usecs;
+		q_vector->tx_intr_mode = q_coal->tx_intr_mode;
 		q_vector->tx_itr_idx = VIRTCHNL2_ITR_IDX_1;
 
-		q_vector->rx_itr_value = IDPF_ITR_RX_DEF;
-		q_vector->rx_intr_mode = IDPF_ITR_DYNAMIC;
+		q_vector->rx_itr_value = q_coal->rx_coalesce_usecs;
+		q_vector->rx_intr_mode = q_coal->rx_intr_mode;
 		q_vector->rx_itr_idx = VIRTCHNL2_ITR_IDX_0;
 
 		q_vector->tx = kcalloc(txqs_per_vector, sizeof(*q_vector->tx),
-- 
2.43.0


