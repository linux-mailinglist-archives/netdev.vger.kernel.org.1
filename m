Return-Path: <netdev+bounces-200460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4201AE588C
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 02:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5F114A7A36
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 00:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94889170A26;
	Tue, 24 Jun 2025 00:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CcZRgBTe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D6113B7A3
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 00:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750725009; cv=none; b=T+C1OwJ2CcuZVry6ckYIV3aEl5mh1SdY9rDdMzaz1L25F/psOTiX06/xwvANLc8x1SYBfRiX2rbiPeWMRM7nOJCeoShh9mUM69qsWxy481Dxcy0l+qRWsTFVvnin4KRaD+Hbh6VdY1rBnFsDjKha4y2JVVFtX3dLE2ImYXUAdcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750725009; c=relaxed/simple;
	bh=VKI23w560cBcnUtRiEIYqxUcHvJkYoTBhjSEyjjnob0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eYGTEAAYUxissKQ4iplxxAZuqNa13oohzT000cIYdIiyl24cBQXORsctBYKMa1VkQmmasMqfqXQ6EU9tCtPM6LmIqotJq3eoPSmDjEMr9S/tgan1u4PSmtEDIY9ghPwRKbyH4dLEvX7tlPIxC3Y8cGDRVWXQFt8XSN5OGeIQLgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CcZRgBTe; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750725008; x=1782261008;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=VKI23w560cBcnUtRiEIYqxUcHvJkYoTBhjSEyjjnob0=;
  b=CcZRgBTeFuRoDVlLDj4hSfErXWIkvtEPn5/ANtB4xA1HGn7oa56jIaJF
   Ib0iEh9h+rw2RqY/jYjgF3XgxRk5vFom+pr6FShIlvRv9bFZ8ENZI4fFT
   NTofZuM9pJ3N2iCm8gxyaj2yLSS+FsbHYvPXwFQG/EmpuPpVz356PnP4v
   MJhuxE/wy0XGkKPB2m1jOCsfWpqh/ojkW+dUOeDY3l8SaZuysfHhbwrdt
   58W8kPo7LIIBztd9EHAg6k8cp8Dg26Cpd+6Nl6oGm+ZzLq0X7XQT/o/RS
   PbK0s0S9ThZQjXVSmcI/3WHXpl+sFmmflalr6ULx2UrnH0Bute+v4H8DF
   A==;
X-CSE-ConnectionGUID: JqOfrlwyQzm4zesxykYFaw==
X-CSE-MsgGUID: M63iazmfQSOnNikZ0CAehQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="52067909"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="52067909"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 17:30:06 -0700
X-CSE-ConnectionGUID: Ajz5ZZa/RKqa3sSP8X7U+w==
X-CSE-MsgGUID: GcH285SqR+mlyqSrii4EJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="157534035"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 17:30:05 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 23 Jun 2025 17:29:57 -0700
Subject: [PATCH 1/8] ice: clear time_sync_en field for E825-C during
 reprogramming
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-kk-tspll-improvements-alignment-v1-1-fe9a50620700@intel.com>
References: <20250623-kk-tspll-improvements-alignment-v1-0-fe9a50620700@intel.com>
In-Reply-To: <20250623-kk-tspll-improvements-alignment-v1-0-fe9a50620700@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org, 
 Karol Kolacinski <karol.kolacinski@intel.com>
X-Mailer: b4 0.14.2

When programming the Clock Generation Unit for E285-C hardware, we need
to clear the time_sync_en bit of the DWORD 9 before we set the
frequency.

Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tspll.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index 08af4ced50eb877dce5944d87a90d0dcdb49ff2e..5a2ddd3feba2f96d14c817a697423219cadc45e6 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -342,6 +342,14 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 			return err;
 	}
 
+	if (dw9.time_sync_en) {
+		dw9.time_sync_en = 0;
+
+		err = ice_write_cgue_reg(hw, ICE_CGU_R9, dw9.val);
+		if (err)
+			return err;
+	}
+
 	/* Set the frequency */
 	dw9.time_ref_freq_sel = clk_freq;
 
@@ -353,6 +361,7 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 		dw9.time_ref_en = 1;
 		dw9.clk_eref0_en = 0;
 	}
+	dw9.time_sync_en = 1;
 	err = ice_write_cgu_reg(hw, ICE_CGU_R9, dw9.val);
 	if (err)
 		return err;

-- 
2.48.1.397.gec9d649cc640


