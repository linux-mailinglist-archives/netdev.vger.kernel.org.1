Return-Path: <netdev+bounces-242216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE22BC8D90E
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 10:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAD703ABAD1
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 09:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E590296BC4;
	Thu, 27 Nov 2025 09:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U056A0Pm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF5427FD5B
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 09:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764235974; cv=none; b=hzoB3TyCCqtIm9OOV+QmfqQDeEuXwR6+bZzGb1g0GYYqd4rmmyYue+mW4GPtrdmNIhnl4ZFMMHu6PuLMzdr/YOoqHowrM+x4DlOL5Adf+zz+x6yZQUa4aKZjKIn5/Xh8kBA4NOFgStx6yKsVmF6k8GuCkMkgep0owz5k3ItUA+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764235974; c=relaxed/simple;
	bh=Lz5tiYqO9lVIx/L5agfQKSQCh9f11c5AqKOu4sPTUWY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ESfRRbrU/pvFWa8LVIODvz8+RQXdIkWH63n/4AUCDSSNGiYubfGA/JpdrNPyRAa5Us0iOkAtXkgxo/C/iEMNYHrDuzZFjMIZ2g6zno70zviCkYg0/ABTFn6Xc2KOdTMU20P47QolT8OjVZZ5qEwf2Gas46/Fdsx5JWTi3lwpQno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U056A0Pm; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764235972; x=1795771972;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Lz5tiYqO9lVIx/L5agfQKSQCh9f11c5AqKOu4sPTUWY=;
  b=U056A0Pml6ezR4qw4w2v38ssKtFm6U/dgSq0Chc2OOyOVMZtOy8yDKjb
   lyNxkMPLJh2LJI9jloJRrt3pgHTD5hoyadKh8o0erRsQBM3aFz9c24QOR
   NRD1wIwDY8493x73p0z1h1zHySVEr97ncAtX5/XiuvMYauMJxSnUz5DZc
   74nmCQr6horFeIsSvNVoSd9k5lHHlWBHjewb3rJ66zR8Un2cDe8yqtKfx
   jH8hof1bUohVJEZplINpLTB95eaORjO8PQAQy9NZAD/0e+FjrV2qoVgLn
   lBkaUzWXNGuIXZZ6QgredKJSU1YxnBNx+YA2gUBCOKmNlz76VWNaeLZb2
   w==;
X-CSE-ConnectionGUID: h9kvu+JjSvCLJQtEaF/xBw==
X-CSE-MsgGUID: susby758RQWfFBsZzFibpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="91761057"
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="91761057"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 01:32:51 -0800
X-CSE-ConnectionGUID: CrWZo14MTBqvOxJoaSnh8g==
X-CSE-MsgGUID: dmQlN1HuSM2+68I7x5daDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="193210142"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by orviesa007.jf.intel.com with ESMTP; 27 Nov 2025 01:32:50 -0800
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-net] ice: fix missing TX timestamps interrupts on E825 devices
Date: Thu, 27 Nov 2025 10:25:58 +0100
Message-Id: <20251127092558.914981-1-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify PTP (Precision Time Protocol) configuration on link down flow.
Previously, PHY_REG_TX_OFFSET_READY register was cleared in such case.
This register is used to determine if the timestamp is valid or not on
the hardware side.
However, there is a possibility that there is still the packet in the
HW queue which originally was supposed to be timestamped but the link
is already down and given register is cleared.
This potentially might lead to the situation in which that 'delayed'
packet's timestamp is treated as invalid one when the link is up
again.
This in turn leads to the situation in which the driver is not able to
effectively clean timestamp memory and interrupt configuration.
From the hardware perspective, that 'old' interrupt was not handled
properly and even if new timestamp packets are processed, no new
interrupts is generated. As a result, providing timestamps to the user
applications (like ptp4l) is not possible.
The solution for this problem is implemented at the driver level rather
than the firmware, and maintains the tx_ready bit high, even during
link down events. This avoids entering a potential inconsistent state
between the driver and the timestamp hardware.

Testing hints:
- run PTP traffic at higher rate (like 16 PTP messages per second)
- observe ptp4l behaviour at the client side in the following
  conditions:
	a) trigger link toggle events. It needs to be physiscal
           link down/up events
	b) link speed change
In all above cases, PTP processing at ptp4l application should resume
always. In failure case, the following permanent error message in ptp4l
log was observed:
controller-0 ptp4l: err [6175.116] ptp4l-legacy timed out while polling
	for tx timestamp

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 8ec0f7d0fceb..4aa88bac759f 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1338,9 +1338,12 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 		/* Do not reconfigure E810 or E830 PHY */
 		return;
 	case ICE_MAC_GENERIC:
-	case ICE_MAC_GENERIC_3K_E825:
 		ice_ptp_port_phy_restart(ptp_port);
 		return;
+	case ICE_MAC_GENERIC_3K_E825:
+		if (linkup)
+			ice_ptp_port_phy_restart(ptp_port);
+		return;
 	default:
 		dev_warn(ice_pf_to_dev(pf), "%s: Unknown PHY type\n", __func__);
 	}

base-commit: e2cedb8386f079af01cd659c22bb43f1acf4d1b1
-- 
2.39.3


