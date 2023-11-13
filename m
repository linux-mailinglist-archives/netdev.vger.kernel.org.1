Return-Path: <netdev+bounces-47507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 219A67EA6BB
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0BF5280FCC
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A5B3D3A0;
	Mon, 13 Nov 2023 23:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VcG/TWpn"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1322F3C6BB
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 23:10:58 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6220C1B5
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 15:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699917057; x=1731453057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c8nTqBeV2s52FjBdNAITESqteU9mEpOJJIljjWae/1g=;
  b=VcG/TWpnIadHPbYK2l7ub8h5M0zc4QQHDKRdcHd/lLbTxN76M1Fu1hNh
   htYKxG7FXMROS7vxov5+/jasW2clVk/prHqXncISALrjbF5VxM4lagRoe
   27E7F4gcxW2DtX11L6PurA1Kp61YIrwn13x4gYN01QuzZr1+JSGf6P6ez
   NQZdm7aW9qzfS6yF6NLu2tNFjezsSVqNF8rC2ClBIfIrlt3gNf/Tpscfd
   V99/DX40/d5GM9N5kdIFpmO88A73o6CBPkebt31eLTh6yKs8y6RJynIpM
   4RZiGwaSpEMBBF9FaBKlmx+OvUAB2m7J98b+ccSRK6CRQlFZ4IWJaxrwg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="375562619"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="375562619"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 15:10:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="888051406"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="888051406"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga004.jf.intel.com with ESMTP; 13 Nov 2023 15:10:52 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>,
	anthony.l.nguyen@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 05/15] i40e: Remove _t suffix from enum type names
Date: Mon, 13 Nov 2023 15:10:24 -0800
Message-ID: <20231113231047.548659-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113231047.548659-1-anthony.l.nguyen@intel.com>
References: <20231113231047.548659-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ivan Vecera <ivecera@redhat.com>

Enum type names should not be suffixed by '_t'. Either to use
'typedef enum name name_t' to so plain 'name_t var' instead of
'enum name_t var'.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h      | 4 ++--
 drivers/net/ethernet/intel/i40e/i40e_ptp.c  | 6 +++---
 drivers/net/ethernet/intel/i40e/i40e_txrx.h | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 7d83dcbd9294..f47c2e6bf786 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -79,7 +79,7 @@
 #define I40E_MAX_BW_INACTIVE_ACCUM	4 /* accumulate 4 credits max */
 
 /* driver state flags */
-enum i40e_state_t {
+enum i40e_state {
 	__I40E_TESTING,
 	__I40E_CONFIG_BUSY,
 	__I40E_CONFIG_DONE,
@@ -127,7 +127,7 @@ enum i40e_state_t {
 	BIT_ULL(__I40E_PF_RESET_AND_REBUILD_REQUESTED)
 
 /* VSI state flags */
-enum i40e_vsi_state_t {
+enum i40e_vsi_state {
 	__I40E_VSI_DOWN,
 	__I40E_VSI_NEEDS_RESTART,
 	__I40E_VSI_SYNCING_FILTERS,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 20b77398f060..65c714d0bfff 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -35,7 +35,7 @@ enum i40e_ptp_pin {
 	GPIO_4
 };
 
-enum i40e_can_set_pins_t {
+enum i40e_can_set_pins {
 	CANT_DO_PINS = -1,
 	CAN_SET_PINS,
 	CAN_DO_PINS
@@ -193,7 +193,7 @@ static bool i40e_is_ptp_pin_dev(struct i40e_hw *hw)
  * return CAN_DO_PINS if pins can be manipulated within a NIC or
  * return CANT_DO_PINS otherwise.
  **/
-static enum i40e_can_set_pins_t i40e_can_set_pins(struct i40e_pf *pf)
+static enum i40e_can_set_pins i40e_can_set_pins(struct i40e_pf *pf)
 {
 	if (!i40e_is_ptp_pin_dev(&pf->hw)) {
 		dev_warn(&pf->pdev->dev,
@@ -1071,7 +1071,7 @@ static void i40e_ptp_set_pins_hw(struct i40e_pf *pf)
 static int i40e_ptp_set_pins(struct i40e_pf *pf,
 			     struct i40e_ptp_pins_settings *pins)
 {
-	enum i40e_can_set_pins_t pin_caps = i40e_can_set_pins(pf);
+	enum i40e_can_set_pins pin_caps = i40e_can_set_pins(pf);
 	int i = 0;
 
 	if (pin_caps == CANT_DO_PINS)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index 421fe5675584..1c667408f687 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -58,7 +58,7 @@ static inline u16 i40e_intrl_usec_to_reg(int intrl)
  * mentioning ITR_INDX, ITR_NONE cannot be used as an index 'n' into any
  * register but instead is a special value meaning "don't update" ITR0/1/2.
  */
-enum i40e_dyn_idx_t {
+enum i40e_dyn_idx {
 	I40E_IDX_ITR0 = 0,
 	I40E_IDX_ITR1 = 1,
 	I40E_IDX_ITR2 = 2,
@@ -306,7 +306,7 @@ struct i40e_rx_queue_stats {
 	u64 page_busy_count;
 };
 
-enum i40e_ring_state_t {
+enum i40e_ring_state {
 	__I40E_TX_FDIR_INIT_DONE,
 	__I40E_TX_XPS_INIT_DONE,
 	__I40E_RING_STATE_NBITS /* must be last */
-- 
2.41.0


