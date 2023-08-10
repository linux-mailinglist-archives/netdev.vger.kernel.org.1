Return-Path: <netdev+bounces-26276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FBD777611
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 12:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7377F1C20B01
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A2E1FB3E;
	Thu, 10 Aug 2023 10:38:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6C61FB2D
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 10:38:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242EEE6B;
	Thu, 10 Aug 2023 03:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691663927; x=1723199927;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=08LkNIvUUrKmcl7BD9rhPkjWXkqLmnZRpa2lV/Wo1JU=;
  b=NvgvWrZLBZsJ1h3wv5nfbxpqMdprh5GDpvFtoOVWesFo2VnHZ6Enpb94
   /wBpkOeAZqsbtqsF3c/YMFIIAPOI4exT3WQZaPxKHFAhf0up1tL6swJFD
   lyqICLoAsgKdkPtaf+6DXVw1CxH2hIRfpDv0+t7L5bq9gKdpgWuP52rYm
   bYdz41ZeEHiKMxBu0btSWVEiq5yuQ+6hD8STc0G32onGoOlLTOzzMhTs+
   GSvtFk+j0aQMlqeIavDYn4ppegLKLnse98+cZHqukws9+9RzCU8T/Wrem
   jCmn9zyJ/8/gKP6gi1S7FG8PoPCMScCbsuS2Sgbx37t71dVXDhMFpGbhA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="370260830"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="370260830"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 03:38:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="767237181"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="767237181"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga001.jf.intel.com with ESMTP; 10 Aug 2023 03:38:44 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id C0B0034922;
	Thu, 10 Aug 2023 11:38:43 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: Kees Cook <keescook@chromium.org>,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-hardening@vger.kernel.org,
	Steven Zou <steven.zou@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v1 7/7] ice: make use of DEFINE_FLEX() in ice_switch.c
Date: Thu, 10 Aug 2023 06:35:09 -0400
Message-Id: <20230810103509.163225-8-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230810103509.163225-1-przemyslaw.kitszel@intel.com>
References: <20230810103509.163225-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use DEFINE_FLEX() macro for 1-elem flex array members of ice_switch.c

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
add/remove: 2/2 grow/shrink: 3/6 up/down: 535/-488 (47)
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 63 +++++----------------
 1 file changed, 14 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index a7afb612fe32..df8ba16c5171 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -1812,15 +1812,11 @@ ice_aq_alloc_free_vsi_list(struct ice_hw *hw, u16 *vsi_list_id,
 			   enum ice_sw_lkup_type lkup_type,
 			   enum ice_adminq_opc opc)
 {
-	struct ice_aqc_alloc_free_res_elem *sw_buf;
+	DEFINE_FLEX(struct ice_aqc_alloc_free_res_elem, sw_buf, elem, 1);
+	u16 buf_len = const_flex_size(sw_buf);
 	struct ice_aqc_res_elem *vsi_ele;
-	u16 buf_len;
 	int status;
 
-	buf_len = struct_size(sw_buf, elem, 1);
-	sw_buf = devm_kzalloc(ice_hw_to_dev(hw), buf_len, GFP_KERNEL);
-	if (!sw_buf)
-		return -ENOMEM;
 	sw_buf->num_elems = cpu_to_le16(1);
 
 	if (lkup_type == ICE_SW_LKUP_MAC ||
@@ -1840,25 +1836,22 @@ ice_aq_alloc_free_vsi_list(struct ice_hw *hw, u16 *vsi_list_id,
 			sw_buf->res_type =
 				cpu_to_le16(ICE_AQC_RES_TYPE_VSI_LIST_PRUNE);
 	} else {
-		status = -EINVAL;
-		goto ice_aq_alloc_free_vsi_list_exit;
+		return -EINVAL;
 	}
 
 	if (opc == ice_aqc_opc_free_res)
 		sw_buf->elem[0].e.sw_resp = cpu_to_le16(*vsi_list_id);
 
 	status = ice_aq_alloc_free_res(hw, 1, sw_buf, buf_len, opc, NULL);
 	if (status)
-		goto ice_aq_alloc_free_vsi_list_exit;
+		return status;
 
 	if (opc == ice_aqc_opc_alloc_res) {
 		vsi_ele = &sw_buf->elem[0];
 		*vsi_list_id = le16_to_cpu(vsi_ele->e.sw_resp);
 	}
 
-ice_aq_alloc_free_vsi_list_exit:
-	devm_kfree(ice_hw_to_dev(hw), sw_buf);
-	return status;
+	return 0;
 }
 
 /**
@@ -2088,24 +2081,18 @@ ice_aq_get_recipe_to_profile(struct ice_hw *hw, u32 profile_id, u8 *r_bitmap,
  */
 int ice_alloc_recipe(struct ice_hw *hw, u16 *rid)
 {
-	struct ice_aqc_alloc_free_res_elem *sw_buf;
-	u16 buf_len;
+	DEFINE_FLEX(struct ice_aqc_alloc_free_res_elem, sw_buf, elem, 1);
+	u16 buf_len = const_flex_size(sw_buf);
 	int status;
 
-	buf_len = struct_size(sw_buf, elem, 1);
-	sw_buf = kzalloc(buf_len, GFP_KERNEL);
-	if (!sw_buf)
-		return -ENOMEM;
-
 	sw_buf->num_elems = cpu_to_le16(1);
 	sw_buf->res_type = cpu_to_le16((ICE_AQC_RES_TYPE_RECIPE <<
 					ICE_AQC_RES_TYPE_S) |
 					ICE_AQC_RES_TYPE_FLAG_SHARED);
 	status = ice_aq_alloc_free_res(hw, 1, sw_buf, buf_len,
 				       ice_aqc_opc_alloc_res, NULL);
 	if (!status)
 		*rid = le16_to_cpu(sw_buf->elem[0].e.sw_resp);
-	kfree(sw_buf);
 
 	return status;
 }
@@ -4482,29 +4469,20 @@ int
 ice_alloc_res_cntr(struct ice_hw *hw, u8 type, u8 alloc_shared, u16 num_items,
 		   u16 *counter_id)
 {
-	struct ice_aqc_alloc_free_res_elem *buf;
-	u16 buf_len;
+	DEFINE_FLEX(struct ice_aqc_alloc_free_res_elem, buf, elem, 1);
+	u16 buf_len = const_flex_size(buf);
 	int status;
 
-	/* Allocate resource */
-	buf_len = struct_size(buf, elem, 1);
-	buf = kzalloc(buf_len, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
 	buf->num_elems = cpu_to_le16(num_items);
 	buf->res_type = cpu_to_le16(((type << ICE_AQC_RES_TYPE_S) &
 				      ICE_AQC_RES_TYPE_M) | alloc_shared);
 
 	status = ice_aq_alloc_free_res(hw, 1, buf, buf_len,
 				       ice_aqc_opc_alloc_res, NULL);
 	if (status)
-		goto exit;
+		return status;
 
 	*counter_id = le16_to_cpu(buf->elem[0].e.sw_resp);
-
-exit:
-	kfree(buf);
 	return status;
 }
 
@@ -4520,16 +4498,10 @@ int
 ice_free_res_cntr(struct ice_hw *hw, u8 type, u8 alloc_shared, u16 num_items,
 		  u16 counter_id)
 {
-	struct ice_aqc_alloc_free_res_elem *buf;
-	u16 buf_len;
+	DEFINE_FLEX(struct ice_aqc_alloc_free_res_elem, buf, elem, 1);
+	u16 buf_len = const_flex_size(buf);
 	int status;
 
-	/* Free resource */
-	buf_len = struct_size(buf, elem, 1);
-	buf = kzalloc(buf_len, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
 	buf->num_elems = cpu_to_le16(num_items);
 	buf->res_type = cpu_to_le16(((type << ICE_AQC_RES_TYPE_S) &
 				      ICE_AQC_RES_TYPE_M) | alloc_shared);
@@ -4540,7 +4512,6 @@ ice_free_res_cntr(struct ice_hw *hw, u8 type, u8 alloc_shared, u16 num_items,
 	if (status)
 		ice_debug(hw, ICE_DBG_SW, "counter resource could not be freed\n");
 
-	kfree(buf);
 	return status;
 }
 
@@ -4558,15 +4529,10 @@ ice_free_res_cntr(struct ice_hw *hw, u8 type, u8 alloc_shared, u16 num_items,
  */
 int ice_share_res(struct ice_hw *hw, u16 type, u8 shared, u16 res_id)
 {
-	struct ice_aqc_alloc_free_res_elem *buf;
-	u16 buf_len;
+	DEFINE_FLEX(struct ice_aqc_alloc_free_res_elem, buf, elem, 1);
+	u16 buf_len = const_flex_size(buf);
 	int status;
 
-	buf_len = struct_size(buf, elem, 1);
-	buf = kzalloc(buf_len, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
 	buf->num_elems = cpu_to_le16(1);
 	if (shared)
 		buf->res_type = cpu_to_le16(((type << ICE_AQC_RES_TYPE_S) &
@@ -4584,7 +4550,6 @@ int ice_share_res(struct ice_hw *hw, u16 type, u8 shared, u16 res_id)
 		ice_debug(hw, ICE_DBG_SW, "Could not set resource type %u id %u to %s\n",
 			  type, res_id, shared ? "SHARED" : "DEDICATED");
 
-	kfree(buf);
 	return status;
 }
 
-- 
2.40.1


