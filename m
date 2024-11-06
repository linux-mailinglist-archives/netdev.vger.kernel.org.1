Return-Path: <netdev+bounces-142501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 586D39BF5D9
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 19:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AFE51F22EC5
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 18:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E21209696;
	Wed,  6 Nov 2024 18:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XenMr2lm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ACA207A1A
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 18:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730919535; cv=none; b=o2AZ5+h+FHHizYkaD6Xad4/IG+CpH0OFvaKuOvaXl4oTm0Vy0Ha0dCIR0XJWQG61R9bl3HvOeedmVLwTkR9WdXOBG3Xhnka48YBcKQrdttRYI/zvNAtkf4Oq2zAguCZ4j8PkwPJtl1dg6LLOcO0PRwr21+h1q+rOEfwPSeEg8f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730919535; c=relaxed/simple;
	bh=QOTNwCbXC0dEBBEghJ97he0ts6uyFWd6JAr1mw42WaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ejj58tfBpamBGdqaahysrhxErHaNldNaLcLCcYEx9zgPZee5fIZ+MzRL7OfrtGGOnhto2SL6gTtkS2D0CpH64e9akiti2fBjqqyLNQRaBs42bS1IoL2+ye3H26RLCGUESO9O22NB0JoTaOilN96rroZWuGhGeuepZzUi9Ofccz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XenMr2lm; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730919534; x=1762455534;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QOTNwCbXC0dEBBEghJ97he0ts6uyFWd6JAr1mw42WaI=;
  b=XenMr2lmssLaaEdzlCwcQmqR4FOWRiJRC5KpiRBxHSkFHXTSa3Azw0Q0
   VVibS6MnePV/jKn8YJQRHmb1XBnCtjvOhtjwbXMUoiJDAHmrAxV536xRT
   biGO9389q8me9HMOhH7HV46AyPLXQOU+s8vQ+qCh0Aq3Fjc8BCcpgJX16
   h7NV4wDDvOoPLriUCiFVUbtd+yH+H+MpC70mkJOWCu2ri/join7e9zVOT
   s0YdaNR+I47e3KE5nJZes+3OKkxagYmlqPLHLFCAibj3hjy2LvA7KwrUJ
   E7alOiZqsrgbLiFhYD8uYstkAFVheoJ4FhfCz6FzWq09QZ+w0q+G2D4HU
   g==;
X-CSE-ConnectionGUID: Kpk7y74tTBK70hD/Xkp8Ug==
X-CSE-MsgGUID: Rfqhq+PKTlGJpvBmBg/klA==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="30959470"
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="30959470"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 10:58:51 -0800
X-CSE-ConnectionGUID: Wt116T5XSFmacTxaz98PaQ==
X-CSE-MsgGUID: kiB6UEE4S4ecp80eDo+RnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="89813797"
Received: from timelab-spr11.ch.intel.com ([143.182.136.151])
  by orviesa004.jf.intel.com with ESMTP; 06 Nov 2024 10:56:41 -0800
From: Christopher S M Hall <christopher.s.hall@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: david.zage@intel.com,
	vinicius.gomes@intel.com,
	netdev@vger.kernel.org,
	rodrigo.cadore@l-acoustics.com,
	vinschen@redhat.com
Subject: [PATCH iwl-net v3 4/6] igc: Handle the IGC_PTP_ENABLED flag correctly
Date: Wed,  6 Nov 2024 18:47:20 +0000
Message-Id: <20241106184722.17230-5-christopher.s.hall@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241106184722.17230-1-christopher.s.hall@intel.com>
References: <20241106184722.17230-1-christopher.s.hall@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All functions in igc_ptp.c called from igc_main.c should check the
IGC_PTP_ENABLED flag. Adding check for this flag to stop and reset
functions.

Fixes: 5f2958052c58 ("igc: Add basic skeleton for PTP")
Signed-off-by: Christopher S M Hall <christopher.s.hall@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ptp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 516abe7405de..343205bffc35 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -1244,8 +1244,12 @@ void igc_ptp_suspend(struct igc_adapter *adapter)
  **/
 void igc_ptp_stop(struct igc_adapter *adapter)
 {
+	if (!(adapter->ptp_flags & IGC_PTP_ENABLED))
+		return;
+
 	igc_ptp_suspend(adapter);
 
+	adapter->ptp_flags &= ~IGC_PTP_ENABLED;
 	if (adapter->ptp_clock) {
 		ptp_clock_unregister(adapter->ptp_clock);
 		netdev_info(adapter->netdev, "PHC removed\n");
@@ -1266,6 +1270,9 @@ void igc_ptp_reset(struct igc_adapter *adapter)
 	unsigned long flags;
 	u32 timadj;
 
+	if (!(adapter->ptp_flags & IGC_PTP_ENABLED))
+		return;
+
 	/* reset the tstamp_config */
 	igc_ptp_set_timestamp_mode(adapter, &adapter->tstamp_config);
 
-- 
2.34.1


