Return-Path: <netdev+bounces-42029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B56F7CCBA7
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 21:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 829F0281B9A
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 19:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352C62DF9D;
	Tue, 17 Oct 2023 19:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MNJaVEZ/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A152DF68
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 19:04:30 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEDFF7
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 12:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697569469; x=1729105469;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=021HxRuTL5thXIfbIQD3o820zZI4N+mXSrrljJWVtcU=;
  b=MNJaVEZ/lpVZJsMlYHf2n76wV9AqQ/jOCGi5QN9iT3axo3Bfk/Xzdsgp
   LiFt80nV0mQH5OCYeIqyT/ui0oA+n5wZu8kgGcIVS7btx4x/gK6lq0jOk
   AS8BZF7xDLAigGvHpCoIARTGg8luruJSmQRoU6zFiXVfeIjw9h8x/aS5r
   QGkQpz0NnoOZ96PjTziHgu7shVVJLlF5wvmRUjor851B2VtgDM1gSKmOK
   pHdk0eHCFQ7fL09Nl37J/zwWLwR3KoDPj5Fp/zicmbo/D87v7NeOWjTn9
   FhJHgByYnDKqzlZmEhfJ+mjWqStZulDtuR2ZQ1qV5K3jSNqvWV+MEM7Dx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="384739709"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="384739709"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 12:04:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="822108703"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="822108703"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 12:04:18 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 2/9] intel: fix format warnings
Date: Tue, 17 Oct 2023 12:04:04 -0700
Message-ID: <20231017190411.2199743-3-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017190411.2199743-1-jacob.e.keller@intel.com>
References: <20231017190411.2199743-1-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

Get ahead of the game and fix all the -Wformat=2 noted warnings in the
intel drivers directory.

There are one set of i40e and iavf warnings I couldn't figure out how to
fix because the driver is already using vsnprintf without an explicit
"const char *" format string.

Tested with both gcc-12 and clang-15. I found gcc-12 runs clean after
this series but clang-15 is a little worried about the vsnprintf lines.

summary of warnings:

drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c:148:34: warning: format string is not a string literal [-Wformat-nonliteral]
drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c:1416:24: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c:1416:24: note: treat the string as an argument to avoid this
drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c:1421:6: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c:1421:6: note: treat the string as an argument to avoid this
drivers/net/ethernet/intel/igc/igc_ethtool.c:776:24: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
drivers/net/ethernet/intel/igc/igc_ethtool.c:776:24: note: treat the string as an argument to avoid this
drivers/net/ethernet/intel/igc/igc_ethtool.c:779:6: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
drivers/net/ethernet/intel/igc/igc_ethtool.c:779:6: note: treat the string as an argument to avoid this
drivers/net/ethernet/intel/iavf/iavf_ethtool.c:199:34: warning: format string is not a string literal [-Wformat-nonliteral]
drivers/net/ethernet/intel/igb/igb_ethtool.c:2360:6: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
drivers/net/ethernet/intel/igb/igb_ethtool.c:2360:6: note: treat the string as an argument to avoid this
drivers/net/ethernet/intel/igb/igb_ethtool.c:2363:6: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
drivers/net/ethernet/intel/igb/igb_ethtool.c:2363:6: note: treat the string as an argument to avoid this
drivers/net/ethernet/intel/i40e/i40e_ethtool.c:208:34: warning: format string is not a string literal [-Wformat-nonliteral]
drivers/net/ethernet/intel/i40e/i40e_ethtool.c:2515:23: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
drivers/net/ethernet/intel/i40e/i40e_ethtool.c:2515:23: note: treat the string as an argument to avoid this
drivers/net/ethernet/intel/i40e/i40e_ethtool.c:2519:23: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
drivers/net/ethernet/intel/i40e/i40e_ethtool.c:2519:23: note: treat the string as an argument to avoid this
drivers/net/ethernet/intel/ice/ice_ethtool.c:1064:6: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
drivers/net/ethernet/intel/ice/ice_ethtool.c:1064:6: note: treat the string as an argument to avoid this
drivers/net/ethernet/intel/ice/ice_ethtool.c:1084:6: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
drivers/net/ethernet/intel/ice/ice_ethtool.c:1084:6: note: treat the string as an argument to avoid this
drivers/net/ethernet/intel/ice/ice_ethtool.c:1100:24: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
drivers/net/ethernet/intel/ice/ice_ethtool.c:1100:24: note: treat the string as an argument to avoid this

Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c   | 6 ++++--
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c   | 8 +++-----
 drivers/net/ethernet/intel/ice/ice_ethtool.c     | 7 ++++---
 drivers/net/ethernet/intel/igb/igb_ethtool.c     | 4 ++--
 drivers/net/ethernet/intel/igc/igc_ethtool.c     | 5 +++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 4 ++--
 6 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index ebf36f76c0d7..fd7163128c4d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2514,11 +2514,13 @@ static void i40e_get_priv_flag_strings(struct net_device *netdev, u8 *data)
 	u8 *p = data;
 
 	for (i = 0; i < I40E_PRIV_FLAGS_STR_LEN; i++)
-		ethtool_sprintf(&p, i40e_gstrings_priv_flags[i].flag_string);
+		ethtool_sprintf(&p, "%s",
+				i40e_gstrings_priv_flags[i].flag_string);
 	if (pf->hw.pf_id != 0)
 		return;
 	for (i = 0; i < I40E_GL_PRIV_FLAGS_STR_LEN; i++)
-		ethtool_sprintf(&p, i40e_gl_gstrings_priv_flags[i].flag_string);
+		ethtool_sprintf(&p, "%s",
+				i40e_gl_gstrings_priv_flags[i].flag_string);
 }
 
 static void i40e_get_strings(struct net_device *netdev, u32 stringset,
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 9246172c9c33..6f236d1a6444 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -395,11 +395,9 @@ static void iavf_get_priv_flag_strings(struct net_device *netdev, u8 *data)
 {
 	unsigned int i;
 
-	for (i = 0; i < IAVF_PRIV_FLAGS_STR_LEN; i++) {
-		strscpy(data, iavf_gstrings_priv_flags[i].flag_string,
-			ETH_GSTRING_LEN);
-		data += ETH_GSTRING_LEN;
-	}
+	for (i = 0; i < IAVF_PRIV_FLAGS_STR_LEN; i++)
+		ethtool_sprintf(&data, "%s",
+				iavf_gstrings_priv_flags[i].flag_string);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index d3cb08e66dcb..5545906f39af 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1060,7 +1060,7 @@ __ice_get_strings(struct net_device *netdev, u32 stringset, u8 *data,
 	switch (stringset) {
 	case ETH_SS_STATS:
 		for (i = 0; i < ICE_VSI_STATS_LEN; i++)
-			ethtool_sprintf(&p,
+			ethtool_sprintf(&p, "%s",
 					ice_gstrings_vsi_stats[i].stat_string);
 
 		if (ice_is_port_repr_netdev(netdev))
@@ -1080,7 +1080,7 @@ __ice_get_strings(struct net_device *netdev, u32 stringset, u8 *data,
 			return;
 
 		for (i = 0; i < ICE_PF_STATS_LEN; i++)
-			ethtool_sprintf(&p,
+			ethtool_sprintf(&p, "%s",
 					ice_gstrings_pf_stats[i].stat_string);
 
 		for (i = 0; i < ICE_MAX_USER_PRIORITY; i++) {
@@ -1097,7 +1097,8 @@ __ice_get_strings(struct net_device *netdev, u32 stringset, u8 *data,
 		break;
 	case ETH_SS_PRIV_FLAGS:
 		for (i = 0; i < ICE_PRIV_FLAG_ARRAY_SIZE; i++)
-			ethtool_sprintf(&p, ice_gstrings_priv_flags[i].name);
+			ethtool_sprintf(&p, "%s",
+					ice_gstrings_priv_flags[i].name);
 		break;
 	default:
 		break;
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 319ed601eaa1..9cbd35b6df43 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2356,10 +2356,10 @@ static void igb_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 		break;
 	case ETH_SS_STATS:
 		for (i = 0; i < IGB_GLOBAL_STATS_LEN; i++)
-			ethtool_sprintf(&p,
+			ethtool_sprintf(&p, "%s",
 					igb_gstrings_stats[i].stat_string);
 		for (i = 0; i < IGB_NETDEV_STATS_LEN; i++)
-			ethtool_sprintf(&p,
+			ethtool_sprintf(&p, "%s",
 					igb_gstrings_net_stats[i].stat_string);
 		for (i = 0; i < adapter->num_tx_queues; i++) {
 			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 7ab6dd58e400..bf4f611286ae 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -773,9 +773,10 @@ static void igc_ethtool_get_strings(struct net_device *netdev, u32 stringset,
 		break;
 	case ETH_SS_STATS:
 		for (i = 0; i < IGC_GLOBAL_STATS_LEN; i++)
-			ethtool_sprintf(&p, igc_gstrings_stats[i].stat_string);
+			ethtool_sprintf(&p, "%s",
+					igc_gstrings_stats[i].stat_string);
 		for (i = 0; i < IGC_NETDEV_STATS_LEN; i++)
-			ethtool_sprintf(&p,
+			ethtool_sprintf(&p, "%s",
 					igc_gstrings_net_stats[i].stat_string);
 		for (i = 0; i < adapter->num_tx_queues; i++) {
 			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 0bbad4a5cc2f..4dd897806fa5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -1413,11 +1413,11 @@ static void ixgbe_get_strings(struct net_device *netdev, u32 stringset,
 	switch (stringset) {
 	case ETH_SS_TEST:
 		for (i = 0; i < IXGBE_TEST_LEN; i++)
-			ethtool_sprintf(&p, ixgbe_gstrings_test[i]);
+			ethtool_sprintf(&p, "%s", ixgbe_gstrings_test[i]);
 		break;
 	case ETH_SS_STATS:
 		for (i = 0; i < IXGBE_GLOBAL_STATS_LEN; i++)
-			ethtool_sprintf(&p,
+			ethtool_sprintf(&p, "%s",
 					ixgbe_gstrings_stats[i].stat_string);
 		for (i = 0; i < netdev->num_tx_queues; i++) {
 			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
-- 
2.41.0


