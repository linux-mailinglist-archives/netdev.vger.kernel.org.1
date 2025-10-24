Return-Path: <netdev+bounces-232701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D57B5C081E2
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 22:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C71954F5FD6
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 20:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17F12FB091;
	Fri, 24 Oct 2025 20:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A+7iTXif"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7C12FB98F
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 20:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338876; cv=none; b=BY9uH83wAqurYrcMEDniJirMiiHNL60k0MCMTlSkDnxh+h+L3RFxQVmidrX2GVTsu3uEJWtKPhrn/0ONfjUaxn5R4EciV5fmLE7I0SGPSLT92t6U5X6kvNcGg0thL225VMnEDQUp22p9Nrtcwr5Q/KTcW2UkXfAf3TGd8dKIHNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338876; c=relaxed/simple;
	bh=8BaN8tdu+zFDOhqPsEhT1d73/E56jYUcIzB910NbYeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okHkN/7eruhTHsNtHWdhrISi1xWllOI3x8OyMFYkEYlgvkoBtoM7VTbF2dW7C974h9eJnW8tMcP2R2BstDVo9VkZoggSPeJEzAe83d5U9eHDWyo5sewePS9Of/Op/V1pPQ4mcRKcS/OXbCNWAv7TyXCC+JEHJGaBVSsKSV9GYoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A+7iTXif; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761338875; x=1792874875;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8BaN8tdu+zFDOhqPsEhT1d73/E56jYUcIzB910NbYeI=;
  b=A+7iTXifTpNA1qWxt/IBlQd15gNjwsh7Xao/4ZnmhN+MQ+CBsq3pBwsJ
   s7ZlcbvgbTbYqomfTjfyaJvhgh+POdoiMlt6cRcSSIIgAcBrVVKaNmy4a
   VhIrzg7iigWjATJeSwbwBVFh6rcmuXzrKsBbSeDHQMhAdfdQTSQ9XDiww
   CfYa5hKdIpQoRA42t3fp8gsK1ibzRtm4LkOJGjVfcrtWBqwUW5OrwG9ec
   yD56E+Ymrzt+udUY3P+H4MYgoym4O+fxCuzvJiNtI8x0gUdDZHIMM3//7
   IZMyV9zQqbTvtj3gh+QkjgdaYHS1LuFeg+u8zjczIIcrG5vnZLcy9t09/
   Q==;
X-CSE-ConnectionGUID: V9A8QNI1RGufFK9dxRljkg==
X-CSE-MsgGUID: nRBq9SNxSIqyohXZQw53Uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66139504"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="66139504"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 13:47:53 -0700
X-CSE-ConnectionGUID: cODC64T5TLOC0UG8FAiOvw==
X-CSE-MsgGUID: wXO8Vm57T2arOrcSTnEddA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="188821517"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 24 Oct 2025 13:47:53 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	mschmidt@redhat.com,
	poros@redhat.com,
	horms@kernel.org,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 2/9] ice: move service task start out of ice_init_pf()
Date: Fri, 24 Oct 2025 13:47:37 -0700
Message-ID: <20251024204746.3092277-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251024204746.3092277-1-anthony.l.nguyen@intel.com>
References: <20251024204746.3092277-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Move service task start out of ice_init_pf(). Do analogous with deinit.
Service task is needed up to the very end of driver removal, later commit
of the series will move it later on execution timeline.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h      |  1 +
 drivers/net/ethernet/intel/ice/ice_main.c | 18 +++++++++++-------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 22b8323ff0d0..0e58a58c23eb 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -1029,6 +1029,7 @@ int ice_open(struct net_device *netdev);
 int ice_open_internal(struct net_device *netdev);
 int ice_stop(struct net_device *netdev);
 void ice_service_task_schedule(struct ice_pf *pf);
+void ice_start_service_task(struct ice_pf *pf);
 int ice_load(struct ice_pf *pf);
 void ice_unload(struct ice_pf *pf);
 void ice_adv_lnk_speed_maps_init(void);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index ca95b8800bb3..f9e464b79bca 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3951,7 +3951,6 @@ u16 ice_get_avail_rxq_count(struct ice_pf *pf)
  */
 static void ice_deinit_pf(struct ice_pf *pf)
 {
-	ice_service_task_stop(pf);
 	mutex_destroy(&pf->lag_mutex);
 	mutex_destroy(&pf->adev_mutex);
 	mutex_destroy(&pf->sw_mutex);
@@ -4030,6 +4029,14 @@ static void ice_set_pf_caps(struct ice_pf *pf)
 	pf->max_pf_rxqs = func_caps->common_cap.num_rxq;
 }
 
+void ice_start_service_task(struct ice_pf *pf)
+{
+	timer_setup(&pf->serv_tmr, ice_service_timer, 0);
+	pf->serv_tmr_period = HZ;
+	INIT_WORK(&pf->serv_task, ice_service_task);
+	clear_bit(ICE_SERVICE_SCHED, pf->state);
+}
+
 /**
  * ice_init_pf - Initialize general software structures (struct ice_pf)
  * @pf: board private structure to initialize
@@ -4049,12 +4056,6 @@ static int ice_init_pf(struct ice_pf *pf)
 
 	init_waitqueue_head(&pf->reset_wait_queue);
 
-	/* setup service timer and periodic service task */
-	timer_setup(&pf->serv_tmr, ice_service_timer, 0);
-	pf->serv_tmr_period = HZ;
-	INIT_WORK(&pf->serv_task, ice_service_task);
-	clear_bit(ICE_SERVICE_SCHED, pf->state);
-
 	mutex_init(&pf->avail_q_mutex);
 	pf->avail_txqs = bitmap_zalloc(pf->max_pf_txqs, GFP_KERNEL);
 	if (!pf->avail_txqs)
@@ -4745,6 +4746,7 @@ int ice_init_dev(struct ice_pf *pf)
 		ice_set_safe_mode_caps(hw);
 	}
 
+	ice_start_service_task(pf);
 	err = ice_init_pf(pf);
 	if (err) {
 		dev_err(dev, "ice_init_pf failed: %d\n", err);
@@ -4791,6 +4793,7 @@ int ice_init_dev(struct ice_pf *pf)
 	ice_clear_interrupt_scheme(pf);
 unroll_pf_init:
 	ice_deinit_pf(pf);
+	ice_service_task_stop(pf);
 	return err;
 }
 
@@ -4799,6 +4802,7 @@ void ice_deinit_dev(struct ice_pf *pf)
 	ice_free_irq_msix_misc(pf);
 	ice_deinit_pf(pf);
 	ice_deinit_hw(&pf->hw);
+	ice_service_task_stop(pf);
 
 	/* Service task is already stopped, so call reset directly. */
 	ice_reset(&pf->hw, ICE_RESET_PFR);
-- 
2.47.1


