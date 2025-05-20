Return-Path: <netdev+bounces-191769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 552DCABD231
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 10:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97A11189448F
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 08:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792F126156A;
	Tue, 20 May 2025 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GmwWeQo1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF25E25E46A
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 08:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747730550; cv=none; b=VAncHldJajNE2GQFAev6Dr8UuC7jgaRn1F0/PZIi+DEDG16HWPbR+7OpFwT5KwDD2XeXvV/+77o26VMEo4/2ojyjl3xUu+AvCsOBmyOk/JxovjFDSKK2YP/qB4JCrns8hg6yc8xHdUf6h5p2FvO1GbuWNGlEvLA4RgN3dG6RUak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747730550; c=relaxed/simple;
	bh=rchwuanThsE5B2k89HcYlZ9D24IM1yxl1+aLijatFB4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CN1y6c+iXfScGvAs2JtGALs0hw7UZEzZzBXNLZwLS3cMOGhBJQPMsM6nY73v/jGNHlclheO59RXqOjDuEsnv5iNx9/iJ5/Z/yklfqLZDheJy5/v4WnJjsgkGMB3oWX/pBRzmkt3L+W7UQX9NR0cApJUjNAD9AgZ8Co43eczZz7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GmwWeQo1; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747730547; x=1779266547;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rchwuanThsE5B2k89HcYlZ9D24IM1yxl1+aLijatFB4=;
  b=GmwWeQo1PV3ieM2tQbUiF+Wq+HozPbqThFSO+Lte8QE+TBEYTjfN0r3l
   +MlZkKAHkIXKqr0zZBV7NBtV6DYrlwrRPSh/6dhqJUIdajJgVftVQQIyd
   okfahxGHW2Tr/wDLcXysDcpOg1rMI0eW4P74y/HK8Xs+rpb3eaMoolqDD
   k4cSyzz6yaIZ12ee+iQHZvALqYfR1g/jkvSg1o2HgU1saNbMDJjspx2Wr
   EwTxU+S66KWElJuIKQl1463+0Dp5/O5OnwkcygZFmn/dMsi4kvX70S+7A
   zMSu4SvIVkMT80VbeazbDlCmvUaGbF6H4jqp0zJXXulwyZZqFrmjVpiLM
   Q==;
X-CSE-ConnectionGUID: GV8lFOufRXWFSZRDQLS5xg==
X-CSE-MsgGUID: LTA5p8m2TP6VfSLGjSDNnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="37270479"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="37270479"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 01:42:27 -0700
X-CSE-ConnectionGUID: PQHVbds1QNieHIhf0zbgLA==
X-CSE-MsgGUID: Ge8aUrcrS3yfNDSM4SLwdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144742753"
Received: from admindev-x299-aorus-gaming-3-pro.igk.intel.com ([10.91.3.52])
  by orviesa005.jf.intel.com with ESMTP; 20 May 2025 01:42:25 -0700
From: Anton Nadezhdin <anton.nadezhdin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Anton Nadezhdin <anton.nadezhdin@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH iwl-net v4] ice/ptp: fix crosstimestamp reporting
Date: Tue, 20 May 2025 10:42:16 +0200
Message-Id: <20250520084216.326210-1-anton.nadezhdin@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

Set use_nsecs=true as timestamp is reported in ns. Lack of this result
in smaller timestamp error window which cause error during phc2sys
execution on E825 NICs:
phc2sys[1768.256]: ioctl PTP_SYS_OFFSET_PRECISE: Invalid argument

This problem was introduced in the cited commit which omitted setting
use_nsecs to true when converting the ice driver to use
convert_base_to_cs().

Testing hints (ethX is PF netdev):
phc2sys -s ethX -c CLOCK_REALTIME  -O 37 -m
phc2sys[1769.256]: CLOCK_REALTIME phc offset -5 s0 freq      -0 delay    0

Fixes: d4bea547ebb57 ("ice/ptp: Remove convert_art_to_tsc()")
Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
V3 -> V4 Updated commit message
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 1fd1ae03eb90..11ed48a62b53 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2307,6 +2307,7 @@ static int ice_capture_crosststamp(ktime_t *device,
 	ts = ((u64)ts_hi << 32) | ts_lo;
 	system->cycles = ts;
 	system->cs_id = CSID_X86_ART;
+	system->use_nsecs = true;
 
 	/* Read Device source clock time */
 	ts_lo = rd32(hw, cfg->dev_time_l[tmr_idx]);

base-commit: 7e5af365e38059ed585917623c1ba3a6c04a8c10
-- 
2.34.1


