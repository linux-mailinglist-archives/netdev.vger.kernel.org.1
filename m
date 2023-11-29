Return-Path: <netdev+bounces-52034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7557FD095
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 09:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87E4DB20F16
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 08:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA5E11C86;
	Wed, 29 Nov 2023 08:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JuKQIaOM"
X-Original-To: netdev@vger.kernel.org
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Nov 2023 00:21:31 PST
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD3F1735
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 00:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701246091; x=1732782091;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JB7QfYr2IVIshrpOKCBYxoSTbkG8kwKxU6DQNDmaM/0=;
  b=JuKQIaOMx0sQ42s3QEpAyHODN/wG2Pgd5WSy08P/VEzoAsBfCHV7yPMO
   kYSlgoCpQr9sGdXLGD9czZbutYvX0Rxsx98zkzWCCs2NIA1rnsEZeLj+o
   5tRoV8F8WiKIBNb/55WyBo1bZA8LHf0+PuxsGFA6NQVANoocmBZUg36Wl
   dHdHXoVrPNatN9h6WD8sNjpVysy58FzLnksOSmcIaCRvvDIHmU4Dd0uyp
   q9DBIsaC6fAlCA+g7Hk8C40jcye3wxT1cNxYB6E8hMUT2XQcdrRiF7NWa
   EXtjo9Z8lRHDnk/vUbSLDs3omT5WmDKhqM+8V57OvqhsxsiJqA/dz0qSi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="98873"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="98873"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 00:20:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="1100415108"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="1100415108"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga005.fm.intel.com with ESMTP; 29 Nov 2023 00:20:25 -0800
Received: from localhost.localdomain (unknown [10.123.220.123])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 2B4A436830;
	Wed, 29 Nov 2023 08:20:24 +0000 (GMT)
From: Jan Glaza <jan.glaza@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jan Glaza <jan.glaza@intel.com>,
	Andrii Staikov <andrii.staikov@intel.com>,
	Sachin Bahadur <sachin.bahadur@intel.com>
Subject: [PATCH iwl-next] ice: ice_base.c: Add const modifier to params and vars
Date: Wed, 29 Nov 2023 02:36:11 -0500
Message-Id: <20231129073611.8816-1-jan.glaza@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add const modifier to function parameters and variables where appropriate
in ice_base.c and corresponding declarations in ice_base.h.

The reason for starting the change is that read-only pointers should be
marked as const when possible to allow for smoother and more optimal code
generation and optimization as well as allowing the compiler to warn the
developer about potentially unwanted modifications, while not carrying
noticable negative impact.

Reviewed-by: Andrii Staikov <andrii.staikov@intel.com>
Reviewed-by: Sachin Bahadur <sachin.bahadur@intel.com>
Signed-off-by: Jan Glaza <jan.glaza@intel.com>
---
This change is done in one file to get comment feedback and, if positive,
will be rolled out across the entire ice driver code.
---
 drivers/net/ethernet/intel/ice/ice_base.c | 6 +++---
 drivers/net/ethernet/intel/ice/ice_base.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 7fa43827a3f0..5ca323ac36ce 100644
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
@@ -960,7 +960,7 @@ ice_cfg_rxq_interrupt(struct ice_vsi *vsi, u16 rxq, u16 msix_idx, u16 itr_idx)
  * @hw: pointer to the HW structure
  * @q_vector: interrupt vector to trigger the software interrupt for
  */
-void ice_trigger_sw_intr(struct ice_hw *hw, struct ice_q_vector *q_vector)
+void ice_trigger_sw_intr(struct ice_hw *hw, const struct ice_q_vector *q_vector)
 {
 	wr32(hw, GLINT_DYN_CTL(q_vector->reg_idx),
 	     (ICE_ITR_NONE << GLINT_DYN_CTL_ITR_INDX_S) |
@@ -1035,7 +1035,7 @@ ice_vsi_stop_tx_ring(struct ice_vsi *vsi, enum ice_disq_rst_src rst_src,
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
2.39.3


