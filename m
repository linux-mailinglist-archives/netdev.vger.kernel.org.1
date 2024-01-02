Return-Path: <netdev+bounces-61034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12028822485
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 23:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95151B22B2B
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 22:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445A71775E;
	Tue,  2 Jan 2024 22:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MGGyRPmj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71F61773D
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 22:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704233081; x=1735769081;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U4o+rpuVnFcKoriqbSPMyneBHQF3iABQqP5Kt0R4OM0=;
  b=MGGyRPmjd4a8ffplo2fo4dx6pFH4A64eHhVMZIxVntqEGdlm9BSxL8E8
   /XEIIMaVsFQFu5vJ6kr2qXs1G5YhwvmNInxZphzOU22v7Yf/wG3+oIdQV
   ko4AQLaM4ZV54Ssf1ZuEACB+deqrScGxKs1g86y8GQVyEGfj6H7fF3TJ5
   kGNLcMJUi+SKzt+fUby0LZYurNBWyQFeeewJByZxV6GcPjR/I7d/qrH/F
   yYsjCsknO4CgX9Z5Uhg9LZ7euyU3AByPSI6qZp4wxixmFcDa2NYGfh4YT
   /gsRZRaaqzVxUqlltwx9DxUV94xQu8AYa9aA43q/WPt1K0IEZFe9AfXaB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="15567904"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="15567904"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 14:04:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="808621417"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="808621417"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga008.jf.intel.com with ESMTP; 02 Jan 2024 14:04:36 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jan Glaza <jan.glaza@intel.com>,
	anthony.l.nguyen@intel.com,
	Andrii Staikov <andrii.staikov@intel.com>,
	Sachin Bahadur <sachin.bahadur@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 6/7] ice: ice_base.c: Add const modifier to params and vars
Date: Tue,  2 Jan 2024 14:04:22 -0800
Message-ID: <20240102220428.698969-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240102220428.698969-1-anthony.l.nguyen@intel.com>
References: <20240102220428.698969-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Glaza <jan.glaza@intel.com>

Add const modifier to function parameters and variables where appropriate
in ice_base.c and corresponding declarations in ice_base.h.

The reason for starting the change is that read-only pointers should be
marked as const when possible to allow for smoother and more optimal code
generation and optimization as well as allowing the compiler to warn the
developer about potentially unwanted modifications, while not carrying
noticeable negative impact.

Reviewed-by: Andrii Staikov <andrii.staikov@intel.com>
Reviewed-by: Sachin Bahadur <sachin.bahadur@intel.com>
Signed-off-by: Jan Glaza <jan.glaza@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
This change is done in one file to get comment feedback and, if positive,
will be rolled out across the entire ice driver code.

 drivers/net/ethernet/intel/ice/ice_base.c | 6 +++---
 drivers/net/ethernet/intel/ice/ice_base.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 6e3694145f59..533b923cae2d 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -278,7 +278,7 @@ static u16 ice_calc_txq_handle(struct ice_vsi *vsi, struct ice_tx_ring *ring, u8
  */
 static u16 ice_eswitch_calc_txq_handle(struct ice_tx_ring *ring)
 {
-	struct ice_vsi *vsi = ring->vsi;
+	const struct ice_vsi *vsi = ring->vsi;
 	int i;
 
 	ice_for_each_txq(vsi, i) {
@@ -975,7 +975,7 @@ ice_cfg_rxq_interrupt(struct ice_vsi *vsi, u16 rxq, u16 msix_idx, u16 itr_idx)
  * @hw: pointer to the HW structure
  * @q_vector: interrupt vector to trigger the software interrupt for
  */
-void ice_trigger_sw_intr(struct ice_hw *hw, struct ice_q_vector *q_vector)
+void ice_trigger_sw_intr(struct ice_hw *hw, const struct ice_q_vector *q_vector)
 {
 	wr32(hw, GLINT_DYN_CTL(q_vector->reg_idx),
 	     (ICE_ITR_NONE << GLINT_DYN_CTL_ITR_INDX_S) |
@@ -1050,7 +1050,7 @@ ice_vsi_stop_tx_ring(struct ice_vsi *vsi, enum ice_disq_rst_src rst_src,
  * are needed for stopping Tx queue
  */
 void
-ice_fill_txq_meta(struct ice_vsi *vsi, struct ice_tx_ring *ring,
+ice_fill_txq_meta(const struct ice_vsi *vsi, struct ice_tx_ring *ring,
 		  struct ice_txq_meta *txq_meta)
 {
 	struct ice_channel *ch = ring->ch;
diff --git a/drivers/net/ethernet/intel/ice/ice_base.h b/drivers/net/ethernet/intel/ice/ice_base.h
index b67dca417acb..17321ba75602 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.h
+++ b/drivers/net/ethernet/intel/ice/ice_base.h
@@ -22,12 +22,12 @@ void
 ice_cfg_txq_interrupt(struct ice_vsi *vsi, u16 txq, u16 msix_idx, u16 itr_idx);
 void
 ice_cfg_rxq_interrupt(struct ice_vsi *vsi, u16 rxq, u16 msix_idx, u16 itr_idx);
-void ice_trigger_sw_intr(struct ice_hw *hw, struct ice_q_vector *q_vector);
+void ice_trigger_sw_intr(struct ice_hw *hw, const struct ice_q_vector *q_vector);
 int
 ice_vsi_stop_tx_ring(struct ice_vsi *vsi, enum ice_disq_rst_src rst_src,
 		     u16 rel_vmvf_num, struct ice_tx_ring *ring,
 		     struct ice_txq_meta *txq_meta);
 void
-ice_fill_txq_meta(struct ice_vsi *vsi, struct ice_tx_ring *ring,
+ice_fill_txq_meta(const struct ice_vsi *vsi, struct ice_tx_ring *ring,
 		  struct ice_txq_meta *txq_meta);
 #endif /* _ICE_BASE_H_ */
-- 
2.41.0


