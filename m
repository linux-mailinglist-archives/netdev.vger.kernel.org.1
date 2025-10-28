Return-Path: <netdev+bounces-233644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFEDC16C36
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 21:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A8712355DF3
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 20:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CA433A006;
	Tue, 28 Oct 2025 20:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i1nH9Gf5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D51D2D46B1
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 20:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761683129; cv=none; b=U9Mt/sZNHtqMezsSe8S9bsy/GEy7w8jJKKfMnwfw0diqTWuxsOiTu0bREhZjuiMaWjKQpWYSwTomj+Z2/r6DDqmMXYBJftHzJBPdX+d75sibbu+cO9fm0ucqB7GwuhhEcW2VDdvuojP9X4SFZ20Gq67fnRiRdbkghBNzO8S15E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761683129; c=relaxed/simple;
	bh=yI05GCHk/8h1mr5QlWTDiSO/gmEcKBVrTfT7hVmDxRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJoTwbQxZEO6YO8JGmoi+E5lMm/EoQ8Z/x5fUd4xhIFAGrZ5KFKfZRq7KIbhg2SGNmtTqlswcG53MxkZ7OZqaH/jfpecQNgH6Z4wFuCrYR6n7ajeM7SPFz20BgoJEOAqoow+XWi2THh/deNZH1c0bMCLIlL9315qepO1AENuSPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i1nH9Gf5; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761683128; x=1793219128;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yI05GCHk/8h1mr5QlWTDiSO/gmEcKBVrTfT7hVmDxRQ=;
  b=i1nH9Gf5PyxCKwKhkV2XSmLT+Pht7bdaLJq6NjoSsr5V/NmJI885hmwH
   U1MIYA8tvQQ+SYwh4VGe/k6/Ue9TspUyA8GA2TsVb0nwHNJrD1PHPEpfA
   uHpBDSmXeo/LMDeDubPUD3qQkzmi7UVQuLg9nWIBYyCvdcNmdL588Jdwx
   cyMDCXAw2VkuPTcmtZqD2x2VdaHi35phH/qxk2Ow5+VSR1pqyvQTbvBqY
   x43S2DHiXuYvgNJZqhcxtgbJCvbT9iHr2PTGFxr/PADJvebTiu88zLvea
   RN7ojYkrlhTBbLFhCckfFr/EdY6McY1wIoekvozvYRQ7Rs572ypuYCIKC
   g==;
X-CSE-ConnectionGUID: cJVjxjQwQnWLeqFqqxhPxw==
X-CSE-MsgGUID: 2M7Ha7srRg+8wbi2WTnd8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62825153"
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="62825153"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 13:25:26 -0700
X-CSE-ConnectionGUID: lzs5d4eeTb6eeC/4P33Hfw==
X-CSE-MsgGUID: sfNpVeWXTVKp94/zAODDlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="185790186"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 28 Oct 2025 13:25:26 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Kohei Enju <enjuk@amazon.com>,
	anthony.l.nguyen@intel.com,
	kohei.enju@gmail.com,
	richardcochran@gmail.com,
	jgarzik@redhat.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net 8/8] ixgbe: use EOPNOTSUPP instead of ENOTSUPP in ixgbe_ptp_feature_enable()
Date: Tue, 28 Oct 2025 13:25:13 -0700
Message-ID: <20251028202515.675129-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251028202515.675129-1-anthony.l.nguyen@intel.com>
References: <20251028202515.675129-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kohei Enju <enjuk@amazon.com>

When the requested PTP feature is not supported,
ixgbe_ptp_feature_enable() returns -ENOTSUPP, causing userland programs
to get "Unknown error 524".

Since EOPNOTSUPP should be used when error is propagated to userland,
return -EOPNOTSUPP instead of -ENOTSUPP.

Fixes: 3a6a4edaa592 ("ixgbe: Hardware Timestamping + PTP Hardware Clock (PHC)")
Signed-off-by: Kohei Enju <enjuk@amazon.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
index 114dd88fc71c..6885d2343c48 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
@@ -641,7 +641,7 @@ static int ixgbe_ptp_feature_enable(struct ptp_clock_info *ptp,
 	 * disabled
 	 */
 	if (rq->type != PTP_CLK_REQ_PPS || !adapter->ptp_setup_sdp)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	if (on)
 		adapter->flags2 |= IXGBE_FLAG2_PTP_PPS_ENABLED;
-- 
2.47.1


