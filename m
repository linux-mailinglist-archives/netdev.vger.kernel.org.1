Return-Path: <netdev+bounces-208885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBFBB0D7C7
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 13:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B551548400
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 11:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE572E267B;
	Tue, 22 Jul 2025 11:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EsIrs5uj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F015F288523
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 11:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753182421; cv=none; b=dsZMoY3MIV7Ow5jWQ70SrB8KmluVpwAvDWKQ10sML1SC/0LJAJ29qnAHsK96WWACfvIYZuIUF/OpLFDmTEVK/IYygR+i9fZRqctNkA9fxXO8zUjNeN1SY+07yn188ckWcK5Kzo3CX6O4Cbn7fXxqJ4N25XWyC8hO1ErutZBk3zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753182421; c=relaxed/simple;
	bh=LBeEu8B+l6M6Pppf5tohqwrjCPwLtmbFMnPPp5cFrbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gv2x1fbMYECAI0LC7TsNWJrE7pAYOQfKOVawcV6ty2DeyYakMLqREAXazYdRBxpdRWCJlv0rRhImk9rtPfXBgRKzJcdoR4MCyQyqxA8HUFqmZy6Gvhe2PHRiduFSZkRZIaome/KYQuaJor/t7JzW1iBIqXnMUtuFiLxMx2wizng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EsIrs5uj; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753182420; x=1784718420;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LBeEu8B+l6M6Pppf5tohqwrjCPwLtmbFMnPPp5cFrbE=;
  b=EsIrs5ujXF/l3NC6EIJldxxzinKOj6WvQcOgPPyULCW/ZjzKZFdWwmu8
   gxh3V8skMvM55LWVrnzSZMQU6QZyHbYto2KI1QL2JCEvkwYF7ugGKnA7c
   GW/GV4ZSi1LNSLCtzbV0K23Vu1Te4jW/eQYBwy2YYzjDJMt8aUOFOnYae
   AvNlIDnN2TjwJTnSSpE8rYYUS6GQ5/2NC/joFmQLCPhPfNreIWmEKdVWQ
   yrT7StO59ReQF/tqkihQCa6Ia6YXZ17xpacKKd85O0f1bqYIaBozFfsyl
   WMRKff35fvpmevJEJkIyhEVYoyt4IVxh0o4w7nCfk3XgbPOaVvHF9dkAE
   Q==;
X-CSE-ConnectionGUID: FAG7yTyQSXewp9rqDt4ZuA==
X-CSE-MsgGUID: wBlNN92HRSu8nrl9JQh17w==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="59083582"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="59083582"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 04:07:00 -0700
X-CSE-ConnectionGUID: 7wOJTViTRHCCz3YAX5m0Wg==
X-CSE-MsgGUID: q5NS+bowR6aa3avH+toFrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="163153926"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
  by fmviesa003.fm.intel.com with ESMTP; 22 Jul 2025 04:06:58 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	dawid.osuchowski@linux.intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v1 02/15] ice: move get_fwlog_data() to fwlog file
Date: Tue, 22 Jul 2025 12:45:47 +0200
Message-ID: <20250722104600.10141-3-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250722104600.10141-1-michal.swiatkowski@linux.intel.com>
References: <20250722104600.10141-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the function prototype to receive hw structure instead of pf to
simplify the call. Instead of passing whole event pass only msg_buf
pointer and length.

Make ice_fwlog_ring_full() static as it isn't  called from any other
context.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_fwlog.c | 27 +++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_fwlog.h |  2 +-
 drivers/net/ethernet/intel/ice/ice_main.c  | 29 ++--------------------
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.c b/drivers/net/ethernet/intel/ice/ice_fwlog.c
index e48856206648..ea5d6d2d3f30 100644
--- a/drivers/net/ethernet/intel/ice/ice_fwlog.c
+++ b/drivers/net/ethernet/intel/ice/ice_fwlog.c
@@ -6,7 +6,7 @@
 #include "ice_common.h"
 #include "ice_fwlog.h"
 
-bool ice_fwlog_ring_full(struct ice_fwlog_ring *rings)
+static bool ice_fwlog_ring_full(struct ice_fwlog_ring *rings)
 {
 	u16 head, tail;
 
@@ -456,3 +456,28 @@ int ice_fwlog_unregister(struct ice_hw *hw)
 
 	return status;
 }
+
+/**
+ * ice_get_fwlog_data - copy the FW log data from ARQ event
+ * @hw: HW that the FW log event is associated with
+ * @buf: event buffer pointer
+ * @len: len of event descriptor
+ */
+void ice_get_fwlog_data(struct ice_hw *hw, u8 *buf, u16 len)
+{
+	struct ice_fwlog_data *fwlog;
+
+	fwlog = &hw->fwlog_ring.rings[hw->fwlog_ring.tail];
+
+	memset(fwlog->data, 0, PAGE_SIZE);
+	fwlog->data_size = len;
+
+	memcpy(fwlog->data, buf, fwlog->data_size);
+	ice_fwlog_ring_increment(&hw->fwlog_ring.tail, hw->fwlog_ring.size);
+
+	if (ice_fwlog_ring_full(&hw->fwlog_ring)) {
+		/* the rings are full so bump the head to create room */
+		ice_fwlog_ring_increment(&hw->fwlog_ring.head,
+					 hw->fwlog_ring.size);
+	}
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.h b/drivers/net/ethernet/intel/ice/ice_fwlog.h
index 7d95d11b6ef9..5b9244f4f0f1 100644
--- a/drivers/net/ethernet/intel/ice/ice_fwlog.h
+++ b/drivers/net/ethernet/intel/ice/ice_fwlog.h
@@ -64,7 +64,6 @@ struct ice_fwlog_ring {
 #define ICE_FWLOG_RING_SIZE_DFLT 256
 #define ICE_FWLOG_RING_SIZE_MAX 512
 
-bool ice_fwlog_ring_full(struct ice_fwlog_ring *rings);
 bool ice_fwlog_ring_empty(struct ice_fwlog_ring *rings);
 void ice_fwlog_ring_increment(u16 *item, u16 size);
 int ice_fwlog_init(struct ice_hw *hw);
@@ -73,4 +72,5 @@ int ice_fwlog_set(struct ice_hw *hw, struct ice_fwlog_cfg *cfg);
 int ice_fwlog_register(struct ice_hw *hw);
 int ice_fwlog_unregister(struct ice_hw *hw);
 void ice_fwlog_realloc_rings(struct ice_hw *hw, int index);
+void ice_get_fwlog_data(struct ice_hw *hw, u8 *buf, u16 len);
 #endif /* _ICE_FWLOG_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 8e0b06c1e02b..c2101853adf8 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1250,32 +1250,6 @@ ice_handle_link_event(struct ice_pf *pf, struct ice_rq_event_info *event)
 	return status;
 }
 
-/**
- * ice_get_fwlog_data - copy the FW log data from ARQ event
- * @pf: PF that the FW log event is associated with
- * @event: event structure containing FW log data
- */
-static void
-ice_get_fwlog_data(struct ice_pf *pf, struct ice_rq_event_info *event)
-{
-	struct ice_fwlog_data *fwlog;
-	struct ice_hw *hw = &pf->hw;
-
-	fwlog = &hw->fwlog_ring.rings[hw->fwlog_ring.tail];
-
-	memset(fwlog->data, 0, PAGE_SIZE);
-	fwlog->data_size = le16_to_cpu(event->desc.datalen);
-
-	memcpy(fwlog->data, event->msg_buf, fwlog->data_size);
-	ice_fwlog_ring_increment(&hw->fwlog_ring.tail, hw->fwlog_ring.size);
-
-	if (ice_fwlog_ring_full(&hw->fwlog_ring)) {
-		/* the rings are full so bump the head to create room */
-		ice_fwlog_ring_increment(&hw->fwlog_ring.head,
-					 hw->fwlog_ring.size);
-	}
-}
-
 /**
  * ice_aq_prep_for_event - Prepare to wait for an AdminQ event from firmware
  * @pf: pointer to the PF private structure
@@ -1566,7 +1540,8 @@ static int __ice_clean_ctrlq(struct ice_pf *pf, enum ice_ctl_q q_type)
 			}
 			break;
 		case ice_aqc_opc_fw_logs_event:
-			ice_get_fwlog_data(pf, &event);
+			ice_get_fwlog_data(hw, event.msg_buf,
+					   le16_to_cpu(event.desc.datalen));
 			break;
 		case ice_aqc_opc_lldp_set_mib_change:
 			ice_dcb_process_lldp_set_mib_change(pf, &event);
-- 
2.49.0


