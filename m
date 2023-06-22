Return-Path: <netdev+bounces-13090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2146073A22D
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 15:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1F0C281996
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 13:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDEE1F175;
	Thu, 22 Jun 2023 13:49:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F287A1D2D1
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 13:49:01 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F651994
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 06:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687441740; x=1718977740;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2U8ba/PFFG8NcXM4ie8ydtVJGrdtthQJRmmJQI+Koik=;
  b=VhAS9XjcorueQPPqjXSMQOyYT/XziI6sAVpm3L7Rpc03Bz0AZBSYBjv0
   VHYmRzFPpnOvcL+CtGuqbAc0TFjYsXMF8GLjxfwZo4L0CPFO7Gu4qWeq7
   y8Y+dCRwuMoEQ9RC5+n8xz174b6ULgpjQIdbRrw9gSapfZio7aLkC+SFa
   QV2+VnpqhIcqkM6mlCQbmm0woSAs9DySGvISsX/U7+Lt4k15HMzZARdaR
   GYQN8uuKmllfDwEJzQ1EGz+GEASL6HFVQ7HXL+iyfuzMffFDwZUeUqsb1
   fAfDrWKoEkGXB4oYX3z/3iBSmqdH6YsDrvejEpUSjQLJNL2OiLQgzxus1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="390234096"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="390234096"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 06:49:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="804791814"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="804791814"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jun 2023 06:48:59 -0700
Received: from giewont.igk.intel.com (giewont.igk.intel.com [10.211.8.15])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 6C3FC34947;
	Thu, 22 Jun 2023 14:48:58 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH iwl-next 2/2] ice: Rename enum ice_pkt_flags values
Date: Thu, 22 Jun 2023 15:35:13 +0200
Message-Id: <20230622133513.28551-3-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230622133513.28551-1-marcin.szycik@linux.intel.com>
References: <20230622133513.28551-1-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

enum ice_pkt_flags contains values such as ICE_PKT_FLAGS_VLAN and
ICE_PKT_FLAGS_TUNNEL, but actually the flags words which they refer to
contain a range of unrelated values - e.g. word 0 (ICE_PKT_FLAGS_VLAN)
contains fields such as from_network and ucast, which have nothing to do
with VLAN. Rename each enum value to ICE_PKT_FLAGS_MDID<number>, so it's
clear in which flags word does some value reside.

Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_protocol_type.h | 8 ++++----
 drivers/net/ethernet/intel/ice/ice_switch.c        | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_protocol_type.h b/drivers/net/ethernet/intel/ice/ice_protocol_type.h
index 82491f6af6d0..755a9c55267c 100644
--- a/drivers/net/ethernet/intel/ice/ice_protocol_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_protocol_type.h
@@ -404,10 +404,10 @@ enum ice_hw_metadata_offset {
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
index 28fb175f0fe4..f962d3350332 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -6143,21 +6143,21 @@ ice_adv_add_update_vsi_list(struct ice_hw *hw,
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
2.31.1


