Return-Path: <netdev+bounces-181781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C01A8677C
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 22:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF99D1B82E0B
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62E529B238;
	Fri, 11 Apr 2025 20:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H6vXcFFu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22677298984
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 20:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744404255; cv=none; b=t5x1OCpA18gL2B3jfRkv23uKe8+7LbhTKqeBjIEwwPRFqrADOZWD/ZlZNx09jYFWLOQEzAdm+anOJvg+uhLee0Do2/hMDjSHsNsLzRldlUNyi2E1janklz6rOVxUVqZE7EQpTBCk+mbJS8NV+zzUwTp7n3+VZ+rpFJDhG9o/nzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744404255; c=relaxed/simple;
	bh=JgtaJTy2dIPxeEqdxeXPcO4TT0UMnG97jk+tl+bHcpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DBigPtAxdzxVNaeFE2WM2r3VxbWvPIOZVTN68BEdqmAfRUG5lZi5OA4rp41JdGYD5lAF2kqKQSnjhyt4oEL/kMW+QzgWN81ov9IpmrF+dv8vvSLLXnwKZtZPzrw8U7XkOBnW9AJTeof/YAF2f75ruhqj9fXExw98tSw8u0zb4EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H6vXcFFu; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744404254; x=1775940254;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JgtaJTy2dIPxeEqdxeXPcO4TT0UMnG97jk+tl+bHcpI=;
  b=H6vXcFFudoBIdwyiD+GifT4TDIUuHvaMBM6SvlTWV6HYKxrbhcTLVSZ+
   HHMFdcUn0XedpNWlDj+a3YRoU171p6jkBXHGhddE2E8l24huVb8fvNwXK
   wT4zP34Iarr2wfGXw3cWo7rn2d4tHK6LU++74v32V3B/fDwWJO2FMYzPQ
   Mn8aI3LJnuAaxDi9OYQQLk9pWW/pcK5hkSJAPquIhOohn7MNHi1ggv7RE
   hAo29aecFt+VM7uGVD8U+zsvC3QtgM6R2RNvTOVvV56wr8+zfWyJzDy56
   bSgc8tgEvMCZ0H1Y3NNOJTyHHf89UUP2dgibFasfcYCv/3wS9qYTJYqJ1
   Q==;
X-CSE-ConnectionGUID: tG1lgMqJSf6rGPWW9uyAYQ==
X-CSE-MsgGUID: ktybpoSgTjKJlA8a46vmtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="45103902"
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="45103902"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 13:44:07 -0700
X-CSE-ConnectionGUID: EyDFk36lS52oOSvhaNhhSQ==
X-CSE-MsgGUID: QcaxuC1dSEOYzbQ0smFRAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="129241823"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 11 Apr 2025 13:44:07 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 10/15] ice: improve error message for insufficient filter space
Date: Fri, 11 Apr 2025 13:43:51 -0700
Message-ID: <20250411204401.3271306-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411204401.3271306-1-anthony.l.nguyen@intel.com>
References: <20250411204401.3271306-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>

When adding a rule to switch through tc, if the operation fails
due to not enough free recipes (-ENOSPC), provide a clearer
error message: "Unable to add filter: insufficient space available."

This improves user feedback by distinguishing space limitations from
other generic failures.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index 49b87071b7dc..fb9ea7f8ef44 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -996,6 +996,9 @@ ice_eswitch_add_tc_fltr(struct ice_vsi *vsi, struct ice_tc_flower_fltr *fltr)
 		NL_SET_ERR_MSG_MOD(fltr->extack, "Unable to add filter because it already exist");
 		ret = -EINVAL;
 		goto exit;
+	} else if (ret == -ENOSPC) {
+		NL_SET_ERR_MSG_MOD(fltr->extack, "Unable to add filter: insufficient space available.");
+		goto exit;
 	} else if (ret) {
 		NL_SET_ERR_MSG_MOD(fltr->extack, "Unable to add filter due to error");
 		goto exit;
@@ -1228,6 +1231,10 @@ ice_add_tc_flower_adv_fltr(struct ice_vsi *vsi,
 				   "Unable to add filter because it already exist");
 		ret = -EINVAL;
 		goto exit;
+	} else if (ret == -ENOSPC) {
+		NL_SET_ERR_MSG_MOD(tc_fltr->extack,
+				   "Unable to add filter: insufficient space available.");
+		goto exit;
 	} else if (ret) {
 		NL_SET_ERR_MSG_MOD(tc_fltr->extack,
 				   "Unable to add filter due to error");
-- 
2.47.1


