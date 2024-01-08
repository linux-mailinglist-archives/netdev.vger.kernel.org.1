Return-Path: <netdev+bounces-62400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECE0826EE5
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 13:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BF681C22680
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 12:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1E745976;
	Mon,  8 Jan 2024 12:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kdT6c4ZB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C753FE49
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 12:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704718053; x=1736254053;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5P0CYo/qRMZgkISiZH4v67ugfCQ8kmfz/syHPQp0GDE=;
  b=kdT6c4ZBJ6xMOrnwVbF6UQ+fGDAUJEcsn2MOWtK/ap9VXLaMABcZ1h0k
   JB9cGi9Ko4wv8wChpjKOmawNboxh/ZWhUGY6/DEtoPD1ZzZ1ml/TH8jJk
   bn0H2YBcTBvpxjDAN0JBi3nr2bevfYa1XVg6HXfBiJ/hMjhmh+uqbdFAW
   1ZpDbNNjo9CaBXBTYn5E457CSot2ogwi2KxJFVD8C8mB4KWAiK9n2+bml
   qosHuhdOTrkz8LHyZoRDdfmekdOiYDE6mCM5a4II5yWu56/jD01fumm0h
   NgmvqUPRGiUN0ahHcd0qtIkS9I6Py0V4PC3w6begm62MUm4JDbcUTAi3B
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="11359584"
X-IronPort-AV: E=Sophos;i="6.04,341,1695711600"; 
   d="scan'208";a="11359584"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 04:47:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="904791330"
X-IronPort-AV: E=Sophos;i="6.04,341,1695711600"; 
   d="scan'208";a="904791330"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by orsmga004.jf.intel.com with ESMTP; 08 Jan 2024 04:47:30 -0800
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v5 iwl-next 4/6] ice: rename ice_ptp_tx_cfg_intr
Date: Mon,  8 Jan 2024 13:47:15 +0100
Message-Id: <20240108124717.1845481-5-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240108124717.1845481-1-karol.kolacinski@intel.com>
References: <20240108124717.1845481-1-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The ice_ptp_tx_cfg_intr() function sends a control queue message to
configure the PHY timestamp interrupt block. This is a very similar name
to a function which is used to configure the MAC Other Interrupt Cause
Enable register.

Rename this function to ice_ptp_cfg_phy_interrupt in order to make it
more obvious to the reader what action it performs, and distinguish it
from other similarly named functions.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 4b1b2c577df7..fe2d8389627b 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1455,14 +1455,14 @@ void ice_ptp_link_change(struct ice_pf *pf, u8 port, bool linkup)
 }
 
 /**
- * ice_ptp_tx_ena_intr - Enable or disable the Tx timestamp interrupt
+ * ice_ptp_cfg_phy_interrupt - Configure PHY interrupt settings
  * @pf: PF private structure
  * @ena: bool value to enable or disable interrupt
  * @threshold: Minimum number of packets at which intr is triggered
  *
  * Utility function to enable or disable Tx timestamp interrupt and threshold
  */
-static int ice_ptp_tx_ena_intr(struct ice_pf *pf, bool ena, u32 threshold)
+static int ice_ptp_cfg_phy_interrupt(struct ice_pf *pf, bool ena, u32 threshold)
 {
 	struct ice_hw *hw = &pf->hw;
 	int err = 0;
@@ -2674,8 +2674,8 @@ void ice_ptp_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 	struct ice_ptp *ptp = &pf->ptp;
 	struct ice_hw *hw = &pf->hw;
 	struct timespec64 ts;
-	int err, itr = 1;
 	u64 time_diff;
+	int err;
 
 	if (ptp->state != ICE_PTP_RESETTING) {
 		if (ptp->state == ICE_PTP_READY) {
@@ -2728,7 +2728,7 @@ void ice_ptp_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 
 	if (!ice_is_e810(hw)) {
 		/* Enable quad interrupts */
-		err = ice_ptp_tx_ena_intr(pf, true, itr);
+		err = ice_ptp_cfg_phy_interrupt(pf, true, 1);
 		if (err)
 			goto err;
 	}
@@ -2981,7 +2981,7 @@ static int ice_ptp_init_owner(struct ice_pf *pf)
 {
 	struct ice_hw *hw = &pf->hw;
 	struct timespec64 ts;
-	int err, itr = 1;
+	int err;
 
 	err = ice_ptp_init_phc(hw);
 	if (err) {
@@ -3016,7 +3016,7 @@ static int ice_ptp_init_owner(struct ice_pf *pf)
 
 	if (!ice_is_e810(hw)) {
 		/* Enable quad interrupts */
-		err = ice_ptp_tx_ena_intr(pf, true, itr);
+		err = ice_ptp_cfg_phy_interrupt(pf, true, 1);
 		if (err)
 			goto err_exit;
 	}
-- 
2.40.1


