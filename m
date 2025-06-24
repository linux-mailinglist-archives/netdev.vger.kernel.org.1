Return-Path: <netdev+bounces-200466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E46AE5898
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 02:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECDA44A81A6
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 00:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421D970823;
	Tue, 24 Jun 2025 00:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fL8yuJzu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938CB1946DF
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 00:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750725013; cv=none; b=P61UJp/paUzbz14m/je8D2UpvyDJ9NthZTWVdEQW1JiNnBqyNPoCqIvGasBCgkepGiwVvCLY8u+LvlmzXWn6K52K2MDMZaTEKRAIoH6CmVR5betxGKHOcvrfmc/HyOzhKgtrqhqYp6T4q9wXluidDjlMMgQbyFByhKEwRGBqTYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750725013; c=relaxed/simple;
	bh=HCof3ZorrURb/XNOTqNcJBeLxfq4ji8wlBJfgFY5nlI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZDwYXKjy+p9wQ2iH1KuhVw8DnBkoeNU9YtcVknmUOwYbWrWtb0YwzeAnuXdlb92N9k/6nOls28k572Zc6od/jthmMv1BOka8RxfvlOZRzoHR7heyG3g4VuvXAkm+YmcB2WCvMkDbWbUxJWPesrCsrLMyRx5p+RWWam/BMYjliqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fL8yuJzu; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750725012; x=1782261012;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=HCof3ZorrURb/XNOTqNcJBeLxfq4ji8wlBJfgFY5nlI=;
  b=fL8yuJzuLzhJtN1aDwY2zCEhCYWQv0dnV9OTO293owi30ub3H4jeVDqG
   aa0WmwqU5cgPk/g3hvgkQ7TP90ZfsCIkHhseY7OxWHKV1HKZxMt1nKICo
   Mf9ey7z3mTCNMObgLnR7OdgTFpiBcztRZo9gKQGFeXZ6KnG7ursJYnI70
   hVsjxDFeiw0jTioyIkWgZiLG/UwKU8C3NGjXd9WT/BzgHzCDYghWsNuQ6
   zamthm6+NY+8ozFMOnWnhPpCk07IbjEHHcLOq+DoMUWZJhstOA/LP7LuB
   mmSm6/zEGjMtvLpTl4yIcsunqG72SZz7IAD8wtGOSY37QU3X83zeBqXfP
   A==;
X-CSE-ConnectionGUID: nkbtx50XSkmz0i2X/nM2Pw==
X-CSE-MsgGUID: EKC8E81YRcKzfaCVGb9qYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="52067920"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="52067920"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 17:30:07 -0700
X-CSE-ConnectionGUID: dML8eh9aRd+IHAPTLd7RFg==
X-CSE-MsgGUID: pjHfOmlySHWIDmwXqDBFeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="157534056"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 17:30:06 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 23 Jun 2025 17:30:04 -0700
Subject: [PATCH 8/8] ice: default to TIME_REF instead of TXCO on E825-C
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-kk-tspll-improvements-alignment-v1-8-fe9a50620700@intel.com>
References: <20250623-kk-tspll-improvements-alignment-v1-0-fe9a50620700@intel.com>
In-Reply-To: <20250623-kk-tspll-improvements-alignment-v1-0-fe9a50620700@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org
X-Mailer: b4 0.14.2

The driver currently defaults to the internal oscillator as the clock
source for E825-C hardware. While this clock source is labeled TCXO,
indicating a temperature compensated oscillator, this is only true for some
board designs. Many board designs have a less capable oscillator. The
E825-C hardware may also have its clock source set to the TIME_REF pin.
This pin is connected to the DPLL and is often a more stable clock source.
The choice of the internal oscillator is not suitable for all systems,
especially those which want to enable SyncE support.

There is currently no interface available for users to configure the clock
source. Other variants of the E82x board have the clock source configured
in the NVM, but E825-C lacks this capability, so different board designs
cannot select a different default clock via firmware.

In most setups, the TIME_REF is a suitable default clock source.
Additionally, we now fall back to the internal oscillator automatically if
the TIME_REF clock source cannot be locked.

Change the default clock source for E825-C to TIME_REF. Note that the
driver logs a dev_dbg message upon configuring the TSPLL which includes the
clock source and frequency. This can be enabled to confirm which clock
source is in use.

Longterm a proper interface to dynamically introspect and change the clock
source will be designed (perhaps some extension of the DPLL subsystem?)

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index bc292d61892c3856919c6986f28795e50b0c0748..84cd8c6dcf39bf35c59ad27468d4e63f9b575376 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2302,7 +2302,7 @@ ice_parse_1588_func_caps(struct ice_hw *hw, struct ice_hw_func_caps *func_p,
 		info->clk_src = ((number & ICE_TS_CLK_SRC_M) != 0);
 	} else {
 		info->clk_freq = ICE_TSPLL_FREQ_156_250;
-		info->clk_src = ICE_CLK_SRC_TCXO;
+		info->clk_src = ICE_CLK_SRC_TIME_REF;
 	}
 
 	if (info->clk_freq < NUM_ICE_TSPLL_FREQ) {

-- 
2.48.1.397.gec9d649cc640


