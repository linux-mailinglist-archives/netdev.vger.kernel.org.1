Return-Path: <netdev+bounces-42745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3817D0093
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 19:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE1AC28200A
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 17:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB24347DF;
	Thu, 19 Oct 2023 17:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hIhDcgaF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C063335A7
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 17:32:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9852FCF
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697736755; x=1729272755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LmIWwKcsHMK2uHG9SRLAnhRp80bltX+X+1vzzutioUg=;
  b=hIhDcgaF4t4/ugKcSE0YjQ+NG3IAX9JCwAqzgsWCMW7+dnCR1XyxEufg
   QXAryYZy4R47iKWZQh3uvLLiqznKfNM8g4th0QLc1fvW9bH2rsAqZuEmX
   +TA2KJng6rugCH1hZTlfATCUsn1He2j07NYtXWX52kteSMAXNO9QvsTqq
   SxR1AijZW7EYGJR2TqVNL1OQwhTbTGG/wuLM9yWRC2C3Vu/wLhfr/FuG/
   dCeawezJeVidrfIVePbyqiYoslb9EsUvQiYupy1A2JnmwlOVcQTAvqS0K
   kzD7ZSeGGtPrxXXaAew8WvIQsY8xzzLaMJz1UVUJFQiDhDmQJetR1ktqb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="389183673"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="389183673"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 10:32:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="760722671"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="760722671"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 10:32:33 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 01/11] ice: remove unused ice_flow_entry fields
Date: Thu, 19 Oct 2023 10:32:17 -0700
Message-ID: <20231019173227.3175575-2-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019173227.3175575-1-jacob.e.keller@intel.com>
References: <20231019173227.3175575-1-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Remove ::entry and ::entry_sz fields of &ice_flow_entry,
as they were never set.

Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
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
-- 
2.41.0


