Return-Path: <netdev+bounces-226437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C048BA05CB
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 17:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6067D7B0C9D
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 15:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40A22E1EE0;
	Thu, 25 Sep 2025 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EGFrCExb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC0D2E7F06
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758814457; cv=none; b=qRuG0PvK7gtKx6VV9SMRvzcQF6LCWqbePdrzwyitXt8POODc0h9DgsGtuE4BPHxf6V7SBlhjHdqnWSeNg0FtAtaOjQMz3dW4dMEkCBV6gzCKPx1w3ogGshxqHmuM494vEiMZFLnhGkDcwmZr0wVRLe40K3iTUx/xvlFqK3ZNT68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758814457; c=relaxed/simple;
	bh=0V7lombKI/qcPCWq7WtfyfMx7SVo0vPp8phy/tW8L1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FeyOciFXtftlRbHvJRv/O3d5f17/tZabe5MoFGEBeZYip98s3FkKSmPacNwDdgAQlpalyQpHzv2fIoReE1ObBp++tJfKtHvXvht5ZKeLIjku2e/qSkwX9JkMpSpNg12rdjzIcaw8QKNVXEjIPVGVF8HTT7ZEdF5IiZiDy7XuevY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EGFrCExb; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758814456; x=1790350456;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0V7lombKI/qcPCWq7WtfyfMx7SVo0vPp8phy/tW8L1k=;
  b=EGFrCExbKeEaEPempDQmn9w8pjq8DbzmhTfw9bWKrnc9cve+OigL8vXu
   84V6F1k6r2zrXiFUSozv/6WiqmluBzhjRBibBwYFty43jIsSg4xaoNYil
   58hT8H3efbah9YcrkfugJG1HfsGSCF0kVv/aT7BKzwmGU8U92xMXgq2fS
   4AS9I3fbVV19y1fKyJZwck54L8p5rlSsczHekC3T1KNmjjXe6beemTKZA
   XYeZ0G13RERN0ubqlL5/zTlTvnx2irRVw/UdZYdYNmaqhAAyRRjTMhNvz
   7Jw9IBVdmtqrG0lCHHAh6owkYBByrsdZFs9FtBDk+CxM0jDnVrpVpxJOG
   Q==;
X-CSE-ConnectionGUID: 5JJg3ZAsTLK825ipPMJACw==
X-CSE-MsgGUID: AMXhr5G5TMezPV/EydGRvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64947225"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64947225"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 08:34:16 -0700
X-CSE-ConnectionGUID: KpSDDVDlS52hUd1lrnLr0w==
X-CSE-MsgGUID: X7bVb1UOQ6e8AXjb2tvUkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="208298251"
Received: from aus-labsrv3.an.intel.com ([10.123.116.23])
  by fmviesa001.fm.intel.com with ESMTP; 25 Sep 2025 08:34:15 -0700
From: Sreedevi Joshi <sreedevi.joshi@intel.com>
To: sreedevi.joshi@intel.com,
	intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-net 1/2] idpf: fix memory leak of flow steer list on rmmod
Date: Thu, 25 Sep 2025 10:33:57 -0500
Message-Id: <20250925153358.143112-2-sreedevi.joshi@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250925153358.143112-1-sreedevi.joshi@intel.com>
References: <20250925153358.143112-1-sreedevi.joshi@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The flow steering list maintains entries that are added and removed as
ethtool creates and deletes flow steering rules. Module removal with active
entries causes memory leak as the list is not properly cleaned up.

Prevent this by iterating through the remaining entries in the list and
freeing the associated memory during module removal. Add a spinlock
(flow_steer_list_lock) to protect the list access from multiple threads.

Fixes: ada3e24b84a0 ("idpf: add flow steering support")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        |  2 ++
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 15 ++++++++--
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 28 ++++++++++++++++++-
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index cfbf3a716f34..4f4cf21e3c46 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -525,6 +525,7 @@ struct idpf_vector_lifo {
  * @max_q: Maximum possible queues
  * @req_qs_chunks: Queue chunk data for requested queues
  * @mac_filter_list_lock: Lock to protect mac filters
+ * @flow_steer_list_lock: Lock to protect fsteer filters
  * @flags: See enum idpf_vport_config_flags
  */
 struct idpf_vport_config {
@@ -532,6 +533,7 @@ struct idpf_vport_config {
 	struct idpf_vport_max_q max_q;
 	struct virtchnl2_add_queues *req_qs_chunks;
 	spinlock_t mac_filter_list_lock;
+	spinlock_t flow_steer_list_lock;
 	DECLARE_BITMAP(flags, IDPF_VPORT_CONFIG_FLAGS_NBITS);
 };
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index f84e247399a7..1352f18b60b0 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -18,6 +18,7 @@ static int idpf_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 {
 	struct idpf_netdev_priv *np = netdev_priv(netdev);
 	struct idpf_vport_user_config_data *user_config;
+	struct idpf_vport_config *vport_config;
 	struct idpf_fsteer_fltr *f;
 	struct idpf_vport *vport;
 	unsigned int cnt = 0;
@@ -25,7 +26,8 @@ static int idpf_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 
 	idpf_vport_ctrl_lock(netdev);
 	vport = idpf_netdev_to_vport(netdev);
-	user_config = &np->adapter->vport_config[np->vport_idx]->user_config;
+	vport_config = np->adapter->vport_config[np->vport_idx];
+	user_config = &vport_config->user_config;
 
 	switch (cmd->cmd) {
 	case ETHTOOL_GRXRINGS:
@@ -37,15 +39,18 @@ static int idpf_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 		break;
 	case ETHTOOL_GRXCLSRULE:
 		err = -EINVAL;
+		spin_lock_bh(&vport_config->flow_steer_list_lock);
 		list_for_each_entry(f, &user_config->flow_steer_list, list)
 			if (f->loc == cmd->fs.location) {
 				cmd->fs.ring_cookie = f->q_index;
 				err = 0;
 				break;
 			}
+		spin_unlock_bh(&vport_config->flow_steer_list_lock);
 		break;
 	case ETHTOOL_GRXCLSRLALL:
 		cmd->data = idpf_fsteer_max_rules(vport);
+		spin_lock_bh(&vport_config->flow_steer_list_lock);
 		list_for_each_entry(f, &user_config->flow_steer_list, list) {
 			if (cnt == cmd->rule_cnt) {
 				err = -EMSGSIZE;
@@ -56,6 +61,7 @@ static int idpf_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 		}
 		if (!err)
 			cmd->rule_cnt = user_config->num_fsteer_fltrs;
+		spin_unlock_bh(&vport_config->flow_steer_list_lock);
 		break;
 	default:
 		break;
@@ -224,6 +230,7 @@ static int idpf_add_flow_steer(struct net_device *netdev,
 
 	fltr->loc = fsp->location;
 	fltr->q_index = q_index;
+	spin_lock_bh(&vport_config->flow_steer_list_lock);
 	list_for_each_entry(f, &user_config->flow_steer_list, list) {
 		if (f->loc >= fltr->loc)
 			break;
@@ -234,6 +241,7 @@ static int idpf_add_flow_steer(struct net_device *netdev,
 		 list_add(&fltr->list, &user_config->flow_steer_list);
 
 	user_config->num_fsteer_fltrs++;
+	spin_unlock_bh(&vport_config->flow_steer_list_lock);
 
 out:
 	kfree(rule);
@@ -286,17 +294,20 @@ static int idpf_del_flow_steer(struct net_device *netdev,
 		goto out;
 	}
 
+	spin_lock_bh(&vport_config->flow_steer_list_lock);
 	list_for_each_entry_safe(f, iter,
 				 &user_config->flow_steer_list, list) {
 		if (f->loc == fsp->location) {
 			list_del(&f->list);
 			kfree(f);
 			user_config->num_fsteer_fltrs--;
-			goto out;
+			goto out_unlock;
 		}
 	}
 	err = -EINVAL;
 
+out_unlock:
+	spin_unlock_bh(&vport_config->flow_steer_list_lock);
 out:
 	kfree(rule);
 	return err;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 01ab42fa23f9..72685f8b48f7 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -440,6 +440,29 @@ int idpf_intr_req(struct idpf_adapter *adapter)
 	return err;
 }
 
+/**
+ * idpf_del_all_flow_steer_filters - Delete all flow steer filters in list
+ * @vport: main vport struct
+ *
+ * Takes flow_steer_list_lock spinlock.  Deletes all filters
+ */
+static void idpf_del_all_flow_steer_filters(struct idpf_vport *vport)
+{
+	struct idpf_vport_config *vport_config;
+	struct idpf_fsteer_fltr *f, *ftmp;
+
+	vport_config = vport->adapter->vport_config[vport->idx];
+
+	spin_lock_bh(&vport_config->flow_steer_list_lock);
+	list_for_each_entry_safe(f, ftmp, &vport_config->user_config.flow_steer_list,
+				 list) {
+		list_del(&f->list);
+		kfree(f);
+	}
+	vport_config->user_config.num_fsteer_fltrs = 0;
+	spin_unlock_bh(&vport_config->flow_steer_list_lock);
+}
+
 /**
  * idpf_find_mac_filter - Search filter list for specific mac filter
  * @vconfig: Vport config structure
@@ -1031,8 +1054,10 @@ static void idpf_vport_dealloc(struct idpf_vport *vport)
 
 	if (!test_bit(IDPF_HR_RESET_IN_PROG, adapter->flags))
 		idpf_decfg_netdev(vport);
-	if (test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
+	if (test_bit(IDPF_REMOVE_IN_PROG, adapter->flags)) {
 		idpf_del_all_mac_filters(vport);
+		idpf_del_all_flow_steer_filters(vport);
+	}
 
 	if (adapter->netdevs[i]) {
 		struct idpf_netdev_priv *np = netdev_priv(adapter->netdevs[i]);
@@ -1549,6 +1574,7 @@ void idpf_init_task(struct work_struct *work)
 	init_waitqueue_head(&vport->sw_marker_wq);
 
 	spin_lock_init(&vport_config->mac_filter_list_lock);
+	spin_lock_init(&vport_config->flow_steer_list_lock);
 
 	INIT_LIST_HEAD(&vport_config->user_config.mac_filter_list);
 	INIT_LIST_HEAD(&vport_config->user_config.flow_steer_list);
-- 
2.43.0


