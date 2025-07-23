Return-Path: <netdev+bounces-209490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5181B0FB4D
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 22:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C8D1C239B5
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 20:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D2720F087;
	Wed, 23 Jul 2025 20:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkelfJ76"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA361E7C1C;
	Wed, 23 Jul 2025 20:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753301736; cv=none; b=gUupcVJoh0QgMpEJ543Ziq+h0PFxBh/k5IyfBWqVleRViAatbktNW4vXh3Brmz7CSJJMw8fgN4LsG52K83VWzKUZrL4kaZZfbt/lMh77oqk1eyDPm/nbRuGZTgtgbvquBHXIFiCnqtbbhhLgaRF/rfQmb+Ge1N8Gipu8sx6R9wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753301736; c=relaxed/simple;
	bh=X/H6wobxFfjzr1wQCvTMxxrRUkk7PQxBiI41a4mTZ88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hD8kggqrtM6cNWPc6FK+AN2qTs092kesooa5sGmLbFtLw5nbUtStSrTexR6DoApEPk6cNoqGsj+iaZH2euj14pTl5A14NrEwFYGaiKkOVUeJmbFw2NtjI8TenJ90TK4DsJNpkxsqLFxXDmA4ck6LZpJ9u43/HTuQzJAKyIcgAXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkelfJ76; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77672C4CEE7;
	Wed, 23 Jul 2025 20:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753301735;
	bh=X/H6wobxFfjzr1wQCvTMxxrRUkk7PQxBiI41a4mTZ88=;
	h=From:To:Cc:Subject:Date:From;
	b=PkelfJ76oQNFVwsQNzmEITA9C+qoM1bqaV9iZ7jlQTFx44Gse8ig3cWSZq6diRc9/
	 ByK0XyuK0bnlpADsyxYG5HWvHOMdUEkDElfBM42l726zVabthvt88QEaBq0K3x1TmT
	 LSiFiYJdSpG+/kaRufuNSdVlRt5gP9cvGeyVDuMVyQnSYcNUByCCVN6d4bodk4HJBM
	 mlPsFeMVpIxoe64Rr2C4bQ0ElGZE7KCMH0rwh7BB4GFX2TWyb/u1u6eem4k7Hz8G4d
	 h7gEKm3+p5wdnTaVV5LwB5sdm15aypSID6HDXLrC8Ky/grfJcZVYAK8wWeUw4fbjgd
	 EKMFPvpB7r0RQ==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] net: Fix typos
Date: Wed, 23 Jul 2025 15:15:05 -0500
Message-ID: <20250723201528.2908218-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Fix typos in comments and error messages.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/net/ethernet/amazon/ena/ena_admin_defs.h     |  2 +-
 drivers/net/ethernet/broadcom/b44.c                  |  2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_dcb.c      |  2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c  |  4 ++--
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_fw_defs.h  |  2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c     |  2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.h       |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c            |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c      |  2 +-
 drivers/net/ethernet/broadcom/tg3.c                  |  2 +-
 drivers/net/ethernet/cavium/liquidio/octeon_main.h   |  2 +-
 drivers/net/ethernet/cavium/liquidio/octeon_nic.h    |  4 ++--
 drivers/net/ethernet/chelsio/cxgb/pm3393.c           |  8 ++++----
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h           |  2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c      |  4 ++--
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32.c    |  4 ++--
 drivers/net/ethernet/chelsio/cxgb4/sge.c             |  2 +-
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c           |  2 +-
 drivers/net/ethernet/chelsio/cxgb4vf/sge.c           |  2 +-
 drivers/net/ethernet/chelsio/cxgb4vf/t4vf_hw.c       |  2 +-
 drivers/net/ethernet/dec/tulip/tulip_core.c          |  2 +-
 drivers/net/ethernet/faraday/ftgmac100.c             |  2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c      |  4 ++--
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c  |  2 +-
 drivers/net/ethernet/huawei/hinic/hinic_hw_eqs.c     |  2 +-
 drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c    |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_ptp.c           |  2 +-
 drivers/net/ethernet/intel/ice/devlink/port.h        |  2 +-
 drivers/net/ethernet/intel/ice/ice_base.c            |  2 +-
 drivers/net/ethernet/intel/ice/ice_lib.c             |  2 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c          |  2 +-
 drivers/net/ethernet/intel/igc/igc_mac.c             |  2 +-
 drivers/net/ethernet/intel/ixgbevf/vf.c              |  2 +-
 drivers/net/ethernet/marvell/mvneta_bm.h             |  2 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_cn10k.c    |  2 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c  |  2 +-
 drivers/net/ethernet/marvell/pxa168_eth.c            |  6 +++---
 drivers/net/ethernet/mellanox/mlx5/core/en.h         |  2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c      |  2 +-
 drivers/net/ethernet/micrel/ks8842.c                 |  2 +-
 drivers/net/ethernet/neterion/s2io.c                 |  4 ++--
 drivers/net/ethernet/pensando/ionic/ionic_if.h       |  2 +-
 drivers/net/ethernet/qlogic/qed/qed_dev.c            |  2 +-
 drivers/net/ethernet/qlogic/qed/qed_ptp.c            |  2 +-
 drivers/net/ethernet/qlogic/qla3xxx.c                |  2 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c    |  2 +-
 drivers/net/ethernet/qualcomm/emac/emac-sgmii.c      |  2 +-
 drivers/net/ethernet/sfc/mcdi_pcol.h                 |  6 +++---
 drivers/net/ethernet/sfc/siena/farch.c               |  2 +-
 drivers/net/ethernet/sfc/siena/mcdi_pcol.h           | 12 ++++++------
 drivers/net/ethernet/sfc/tc_encap_actions.c          |  2 +-
 drivers/net/ethernet/smsc/smsc911x.c                 |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c    |  2 +-
 drivers/net/ethernet/sun/niu.c                       |  2 +-
 drivers/net/ethernet/sun/niu.h                       |  4 ++--
 drivers/net/ethernet/sun/sunhme.c                    |  2 +-
 drivers/net/ethernet/sun/sunqe.h                     |  2 +-
 drivers/net/ethernet/tehuti/tehuti.c                 |  2 +-
 58 files changed, 77 insertions(+), 77 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_admin_defs.h b/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
index 562869a0fdba..898ecd96b96a 100644
--- a/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
+++ b/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
@@ -986,7 +986,7 @@ struct ena_admin_feature_rss_ind_table {
 	struct ena_admin_rss_ind_table_entry inline_entry;
 };
 
-/* When hint value is 0, driver should use it's own predefined value */
+/* When hint value is 0, driver should use its own predefined value */
 struct ena_admin_ena_hw_hints {
 	/* value in ms */
 	u16 mmio_read_timeout;
diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/broadcom/b44.c
index 8267417b3750..0353359c3fe9 100644
--- a/drivers/net/ethernet/broadcom/b44.c
+++ b/drivers/net/ethernet/broadcom/b44.c
@@ -2570,7 +2570,7 @@ static int __init b44_init(void)
 	unsigned int dma_desc_align_size = dma_get_cache_alignment();
 	int err;
 
-	/* Setup paramaters for syncing RX/TX DMA descriptors */
+	/* Setup parameters for syncing RX/TX DMA descriptors */
 	dma_desc_sync_size = max_t(unsigned int, dma_desc_align_size, sizeof(struct dma_desc));
 
 	err = b44_pci_init();
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_dcb.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_dcb.c
index 17ae6df90723..9af81630c8a4 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_dcb.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_dcb.c
@@ -344,7 +344,7 @@ static void  bnx2x_dcbx_get_pfc_feature(struct bnx2x *bp,
 	}
 }
 
-/* maps unmapped priorities to to the same COS as L2 */
+/* maps unmapped priorities to the same COS as L2 */
 static void bnx2x_dcbx_map_nw(struct bnx2x *bp)
 {
 	int i;
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
index 528ce9ca4f54..fc8dec37a9e4 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
@@ -1243,9 +1243,9 @@ static int bnx2x_get_eeprom_len(struct net_device *dev)
  * pf B succeeds in taking the same lock since they are from the same port.
  * pf A takes the per pf misc lock. Performs eeprom access.
  * pf A finishes. Unlocks the per pf misc lock.
- * Pf B takes the lock and proceeds to perform it's own access.
+ * Pf B takes the lock and proceeds to perform its own access.
  * pf A unlocks the per port lock, while pf B is still working (!).
- * mcp takes the per port lock and corrupts pf B's access (and/or has it's own
+ * mcp takes the per port lock and corrupts pf B's access (and/or has its own
  * access corrupted by pf B)
  */
 static int bnx2x_acquire_nvram_lock(struct bnx2x *bp)
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_fw_defs.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_fw_defs.h
index a84d015da5df..9221942290a8 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_fw_defs.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_fw_defs.h
@@ -332,7 +332,7 @@
 #define TOE_STATE (TOE_CONNECTION_TYPE << PROTOCOL_STATE_BIT_OFFSET)
 #define RDMA_STATE (RDMA_CONNECTION_TYPE << PROTOCOL_STATE_BIT_OFFSET)
 
-/* microcode fixed page page size 4K (chains and ring segments) */
+/* microcode fixed page size 4K (chains and ring segments) */
 #define MC_PAGE_SIZE 4096
 
 /* Number of indices per slow-path SB */
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 3ee4b848ef53..9d9f9a987bc0 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -1768,7 +1768,7 @@ static bool bnx2x_trylock_hw_lock(struct bnx2x *bp, u32 resource)
  * @bp:	driver handle
  *
  * Returns the recovery leader resource id according to the engine this function
- * belongs to. Currently only only 2 engines is supported.
+ * belongs to. Currently only 2 engines is supported.
  */
 static int bnx2x_get_leader_lock_resource(struct bnx2x *bp)
 {
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.h
index bacc8552bce1..00ca861c80dd 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.h
@@ -379,7 +379,7 @@ struct bnx2x_vlan_mac_obj {
 	/**
 	*  Delete all configured elements having the given
 	*  vlan_mac_flags specification. Assumes no pending for
-	*  execution commands. Will schedule all all currently
+	*  execution commands. Will schedule all currently
 	*  configured MACs/VLANs/VLAN-MACs matching the vlan_mac_flags
 	*  specification for deletion and will use the given
 	*  ramrod_flags for the last DEL operation.
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index de8080df69a8..5578ddcb465d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -16974,7 +16974,7 @@ static pci_ers_result_t bnxt_io_error_detected(struct pci_dev *pdev,
 	bnxt_free_ctx_mem(bp, false);
 	netdev_unlock(netdev);
 
-	/* Request a slot slot reset. */
+	/* Request a slot reset. */
 	return PCI_ERS_RESULT_NEED_RESET;
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
index ec14b51ba38e..480e18a32caa 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
@@ -1125,7 +1125,7 @@ static int bnxt_vf_validate_set_mac(struct bnxt *bp, struct bnxt_vf_info *vf)
 		/* There are two cases:
 		 * 1.If firmware spec < 0x10202,VF MAC address is not forwarded
 		 *   to the PF and so it doesn't have to match
-		 * 2.Allow VF to modify it's own MAC when PF has not assigned a
+		 * 2.Allow VF to modify its own MAC when PF has not assigned a
 		 *   valid MAC address and firmware spec >= 0x10202
 		 */
 		mac_ok = true;
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index c00b05b2e945..b4dc93a48718 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -16610,7 +16610,7 @@ static int tg3_get_invariants(struct tg3 *tp, const struct pci_device_id *ent)
 
 			tg3_flag_set(tp, PCIX_TARGET_HWBUG);
 
-			/* The chip can have it's power management PCI config
+			/* The chip can have its power management PCI config
 			 * space registers clobbered due to this bug.
 			 * So explicitly force the chip into D0 here.
 			 */
diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_main.h b/drivers/net/ethernet/cavium/liquidio/octeon_main.h
index 5b4cb725f60f..953edf0c7096 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_main.h
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_main.h
@@ -157,7 +157,7 @@ static inline int octeon_map_pci_barx(struct octeon_device *oct,
 	    response of the request.
  *          0: the request will wait until its response gets back
  *	       from the firmware within LIO_SC_MAX_TMO_MS milli sec.
- *	       It the response does not return within
+ *	       If the response does not return within
  *	       LIO_SC_MAX_TMO_MS milli sec, lio_process_ordered_list()
  *	       will move the request to zombie response list.
  *
diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_nic.h b/drivers/net/ethernet/cavium/liquidio/octeon_nic.h
index 87dd6f89ce51..c139fc423764 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_nic.h
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_nic.h
@@ -268,7 +268,7 @@ octeon_alloc_soft_command_resp(struct octeon_device    *oct,
  * @param oct - octeon device pointer
  * @param ndata - control structure with queueing, and buffer information
  *
- * @returns IQ_FAILED if it failed to add to the input queue. IQ_STOP if it the
+ * @returns IQ_FAILED if it failed to add to the input queue. IQ_STOP if the
  * queue should be stopped, and IQ_SEND_OK if it sent okay.
  */
 int octnet_send_nic_data_pkt(struct octeon_device *oct,
@@ -278,7 +278,7 @@ int octnet_send_nic_data_pkt(struct octeon_device *oct,
 /** Send a NIC control packet to the device
  * @param oct - octeon device pointer
  * @param nctrl - control structure with command, timout, and callback info
- * @returns IQ_FAILED if it failed to add to the input queue. IQ_STOP if it the
+ * @returns IQ_FAILED if it failed to add to the input queue. IQ_STOP if the
  * queue should be stopped, and IQ_SEND_OK if it sent okay.
  */
 int
diff --git a/drivers/net/ethernet/chelsio/cxgb/pm3393.c b/drivers/net/ethernet/chelsio/cxgb/pm3393.c
index cbfa03d5663a..f3ada6e7cdc5 100644
--- a/drivers/net/ethernet/chelsio/cxgb/pm3393.c
+++ b/drivers/net/ethernet/chelsio/cxgb/pm3393.c
@@ -141,7 +141,7 @@ static int pm3393_interrupt_enable(struct cmac *cmac)
 	pmwrite(cmac, SUNI1x10GEXP_REG_GLOBAL_INTERRUPT_ENABLE,
 		0 /*SUNI1x10GEXP_BITMSK_TOP_INTE */ );
 
-	/* TERMINATOR - PL_INTERUPTS_EXT */
+	/* TERMINATOR - PL_INTERRUPTS_EXT */
 	pl_intr = readl(cmac->adapter->regs + A_PL_ENABLE);
 	pl_intr |= F_PL_INTR_EXT;
 	writel(pl_intr, cmac->adapter->regs + A_PL_ENABLE);
@@ -179,7 +179,7 @@ static int pm3393_interrupt_disable(struct cmac *cmac)
 	elmer &= ~ELMER0_GP_BIT1;
 	t1_tpi_write(cmac->adapter, A_ELMER0_INT_ENABLE, elmer);
 
-	/* TERMINATOR - PL_INTERUPTS_EXT */
+	/* TERMINATOR - PL_INTERRUPTS_EXT */
 	/* DO NOT DISABLE TERMINATOR's EXTERNAL INTERRUPTS. ANOTHER CHIP
 	 * COULD WANT THEM ENABLED. We disable PM3393 at the ELMER level.
 	 */
@@ -222,7 +222,7 @@ static int pm3393_interrupt_clear(struct cmac *cmac)
 	elmer |= ELMER0_GP_BIT1;
 	t1_tpi_write(cmac->adapter, A_ELMER0_INT_CAUSE, elmer);
 
-	/* TERMINATOR - PL_INTERUPTS_EXT
+	/* TERMINATOR - PL_INTERRUPTS_EXT
 	 */
 	pl_intr = readl(cmac->adapter->regs + A_PL_CAUSE);
 	pl_intr |= F_PL_INTR_EXT;
@@ -756,7 +756,7 @@ static int pm3393_mac_reset(adapter_t * adapter)
 
 		/* ??? If this fails, might be able to software reset the XAUI part
 		 *     and try to recover... thus saving us from doing another HW reset */
-		/* Has the XAUI MABC PLL circuitry stablized? */
+		/* Has the XAUI MABC PLL circuitry stabilized? */
 		is_xaui_mabc_pll_locked =
 		    (val & SUNI1x10GEXP_BITMSK_TOP_SXRA_EXPIRED);
 
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
index 95e6f015a6af..0d85198fb03d 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
@@ -1316,7 +1316,7 @@ struct ch_sched_flowc {
  * (value, mask) tuples.  The associated ingress packet field matches the
  * tuple when ((field & mask) == value).  (Thus a wildcard "don't care" field
  * rule can be constructed by specifying a tuple of (0, 0).)  A filter rule
- * matches an ingress packet when all of the individual individual field
+ * matches an ingress packet when all of the individual field
  * matching rules are true.
  *
  * Partial field masks are always valid, however, while it may be easy to
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 51395c96b2e9..392723ef14e5 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -3297,7 +3297,7 @@ static int cxgb4_mgmt_set_vf_rate(struct net_device *dev, int vf,
 	}
 
 	if (max_tx_rate == 0) {
-		/* unbind VF to to any Traffic Class */
+		/* unbind VF to any Traffic Class */
 		fw_pfvf =
 		    (FW_PARAMS_MNEM_V(FW_PARAMS_MNEM_PFVF) |
 		     FW_PARAMS_PARAM_X_V(FW_PARAMS_PARAM_PFVF_SCHEDCLASS_ETH));
@@ -4816,7 +4816,7 @@ static int adap_init0(struct adapter *adap, int vpd_skip)
 			goto bye;
 		}
 
-		/* Get FW from from /lib/firmware/ */
+		/* Get FW from /lib/firmware/ */
 		ret = request_firmware(&fw, fw_info->fw_mod_name,
 				       adap->pdev_dev);
 		if (ret < 0) {
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32.c
index a5d2f84dcdd5..8524246fd67e 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32.c
@@ -186,7 +186,7 @@ int cxgb4_config_knode(struct net_device *dev, struct tc_cls_u32_offload *cls)
 	link_uhtid = TC_U32_USERHTID(cls->knode.link_handle);
 
 	/* Ensure that uhtid is either root u32 (i.e. 0x800)
-	 * or a a valid linked bucket.
+	 * or a valid linked bucket.
 	 */
 	if (uhtid != 0x800 && uhtid >= t->size)
 		return -EINVAL;
@@ -422,7 +422,7 @@ int cxgb4_delete_knode(struct net_device *dev, struct tc_cls_u32_offload *cls)
 	uhtid = TC_U32_USERHTID(cls->knode.handle);
 
 	/* Ensure that uhtid is either root u32 (i.e. 0x800)
-	 * or a a valid linked bucket.
+	 * or a valid linked bucket.
 	 */
 	if (uhtid != 0x800 && uhtid >= t->size)
 		return -EINVAL;
diff --git a/drivers/net/ethernet/chelsio/cxgb4/sge.c b/drivers/net/ethernet/chelsio/cxgb4/sge.c
index 64402e3646b3..9fccb8ea9bcd 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
@@ -163,7 +163,7 @@ static inline unsigned int fl_mtu_bufsize(struct adapter *adapter,
  * for DMA, but this is of course never sent to the hardware and is only used
  * to prevent double unmappings.  All of the above requires that the Free List
  * Buffers which we allocate have the bottom 5 bits free (0) -- i.e. are
- * 32-byte or or a power of 2 greater in alignment.  Since the SGE's minimal
+ * 32-byte or a power of 2 greater in alignment.  Since the SGE's minimal
  * Free List Buffer alignment is 32 bytes, this works out for us ...
  */
 enum {
diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
index 175bf9b13058..171750fad44f 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
@@ -9348,7 +9348,7 @@ int t4_init_devlog_params(struct adapter *adap)
 		return 0;
 	}
 
-	/* Otherwise, ask the firmware for it's Device Log Parameters.
+	/* Otherwise, ask the firmware for its Device Log Parameters.
 	 */
 	memset(&devlog_cmd, 0, sizeof(devlog_cmd));
 	devlog_cmd.op_to_write = cpu_to_be32(FW_CMD_OP_V(FW_DEVLOG_CMD) |
diff --git a/drivers/net/ethernet/chelsio/cxgb4vf/sge.c b/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
index 4e6ecb9c8dcc..31fab2415743 100644
--- a/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
@@ -2191,7 +2191,7 @@ static void __iomem *bar2_address(struct adapter *adapter,
 /**
  *	t4vf_sge_alloc_rxq - allocate an SGE RX Queue
  *	@adapter: the adapter
- *	@rspq: pointer to to the new rxq's Response Queue to be filled in
+ *	@rspq: pointer to the new rxq's Response Queue to be filled in
  *	@iqasynch: if 0, a normal rspq; if 1, an asynchronous event queue
  *	@dev: the network device associated with the new rspq
  *	@intr_dest: MSI-X vector index (overriden in MSI mode)
diff --git a/drivers/net/ethernet/chelsio/cxgb4vf/t4vf_hw.c b/drivers/net/ethernet/chelsio/cxgb4vf/t4vf_hw.c
index 1c52592d3b65..56fcc531af2e 100644
--- a/drivers/net/ethernet/chelsio/cxgb4vf/t4vf_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/t4vf_hw.c
@@ -706,7 +706,7 @@ int t4vf_fl_pkt_align(struct adapter *adapter)
 	 * separately.  The actual Ingress Packet Data alignment boundary
 	 * within Packed Buffer Mode is the maximum of these two
 	 * specifications.  (Note that it makes no real practical sense to
-	 * have the Pading Boudary be larger than the Packing Boundary but you
+	 * have the Padding Boundary be larger than the Packing Boundary but you
 	 * could set the chip up that way and, in fact, legacy T4 code would
 	 * end doing this because it would initialize the Padding Boundary and
 	 * leave the Packing Boundary initialized to 0 (16 bytes).)
diff --git a/drivers/net/ethernet/dec/tulip/tulip_core.c b/drivers/net/ethernet/dec/tulip/tulip_core.c
index 5b7e6eb080f3..b608585f1954 100644
--- a/drivers/net/ethernet/dec/tulip/tulip_core.c
+++ b/drivers/net/ethernet/dec/tulip/tulip_core.c
@@ -1550,7 +1550,7 @@ static int tulip_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
                     (PCI_SLOT(pdev->devfn) == 12))) {
                        /* Cobalt MAC address in first EEPROM locations. */
                        sa_offset = 0;
-		       /* Ensure our media table fixup get's applied */
+		       /* Ensure our media table fixup gets applied */
 		       memcpy(ee_data + 16, ee_data, 8);
                }
 #endif
diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 05b8e3743a79..5d0c0906878d 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1448,7 +1448,7 @@ static void ftgmac100_adjust_link(struct net_device *netdev)
 	/* Disable all interrupts */
 	iowrite32(0, priv->base + FTGMAC100_OFFSET_IER);
 
-	/* Release phy lock to allow ftgmac100_reset to aquire it, keeping lock
+	/* Release phy lock to allow ftgmac100_reset to acquire it, keeping lock
 	 * order consistent to prevent dead lock.
 	 */
 	if (netdev->phydev)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 52f42fe1d56f..011f710d933a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2106,7 +2106,7 @@ static void hns3_tx_doorbell(struct hns3_enet_ring *ring, int num,
 	 */
 	if (test_bit(HNS3_NIC_STATE_TX_PUSH_ENABLE, &priv->state) && num &&
 	    !ring->pending_buf && num <= HNS3_MAX_PUSH_BD_NUM && doorbell) {
-		/* This smp_store_release() pairs with smp_load_aquire() in
+		/* This smp_store_release() pairs with smp_load_acquire() in
 		 * hns3_nic_reclaim_desc(). Ensure that the BD valid bit
 		 * is updated.
 		 */
@@ -2122,7 +2122,7 @@ static void hns3_tx_doorbell(struct hns3_enet_ring *ring, int num,
 		return;
 	}
 
-	/* This smp_store_release() pairs with smp_load_aquire() in
+	/* This smp_store_release() pairs with smp_load_acquire() in
 	 * hns3_nic_reclaim_desc(). Ensure that the BD valid bit is updated.
 	 */
 	smp_store_release(&ring->last_to_use, ring->next_to_use);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index d3c71bc1855d..ef17de71b9d4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -490,7 +490,7 @@ static int hclge_mac_update_stats_complete(struct hclge_dev *hdev)
 	desc_num = reg_num / HCLGE_REG_NUM_PER_DESC + 1;
 
 	/* This may be called inside atomic sections,
-	 * so GFP_ATOMIC is more suitalbe here
+	 * so GFP_ATOMIC is more suitable here
 	 */
 	desc = kcalloc(desc_num, sizeof(struct hclge_desc), GFP_ATOMIC);
 	if (!desc)
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_eqs.c b/drivers/net/ethernet/huawei/hinic/hinic_hw_eqs.c
index 045c47786a04..28114a59347e 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_hw_eqs.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_eqs.c
@@ -605,7 +605,7 @@ static void aeq_elements_init(struct hinic_eq *eq, u32 init_val)
 /**
  * ceq_elements_init - Initialize all the elements in the ceq
  * @eq: the event queue
- * @init_val: value to init with it the elements
+ * @init_val: value to init the elements with
  **/
 static void ceq_elements_init(struct hinic_eq *eq, u32 init_val)
 {
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c b/drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c
index 3f9c31d29215..97c1584dc05b 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c
@@ -861,7 +861,7 @@ static int send_mbox_to_func(struct hinic_mbox_func_to_func *func_to_func,
 		 HINIC_MBOX_HEADER_SET(NOT_LAST_SEG, LAST) |
 		 HINIC_MBOX_HEADER_SET(direction, DIRECTION) |
 		 HINIC_MBOX_HEADER_SET(cmd, CMD) |
-		 /* The vf's offset to it's associated pf */
+		 /* The vf's offset to its associated pf */
 		 HINIC_MBOX_HEADER_SET(msg_info->msg_id, MSG_ID) |
 		 HINIC_MBOX_HEADER_SET(msg_info->status, STATUS) |
 		 HINIC_MBOX_HEADER_SET(hinic_global_func_id_hw(hwdev->hwif),
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 1d04ea7df552..33535418178b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -550,7 +550,7 @@ static int i40e_ptp_enable_pin(struct i40e_pf *pf, unsigned int chan,
 	pins.gpio_4 = pf->ptp_pins->gpio_4;
 
 	/* To turn on the pin - find the corresponding one based on
-	 * the given index. To to turn the function off - find
+	 * the given index. To turn the function off - find
 	 * which pin had it assigned. Don't use ptp_find_pin here
 	 * because it tries to lock the pincfg_mux which is locked by
 	 * ptp_pin_store() that calls here.
diff --git a/drivers/net/ethernet/intel/ice/devlink/port.h b/drivers/net/ethernet/intel/ice/devlink/port.h
index d60efc340945..e89ddd60eeac 100644
--- a/drivers/net/ethernet/intel/ice/devlink/port.h
+++ b/drivers/net/ethernet/intel/ice/devlink/port.h
@@ -11,7 +11,7 @@
  * struct ice_dynamic_port - Track dynamically added devlink port instance
  * @hw_addr: the HW address for this port
  * @active: true if the port has been activated
- * @attached: true it the prot is attached
+ * @attached: true if the prot is attached
  * @devlink_port: the associated devlink port structure
  * @pf: pointer to the PF private structure
  * @vsi: the VSI associated with this port
diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 270f936ce807..c5da8e9cc0a0 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -250,7 +250,7 @@ static u16 ice_calc_txq_handle(struct ice_vsi *vsi, struct ice_tx_ring *ring, u8
 		return ring->q_index - ring->ch->base_q;
 
 	/* Idea here for calculation is that we subtract the number of queue
-	 * count from TC that ring belongs to from it's absolute queue index
+	 * count from TC that ring belongs to from its absolute queue index
 	 * and as a result we get the queue's index within TC.
 	 */
 	return ring->q_index - vsi->tc_cfg.tc_info[tc].qoffset;
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 1be1e429a7c8..b1965357fda2 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3199,7 +3199,7 @@ void ice_vsi_cfg_netdev_tc(struct ice_vsi *vsi, u8 ena_tc)
 	if (!netdev)
 		return;
 
-	/* CHNL VSI doesn't have it's own netdev, hence, no netdev_tc */
+	/* CHNL VSI doesn't have its own netdev, hence, no netdev_tc */
 	if (vsi->type == ICE_VSI_CHNL)
 		return;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index e8e439fd64a4..70365196bb5c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -149,7 +149,7 @@ static const struct ice_cgu_pin_desc ice_e823_zl_cgu_outputs[] = {
  *                    |    8 bit s    | |    32 bits    |
  *                    +---------------+ +---------------+
  *
- * The increment value is added to the GLSTYN_TIME_R and GLSTYN_TIME_L
+ * The increment value is added to the GLTSYN_TIME_R and GLTSYN_TIME_L
  * registers every clock source tick. Depending on the specific device
  * configuration, the clock source frequency could be one of a number of
  * values.
diff --git a/drivers/net/ethernet/intel/igc/igc_mac.c b/drivers/net/ethernet/intel/igc/igc_mac.c
index d344e0a1cd5e..7ac6637f8db7 100644
--- a/drivers/net/ethernet/intel/igc/igc_mac.c
+++ b/drivers/net/ethernet/intel/igc/igc_mac.c
@@ -127,7 +127,7 @@ s32 igc_setup_link(struct igc_hw *hw)
 		goto out;
 
 	/* If requested flow control is set to default, set flow control
-	 * to the both 'rx' and 'tx' pause frames.
+	 * to both 'rx' and 'tx' pause frames.
 	 */
 	if (hw->fc.requested_mode == igc_fc_default)
 		hw->fc.requested_mode = igc_fc_full;
diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
index da7a72ecce7a..dcaef34b88b6 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.c
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
@@ -255,7 +255,7 @@ static s32 ixgbevf_set_uc_addr_vf(struct ixgbe_hw *hw, u32 index, u8 *addr)
 
 	memset(msgbuf, 0, sizeof(msgbuf));
 	/* If index is one then this is the start of a new list and needs
-	 * indication to the PF so it can do it's own list management.
+	 * indication to the PF so it can do its own list management.
 	 * If it is zero then that tells the PF to just clear all of
 	 * this VF's macvlans and there is no new list.
 	 */
diff --git a/drivers/net/ethernet/marvell/mvneta_bm.h b/drivers/net/ethernet/marvell/mvneta_bm.h
index e47783ce77e0..57ac039df6f7 100644
--- a/drivers/net/ethernet/marvell/mvneta_bm.h
+++ b/drivers/net/ethernet/marvell/mvneta_bm.h
@@ -115,7 +115,7 @@ struct mvneta_bm_pool {
 
 	/* Packet size */
 	int pkt_size;
-	/* Size of the buffer acces through DMA*/
+	/* Size of the buffer access through DMA */
 	u32 buf_size;
 
 	/* BPPE virtual base address */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
index 05adc54535eb..d2163da28d18 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
@@ -155,7 +155,7 @@ int rvu_mbox_handler_lmtst_tbl_setup(struct rvu *rvu,
 	int err = 0;
 	u64 val;
 
-	/* Check if PF_FUNC wants to use it's own local memory as LMTLINE
+	/* Check if PF_FUNC wants to use its own local memory as LMTLINE
 	 * region, if so, convert that IOVA to physical address and
 	 * populate LMT table with that address
 	 */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index bdf4d852c15d..60db1f616cc8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -5050,7 +5050,7 @@ static int rvu_nix_block_init(struct rvu *rvu, struct nix_hw *nix_hw)
 				    (ltdefs->rx_apad1.ltype_match << 4) |
 				    ltdefs->rx_apad1.ltype_mask);
 
-			/* Receive ethertype defination register defines layer
+			/* Receive ethertype definition register defines layer
 			 * information in NPC_RESULT_S to identify the Ethertype
 			 * location in L2 header. Used for Ethertype overwriting
 			 * in inline IPsec flow.
diff --git a/drivers/net/ethernet/marvell/pxa168_eth.c b/drivers/net/ethernet/marvell/pxa168_eth.c
index e4cfdc8bc055..68f8a1e36aa6 100644
--- a/drivers/net/ethernet/marvell/pxa168_eth.c
+++ b/drivers/net/ethernet/marvell/pxa168_eth.c
@@ -1229,9 +1229,9 @@ static int pxa168_rx_poll(struct napi_struct *napi, int budget)
 	int work_done = 0;
 
 	/*
-	 * We call txq_reclaim every time since in NAPI interupts are disabled
-	 * and due to this we miss the TX_DONE interrupt,which is not updated in
-	 * interrupt status register.
+	 * We call txq_reclaim every time since in NAPI interrupts are disabled
+	 * and due to this we miss the TX_DONE interrupt, which is not updated
+	 * in interrupt status register.
 	 */
 	txq_reclaim(dev, 0);
 	if (netif_queue_stopped(dev)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 99295eaf2f02..60d24d8a2242 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -375,7 +375,7 @@ struct mlx5e_sq_dma {
 	enum mlx5e_dma_map_type type;
 };
 
-/* Keep this enum consistent with with the corresponding strings array
+/* Keep this enum consistent with the corresponding strings array
  * declared in en/reporter_tx.c
  */
 enum {
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 588da02d6e22..dc7ba8d5fc43 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -1445,7 +1445,7 @@ static int fbnic_set_channels(struct net_device *netdev,
 	standalone = ch->rx_count + ch->tx_count;
 
 	/* Limits for standalone queues:
-	 *  - each queue has it's own NAPI (num_napi >= rx + tx + combined)
+	 *  - each queue has its own NAPI (num_napi >= rx + tx + combined)
 	 *  - combining queues (combined not 0, rx or tx must be 0)
 	 */
 	if ((ch->rx_count && ch->tx_count && ch->combined_count) ||
diff --git a/drivers/net/ethernet/micrel/ks8842.c b/drivers/net/ethernet/micrel/ks8842.c
index c7b0b09c2b09..541c41a9077a 100644
--- a/drivers/net/ethernet/micrel/ks8842.c
+++ b/drivers/net/ethernet/micrel/ks8842.c
@@ -335,7 +335,7 @@ static void ks8842_reset_hw(struct ks8842_adapter *adapter)
 		/* When running in DMA Mode the RX interrupt is not enabled in
 		   timberdale because RX data is received by DMA callbacks
 		   it must still be enabled in the KS8842 because it indicates
-		   to timberdale when there is RX data for it's DMA FIFOs */
+		   to timberdale when there is RX data for its DMA FIFOs */
 		iowrite16(ENABLED_IRQS_DMA_IP, adapter->hw_addr + REG_TIMB_IER);
 		ks8842_write16(adapter, 18, ENABLED_IRQS_DMA, REG_IER);
 	} else {
diff --git a/drivers/net/ethernet/neterion/s2io.c b/drivers/net/ethernet/neterion/s2io.c
index 27443e346f9f..5026b0263d43 100644
--- a/drivers/net/ethernet/neterion/s2io.c
+++ b/drivers/net/ethernet/neterion/s2io.c
@@ -4707,7 +4707,7 @@ static irqreturn_t s2io_isr(int irq, void *dev_id)
 			/*
 			 * rx_traffic_int reg is an R1 register, writing all 1's
 			 * will ensure that the actual interrupt causing bit
-			 * get's cleared and hence a read can be avoided.
+			 * gets cleared and hence a read can be avoided.
 			 */
 			if (reason & GEN_INTR_RXTRAFFIC)
 				writeq(S2IO_MINUS_ONE, &bar0->rx_traffic_int);
@@ -4721,7 +4721,7 @@ static irqreturn_t s2io_isr(int irq, void *dev_id)
 
 		/*
 		 * tx_traffic_int reg is an R1 register, writing all 1's
-		 * will ensure that the actual interrupt causing bit get's
+		 * will ensure that the actual interrupt causing bit gets
 		 * cleared and hence a read can be avoided.
 		 */
 		if (reason & GEN_INTR_TXTRAFFIC)
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_if.h b/drivers/net/ethernet/pensando/ionic/ionic_if.h
index f1ddbe9994a3..9886cd66ce68 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_if.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_if.h
@@ -1074,7 +1074,7 @@ struct ionic_rxq_sg_desc {
  *                    first IPv4 header.  If the receive packet
  *                    contains both a tunnel IPv4 header and a
  *                    transport IPv4 header, the device validates the
- *                    checksum for the both IPv4 headers.
+ *                    checksum for both IPv4 headers.
  *
  *                  IONIC_RXQ_COMP_CSUM_F_IP_BAD:
  *                    The IPv4 checksum calculated by the device did
diff --git a/drivers/net/ethernet/qlogic/qed/qed_dev.c b/drivers/net/ethernet/qlogic/qed/qed_dev.c
index 9659ce5b0712..f3d2b2b3bad5 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dev.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dev.c
@@ -2216,7 +2216,7 @@ int qed_resc_alloc(struct qed_dev *cdev)
 		}
 
 		/* CID map / ILT shadow table / T2
-		 * The talbes sizes are determined by the computations above
+		 * The table sizes are determined by the computations above
 		 */
 		rc = qed_cxt_tables_alloc(p_hwfn);
 		if (rc)
diff --git a/drivers/net/ethernet/qlogic/qed/qed_ptp.c b/drivers/net/ethernet/qlogic/qed/qed_ptp.c
index 295ce435a1a4..4df8a97b717e 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_ptp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_ptp.c
@@ -307,7 +307,7 @@ static int qed_ptp_hw_adjfreq(struct qed_dev *cdev, s32 ppb)
 	} else if (ppb == 1) {
 		/* This is a special case as its the only value which wouldn't
 		 * fit in a s64 variable. In order to prevent castings simple
-		 * handle it seperately.
+		 * handle it separately.
 		 */
 		best_val = 4;
 		best_period = 0xee6b27f;
diff --git a/drivers/net/ethernet/qlogic/qla3xxx.c b/drivers/net/ethernet/qlogic/qla3xxx.c
index aee4e63b4b82..fca94a69c777 100644
--- a/drivers/net/ethernet/qlogic/qla3xxx.c
+++ b/drivers/net/ethernet/qlogic/qla3xxx.c
@@ -1501,7 +1501,7 @@ static int ql_finish_auto_neg(struct ql3_adapter *qdev)
 				     "Remote error detected. Calling ql_port_start()\n");
 			/*
 			 * ql_port_start() is shared code and needs
-			 * to lock the PHY on it's own.
+			 * to lock the PHY on its own.
 			 */
 			ql_sem_unlock(qdev, QL_PHY_GIO_SEM_MASK);
 			if (ql_port_start(qdev))	/* Restart port */
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
index b733374b4dc5..6145252d8ff8 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
@@ -2051,7 +2051,7 @@ static void qlcnic_83xx_init_hw(struct qlcnic_adapter *p_dev)
 		dev_err(&p_dev->pdev->dev, "%s: failed\n", __func__);
 }
 
-/* POST FW related definations*/
+/* POST FW related definitions*/
 #define QLC_83XX_POST_SIGNATURE_REG	0x41602014
 #define QLC_83XX_POST_MODE_REG		0x41602018
 #define QLC_83XX_POST_FAST_MODE		0
diff --git a/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c b/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
index a508ebc4b206..28b3a7071e58 100644
--- a/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
@@ -419,7 +419,7 @@ int emac_sgmii_config(struct platform_device *pdev, struct emac_adapter *adpt)
 		goto error_put_device;
 	}
 
-	/* v2 SGMII has a per-lane digital digital, so parse it if it exists */
+	/* v2 SGMII has a per-lane digital, so parse it if it exists */
 	res = platform_get_resource(sgmii_pdev, IORESOURCE_MEM, 1);
 	if (res) {
 		phy->digital = ioremap(res->start, resource_size(res));
diff --git a/drivers/net/ethernet/sfc/mcdi_pcol.h b/drivers/net/ethernet/sfc/mcdi_pcol.h
index 9cb339c461fb..b9866e389e6d 100644
--- a/drivers/net/ethernet/sfc/mcdi_pcol.h
+++ b/drivers/net/ethernet/sfc/mcdi_pcol.h
@@ -9190,7 +9190,7 @@
 /* MC_CMD_DYNAMIC_SENSORS_GET_DESCRIPTIONS
  * Get descriptions for a set of sensors, specified as an array of sensor
  * handles as returned by MC_CMD_DYNAMIC_SENSORS_LIST. Any handles which do not
- * correspond to a sensor currently managed by the MC will be dropped from from
+ * correspond to a sensor currently managed by the MC will be dropped from
  * the response. This may happen when a sensor table update is in progress, and
  * effectively means the set of usable sensors is the intersection between the
  * sets of sensors known to the driver and the MC. On Riverhead this command is
@@ -9236,7 +9236,7 @@
  * broken sensor, then the state of the response's MC_CMD_DYNAMIC_SENSORS_VALUE
  * entry will be set to BROKEN, and any value provided should be treated as
  * erroneous. Any handles which do not correspond to a sensor currently managed
- * by the MC will be dropped from from the response. This may happen when a
+ * by the MC will be dropped from the response. This may happen when a
  * sensor table update is in progress, and effectively means the set of usable
  * sensors is the intersection between the sets of sensors known to the driver
  * and the MC. On Riverhead this command is implemented as a wrapper for
@@ -22487,7 +22487,7 @@
  * the named interface itself - INTF=..., PF=..., VF=VF_NULL to refer to a PF
  * on a named interface - INTF=..., PF=..., VF=... to refer to a VF on a named
  * interface where ... refers to a small integer for the VF/PF fields, and to
- * values from the PCIE_INTERFACE enum for for the INTF field. It's only
+ * values from the PCIE_INTERFACE enum for the INTF field. It's only
  * meaningful to use INTF=CALLER within a structure that's an argument to
  * MC_CMD_DEVEL_GET_CLIENT_HANDLE.
  */
diff --git a/drivers/net/ethernet/sfc/siena/farch.c b/drivers/net/ethernet/sfc/siena/farch.c
index 89ccd65c978b..562a038e38a7 100644
--- a/drivers/net/ethernet/sfc/siena/farch.c
+++ b/drivers/net/ethernet/sfc/siena/farch.c
@@ -1708,7 +1708,7 @@ void efx_farch_dimension_resources(struct efx_nic *efx, unsigned sram_lim_qw)
 
 			if (efx->vf_count > vf_limit) {
 				netif_err(efx, probe, efx->net_dev,
-					  "Reducing VF count from from %d to %d\n",
+					  "Reducing VF count from %d to %d\n",
 					  efx->vf_count, vf_limit);
 				efx->vf_count = vf_limit;
 			}
diff --git a/drivers/net/ethernet/sfc/siena/mcdi_pcol.h b/drivers/net/ethernet/sfc/siena/mcdi_pcol.h
index a3cc8b7ec732..b81b0aa460d2 100644
--- a/drivers/net/ethernet/sfc/siena/mcdi_pcol.h
+++ b/drivers/net/ethernet/sfc/siena/mcdi_pcol.h
@@ -6704,16 +6704,16 @@
 #define       MC_CMD_SENSOR_SET_LIMS_IN_SENSOR_LEN 4
 /*            Enum values, see field(s): */
 /*               MC_CMD_SENSOR_INFO/MC_CMD_SENSOR_INFO_OUT/MASK */
-/* interpretation is is sensor-specific. */
+/* interpretation is sensor-specific. */
 #define       MC_CMD_SENSOR_SET_LIMS_IN_LOW0_OFST 4
 #define       MC_CMD_SENSOR_SET_LIMS_IN_LOW0_LEN 4
-/* interpretation is is sensor-specific. */
+/* interpretation is sensor-specific. */
 #define       MC_CMD_SENSOR_SET_LIMS_IN_HI0_OFST 8
 #define       MC_CMD_SENSOR_SET_LIMS_IN_HI0_LEN 4
-/* interpretation is is sensor-specific. */
+/* interpretation is sensor-specific. */
 #define       MC_CMD_SENSOR_SET_LIMS_IN_LOW1_OFST 12
 #define       MC_CMD_SENSOR_SET_LIMS_IN_LOW1_LEN 4
-/* interpretation is is sensor-specific. */
+/* interpretation is sensor-specific. */
 #define       MC_CMD_SENSOR_SET_LIMS_IN_HI1_OFST 16
 #define       MC_CMD_SENSOR_SET_LIMS_IN_HI1_LEN 4
 
@@ -7823,7 +7823,7 @@
  * handles as returned by MC_CMD_DYNAMIC_SENSORS_LIST
  *
  * Any handles which do not correspond to a sensor currently managed by the MC
- * will be dropped from from the response. This may happen when a sensor table
+ * will be dropped from the response. This may happen when a sensor table
  * update is in progress, and effectively means the set of usable sensors is
  * the intersection between the sets of sensors known to the driver and the MC.
  *
@@ -7872,7 +7872,7 @@
  * provided should be treated as erroneous.
  *
  * Any handles which do not correspond to a sensor currently managed by the MC
- * will be dropped from from the response. This may happen when a sensor table
+ * will be dropped from the response. This may happen when a sensor table
  * update is in progress, and effectively means the set of usable sensors is
  * the intersection between the sets of sensors known to the driver and the MC.
  *
diff --git a/drivers/net/ethernet/sfc/tc_encap_actions.c b/drivers/net/ethernet/sfc/tc_encap_actions.c
index 87443f9dfd22..2258f854e5be 100644
--- a/drivers/net/ethernet/sfc/tc_encap_actions.c
+++ b/drivers/net/ethernet/sfc/tc_encap_actions.c
@@ -442,7 +442,7 @@ static void efx_tc_update_encap(struct efx_nic *efx,
 			rule = container_of(acts, struct efx_tc_flow_rule, acts);
 			if (rule->fallback)
 				fallback = rule->fallback;
-			else /* fallback fallback: deliver to PF */
+			else /* fallback: deliver to PF */
 				fallback = &efx->tc->facts.pf;
 			rc = efx_mae_update_rule(efx, fallback->fw_id,
 						 rule->fw_id);
diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index 2e1106097965..6ca290f7c0df 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -2350,7 +2350,7 @@ static void smsc911x_drv_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 }
 
-/* standard register acces */
+/* standard register access */
 static const struct smsc911x_ops standard_smsc911x_ops = {
 	.reg_read = __smsc911x_reg_read,
 	.reg_write = __smsc911x_reg_write,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 38b1c04c92a2..030fcf1b5993 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -60,7 +60,7 @@ static int dwmac1000_validate_mcast_bins(struct device *dev, int mcast_bins)
  * Description:
  * This function validates the number of Unicast address entries supported
  * by a particular Synopsys 10/100/1000 controller. The Synopsys controller
- * supports 1..32, 64, or 128 Unicast filter entries for it's Unicast filter
+ * supports 1..32, 64, or 128 Unicast filter entries for its Unicast filter
  * logic. This function validates a valid, supported configuration is
  * selected, and defaults to 1 Unicast address if an unsupported
  * configuration is selected.
diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index 67625fb12101..893216b0e08d 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -5825,7 +5825,7 @@ static int niu_init_mac(struct niu *np)
 	/* This looks hookey but the RX MAC reset we just did will
 	 * undo some of the state we setup in niu_init_tx_mac() so we
 	 * have to call it again.  In particular, the RX MAC reset will
-	 * set the XMAC_MAX register back to it's default value.
+	 * set the XMAC_MAX register back to its default value.
 	 */
 	niu_init_tx_mac(np);
 	niu_enable_tx_mac(np, 1);
diff --git a/drivers/net/ethernet/sun/niu.h b/drivers/net/ethernet/sun/niu.h
index 0b169c08b0f2..d8368043fc3b 100644
--- a/drivers/net/ethernet/sun/niu.h
+++ b/drivers/net/ethernet/sun/niu.h
@@ -3250,8 +3250,8 @@ struct niu {
 	struct niu_parent		*parent;
 
 	u32				flags;
-#define NIU_FLAGS_HOTPLUG_PHY_PRESENT	0x02000000 /* Removeable PHY detected*/
-#define NIU_FLAGS_HOTPLUG_PHY		0x01000000 /* Removeable PHY */
+#define NIU_FLAGS_HOTPLUG_PHY_PRESENT	0x02000000 /* Removable PHY detected*/
+#define NIU_FLAGS_HOTPLUG_PHY		0x01000000 /* Removable PHY */
 #define NIU_FLAGS_VPD_VALID		0x00800000 /* VPD has valid version */
 #define NIU_FLAGS_MSIX			0x00400000 /* MSI-X in use */
 #define NIU_FLAGS_MCAST			0x00200000 /* multicast filter enabled */
diff --git a/drivers/net/ethernet/sun/sunhme.c b/drivers/net/ethernet/sun/sunhme.c
index 4bc0e114d5ee..48f0a96c0e9e 100644
--- a/drivers/net/ethernet/sun/sunhme.c
+++ b/drivers/net/ethernet/sun/sunhme.c
@@ -451,7 +451,7 @@ static void happy_meal_tcvr_write(struct happy_meal *hp,
 /* Auto negotiation.  The scheme is very simple.  We have a timer routine
  * that keeps watching the auto negotiation process as it progresses.
  * The DP83840 is first told to start doing it's thing, we set up the time
- * and place the timer state machine in it's initial state.
+ * and place the timer state machine in its initial state.
  *
  * Here the timer peeks at the DP83840 status registers at each click to see
  * if the auto negotiation has completed, we assume here that the DP83840 PHY
diff --git a/drivers/net/ethernet/sun/sunqe.h b/drivers/net/ethernet/sun/sunqe.h
index 0daed05b7c83..300631e8ac0d 100644
--- a/drivers/net/ethernet/sun/sunqe.h
+++ b/drivers/net/ethernet/sun/sunqe.h
@@ -36,7 +36,7 @@
 #define GLOB_PSIZE_6144       0x10       /* 6k packet size           */
 #define GLOB_PSIZE_8192       0x11       /* 8k packet size           */
 
-/* In MACE mode, there are four qe channels.  Each channel has it's own
+/* In MACE mode, there are four qe channels.  Each channel has its own
  * status bits in the QEC status register.  This macro picks out the
  * ones you want.
  */
diff --git a/drivers/net/ethernet/tehuti/tehuti.c b/drivers/net/ethernet/tehuti/tehuti.c
index fc77f424f90b..2cee1f05ac47 100644
--- a/drivers/net/ethernet/tehuti/tehuti.c
+++ b/drivers/net/ethernet/tehuti/tehuti.c
@@ -276,7 +276,7 @@ static irqreturn_t bdx_isr_napi(int irq, void *dev)
 			 * currently intrs are disabled (since we read ISR),
 			 * and we have failed to register next poll.
 			 * so we read the regs to trigger chip
-			 * and allow further interupts. */
+			 * and allow further interrupts. */
 			READ_REG(priv, regTXF_WPTR_0);
 			READ_REG(priv, regRXD_WPTR_0);
 		}
-- 
2.43.0


