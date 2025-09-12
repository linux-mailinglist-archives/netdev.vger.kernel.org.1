Return-Path: <netdev+bounces-222597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CA9B54F3B
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 15:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2FE9A01F68
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 13:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1494231076D;
	Fri, 12 Sep 2025 13:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c5+w4bgc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D26D30F924
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 13:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683041; cv=none; b=lVO3rg3rf9/fLUmdigI7oD8vnH3b6AW9pfKseq5ZB4FQmJ5mHMyLKQvIDZwA+lxIuJtgAGQs3ngboUzIQFOG92cLHSVBP4LsmTj05feuDKXCgTuEagsif2FXQ+EC4JQu0a96ROrOgLRTECT3/n1NykuhlsaBtNADAl+KR8XtAvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683041; c=relaxed/simple;
	bh=R/eC2fW3pIqyDG+5lHEXdyt0lzGW//Pji/GQewD3KV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CiGnlWL0d+apRF5yXbzp8QBtaANebsFFx37dqqRqmnjctVU29IqGe21CmexyCfYezsgPEy7exj292cbt4y9aciPmIFqrLSrJtLmXtG1b9zHYyGUOlB8VLb5jVzXZuvcYjgrxekp4f0OaRm0+xy+VJMmqGtv9J1WpMsGluPDs0jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c5+w4bgc; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757683039; x=1789219039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R/eC2fW3pIqyDG+5lHEXdyt0lzGW//Pji/GQewD3KV0=;
  b=c5+w4bgc+fN4ZkMbDNI7rMsM/US1e18V2tYp01vWXlzGRkytnuje35f9
   +1HXQ+xMGdGUmOjrQbWsQmGw9c0acgEzRc/XRgjOyV+Qz55vuAirPZ5Oh
   gS4I03ni5K6eg3CxWvi/1NRb3a4ApxDRvH2Lnwi7kA8ky8V55FABf5iJ1
   w+OmL3xFPQB+pzpbg6BSvERYZDeO66fZRGA/TV3xmmjQAx56IytKZSkq5
   xbEY6QTtwy+ABX6vod6v1e+ex8NUK5A5vqrThStXELQPsUcBzkAKbMUid
   pD8TrkGtH5wIwTc0+IgrTlL0J3W6YMMp9Q0+dL82LceIU9yscOhUPJYq6
   w==;
X-CSE-ConnectionGUID: fE3Yh7KoR1SiaF7jpnHNeQ==
X-CSE-MsgGUID: o5w4sFMmS5qHh0u963qwvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="85461441"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="85461441"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 06:17:17 -0700
X-CSE-ConnectionGUID: 7gL5fEF5QfOV5NaS4mBvBQ==
X-CSE-MsgGUID: +C0ZCqivRRSH66jl+svNTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="173131238"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa006.jf.intel.com with ESMTP; 12 Sep 2025 06:17:15 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id ECFBB2FC70;
	Fri, 12 Sep 2025 14:17:13 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next 8/9] ice: move ice_deinit_dev() to the end of deinit paths
Date: Fri, 12 Sep 2025 15:06:26 +0200
Message-Id: <20250912130627.5015-9-przemyslaw.kitszel@intel.com>
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

ice_deinit_dev() takes care of turning off adminq processing, which is
much needed during driver teardown (remove, reset, error path). Move it
to the very end where applicable.
For example, ice_deinit_hw() called after adminq deinit slows rmmod on
my two-card setup by about 60 seconds.

ice_init_dev() and ice_deinit_dev() scopes were reduced by previous
commits of the series, with a final touch of extracting ice_init_dev_hw()
out now (there is no deinit counterpart).

Note that removed ice_service_task_stop() call from ice_remove() is placed
in the ice_deinit_dev() (and stopping twice makes no sense).

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h          |  1 +
 .../net/ethernet/intel/ice/devlink/devlink.c  |  5 +++-
 drivers/net/ethernet/intel/ice/ice_common.c   |  3 +++
 drivers/net/ethernet/intel/ice/ice_main.c     | 23 ++++++++++++-------
 4 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 38e34246c803..34b9d67e94de 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -1006,6 +1006,7 @@ void ice_start_service_task(struct ice_pf *pf);
 int ice_load(struct ice_pf *pf);
 void ice_unload(struct ice_pf *pf);
 void ice_adv_lnk_speed_maps_init(void);
+void ice_init_dev_hw(struct ice_pf *pf);
 int ice_init_dev(struct ice_pf *pf);
 void ice_deinit_dev(struct ice_pf *pf);
 int ice_init_pf(struct ice_pf *pf);
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index c354a03c950c..938914abbe06 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -1233,6 +1233,7 @@ static int ice_devlink_reinit_up(struct ice_pf *pf)
 {
 	struct ice_vsi *vsi = ice_get_main_vsi(pf);
 	struct device *dev = ice_pf_to_dev(pf);
+	bool need_dev_deinit = false;
 	int err;
 
 	err = ice_init_hw(&pf->hw);
@@ -1276,9 +1277,11 @@ static int ice_devlink_reinit_up(struct ice_pf *pf)
 unroll_pf_init:
 	ice_deinit_pf(pf);
 unroll_dev_init:
-	ice_deinit_dev(pf);
+	need_dev_deinit = true;
 unroll_hw_init:
 	ice_deinit_hw(&pf->hw);
+	if (need_dev_deinit)
+		ice_deinit_dev(pf);
 	return err;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 808870539667..2272b0bd2add 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1130,6 +1130,9 @@ int ice_init_hw(struct ice_hw *hw)
 	status = ice_init_hw_tbls(hw);
 	if (status)
 		goto err_unroll_fltr_mgmt_struct;
+
+	ice_init_dev_hw(hw->back);
+
 	mutex_init(&hw->tnl_lock);
 	ice_init_chk_recipe_reuse_support(hw);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index faee44ad5928..c169134beb04 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4773,9 +4773,8 @@ static void ice_decfg_netdev(struct ice_vsi *vsi)
 	vsi->netdev = NULL;
 }
 
-int ice_init_dev(struct ice_pf *pf)
+void ice_init_dev_hw(struct ice_pf *pf)
 {
-	struct device *dev = ice_pf_to_dev(pf);
 	struct ice_hw *hw = &pf->hw;
 	int err;
 
@@ -4795,6 +4794,12 @@ int ice_init_dev(struct ice_pf *pf)
 		 */
 		ice_set_safe_mode_caps(hw);
 	}
+}
+
+int ice_init_dev(struct ice_pf *pf)
+{
+	struct device *dev = ice_pf_to_dev(pf);
+	int err;
 
 	ice_set_pf_caps(pf);
 	err = ice_init_interrupt_scheme(pf);
@@ -5251,6 +5256,7 @@ static int
 ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 {
 	struct device *dev = &pdev->dev;
+	bool need_dev_deinit = false;
 	struct ice_adapter *adapter;
 	struct ice_pf *pf;
 	struct ice_hw *hw;
@@ -5373,11 +5379,13 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 	devl_unlock(priv_to_devlink(pf));
 	ice_deinit(pf);
 unroll_dev_init:
-	ice_deinit_dev(pf);
+	need_dev_deinit = true;
 unroll_adapter:
 	ice_adapter_put(pdev);
 unroll_hw_init:
 	ice_deinit_hw(hw);
+	if (need_dev_deinit)
+		ice_deinit_dev(pf);
 	return err;
 }
 
@@ -5472,10 +5480,6 @@ static void ice_remove(struct pci_dev *pdev)
 
 	ice_hwmon_exit(pf);
 
-	ice_service_task_stop(pf);
-	ice_aq_cancel_waiting_tasks(pf);
-	set_bit(ICE_DOWN, pf->state);
-
 	if (!ice_is_safe_mode(pf))
 		ice_remove_arfs(pf);
 
@@ -5487,13 +5491,16 @@ static void ice_remove(struct pci_dev *pdev)
 	devl_unlock(priv_to_devlink(pf));
 
 	ice_deinit(pf);
-	ice_deinit_dev(pf);
 	ice_vsi_release_all(pf);
 
 	ice_setup_mc_magic_wake(pf);
 	ice_set_wake(pf);
 
 	ice_adapter_put(pdev);
+
+	ice_deinit_dev(pf);
+	ice_aq_cancel_waiting_tasks(pf);
+	set_bit(ICE_DOWN, pf->state);
 }
 
 /**
-- 
2.39.3


