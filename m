Return-Path: <netdev+bounces-234190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E160BC1DA92
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 00:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E944189BE09
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 23:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC9A31158A;
	Wed, 29 Oct 2025 23:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ESqbAhba"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B221301494
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 23:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761779633; cv=none; b=EZ/XIfuqJ5YJVzRNvPGpxmyW8rlAwv1QQQbaE/62VUVp5ODeDopuVS7QlA1v3u/PTbAVcnrXo8dY0KMRdyV+Zxff+KSdofuhsmov19i06dRtu2aOQwihrz0wdBvDZFjUxOSFnHE5l71imD7f0LOrPClo5S9F+Q8ZTz0YY1KTJYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761779633; c=relaxed/simple;
	bh=Qzbh5+KS+S//B82finO6/DuzI6iDinluCsFtsZxbmpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KkSOXd0wLuiiQBdepdG3FkjOfF8wBs9WxFSBtBXyGfQbu56Gooe1IIdxCdfEpLkPoyrDPBZZW+e6cjAnKkfa20LJfvClT4mjs/SWz6pF2YkJSZvs673G0ZUBIXBvu9G2p6Aw/AgRrUbW7/l1retaM/Kn8B0wfFBXcriWftPOYMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ESqbAhba; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761779632; x=1793315632;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qzbh5+KS+S//B82finO6/DuzI6iDinluCsFtsZxbmpE=;
  b=ESqbAhbaKJXJCLEvqDK8H36G5BdWJon2MUFOlGOr0gTm06Vjzhu1my4J
   Be0bphw1Cps99AodVrIXAm/+dRZDQb25XBYaN8m79bBsUmlW5GljcYo6o
   9eTJZR/j/aaYjCMhd5v+T9LcltdLzvzfBxBEFzjHroyGVCk2uoZewIgoa
   yJnG7DGW5VykOGCst6/lZ/RUGq0Pu3QhjblvKeuKPXkLM5Ok3nwczjlB8
   gALSxl09Kkaa4F00ZPqxUf8ntozEWz8ISJaN/VlDtWfijUfsVqk6gG2wK
   62HtjvekIY7CJEr5xpXi8D/mBHnafw+gqo+QSECqgEKTkkJMEodn/uydM
   w==;
X-CSE-ConnectionGUID: CgXcTWqiQpqfaNiRMRusfw==
X-CSE-MsgGUID: HQgwYIbwSpuCTst5WdX/Sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63817611"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63817611"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 16:13:47 -0700
X-CSE-ConnectionGUID: YMP0EIMGSuGjcQ2ZnDLo8w==
X-CSE-MsgGUID: p/13bTrmSu+mXi//IclYJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="185729707"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 29 Oct 2025 16:13:47 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Alok Tiwari <alok.a.tiwari@oracle.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	alok.a.tiwarilinux@gmail.com
Subject: [PATCH net-next 8/9] ixgbe: fix typos in ixgbe driver comments
Date: Wed, 29 Oct 2025 16:12:15 -0700
Message-ID: <20251029231218.1277233-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251029231218.1277233-1-anthony.l.nguyen@intel.com>
References: <20251029231218.1277233-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alok Tiwari <alok.a.tiwari@oracle.com>

Corrected function reference:
 - "proc_autoc_read_82599" -> "prot_autoc_read_82599"
Fixed spelling of:
 - "big-enian" -> "big-endian"
 - "Virtualiztion" -> "Virtualization"

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c | 4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
index d5b1b974b4a3..3069b583fd81 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
@@ -198,7 +198,7 @@ static int prot_autoc_read_82599(struct ixgbe_hw *hw, bool *locked,
  * @hw: pointer to hardware structure
  * @autoc: value to write to AUTOC
  * @locked: bool to indicate whether the SW/FW lock was already taken by
- *	     previous proc_autoc_read_82599.
+ *	     previous prot_autoc_read_82599.
  *
  * This part (82599) may need to hold a the SW/FW lock around all writes to
  * AUTOC. Likewise after a write we need to do a pipeline reset.
@@ -1622,7 +1622,7 @@ int ixgbe_fdir_set_input_mask_82599(struct ixgbe_hw *hw,
 		break;
 	}
 
-	/* store source and destination IP masks (big-enian) */
+	/* store source and destination IP masks (big-endian) */
 	IXGBE_WRITE_REG_BE32(hw, IXGBE_FDIRSIP4M,
 			     ~input_mask->formatted.src_ip[0]);
 	IXGBE_WRITE_REG_BE32(hw, IXGBE_FDIRDIP4M,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
index 170a29d162c6..a1d04914fbbc 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
@@ -318,7 +318,7 @@ static int ixgbe_xdp_queues(struct ixgbe_adapter *adapter)
  * ixgbe_set_dcb_sriov_queues: Allocate queues for SR-IOV devices w/ DCB
  * @adapter: board private structure to initialize
  *
- * When SR-IOV (Single Root IO Virtualiztion) is enabled, allocate queues
+ * When SR-IOV (Single Root IO Virtualization) is enabled, allocate queues
  * and VM pools where appropriate.  Also assign queues based on DCB
  * priorities and map accordingly..
  *
@@ -492,7 +492,7 @@ static bool ixgbe_set_dcb_queues(struct ixgbe_adapter *adapter)
  * ixgbe_set_sriov_queues - Allocate queues for SR-IOV devices
  * @adapter: board private structure to initialize
  *
- * When SR-IOV (Single Root IO Virtualiztion) is enabled, allocate queues
+ * When SR-IOV (Single Root IO Virtualization) is enabled, allocate queues
  * and VM pools where appropriate.  If RSS is available, then also try and
  * enable RSS and map accordingly.
  *
-- 
2.47.1


