Return-Path: <netdev+bounces-124521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E81969D7B
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF08B1F2410C
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 12:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0382C1D6C7E;
	Tue,  3 Sep 2024 12:26:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41891C986E
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 12:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725366371; cv=none; b=NfclkQL5kOJwLlAnx/0WttBnzMcshSxkW0AJrJsbwhgMF7WQVGT657QszkAg5oAWoVJwcfwMK3pd28QCMWnkV+RqVyb9Rqqhcbv53vtizC+BXhUKolsQbrMb82Xf1CwEptEV1hCFQ7eXOBXTHiqCIvAm2j221x2O6SlIEvXsmBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725366371; c=relaxed/simple;
	bh=jeYRrRXmEW8pvvh5JZsSgwoq281Jw12lwI3FALKIhWo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SYcOI7a1J7zRo+duyguPyJYfzu0RZ9BWYIfMlH5ml8+8L1NHJN4EMmD1lR9LjCFXTJ4P5LMgex1QZRO/pAcs1xodpNZHZyorXigXELsFc5uv07SZ9dKECo8GV2MgZ4idiQqhy85FKuiNR2Wld+374EhDy2iJdx7zbM/F/1vTEUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WylD72TLtz1xwys;
	Tue,  3 Sep 2024 20:24:07 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id AF3EF1402CF;
	Tue,  3 Sep 2024 20:26:07 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Sep
 2024 20:26:06 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<ahmed.zaki@intel.com>, <yuehaibing@huawei.com>, <richardcochran@gmail.com>,
	<michal.swiatkowski@linux.intel.com>, <amritha.nambiar@intel.com>,
	<mateusz.polchlopek@intel.com>, <jacob.e.keller@intel.com>,
	<maciej.fijalkowski@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 3/3] ice: Cleanup unused declarations
Date: Tue, 3 Sep 2024 20:22:34 +0800
Message-ID: <20240903122234.964218-4-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903122234.964218-1-yuehaibing@huawei.com>
References: <20240903122234.964218-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Since commit fff292b47ac1 ("ice: add VF representors one by one")
ice_eswitch_configure() is not used anymore.
Commit 1b8f15b64a00 ("ice: refactor filter functions") removed
ice_vsi_cfg_mac_fltr() but leave declaration.
Commit a24b4c6e9aab ("ice: xsk: Do not convert to buff to frame for
XDP_TX") leave ice_xmit_xdp_buff() declaration.

Commit 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C
products") declared ice_phy_cfg_{rx,tx}_offset_eth56g(),
commit a1ffafb0b4a4 ("ice: Support configuring the device to Double
VLAN Mode") declared ice_pkg_buf_get_free_space(), and
commit 8a3a565ff210 ("ice: add admin commands to access cgu
configuration") declared ice_is_pca9575_present(), but all these never
be implemented.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.h   | 5 -----
 drivers/net/ethernet/intel/ice/ice_flex_pipe.h | 3 ---
 drivers/net/ethernet/intel/ice/ice_lib.h       | 2 --
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h    | 3 ---
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h  | 1 -
 5 files changed, 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.h b/drivers/net/ethernet/intel/ice/ice_eswitch.h
index 78fd39a6935d..cf4b7845f08f 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.h
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.h
@@ -48,11 +48,6 @@ ice_eswitch_set_target_vsi(struct sk_buff *skb,
 static inline void
 ice_eswitch_update_repr(unsigned long *repr_id, struct ice_vsi *vsi) { }
 
-static inline int ice_eswitch_configure(struct ice_pf *pf)
-{
-	return 0;
-}
-
 static inline int ice_eswitch_mode_get(struct devlink *devlink, u16 *mode)
 {
 	return DEVLINK_ESWITCH_MODE_LEGACY;
diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.h b/drivers/net/ethernet/intel/ice/ice_flex_pipe.h
index 90b9b0993122..28b0897adf32 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.h
+++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.h
@@ -23,9 +23,6 @@ int
 ice_get_sw_fv_list(struct ice_hw *hw, struct ice_prot_lkup_ext *lkups,
 		   unsigned long *bm, struct list_head *fv_list);
 int
-ice_pkg_buf_unreserve_section(struct ice_buf_build *bld, u16 count);
-u16 ice_pkg_buf_get_free_space(struct ice_buf_build *bld);
-int
 ice_aq_upload_section(struct ice_hw *hw, struct ice_buf_hdr *pkg_buf,
 		      u16 buf_size, struct ice_sq_cd *cd);
 bool
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 94ce8964dda6..77dff4ab875a 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -91,8 +91,6 @@ void ice_write_intrl(struct ice_q_vector *q_vector, u8 intrl);
 void ice_write_itr(struct ice_ring_container *rc, u16 itr);
 void ice_set_q_vector_intrl(struct ice_q_vector *q_vector);
 
-int ice_vsi_cfg_mac_fltr(struct ice_vsi *vsi, const u8 *macaddr, bool set);
-
 bool ice_is_safe_mode(struct ice_pf *pf);
 bool ice_is_rdma_ena(struct ice_pf *pf);
 bool ice_is_dflt_vsi_in_use(struct ice_port_info *pi);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 0852a34ade91..67a9711d01ac 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -403,7 +403,6 @@ int ice_phy_cfg_intr_e82x(struct ice_hw *hw, u8 quad, bool ena, u8 threshold);
 int ice_read_sma_ctrl_e810t(struct ice_hw *hw, u8 *data);
 int ice_write_sma_ctrl_e810t(struct ice_hw *hw, u8 data);
 int ice_read_pca9575_reg_e810t(struct ice_hw *hw, u8 offset, u8 *data);
-bool ice_is_pca9575_present(struct ice_hw *hw);
 enum dpll_pin_type ice_cgu_get_pin_type(struct ice_hw *hw, u8 pin, bool input);
 struct dpll_pin_frequency *
 ice_cgu_get_pin_freq_supp(struct ice_hw *hw, u8 pin, bool input, u8 *num);
@@ -420,8 +419,6 @@ int ice_cgu_get_output_pin_state_caps(struct ice_hw *hw, u8 pin_id,
 int ice_ptp_read_tx_hwtstamp_status_eth56g(struct ice_hw *hw, u32 *ts_status);
 int ice_stop_phy_timer_eth56g(struct ice_hw *hw, u8 port, bool soft_reset);
 int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port);
-int ice_phy_cfg_tx_offset_eth56g(struct ice_hw *hw, u8 port);
-int ice_phy_cfg_rx_offset_eth56g(struct ice_hw *hw, u8 port);
 int ice_phy_cfg_intr_eth56g(struct ice_hw *hw, u8 port, bool ena, u8 threshold);
 int ice_phy_cfg_ptp_1step_eth56g(struct ice_hw *hw, u8 port);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
index afcead4baef4..79f960c6680d 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
@@ -154,7 +154,6 @@ static inline u32 ice_set_rs_bit(const struct ice_tx_ring *xdp_ring)
 }
 
 void ice_finalize_xdp_rx(struct ice_tx_ring *xdp_ring, unsigned int xdp_res, u32 first_idx);
-int ice_xmit_xdp_buff(struct xdp_buff *xdp, struct ice_tx_ring *xdp_ring);
 int __ice_xmit_xdp_ring(struct xdp_buff *xdp, struct ice_tx_ring *xdp_ring,
 			bool frame);
 void ice_release_rx_desc(struct ice_rx_ring *rx_ring, u16 val);
-- 
2.34.1


