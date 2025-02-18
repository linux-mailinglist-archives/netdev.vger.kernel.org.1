Return-Path: <netdev+bounces-167400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E404EA3A26E
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 17:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4649218919B9
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 16:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A53F26B0A1;
	Tue, 18 Feb 2025 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JWuAJ7Ie"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3990A1ABEC5
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739895468; cv=none; b=SjTlIu1PZg9yHXT/aAeI4gO/jTZnGEH5sNV5yx04enwrxom5U7t+G+GpJ3rgIB1ww4ZtYjZ2a97ARoDXdtzZgkvPTlZLoaj++rJ1Is0dwv/Qj12YM9eRcQg8wWR1o+claXO+iYVVg9WaSj2TYFzEW4RzTxZyN1b9wYHu3A3EDXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739895468; c=relaxed/simple;
	bh=XR75bg3WZqzb6NLXgJEAV1nHtNKD8PMpdk9Fdj+btS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G+o66/DXaZNvvUNobmOQhk4H1q/MmhOkfRfUrVfd3b0WzTRGAkdf8qbiaFwS369Jrrb47zRpDE9YOPKcZhCLuv3uyZZrLmQDGrBS0F081aZ9ReW6rCF5Jj7R6r4mu8FlZFeMIQuNMIPC0EBtcKgyQJqM6sHg5R0tDqtSB1lV2T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JWuAJ7Ie; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739895466; x=1771431466;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XR75bg3WZqzb6NLXgJEAV1nHtNKD8PMpdk9Fdj+btS8=;
  b=JWuAJ7Ie1A0N/t5/7snnS4SOgw3Do7SBRdSVO5giBQFPgQPQAn5ZpBPo
   fIDbGewoLPwJKQD7jxs2adS44LAtpbg/rTpbNJLZcvoLh7oGAWsbxfZFI
   dJPjJt/kyxNr+hj3GroQD/FXl0e1tGNUoCupVuq9L1wa+M1a3TyiJE/j2
   fV5R1ZvZ9zjn3Y6MET5atqyXNEnCyldeW7RqfutCse06jg9ppf/RsHH+1
   H9qqu4JcckP3YZIpcVEwX5XhHSUkZBqUcC4Mj9h/XlLg4QvpuvH+70GCJ
   GObC4ycDLMCIf1r/SSKpfBF4LYGijONFAZ0HokZXyb0hHTpwN/Fj2mZGe
   w==;
X-CSE-ConnectionGUID: zJzR3JcTTg2EdVzl1swI1A==
X-CSE-MsgGUID: BkBIs2yPRx2oWy5s11GuxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40620314"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="40620314"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 08:17:45 -0800
X-CSE-ConnectionGUID: xF4HKS2RQ6m5VLjy++fgyA==
X-CSE-MsgGUID: XnIVIdfoQc+4BKrz4AcE4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119083750"
Received: from pkwapuli-mobl1.ger.corp.intel.com (HELO vbox-pkwap.ger.corp.intel.com) ([10.245.87.141])
  by fmviesa005.fm.intel.com with ESMTP; 18 Feb 2025 08:17:44 -0800
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	andrew@lunn.ch,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net] ixgbe: fix media type detection for E610 device
Date: Tue, 18 Feb 2025 17:17:41 +0100
Message-ID: <20250218161741.4147-1-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 23c0e5a16bcc ("ixgbe: Add link management support for E610
device") introduced incorrect media type detection for E610 device. It
reproduces when advertised speed is modified after driver reload. Clear
the previous outdated PHY type.

Fixes: 23c0e5a16bcc ("ixgbe: Add link management support for E610 device")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 683c668..0dfefd2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -1453,9 +1453,11 @@ enum ixgbe_media_type ixgbe_get_media_type_e610(struct ixgbe_hw *hw)
 			hw->link.link_info.phy_type_low = 0;
 		} else {
 			highest_bit = fls64(le64_to_cpu(pcaps.phy_type_low));
-			if (highest_bit)
+			if (highest_bit) {
 				hw->link.link_info.phy_type_low =
 					BIT_ULL(highest_bit - 1);
+				hw->link.link_info.phy_type_high = 0;
+			}
 		}
 	}
 
-- 
2.43.0


