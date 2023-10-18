Return-Path: <netdev+bounces-42197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4EF7CDA1C
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 13:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD19D1C20D1C
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 11:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F006D1A5BE;
	Wed, 18 Oct 2023 11:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q2CQ7hvC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1181A72A
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 11:15:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5E2111
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 04:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697627749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X1YOPkd3TUNEKN4157MWeimHZGg2FyGct8o7FTgxwG0=;
	b=Q2CQ7hvCQqSMknZa3Nmprc2ZApYB36U78J7lyLwPOnJaNnzkXsHNksaRigQbViP7WpxD/K
	Kt4iqAFBDGkrZJu89UGDmAUUnKMct/wgoCjCjn2hf4gjfRIAbiJ8dJt6wiv1wYdbJBkPZd
	QDC0f5PcrAt3FcuzOWo0p6uwiHK3i04=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-hz-euYIENpCDFKgA_d8VgQ-1; Wed, 18 Oct 2023 07:15:43 -0400
X-MC-Unique: hz-euYIENpCDFKgA_d8VgQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E4A61E441CF;
	Wed, 18 Oct 2023 11:15:42 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.224.209])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7460F2026D4C;
	Wed, 18 Oct 2023 11:15:40 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] iavf: delete unused iavf_mac_info fields
Date: Wed, 18 Oct 2023 13:15:27 +0200
Message-ID: <20231018111527.78194-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

'san_addr' and 'mac_fcoeq' members of struct iavf_mac_info are unused.
'type' is write-only. Delete all three.

The function iavf_set_mac_type that sets 'type' also checks if the PCI
vendor ID is Intel. This is unnecessary. Delete the whole function.

If in the future there's a need for the MAC type (or other PCI
ID-dependent data), I would prefer to use .driver_data in iavf_pci_tbl[]
for this purpose.

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/net/ethernet/intel/iavf/iavf_common.c | 32 -------------------
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  5 ---
 .../net/ethernet/intel/iavf/iavf_prototype.h  |  2 --
 drivers/net/ethernet/intel/iavf/iavf_type.h   | 12 -------
 4 files changed, 51 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_common.c b/drivers/net/ethernet/intel/iavf/iavf_common.c
index 1afd761d8052..8091e6feca01 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_common.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_common.c
@@ -6,38 +6,6 @@
 #include "iavf_prototype.h"
 #include <linux/avf/virtchnl.h>
 
-/**
- * iavf_set_mac_type - Sets MAC type
- * @hw: pointer to the HW structure
- *
- * This function sets the mac type of the adapter based on the
- * vendor ID and device ID stored in the hw structure.
- **/
-enum iavf_status iavf_set_mac_type(struct iavf_hw *hw)
-{
-	enum iavf_status status = 0;
-
-	if (hw->vendor_id == PCI_VENDOR_ID_INTEL) {
-		switch (hw->device_id) {
-		case IAVF_DEV_ID_X722_VF:
-			hw->mac.type = IAVF_MAC_X722_VF;
-			break;
-		case IAVF_DEV_ID_VF:
-		case IAVF_DEV_ID_VF_HV:
-		case IAVF_DEV_ID_ADAPTIVE_VF:
-			hw->mac.type = IAVF_MAC_VF;
-			break;
-		default:
-			hw->mac.type = IAVF_MAC_GENERIC;
-			break;
-		}
-	} else {
-		status = IAVF_ERR_DEVICE_NOT_SUPPORTED;
-	}
-
-	return status;
-}
-
 /**
  * iavf_aq_str - convert AQ err code to a string
  * @hw: pointer to the HW structure
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 768bec67825a..c862ebcd2e39 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2363,11 +2363,6 @@ static void iavf_startup(struct iavf_adapter *adapter)
 	/* driver loaded, probe complete */
 	adapter->flags &= ~IAVF_FLAG_PF_COMMS_FAILED;
 	adapter->flags &= ~IAVF_FLAG_RESET_PENDING;
-	status = iavf_set_mac_type(hw);
-	if (status) {
-		dev_err(&pdev->dev, "Failed to set MAC type (%d)\n", status);
-		goto err;
-	}
 
 	ret = iavf_check_reset_complete(hw);
 	if (ret) {
diff --git a/drivers/net/ethernet/intel/iavf/iavf_prototype.h b/drivers/net/ethernet/intel/iavf/iavf_prototype.h
index 940cb4203fbe..4a48e6171405 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_prototype.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_prototype.h
@@ -45,8 +45,6 @@ enum iavf_status iavf_aq_set_rss_lut(struct iavf_hw *hw, u16 seid,
 enum iavf_status iavf_aq_set_rss_key(struct iavf_hw *hw, u16 seid,
 				     struct iavf_aqc_get_set_rss_key_data *key);
 
-enum iavf_status iavf_set_mac_type(struct iavf_hw *hw);
-
 extern struct iavf_rx_ptype_decoded iavf_ptype_lookup[];
 
 static inline struct iavf_rx_ptype_decoded decode_rx_desc_ptype(u8 ptype)
diff --git a/drivers/net/ethernet/intel/iavf/iavf_type.h b/drivers/net/ethernet/intel/iavf/iavf_type.h
index 9f1f523807c4..2b6a207fa441 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_type.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_type.h
@@ -69,15 +69,6 @@ enum iavf_debug_mask {
  * the Firmware and AdminQ are intended to insulate the driver from most of the
  * future changes, but these structures will also do part of the job.
  */
-enum iavf_mac_type {
-	IAVF_MAC_UNKNOWN = 0,
-	IAVF_MAC_XL710,
-	IAVF_MAC_VF,
-	IAVF_MAC_X722,
-	IAVF_MAC_X722_VF,
-	IAVF_MAC_GENERIC,
-};
-
 enum iavf_vsi_type {
 	IAVF_VSI_MAIN	= 0,
 	IAVF_VSI_VMDQ1	= 1,
@@ -110,11 +101,8 @@ struct iavf_hw_capabilities {
 };
 
 struct iavf_mac_info {
-	enum iavf_mac_type type;
 	u8 addr[ETH_ALEN];
 	u8 perm_addr[ETH_ALEN];
-	u8 san_addr[ETH_ALEN];
-	u16 max_fcoeq;
 };
 
 /* PCI bus types */
-- 
2.41.0


