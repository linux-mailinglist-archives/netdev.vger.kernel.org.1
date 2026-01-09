Return-Path: <netdev+bounces-248602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE81D0C41D
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 22:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 499653051FB0
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 21:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D8C321448;
	Fri,  9 Jan 2026 21:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AiVubebt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBD23203A1
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 21:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767992818; cv=none; b=eINvJcUQkd8E2lPnhhUvzH8uDXqXeXZNu6tT80zWOEsfaV51JGyeHoYnj61mdM2OtZRlWpEra3svFfwwCW4f+AsaXkiOEFWtbrujaMn2Gzu+mAbiK2LDF6+vXXFI/mDWOXgFJZMZYYBE1DpkYtR98hw3pH2C0K8qycj+Vmay/gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767992818; c=relaxed/simple;
	bh=rg9FuW54pB2jA0HgmiOa1Z5/QPmGBiF734i1gHCU8TI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kIMqKXP608iAeXdQa+/t30qUYCNwbsYRS3sURqRxL1tmQtEhNtA0vNxsMypcEKb1f8Sf43yQj5PiSUejQLv72AHCCvPCX9DRKYZ5xKLn4vyxAHtOlbbrEMIpi+mmTw5DX2jLsrAinjFNA2bQ4vkHZKS/kr/A1LbAcQ6bcRMRifA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AiVubebt; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767992817; x=1799528817;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rg9FuW54pB2jA0HgmiOa1Z5/QPmGBiF734i1gHCU8TI=;
  b=AiVubebty34W20lJbuxvgbzh+1UsvhprcdmOW3dyDx5xREDP8Qf9Z8a+
   PW09Tl58Ugr05BOwHAjs5DvnQPbw/TEs9Dp4GcOICkng6oan2brCu5fY/
   KUQqPJK49Q+YOAtRSMCznFV8vLlrNzgPV+N88Dx2H7zHkdLG9mswUei0j
   o/AhxDD9wCLZ32YUJWIQFjh/IwajAZcw2p3uqJKHQkxfyx1gSBsqWo/2f
   X48wi3dEiQbMKODYD0IZcXDm8MAx/8PyFnrOgc3qvJLgVNgNBel9LJnMF
   ndwLiynVMlxTBzYEmch5WG+SGXgsqIIXxQsL1xdBuqGON4Kbcp+n7M57/
   Q==;
X-CSE-ConnectionGUID: hs7AHVnwTxaDgMy8dkmseA==
X-CSE-MsgGUID: SVubyifET3GRwCC9pg6fEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="73222066"
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="73222066"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 13:06:54 -0800
X-CSE-ConnectionGUID: vnLfnKEUTBKBS9vgdlNy2w==
X-CSE-MsgGUID: 8t950A9tT0CQfoTp6MDS/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="203571432"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 09 Jan 2026 13:06:54 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Sreedevi Joshi <sreedevi.joshi@intel.com>,
	anthony.l.nguyen@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 4/5] idpf: update idpf_up_complete() return type to void
Date: Fri,  9 Jan 2026 13:06:41 -0800
Message-ID: <20260109210647.3849008-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260109210647.3849008-1-anthony.l.nguyen@intel.com>
References: <20260109210647.3849008-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sreedevi Joshi <sreedevi.joshi@intel.com>

idpf_up_complete() function always returns 0 and no callers use this return
value. Although idpf_vport_open() checks the return value, it only handles
error cases which never occur. Change the return type to void to simplify
the code.

Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 131a8121839b..f5a1ede23dbf 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1429,10 +1429,8 @@ static int idpf_set_real_num_queues(struct idpf_vport *vport)
 /**
  * idpf_up_complete - Complete interface up sequence
  * @vport: virtual port structure
- *
- * Returns 0 on success, negative on failure.
  */
-static int idpf_up_complete(struct idpf_vport *vport)
+static void idpf_up_complete(struct idpf_vport *vport)
 {
 	struct idpf_netdev_priv *np = netdev_priv(vport->netdev);
 
@@ -1442,8 +1440,6 @@ static int idpf_up_complete(struct idpf_vport *vport)
 	}
 
 	set_bit(IDPF_VPORT_UP, np->state);
-
-	return 0;
 }
 
 /**
@@ -1584,12 +1580,7 @@ static int idpf_vport_open(struct idpf_vport *vport, bool rtnl)
 		goto disable_vport;
 	}
 
-	err = idpf_up_complete(vport);
-	if (err) {
-		dev_err(&adapter->pdev->dev, "Failed to complete interface up for vport %u: %d\n",
-			vport->vport_id, err);
-		goto disable_vport;
-	}
+	idpf_up_complete(vport);
 
 	if (rtnl)
 		rtnl_unlock();
-- 
2.47.1


