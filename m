Return-Path: <netdev+bounces-248416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 62ACED085A7
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 10:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 996C1300051C
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 09:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BA724293C;
	Fri,  9 Jan 2026 09:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mm8Mt4B4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8351F2D6E64
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767952416; cv=none; b=ZqIoNCxt7dGYzJEoVtWmLPGS+T0RPnRmHVo/cGQtpFIpJVxZDZRWOMxXyVlsaBQOxKt03RgxzYYCBsutskMDlGlieJfKufS08gUA7uTfTWRWfixTXHooOBdOeDJqEsOwsfZNZ5ODo4tZHrEdcFTiQqK3T1BJBotZy7CTiGiDjnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767952416; c=relaxed/simple;
	bh=RB5uC0PLRMLIszW++ntMi95ZkbuVdAu3AgLwewqxGYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tPSgbUQZwMjnLWK+yQL4/viH4vfeLUqc0KFWcw2arahHNdVTfjmAQFHKS0GfqWGAmG8iQAaU5gGGkU/w798Z7UIs9gQ7hZDRNOK2YhQVuKiR8kyxQa8IcPYfEe0/vPHrXQ1a70zPbuEKdy8s9JODb4hcCUW8BjkIs+5ViI3GPso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mm8Mt4B4; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767952416; x=1799488416;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RB5uC0PLRMLIszW++ntMi95ZkbuVdAu3AgLwewqxGYU=;
  b=mm8Mt4B4BL9mc5LSxweps1a5OFke2AVDuj1DkRSy3A25ylNFVnC5eWJB
   XoDx76IhTwLJ9FhC/DOB+r1TKFphUEAm2sxfkxw0xaLe/w9UD6YBwe9I3
   Ei9E4TDU351KYLfVQ3p3Abmgt/RA34aMEmCVXg96pMeWzBEwmhpVNFVOc
   BV7HYoL4XKT/jnuDg5HEJrzvCFfcVi8VSUf4WwXYoW6gLbmRUzSQTrJY7
   K+pcZ0GL90PxE9IkRlaZcBRNQpDqO7g1lo6YrhsGD9lIQM+cWpB2p8HBj
   YRqj9vJcCpyk7TtkLzQ1lH5h27x3Sl5v0PUFTxohUjAjfYN6QTdDHLG7s
   g==;
X-CSE-ConnectionGUID: PYtoIcNbS6agI/rYGUY+Jg==
X-CSE-MsgGUID: bZ+XYBBhSZqLg9W39I+kkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="80444233"
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; 
   d="scan'208";a="80444233"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 01:53:35 -0800
X-CSE-ConnectionGUID: wq7xPbJ/SriYC6E5Y/eZAA==
X-CSE-MsgGUID: TAQXvhJ3QIOgUXKXYCknJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; 
   d="scan'208";a="226813256"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa002.fm.intel.com with ESMTP; 09 Jan 2026 01:53:33 -0800
Received: from gond.igk.intel.com (gond.igk.intel.com [10.123.220.52])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 86320278D4;
	Fri,  9 Jan 2026 09:53:32 +0000 (GMT)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net] ice: fix setting RSS VSI hash for E830
Date: Fri,  9 Jan 2026 09:53:39 +0100
Message-ID: <20260109085339.49839-1-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ice_set_rss_hfunc() performs a VSI update, in which it sets hashing
function, leaving other VSI options unchanged. However, ::q_opt_flags is
mistakenly set to the value of another field, instead of its original
value, probably due to a typo. What happens next is hardware-dependent:

On E810, only the first bit is meaningful (see
ICE_AQ_VSI_Q_OPT_PE_FLTR_EN) and can potentially end up in a different
state than before VSI update.

On E830, some of the remaining bits are not reserved. Setting them
to some unrelated values can cause the firmware to reject the update
because of invalid settings, or worse - succeed.

Reproducer:
  sudo ethtool -X $PF1 equal 8

Output in dmesg:
  Failed to configure RSS hash for VSI 6, error -5

Fixes: 352e9bf23813 ("ice: enable symmetric-xor RSS for Toeplitz hash function")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index cf8ba5a85384..08268f1a03da 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -8038,7 +8038,7 @@ int ice_set_rss_hfunc(struct ice_vsi *vsi, u8 hfunc)
 	ctx->info.q_opt_rss |=
 		FIELD_PREP(ICE_AQ_VSI_Q_OPT_RSS_HASH_M, hfunc);
 	ctx->info.q_opt_tc = vsi->info.q_opt_tc;
-	ctx->info.q_opt_flags = vsi->info.q_opt_rss;
+	ctx->info.q_opt_flags = vsi->info.q_opt_flags;
 
 	err = ice_update_vsi(hw, vsi->idx, ctx, NULL);
 	if (err) {
-- 
2.49.0


