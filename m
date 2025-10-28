Return-Path: <netdev+bounces-233639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B89F4C16C2D
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 21:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39BAA4E77E4
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 20:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFCF2C3768;
	Tue, 28 Oct 2025 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IFeFRznV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD5D2BEC20
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 20:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761683127; cv=none; b=Xuzl/gn1MMBlPlU1lkQZGU/Ddi9kd0znWCMLSaPmsW8Zj2Jm00AJoCjMsAkyun3tHSmCFlUdYIE/cPIGYsdcG0PPgWRW0pEwiM0Xa4cv2qyY1wL3DYKsHUbutHt2PDYJgT8mbE8iOuAvxAnaLw596QWCxLt8R12Xng0ivRmLFFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761683127; c=relaxed/simple;
	bh=GcLncBIehrXHDpzWInlzHG9cQKmLE3nwcb0tKeCvRSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gnnJDCiN9Ede1pfN6yroeAVQr20/asEvNi9mfUxzZv2sl7BKD9ltHpU6t+OhhM0TohHs310oORLAosFOgCrsnGXBLEibul3t9AvZRPXvyi72ob6T8vYmFV4ltD6ajNTpPij6QhlYVc8wy+CklPl3X8BOTr2eCZg0pIABRw6v9Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IFeFRznV; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761683125; x=1793219125;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GcLncBIehrXHDpzWInlzHG9cQKmLE3nwcb0tKeCvRSk=;
  b=IFeFRznVDo4IuEgBeMY7Yw4mmLCvGEdEo/vZgNZBVfGYcgw+zW0BvE2x
   oSYoaeBvHIytqxkRuF2F++LfSn69klGbmm+XQjNyIZMCI+e1pO3JEYqlB
   VowdBRZT/gVwSleFGbOVGK67rxTxG5xBRq/Dw7IZqpMI2FEfThHP3tOgs
   TI+duWScHoLiuozryRwB6gGoCay+eYKI0C5XIblD6QJvf2Le8LMFlAAwv
   Gw0CNfIcqpdauPBg1w1Ob84w7UxsoeLyFXdk6Ku8DKnDxiv0iOQNU4r+K
   0WYGbneWQdJKpO8faf/PkWzvvpWHpkBhw4SolqTdTYSaEq91hOGrtmCUM
   g==;
X-CSE-ConnectionGUID: zykqd6IoSwS9izkPCSh/WQ==
X-CSE-MsgGUID: 3T1ZD8AkQNSSZf51auiiZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62825148"
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="62825148"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 13:25:24 -0700
X-CSE-ConnectionGUID: lYjlxfLdSeSPZB4CuO6jrA==
X-CSE-MsgGUID: 37TpjqDoTj24+ooyzyfhUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="185790158"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 28 Oct 2025 13:25:23 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>,
	anthony.l.nguyen@intel.com,
	jiri@resnulli.us,
	Dan Nowlin <dan.nowlin@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 3/8] ice: fix usage of logical PF id
Date: Tue, 28 Oct 2025 13:25:08 -0700
Message-ID: <20251028202515.675129-4-anthony.l.nguyen@intel.com>
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

From: Grzegorz Nitka <grzegorz.nitka@intel.com>

In some devices, the function numbers used are non-contiguous. For
example, here is such configuration for E825 device:

root@/home/root# lspci -v | grep Eth
0a:00.0 Ethernet controller: Intel Corporation Ethernet Connection
E825-C for backplane (rev 04)
0a:00.1 Ethernet controller: Intel Corporation Ethernet Connection
E825-C for backplane (rev 04)
0a:00.4 Ethernet controller: Intel Corporation Ethernet Connection
E825-C 10GbE (rev 04)
0a:00.5 Ethernet controller: Intel Corporation Ethernet Connection
E825-C 10GbE (rev 04)

When distributing RSS and FDIR masks, which are global resources across
the active devices, it is required to have a contiguous PF id, which can
be described as a logical PF id. In the case above, function 0 would
have a logical PF id of 0, function 1 would have a logical PF id
of 1, and functions 4 and 5 would have a logical PF ids 2 and 3
respectively.
Using logical PF id can properly describe which slice of resources can
be used by a particular PF.

The 'function id' to 'logical id' mapping has been introduced with the
commit 015307754a19 ("ice: Support VF queue rate limit and quanta size
configuration"). However, the usage of 'logical_pf_id' field was
unintentionally skipped for profile mask configuration.
Fix it by using 'logical_pf_id' instead of 'pf_id' value when configuring
masks.

Without that patch, wrong indexes, i.e. out of range for given PF, can
be used while configuring resources masks, which might lead to memory
corruption and undefined driver behavior.
The call trace below is one of the examples of such error:

[  +0.000008] WARNING: CPU: 39 PID: 3830 at drivers/base/devres.c:1095
devm_kfree+0x70/0xa0
[  +0.000002] RIP: 0010:devm_kfree+0x70/0xa0
[  +0.000001] Call Trace:
[  +0.000002]  <TASK>
[  +0.000002]  ice_free_hw_tbls+0x183/0x710 [ice]
[  +0.000106]  ice_deinit_hw+0x67/0x90 [ice]
[  +0.000091]  ice_deinit+0x20d/0x2f0 [ice]
[  +0.000076]  ice_remove+0x1fa/0x6a0 [ice]
[  +0.000075]  pci_device_remove+0xa7/0x1d0
[  +0.000010]  device_release_driver_internal+0x365/0x530
[  +0.000006]  driver_detach+0xbb/0x170
[  +0.000003]  bus_remove_driver+0x117/0x290
[  +0.000007]  pci_unregister_driver+0x26/0x250

Fixes: 015307754a19 ("ice: Support VF queue rate limit and quanta size configuration")
Suggested-by: Dan Nowlin <dan.nowlin@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_flex_pipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
index 363ae79a3620..013c93b6605e 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
+++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
@@ -1479,7 +1479,7 @@ static void ice_init_prof_masks(struct ice_hw *hw, enum ice_block blk)
 	per_pf = ICE_PROF_MASK_COUNT / hw->dev_caps.num_funcs;
 
 	hw->blk[blk].masks.count = per_pf;
-	hw->blk[blk].masks.first = hw->pf_id * per_pf;
+	hw->blk[blk].masks.first = hw->logical_pf_id * per_pf;
 
 	memset(hw->blk[blk].masks.masks, 0, sizeof(hw->blk[blk].masks.masks));
 
-- 
2.47.1


