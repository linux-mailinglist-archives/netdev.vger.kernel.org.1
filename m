Return-Path: <netdev+bounces-187323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E454AAA6680
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 00:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFA671BC6EFC
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 22:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078092676C0;
	Thu,  1 May 2025 22:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F01VcChY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AB6264A90
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 22:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140077; cv=none; b=XE7YE5vkczuITuAFp33Ri7Tsf5PRTaC2nBD4NUoD5sue1jk1M/6iiLhgM5ia7mrvduR+35WypqZYyw3FYMizWZw1948wNRHbZfvqEnaeB0pVWIXpM+LzUgL4a8SQ+WXG7+mlsmcOIyqqPazdPsOJpT4U1GQp1Ulia6JbFiEOBzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140077; c=relaxed/simple;
	bh=p4ooCRtCJKeRfP1ccPMjYMHRLD7QTyW54ke+j3QUJog=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VMfUyFQQDnTrnFBDXRcd9TIcOcl1wqM9iRdXzy+aQQAJQCnptgtI38FX6XZVrtOe76OQCIXz0QzeSd2kb2N2M+CfoLDQ2ut9FbXtjNzClzKJMAzpuBqjwsUM8L+VTf1s0jORpkXHH3In9XMwsG/bfiTVCM1tJV4BGNL/m9XXraY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F01VcChY; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746140077; x=1777676077;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=p4ooCRtCJKeRfP1ccPMjYMHRLD7QTyW54ke+j3QUJog=;
  b=F01VcChYjIT8ca5mxNYl7c7UfDL/sIo6K3qGWMdBWWx1lAF33XvCkvsh
   N8Ta307wWdmL0hm68z22HdL6vCWT8Cn5BhVwzz2WpjWX0U899G2S3UQPi
   IjCoxOi56yBDwJOsI3IxZEO21BMCfByiVqDObI51lvI+UKw8qiewRucGp
   4tyD4VxykplkIod6fBKj2tbgPis/19MdMyVppw+Io6/kjxiiaZHhUSKNu
   hmLsmzwLj2HuD2++5ww8tGUkNH+1lM/TZ9CwoVNLEXqc1nC/2jmQQ74KL
   lrD+hxDd8EKPExiMmT8+ZOsRcI6aL3OPBWpwRIxaaH+e7nBcl0fmaLMSZ
   g==;
X-CSE-ConnectionGUID: +r/CUxPoRVOCid1UQBTvAw==
X-CSE-MsgGUID: juIKBlsOTcaze+T/EyH/fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="58811717"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="58811717"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 15:54:34 -0700
X-CSE-ConnectionGUID: DWG51QrqQxKY4JU1uB7ZHw==
X-CSE-MsgGUID: Ba64fF4eTom7MBMs8fmN9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="138514284"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 15:54:32 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 01 May 2025 15:54:16 -0700
Subject: [PATCH v4 05/15] ice: use designated initializers for TSPLL consts
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250501-kk-tspll-improvements-alignment-v4-5-24c83d0ce7a8@intel.com>
References: <20250501-kk-tspll-improvements-alignment-v4-0-24c83d0ce7a8@intel.com>
In-Reply-To: <20250501-kk-tspll-improvements-alignment-v4-0-24c83d0ce7a8@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Karol Kolacinski <karol.kolacinski@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Milena Olech <milena.olech@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>
X-Mailer: b4 0.14.2

From: Karol Kolacinski <karol.kolacinski@intel.com>

Instead of multiple comments, use designated initializers for TSPLL
consts.

Adjust ice_tspll_params_e82x fields sizes.

Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tspll.h |  8 +--
 drivers/net/ethernet/intel/ice/ice_tspll.c | 95 ++++++++++--------------------
 2 files changed, 34 insertions(+), 69 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.h b/drivers/net/ethernet/intel/ice/ice_tspll.h
index 7aef430258e23e8e65cfc37ef8436ac158fa7ee5..c0b1232cc07c3ebd73264d16fc9cd8bfaec29fec 100644
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
diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index eb7fbae719843e8b446f78943a2edcc4d5a9de6c..cf0e37296796c5bbda011d027dc8ef007b0e2021 100644
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
 

-- 
2.48.1.397.gec9d649cc640


