Return-Path: <netdev+bounces-251569-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHF/DYrSb2mgMQAAu9opvQ
	(envelope-from <netdev+bounces-251569-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:07:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9800D4A04F
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E535EA42C9D
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 17:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6C6426D20;
	Tue, 20 Jan 2026 17:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TfWqJG5S"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B213426D08;
	Tue, 20 Jan 2026 17:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768930498; cv=none; b=nfthITDCJOdEb1ExVagE/W4yaFHFMynHt7V2AnZRaYGx/++B0/fm8TuBibMg41WJW8qKmlxMM+Kdl9winzofnaCBEzpdxna89WxejLV4BO9uUj+W9yqOaFdUiRoa6WnRWkZ6nvDDEJTva5zX4828KDRkhaJ6wotAH/dtRF5q6XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768930498; c=relaxed/simple;
	bh=TXtq3AcxlNDXfEyyHbKAUsnG1pDmSsdzskwfPbUP66c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KftB0eTEIJhOzgZeZ9Yyz5QEFfhQLZ3PKY69CedqK7A0o20FN7k8E/E7BUQeHqVcB3nQ1FOy9TKKIc8D1jz0e2qZbjD3GL9mpc50hx3U0In4XfMQsmV9Wq0Qriy04k179edus2pBklE9be2af3vIURQDZ0jvCR/5SXRYURpx4iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TfWqJG5S; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768930496; x=1800466496;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TXtq3AcxlNDXfEyyHbKAUsnG1pDmSsdzskwfPbUP66c=;
  b=TfWqJG5SCgi/VXrNsHbX0N2q9OxbxQAkYpwtuU/uv8GZhCC7+rHLCWtR
   DqbzzGdteb75KyJpqePiTHrziT6BrHGPTqasYs8mJu4NWjhsEqm41xLIV
   6AndeZoocp7ZSKLLkitMSXpLQiWb0bM3/OmECAMdrq1cct3nLSxJ3mC7m
   5WgKVJo6YFl0Lhf7Ls/FHOetKs0CTvuYfNobbcby4tBmm2E3c2EFJSsxV
   i3KUMJoq+2CcbBEXrvow8w0x9uxp0xJvsJO6pxtqn0vumuoFc41rdJS4R
   DV7LJ5oFhOdZCLHBlErraquMCMlQtjk+Zr7E9eIUBB12NgCHNBkHbHC4T
   w==;
X-CSE-ConnectionGUID: qSDbuDK1RqOMJ0WXsTd0lw==
X-CSE-MsgGUID: zHszCAuaS1iON6Ej3NKXOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="81255952"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="81255952"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 09:34:55 -0800
X-CSE-ConnectionGUID: C3kTcWW0RNqN4BbTPsCZRw==
X-CSE-MsgGUID: iHRmYtCIQPm+9mBoKf/Ccw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="237434922"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa001.fm.intel.com with ESMTP; 20 Jan 2026 09:34:52 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
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
Subject: [PATCH iwl-next] ice: fix system hang on `ethtool -L`
Date: Tue, 20 Jan 2026 18:34:00 +0100
Message-ID: <20260120173405.82147-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <c507379f-07a9-44fe-9679-277d618c0e04@intel.com>
References: <20251204155133.2437621-1-aleksander.lobakin@intel.com> <20251204155133.2437621-4-aleksander.lobakin@intel.com> <c507379f-07a9-44fe-9679-277d618c0e04@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251569-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 9800D4A04F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ice_set_channels() calls ice_vsi_rebuild() under the netdev lock
taken, but ice_vsi_rebuild() calls netif_napi_{add,del}() which
take the same lock.
Add ice_vsi_rebuild_locked() which uses the _locked counterparts
of these functions and use it in ice_set_channels().

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
Hey Tony, please amend to the patch I replied to.
---
 drivers/net/ethernet/intel/ice/ice_base.h |  2 +
 drivers/net/ethernet/intel/ice/ice_lib.h  |  1 +
 drivers/net/ethernet/intel/ice/ice_base.c | 63 ++++++++++++---
 drivers/net/ethernet/intel/ice/ice_lib.c  | 94 ++++++++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_main.c |  5 +-
 5 files changed, 143 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.h b/drivers/net/ethernet/intel/ice/ice_base.h
index d28294247599..99b2c7232829 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.h
+++ b/drivers/net/ethernet/intel/ice/ice_base.h
@@ -12,8 +12,10 @@ int __ice_vsi_get_qs(struct ice_qs_cfg *qs_cfg);
 int
 ice_vsi_ctrl_one_rx_ring(struct ice_vsi *vsi, bool ena, u16 rxq_idx, bool wait);
 int ice_vsi_wait_one_rx_ring(struct ice_vsi *vsi, bool ena, u16 rxq_idx);
+int ice_vsi_alloc_q_vectors_locked(struct ice_vsi *vsi);
 int ice_vsi_alloc_q_vectors(struct ice_vsi *vsi);
 void ice_vsi_map_rings_to_vectors(struct ice_vsi *vsi);
+void ice_vsi_free_q_vectors_locked(struct ice_vsi *vsi);
 void ice_vsi_free_q_vectors(struct ice_vsi *vsi);
 int ice_vsi_cfg_single_txq(struct ice_vsi *vsi, struct ice_tx_ring **tx_rings,
 			   u16 q_idx);
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 347b63e497e7..e55b72db72c4 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -68,6 +68,7 @@ int ice_ena_vsi(struct ice_vsi *vsi, bool locked);
 void ice_vsi_decfg(struct ice_vsi *vsi);
 void ice_dis_vsi(struct ice_vsi *vsi, bool locked);
 
+int ice_vsi_rebuild_locked(struct ice_vsi *vsi, u32 vsi_flags);
 int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags);
 int ice_vsi_cfg(struct ice_vsi *vsi);
 struct ice_vsi *ice_vsi_alloc(struct ice_pf *pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 7097324c38f3..65e19815bec5 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -153,8 +153,8 @@ static int ice_vsi_alloc_q_vector(struct ice_vsi *vsi, u16 v_idx)
 	 * handler here (i.e. resume, reset/rebuild, etc.)
 	 */
 	if (vsi->netdev)
-		netif_napi_add_config(vsi->netdev, &q_vector->napi,
-				      ice_napi_poll, v_idx);
+		netif_napi_add_config_locked(vsi->netdev, &q_vector->napi,
+					     ice_napi_poll, v_idx);
 
 out:
 	/* tie q_vector and VSI together */
@@ -196,7 +196,7 @@ static void ice_free_q_vector(struct ice_vsi *vsi, int v_idx)
 
 	/* only VSI with an associated netdev is set up with NAPI */
 	if (vsi->netdev)
-		netif_napi_del(&q_vector->napi);
+		netif_napi_del_locked(&q_vector->napi);
 
 	/* release MSIX interrupt if q_vector had interrupt allocated */
 	if (q_vector->irq.index < 0)
@@ -896,13 +896,15 @@ int ice_vsi_wait_one_rx_ring(struct ice_vsi *vsi, bool ena, u16 rxq_idx)
 }
 
 /**
- * ice_vsi_alloc_q_vectors - Allocate memory for interrupt vectors
+ * ice_vsi_alloc_q_vectors_locked - Allocate memory for interrupt vectors
  * @vsi: the VSI being configured
  *
- * We allocate one q_vector per queue interrupt. If allocation fails we
- * return -ENOMEM.
+ * Should be called only under the netdev lock.
+ * We allocate one q_vector per queue interrupt.
+ *
+ * Return: 0 on success, -ENOMEM if allocation fails.
  */
-int ice_vsi_alloc_q_vectors(struct ice_vsi *vsi)
+int ice_vsi_alloc_q_vectors_locked(struct ice_vsi *vsi)
 {
 	struct device *dev = ice_pf_to_dev(vsi->back);
 	u16 v_idx;
@@ -929,6 +931,30 @@ int ice_vsi_alloc_q_vectors(struct ice_vsi *vsi)
 	return v_idx ? 0 : err;
 }
 
+/**
+ * ice_vsi_alloc_q_vectors - Allocate memory for interrupt vectors
+ * @vsi: the VSI being configured
+ *
+ * We allocate one q_vector per queue interrupt.
+ *
+ * Return: 0 on success, -ENOMEM if allocation fails.
+ */
+int ice_vsi_alloc_q_vectors(struct ice_vsi *vsi)
+{
+	struct net_device *dev = vsi->netdev;
+	int ret;
+
+	if (dev)
+		netdev_lock(dev);
+
+	ret = ice_vsi_alloc_q_vectors_locked(vsi);
+
+	if (dev)
+		netdev_unlock(dev);
+
+	return ret;
+}
+
 /**
  * ice_vsi_map_rings_to_vectors - Map VSI rings to interrupt vectors
  * @vsi: the VSI being configured
@@ -992,10 +1018,12 @@ void ice_vsi_map_rings_to_vectors(struct ice_vsi *vsi)
 }
 
 /**
- * ice_vsi_free_q_vectors - Free memory allocated for interrupt vectors
+ * ice_vsi_free_q_vectors_locked - Free memory allocated for interrupt vectors
  * @vsi: the VSI having memory freed
+ *
+ * Should be called only under the netdev lock.
  */
-void ice_vsi_free_q_vectors(struct ice_vsi *vsi)
+void ice_vsi_free_q_vectors_locked(struct ice_vsi *vsi)
 {
 	int v_idx;
 
@@ -1005,6 +1033,23 @@ void ice_vsi_free_q_vectors(struct ice_vsi *vsi)
 	vsi->num_q_vectors = 0;
 }
 
+/**
+ * ice_vsi_free_q_vectors - Free memory allocated for interrupt vectors
+ * @vsi: the VSI having memory freed
+ */
+void ice_vsi_free_q_vectors(struct ice_vsi *vsi)
+{
+	struct net_device *dev = vsi->netdev;
+
+	if (dev)
+		netdev_lock(dev);
+
+	ice_vsi_free_q_vectors_locked(vsi);
+
+	if (dev)
+		netdev_unlock(dev);
+}
+
 /**
  * ice_cfg_tstamp - Configure Tx time stamp queue
  * @tx_ring: Tx ring to be configured with timestamping
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 041278caf8e3..f647e583d198 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2308,10 +2308,14 @@ static int ice_vsi_cfg_tc_lan(struct ice_pf *pf, struct ice_vsi *vsi)
 }
 
 /**
- * ice_vsi_cfg_def - configure default VSI based on the type
+ * ice_vsi_cfg_def_locked - configure default VSI based on the type
  * @vsi: pointer to VSI
+ *
+ * Should be called only with the netdev lock taken.
+ *
+ * Return: 0 on success, -errno on failure.
  */
-static int ice_vsi_cfg_def(struct ice_vsi *vsi)
+static int ice_vsi_cfg_def_locked(struct ice_vsi *vsi)
 {
 	struct device *dev = ice_pf_to_dev(vsi->back);
 	struct ice_pf *pf = vsi->back;
@@ -2354,7 +2358,7 @@ static int ice_vsi_cfg_def(struct ice_vsi *vsi)
 	case ICE_VSI_CTRL:
 	case ICE_VSI_SF:
 	case ICE_VSI_PF:
-		ret = ice_vsi_alloc_q_vectors(vsi);
+		ret = ice_vsi_alloc_q_vectors_locked(vsi);
 		if (ret)
 			goto unroll_vsi_init;
 
@@ -2404,7 +2408,7 @@ static int ice_vsi_cfg_def(struct ice_vsi *vsi)
 		 * creates a VSI and corresponding structures for bookkeeping
 		 * purpose
 		 */
-		ret = ice_vsi_alloc_q_vectors(vsi);
+		ret = ice_vsi_alloc_q_vectors_locked(vsi);
 		if (ret)
 			goto unroll_vsi_init;
 
@@ -2460,6 +2464,28 @@ static int ice_vsi_cfg_def(struct ice_vsi *vsi)
 	return ret;
 }
 
+/**
+ * ice_vsi_cfg_def - configure default VSI based on the type
+ * @vsi: pointer to VSI
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+static int ice_vsi_cfg_def(struct ice_vsi *vsi)
+{
+	struct net_device *dev = vsi->netdev;
+	int ret;
+
+	if (dev)
+		netdev_lock(dev);
+
+	ret = ice_vsi_cfg_def_locked(vsi);
+
+	if (dev)
+		netdev_unlock(dev);
+
+	return ret;
+}
+
 /**
  * ice_vsi_cfg - configure a previously allocated VSI
  * @vsi: pointer to VSI
@@ -2494,10 +2520,12 @@ int ice_vsi_cfg(struct ice_vsi *vsi)
 }
 
 /**
- * ice_vsi_decfg - remove all VSI configuration
+ * ice_vsi_decfg_locked - remove all VSI configuration
  * @vsi: pointer to VSI
+ *
+ * Should be called only under the netdev lock.
  */
-void ice_vsi_decfg(struct ice_vsi *vsi)
+static void ice_vsi_decfg_locked(struct ice_vsi *vsi)
 {
 	struct ice_pf *pf = vsi->back;
 	int err;
@@ -2515,7 +2543,7 @@ void ice_vsi_decfg(struct ice_vsi *vsi)
 		ice_destroy_xdp_rings(vsi, ICE_XDP_CFG_PART);
 
 	ice_vsi_clear_rings(vsi);
-	ice_vsi_free_q_vectors(vsi);
+	ice_vsi_free_q_vectors_locked(vsi);
 	ice_vsi_put_qs(vsi);
 	ice_vsi_free_arrays(vsi);
 
@@ -2530,6 +2558,23 @@ void ice_vsi_decfg(struct ice_vsi *vsi)
 		vsi->agg_node->num_vsis--;
 }
 
+/**
+ * ice_vsi_decfg - remove all VSI configuration
+ * @vsi: pointer to VSI
+ */
+void ice_vsi_decfg(struct ice_vsi *vsi)
+{
+	struct net_device *dev = vsi->netdev;
+
+	if (dev)
+		netdev_lock(dev);
+
+	ice_vsi_decfg_locked(vsi);
+
+	if (dev)
+		netdev_unlock(dev);
+}
+
 /**
  * ice_vsi_setup - Set up a VSI by a given type
  * @pf: board private structure
@@ -3107,16 +3152,17 @@ ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
 }
 
 /**
- * ice_vsi_rebuild - Rebuild VSI after reset
+ * ice_vsi_rebuild_locked - Rebuild VSI after reset
  * @vsi: VSI to be rebuild
  * @vsi_flags: flags used for VSI rebuild flow
  *
  * Set vsi_flags to ICE_VSI_FLAG_INIT to initialize a new VSI, or
  * ICE_VSI_FLAG_NO_INIT to rebuild an existing VSI in hardware.
+ * Should be called only under the netdev lock.
  *
  * Returns 0 on success and negative value on failure
  */
-int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
+int ice_vsi_rebuild_locked(struct ice_vsi *vsi, u32 vsi_flags)
 {
 	struct ice_coalesce_stored *coalesce;
 	int prev_num_q_vectors;
@@ -3137,8 +3183,8 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
 	if (ret)
 		goto unlock;
 
-	ice_vsi_decfg(vsi);
-	ret = ice_vsi_cfg_def(vsi);
+	ice_vsi_decfg_locked(vsi);
+	ret = ice_vsi_cfg_def_locked(vsi);
 	if (ret)
 		goto unlock;
 
@@ -3175,6 +3221,32 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
 	return ret;
 }
 
+/**
+ * ice_vsi_rebuild - Rebuild VSI after reset
+ * @vsi: VSI to be rebuild
+ * @vsi_flags: flags used for VSI rebuild flow
+ *
+ * Set vsi_flags to ICE_VSI_FLAG_INIT to initialize a new VSI, or
+ * ICE_VSI_FLAG_NO_INIT to rebuild an existing VSI in hardware.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
+{
+	struct net_device *dev = vsi->netdev;
+	int ret;
+
+	if (dev)
+		netdev_lock(dev);
+
+	ret = ice_vsi_rebuild_locked(vsi, vsi_flags);
+
+	if (dev)
+		netdev_unlock(dev);
+
+	return ret;
+}
+
 /**
  * ice_is_reset_in_progress - check for a reset in progress
  * @state: PF state field
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 7a1c6859d708..b9d726797919 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4130,6 +4130,7 @@ bool ice_is_wol_supported(struct ice_hw *hw)
  * @locked: is adev device_lock held
  *
  * Only change the number of queues if new_tx, or new_rx is non-0.
+ * Note that it should be called only with the netdev lock taken.
  *
  * Returns 0 on success.
  */
@@ -4155,7 +4156,7 @@ int ice_vsi_recfg_qs(struct ice_vsi *vsi, int new_rx, int new_tx, bool locked)
 
 	/* set for the next time the netdev is started */
 	if (!netif_running(vsi->netdev)) {
-		err = ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
+		err = ice_vsi_rebuild_locked(vsi, ICE_VSI_FLAG_NO_INIT);
 		if (err)
 			goto rebuild_err;
 		dev_dbg(ice_pf_to_dev(pf), "Link is down, queue count change happens when link is brought up\n");
@@ -4163,7 +4164,7 @@ int ice_vsi_recfg_qs(struct ice_vsi *vsi, int new_rx, int new_tx, bool locked)
 	}
 
 	ice_vsi_close(vsi);
-	err = ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
+	err = ice_vsi_rebuild_locked(vsi, ICE_VSI_FLAG_NO_INIT);
 	if (err)
 		goto rebuild_err;
 
-- 
2.52.0


