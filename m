Return-Path: <netdev+bounces-23368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0607A76BB77
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 19:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B49B9281BD3
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 17:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E2C235B2;
	Tue,  1 Aug 2023 17:37:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D1F2359F
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 17:37:47 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF0710EA
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 10:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690911464; x=1722447464;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6fLEmxnd+0000XODYdFAW/qgkqefuOOtSPAEN237lIo=;
  b=U64vvqwHvwwtecrSG+osnAdc7Xc8LdeWAV432vn8URR7TVP11tzSjEeK
   ujBi+fIp5q2fdLfZ/cKaJHOZrH/szrHoIy8JQhZIcCRM0PNEwjMyyIR0a
   TdiC+ZNYjvnKkKJ4rlYmbW0GaoZ//T/9p4FYHtfYytq6vlw6EzteFtT8q
   Hq2GIgdjZxEnzlL8n9xCC+f5FCAKcz8A/zJJYsd+wGHtQSNcRxwT0gueS
   zxnfU0ccTg6jlOBwm3va/L0bLsQW8xm6HULlQvwTR1xzR8rp0A7aBd7Jl
   1cyk0bT3ym7vMKekyPnbf0R4iLfObIjzeUjR0HfUOy7gEJzlQsUdqObJg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="455740685"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="455740685"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 10:37:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="798769700"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="798769700"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga004.fm.intel.com with ESMTP; 01 Aug 2023 10:37:35 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Marcin Szycik <marcin.szycik@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Simon Horman <simon.horman@corigine.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 4/7] ice: Rename enum ice_pkt_flags values
Date: Tue,  1 Aug 2023 10:31:09 -0700
Message-Id: <20230801173112.3625977-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230801173112.3625977-1-anthony.l.nguyen@intel.com>
References: <20230801173112.3625977-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Marcin Szycik <marcin.szycik@linux.intel.com>

enum ice_pkt_flags contains values such as ICE_PKT_FLAGS_VLAN and
ICE_PKT_FLAGS_TUNNEL, but actually the flags words which they refer to
contain a range of unrelated values - e.g. word 0 (ICE_PKT_FLAGS_VLAN)
contains fields such as from_network and ucast, which have nothing to do
with VLAN. Rename each enum value to ICE_PKT_FLAGS_MDID<number>, so it's
clear in which flags word does some value reside.

Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_protocol_type.h | 8 ++++----
 drivers/net/ethernet/intel/ice/ice_switch.c        | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_protocol_type.h b/drivers/net/ethernet/intel/ice/ice_protocol_type.h
index 9812b98d107f..f6f27361c3cf 100644
--- a/drivers/net/ethernet/intel/ice/ice_protocol_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_protocol_type.h
@@ -393,10 +393,10 @@ enum ice_hw_metadata_offset {
 };
 
 enum ice_pkt_flags {
-	ICE_PKT_FLAGS_VLAN = 0,
-	ICE_PKT_FLAGS_TUNNEL = 1,
-	ICE_PKT_FLAGS_TCP = 2,
-	ICE_PKT_FLAGS_ERROR = 3,
+	ICE_PKT_FLAGS_MDID20 = 0,
+	ICE_PKT_FLAGS_MDID21 = 1,
+	ICE_PKT_FLAGS_MDID22 = 2,
+	ICE_PKT_FLAGS_MDID23 = 3,
 };
 
 struct ice_hw_metadata {
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index dcbb69bc9f5a..a7afb612fe32 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -6058,21 +6058,21 @@ ice_adv_add_update_vsi_list(struct ice_hw *hw,
 void ice_rule_add_tunnel_metadata(struct ice_adv_lkup_elem *lkup)
 {
 	lkup->type = ICE_HW_METADATA;
-	lkup->m_u.metadata.flags[ICE_PKT_FLAGS_TUNNEL] |=
+	lkup->m_u.metadata.flags[ICE_PKT_FLAGS_MDID21] |=
 		cpu_to_be16(ICE_PKT_TUNNEL_MASK);
 }
 
 void ice_rule_add_direction_metadata(struct ice_adv_lkup_elem *lkup)
 {
 	lkup->type = ICE_HW_METADATA;
-	lkup->m_u.metadata.flags[ICE_PKT_FLAGS_VLAN] |=
+	lkup->m_u.metadata.flags[ICE_PKT_FLAGS_MDID20] |=
 		cpu_to_be16(ICE_PKT_FROM_NETWORK);
 }
 
 void ice_rule_add_vlan_metadata(struct ice_adv_lkup_elem *lkup)
 {
 	lkup->type = ICE_HW_METADATA;
-	lkup->m_u.metadata.flags[ICE_PKT_FLAGS_VLAN] |=
+	lkup->m_u.metadata.flags[ICE_PKT_FLAGS_MDID20] |=
 		cpu_to_be16(ICE_PKT_VLAN_MASK);
 }
 
-- 
2.38.1


