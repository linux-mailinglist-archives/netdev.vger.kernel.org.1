Return-Path: <netdev+bounces-110931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 570E492F037
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 22:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6FCE1F22B8F
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 20:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A1319EEAB;
	Thu, 11 Jul 2024 20:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m72A20ZK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A1E14D449
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 20:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720729180; cv=none; b=Jalc1MKR4ESVUB1HcF0kOMe7MHoD2wptQHVqWNPnj7Aa9RYBB9aLG9bVUy6cGW1x8wWFuhFi0HU/V8idMI7pvWLouGy1FpwLi1iWZkSCTLbHX/hh5Y5M0xwxoLiBMYrCc/YL28d6PppG50nXGKXeKCCcxfTaodZhmcOF4ehmQ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720729180; c=relaxed/simple;
	bh=oacByTou+oBjv4DrDg57PJqSR1QLUx5ZAI1P1ShMV2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MYevN5xflkyYCw64vohfrA9z+lobdvAGSXZIRv0Bz9ssVvm7V57VMfzXkMZV7dLvORuDroXY6PsJ/iLpZicydfUT2kFGn/FojUz+xJ2LrBrSJXX0odHGOtuj7TPC4FvYgHfQTiboP8X4tiYslsDdc/LLnFcnIWUr/5eAbCNk5DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m72A20ZK; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720729179; x=1752265179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oacByTou+oBjv4DrDg57PJqSR1QLUx5ZAI1P1ShMV2E=;
  b=m72A20ZKxw9M2ffWA/7wWg7UcjiLEuQS9cPxjtYrVO8MwqRH24Hq8H0I
   mve9m7GngL/K5AbVyC/56bLPWtJC5BZktMmB04roB10J1m/z794Vzf//4
   1pf1pIYUMNxWQ7seVnqlgSTwaZB83Tx0Tf/MunAISy75lMv4fheUg/Dzd
   N+qDd10cUj6HAWi/bdUlsqjkIv/lawcXpv3svg9wbxMSVKHqgtrTEiynN
   IMCwSFMi6y6GC9yXJihiqPreLOpf2XZziIUyaDJbDG4eECBG0oSOwdayC
   gdJ8J7CQ8SeX4QuCsKcN/rJ54Yw0y+jhJRAHVLup7OpSGXDbEhqG2XRAq
   w==;
X-CSE-ConnectionGUID: 86L8NoqBTnyuFwhbIHSXNQ==
X-CSE-MsgGUID: 9ovrZQirQM+WmtsxgUfhqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="12508386"
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="12508386"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 13:19:37 -0700
X-CSE-ConnectionGUID: yd1158WYTESR4+pYoBNMhQ==
X-CSE-MsgGUID: wu+cGUNBQfa2um1bDgDEYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="71887401"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 11 Jul 2024 13:19:37 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 1/5] net: intel: Remove MODULE_AUTHORs
Date: Thu, 11 Jul 2024 13:19:26 -0700
Message-ID: <20240711201932.2019925-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240711201932.2019925-1-anthony.l.nguyen@intel.com>
References: <20240711201932.2019925-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are moving away from the Sourceforge email address. Rather than
removing or updating the email for the affected entries, remove the
MODULE_AUTHOR altogether as its usage is incorrect [1].

Link: https://lore.kernel.org/netdev/20200626115236.7f36d379@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com/ [1]
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Acked-by: Alexander Lobakin <aleksander.lobakin@intel.com> # libeth, libie
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e100.c                 | 1 -
 drivers/net/ethernet/intel/e1000/e1000_main.c     | 1 -
 drivers/net/ethernet/intel/e1000e/netdev.c        | 1 -
 drivers/net/ethernet/intel/fm10k/fm10k_main.c     | 1 -
 drivers/net/ethernet/intel/i40e/i40e_main.c       | 1 -
 drivers/net/ethernet/intel/iavf/iavf_main.c       | 1 -
 drivers/net/ethernet/intel/ice/ice_main.c         | 1 -
 drivers/net/ethernet/intel/igb/igb_main.c         | 1 -
 drivers/net/ethernet/intel/igbvf/netdev.c         | 1 -
 drivers/net/ethernet/intel/igc/igc_main.c         | 1 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     | 1 -
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 1 -
 drivers/net/ethernet/intel/libeth/rx.c            | 1 -
 drivers/net/ethernet/intel/libie/rx.c             | 1 -
 14 files changed, 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 9b068d40778d..aa139b67a55b 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -161,7 +161,6 @@
 #define FIRMWARE_D102E		"e100/d102e_ucode.bin"
 
 MODULE_DESCRIPTION(DRV_DESCRIPTION);
-MODULE_AUTHOR(DRV_COPYRIGHT);
 MODULE_LICENSE("GPL v2");
 MODULE_FIRMWARE(FIRMWARE_D101M);
 MODULE_FIRMWARE(FIRMWARE_D101S);
diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 60fff9a6c53e..ab7ae418d294 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -187,7 +187,6 @@ static struct pci_driver e1000_driver = {
 	.err_handler = &e1000_err_handler
 };
 
-MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
 MODULE_DESCRIPTION("Intel(R) PRO/1000 Network Driver");
 MODULE_LICENSE("GPL v2");
 
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 3cd161c6672b..360ee26557f7 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7969,7 +7969,6 @@ static void __exit e1000_exit_module(void)
 }
 module_exit(e1000_exit_module);
 
-MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
 MODULE_DESCRIPTION("Intel(R) PRO/1000 Network Driver");
 MODULE_LICENSE("GPL v2");
 
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index fc373472e4e1..142f07ca8bc0 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -17,7 +17,6 @@ static const char fm10k_driver_string[] = DRV_SUMMARY;
 static const char fm10k_copyright[] =
 	"Copyright(c) 2013 - 2019 Intel Corporation.";
 
-MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
 MODULE_DESCRIPTION(DRV_SUMMARY);
 MODULE_LICENSE("GPL v2");
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 284c3fad5a6e..8535fb5c4e46 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -98,7 +98,6 @@ static int debug = -1;
 module_param(debug, uint, 0);
 MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all), Debug mask (0x8XXXXXXX)");
 
-MODULE_AUTHOR("Intel Corporation, <e1000-devel@lists.sourceforge.net>");
 MODULE_DESCRIPTION("Intel(R) Ethernet Connection XL710 Network Driver");
 MODULE_IMPORT_NS(LIBIE);
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index c6dff0963053..ff11bafb3b4f 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -45,7 +45,6 @@ static const struct pci_device_id iavf_pci_tbl[] = {
 MODULE_DEVICE_TABLE(pci, iavf_pci_tbl);
 
 MODULE_ALIAS("i40evf");
-MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
 MODULE_DESCRIPTION("Intel(R) Ethernet Adaptive Virtual Function Network Driver");
 MODULE_IMPORT_NS(LIBETH);
 MODULE_IMPORT_NS(LIBIE);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 14ec4ebcd9af..bd3a60dd779f 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -35,7 +35,6 @@ static const char ice_copyright[] = "Copyright (c) 2018, Intel Corporation.";
 #define ICE_DDP_PKG_PATH	"intel/ice/ddp/"
 #define ICE_DDP_PKG_FILE	ICE_DDP_PKG_PATH "ice.pkg"
 
-MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
 MODULE_DESCRIPTION(DRV_SUMMARY);
 MODULE_IMPORT_NS(LIBIE);
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 3af03a211c3c..11be39f435f3 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -203,7 +203,6 @@ static const struct pci_error_handlers igb_err_handler = {
 
 static void igb_init_dmac(struct igb_adapter *adapter, u32 pba);
 
-MODULE_AUTHOR("Intel Corporation, <e1000-devel@lists.sourceforge.net>");
 MODULE_DESCRIPTION("Intel(R) Gigabit Ethernet Network Driver");
 MODULE_LICENSE("GPL v2");
 
diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index 7661edd7d0f2..925d7286a8ee 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -3001,7 +3001,6 @@ static void __exit igbvf_exit_module(void)
 }
 module_exit(igbvf_exit_module);
 
-MODULE_AUTHOR("Intel Corporation, <e1000-devel@lists.sourceforge.net>");
 MODULE_DESCRIPTION("Intel(R) Gigabit Virtual Function Network Driver");
 MODULE_LICENSE("GPL v2");
 
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 87b655b839c1..7a7cbed237d3 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -32,7 +32,6 @@
 
 static int debug = -1;
 
-MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
 MODULE_DESCRIPTION(DRV_SUMMARY);
 MODULE_LICENSE("GPL v2");
 module_param(debug, int, 0);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 094653e81b97..8057cef61f39 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -162,7 +162,6 @@ static int debug = -1;
 module_param(debug, int, 0);
 MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
 
-MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
 MODULE_DESCRIPTION("Intel(R) 10 Gigabit PCI Express Network Driver");
 MODULE_LICENSE("GPL v2");
 
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index b938dc06045d..149911e3002a 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -76,7 +76,6 @@ static const struct pci_device_id ixgbevf_pci_tbl[] = {
 };
 MODULE_DEVICE_TABLE(pci, ixgbevf_pci_tbl);
 
-MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
 MODULE_DESCRIPTION("Intel(R) 10 Gigabit Virtual Function Network Driver");
 MODULE_LICENSE("GPL v2");
 
diff --git a/drivers/net/ethernet/intel/libeth/rx.c b/drivers/net/ethernet/intel/libeth/rx.c
index 6221b88c34ac..bd135d6dccca 100644
--- a/drivers/net/ethernet/intel/libeth/rx.c
+++ b/drivers/net/ethernet/intel/libeth/rx.c
@@ -145,6 +145,5 @@ EXPORT_SYMBOL_NS_GPL(libeth_rx_pt_gen_hash_type, LIBETH);
 
 /* Module */
 
-MODULE_AUTHOR("Intel Corporation");
 MODULE_DESCRIPTION("Common Ethernet library");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/intel/libie/rx.c b/drivers/net/ethernet/intel/libie/rx.c
index 38201ee1e891..aceb8d8813c4 100644
--- a/drivers/net/ethernet/intel/libie/rx.c
+++ b/drivers/net/ethernet/intel/libie/rx.c
@@ -118,7 +118,6 @@ const struct libeth_rx_pt libie_rx_pt_lut[LIBIE_RX_PT_NUM] = {
 };
 EXPORT_SYMBOL_NS_GPL(libie_rx_pt_lut, LIBIE);
 
-MODULE_AUTHOR("Intel Corporation");
 MODULE_DESCRIPTION("Intel(R) Ethernet common library");
 MODULE_IMPORT_NS(LIBETH);
 MODULE_LICENSE("GPL");
-- 
2.41.0


