Return-Path: <netdev+bounces-156482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DDAA06815
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 23:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29422188601E
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 22:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8CD204C23;
	Wed,  8 Jan 2025 22:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gSfwt5F9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A46204690
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 22:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736374687; cv=none; b=qlTub6JuGgn6/Ce36/94RgtFnJI7Ga97vE2tAfrZE1XMapE0kZJGC402hYPLRgah4h4Spi7gxDtRf9GqqHsSP7OSategdO6ZHmmKsMybyaXMNDMZN3WEwsE2VmOrOSw1h18Bb6dAKbHo9KBsU2CFen/r8sCB33dGB0Kq8l9G4Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736374687; c=relaxed/simple;
	bh=c6XEK8H2bobr3a3qFVyP7+0hRU78mtNYtPNLxlAVm6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBEltLFQyku+o9WP+jdeKwBqCGC3X0cmJuyo1baIvVFvZqnQGCeTyEhY00K8JcwEqRvgOUZqRgmhDVk54r4mPj/2CjdN4dGSdsY2I/+VkVDI8IrdUEDZ4pQJc1ZWJAx8fyIUiV3YbC1c0JdLgSYux1MKr4FtYV+pdkgh+Yk6OZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gSfwt5F9; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736374686; x=1767910686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c6XEK8H2bobr3a3qFVyP7+0hRU78mtNYtPNLxlAVm6Y=;
  b=gSfwt5F9nyvR4sGKuRmOr1VTu7KsyCYQI6DM6j7k1+oGHjIgOA5V3944
   7Ix1Y5HjN134YMTJq1TJGISRHG0mE3Gm0f57FAwvoHngSIC8Bk3JAWnjK
   0ORGr9JXewMCaaxO1RcP/kU8Z6byZOPhOfMKUIj05gab3BGjAI1QcOn8M
   W4MlnvwxcaHXv1/AG4GoNN+5ZT5ZbcPLBLO38Kbiqzw2ult1mQ9q7RDGm
   rmNO7cuBLRWQOOLTUk/9mPmmslnt5oBUXCyVa2caNrMSab3WNLp4XNISN
   +Rv5guElH1lbt8cnCCjKmlbXz4SYriXbOvEIN+6TNJPBlgX3nrdlXODkD
   w==;
X-CSE-ConnectionGUID: Qk8T3CVhQO6ZGq2hZc+yMQ==
X-CSE-MsgGUID: yvaSUftgT+iBvsoTn6qbFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="40384657"
X-IronPort-AV: E=Sophos;i="6.12,299,1728975600"; 
   d="scan'208";a="40384657"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 14:18:03 -0800
X-CSE-ConnectionGUID: uXqhkZfBSICczhiwIXLmWw==
X-CSE-MsgGUID: x047e9geSBmu3i071ICMtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="140545117"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 08 Jan 2025 14:18:03 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next 04/13] ice: ice_probe: init ice_adapter after HW init
Date: Wed,  8 Jan 2025 14:17:41 -0800
Message-ID: <20250108221753.2055987-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108221753.2055987-1-anthony.l.nguyen@intel.com>
References: <20250108221753.2055987-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Move ice_adapter initialization to be after HW init, so it could use HW
capabilities, like number of PFs. This is needed for devlink-resource
based RSS LUT size management for PF/VF (not in this series).

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 7fd79482116f..f63e485e65f6 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5277,13 +5277,7 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 	}
 
 	pci_set_master(pdev);
-
-	adapter = ice_adapter_get(pdev);
-	if (IS_ERR(adapter))
-		return PTR_ERR(adapter);
-
 	pf->pdev = pdev;
-	pf->adapter = adapter;
 	pci_set_drvdata(pdev, pf);
 	set_bit(ICE_DOWN, pf->state);
 	/* Disable service task until DOWN bit is cleared */
@@ -5314,12 +5308,19 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 	err = ice_init_hw(hw);
 	if (err) {
 		dev_err(dev, "ice_init_hw failed: %d\n", err);
-		goto unroll_adapter;
+		return err;
 	}
 
+	adapter = ice_adapter_get(pdev);
+	if (IS_ERR(adapter)) {
+		err = PTR_ERR(adapter);
+		goto unroll_hw_init;
+	}
+	pf->adapter = adapter;
+
 	err = ice_init(pf);
 	if (err)
-		goto unroll_hw_init;
+		goto unroll_adapter;
 
 	devl_lock(priv_to_devlink(pf));
 	err = ice_load(pf);
@@ -5338,10 +5339,10 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 unroll_init:
 	devl_unlock(priv_to_devlink(pf));
 	ice_deinit(pf);
-unroll_hw_init:
-	ice_deinit_hw(hw);
 unroll_adapter:
 	ice_adapter_put(pdev);
+unroll_hw_init:
+	ice_deinit_hw(hw);
 	return err;
 }
 
-- 
2.47.1


