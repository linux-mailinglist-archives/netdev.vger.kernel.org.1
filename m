Return-Path: <netdev+bounces-293929-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eB+fLe8gHmr3hQkAu9opvQ
	(envelope-from <netdev+bounces-293929-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 02:16:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9A3626823
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 02:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C95CE3046073
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 00:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538282DF142;
	Tue,  2 Jun 2026 00:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J5SqTnRP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1442E6CB3
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 00:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780359335; cv=none; b=fXUz5wlYhtD2H3EMlCreY3frKhsuBJ4xOu7wmgdn0jVRddHNnwu6abxvUHFN296QrzlBAAyZZaiPB4QSIrXeh0Giuu1qMku3qqo1gcVQjp++kD4T93HfkZN3EVYLyL81cUHZe/IJiod0RYyAQX8YiYFFAMIplFJmR4wuNvvq730=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780359335; c=relaxed/simple;
	bh=2R5YQ5HwMWaPXShLbmuxsPxxykQE+hg8tNL3ARg9LyA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RDoyKPKAytNvgMQhojjeDNjOIWR5BHCnyp0e2pP50tuCm4hkrwjJWbIyRiW7Ker6tuj38iWq9ktt/jxqfNOFbc9DNMqiZ0Q6M3wmYpt1IUf3q0Rqi7QgszyFXYLniP1R12htVLmltIedJmwHB+i+Pxv/rGnb85D7a4V5L/+XEa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J5SqTnRP; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780359334; x=1811895334;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=2R5YQ5HwMWaPXShLbmuxsPxxykQE+hg8tNL3ARg9LyA=;
  b=J5SqTnRPE9ABQjLC8i4CkQWbgXdrGboPTUaTo7szDYmikOAlERHJkKIY
   pYB5/En7O12TEqh30pYvMBEQt7iJixHV02OGtKIyZB1lHFkuffMVfSSsv
   jBEsZ4WDwAugbSjuJ+UbTLgbCRSplU1iRz1T1p7eTVY9bvnuUf1cEYlUO
   2zb8m1IV1bkShCnJhVNwGiqE2IxdUGMB43uMUFFh4pSwcCZqjSdDpNlOa
   urjxg5DpQ4jrEOatxWCco3NPHhAFHPaszA0u1s9/yQtW0PEKpXSQ6x9sw
   Hl9J2ohvO5IIxzlMPgcPSBbCrZPPiYCDPmcq3fuZcCLITAptYwMoiaHKw
   A==;
X-CSE-ConnectionGUID: STGOHs1PS0qk1axpTZe5/Q==
X-CSE-MsgGUID: hiM3sGqVQBGeQZodNvrHVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="84755429"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="84755429"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 17:15:31 -0700
X-CSE-ConnectionGUID: bylcpzkUTGSFqH47nIGlHQ==
X-CSE-MsgGUID: kKe+Gw4YQqG2og9RrFs4BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="267598728"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 17:15:31 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 01 Jun 2026 17:14:22 -0700
Subject: [PATCH iwl-next 5/6] ice: remove unused aggregator node functions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-jk-cleanup-vsi-aggregator-nodes-v1-5-36d6ecbe5ede@intel.com>
References: <20260601-jk-cleanup-vsi-aggregator-nodes-v1-0-36d6ecbe5ede@intel.com>
In-Reply-To: <20260601-jk-cleanup-vsi-aggregator-nodes-v1-0-36d6ecbe5ede@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 netdev@vger.kernel.org, Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
X-Mailer: b4 0.16-dev-3fed5
X-Developer-Signature: v=1; a=openpgp-sha256; l=3346;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=2R5YQ5HwMWaPXShLbmuxsPxxykQE+hg8tNL3ARg9LyA=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhiw5hYW3VrxeJsF4am50m8QRTV7Nk1Ym1p/K9j8/ZuN6x
 ClIvPx6RykLgxgXg6yYIouCQ8jK68YTwrTeOMvBzGFlAhnCwMUpABOZL8nwP2uv/Od1opO+uLzZ
 wvTpdEqH96/NjFIXNU675gVxzTVtCGVkmHppdTBbXLFr6dGEVz0GbxwKmS9P37Jp9zH/k4wCpS+
 0mQA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293929-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 1F9A3626823
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

With the introduction of ice_cfg_vsi_agg(), the ice_cfg_agg() and
ice_move_vsi_to_agg() functions are no longer used. Remove them.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sched.h |  6 ----
 drivers/net/ethernet/intel/ice/ice_sched.c | 50 ------------------------------
 2 files changed, 56 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.h b/drivers/net/ethernet/intel/ice/ice_sched.h
index b9ea9174f3d9..30b55bab09d3 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.h
+++ b/drivers/net/ethernet/intel/ice/ice_sched.h
@@ -140,12 +140,6 @@ int ice_cfg_vsi_agg(struct ice_port_info *pi, u16 vsi_handle,
 		    u32 min_id, u32 max_id, u8 tc_bitmap,
 		    u32 *configured_id);
 int
-ice_cfg_agg(struct ice_port_info *pi, u32 agg_id,
-	    enum ice_agg_type agg_type, u8 tc_bitmap);
-int
-ice_move_vsi_to_agg(struct ice_port_info *pi, u32 agg_id, u16 vsi_handle,
-		    u8 tc_bitmap);
-int
 ice_cfg_q_bw_lmt(struct ice_port_info *pi, u16 vsi_handle, u8 tc,
 		 u16 q_handle, enum ice_rl_type rl_type, u32 bw);
 int
diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index a7f31e84ee14..c45e9076518d 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -2798,30 +2798,6 @@ ice_sched_cfg_agg(struct ice_port_info *pi, u32 agg_id,
 	return status;
 }
 
-/**
- * ice_cfg_agg - config aggregator node
- * @pi: port information structure
- * @agg_id: aggregator ID
- * @agg_type: aggregator type queue, VSI, or aggregator group
- * @tc_bitmap: bits TC bitmap
- *
- * This function configures aggregator node(s).
- */
-int
-ice_cfg_agg(struct ice_port_info *pi, u32 agg_id, enum ice_agg_type agg_type,
-	    u8 tc_bitmap)
-{
-	unsigned long bitmap = tc_bitmap;
-	int status;
-
-	mutex_lock(&pi->sched_lock);
-	status = ice_sched_cfg_agg(pi, agg_id, agg_type, &bitmap);
-	if (!status)
-		status = ice_save_agg_tc_bitmap(pi, agg_id, &bitmap);
-	mutex_unlock(&pi->sched_lock);
-	return status;
-}
-
 /**
  * ice_get_agg_vsi_info - get the aggregator ID
  * @agg_info: aggregator info
@@ -3073,32 +3049,6 @@ ice_sched_cfg_node_bw_alloc(struct ice_hw *hw, struct ice_sched_node *node,
 	return ice_sched_update_elem(hw, node, &buf);
 }
 
-/**
- * ice_move_vsi_to_agg - moves VSI to new or default aggregator
- * @pi: port information structure
- * @agg_id: aggregator ID
- * @vsi_handle: software VSI handle
- * @tc_bitmap: TC bitmap of enabled TC(s)
- *
- * Move or associate VSI to a new or default aggregator node.
- */
-int
-ice_move_vsi_to_agg(struct ice_port_info *pi, u32 agg_id, u16 vsi_handle,
-		    u8 tc_bitmap)
-{
-	unsigned long bitmap = tc_bitmap;
-	int status;
-
-	mutex_lock(&pi->sched_lock);
-	status = ice_sched_assoc_vsi_to_agg(pi, agg_id, vsi_handle,
-					    (unsigned long *)&bitmap);
-	if (!status)
-		status = ice_save_agg_vsi_tc_bitmap(pi, agg_id, vsi_handle,
-						    (unsigned long *)&bitmap);
-	mutex_unlock(&pi->sched_lock);
-	return status;
-}
-
 /**
  * ice_find_available_agg - Find or create aggregator node
  * @hw: pointer to the HW structure

-- 
2.54.0.1064.gd145956f57df


