Return-Path: <netdev+bounces-34110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AD07A2214
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 17:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25F331C20EB5
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 15:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEC1111B5;
	Fri, 15 Sep 2023 15:12:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09250111AE
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 15:12:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A8DE6A
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 08:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694790756; x=1726326756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EAI32p84QZ7fMvHToGeKlZGL967yY9vhMQGUU1IzvBw=;
  b=VZIGwUlNe3//GHs+d4kUvsvwJk1CG2dRXNf/WUDDcwXQDY/H5RSXBH9v
   3ejdqvBuRfujRHoGyuVIfx7UAhf70Lpo39/geLGu2mcwqt8acih4yzcpj
   lSc9Zp6s4PtbiRvIX3jNancT9kDac1ucDLw/nbumAFEpqovCMlUwMKzZ3
   kBab8pCIoS6CX8L8TevY+w3K9ULVXVdXuLysQmLRbngDKzGxhXrGr6Dr7
   evVkDZU6RaHO960/RWoz8CdurtRLYlDPRJP6VNasQIT4iUmO0qIyyUMJh
   PZFkN4ton7pHS2BNAjFXO1IBVpzJbJ5QJBGNxlnPrfqZrXf1l+SQMl+vR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="410209426"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="410209426"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 08:12:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="868741787"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="868741787"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga004.jf.intel.com with ESMTP; 15 Sep 2023 08:12:34 -0700
Received: from baltimore.igk.intel.com (baltimore.igk.intel.com [10.102.21.1])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id ED27033BF8;
	Fri, 15 Sep 2023 16:12:32 +0100 (IST)
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	andrew@lunn.ch,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH iwl-next v4 5/6] ice: Remove redundant zeroing of the fields.
Date: Fri, 15 Sep 2023 17:09:57 +0200
Message-Id: <20230915150958.592564-6-pawel.chmielewski@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230915150958.592564-1-pawel.chmielewski@intel.com>
References: <20230915150958.592564-1-pawel.chmielewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75 autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Remove zeroing of the fields, as all the fields are in fact initialized
with zeros automatically

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 54 +++++++++++------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d13b6e3de920..9562ba928aae 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5561,34 +5561,34 @@ static void ice_pci_err_reset_done(struct pci_dev *pdev)
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
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E810C_BACKPLANE) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E810C_QSFP) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E810C_SFP) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E810_XXV_BACKPLANE) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E810_XXV_QSFP) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E810_XXV_SFP) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823C_BACKPLANE) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823C_QSFP) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823C_SFP) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823C_10G_BASE_T) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823C_SGMII) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822C_BACKPLANE) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822C_QSFP) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822C_SFP) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822C_10G_BASE_T) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822C_SGMII) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822L_BACKPLANE) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822L_SFP) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822L_10G_BASE_T) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822L_SGMII) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_BACKPLANE) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_SFP) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_10G_BASE_T) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_1GBE) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_QSFP) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822_SI_DFLT) },
 	/* required last entry */
-	{ 0, }
+	{}
 };
 MODULE_DEVICE_TABLE(pci, ice_pci_tbl);
 
-- 
2.37.3


