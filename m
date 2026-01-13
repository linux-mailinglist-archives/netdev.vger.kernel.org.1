Return-Path: <netdev+bounces-249608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F15DBD1B848
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 23:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D3B83012E9F
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 22:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA63354AEB;
	Tue, 13 Jan 2026 22:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JhOVTI7G"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AEA350D62
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 22:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768341752; cv=none; b=AKMOlksNDbEkbn0LpM5nJF89qdOr+UZx7UGMoRr6jreTH/xEyi+NxAJrDzlSZe5WwOUYuokhEvzPnW2Aomgm/RLlMOxMHs5BXIfTecrHu51GvaXRuStps9K7Yx3FnxlufDIlv0w3Dc/6DTDw1G2lT8YaSccyXLkIzOS1vgoB8NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768341752; c=relaxed/simple;
	bh=22quTL7fh9scRyyVrxtChnsb+pVvyQ7G290IuYomw4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PyOhanhZNMo4hDo7zO65njlZ0CFIggpCuzhjzYJjDPbuLT+r2xlspuJHlBXjaglX36qvQQdxNmiB0ak9zAL3lUDyfz/Q52rj0pgqggbzxYRatZry7oeXHwpXH6VyI3/E7jLaTrkPZKCPceMBWJpzxeTVlc2eg6S8UVbbUJydUe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JhOVTI7G; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768341751; x=1799877751;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=22quTL7fh9scRyyVrxtChnsb+pVvyQ7G290IuYomw4o=;
  b=JhOVTI7GCpCk8T8gBvmx5of0XOx0IU3OoUjGvU/3O/9EroEEbITp4m8b
   MAbUArkAPLZlDcvNVSGzB2L1MO0e4ahFqfzsEgtv+aHCiq6uWNBIGlQwu
   ik9njFcl/zJCM3rV+qcxiChTxrO9GxbZCUIkSeNteIDTxKQhcvy3qzRja
   68bDNJ5nK/MGnaeAV20SfxTzO5Kpwks761pCA7Do847REG41OT4MtOVqV
   iccWi1ruG/5hgUz9PI1SUAFuiuA/KnLqD/Rekw8mkuvRFTcskqKm3oybN
   uy51qms5M1U0wwDzMsL5E3HJY6Ic6UZgs9ZtVthLEbbvTPBsQgr3/e4Ax
   w==;
X-CSE-ConnectionGUID: ZrpP/iicRxuTKwnS7CrWYQ==
X-CSE-MsgGUID: Ed82LXySTBOAp90ViQjo2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69558674"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="69558674"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 14:02:29 -0800
X-CSE-ConnectionGUID: D1nm+0Q+QN6dv9R53EpRgA==
X-CSE-MsgGUID: 8Z811L0JSS+0txPORkzzXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="204388177"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 13 Jan 2026 14:02:28 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Ding Hui <dinghui@sangfor.com.cn>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Simon Horman <horms@kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 3/6] ice: Fix incorrect timeout ice_release_res()
Date: Tue, 13 Jan 2026 14:02:16 -0800
Message-ID: <20260113220220.1034638-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260113220220.1034638-1-anthony.l.nguyen@intel.com>
References: <20260113220220.1034638-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ding Hui <dinghui@sangfor.com.cn>

The commit 5f6df173f92e ("ice: implement and use rd32_poll_timeout for
ice_sq_done timeout") converted ICE_CTL_Q_SQ_CMD_TIMEOUT from jiffies
to microseconds.

But the ice_release_res() function was missed, and its logic still
treats ICE_CTL_Q_SQ_CMD_TIMEOUT as a jiffies value.

So correct the issue by usecs_to_jiffies().

Found by inspection of the DDP downloading process.
Compile and modprobe tested only.

Fixes: 5f6df173f92e ("ice: implement and use rd32_poll_timeout for ice_sq_done timeout")
Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 046bc9c65c51..785bf5cc1b25 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2251,7 +2251,7 @@ void ice_release_res(struct ice_hw *hw, enum ice_aq_res_ids res)
 	/* there are some rare cases when trying to release the resource
 	 * results in an admin queue timeout, so handle them correctly
 	 */
-	timeout = jiffies + 10 * ICE_CTL_Q_SQ_CMD_TIMEOUT;
+	timeout = jiffies + 10 * usecs_to_jiffies(ICE_CTL_Q_SQ_CMD_TIMEOUT);
 	do {
 		status = ice_aq_release_res(hw, res, 0, NULL);
 		if (status != -EIO)
-- 
2.47.1


