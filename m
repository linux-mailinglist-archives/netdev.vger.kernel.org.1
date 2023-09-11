Return-Path: <netdev+bounces-32899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE1D79AABE
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 20:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E998928139E
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 18:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36C715AEF;
	Mon, 11 Sep 2023 18:11:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC3F156EA
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 18:11:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F12D106
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 11:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694455865; x=1725991865;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K4+47zPUKpvW+4LzkMFLvrrsTmPb8XcoBe5SRLEtAf8=;
  b=NxjLnFJwu7RQ17N5+eGcv4eF0Oulix/4l1fhrMELygcwTCjU56o6SJY/
   3dz7MIMp06qRs1C8xKt+rTtYHg+0iZQnqS8zI93wSun8L214Gj3YN1AHw
   4rH7vmgE1gZagF+3MxPNeD6efHj3p6qqvj8YsRlxucb//VVDCHsq23cjH
   c4R1UZK7gz1zILvkgE0UoBVUBK1jR8wiNnK1cT302mIfdn/BHpfVpcZmH
   pWM5D3FR3quFTjXyYuQ7KWmOZj7oj+dUKOJzY/hQA45sqfgcO9fI1mx2x
   sPNU6/VusHwmG3JUxhYyO3NcSRs1hDqH8YUq5/mTsu8jA3y/ME9xZyV7G
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="378075646"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="378075646"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 11:11:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="917129939"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="917129939"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga005.jf.intel.com with ESMTP; 11 Sep 2023 11:11:01 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 06/13] ice: PTP: Rename macros used for PHY/QUAD port definitions
Date: Mon, 11 Sep 2023 11:03:07 -0700
Message-Id: <20230911180314.4082659-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230911180314.4082659-1-anthony.l.nguyen@intel.com>
References: <20230911180314.4082659-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Karol Kolacinski <karol.kolacinski@intel.com>

The ice_fill_phy_msg_e822 function uses several macros to specify the
correct address when sending a sideband message to the PHY block in
hardware.

The names of these macros are fairly generic and confusing. Future
development is going to extend the driver to support new hardware families
which have different relationships between PHY and QUAD. Rename the macros
for clarity and to indicate that they are E822 specific. This also matches
closer to the hardware specification in the data sheet.

Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c |  8 ++++----
 drivers/net/ethernet/intel/ice/ice_type.h   | 14 +++++++-------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 8d1961dc06e6..489dfbbe7290 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -168,9 +168,9 @@ ice_fill_phy_msg_e822(struct ice_sbq_msg_input *msg, u8 port, u16 offset)
 {
 	int phy_port, phy, quadtype;
 
-	phy_port = port % ICE_PORTS_PER_PHY;
-	phy = port / ICE_PORTS_PER_PHY;
-	quadtype = (port / ICE_PORTS_PER_QUAD) % ICE_NUM_QUAD_TYPE;
+	phy_port = port % ICE_PORTS_PER_PHY_E822;
+	phy = port / ICE_PORTS_PER_PHY_E822;
+	quadtype = (port / ICE_PORTS_PER_QUAD) % ICE_QUADS_PER_PHY_E822;
 
 	if (quadtype == 0) {
 		msg->msg_addr_low = P_Q0_L(P_0_BASE + offset, phy_port);
@@ -502,7 +502,7 @@ ice_fill_quad_msg_e822(struct ice_sbq_msg_input *msg, u8 quad, u16 offset)
 
 	msg->dest_dev = rmn_0;
 
-	if ((quad % ICE_NUM_QUAD_TYPE) == 0)
+	if ((quad % ICE_QUADS_PER_PHY_E822) == 0)
 		addr = Q_0_BASE + offset;
 	else
 		addr = Q_1_BASE + offset;
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 86165d388f34..a5429eca4350 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -909,13 +909,13 @@ struct ice_hw {
 	/* INTRL granularity in 1 us */
 	u8 intrl_gran;
 
-#define ICE_PHY_PER_NAC		1
-#define ICE_MAX_QUAD		2
-#define ICE_NUM_QUAD_TYPE	2
-#define ICE_PORTS_PER_QUAD	4
-#define ICE_PHY_0_LAST_QUAD	1
-#define ICE_PORTS_PER_PHY	8
-#define ICE_NUM_EXTERNAL_PORTS		ICE_PORTS_PER_PHY
+#define ICE_PHY_PER_NAC_E822		1
+#define ICE_MAX_QUAD			2
+#define ICE_QUADS_PER_PHY_E822		2
+#define ICE_PORTS_PER_PHY_E822		8
+#define ICE_PORTS_PER_QUAD		4
+#define ICE_PORTS_PER_PHY_E810		4
+#define ICE_NUM_EXTERNAL_PORTS		(ICE_MAX_QUAD * ICE_PORTS_PER_QUAD)
 
 	/* Active package version (currently active) */
 	struct ice_pkg_ver active_pkg_ver;
-- 
2.38.1


