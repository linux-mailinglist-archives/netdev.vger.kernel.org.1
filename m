Return-Path: <netdev+bounces-166948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 500A0A38036
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 11:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 207C416906B
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 10:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E644A216E2B;
	Mon, 17 Feb 2025 10:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L1saTG+k"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522E3216E14
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 10:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788138; cv=none; b=YBlQWIRYNaQnjXin7yjgjgYU0HSqQrIqNI3ok8+YIXGSLKccDOyc3aSh2IxbwXigipAXbzH5E+ETTVqRKfnSETKLMYmXN7cTW7Levg2uM5jWqvwtXZvnhTwVLn+ePUq95S2hqziNsp2HZwrWr/tx9rkDLkjWNt/pZycOBWu8KyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788138; c=relaxed/simple;
	bh=qvH744x9n/EIaRK81PRkt4ItVtZ4IA+MhzAIe0c3AxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQsiURfESykbuPYUa+3jYObH0iIa+Xm97qIY2liYWBdUNxRkNwy/roK3wwY5Tafqv05/9oueD9jQ+qOUpIId8jlglPyNqWQH+fXF3lps3Pz7DcZvlvMcBhUAos1Ovw99k1OFflnpfoyDmIS34FIiWd/oo3GRuOTV86j5z++x610=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L1saTG+k; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739788137; x=1771324137;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qvH744x9n/EIaRK81PRkt4ItVtZ4IA+MhzAIe0c3AxQ=;
  b=L1saTG+kB8nSRp7lBG4IYfNhsbiuRBc9GUWA1qSCt00umjJbAojHuwy7
   KC2tlDC1e5xTN8yHXIBL8hDcY+QSkXl6buoCEEJ/vkLjrNHh6LcgIKM0B
   o46DTgE9rDvxjnGZ3gVaRN1YIB1lzFJtSwxyKK2sN8Gr6Vu69C97Xzlau
   6QaNBmNcyG69NksRBrje4p0e32Jd+CAW87gSKiHmqP06L2zRjLNsZoD1F
   gAtVz8QJWGYoxNG9eMz7JNPFy7A53eSuSdZoP95oOBOVJtD6c679LqO32
   ftcpR8UbL/tL6yV9TV/u+eBuUlAcvTsDVfU+Q7WnY4vdTTaHP+fnoiZKH
   g==;
X-CSE-ConnectionGUID: Mebub26ETfSAK1aGn522/A==
X-CSE-MsgGUID: jADEv+niTfKmt4hno6XEMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="40168442"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="40168442"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 02:28:53 -0800
X-CSE-ConnectionGUID: h3LNOBPlQBCa3ZpNLCw3dw==
X-CSE-MsgGUID: 606Xn9IHREKY1xauiskqxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="114598308"
Received: from enterprise.igk.intel.com ([10.102.20.175])
  by fmviesa010.fm.intel.com with ESMTP; 17 Feb 2025 02:28:51 -0800
From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jan Glaza <jan.glaza@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Subject: [iwl-net 3/4] ice: validate queue quanta parameters to prevent OOB access
Date: Mon, 17 Feb 2025 11:27:47 +0100
Message-ID: <20250217102744.300357-8-martyna.szapar-mudlaw@linux.intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250217102744.300357-2-martyna.szapar-mudlaw@linux.intel.com>
References: <20250217102744.300357-2-martyna.szapar-mudlaw@linux.intel.com>
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
Signed-off-by: Jan Glaza <jan.glaza@intel.com>
Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index 343f2b4b0dc5..adb1bf12542f 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -1903,13 +1903,21 @@ static int ice_vc_cfg_q_bw(struct ice_vf *vf, u8 *msg)
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
@@ -1921,8 +1929,6 @@ static int ice_vc_cfg_q_quanta(struct ice_vf *vf, u8 *msg)
 		goto err;
 	}
 
-	end_qid = qquanta->queue_select.start_queue_id +
-		  qquanta->queue_select.num_queues;
 	if (end_qid > ICE_MAX_RSS_QS_PER_VF ||
 	    end_qid > min_t(u16, vsi->alloc_txq, vsi->alloc_rxq)) {
 		dev_err(ice_pf_to_dev(vf->pf), "VF-%d trying to configure more than allocated number of queues: %d\n",
@@ -1951,7 +1957,6 @@ static int ice_vc_cfg_q_quanta(struct ice_vf *vf, u8 *msg)
 		goto err;
 	}
 
-	start_qid = qquanta->queue_select.start_queue_id;
 	for (i = start_qid; i < end_qid; i++)
 		vsi->tx_rings[i]->quanta_prof_id = quanta_prof_id;
 
-- 
2.47.0


