Return-Path: <netdev+bounces-28776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DE4780AA8
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 13:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC3728233D
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 11:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C187B182A6;
	Fri, 18 Aug 2023 11:02:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AEF14F61
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 11:02:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7CA270C
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 04:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692356552; x=1723892552;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dHD/2OpQotKC16EyeLGxjmzHd0UMqWyt/RnceI1F81U=;
  b=iE0yaBVJ2ik1JkoyJ/qD8j6qgL3wpoyub/tXV8YQS/RBHG+ZF0hFOYSu
   LIgeZFJmm7hZMZfGXRHGb2CILWYR8Z/0GwP7l1O64dET0BtYzDOM2JXuJ
   i0504s3GB6B7PY9eUH/65fIHBuqc52Ob3jY7y6i7/sXQDJcqEbiXf+f5y
   9JM4AjEfijm/PDU/jgm8ZqqQc2UyDJbcRdcLQErwlxePagCYcsN9Ej5cL
   4J/NQC1kyXkWqjmTZqbNo7+g/qhgQh4XYq5Ehtc+GO1T2aqgkT4+tQVXl
   NR5NTcO6AlzSD4JXhv9pAy7KmIInpfnxA3Sj6ui6vpg2PfzLJ1MKNCF9X
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="370535542"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="370535542"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 04:02:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="825081050"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="825081050"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Aug 2023 04:02:29 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id EF677332A6;
	Fri, 18 Aug 2023 12:02:28 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH iwl-next] ice: remove unused ice_flow_entry fields
Date: Fri, 18 Aug 2023 06:59:29 -0400
Message-Id: <20230818105929.544072-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Remove ::entry and ::entry_sz fields of &ice_flow_entry,
as they were never set.

Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_flow.c | 5 +----
 drivers/net/ethernet/intel/ice/ice_flow.h | 3 ---
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
index 85cca572c22a..fb8b925aaf8b 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.c
+++ b/drivers/net/ethernet/intel/ice/ice_flow.c
@@ -1318,7 +1318,6 @@ ice_flow_rem_entry_sync(struct ice_hw *hw, enum ice_block __always_unused blk,
 
 	list_del(&entry->l_entry);
 
-	devm_kfree(ice_hw_to_dev(hw), entry->entry);
 	devm_kfree(ice_hw_to_dev(hw), entry);
 
 	return 0;
@@ -1645,10 +1644,8 @@ ice_flow_add_entry(struct ice_hw *hw, enum ice_block blk, u64 prof_id,
 	*entry_h = ICE_FLOW_ENTRY_HNDL(e);
 
 out:
-	if (status && e) {
-		devm_kfree(ice_hw_to_dev(hw), e->entry);
+	if (status)
 		devm_kfree(ice_hw_to_dev(hw), e);
-	}
 
 	return status;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_flow.h b/drivers/net/ethernet/intel/ice/ice_flow.h
index b465d27d9b80..96923ef0a5a8 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.h
+++ b/drivers/net/ethernet/intel/ice/ice_flow.h
@@ -350,11 +350,8 @@ struct ice_flow_entry {
 
 	u64 id;
 	struct ice_flow_prof *prof;
-	/* Flow entry's content */
-	void *entry;
 	enum ice_flow_priority priority;
 	u16 vsi_handle;
-	u16 entry_sz;
 };
 
 #define ICE_FLOW_ENTRY_HNDL(e)	((u64)(uintptr_t)e)

base-commit: 52d0f297b37b44066ca22abdcc164766ea49ac18
-- 
2.40.1


