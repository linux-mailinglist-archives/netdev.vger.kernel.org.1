Return-Path: <netdev+bounces-250352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBADD2954C
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 00:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1917730167B2
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 23:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4E6328B4E;
	Thu, 15 Jan 2026 23:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZPGF6Dzy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E1032E13E
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 23:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768520890; cv=none; b=bxlFAgwwWWIE7Mv5nVH51armE1DI/L0tNf2A3DYC7Y2ohhu3lmsa2r4EGS1Y/v69FjVEnX/K9H84EK74DaNDh6I+eJrCqzkfsEnKZyhG7sKTSDUVCyEXo4B8dtaV7PWrBA1xeUvAAAphcESjdFIcsvo5XC1fNMEDPSeB1LPaPYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768520890; c=relaxed/simple;
	bh=BWKupGoa/8vc0avAKIjKwXveic27wZNeFDcySj9Otfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PBFEG3GKX/e9ZYvT6s9vNqx10piTRW1c5wCF0rgEqC62B7kMiBW1tX5A+XR6Hkv49gOp0/PUfB9K0SZx0gmN1ANtSRDb7GpPgqTBMOtwDI6aE1yNdtsDOGHnOEM+ybqVp6ffGwYUx0FZW1wL+8UhLVfM63lr87N4YXU9dWY1ye8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZPGF6Dzy; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768520886; x=1800056886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BWKupGoa/8vc0avAKIjKwXveic27wZNeFDcySj9Otfc=;
  b=ZPGF6DzyLcFXO/BUuMi2mXZC6YBGg3FyIFugDAXARmbReaOHQpAFG5VA
   DynjqNVs8WgsJuP6v48GLGF/D9nmzQAyipGquUXf2kHl1csIUAH9o9rO+
   nAIbTPmSI5YPhwGJbxqiRRAona/hcGlyDf84Im1vAsjqy5f9ndxmslMTz
   1XW1FyNNO7h0Z2AQ8sKYHC5Yk4Rr4oybeiVSDF7s+2zgHapxEcmmdLtaE
   EdSPNdYfHr+/oZArLfuMKOARhHzabzQtApy8gAlZwlKP76WNWRkrVTV7u
   mePf8dBIKyZzmesOWJouAKwkUNJSHWXvsJEiPZ8NaYHKHQVeDSNevL+J2
   A==;
X-CSE-ConnectionGUID: XYLvciKHRDa9By/X8jVZHQ==
X-CSE-MsgGUID: 8KJVySpsSLue+F5SutJF5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="69892363"
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="69892363"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 15:48:01 -0800
X-CSE-ConnectionGUID: +djalknsRvCAGKTuPDE51g==
X-CSE-MsgGUID: uFL3DUTjT8CcJgGI10m8kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="205502016"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 15 Jan 2026 15:48:01 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Madhu Chittim <madhu.chittim@intel.com>,
	anthony.l.nguyen@intel.com,
	joshua.a.hay@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net-next 06/10] idpf: add rss_data field to RSS function parameters
Date: Thu, 15 Jan 2026 15:47:43 -0800
Message-ID: <20260115234749.2365504-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260115234749.2365504-1-anthony.l.nguyen@intel.com>
References: <20260115234749.2365504-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>

Retrieve rss_data field of vport just once and pass it to RSS related
functions instead of retrieving it in each function.

While at it, update s/rss/RSS in the RSS function doc comments.

Reviewed-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        |  1 +
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |  2 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 27 +++++++++++-----
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 32 +++++++------------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  9 +++---
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 29 +++++++++--------
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  8 +++--
 7 files changed, 59 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index a196c4debc3f..ade41c4465b1 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -9,6 +9,7 @@ struct idpf_adapter;
 struct idpf_vport;
 struct idpf_vport_max_q;
 struct idpf_q_vec_rsrc;
+struct idpf_rss_data;
 
 #include <net/pkt_sched.h>
 #include <linux/aer.h>
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index 3d0f3170a6f2..1d78a621d65b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -503,7 +503,7 @@ static int idpf_set_rxfh(struct net_device *netdev,
 	}
 
 	if (test_bit(IDPF_VPORT_UP, np->state))
-		err = idpf_config_rss(vport);
+		err = idpf_config_rss(vport, rss_data);
 
 unlock_mutex:
 	idpf_vport_ctrl_unlock(netdev);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index a6e5ec68a1d2..abed412bb533 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1078,8 +1078,8 @@ static void idpf_vport_rel(struct idpf_vport *vport)
 	u16 idx = vport->idx;
 
 	vport_config = adapter->vport_config[vport->idx];
-	idpf_deinit_rss_lut(vport);
 	rss_data = &vport_config->user_config.rss_data;
+	idpf_deinit_rss_lut(rss_data);
 	kfree(rss_data->rss_key);
 	rss_data->rss_key = NULL;
 
@@ -1296,11 +1296,11 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
 	if (!rss_data->rss_key)
 		goto free_qreg_chunks;
 
-	/* Initialize default rss key */
+	/* Initialize default RSS key */
 	netdev_rss_key_fill((void *)rss_data->rss_key, rss_data->rss_key_size);
 
-	/* Initialize default rss LUT */
-	err = idpf_init_rss_lut(vport);
+	/* Initialize default RSS LUT */
+	err = idpf_init_rss_lut(vport, rss_data);
 	if (err)
 		goto free_rss_key;
 
@@ -1492,6 +1492,7 @@ static int idpf_vport_open(struct idpf_vport *vport, bool rtnl)
 	struct idpf_adapter *adapter = vport->adapter;
 	struct idpf_vport_config *vport_config;
 	struct idpf_queue_id_reg_info *chunks;
+	struct idpf_rss_data *rss_data;
 	int err;
 
 	if (test_bit(IDPF_VPORT_UP, np->state))
@@ -1588,7 +1589,8 @@ static int idpf_vport_open(struct idpf_vport *vport, bool rtnl)
 
 	idpf_restore_features(vport);
 
-	err = idpf_config_rss(vport);
+	rss_data = &vport_config->user_config.rss_data;
+	err = idpf_config_rss(vport, rss_data);
 	if (err) {
 		dev_err(&adapter->pdev->dev, "Failed to configure RSS for vport %u: %d\n",
 			vport->vport_id, err);
@@ -2092,8 +2094,12 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 		goto err_open;
 
 	if (reset_cause == IDPF_SR_Q_CHANGE &&
-	    !netif_is_rxfh_configured(vport->netdev))
-		idpf_fill_dflt_rss_lut(vport);
+	    !netif_is_rxfh_configured(vport->netdev)) {
+		struct idpf_rss_data *rss_data;
+
+		rss_data = &vport_config->user_config.rss_data;
+		idpf_fill_dflt_rss_lut(vport, rss_data);
+	}
 
 	if (vport_is_up)
 		err = idpf_vport_open(vport, false);
@@ -2271,7 +2277,12 @@ static int idpf_set_features(struct net_device *netdev,
 		 * the HW when the interface is brought up.
 		 */
 		if (test_bit(IDPF_VPORT_UP, np->state)) {
-			err = idpf_config_rss(vport);
+			struct idpf_vport_config *vport_config;
+			struct idpf_rss_data *rss_data;
+
+			vport_config = adapter->vport_config[vport->idx];
+			rss_data = &vport_config->user_config.rss_data;
+			err = idpf_config_rss(vport, rss_data);
 			if (err)
 				goto unlock_mutex;
 		}
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index a857f8674735..6afb8e1779c6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -4673,33 +4673,32 @@ void idpf_vport_intr_ena(struct idpf_vport *vport, struct idpf_q_vec_rsrc *rsrc)
 /**
  * idpf_config_rss - Send virtchnl messages to configure RSS
  * @vport: virtual port
+ * @rss_data: pointer to RSS key and lut info
  *
  * Return: 0 on success, negative on failure
  */
-int idpf_config_rss(struct idpf_vport *vport)
+int idpf_config_rss(struct idpf_vport *vport, struct idpf_rss_data *rss_data)
 {
 	int err;
 
-	err = idpf_send_get_set_rss_key_msg(vport, false);
+	err = idpf_send_get_set_rss_key_msg(vport, rss_data, false);
 	if (err)
 		return err;
 
-	return idpf_send_get_set_rss_lut_msg(vport, false);
+	return idpf_send_get_set_rss_lut_msg(vport, rss_data, false);
 }
 
 /**
  * idpf_fill_dflt_rss_lut - Fill the indirection table with the default values
  * @vport: virtual port structure
+ * @rss_data: pointer to RSS key and lut info
  */
-void idpf_fill_dflt_rss_lut(struct idpf_vport *vport)
+void idpf_fill_dflt_rss_lut(struct idpf_vport *vport,
+			    struct idpf_rss_data *rss_data)
 {
 	u16 num_active_rxq = vport->dflt_qv_rsrc.num_rxq;
-	struct idpf_adapter *adapter = vport->adapter;
-	struct idpf_rss_data *rss_data;
 	int i;
 
-	rss_data = &adapter->vport_config[vport->idx]->user_config.rss_data;
-
 	for (i = 0; i < rss_data->rss_lut_size; i++)
 		rss_data->rss_lut[i] = i % num_active_rxq;
 }
@@ -4707,15 +4706,12 @@ void idpf_fill_dflt_rss_lut(struct idpf_vport *vport)
 /**
  * idpf_init_rss_lut - Allocate and initialize RSS LUT
  * @vport: virtual port
+ * @rss_data: pointer to RSS key and lut info
  *
  * Return: 0 on success, negative on failure
  */
-int idpf_init_rss_lut(struct idpf_vport *vport)
+int idpf_init_rss_lut(struct idpf_vport *vport, struct idpf_rss_data *rss_data)
 {
-	struct idpf_adapter *adapter = vport->adapter;
-	struct idpf_rss_data *rss_data;
-
-	rss_data = &adapter->vport_config[vport->idx]->user_config.rss_data;
 	if (!rss_data->rss_lut) {
 		u32 lut_size;
 
@@ -4726,21 +4722,17 @@ int idpf_init_rss_lut(struct idpf_vport *vport)
 	}
 
 	/* Fill the default RSS lut values */
-	idpf_fill_dflt_rss_lut(vport);
+	idpf_fill_dflt_rss_lut(vport, rss_data);
 
 	return 0;
 }
 
 /**
  * idpf_deinit_rss_lut - Release RSS LUT
- * @vport: virtual port
+ * @rss_data: pointer to RSS key and lut info
  */
-void idpf_deinit_rss_lut(struct idpf_vport *vport)
+void idpf_deinit_rss_lut(struct idpf_rss_data *rss_data)
 {
-	struct idpf_adapter *adapter = vport->adapter;
-	struct idpf_rss_data *rss_data;
-
-	rss_data = &adapter->vport_config[vport->idx]->user_config.rss_data;
 	kfree(rss_data->rss_lut);
 	rss_data->rss_lut = NULL;
 }
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 99daa081268a..4be5b3b6d3ed 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -1098,10 +1098,11 @@ int idpf_vport_intr_init(struct idpf_vport *vport,
 			 struct idpf_q_vec_rsrc *rsrc);
 void idpf_vport_intr_ena(struct idpf_vport *vport,
 			 struct idpf_q_vec_rsrc *rsrc);
-void idpf_fill_dflt_rss_lut(struct idpf_vport *vport);
-int idpf_config_rss(struct idpf_vport *vport);
-int idpf_init_rss_lut(struct idpf_vport *vport);
-void idpf_deinit_rss_lut(struct idpf_vport *vport);
+void idpf_fill_dflt_rss_lut(struct idpf_vport *vport,
+			    struct idpf_rss_data *rss_data);
+int idpf_config_rss(struct idpf_vport *vport, struct idpf_rss_data *rss_data);
+int idpf_init_rss_lut(struct idpf_vport *vport, struct idpf_rss_data *rss_data);
+void idpf_deinit_rss_lut(struct idpf_rss_data *rss_data);
 int idpf_rx_bufs_init_all(struct idpf_vport *vport,
 			  struct idpf_q_vec_rsrc *rsrc);
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 564feb3bff08..fa3ac264196a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -2824,30 +2824,31 @@ int idpf_send_get_stats_msg(struct idpf_vport *vport)
 }
 
 /**
- * idpf_send_get_set_rss_lut_msg - Send virtchnl get or set rss lut message
+ * idpf_send_get_set_rss_lut_msg - Send virtchnl get or set RSS lut message
  * @vport: virtual port data structure
- * @get: flag to set or get rss look up table
+ * @rss_data: pointer to RSS key and lut info
+ * @get: flag to set or get RSS look up table
  *
  * When rxhash is disabled, RSS LUT will be configured with zeros.  If rxhash
  * is enabled, the LUT values stored in driver's soft copy will be used to setup
  * the HW.
  *
- * Returns 0 on success, negative on failure.
+ * Return: 0 on success, negative on failure.
  */
-int idpf_send_get_set_rss_lut_msg(struct idpf_vport *vport, bool get)
+int idpf_send_get_set_rss_lut_msg(struct idpf_vport *vport,
+				  struct idpf_rss_data *rss_data,
+				  bool get)
 {
 	struct virtchnl2_rss_lut *recv_rl __free(kfree) = NULL;
 	struct virtchnl2_rss_lut *rl __free(kfree) = NULL;
 	struct idpf_vc_xn_params xn_params = {};
-	struct idpf_rss_data *rss_data;
 	int buf_size, lut_buf_size;
 	ssize_t reply_sz;
 	bool rxhash_ena;
 	int i;
 
-	rss_data =
-		&vport->adapter->vport_config[vport->idx]->user_config.rss_data;
 	rxhash_ena = idpf_is_feature_ena(vport, NETIF_F_RXHASH);
+
 	buf_size = struct_size(rl, lut, rss_data->rss_lut_size);
 	rl = kzalloc(buf_size, GFP_KERNEL);
 	if (!rl)
@@ -2906,24 +2907,24 @@ int idpf_send_get_set_rss_lut_msg(struct idpf_vport *vport, bool get)
 }
 
 /**
- * idpf_send_get_set_rss_key_msg - Send virtchnl get or set rss key message
+ * idpf_send_get_set_rss_key_msg - Send virtchnl get or set RSS key message
  * @vport: virtual port data structure
- * @get: flag to set or get rss look up table
+ * @rss_data: pointer to RSS key and lut info
+ * @get: flag to set or get RSS look up table
  *
- * Returns 0 on success, negative on failure
+ * Return: 0 on success, negative on failure
  */
-int idpf_send_get_set_rss_key_msg(struct idpf_vport *vport, bool get)
+int idpf_send_get_set_rss_key_msg(struct idpf_vport *vport,
+				  struct idpf_rss_data *rss_data,
+				  bool get)
 {
 	struct virtchnl2_rss_key *recv_rk __free(kfree) = NULL;
 	struct virtchnl2_rss_key *rk __free(kfree) = NULL;
 	struct idpf_vc_xn_params xn_params = {};
-	struct idpf_rss_data *rss_data;
 	ssize_t reply_sz;
 	int i, buf_size;
 	u16 key_size;
 
-	rss_data =
-		&vport->adapter->vport_config[vport->idx]->user_config.rss_data;
 	buf_size = struct_size(rk, key_flex, rss_data->rss_key_size);
 	rk = kzalloc(buf_size, GFP_KERNEL);
 	if (!rk)
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
index 6fde600dfe53..e35e1efa211c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
@@ -199,8 +199,12 @@ int idpf_send_get_rx_ptype_msg(struct idpf_vport *vport);
 int idpf_send_ena_dis_loopback_msg(struct idpf_vport *vport);
 int idpf_send_get_stats_msg(struct idpf_vport *vport);
 int idpf_send_set_sriov_vfs_msg(struct idpf_adapter *adapter, u16 num_vfs);
-int idpf_send_get_set_rss_key_msg(struct idpf_vport *vport, bool get);
-int idpf_send_get_set_rss_lut_msg(struct idpf_vport *vport, bool get);
+int idpf_send_get_set_rss_key_msg(struct idpf_vport *vport,
+				  struct idpf_rss_data *rss_data,
+				  bool get);
+int idpf_send_get_set_rss_lut_msg(struct idpf_vport *vport,
+				  struct idpf_rss_data *rss_data,
+				  bool get);
 void idpf_vc_xn_shutdown(struct idpf_vc_xn_manager *vcxn_mngr);
 int idpf_idc_rdma_vc_send_sync(struct iidc_rdma_core_dev_info *cdev_info,
 			       u8 *send_msg, u16 msg_size,
-- 
2.47.1


