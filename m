Return-Path: <netdev+bounces-222595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D56B54F38
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 15:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB876A01C34
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 13:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EA030FC03;
	Fri, 12 Sep 2025 13:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QS+zFJD/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302BA30F54A
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 13:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683039; cv=none; b=eFcjng6pnac6Jyo6uoGHSvFoS6N8kfYf6Z9kXBFjwNM/tLsHPHR1bdeq9O2YBfaYzxGNQcVYT/OwK/o9k7HCLONpYXoP55FOovagFcuppUypnus8LK8eqCm2UIsIKKAj5Z9Y+Mrd0Kb6/puN6hjhtk04dhWu4ccA6jH/YZ7aQps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683039; c=relaxed/simple;
	bh=oKCUiNYNWYYf2KHg5yOtaekk1S2bAh14IFPmuzYk2xI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fJ9ap41lTtEtiNF0yVfmz4XxJeioKs0folxV+FUEoCiUceOomZGBhzDKwXJk5rDSq6KKD1TH1qLIfGrxz4cSBB9HGMxSpF1HQFXvjKwiQ4/rVM1kY7fDNuRuvGwp+z3RngR/j1zGWBzSotJUkm0yYGZw8hseYgJ86prXLVP5Lq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QS+zFJD/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757683038; x=1789219038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oKCUiNYNWYYf2KHg5yOtaekk1S2bAh14IFPmuzYk2xI=;
  b=QS+zFJD/sjx8n6Nf5wXjhG9VqLQlbcS6WXJT1ldbHfGMz+ctJ/be1khb
   jLpnFQgZV6sFqD4XLg1arnYpwJocLZwfRJaZx/M1JVewugTE+P7NpAgd4
   vQdJHF40paf3+bFOcKeEcI7wJ7x0NAOmINiPtgsUBLBZul9oEuGIkguj8
   LYfVJjECG5VA0zEDpLoLJou1LVho2rCnank/eYi2wRE6YAHztcUIk4qBC
   AARY1QY8mSMYl/jNsoW+WjFhxSFz8pR3DQx6P2MYfy0b/6sPCXVtiDJ9C
   5RAbHyP3hZXkz32JRGrUWnKdTGhbFntNxg4uGaUvV8/Anvy2b2UOQ77qz
   A==;
X-CSE-ConnectionGUID: dL4FloyxTGOONZ2cNXINdQ==
X-CSE-MsgGUID: 9KzJ23n3Sha7+clGMMNAaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="85461431"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="85461431"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 06:17:16 -0700
X-CSE-ConnectionGUID: mUtTehwKRDysC7bduifkPA==
X-CSE-MsgGUID: blrpboMxSh+zN6dpGlBBVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="173131232"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa006.jf.intel.com with ESMTP; 12 Sep 2025 06:17:14 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 9ECB02FC6E;
	Fri, 12 Sep 2025 14:17:12 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next 6/9] ice: move ice_init_pf() out of ice_init_dev()
Date: Fri, 12 Sep 2025 15:06:24 +0200
Message-Id: <20250912130627.5015-7-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250912130627.5015-1-przemyslaw.kitszel@intel.com>
References: <20250912130627.5015-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move ice_init_pf() out of ice_init_dev().
Do the same for deinit counterpart.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h          |  2 ++
 .../net/ethernet/intel/ice/devlink/devlink.c  | 16 ++++++++--
 drivers/net/ethernet/intel/ice/ice_main.c     | 32 +++++++++----------
 3 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 184aab6221c2..38e34246c803 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -1008,6 +1008,8 @@ void ice_unload(struct ice_pf *pf);
 void ice_adv_lnk_speed_maps_init(void);
 int ice_init_dev(struct ice_pf *pf);
 void ice_deinit_dev(struct ice_pf *pf);
+int ice_init_pf(struct ice_pf *pf);
+void ice_deinit_pf(struct ice_pf *pf);
 int ice_change_mtu(struct net_device *netdev, int new_mtu);
 void ice_tx_timeout(struct net_device *netdev, unsigned int txqueue);
 int ice_xdp(struct net_device *dev, struct netdev_bpf *xdp);
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index fb2de521731a..c354a03c950c 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -459,6 +459,7 @@ static void ice_devlink_reinit_down(struct ice_pf *pf)
 	rtnl_lock();
 	ice_vsi_decfg(ice_get_main_vsi(pf));
 	rtnl_unlock();
+	ice_deinit_pf(pf);
 	ice_deinit_dev(pf);
 }
 
@@ -1231,11 +1232,12 @@ static void ice_set_min_max_msix(struct ice_pf *pf)
 static int ice_devlink_reinit_up(struct ice_pf *pf)
 {
 	struct ice_vsi *vsi = ice_get_main_vsi(pf);
+	struct device *dev = ice_pf_to_dev(pf);
 	int err;
 
 	err = ice_init_hw(&pf->hw);
 	if (err) {
-		dev_err(ice_pf_to_dev(pf), "ice_init_hw failed: %d\n", err);
+		dev_err(dev, "ice_init_hw failed: %d\n", err);
 		return err;
 	}
 
@@ -1246,13 +1248,19 @@ static int ice_devlink_reinit_up(struct ice_pf *pf)
 	if (err)
 		goto unroll_hw_init;
 
+	err = ice_init_pf(pf);
+	if (err) {
+		dev_err(dev, "ice_init_pf failed: %d\n", err);
+		goto unroll_dev_init;
+	}
+
 	vsi->flags = ICE_VSI_FLAG_INIT;
 
 	rtnl_lock();
 	err = ice_vsi_cfg(vsi);
 	rtnl_unlock();
 	if (err)
-		goto err_vsi_cfg;
+		goto unroll_pf_init;
 
 	/* No need to take devl_lock, it's already taken by devlink API */
 	err = ice_load(pf);
@@ -1265,7 +1273,9 @@ static int ice_devlink_reinit_up(struct ice_pf *pf)
 	rtnl_lock();
 	ice_vsi_decfg(vsi);
 	rtnl_unlock();
-err_vsi_cfg:
+unroll_pf_init:
+	ice_deinit_pf(pf);
+unroll_dev_init:
 	ice_deinit_dev(pf);
 unroll_hw_init:
 	ice_deinit_hw(&pf->hw);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index ae8339f7d2ff..6d9de6e24804 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3973,7 +3973,7 @@ u16 ice_get_avail_rxq_count(struct ice_pf *pf)
  * ice_deinit_pf - Unrolls initialziations done by ice_init_pf
  * @pf: board private structure to initialize
  */
-static void ice_deinit_pf(struct ice_pf *pf)
+void ice_deinit_pf(struct ice_pf *pf)
 {
 	/* note that we unroll also on ice_init_pf() failure here */
 
@@ -4064,8 +4064,9 @@ void ice_start_service_task(struct ice_pf *pf)
 /**
  * ice_init_pf - Initialize general software structures (struct ice_pf)
  * @pf: board private structure to initialize
+ * Return: 0 on success, negative errno otherwise.
  */
-static int ice_init_pf(struct ice_pf *pf)
+int ice_init_pf(struct ice_pf *pf)
 {
 	struct udp_tunnel_nic_info *udp_tunnel_nic = &pf->hw.udp_tunnel_nic;
 	struct device *dev = ice_pf_to_dev(pf);
@@ -4803,23 +4804,12 @@ int ice_init_dev(struct ice_pf *pf)
 	}
 
 	ice_start_service_task(pf);
-	err = ice_init_pf(pf);
-	if (err) {
-		dev_err(dev, "ice_init_pf failed: %d\n", err);
-		goto unroll_irq_scheme_init;
-	}
 
 	return 0;
-
-unroll_irq_scheme_init:
-	ice_service_task_stop(pf);
-	ice_clear_interrupt_scheme(pf);
-	return err;
 }
 
 void ice_deinit_dev(struct ice_pf *pf)
 {
-	ice_deinit_pf(pf);
 	ice_deinit_hw(&pf->hw);
 	ice_service_task_stop(pf);
 
@@ -5061,21 +5051,28 @@ static void ice_deinit_devlink(struct ice_pf *pf)
 
 static int ice_init(struct ice_pf *pf)
 {
+	struct device *dev = ice_pf_to_dev(pf);
 	int err;
 
 	err = ice_init_dev(pf);
 	if (err)
 		return err;
 
+	err = ice_init_pf(pf);
+	if (err) {
+		dev_err(dev, "ice_init_pf failed: %d\n", err);
+		goto unroll_dev_init;
+	}
+
 	if (pf->hw.mac_type == ICE_MAC_E830) {
 		err = pci_enable_ptm(pf->pdev, NULL);
 		if (err)
-			dev_dbg(ice_pf_to_dev(pf), "PCIe PTM not supported by PCIe bus/controller\n");
+			dev_dbg(dev, "PCIe PTM not supported by PCIe bus/controller\n");
 	}
 
 	err = ice_alloc_vsis(pf);
 	if (err)
-		goto err_alloc_vsis;
+		goto unroll_pf_init;
 
 	err = ice_init_pf_sw(pf);
 	if (err)
@@ -5112,7 +5109,9 @@ static int ice_init(struct ice_pf *pf)
 	ice_deinit_pf_sw(pf);
 err_init_pf_sw:
 	ice_dealloc_vsis(pf);
-err_alloc_vsis:
+unroll_pf_init:
+	ice_deinit_pf(pf);
+unroll_dev_init:
 	ice_deinit_dev(pf);
 	return err;
 }
@@ -5124,6 +5123,7 @@ static void ice_deinit(struct ice_pf *pf)
 
 	ice_deinit_pf_sw(pf);
 	ice_dealloc_vsis(pf);
+	ice_deinit_pf(pf);
 	ice_deinit_dev(pf);
 }
 
-- 
2.39.3


