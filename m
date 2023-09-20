Return-Path: <netdev+bounces-35287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A537A8A72
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 19:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F206E1C20CFE
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 17:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4031A5B2;
	Wed, 20 Sep 2023 17:20:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAEE1A5A6
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 17:20:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36862A9
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 10:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695230405; x=1726766405;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zv8NjEzUuIHuS9diKOZaJeFVC3nl7j7albHFJr1lTIg=;
  b=A+BTh+2EVBGb84M/btiS2+oNZTVhCZc4DZX8pIhD/uTxBEBD/aC4QXUI
   +uH1f45dJfTKI6zvfEar3Tc6wV6bwfuGbiP1lcr/kIX80hjUaN6R3gDSm
   BN8gURd+TeYn+cbEXDDUfbmfbSNLa+IGzSvWoysoS1/xTMxqw2tDxnJ1a
   pXB5Cmajh2eFCWoVOlIJIlpgpkQuqxdKeA/8x6xi3PAnOpTcAm4NvqhIt
   LyMNwIwu5QLPUZ6GtI+L3pYJriw44Q44T4nvHE0SseYGY3I5iJQTfYuFW
   Wli+0AkfdRo+dffETUhtDMnn/4/j8M7L/h+xl8EW+qk2ODQuWq7syfDZ7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="411234483"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="411234483"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 10:20:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="1077543770"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="1077543770"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga005.fm.intel.com with ESMTP; 20 Sep 2023 10:20:02 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Michalik <michal.michalik@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	richardcochran@gmail.com,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 4/4] ice: Remove the FW shared parameters
Date: Wed, 20 Sep 2023 10:19:29 -0700
Message-Id: <20230920171929.2198273-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230920171929.2198273-1-anthony.l.nguyen@intel.com>
References: <20230920171929.2198273-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Michal Michalik <michal.michalik@intel.com>

The only feature using the Firmware (FW) shared parameters was the PTP
clock ID. Since this ID is now shared using auxiliary buss - remove the
FW shared parameters from the code.

Signed-off-by: Michal Michalik <michal.michalik@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  5 --
 drivers/net/ethernet/intel/ice/ice_common.c   | 75 -------------------
 drivers/net/ethernet/intel/ice/ice_common.h   |  6 --
 3 files changed, 86 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 6e49a6198f02..51281b58ad72 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -2358,11 +2358,6 @@ struct ice_aqc_driver_shared_params {
 	__le32 addr_low;
 };
 
-enum ice_aqc_driver_params {
-	/* Add new parameters above */
-	ICE_AQC_DRIVER_PARAM_MAX = 16,
-};
-
 /* Lan Queue Overflow Event (direct, 0x1001) */
 struct ice_aqc_event_lan_overflow {
 	__le32 prtdcb_ruptq;
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 8f31ae449948..5ed266fdc01b 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -5720,81 +5720,6 @@ ice_aq_write_i2c(struct ice_hw *hw, struct ice_aqc_link_topo_addr topo_addr,
 	return ice_aq_send_cmd(hw, &desc, NULL, 0, cd);
 }
 
-/**
- * ice_aq_set_driver_param - Set driver parameter to share via firmware
- * @hw: pointer to the HW struct
- * @idx: parameter index to set
- * @value: the value to set the parameter to
- * @cd: pointer to command details structure or NULL
- *
- * Set the value of one of the software defined parameters. All PFs connected
- * to this device can read the value using ice_aq_get_driver_param.
- *
- * Note that firmware provides no synchronization or locking, and will not
- * save the parameter value during a device reset. It is expected that
- * a single PF will write the parameter value, while all other PFs will only
- * read it.
- */
-int
-ice_aq_set_driver_param(struct ice_hw *hw, enum ice_aqc_driver_params idx,
-			u32 value, struct ice_sq_cd *cd)
-{
-	struct ice_aqc_driver_shared_params *cmd;
-	struct ice_aq_desc desc;
-
-	if (idx >= ICE_AQC_DRIVER_PARAM_MAX)
-		return -EIO;
-
-	cmd = &desc.params.drv_shared_params;
-
-	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_driver_shared_params);
-
-	cmd->set_or_get_op = ICE_AQC_DRIVER_PARAM_SET;
-	cmd->param_indx = idx;
-	cmd->param_val = cpu_to_le32(value);
-
-	return ice_aq_send_cmd(hw, &desc, NULL, 0, cd);
-}
-
-/**
- * ice_aq_get_driver_param - Get driver parameter shared via firmware
- * @hw: pointer to the HW struct
- * @idx: parameter index to set
- * @value: storage to return the shared parameter
- * @cd: pointer to command details structure or NULL
- *
- * Get the value of one of the software defined parameters.
- *
- * Note that firmware provides no synchronization or locking. It is expected
- * that only a single PF will write a given parameter.
- */
-int
-ice_aq_get_driver_param(struct ice_hw *hw, enum ice_aqc_driver_params idx,
-			u32 *value, struct ice_sq_cd *cd)
-{
-	struct ice_aqc_driver_shared_params *cmd;
-	struct ice_aq_desc desc;
-	int status;
-
-	if (idx >= ICE_AQC_DRIVER_PARAM_MAX)
-		return -EIO;
-
-	cmd = &desc.params.drv_shared_params;
-
-	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_driver_shared_params);
-
-	cmd->set_or_get_op = ICE_AQC_DRIVER_PARAM_GET;
-	cmd->param_indx = idx;
-
-	status = ice_aq_send_cmd(hw, &desc, NULL, 0, cd);
-	if (status)
-		return status;
-
-	*value = le32_to_cpu(cmd->param_val);
-
-	return 0;
-}
-
 /**
  * ice_aq_set_gpio
  * @hw: pointer to the hw struct
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 47a75651ca38..822f5a875942 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -253,12 +253,6 @@ int
 ice_sched_query_elem(struct ice_hw *hw, u32 node_teid,
 		     struct ice_aqc_txsched_elem_data *buf);
 int
-ice_aq_set_driver_param(struct ice_hw *hw, enum ice_aqc_driver_params idx,
-			u32 value, struct ice_sq_cd *cd);
-int
-ice_aq_get_driver_param(struct ice_hw *hw, enum ice_aqc_driver_params idx,
-			u32 *value, struct ice_sq_cd *cd);
-int
 ice_aq_set_gpio(struct ice_hw *hw, u16 gpio_ctrl_handle, u8 pin_idx, bool value,
 		struct ice_sq_cd *cd);
 int
-- 
2.38.1


