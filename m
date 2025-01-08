Return-Path: <netdev+bounces-156481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEF1A06814
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 23:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013F51885A51
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 22:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344BD2046BB;
	Wed,  8 Jan 2025 22:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gkXJMnZC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483C31A070E
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 22:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736374687; cv=none; b=aU7SQxIvLwAQOQ436BdqXcBuRIfz3W/UV7KPszdEOhaozL1ZhexlWR62QJHuU2zgbqd7iju4R5pZkztSMA+NFsgtietgUlviJRPe9lcmNmOHWDwT5KSdEUJNvS7Z9KFxrgoPYvZZl/c8zqQLJSukI1WaG27J4FOM1TIB0u7Ae/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736374687; c=relaxed/simple;
	bh=Oqd1RlCnDoZrJzYOjkUWEPRaGaDv37NpN2ml2ApCgYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rSwbUomDZdEvsCFF61Z5OE/WWGBk6K1mvUJyD5l5B9ohSL3jdG38yn+Cc1iIVpyncQSW6QyNJU/P+UlIAzGrU7qX9Q/gTa09WkriArqAllH4bSEAZxyVCUBdbnsinMao7kl7qpxU33USYBs3nSu7f9TzJfxgXkX/Bu6T5ciyDRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gkXJMnZC; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736374685; x=1767910685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Oqd1RlCnDoZrJzYOjkUWEPRaGaDv37NpN2ml2ApCgYM=;
  b=gkXJMnZCofH+Csvu4/a7N/lCl5sMx/EG7R+OhWOui9ZDVyVmUeiHGkDk
   tmDsnXkMpCDi/6HPhXBiRa0Fx5t6Bqu0ntw1rFvCSPIj7CktJUiQhnNep
   50awRY7fFAzJ37zxAt1VvGoL26XtGxXMkRYAGH52Vs8/vxUBMfFDRi/rr
   /jJK9L0CWYdXqfMxm7btSi+g0ll3HTggLNmT8z8rC0FBNG/oGUtmr0+GW
   Ddhu5GCsQMMjtibGyn/sJcOWVUTkJei0hK9oe7FLbD81YnweovNmpVPo9
   TxvYrncpU7XkVYJTQG8hpJdLICYG7A4Du9F1M+q2COfmMsx+lXJ6/vRmo
   w==;
X-CSE-ConnectionGUID: DR/Om3/UQTuQifS/ANXtog==
X-CSE-MsgGUID: MybG4fVcSnyORGZfmWNLug==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="40384643"
X-IronPort-AV: E=Sophos;i="6.12,299,1728975600"; 
   d="scan'208";a="40384643"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 14:18:03 -0800
X-CSE-ConnectionGUID: xyx3T0ywQ7uaONJMrJCbaQ==
X-CSE-MsgGUID: /CO6Km36RiG24x1DY97AYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="140545111"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 08 Jan 2025 14:18:02 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next 02/13] ice: split ice_init_hw() out from ice_init_dev()
Date: Wed,  8 Jan 2025 14:17:39 -0800
Message-ID: <20250108221753.2055987-3-anthony.l.nguyen@intel.com>
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

Split ice_init_hw() call out from ice_init_dev(). Such move enables
pulling the former to be even earlier on call path, what would enable
moving ice_adapter init to be between the two (in subsequent commit).
Such move enables ice_adapter to know about number of PFs.

Do the same for ice_deinit_hw(), so the init and deinit calls could
be easily mirrored.
Next commit will rename unrelated goto labels to unroll prefix.

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/devlink/devlink.c  | 10 ++++++++-
 drivers/net/ethernet/intel/ice/ice_main.c     | 22 +++++++++----------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index 1b10682c00b8..d1b9ccec5e05 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -1207,9 +1207,15 @@ static int ice_devlink_reinit_up(struct ice_pf *pf)
 	struct ice_vsi *vsi = ice_get_main_vsi(pf);
 	int err;
 
+	err = ice_init_hw(&pf->hw);
+	if (err) {
+		dev_err(ice_pf_to_dev(pf), "ice_init_hw failed: %d\n", err);
+		return err;
+	}
+
 	err = ice_init_dev(pf);
 	if (err)
-		return err;
+		goto unroll_hw_init;
 
 	vsi->flags = ICE_VSI_FLAG_INIT;
 
@@ -1232,6 +1238,8 @@ static int ice_devlink_reinit_up(struct ice_pf *pf)
 	rtnl_unlock();
 err_vsi_cfg:
 	ice_deinit_dev(pf);
+unroll_hw_init:
+	ice_deinit_hw(&pf->hw);
 	return err;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index f0a637cf3d87..5d7d4a66fbcd 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4755,12 +4755,6 @@ int ice_init_dev(struct ice_pf *pf)
 	struct ice_hw *hw = &pf->hw;
 	int err;
 
-	err = ice_init_hw(hw);
-	if (err) {
-		dev_err(dev, "ice_init_hw failed: %d\n", err);
-		return err;
-	}
-
 	ice_init_feature_support(pf);
 
 	err = ice_init_ddp_config(hw, pf);
@@ -4781,7 +4775,7 @@ int ice_init_dev(struct ice_pf *pf)
 	err = ice_init_pf(pf);
 	if (err) {
 		dev_err(dev, "ice_init_pf failed: %d\n", err);
-		goto err_init_pf;
+		return err;
 	}
 
 	pf->hw.udp_tunnel_nic.set_port = ice_udp_tunnel_set_port;
@@ -4825,8 +4819,6 @@ int ice_init_dev(struct ice_pf *pf)
 	ice_clear_interrupt_scheme(pf);
 err_init_interrupt_scheme:
 	ice_deinit_pf(pf);
-err_init_pf:
-	ice_deinit_hw(hw);
 	return err;
 }
 
@@ -5319,9 +5311,15 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 		hw->debug_mask = debug;
 #endif
 
+	err = ice_init_hw(hw);
+	if (err) {
+		dev_err(dev, "ice_init_hw failed: %d\n", err);
+		goto unroll_adapter;
+	}
+
 	err = ice_init(pf);
 	if (err)
-		goto err_init;
+		goto unroll_hw_init;
 
 	devl_lock(priv_to_devlink(pf));
 	err = ice_load(pf);
@@ -5340,7 +5338,9 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 err_load:
 	devl_unlock(priv_to_devlink(pf));
 	ice_deinit(pf);
-err_init:
+unroll_hw_init:
+	ice_deinit_hw(hw);
+unroll_adapter:
 	ice_adapter_put(pdev);
 	return err;
 }
-- 
2.47.1


