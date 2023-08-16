Return-Path: <netdev+bounces-28286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F355877EE17
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 02:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F22D1C21281
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 00:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CD5802;
	Thu, 17 Aug 2023 00:05:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA5810FF
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 00:05:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7EA273A
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 17:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692230720; x=1723766720;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uOaHuO89FuzTgLUzEh2x9VhUr5CRa8Z2PtrAaVnjwCI=;
  b=bdoIB1dEJVA8swCa8seewS19hrFYfp8tKcxxSwk+/eVsLwIWJfqG5J6W
   yAVex0siMGstsz9EHMM+suQpuiihiaJjVZOZKtT8no6rQRfAP6hoTbjR2
   wBxBgWPB7pq78oku/PiPKugAwBh7rp5RzpzVpDBFFJZ+EZgwfTGEUnFfr
   XmuH7IYF+ZIcKMyVJYTHHnVkqqCtltQgC1OPZkEeV1l32qNFCt9f74vw2
   uZudCMivFQKuoeXBT0O81RHiMx5vV8ZzhaNCAKBB4/HzduVSlAxvUDutn
   HFsR6V+l/IBtZMPLB18uuvoyLcsNVrfkGWrGgMiYn5bKDTa5sWvlN0Z3/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="371570661"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="371570661"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 17:04:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="824422147"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="824422147"
Received: from unknown (HELO localhost.jf.intel.com) ([10.166.244.168])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Aug 2023 17:04:54 -0700
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH iwl-next 6/7] ice: Remove redundant zeroing of the fields.
Date: Wed, 16 Aug 2023 16:57:18 -0700
Message-Id: <20230816235719.1120726-7-paul.greenwalt@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816235719.1120726-1-paul.greenwalt@intel.com>
References: <20230816235719.1120726-1-paul.greenwalt@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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


