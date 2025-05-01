Return-Path: <netdev+bounces-187326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF20AA6686
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 00:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860359A83DC
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 22:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D3726A1BB;
	Thu,  1 May 2025 22:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bYGzJzKM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AB9267734
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 22:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140080; cv=none; b=r0Cn//RmaL7wNRjeFYN2GWjBn0haWJOPzIf4VW6c/+Mro8xevmKPcVad8jy4axR5GqnTzdrW/W7xZZuL7b64iIPLJ89fF9o5ARGZpB+XmmUwi/fGhFP5H2G8vjRfu3bs2fr1RHXwOCMXlVnZ8QJHctuIKntWP1m2TeAu9Uyyo5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140080; c=relaxed/simple;
	bh=p2ifKL5IrrpxwpF8I/RdIitdsMsZUbE9VlVfq98qPEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HCiYbfy0ND94ro4wEIi4so7+jX3LcfXPyvDvvoAFJqOAMsgWzK/BfjrbebMbGKIl08/p2QhT8HUio8zMJp9JJeUriwxJ91AubTsBRPd+GBVZNukxotN0se7xrVa6NR1tf41qPd5UjzuiiVeQ1ktOnuwFQm1eGubdf/7mrihK/Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bYGzJzKM; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746140079; x=1777676079;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=p2ifKL5IrrpxwpF8I/RdIitdsMsZUbE9VlVfq98qPEU=;
  b=bYGzJzKMZnmuXOCcqT9uTNslu+b9/5qyxbp2joMnKAb19aExZfXA3pkO
   7XE0UBF2ZDHFrvwGL1FnzriwXqrAYgWlXsMe2RLZs1R3BcsKWPY4xKH7E
   aI+LKw0GIxfa+4n6rSOKfU1B9eSv6MGiapmjs/oKHjmV6UV/7gQMTqxHs
   yDBZw6QJqUsqt2bnRXo7xTP2MJHCSOmfXVg5zbl9AboBAd7iL8yRbZhgV
   U49YyZBCtTxXGTbg59toWdi1ScJSEK804+SwueNaI4cxzaPvQWyhmHBOv
   T4ayCKuv5o9pFT4FfWj08kU3dLcvXIfjkNvW+D3/vbXZjFi2p3NCQ3baU
   w==;
X-CSE-ConnectionGUID: aYyt4et6Ql+e7uGkqnZTuA==
X-CSE-MsgGUID: /+OazulZTUyac0j77HsLfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="58811734"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="58811734"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 15:54:36 -0700
X-CSE-ConnectionGUID: uPXsd7ZCQQyDNap6ptzdtQ==
X-CSE-MsgGUID: YEh+XF3RRhKuXSGWGiFpyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="138514300"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 15:54:34 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 01 May 2025 15:54:20 -0700
Subject: [PATCH v4 09/15] ice: read TSPLL registers again before reporting
 status
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250501-kk-tspll-improvements-alignment-v4-9-24c83d0ce7a8@intel.com>
References: <20250501-kk-tspll-improvements-alignment-v4-0-24c83d0ce7a8@intel.com>
In-Reply-To: <20250501-kk-tspll-improvements-alignment-v4-0-24c83d0ce7a8@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Karol Kolacinski <karol.kolacinski@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Milena Olech <milena.olech@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>
X-Mailer: b4 0.14.2

After programming the TSPLL, re-read the registers before reporting status.
This ensures the debug log message will show what was actually programmed,
rather than relying on a cached value.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tspll.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index 8de1ad1da8346d4be4224b923de3baeffc954198..74384725869399b4aa999d5b1fe33a5b19e0c2fd 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -201,8 +201,11 @@ static int ice_tspll_cfg_e82x(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 		return -EBUSY;
 	}
 
-	ice_tspll_log_cfg(hw, dw24.ts_pll_enable, clk_src, clk_freq, true,
-			  true);
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R9, &dw9.val);
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R24, &dw24.val);
+
+	ice_tspll_log_cfg(hw, dw24.ts_pll_enable, dw24.time_ref_sel,
+			  dw9.time_ref_freq_sel, true, false);
 
 	return 0;
 }
@@ -343,8 +346,11 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 		return -EBUSY;
 	}
 
-	ice_tspll_log_cfg(hw, dw23.ts_pll_enable, clk_src, clk_freq, true,
-			  true);
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R9, &dw9.val);
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R23, &dw23.val);
+
+	ice_tspll_log_cfg(hw, dw23.ts_pll_enable, dw23.time_ref_sel,
+			  dw9.time_ref_freq_sel, true, true);
 
 	return 0;
 }

-- 
2.48.1.397.gec9d649cc640


