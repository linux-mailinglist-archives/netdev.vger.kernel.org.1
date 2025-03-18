Return-Path: <netdev+bounces-175887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E10A67DB3
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 21:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83B9A19C81D2
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 20:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED03E207E0B;
	Tue, 18 Mar 2025 20:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dgQDRsHp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1040213227
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 20:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742328329; cv=none; b=MzPvbBg6DGQbV2EzC7DPbm8oGPNS0wtpnViXaMTN3Olg4ZzGjwYpj0sDk3aFh7tuQaeocAhjzzT33hKd+axbfTpnCzm18TdKOcPHWzPLh5v8O1lahCD+ph3ffqhZpeQYcrTHSbDeKL64FuZjsItabPuTWBtYG1u/SDTYiBk51o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742328329; c=relaxed/simple;
	bh=EuZ2mOFCRP/rGVath4UQsx9IGgcsqSgyBOwf8/ki7ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tc0WU+mFi6NFv33UqZtxNjGU0Gbqp2pKJuCtiTwinxtaAD+EyHusr4XYLEuDANvtVVVLM4U2CjFgRVTVBB9OKLfNtAAVGlmSqJkZj/h0skX6NRMkD4vI29BJh5NfVu4ENpRiUv1W6lSfytladoXPTkz/4Fbb8VWP6HY9ydOBlPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dgQDRsHp; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742328325; x=1773864325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EuZ2mOFCRP/rGVath4UQsx9IGgcsqSgyBOwf8/ki7ck=;
  b=dgQDRsHpKv+R6SuRN4GiCtss5RXJFmsmAQ0E88EYTbN8Kdk1nAc5QLKX
   qS8B2rMW9dNjOT0unGuocgu9kVhWXnHJwPzZMDm+3YQ3WDtU6JRpOuNGA
   Qh8WNCpZOk5A51ZWVO80nXRr+iVgtojzEiTToifvmcg06OFY2B/5Xrr/S
   eI9BFLn6a4LIjC2b1OAzR8O1X+iqLq13MPvU8WekmC/HAqExQlSW1P9zu
   /eWqUJzmuJHFLkurEl0n+Wuug236TfmBMx1jZubsdc8cGFaa3UJABwvL6
   TJndDEGkQktynBDYIx1mE60lAQNh8xtREhvCBAfPf8A6QL5i5br28Dm3+
   g==;
X-CSE-ConnectionGUID: tUjqKDQNRIus0PAI/MslVw==
X-CSE-MsgGUID: gponosPVTfKiKjxR4cwfyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43593055"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="43593055"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 13:05:22 -0700
X-CSE-ConnectionGUID: dutpkPZ/S9moRlFKzNmTng==
X-CSE-MsgGUID: r5119TVoSPaXBrshfMCB/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="153363153"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 18 Mar 2025 13:05:21 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jan Glaza <jan.glaza@intel.com>,
	anthony.l.nguyen@intel.com,
	jiri@resnulli.us,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 6/9] ice: validate queue quanta parameters to prevent OOB access
Date: Tue, 18 Mar 2025 13:04:50 -0700
Message-ID: <20250318200511.2958251-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250318200511.2958251-1-anthony.l.nguyen@intel.com>
References: <20250318200511.2958251-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Glaza <jan.glaza@intel.com>

Add queue wraparound prevention in quanta configuration.
Ensure end_qid does not overflow by validating start_qid and num_queues.

Fixes: 015307754a19 ("ice: Support VF queue rate limit and quanta size configuration")
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jan Glaza <jan.glaza@intel.com>
Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index 346aee373ccd..df13f5110168 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -1900,13 +1900,21 @@ static int ice_vc_cfg_q_bw(struct ice_vf *vf, u8 *msg)
  */
 static int ice_vc_cfg_q_quanta(struct ice_vf *vf, u8 *msg)
 {
+	u16 quanta_prof_id, quanta_size, start_qid, num_queues, end_qid, i;
 	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
-	u16 quanta_prof_id, quanta_size, start_qid, end_qid, i;
 	struct virtchnl_quanta_cfg *qquanta =
 		(struct virtchnl_quanta_cfg *)msg;
 	struct ice_vsi *vsi;
 	int ret;
 
+	start_qid = qquanta->queue_select.start_queue_id;
+	num_queues = qquanta->queue_select.num_queues;
+
+	if (check_add_overflow(start_qid, num_queues, &end_qid)) {
+		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+		goto err;
+	}
+
 	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states)) {
 		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 		goto err;
@@ -1918,8 +1926,6 @@ static int ice_vc_cfg_q_quanta(struct ice_vf *vf, u8 *msg)
 		goto err;
 	}
 
-	end_qid = qquanta->queue_select.start_queue_id +
-		  qquanta->queue_select.num_queues;
 	if (end_qid > ICE_MAX_RSS_QS_PER_VF ||
 	    end_qid > min_t(u16, vsi->alloc_txq, vsi->alloc_rxq)) {
 		dev_err(ice_pf_to_dev(vf->pf), "VF-%d trying to configure more than allocated number of queues: %d\n",
@@ -1948,7 +1954,6 @@ static int ice_vc_cfg_q_quanta(struct ice_vf *vf, u8 *msg)
 		goto err;
 	}
 
-	start_qid = qquanta->queue_select.start_queue_id;
 	for (i = start_qid; i < end_qid; i++)
 		vsi->tx_rings[i]->quanta_prof_id = quanta_prof_id;
 
-- 
2.47.1


