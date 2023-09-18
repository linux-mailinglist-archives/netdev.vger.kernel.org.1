Return-Path: <netdev+bounces-34820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9C27A5511
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 23:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2508A1C20B8C
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B57F30F98;
	Mon, 18 Sep 2023 21:28:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C8028DDA
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 21:28:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55711114
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 14:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695072527; x=1726608527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wv1pJ7U0vbAAlzDhMSfDGvxZf60QlRqgjhjl/ctZJlQ=;
  b=S4MrKht2dYosLg/d/QOYVppThr5Fliv8YpdV5CKbm7EvdXJYeN5rbk85
   MwCQkLqWBEYbao3Dr56a9CRwL7O3q8cmflSCUpOZxC9fwtGqdiM5sb3BA
   aRfx3rtlrwzs7xMGfNyC0xLK8l9Yifh/xDPXQ+ZnNl1mAbw7WEATrXB+2
   OX5ddno+DhZiQrTV+0hrHZK0pN7y+juxKeiEQWOI9qRDy1hwWEu+ENlcY
   u6AS6Ph1cIK+RkWiCqBxr7anjRiC1l4NNmKXntLBbQqbd9D5wLuaOT+1r
   7yb8muMT/RMKw8zXOw7KThNBT6hk10tT7q93ZejX5JRzm1chPatxCREl0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="359187261"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="359187261"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 14:28:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="749186215"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="749186215"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga007.fm.intel.com with ESMTP; 18 Sep 2023 14:28:45 -0700
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
Subject: [PATCH net-next v2 06/11] ice: PTP: Rename macros used for PHY/QUAD port definitions
Date: Mon, 18 Sep 2023 14:28:09 -0700
Message-Id: <20230918212814.435688-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230918212814.435688-1-anthony.l.nguyen@intel.com>
References: <20230918212814.435688-1-anthony.l.nguyen@intel.com>
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
index 10445bba6539..7c18dbac49d0 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -294,9 +294,9 @@ ice_fill_phy_msg_e822(struct ice_sbq_msg_input *msg, u8 port, u16 offset)
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
@@ -628,7 +628,7 @@ ice_fill_quad_msg_e822(struct ice_sbq_msg_input *msg, u8 quad, u16 offset)
 
 	msg->dest_dev = rmn_0;
 
-	if ((quad % ICE_NUM_QUAD_TYPE) == 0)
+	if ((quad % ICE_QUADS_PER_PHY_E822) == 0)
 		addr = Q_0_BASE + offset;
 	else
 		addr = Q_1_BASE + offset;
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 4cd131546aa9..bb5d8b681bc2 100644
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


