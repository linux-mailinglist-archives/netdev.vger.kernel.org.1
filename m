Return-Path: <netdev+bounces-187177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EDBAA5844
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 00:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA613BC2B3
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 22:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4018622A7E2;
	Wed, 30 Apr 2025 22:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="neQtb9gg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A8D229B38
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 22:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746053511; cv=none; b=gTk2GiNta+Pn2/toaPQIH3HLYgSsU7cvEQ7RzqKiKkMEtYLiFjWmgAiMsVlyM4x5ocXtxiotO2pu+3L2eR1fMYMexiSD3yuofi1fQdIjiBycreYFZJLueSpcU/hzDeQzpNOEaD4DAp4/iL0pg7a/Om+7UZpEix4l+OeAwedA5GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746053511; c=relaxed/simple;
	bh=3UVbBMdtNLyZX+zfViLgWFfnhYDI5ZYcjL5Add/Iq64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XlgXK43f5TkBFmCMEJ2gZeQFLybkQpMD2cP/YHZtAedJiWwoFyxYhenKKhL2hhEg/vAUO2vD7bweH+rTo/Jbjldz+Gm7FaTd2ftIOifhjcjOdEg99rcjlAGMjnj4ecc3iTmBKaUZOvfHh0apL/uo1Dif2IMXo/xq/uwhygk5eIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=neQtb9gg; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746053509; x=1777589509;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=3UVbBMdtNLyZX+zfViLgWFfnhYDI5ZYcjL5Add/Iq64=;
  b=neQtb9ggGjHlGEGUTOkKKzm+YvdV1TF1X3e7lIdfmmrhybCro0U71yO2
   HsRT0oLE/MFlIWi8tsWD4A8kUzEIj/B7KevcJHT0tEwCzkkUwb2pWtMgB
   P63lQQ6Hug6IrRAogCf9O+jQtRrUvjeKFPC3vt72lPQCTWp9I8ZwuYz/w
   drfTJZ+04esSgzaCxSwENJHy2H9iZRCNTwDv4BDq57MUkvnNXjKwIOt8u
   QZdhtrX2ul/tvWLdfSY4G5W/rLncgfw5y2+Jl2T8b+3sD1g1KrC4adgps
   nIxWQvv/w3SrkwaAZOxCHyOuTK6zOoMVbgCVkuk3+slIwfjBPzMrHwkBT
   w==;
X-CSE-ConnectionGUID: TV07HCyfSiOcNdFKVFGAZQ==
X-CSE-MsgGUID: wst2mXSeSR+XdpWECogsUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="73120903"
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="73120903"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 15:51:41 -0700
X-CSE-ConnectionGUID: 1aOoT0+JRrySU08PsQswpA==
X-CSE-MsgGUID: +KOKqtylTAuIamStvrIqDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="134145091"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 15:51:40 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 30 Apr 2025 15:51:39 -0700
Subject: [PATCH v3 08/15] ice: clear time_sync_en field for E825-C during
 reprogramming
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-kk-tspll-improvements-alignment-v3-8-ab8472e86204@intel.com>
References: <20250430-kk-tspll-improvements-alignment-v3-0-ab8472e86204@intel.com>
In-Reply-To: <20250430-kk-tspll-improvements-alignment-v3-0-ab8472e86204@intel.com>
To: Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 netdev <netdev@vger.kernel.org>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Milena Olech <milena.olech@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Karol Kolacinski <karol.kolacinski@intel.com>
X-Mailer: b4 0.14.2

When programming the Clock Generation Unit for E285-C hardware, we need
to clear the time_sync_en bit of the DWORD 9 before we set the
frequency.

Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tspll.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index acb6a4e77678962f8dea61d914579888c9b87b23..f44a27252f384dbb9a1f57d5f9ac03b3b7adf037 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -285,6 +285,11 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 		ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R23, dw23.val);
 	}
 
+	if (dw9.time_sync_en) {
+		dw9.time_sync_en = 0;
+		ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R9, dw9.val);
+	}
+
 	/* Set the frequency */
 	dw9.time_ref_freq_sel = clk_freq;
 
@@ -296,6 +301,7 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 		dw9.time_ref_en = 1;
 		dw9.clk_eref0_en = 0;
 	}
+	dw9.time_sync_en = 1;
 	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R9, dw9.val);
 
 	/* Choose the referenced frequency */

-- 
2.48.1.397.gec9d649cc640


