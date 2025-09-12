Return-Path: <netdev+bounces-222594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E12F1B54F3C
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 15:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D261CC6672
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 13:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632D330F921;
	Fri, 12 Sep 2025 13:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PxzJr4IO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84AA30EF9B
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 13:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683039; cv=none; b=fyek1D+pXBqHEIr2qiNoNK/isWiNU1wA96wr/tIUdVi0X/2d344al6iUOHjd8AhRRAwIc2JJ3ZQF8A0r3JrLOW2XT5xCxrjKDxxcwgAmigg7grx9nKBqHBt1f2hMwm1Wa9xMzM8aPS3kxpTe/VnEQ1aCQ+FKVWTQKpRvoK3GygU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683039; c=relaxed/simple;
	bh=WimtE2+lSFCJa+aikLsi54UGM4k6ywZR+VyG85KhLU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RCLOAcFvFyW/7/m6zifpfJfg9HCRmNnE3UpkJMxH5lcz1CUyJ2xa63vzvjLKSyAxUvXAxH6wnL8oohnOT+Q/+2evES5/nJ7kTpiJ0SZ8wZ87JHus0OufKWFrKEbsgKK1mXGpJTpOm5zeGVj7O91XgelUfhia10fBwYZOMvLrfL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PxzJr4IO; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757683037; x=1789219037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WimtE2+lSFCJa+aikLsi54UGM4k6ywZR+VyG85KhLU4=;
  b=PxzJr4IOT+d4UWN1A1rhb1s6I7PD1RYY1gM1PQUurHolyU5pICyLVpia
   vCQVNAq1cMtgmrlOJIoNGFY2wEVbohrAIoVkBd2R4IKXsXyyAzYrT4i9q
   49dAUz2QBwA5bpY1W4UF5GpxNBMjoeoHlabJsCgl65u4BvBJUqmePTCcm
   qcj5h/WRBg+WcEyu4ZOMZtpe0IIn8bFk0D9Tl/GKsdmFF+bMLHXyDeR43
   jw1zW2Si9CLjcnoNr7D5WwUDRg/hmTx4dEdZOk/tmdhSD+gWt9uGSjp0f
   5rHTW8rF7PnqPH27K+NJhlWQItTRIUHjgVuAjzsZrfXqE4qF+OOzo17af
   g==;
X-CSE-ConnectionGUID: njSr1oWgTWq1YL1ew91bdw==
X-CSE-MsgGUID: 95vD+Fq0QTOz7GF/tYsDhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="85461424"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="85461424"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 06:17:15 -0700
X-CSE-ConnectionGUID: Ouq+kAEFTm+s7oFBhulCEA==
X-CSE-MsgGUID: 1ZjoFv0yTripHCbjuczb7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="173131229"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa006.jf.intel.com with ESMTP; 12 Sep 2025 06:17:13 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id EB5482FC74;
	Fri, 12 Sep 2025 14:17:11 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next 5/9] ice: move udp_tunnel_nic and misc IRQ setup into ice_init_pf()
Date: Fri, 12 Sep 2025 15:06:23 +0200
Message-Id: <20250912130627.5015-6-przemyslaw.kitszel@intel.com>
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

Move udp_tunnel_nic setup and ice_req_irq_msix_misc() call into
ice_init_pf(), remove some redundancy in the former while moving.

Move ice_free_irq_msix_misc() call into ice_deinit_pf(), to mimic
the above in terms of needed cleanup. Guard it via emptiness check,
to keep the allowance of half-initialized pf being cleaned up.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 58 +++++++++++------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index f81603a754f9..ae8339f7d2ff 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3997,6 +3997,9 @@ static void ice_deinit_pf(struct ice_pf *pf)
 	if (pf->ptp.clock)
 		ptp_clock_unregister(pf->ptp.clock);
 
+	if (!xa_empty(&pf->irq_tracker.entries))
+		ice_free_irq_msix_misc(pf);
+
 	xa_destroy(&pf->dyn_ports);
 	xa_destroy(&pf->sf_nums);
 }
@@ -4064,6 +4067,11 @@ void ice_start_service_task(struct ice_pf *pf)
  */
 static int ice_init_pf(struct ice_pf *pf)
 {
+	struct udp_tunnel_nic_info *udp_tunnel_nic = &pf->hw.udp_tunnel_nic;
+	struct device *dev = ice_pf_to_dev(pf);
+	struct ice_hw *hw = &pf->hw;
+	int err = -ENOMEM;
+
 	mutex_init(&pf->sw_mutex);
 	mutex_init(&pf->tc_mutex);
 	mutex_init(&pf->adev_mutex);
@@ -4093,11 +4101,30 @@ static int ice_init_pf(struct ice_pf *pf)
 	if (!pf->avail_txqs || !pf->avail_rxqs)
 		goto undo_init;
 
+	udp_tunnel_nic->set_port = ice_udp_tunnel_set_port;
+	udp_tunnel_nic->unset_port = ice_udp_tunnel_unset_port;
+	udp_tunnel_nic->shared = &hw->udp_tunnel_shared;
+	udp_tunnel_nic->tables[0].n_entries = hw->tnl.valid_count[TNL_VXLAN];
+	udp_tunnel_nic->tables[0].tunnel_types = UDP_TUNNEL_TYPE_VXLAN;
+	udp_tunnel_nic->tables[1].n_entries = hw->tnl.valid_count[TNL_GENEVE];
+	udp_tunnel_nic->tables[1].tunnel_types = UDP_TUNNEL_TYPE_GENEVE;
+
+	/* In case of MSIX we are going to setup the misc vector right here
+	 * to handle admin queue events etc. In case of legacy and MSI
+	 * the misc functionality and queue processing is combined in
+	 * the same vector and that gets setup at open.
+	 */
+	err = ice_req_irq_msix_misc(pf);
+	if (err) {
+		dev_err(dev, "setup of misc vector failed: %d\n", err);
+		goto undo_init;
+	}
+
 	return 0;
 undo_init:
 	/* deinit handles half-initialized pf just fine */
 	ice_deinit_pf(pf);
-	return -ENOMEM;
+	return err;
 }
 
 /**
@@ -4782,45 +4809,16 @@ int ice_init_dev(struct ice_pf *pf)
 		goto unroll_irq_scheme_init;
 	}
 
-	pf->hw.udp_tunnel_nic.set_port = ice_udp_tunnel_set_port;
-	pf->hw.udp_tunnel_nic.unset_port = ice_udp_tunnel_unset_port;
-	pf->hw.udp_tunnel_nic.shared = &pf->hw.udp_tunnel_shared;
-	if (pf->hw.tnl.valid_count[TNL_VXLAN]) {
-		pf->hw.udp_tunnel_nic.tables[0].n_entries =
-			pf->hw.tnl.valid_count[TNL_VXLAN];
-		pf->hw.udp_tunnel_nic.tables[0].tunnel_types =
-			UDP_TUNNEL_TYPE_VXLAN;
-	}
-	if (pf->hw.tnl.valid_count[TNL_GENEVE]) {
-		pf->hw.udp_tunnel_nic.tables[1].n_entries =
-			pf->hw.tnl.valid_count[TNL_GENEVE];
-		pf->hw.udp_tunnel_nic.tables[1].tunnel_types =
-			UDP_TUNNEL_TYPE_GENEVE;
-	}
-	/* In case of MSIX we are going to setup the misc vector right here
-	 * to handle admin queue events etc. In case of legacy and MSI
-	 * the misc functionality and queue processing is combined in
-	 * the same vector and that gets setup at open.
-	 */
-	err = ice_req_irq_msix_misc(pf);
-	if (err) {
-		dev_err(dev, "setup of misc vector failed: %d\n", err);
-		goto unroll_pf_init;
-	}
-
 	return 0;
 
-unroll_pf_init:
-	ice_deinit_pf(pf);
 unroll_irq_scheme_init:
 	ice_service_task_stop(pf);
 	ice_clear_interrupt_scheme(pf);
 	return err;
 }
 
 void ice_deinit_dev(struct ice_pf *pf)
 {
-	ice_free_irq_msix_misc(pf);
 	ice_deinit_pf(pf);
 	ice_deinit_hw(&pf->hw);
 	ice_service_task_stop(pf);
-- 
2.39.3


