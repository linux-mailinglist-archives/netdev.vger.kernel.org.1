Return-Path: <netdev+bounces-222596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3B5B54F2D
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 15:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38A807AE1C3
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 13:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109F730FC14;
	Fri, 12 Sep 2025 13:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F2eoKkGc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB3C30F550
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 13:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683040; cv=none; b=GYqnohk3zl4LWurskzK9oFRxtGdHQwdnWwCmh8u6S4CLT2m5u9NyA+p6I3meWtKqB5Jf3/DLwlaZ/h1DGtZREwFL6cqb88R0GjLG+FplvLKYcbYSJrx+kWf01wK4fKPOf0IfrtPMpNjJNbiewuig936BLsgyTa1Ml/cmIUY6gp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683040; c=relaxed/simple;
	bh=EuAcG0yM7njKO2DdFrnScVlD8tGBmuabGN0D+8eny7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TT5PiXJ0ycGoHjs8v/YlD6vHOMzMwMn+TvmRQGfBsbn0WOu0/qcmjMsk7bXaQRJ7Or9b6PqvuIcT46+ZmnoZA97zY5Q1smCTavB9phTEkpy0zcjbCryTwg7in0V92MPL3HmK3Ffs2npkjcYN34egn3V18OR9yY32AOEh0BAbCSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F2eoKkGc; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757683038; x=1789219038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EuAcG0yM7njKO2DdFrnScVlD8tGBmuabGN0D+8eny7c=;
  b=F2eoKkGceVYwRqqAo2Aok/ykJjHqamWyYSaND4BmHH2S4fiVgywUnIcK
   qvV3dlT6rjAaE1ElZxuL+8a5Pc7NtGZu5CYakU0BgVmmlSsPAN3oTj1eN
   dUFWr3WK1NyPx+71M8FybTfVTSF3LXCK7zlbsEv8l3sJ+YFZeInnPGXd4
   dCsSK79Z4unoKe/TiGrBvxPiR97OR2KBpfdf27x626O/Co8AD8+Vu4pCP
   KkAaxKHXkXF/OOUA7ub+bldklywg1ZiX6JNQevFx09ajESGG0HJziapYd
   2ngv/OhlzxFRoEakLrR/9S2JiL7yW6WgJJSfxx2RWf9mBkReqpH1JIZLQ
   Q==;
X-CSE-ConnectionGUID: GCKD21SVRlmPhV6nRjM/EA==
X-CSE-MsgGUID: f5x6VwvCT7ubgU8Eku7M9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="85461436"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="85461436"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 06:17:16 -0700
X-CSE-ConnectionGUID: 7+Iq9igTS02weQMeF08e6w==
X-CSE-MsgGUID: 637zUvYxTFOAiON/icoxog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="173131234"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa006.jf.intel.com with ESMTP; 12 Sep 2025 06:17:14 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 52BAA2FC6F;
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
Subject: [PATCH iwl-next 7/9] ice: extract ice_init_dev() from ice_init()
Date: Fri, 12 Sep 2025 15:06:25 +0200
Message-Id: <20250912130627.5015-8-przemyslaw.kitszel@intel.com>
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

Extract ice_init_dev() from ice_init(), to allow service task and IRQ
scheme teardown to be put after clearing SW constructs in the subsequent
commit.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 6d9de6e24804..faee44ad5928 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5054,14 +5054,10 @@ static int ice_init(struct ice_pf *pf)
 	struct device *dev = ice_pf_to_dev(pf);
 	int err;
 
-	err = ice_init_dev(pf);
-	if (err)
-		return err;
-
 	err = ice_init_pf(pf);
 	if (err) {
 		dev_err(dev, "ice_init_pf failed: %d\n", err);
-		goto unroll_dev_init;
+		return err;
 	}
 
 	if (pf->hw.mac_type == ICE_MAC_E830) {
@@ -5111,8 +5107,6 @@ static int ice_init(struct ice_pf *pf)
 	ice_dealloc_vsis(pf);
 unroll_pf_init:
 	ice_deinit_pf(pf);
-unroll_dev_init:
-	ice_deinit_dev(pf);
 	return err;
 }
 
@@ -5124,7 +5118,6 @@ static void ice_deinit(struct ice_pf *pf)
 	ice_deinit_pf_sw(pf);
 	ice_dealloc_vsis(pf);
 	ice_deinit_pf(pf);
-	ice_deinit_dev(pf);
 }
 
 /**
@@ -5354,10 +5347,14 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 	}
 	pf->adapter = adapter;
 
-	err = ice_init(pf);
+	err = ice_init_dev(pf);
 	if (err)
 		goto unroll_adapter;
 
+	err = ice_init(pf);
+	if (err)
+		goto unroll_dev_init;
+
 	devl_lock(priv_to_devlink(pf));
 	err = ice_load(pf);
 	if (err)
@@ -5375,6 +5372,8 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 unroll_init:
 	devl_unlock(priv_to_devlink(pf));
 	ice_deinit(pf);
+unroll_dev_init:
+	ice_deinit_dev(pf);
 unroll_adapter:
 	ice_adapter_put(pdev);
 unroll_hw_init:
@@ -5488,6 +5487,7 @@ static void ice_remove(struct pci_dev *pdev)
 	devl_unlock(priv_to_devlink(pf));
 
 	ice_deinit(pf);
+	ice_deinit_dev(pf);
 	ice_vsi_release_all(pf);
 
 	ice_setup_mc_magic_wake(pf);
-- 
2.39.3


