Return-Path: <netdev+bounces-29077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E9B78190A
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 12:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4691B1C20A46
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 10:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E4419BA0;
	Sat, 19 Aug 2023 10:40:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C9C18C19
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 10:40:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BE232430
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 02:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692438605; x=1723974605;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uOaHuO89FuzTgLUzEh2x9VhUr5CRa8Z2PtrAaVnjwCI=;
  b=cHsfGPI2nALji6u7a2tY5nl46jnl5Tou5AwIC0s+fuDSzB3Tg5rma9cv
   WG88NhxQzqf64NFS3/2vIMGzRHSxyd1F4j2G78r3vxewrtfJboOtFrS/H
   UJOoGWfj/B3h3uRnlzW9e2fWeACUveOzA8wdYKo6FLfthtaloY+MfPU7l
   OV3LH6WNd/PjjscTxnYT6X2pqg/jXNmUhI+OeE7wDf5vIfSANwztJBcji
   eW2Lk6httMRQGqumX08d8Sb+ONu/5DDmM7bSXcttwvNvh7UHQIBt7P7B/
   A7bTxZvAQRTS1vnOL/Q/n1XtEW1tZjE1hGctoZnxPE1ccMn8OXVVqhwr0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="459641284"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="459641284"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2023 02:50:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="764830743"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="764830743"
Received: from unknown (HELO localhost.jf.intel.com) ([10.166.244.168])
  by orsmga008.jf.intel.com with ESMTP; 19 Aug 2023 02:50:04 -0700
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	pawel.chmielewski@intel.com,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH iwl-next v2 8/9] ice: Remove redundant zeroing of the fields.
Date: Sat, 19 Aug 2023 02:42:39 -0700
Message-Id: <20230819094239.15304-1-paul.greenwalt@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Pawel Chmielewski <pawel.chmielewski@intel.com>

Remove zeroing of the fields, as all the fields are in fact initialized
with zeros automatically

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 52 +++++++++++------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index ffed5543a5aa..d6715a89ec78 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5605,32 +5605,32 @@ static void ice_pci_err_reset_done(struct pci_dev *pdev)
  *   Class, Class Mask, private data (not used) }
  */
 static const struct pci_device_id ice_pci_tbl[] = {
-	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E810C_BACKPLANE), 0 },
-	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E810C_QSFP), 0 },
-	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E810C_SFP), 0 },
-	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E810_XXV_BACKPLANE), 0 },
-	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E810_XXV_QSFP), 0 },
-	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E810_XXV_SFP), 0 },
-	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823C_BACKPLANE), 0 },
-	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823C_QSFP), 0 },
-	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823C_SFP), 0 },
-	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823C_10G_BASE_T), 0 },
-	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823C_SGMII), 0 },
-	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822C_BACKPLANE), 0 },
-	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822C_QSFP), 0 },
-	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822C_SFP), 0 },
-	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822C_10G_BASE_T), 0 },
-	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822C_SGMII), 0 },
-	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822L_BACKPLANE), 0 },
-	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822L_SFP), 0 },
-	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822L_10G_BASE_T), 0 },
-	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822L_SGMII), 0 },
-	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_BACKPLANE), 0 },
-	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_SFP), 0 },
-	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_10G_BASE_T), 0 },
-	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_1GBE), 0 },
-	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_QSFP), 0 },
-	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822_SI_DFLT), 0 },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E810C_BACKPLANE)},
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E810C_QSFP)},
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E810C_SFP)},
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E810_XXV_BACKPLANE)},
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E810_XXV_QSFP)},
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E810_XXV_SFP)},
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823C_BACKPLANE)},
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823C_QSFP)},
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823C_SFP)},
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823C_10G_BASE_T)},
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823C_SGMII)},
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822C_BACKPLANE)},
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822C_QSFP)},
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822C_SFP)},
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822C_10G_BASE_T)},
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822C_SGMII)},
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822L_BACKPLANE)},
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822L_SFP)},
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822L_10G_BASE_T)},
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822L_SGMII)},
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_BACKPLANE)},
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_SFP)},
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_10G_BASE_T)},
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_1GBE)},
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_QSFP)},
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822_SI_DFLT)},
 	/* required last entry */
 	{ 0, }
 };
-- 
2.39.2


