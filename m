Return-Path: <netdev+bounces-199175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A4AADF4EA
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 19:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6246E16B8B8
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 17:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FBD2FE390;
	Wed, 18 Jun 2025 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="miqJu8zV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3081C2F94A5
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268572; cv=none; b=kyGSX367NepiTGrjza6bytuI8sWTw44u4saayCUklFsFgOtxa9VL79J+6g+keAPmWVcF+CCekzjlRmfaxa7qaBFl6SN0YGc+xWSQQNEa7r+wRAZu9SscHOTagfyEF/Lpd+mDMwTSxNZgwMhgTdw4CCEjBlFWXnfzORUJgHYWu44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268572; c=relaxed/simple;
	bh=SPgdNpTmbRvspp+yu+koBe82DWoqA/Xi5SseP6HBrlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BC/ba9ln8eoHiyEgWw8P/KwY7ako4a0MYbvdnq6xv24oyYYn0PvkBTwBx/jnfkGZe0xYZrgSkurWc4Bk3mg9B+kOdVpUYJyhzDORikJ5COlyo4GmrbfwZaTi8TRGoe2bqSu8B9NT+dOhC3aqcubBMS7lTa9+HtazvKeCqcKlYJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=miqJu8zV; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750268571; x=1781804571;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SPgdNpTmbRvspp+yu+koBe82DWoqA/Xi5SseP6HBrlQ=;
  b=miqJu8zVgLz2jhnhrlcwj3eGZstS3ABOmIEDYc3+bVmufFArqQ8EIB1Q
   I/ANIEXDpAyD0WLkYqvRSBTg8G9sjdIRmFT/PRrU7rtAtupWB3ilJmYPu
   rL4Lgl41OVMXojJHHYT0r05yo+pEXOBGexv+fp8PETe6EZBZmPWWAnE/X
   zYkT75X2X7U4GUJ9ookd57o23SQq0du7tXpjC3nRg5ChOI+mqTSPsYf0R
   ndASqnr7c2/W4974l5evKToX/FSEkaumsBVRRqkwHOwsVCRDJHky0iIh6
   3hp2Xbiz+mcoFZuTc3Pxr05c6BwEZXmfGd4dWA1JzgyU1c91ZxeWYp7m6
   g==;
X-CSE-ConnectionGUID: pqUDH1ePQ/mZr859ymbrnQ==
X-CSE-MsgGUID: hfJkjjlMQ7GBOInYfjGKxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="56183700"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="56183700"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 10:42:47 -0700
X-CSE-ConnectionGUID: 4RByatwbQPOxjjXZhmUZ7A==
X-CSE-MsgGUID: 1DO7oiRmSn2HnOtMmw1Nqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="149695888"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 18 Jun 2025 10:42:46 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com,
	Michal Kubiak <michal.kubiak@intel.com>,
	Milena Olech <milena.olech@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 05/15] ice: use designated initializers for TSPLL consts
Date: Wed, 18 Jun 2025 10:42:17 -0700
Message-ID: <20250618174231.3100231-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250618174231.3100231-1-anthony.l.nguyen@intel.com>
References: <20250618174231.3100231-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

Instead of multiple comments, use designated initializers for TSPLL
consts.

Adjust ice_tspll_params_e82x fields sizes.

Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tspll.c | 95 +++++++---------------
 drivers/net/ethernet/intel/ice/ice_tspll.h |  8 +-
 2 files changed, 34 insertions(+), 69 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index eb7fbae71984..cf0e37296796 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -7,76 +7,41 @@
 
 static const struct
 ice_tspll_params_e82x e82x_tspll_params[NUM_ICE_TSPLL_FREQ] = {
-	/* ICE_TSPLL_FREQ_25_000 -> 25 MHz */
-	{
-		/* refclk_pre_div */
-		1,
-		/* feedback_div */
-		197,
-		/* frac_n_div */
-		2621440,
-		/* post_pll_div */
-		6,
+	[ICE_TSPLL_FREQ_25_000] = {
+		.refclk_pre_div = 1,
+		.post_pll_div = 6,
+		.feedback_div = 197,
+		.frac_n_div = 2621440,
 	},
-
-	/* ICE_TSPLL_FREQ_122_880 -> 122.88 MHz */
-	{
-		/* refclk_pre_div */
-		5,
-		/* feedback_div */
-		223,
-		/* frac_n_div */
-		524288,
-		/* post_pll_div */
-		7,
+	[ICE_TSPLL_FREQ_122_880] = {
+		.refclk_pre_div = 5,
+		.post_pll_div = 7,
+		.feedback_div = 223,
+		.frac_n_div = 524288
 	},
-
-	/* ICE_TSPLL_FREQ_125_000 -> 125 MHz */
-	{
-		/* refclk_pre_div */
-		5,
-		/* feedback_div */
-		223,
-		/* frac_n_div */
-		524288,
-		/* post_pll_div */
-		7,
+	[ICE_TSPLL_FREQ_125_000] = {
+		.refclk_pre_div = 5,
+		.post_pll_div = 7,
+		.feedback_div = 223,
+		.frac_n_div = 524288
 	},
-
-	/* ICE_TSPLL_FREQ_153_600 -> 153.6 MHz */
-	{
-		/* refclk_pre_div */
-		5,
-		/* feedback_div */
-		159,
-		/* frac_n_div */
-		1572864,
-		/* post_pll_div */
-		6,
+	[ICE_TSPLL_FREQ_153_600] = {
+		.refclk_pre_div = 5,
+		.post_pll_div = 6,
+		.feedback_div = 159,
+		.frac_n_div = 1572864
 	},
-
-	/* ICE_TSPLL_FREQ_156_250 -> 156.25 MHz */
-	{
-		/* refclk_pre_div */
-		5,
-		/* feedback_div */
-		159,
-		/* frac_n_div */
-		1572864,
-		/* post_pll_div */
-		6,
+	[ICE_TSPLL_FREQ_156_250] = {
+		.refclk_pre_div = 5,
+		.post_pll_div = 6,
+		.feedback_div = 159,
+		.frac_n_div = 1572864
 	},
-
-	/* ICE_TSPLL_FREQ_245_760 -> 245.76 MHz */
-	{
-		/* refclk_pre_div */
-		10,
-		/* feedback_div */
-		223,
-		/* frac_n_div */
-		524288,
-		/* post_pll_div */
-		7,
+	[ICE_TSPLL_FREQ_245_760] = {
+		.refclk_pre_div = 10,
+		.post_pll_div = 7,
+		.feedback_div = 223,
+		.frac_n_div = 524288
 	},
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.h b/drivers/net/ethernet/intel/ice/ice_tspll.h
index 7aef430258e2..c0b1232cc07c 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.h
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.h
@@ -7,18 +7,18 @@
 /**
  * struct ice_tspll_params_e82x - E82X TSPLL parameters
  * @refclk_pre_div: Reference clock pre-divisor
+ * @post_pll_div: Post PLL divisor
  * @feedback_div: Feedback divisor
  * @frac_n_div: Fractional divisor
- * @post_pll_div: Post PLL divisor
  *
  * Clock Generation Unit parameters used to program the PLL based on the
  * selected TIME_REF/TCXO frequency.
  */
 struct ice_tspll_params_e82x {
-	u32 refclk_pre_div;
-	u32 feedback_div;
+	u8 refclk_pre_div;
+	u8 post_pll_div;
+	u8 feedback_div;
 	u32 frac_n_div;
-	u32 post_pll_div;
 };
 
 #define ICE_TSPLL_CK_REFCLKFREQ_E825		0x1F
-- 
2.47.1


