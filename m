Return-Path: <netdev+bounces-239372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5ABC673D6
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 05:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C4634E14B7
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 04:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4139E284682;
	Tue, 18 Nov 2025 04:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hN35qaLe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2B0281520
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 04:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763439784; cv=none; b=E1f7VUuooJw2AD0M+Kh9xdh3o3uj2x4iSP3+aiQsggyrHwjMMoWUB4O7WiP2qsnW/ZxAU0V0m5YxHWJPBwJkpIsNQ79u2+5bYzCZhltrKK94bVztR+AujM7t6XN1LoFGIrue4H7q1I7WU7ApLk1Zqwpw7K6bEAs4L1sEe7iCVs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763439784; c=relaxed/simple;
	bh=h8D1OMEO/b44JUjXd7SQW2NPCYE1/ueBzo0nde0BOmM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lsdNln5Rl6d31J5g2AOrji7GqDgm99x1w94rc1kaaJUOyIdIOABSaWqRsEEtUlJ+7hJSYSeD2+0Kv7AorrEdUYh36bYi5xcIPenkDqWoSezZsE/OWt+pcYtP4EJgKQNC7vYKdtPYcVtGIEWwArXALgICDLxoIqIhGV1d4yPZAtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hN35qaLe; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763439783; x=1794975783;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h8D1OMEO/b44JUjXd7SQW2NPCYE1/ueBzo0nde0BOmM=;
  b=hN35qaLeLOs4L3shakHo2GXgiaJkAKc9PFLqteIgjBuAGl2CqpnkeY3P
   DKlQk06PyxmbB7Q6vvbVyeCO8LnYPti15jeuDF1oIcruN1zO5xyQkMlF6
   9WXVpC5IVCQx8NIhKgIRemyD35PTA2ZSdzrN+8emfjYbi+REKFLImhhPV
   NW1RxADdeo0BmObBCtYziJbqavsP8BO8PUd/TpFObtFH8u4KxKnXyUE9F
   uVmcLgZW8ok2fjICky3XNSAzMac/BSA1lF8pYURgJPV2RIUfznRhLMSju
   eXIF9d3y7v94KE4ZE3kGjwf9iouRrq/BtlYrE3ocxg/9Ad/d/p9PkrHnd
   w==;
X-CSE-ConnectionGUID: o0qcloGKTvuFi99kiFrsxg==
X-CSE-MsgGUID: 6wUT+QynQiG2hHhzHzer7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="82843590"
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="82843590"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 20:23:02 -0800
X-CSE-ConnectionGUID: E5hzWeKSSMaFzSuyrrQQ+A==
X-CSE-MsgGUID: aBMBEefGTfewHrfumAhlow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="191086482"
Received: from aus-labsrv3.an.intel.com ([10.123.116.23])
  by fmviesa009.fm.intel.com with ESMTP; 17 Nov 2025 20:23:01 -0800
From: Sreedevi Joshi <sreedevi.joshi@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Sreedevi Joshi <sreedevi.joshi@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>
Subject: [PATCH iwl-net 2/3] idpf: Fix RSS LUT configuration on down interfaces
Date: Mon, 17 Nov 2025 22:22:27 -0600
Message-Id: <20251118042228.381667-3-sreedevi.joshi@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251118042228.381667-1-sreedevi.joshi@intel.com>
References: <20251118042228.381667-1-sreedevi.joshi@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RSS LUT provisioning and queries on a down interface currently return
silently without effect. Users should be able to configure RSS settings
even when the interface is down.

Fix by maintaining RSS configuration changes in the driver's soft copy and
deferring HW programming until the interface comes up.

Fixes: 02cbfba1add5 ("idpf: add ethtool callbacks")
Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Reviewed-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index 4c6e52253ae4..d9903a21972a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -393,7 +393,10 @@ static u32 idpf_get_rxfh_indir_size(struct net_device *netdev)
  * @netdev: network interface device structure
  * @rxfh: pointer to param struct (indir, key, hfunc)
  *
- * Reads the indirection table directly from the hardware. Always returns 0.
+ * RSS LUT and Key information are read from driver's cached
+ * copy. When rxhash is off, rss lut will be displayed as zeros.
+ *
+ * Returns 0 on success.
  */
 static int idpf_get_rxfh(struct net_device *netdev,
 			 struct ethtool_rxfh_param *rxfh)
@@ -401,10 +404,13 @@ static int idpf_get_rxfh(struct net_device *netdev,
 	struct idpf_netdev_priv *np = netdev_priv(netdev);
 	struct idpf_rss_data *rss_data;
 	struct idpf_adapter *adapter;
+	struct idpf_vport *vport;
+	bool rxhash_ena;
 	int err = 0;
 	u16 i;
 
 	idpf_vport_ctrl_lock(netdev);
+	vport = idpf_netdev_to_vport(netdev);
 
 	adapter = np->adapter;
 
@@ -414,9 +420,8 @@ static int idpf_get_rxfh(struct net_device *netdev,
 	}
 
 	rss_data = &adapter->vport_config[np->vport_idx]->user_config.rss_data;
-	if (np->state != __IDPF_VPORT_UP)
-		goto unlock_mutex;
 
+	rxhash_ena = idpf_is_feature_ena(vport, NETIF_F_RXHASH);
 	rxfh->hfunc = ETH_RSS_HASH_TOP;
 
 	if (rxfh->key)
@@ -424,7 +429,7 @@ static int idpf_get_rxfh(struct net_device *netdev,
 
 	if (rxfh->indir) {
 		for (i = 0; i < rss_data->rss_lut_size; i++)
-			rxfh->indir[i] = rss_data->rss_lut[i];
+			rxfh->indir[i] = (rxhash_ena) ? rss_data->rss_lut[i] : 0;
 	}
 
 unlock_mutex:
@@ -464,8 +469,6 @@ static int idpf_set_rxfh(struct net_device *netdev,
 	}
 
 	rss_data = &adapter->vport_config[vport->idx]->user_config.rss_data;
-	if (np->state != __IDPF_VPORT_UP)
-		goto unlock_mutex;
 
 	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
 	    rxfh->hfunc != ETH_RSS_HASH_TOP) {
@@ -481,6 +484,8 @@ static int idpf_set_rxfh(struct net_device *netdev,
 			rss_data->rss_lut[lut] = rxfh->indir[lut];
 	}
 
+	if (np->state != __IDPF_VPORT_UP)
+		goto unlock_mutex;
 	err = idpf_config_rss(vport);
 
 unlock_mutex:
-- 
2.43.0


