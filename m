Return-Path: <netdev+bounces-270431-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEsCH2ICwWlUPgQAu9opvQ
	(envelope-from <netdev+bounces-270431-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 10:05:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3AF2EEA69
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 10:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 435513003EFF
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 08:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1625538228F;
	Mon, 23 Mar 2026 08:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hGIiUoms"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF7637E308
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774256326; cv=none; b=oM/efygE1igHhtsZQcW3GkZRHJFzHNbSQHaXNUa/7+zyKpFU1oCwxk476hleMqBIUmmPuEVxkeUUYQ9BXOWU0xnbn9XiZntdCyuWNN9SOu5rFxCg01tfvU/vm2egy5xaft2WI7PxV86lxYeBVNQ3osO2QRW+4JK3zNVB7TWJkao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774256326; c=relaxed/simple;
	bh=jHgelXS5yU++pr9hsze+xt6bI8CoqB6u6b129+DDlTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sCnZfbkd71iYyrEdjKzp75KfOMF/RSTEkOcti5d0I8wemeXJ87Uu5CA/fIKORk9vi7mhHWgKknOLD4PUdpTBNlvBIWCtveuLi2i9ieY2K6W0Lzaat/aS1OrARxV/6eA0NOE5Zo7/K5ncJpXz6cLtAcOoPcgOIG9RcoVMnECsYGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hGIiUoms; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774256324; x=1805792324;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jHgelXS5yU++pr9hsze+xt6bI8CoqB6u6b129+DDlTw=;
  b=hGIiUoms0+I9cOlf5kNYsRpcxRz/dHajeM/dfFocs4MSr4qeD/+RfG7H
   WMCIfNw2LNJaO/xR+91b0lyoU8WzkGKuiknRRDX/jlnZyoNwR2pPzjADi
   6RbTq1BUtTEMnUm604DqJSAlmsVSzrbQ+x1y88EvnxxqEwFyKIZL93m6/
   LTOugvrseKGqpyYvNyU8PwexHPEyaM6owG404xiA5AmlVigxCnmF06TyL
   w9MrRXwkx2tzn3AQULGl+ERnC/FpCoBqX/LxiRqoXWNv6ILON/ksuT+2L
   hFclClIELlOCtewIirUNxq4DcFkxveTugjqjavkcW5+GC/GAQGTWr97s1
   w==;
X-CSE-ConnectionGUID: 0pzFVawCS/mDUMFLCrZT4A==
X-CSE-MsgGUID: frKhp9IqRpukmP5+AfSSOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="75155297"
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="75155297"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 01:58:43 -0700
X-CSE-ConnectionGUID: l4NqCTdSTKyHbpLxX7OrBA==
X-CSE-MsgGUID: eLXjps3STVqluZfiBAM6aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="228434191"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa004.jf.intel.com with ESMTP; 23 Mar 2026 01:58:42 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH iwl-next v2] ice: update ice_link_mode_str_high() with 200G
Date: Mon, 23 Mar 2026 09:58:40 +0100
Message-ID: <20260323085840.3272274-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270431-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA3AF2EEA69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Paul Greenwalt <paul.greenwalt@intel.com>

Update ice_link_mode_str_high() with strings for 200G PHY types.
Without these entries the ice_dump_phy_type() debug helper prints
nothing for phy_type_high bits [5..15], covering all 200G and
400GBASE-FR8 PHY types supported by E825C hardware.

Also add the corresponding ICE_PHY_TYPE_HIGH_* bit definitions for
indices 13-15 (200G_AUI8_AOC_ACC, 200G_AUI8, 400GBASE_FR8) that were
missing from ice_adminq_cmd.h, and update ICE_PHY_TYPE_HIGH_MAX_INDEX
from 12 to 15.  Without these definitions ice_get_phy_type_high() would
stop iterating at index 12, leaving the new PHY types invisible to all
code that bounds-checks against MAX_INDEX.

Fixes: none (new hardware support)
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v1 -> v2 update ICE_PHY_TYPE_HIGH_MAX_INDEX 
---
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |  5 ++++-
 drivers/net/ethernet/intel/ice/ice_common.c     | 11 +++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 859e9c6..f64d2ef 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1044,7 +1044,10 @@ struct ice_aqc_get_phy_caps {
 #define ICE_PHY_TYPE_HIGH_200G_KR4_PAM4		BIT_ULL(10)
 #define ICE_PHY_TYPE_HIGH_200G_AUI4_AOC_ACC	BIT_ULL(11)
 #define ICE_PHY_TYPE_HIGH_200G_AUI4		BIT_ULL(12)
-#define ICE_PHY_TYPE_HIGH_MAX_INDEX		12
+#define ICE_PHY_TYPE_HIGH_200G_AUI8_AOC_ACC	BIT_ULL(13)
+#define ICE_PHY_TYPE_HIGH_200G_AUI8		BIT_ULL(14)
+#define ICE_PHY_TYPE_HIGH_400GBASE_FR8		BIT_ULL(15)
+#define ICE_PHY_TYPE_HIGH_MAX_INDEX		15
 
 struct ice_aqc_get_phy_caps_data {
 	__le64 phy_type_low; /* Use values from ICE_PHY_TYPE_LOW_* */
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 2cebe4e..c6727c5 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -84,6 +84,17 @@ static const char * const ice_link_mode_str_high[] = {
 	[2] = "100G_CAUI2",
 	[3] = "100G_AUI2_AOC_ACC",
 	[4] = "100G_AUI2",
+	[5] = "200G_CR4_PAM4",
+	[6] = "200G_SR4",
+	[7] = "200G_FR4",
+	[8] = "200G_LR4",
+	[9] = "200G_DR4",
+	[10] = "200G_KR4_PAM4",
+	[11] = "200G_AUI4_AOC_ACC",
+	[12] = "200G_AUI4",
+	[13] = "200G_AUI8_AOC_ACC",
+	[14] = "200G_AUI8",
+	[15] = "400GBASE_FR8",
 };
 
 /**
-- 
2.52.0


