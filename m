Return-Path: <netdev+bounces-51470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0006D7FAC52
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 22:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64503281D06
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 21:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8BC45C13;
	Mon, 27 Nov 2023 21:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bk5YZCSn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80781A2
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 13:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701119445; x=1732655445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kxnLbBP004y0OoGMcVYQxzESV+6z5Pj4ts/034GhGNs=;
  b=bk5YZCSn6eZaE9TufD/uzU3AD8DhU2HVM4cOlSqTQbIgrsg+cDkJsbVL
   8d1YzTRKTYV5JgOvHxehtbVsRMkC5TF4OVBUv222rDCifEtQg2Nr1D57a
   OgJ5C24uNhb3pjX3tRAQV5jynRlLDhyR+WMc0TZZOuYHGheksf1kK+7/k
   EMjE+iVfuwvBZiFttuQtTug3Su8UzK9y3DkJxgluXWAIa1QnyTS731Ixf
   rvs8nKg2SOq4Ypekb7Mzi45APKMK2ZGhyy+s8dds2d+YG8tYZljK1w2sA
   p28i/h0Fd/NEgktA/0Pos0VHO1d13KBGDSysYy7/MMLXY3z+P5mswS9Ls
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="5982916"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="5982916"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 13:10:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="9724676"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 27 Nov 2023 13:10:45 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 2/5] i40e: Remove AQ register definitions for VF types
Date: Mon, 27 Nov 2023 13:10:32 -0800
Message-ID: <20231127211037.1135403-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231127211037.1135403-1-anthony.l.nguyen@intel.com>
References: <20231127211037.1135403-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ivan Vecera <ivecera@redhat.com>

The i40e driver does not handle its VF device types so there
is no need to keep AdminQ register definitions for such
device types. Remove them.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_register.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_register.h b/drivers/net/ethernet/intel/i40e/i40e_register.h
index d561687303ea..2e1eaca44343 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_register.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_register.h
@@ -863,16 +863,6 @@
 #define I40E_PFPM_WUFC 0x0006B400 /* Reset: POR */
 #define I40E_PFPM_WUFC_MAG_SHIFT 1
 #define I40E_PFPM_WUFC_MAG_MASK I40E_MASK(0x1, I40E_PFPM_WUFC_MAG_SHIFT)
-#define I40E_VF_ARQBAH1 0x00006000 /* Reset: EMPR */
-#define I40E_VF_ARQBAL1 0x00006C00 /* Reset: EMPR */
-#define I40E_VF_ARQH1 0x00007400 /* Reset: EMPR */
-#define I40E_VF_ARQLEN1 0x00008000 /* Reset: EMPR */
-#define I40E_VF_ARQT1 0x00007000 /* Reset: EMPR */
-#define I40E_VF_ATQBAH1 0x00007800 /* Reset: EMPR */
-#define I40E_VF_ATQBAL1 0x00007C00 /* Reset: EMPR */
-#define I40E_VF_ATQH1 0x00006400 /* Reset: EMPR */
-#define I40E_VF_ATQLEN1 0x00006800 /* Reset: EMPR */
-#define I40E_VF_ATQT1 0x00008400 /* Reset: EMPR */
 #define I40E_VFQF_HLUT_MAX_INDEX 15
 
 
-- 
2.41.0


