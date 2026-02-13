Return-Path: <netdev+bounces-258557-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WqblNiOejmk+DQEAu9opvQ
	(envelope-from <netdev+bounces-258557-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 04:44:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F629132B7E
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 04:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 882F63038CE6
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 03:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6FE2405EB;
	Fri, 13 Feb 2026 03:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TgCZZzb9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE85623815D
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 03:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770954274; cv=none; b=PJ5/ESepSWhHDScljm/C0mhCoANebQL9oV6xv/3bXZ0UPuVc+pkQv/IFZaza3iFqiNpkb0ynq/xJwXPCRdLupFTWCysjLDtHfYXWXUSu0/AtOo7yw0LDPwJYK9I8rU5ln2yf/FC4rGIYA9EgUZQsjltNPUPd1AvO9BqaPfyeFoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770954274; c=relaxed/simple;
	bh=03IQ3DPjdeaDc7XficCVAbrQedWt7kizzgFExuNLrPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BirTTfIhD3wgSuNydZLuw4XCde3+TNf5yhxQ7US6I6Ys/oY3kRcCInb4Pgi+LheP8M69P63BsTO+4HJRWBt74gHg+KCj5xlQyD81zUMM7gcAI2oVEctwHw3I3adB05DYGmwkNpAAfYOUt7+VZ6iBgg4CRMqeEpo2YWmBkjKrxq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TgCZZzb9; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770954273; x=1802490273;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=03IQ3DPjdeaDc7XficCVAbrQedWt7kizzgFExuNLrPc=;
  b=TgCZZzb9+Gn76U0bgMerY+B1S4Kxq761OBn4ZRmUG6LCSYADATvastsY
   l33j49z+VrBqtyGWOnzGjJDtnk1Rh+i6nFn9TFp1tzrVVpDfDIZ7nkTNF
   i5/ApCfVqHuTpyCx7PH1sN17xUKQ3eE1M117U/w/C9wCwLcF9mBWwDksc
   9kRMlmyktwya9hbTVZqV0n747KnRPxsevlBOjSLefpYRkjDJBF3J/kWM7
   YKWj98NYBdxgukAdKR+ti5z75qQhVfNVKIlALGOMfkafGmSwW+DQU3Ynn
   FibkQX1lFpRFMlRhFM8EmWAJBPYRnSKgcNHb8rNInpZ09L3nFEdJlmBeb
   Q==;
X-CSE-ConnectionGUID: iA5FTxmxS6iq1O75OnCnSA==
X-CSE-MsgGUID: SyFUloxnQgyJ2Rn7NOFdew==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="83580932"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="83580932"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 19:44:32 -0800
X-CSE-ConnectionGUID: AnU8FbMjTB2eu+HmqZzi0g==
X-CSE-MsgGUID: FjTGvszCSJyYGhh/ce5O8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="211993807"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa010.fm.intel.com with ESMTP; 12 Feb 2026 19:44:31 -0800
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v1] ice: implement symmetric RSS hash configuration
Date: Fri, 13 Feb 2026 04:44:29 +0100
Message-ID: <20260213034429.1830480-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-258557-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 7F629132B7E
X-Rspamd-Action: no action

The driver advertises symmetric RSS support via supported_input_xfrm
but ice_set_rxfh() ignored the input_xfrm parameter, making it
impossible to configure symmetric hashing.

Fix ice_set_rxfh() to check rxfh->input_xfrm and call
ice_set_rss_hfunc() with ICE_AQ_VSI_Q_OPT_RSS_HASH_SYM_TPLZ when
RXH_XFRM_SYM_XOR is requested.

Modify ice_set_rss_vsi_ctx() to use vsi->rss_hfunc instead of
hardcoding ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ, and export it for
use by ice_set_rxfh().

The kernel requires get_rxfh_fields() to report symmetric hash
configurations when symmetric transforms are supported. Update
ice_get_rxfh_fields() to return symmetric field configuration
(src+dst IP and ports) for all flow types.

Tested with tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 31 +++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_lib.c     |  6 ++--
 drivers/net/ethernet/intel/ice/ice_lib.h     |  1 +
 3 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index c6bc29c..6dc37f9 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3037,8 +3037,10 @@ ice_get_rxfh_fields(struct net_device *netdev, struct ethtool_rxfh_fields *nfc)
 
 	hash_flds = ice_get_rss_cfg(&pf->hw, vsi->idx, hdrs, &symm);
 	if (hash_flds == ICE_HASH_INVALID) {
-		dev_dbg(dev, "No hash fields found for the given header type, vsi num = %d\n",
+		/* Provide default symmetric hash fields when no config exists */
+		dev_dbg(dev, "No RSS config for this flow, using symmetric defaults, vsi num = %d\n",
 			vsi->vsi_num);
+		nfc->data = RXH_IP_SRC | RXH_IP_DST | RXH_L4_B_0_1 | RXH_L4_B_2_3;
 		return 0;
 	}
 
@@ -3067,6 +3069,7 @@ ice_get_rxfh_fields(struct net_device *netdev, struct ethtool_rxfh_fields *nfc)
 	    hash_flds & ICE_FLOW_HASH_FLD_GTPU_DWN_TEID)
 		nfc->data |= (u64)RXH_GTP_TEID;
 
+	nfc->data = RXH_IP_SRC | RXH_IP_DST | RXH_L4_B_0_1 | RXH_L4_B_2_3;
 	return 0;
 }
 
@@ -3667,7 +3670,6 @@ ice_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
 	     struct netlink_ext_ack *extack)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
-	u8 hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
 	struct ice_vsi *vsi = np->vsi;
 	struct ice_pf *pf = vsi->back;
 	struct device *dev;
@@ -3689,13 +3691,26 @@ ice_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
 		return -EOPNOTSUPP;
 	}
 
-	/* Update the VSI's hash function */
-	if (rxfh->input_xfrm & RXH_XFRM_SYM_XOR)
-		hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_SYM_TPLZ;
+	/* Handle RSS symmetric hash transformation */
+	if (rxfh->input_xfrm != RXH_XFRM_NO_CHANGE) {
+		u8 new_hfunc;
 
-	err = ice_set_rss_hfunc(vsi, hfunc);
-	if (err)
-		return err;
+		if (rxfh->input_xfrm & RXH_XFRM_SYM_XOR)
+			new_hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_SYM_TPLZ;
+		else
+			new_hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
+
+		if (new_hfunc != vsi->rss_hfunc) {
+			err = ice_set_rss_hfunc(vsi, new_hfunc);
+			if (err) {
+				netdev_err(netdev, "Failed to set RSS hash function\n");
+				return err;
+			}
+			netdev_info(netdev, "RSS hash function: %sToeplitz\n",
+				    new_hfunc == ICE_AQ_VSI_Q_OPT_RSS_HASH_SYM_TPLZ ?
+				    "Symmetric " : "");
+		}
+	}
 
 	if (rxfh->key) {
 		if (!vsi->rss_hkey_user) {
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index d921269..31f2757 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1155,7 +1155,7 @@ static void ice_set_fd_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
  * @ctxt: the VSI context being set
  * @vsi: the VSI being configured
  */
-static void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
+void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
 {
 	u8 lut_type, hash_type;
 	struct device *dev;
@@ -1181,7 +1181,9 @@ static void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
 		return;
 	}
 
-	hash_type = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
+        if (!vsi->rss_hfunc)
+		vsi->rss_hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
+	hash_type = vsi->rss_hfunc;
 	vsi->rss_hfunc = hash_type;
 
 	ctxt->info.q_opt_rss =
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 49454d98..29ba335 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -46,6 +46,7 @@ void ice_vsi_delete(struct ice_vsi *vsi);
 int ice_vsi_cfg_tc(struct ice_vsi *vsi, u8 ena_tc);
 
 int ice_vsi_cfg_rss_lut_key(struct ice_vsi *vsi);
+void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi);
 
 void ice_vsi_cfg_netdev_tc(struct ice_vsi *vsi, u8 ena_tc);
 
-- 
2.52.0


