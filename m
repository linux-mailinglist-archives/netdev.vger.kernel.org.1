Return-Path: <netdev+bounces-252557-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IL0NGnemcmmMoQAAu9opvQ
	(envelope-from <netdev+bounces-252557-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 23:36:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3B06E348
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 23:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 70888300B188
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 22:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74DF3D7294;
	Thu, 22 Jan 2026 22:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aTDpPpbM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8EE3BBA07
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 22:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769121395; cv=none; b=fletrEy1cDxSWatTqghhuF7kBaM8Qk3gg6F1m4UrqiE3CjwT1mWeT/0EetNXvzcitq4HdiMDpJFhK3R+iLQAszPEKqiyaoe9vE4xtc6VPd+I9Otx87dt7dUoIoEmLJhXZ2GvfNFVmQ0qwj9pCf7EZD3qoiFB9RawMMHrPosr/mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769121395; c=relaxed/simple;
	bh=eHeabOMS8o1nBY+aAc39P7Pvg5sLGDoAnwKX5DpF3yY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aq/jIfHeysbfnjsSezOzC0nDhbCbcrDryqM6zR0ZRxxoevgVb5HozUmc0CqlH8vgy0ITKoVM6nFpOiCD4DB49ssRrv0HYuHxhsN6//PYCKQOs+FlJl7BnM5s8WcY1xqiXKappi1iNufz8955gt+/Ztv5gz9RNcZVVGw8q19aWB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aTDpPpbM; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769121388; x=1800657388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eHeabOMS8o1nBY+aAc39P7Pvg5sLGDoAnwKX5DpF3yY=;
  b=aTDpPpbMP9wL2LpBKrLH6Y+5IQiQkw3fegt2lns3RNKvYtnC3EIFV4o4
   ftKjbREEFwb9f2Xih8GZ/4KVSXAnZKUJ/9i4ZCOxZMVI2BGVyZeRU5L+p
   wNnZkwPLXvk6Ywinbs3YZY/gf6T0ZmUopADQboGq99vIwyB7i5cmhBLfX
   QsuK2C+jyDrwFJnIz6W6fOhZbncPf7VaGtfV38kPZLRl/7YEKe0jCMZQs
   4qr0mOjF97lgrbeA/Zd379nWLzhxmXn63ToUBPaOMDpdAy30ikp4+2qRQ
   YcCJ1Zz+BaJ2BTHfhjOpadoakWjzeeBt44tHAdlnwYEoXCJnMtS+wJ8VB
   w==;
X-CSE-ConnectionGUID: W8SgQrPxSQC5dH/fDjo4hg==
X-CSE-MsgGUID: 3p3CLxprR0+iiy/2knlYrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="93039278"
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; 
   d="scan'208";a="93039278"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 14:36:08 -0800
X-CSE-ConnectionGUID: 3HbeLrGrTkSzWMy/Xx2XgA==
X-CSE-MsgGUID: 1r8nCw52SL+9c32U5ESmOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; 
   d="scan'208";a="206670456"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 22 Jan 2026 14:36:06 -0800
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
	samuel.salin@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net-next v2 06/10] idpf: add rss_data field to RSS function parameters
Date: Thu, 22 Jan 2026 14:35:52 -0800
Message-ID: <20260122223601.2208759-7-anthony.l.nguyen@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252557-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0A3B06E348
X-Rspamd-Action: no action

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
index 4d005986d784..9b6c61f494a2 100644
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
index ae268e75b167..08c5c7370ca4 100644
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
 
@@ -1297,11 +1297,11 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
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
 
@@ -1493,6 +1493,7 @@ static int idpf_vport_open(struct idpf_vport *vport, bool rtnl)
 	struct idpf_adapter *adapter = vport->adapter;
 	struct idpf_vport_config *vport_config;
 	struct idpf_queue_id_reg_info *chunks;
+	struct idpf_rss_data *rss_data;
 	int err;
 
 	if (test_bit(IDPF_VPORT_UP, np->state))
@@ -1589,7 +1590,8 @@ static int idpf_vport_open(struct idpf_vport *vport, bool rtnl)
 
 	idpf_restore_features(vport);
 
-	err = idpf_config_rss(vport);
+	rss_data = &vport_config->user_config.rss_data;
+	err = idpf_config_rss(vport, rss_data);
 	if (err) {
 		dev_err(&adapter->pdev->dev, "Failed to configure RSS for vport %u: %d\n",
 			vport->vport_id, err);
@@ -2093,8 +2095,12 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
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
@@ -2273,7 +2279,12 @@ static int idpf_set_features(struct net_device *netdev,
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
index f41cf79d11cb..c97e20bbcd34 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -4670,33 +4670,32 @@ void idpf_vport_intr_ena(struct idpf_vport *vport, struct idpf_q_vec_rsrc *rsrc)
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
@@ -4704,15 +4703,12 @@ void idpf_fill_dflt_rss_lut(struct idpf_vport *vport)
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
 
@@ -4723,21 +4719,17 @@ int idpf_init_rss_lut(struct idpf_vport *vport)
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
index 211f00e7b30d..434e77a05405 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -2827,30 +2827,31 @@ int idpf_send_get_stats_msg(struct idpf_vport *vport)
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
@@ -2909,24 +2910,24 @@ int idpf_send_get_set_rss_lut_msg(struct idpf_vport *vport, bool get)
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


