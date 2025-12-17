Return-Path: <netdev+bounces-245236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 145B5CC9715
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 20:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 503A5306EDB0
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 19:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1542F60CC;
	Wed, 17 Dec 2025 19:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WqzdLUhM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67BD2F6160
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 19:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766001005; cv=none; b=PjY/a9/gUvgs9ULTyB4msq+bvQJP+f7aeiqpbAFBQ4aiLn+VW3EFsmcluNrRgKoq/rwKz4AuMmFvYMQBvk9VMEzW1y9Xd9+rt+QfP0Sd3O/H5Q79uBR5d/tDvmPP4BFAGWFRUArpUD1Arr0teVXc85KUeQKkw4jgIlPRG9XDcvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766001005; c=relaxed/simple;
	bh=ZyRWIS+MLqrmp2PIwo8i2PObLL513/QCKO+TdjwVCG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PdNt6TofQ5jQg5v7a+BwehwltFUGpkdjyAWgGzh7UrdWR2zZe7mMhX9ff2/FMJlWxMJeLxV0vBni9nWp+0OR3wodTwKq5IUzJbnOKxvFLLQqNezkkeSOS8EqrW72VIUfV9qsFBu5AJGdncp6P7EiacO5nq1lMbm25zKNu66ZMyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WqzdLUhM; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766001004; x=1797537004;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZyRWIS+MLqrmp2PIwo8i2PObLL513/QCKO+TdjwVCG4=;
  b=WqzdLUhM7ZT5iLvhxcdL9sXYDGD+DTf+1ws7YwFKxkRijNObuSqNh9hh
   iaLeOvjROT1xdXIzXdfTy6Vp1KrBaQBEi8dncy3LQANFwb/eb2YGzOyCS
   V5xshVis3ajgQ68mXgEKav0p8nuTDfRt/vhyaLcxrWcKLrV8QDD89s+sw
   FNzmeNvKD59fGkabHQ/bv5mIFHzWtAcVYbkb9LfVrCLaLixPeNm6Zb71R
   CPs8lLynB65zKgTaLhbKfl8IsBaxRDYX7epcAx0nBNgpLRWPtnadaIkOb
   o7/Wy24NPdmPC0sQYRkCfep7hJbLKWGG2+ldjzy2C9fUzo8FGpzDL0kR6
   g==;
X-CSE-ConnectionGUID: bL/BpiU2S06+OmIHwNP76w==
X-CSE-MsgGUID: Wfv9sE9sTyq3KtO1W2PVpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="67841424"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="67841424"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 11:50:02 -0800
X-CSE-ConnectionGUID: K5+ZjnbbSEW4tIyozlpw/A==
X-CSE-MsgGUID: LXqFzQsrRQ6BVjFcaNwGAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="202898039"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 17 Dec 2025 11:50:02 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Gregory Herrero <gregory.herrero@oracle.com>,
	anthony.l.nguyen@intel.com,
	bcreeley@amd.com,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net 2/6] i40e: validate ring_len parameter against hardware-specific values
Date: Wed, 17 Dec 2025 11:49:41 -0800
Message-ID: <20251217194947.2992495-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251217194947.2992495-1-anthony.l.nguyen@intel.com>
References: <20251217194947.2992495-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gregory Herrero <gregory.herrero@oracle.com>

The maximum number of descriptors supported by the hardware is
hardware-dependent and can be retrieved using
i40e_get_max_num_descriptors(). Move this function to a shared header
and use it when checking for valid ring_len parameter rather than using
hardcoded value.

By fixing an over-acceptance issue, behavior change could be seen where
ring_len could now be rejected while configuring rx and tx queues if its
size is larger than the hardware-dependent maximum number of
descriptors.

Fixes: 55d225670def ("i40e: add validation for ring_len param")
Signed-off-by: Gregory Herrero <gregory.herrero@oracle.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h             | 11 +++++++++++
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 12 ------------
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  4 ++--
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index d2d03db2acec..dcb50c2e1aa2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1422,4 +1422,15 @@ static inline struct i40e_veb *i40e_pf_get_main_veb(struct i40e_pf *pf)
 	return (pf->lan_veb != I40E_NO_VEB) ? pf->veb[pf->lan_veb] : NULL;
 }
 
+static inline u32 i40e_get_max_num_descriptors(const struct i40e_pf *pf)
+{
+	const struct i40e_hw *hw = &pf->hw;
+
+	switch (hw->mac.type) {
+	case I40E_MAC_XL710:
+		return I40E_MAX_NUM_DESCRIPTORS_XL710;
+	default:
+		return I40E_MAX_NUM_DESCRIPTORS;
+	}
+}
 #endif /* _I40E_H_ */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index f2c2646ea298..6a47ea0927e9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2013,18 +2013,6 @@ static void i40e_get_drvinfo(struct net_device *netdev,
 		drvinfo->n_priv_flags += I40E_GL_PRIV_FLAGS_STR_LEN;
 }
 
-static u32 i40e_get_max_num_descriptors(struct i40e_pf *pf)
-{
-	struct i40e_hw *hw = &pf->hw;
-
-	switch (hw->mac.type) {
-	case I40E_MAC_XL710:
-		return I40E_MAX_NUM_DESCRIPTORS_XL710;
-	default:
-		return I40E_MAX_NUM_DESCRIPTORS;
-	}
-}
-
 static void i40e_get_ringparam(struct net_device *netdev,
 			       struct ethtool_ringparam *ring,
 			       struct kernel_ethtool_ringparam *kernel_ring,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 8b30a3accd31..1fa877b52f61 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -656,7 +656,7 @@ static int i40e_config_vsi_tx_queue(struct i40e_vf *vf, u16 vsi_id,
 
 	/* ring_len has to be multiple of 8 */
 	if (!IS_ALIGNED(info->ring_len, 8) ||
-	    info->ring_len > I40E_MAX_NUM_DESCRIPTORS_XL710) {
+	    info->ring_len > i40e_get_max_num_descriptors(pf)) {
 		ret = -EINVAL;
 		goto error_context;
 	}
@@ -726,7 +726,7 @@ static int i40e_config_vsi_rx_queue(struct i40e_vf *vf, u16 vsi_id,
 
 	/* ring_len has to be multiple of 32 */
 	if (!IS_ALIGNED(info->ring_len, 32) ||
-	    info->ring_len > I40E_MAX_NUM_DESCRIPTORS_XL710) {
+	    info->ring_len > i40e_get_max_num_descriptors(pf)) {
 		ret = -EINVAL;
 		goto error_param;
 	}
-- 
2.47.1


