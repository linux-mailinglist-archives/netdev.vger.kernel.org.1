Return-Path: <netdev+bounces-116283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 621DE949D12
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 02:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 947931C224C4
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 00:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0588218EBF;
	Wed,  7 Aug 2024 00:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B71kjI7p"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674F01DFFC
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 00:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722991018; cv=none; b=EzO/zXHGUnTBTuyn+2Wh9kbmFzj0dYmSi172H60iOjfqg6EkQPheCRX7ZcKyeh+5wNPkIzwFCm5Hr2y9rFKtazdfm03tjbGCJXL3HKu1AsJ4ryvWGecg+QjSAPIQEwEic6TbwHPSGS704dYW3/LPr5PPTWcoAAx0P7ed/Va3sLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722991018; c=relaxed/simple;
	bh=FWYbx309e0mOibK/0qkpc0jS+BP2N0k4amoXf/TFnH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AcYXwsK07Q+YbWbxMRFpx88BJVjoHCsSQXgE3rfBS3NHlRf+yj24Ds50hGqYcjpsB/XZuZ0mwT1t5HSPEfQ0ECSQx76HfebZGhmbJ3ab9T3ckqkhvnIgGvk+rcB87OCVkhz9314Vn2d8QMzeo3l0WKWvPuAhA9jVDmXMrSVH/xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B71kjI7p; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722991018; x=1754527018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FWYbx309e0mOibK/0qkpc0jS+BP2N0k4amoXf/TFnH8=;
  b=B71kjI7pgxp6yDL3k3hBTND8DB7+kGthkVum0A275FsIAUKsfr6Pb/DV
   SauYcB5ikQwSZ9aNEY2xt8QDywCkrIFKMgbC6Ip4DkEnROKy2VqAbbUEf
   YLpiRHflqLo6rLEnEL1awJRZBXSCWIAOqs2otw2gpFxdiKJJ/RTITtdUG
   TEdWdVAsJnwyWvP6/mPpWUCc0YsHMJ0pFlJeqXFOl/FTGQpgsBlM9Un+0
   1vB2EvTZNTZAovKOEA/5stlGIZNNMKf1v9HFUtP3URClqMzjq/uArMmy1
   vkN3pk9lUbf72Kjgbam6c4M3seED6tSajXaBolf4Tsu28wvDSoErQkWOg
   w==;
X-CSE-ConnectionGUID: Q9JeiU9ATS2US5XUeWTblw==
X-CSE-MsgGUID: k+4eRi5UR0u8QranV8+m3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="31669758"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="31669758"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 17:36:57 -0700
X-CSE-ConnectionGUID: Zc8pSRbkQyWw8Xd5UfY+bQ==
X-CSE-MsgGUID: qPZar2KpSm6T7COtEGBoHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="61497020"
Received: from timelab-spr09.ch.intel.com (HELO timelab-spr09.sc.intel.com) ([143.182.136.138])
  by orviesa003.jf.intel.com with ESMTP; 06 Aug 2024 17:36:56 -0700
From: christopher.s.hall@intel.com
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	vinicius.gomes@intel.com,
	david.zage@intel.com,
	vinschen@redhat.com,
	rodrigo.cadore@l-acoustics.com,
	Christopher S M Hall <christopher.s.hall@intel.com>
Subject: [PATCH iwl-net v1 4/5] igc: Reduce retry count to a more reasonable number
Date: Tue,  6 Aug 2024 17:30:31 -0700
Message-Id: <20240807003032.10300-5-christopher.s.hall@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807003032.10300-1-christopher.s.hall@intel.com>
References: <20240807003032.10300-1-christopher.s.hall@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christopher S M Hall <christopher.s.hall@intel.com>

Setting the retry count to 8x is more than sufficient. 100x is unreasonable
 and would indicate broken hardware/firmware.

Fixes: a90ec8483732 ("igc: Add support for PTP getcrosststamp()")
Signed-off-by: Christopher S M Hall <christopher.s.hall@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index fb885fcaa97c..f770e39650ef 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -1008,8 +1008,8 @@ static int igc_phc_get_syncdevicetime(ktime_t *device,
 	u32 stat, t2_curr_h, t2_curr_l;
 	struct igc_adapter *adapter = ctx;
 	struct igc_hw *hw = &adapter->hw;
-	int err, count = 100;
 	ktime_t t1, t2_curr;
+	int err, count = 8;
 
 	/* Doing this in a loop because in the event of a
 	 * badly timed (ha!) system clock adjustment, we may
-- 
2.34.1


