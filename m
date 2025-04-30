Return-Path: <netdev+bounces-187176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21011AA583E
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 00:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43FE11C223BD
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 22:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A5922A4EC;
	Wed, 30 Apr 2025 22:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JsMR9YKP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF276226CFE
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 22:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746053510; cv=none; b=E/yBoOEg9ofDWp7LRwXcewRVrIF04S0j34T9YEM7dZxBR6VAhFDyNFdFsJxXFXj8RaljJNASR8sUpGL4CbLmEEhRhrVyTsnYLlBQ6gE8YRlJ5xI07umY7uZw1WchUQNxWtFvOqqphfRQg0HQZdUdejj1ujfOXJ6yfJv0k+Dp62k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746053510; c=relaxed/simple;
	bh=Kqhzv+cVV38ZBUVHe8GeDI8u0k0MsCD7MceYaz1hzMQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XXw8dQOPL72AlGRn2Ql8bPsyjdGVR8HRMFV4ygNnr5PIIa8hzXV13cy9ZVysKXfAtw/BF4drz9N6ymoMMJ3G7alUxTvRG+MsLos6hgT7qxJJl2Ozst0GjZJNBU9qXD/L2VZmi9EtMF85QeDXwJwAAxMLaMmbqvrEn45IlzxQito=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JsMR9YKP; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746053509; x=1777589509;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Kqhzv+cVV38ZBUVHe8GeDI8u0k0MsCD7MceYaz1hzMQ=;
  b=JsMR9YKPz8cAk5JCpJCnhVCUsPHG/ihAKgj0Vbl7Fe9XfNnhB7zyz7+T
   omv+idb/uOKCKNlxYqnE+Pe7fJzTQYuhd6dMVoZuKXNjb4sk16axTX25x
   12ogBwf0MXLWavnkM761TdIpfQE4Bf87HiaTfE0tVmRfOqw29TqCoNsE5
   1CBEXVbMXfsFc9z945jC3hqOin76dB6c1lAvySN0x2/4pU3CjNdm0N0+f
   yc+blmF0oKZhfc77lp69Q6moZ7GInDs7q97wYmvU7PVdR1ocwnfFCWPaw
   4fmbHvaOjSQw7g/f3cjKtki+Nd55vpxq2GEgdvZoJTe6SW7eIMXGBbZPb
   A==;
X-CSE-ConnectionGUID: 4GGilVyVSHCZhsWluls1Qw==
X-CSE-MsgGUID: P0iSLngOTUusV/7LKpORqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="73120902"
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="73120902"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 15:51:41 -0700
X-CSE-ConnectionGUID: DT8aZKD6SoqXlVLB39433g==
X-CSE-MsgGUID: MKPcYuJaQKCDLQtg3NLzEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="134145094"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 15:51:40 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 30 Apr 2025 15:51:40 -0700
Subject: [PATCH v3 09/15] ice: read TSPLL registers again before reporting
 status
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-kk-tspll-improvements-alignment-v3-9-ab8472e86204@intel.com>
References: <20250430-kk-tspll-improvements-alignment-v3-0-ab8472e86204@intel.com>
In-Reply-To: <20250430-kk-tspll-improvements-alignment-v3-0-ab8472e86204@intel.com>
To: Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 netdev <netdev@vger.kernel.org>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Milena Olech <milena.olech@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Karol Kolacinski <karol.kolacinski@intel.com>
X-Mailer: b4 0.14.2

After programming the TSPLL, re-read the registers before reporting status.
This ensures the debug log message will show what was actually programmed,
rather than relying on a cached value.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tspll.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index f44a27252f384dbb9a1f57d5f9ac03b3b7adf037..e7bca0957583b7ba16498148b0afca0de3467e85 100644
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


