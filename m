Return-Path: <netdev+bounces-172979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A119CA56AFE
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 15:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27F03177C5A
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 14:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E86211464;
	Fri,  7 Mar 2025 14:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aq0.de header.i=@aq0.de header.b="lnS0OeB3"
X-Original-To: netdev@vger.kernel.org
Received: from mail.aq0.de (mail.aq0.de [168.119.229.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4384121C9EA
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 14:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.229.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741359521; cv=none; b=WeU/Gy1sqt4pz6M0SKd1XzUGGPPGf4byu1CHatDknlZ1cOvKnsjO50IINO5YpMqTgZjYZhmBqWKROGFiogfXRChXr4MGZuk+8+dna579OxazzW5YmUSnyh2xQFXvqZb+8NJsA6tBxCyJ5SOggvb9fHZC3t8ZSIo2K6L0C220Pus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741359521; c=relaxed/simple;
	bh=HRGVLjkSnh+S9QzfqOAkqa3x7GxtwbyNjNcdKTXmmyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wv9O7QKJ8pesvhgMzXgUXuSLzTZFGWot8OwSv8kOToK0//Tc2J+CfQEhnR4jwO1qv4Yj1KLkVGWPEm1x9zOod9ZqeDRIeyci4LBnGQFd3ooMqGQoQUif3J4Sp2gD8pV4beQXWia155LkFfj8t1n1Vtn/lsqeb4eDOWBxpw5PReI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aq0.de; spf=pass smtp.mailfrom=aq0.de; dkim=pass (1024-bit key) header.d=aq0.de header.i=@aq0.de header.b=lnS0OeB3; arc=none smtp.client-ip=168.119.229.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aq0.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aq0.de
From: Janik Haag <janik@aq0.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aq0.de; s=mail;
	t=1741359509; bh=kDAC2tiWrl+98Bp/dv82iXoQYAbWKIe8E4fpflu59us=;
	h=From:To:Cc:Subject:Date;
	b=lnS0OeB32xbpnwKo8mcNJN4OLpwCosTGRxvZnz7TgRpRh2Yv4yN05XigmBFGu84EB
	 7lAcfUkB7+SJZs5GG9eR36VkZ2jkc0hk8wj35szLyWfeow7APv4IdbmXifP5bs7MD1
	 4K1Ns9YsfovBa+ksd/7vpKqLKWTCmMYyuSvHaDpo=
To: horms@kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	Janik Haag <janik@aq0.de>
Subject: [PATCH net-next v2] net: cn23xx: fix typos
Date: Fri,  7 Mar 2025 15:56:49 +0100
Message-ID: <20250307145648.1679912-2-janik@aq0.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes a few typos, spelling mistakes, and a bit of grammar,
increasing the comments readability.

Signed-off-by: Janik Haag <janik@aq0.de>
---
 .../cavium/liquidio/cn23xx_pf_device.c        | 76 +++++++++----------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
index 9ad49aea2673..ff8f2f9f9cae 100644
--- a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
+++ b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
@@ -49,7 +49,7 @@ static int cn23xx_pf_soft_reset(struct octeon_device *oct)
 	lio_pci_readq(oct, CN23XX_RST_SOFT_RST);
 	lio_pci_writeq(oct, 1, CN23XX_RST_SOFT_RST);
 
-	/* Wait for 100ms as Octeon resets. */
+	/* Wait for 100ms as Octeon resets */
 	mdelay(100);
 
 	if (octeon_read_csr64(oct, CN23XX_SLI_SCRATCH1)) {
@@ -61,7 +61,7 @@ static int cn23xx_pf_soft_reset(struct octeon_device *oct)
 	dev_dbg(&oct->pci_dev->dev, "OCTEON[%d]: Reset completed\n",
 		oct->octeon_id);
 
-	/* restore the  reset value*/
+	/* Restore the reset value */
 	octeon_write_csr64(oct, CN23XX_WIN_WR_MASK_REG, 0xFF);
 
 	return 0;
@@ -121,7 +121,7 @@ u32 cn23xx_pf_get_oq_ticks(struct octeon_device *oct, u32 time_intr_in_us)
 	oqticks_per_us /= 1024;
 
 	/* time_intr is in microseconds. The next 2 steps gives the oq ticks
-	 *  corressponding to time_intr.
+	 * corresponding to time_intr.
 	 */
 	oqticks_per_us *= time_intr_in_us;
 	oqticks_per_us /= 1000;
@@ -136,11 +136,11 @@ static void cn23xx_setup_global_mac_regs(struct octeon_device *oct)
 	u64 reg_val;
 	u64 temp;
 
-	/* programming SRN and TRS for each MAC(0..3)  */
+	/* Programming SRN and TRS for each MAC(0..3) */
 
 	dev_dbg(&oct->pci_dev->dev, "%s:Using pcie port %d\n",
 		__func__, mac_no);
-	/* By default, mapping all 64 IOQs to  a single MACs */
+	/* By default, map all 64 IOQs to a single MAC */
 
 	reg_val =
 	    octeon_read_csr64(oct, CN23XX_SLI_PKT_MAC_RINFO64(mac_no, pf_num));
@@ -164,7 +164,7 @@ static void cn23xx_setup_global_mac_regs(struct octeon_device *oct)
 	temp = oct->sriov_info.max_vfs & 0xff;
 	reg_val |= (temp << CN23XX_PKT_MAC_CTL_RINFO_NVFS_BIT_POS);
 
-	/* write these settings to MAC register */
+	/* Write these settings to MAC register */
 	octeon_write_csr64(oct, CN23XX_SLI_PKT_MAC_RINFO64(mac_no, pf_num),
 			   reg_val);
 
@@ -183,10 +183,10 @@ static int cn23xx_reset_io_queues(struct octeon_device *oct)
 	srn = oct->sriov_info.pf_srn;
 	ern = srn + oct->sriov_info.num_pf_rings;
 
-	/*As per HRM reg description, s/w cant write 0 to ENB. */
-	/*to make the queue off, need to set the RST bit. */
+	/* As per HRM reg description, s/w can't write 0 to ENB. */
+	/* We need to set the RST bit, to turn the queue off. */
 
-	/* Reset the Enable bit for all the 64 IQs.  */
+	/* Reset the enable bit for all the 64 IQs. */
 	for (q_no = srn; q_no < ern; q_no++) {
 		/* set RST bit to 1. This bit applies to both IQ and OQ */
 		d64 = octeon_read_csr64(oct, CN23XX_SLI_IQ_PKT_CONTROL64(q_no));
@@ -194,7 +194,7 @@ static int cn23xx_reset_io_queues(struct octeon_device *oct)
 		octeon_write_csr64(oct, CN23XX_SLI_IQ_PKT_CONTROL64(q_no), d64);
 	}
 
-	/*wait until the RST bit is clear or the RST and quite bits are set*/
+	/* Wait until the RST bit is clear or the RST and quiet bits are set */
 	for (q_no = srn; q_no < ern; q_no++) {
 		u64 reg_val = octeon_read_csr64(oct,
 					CN23XX_SLI_IQ_PKT_CONTROL64(q_no));
@@ -245,15 +245,15 @@ static int cn23xx_pf_setup_global_input_regs(struct octeon_device *oct)
 	if (cn23xx_reset_io_queues(oct))
 		return -1;
 
-	/** Set the MAC_NUM and PVF_NUM in IQ_PKT_CONTROL reg
-	 * for all queues.Only PF can set these bits.
+	/* Set the MAC_NUM and PVF_NUM in IQ_PKT_CONTROL reg
+	 * for all queues. Only PF can set these bits.
 	 * bits 29:30 indicate the MAC num.
 	 * bits 32:47 indicate the PVF num.
 	 */
 	for (q_no = 0; q_no < ern; q_no++) {
 		reg_val = (u64)oct->pcie_port << CN23XX_PKT_INPUT_CTL_MAC_NUM_POS;
 
-		/* for VF assigned queues. */
+		/* For VF assigned queues. */
 		if (q_no < oct->sriov_info.pf_srn) {
 			vf_num = q_no / oct->sriov_info.rings_per_vf;
 			vf_num += 1; /* VF1, VF2,........ */
@@ -268,7 +268,7 @@ static int cn23xx_pf_setup_global_input_regs(struct octeon_device *oct)
 				   reg_val);
 	}
 
-	/* Select ES, RO, NS, RDSIZE,DPTR Fomat#0 for
+	/* Select ES, RO, NS, RDSIZE,DPTR Format#0 for
 	 * pf queues
 	 */
 	for (q_no = srn; q_no < ern; q_no++) {
@@ -289,7 +289,7 @@ static int cn23xx_pf_setup_global_input_regs(struct octeon_device *oct)
 		octeon_write_csr64(oct, CN23XX_SLI_IQ_PKT_CONTROL64(q_no),
 				   reg_val);
 
-		/* Set WMARK level for triggering PI_INT */
+		/* Set WMARK level to trigger PI_INT */
 		/* intr_threshold = CN23XX_DEF_IQ_INTR_THRESHOLD & */
 		intr_threshold = CFG_GET_IQ_INTR_PKT(cn23xx->conf) &
 				 CN23XX_PKT_IN_DONE_WMARK_MASK;
@@ -354,7 +354,7 @@ static void cn23xx_pf_setup_global_output_regs(struct octeon_device *oct)
 		/* set the ES bit */
 		reg_val |= (CN23XX_PKT_OUTPUT_CTL_ES);
 
-		/* write all the selected settings */
+		/* Write all the selected settings */
 		octeon_write_csr(oct, CN23XX_SLI_OQ_PKT_CONTROL(q_no), reg_val);
 
 		/* Enabling these interrupt in oct->fn_list.enable_interrupt()
@@ -373,7 +373,7 @@ static void cn23xx_pf_setup_global_output_regs(struct octeon_device *oct)
 	/** Setting the water mark level for pko back pressure **/
 	writeq(0x40, (u8 *)oct->mmio[0].hw_addr + CN23XX_SLI_OQ_WMARK);
 
-	/** Disabling setting OQs in reset when ring has no dorebells
+	/* Disabling setting OQs in reset when ring has no doorbells
 	 * enabling this will cause of head of line blocking
 	 */
 	/* Do it only for pass1.1. and pass1.2 */
@@ -383,7 +383,7 @@ static void cn23xx_pf_setup_global_output_regs(struct octeon_device *oct)
 				     CN23XX_SLI_GBL_CONTROL) | 0x2,
 		       (u8 *)oct->mmio[0].hw_addr + CN23XX_SLI_GBL_CONTROL);
 
-	/** Enable channel-level backpressure */
+	/** Enable channel-level backpressure **/
 	if (oct->pf_num)
 		writeq(0xffffffffffffffffULL,
 		       (u8 *)oct->mmio[0].hw_addr + CN23XX_SLI_OUT_BP_EN2_W1S);
@@ -396,7 +396,7 @@ static int cn23xx_setup_pf_device_regs(struct octeon_device *oct)
 {
 	cn23xx_enable_error_reporting(oct);
 
-	/* program the MAC(0..3)_RINFO before setting up input/output regs */
+	/* Program the MAC(0..3)_RINFO before setting up input/output regs */
 	cn23xx_setup_global_mac_regs(oct);
 
 	if (cn23xx_pf_setup_global_input_regs(oct))
@@ -410,7 +410,7 @@ static int cn23xx_setup_pf_device_regs(struct octeon_device *oct)
 	octeon_write_csr64(oct, CN23XX_SLI_WINDOW_CTL,
 			   CN23XX_SLI_WINDOW_CTL_DEFAULT);
 
-	/* set SLI_PKT_IN_JABBER to handle large VXLAN packets */
+	/* Set SLI_PKT_IN_JABBER to handle large VXLAN packets */
 	octeon_write_csr64(oct, CN23XX_SLI_PKT_IN_JABBER, CN23XX_INPUT_JABBER);
 	return 0;
 }
@@ -574,7 +574,7 @@ static int cn23xx_setup_pf_mbox(struct octeon_device *oct)
 		mbox->mbox_read_reg = (u8 *)oct->mmio[0].hw_addr +
 				      CN23XX_SLI_PKT_PF_VF_MBOX_SIG(q_no, 1);
 
-		/*Mail Box Thread creation*/
+		/* Mail Box Thread creation */
 		INIT_DELAYED_WORK(&mbox->mbox_poll_wk.work,
 				  cn23xx_pf_mbox_thread);
 		mbox->mbox_poll_wk.ctxptr = (void *)mbox;
@@ -626,7 +626,7 @@ static int cn23xx_enable_io_queues(struct octeon_device *oct)
 	ern = srn + oct->num_iqs;
 
 	for (q_no = srn; q_no < ern; q_no++) {
-		/* set the corresponding IQ IS_64B bit */
+		/* Set the corresponding IQ IS_64B bit */
 		if (oct->io_qmask.iq64B & BIT_ULL(q_no - srn)) {
 			reg_val = octeon_read_csr64(
 			    oct, CN23XX_SLI_IQ_PKT_CONTROL64(q_no));
@@ -635,7 +635,7 @@ static int cn23xx_enable_io_queues(struct octeon_device *oct)
 			    oct, CN23XX_SLI_IQ_PKT_CONTROL64(q_no), reg_val);
 		}
 
-		/* set the corresponding IQ ENB bit */
+		/* Set the corresponding IQ ENB bit */
 		if (oct->io_qmask.iq & BIT_ULL(q_no - srn)) {
 			/* IOQs are in reset by default in PEM2 mode,
 			 * clearing reset bit
@@ -681,7 +681,7 @@ static int cn23xx_enable_io_queues(struct octeon_device *oct)
 	}
 	for (q_no = srn; q_no < ern; q_no++) {
 		u32 reg_val;
-		/* set the corresponding OQ ENB bit */
+		/* Set the corresponding OQ ENB bit */
 		if (oct->io_qmask.oq & BIT_ULL(q_no - srn)) {
 			reg_val = octeon_read_csr(
 			    oct, CN23XX_SLI_OQ_PKT_CONTROL(q_no));
@@ -707,7 +707,7 @@ static void cn23xx_disable_io_queues(struct octeon_device *oct)
 	for (q_no = srn; q_no < ern; q_no++) {
 		loop = HZ;
 
-		/* start the Reset for a particular ring */
+		/* Start the Reset for a particular ring */
 		WRITE_ONCE(d64, octeon_read_csr64(
 			   oct, CN23XX_SLI_IQ_PKT_CONTROL64(q_no)));
 		WRITE_ONCE(d64, READ_ONCE(d64) &
@@ -740,7 +740,7 @@ static void cn23xx_disable_io_queues(struct octeon_device *oct)
 		loop = HZ;
 
 		/* Wait until hardware indicates that the particular IQ
-		 * is out of reset.It given that SLI_PKT_RING_RST is
+		 * is out of reset. Given that SLI_PKT_RING_RST is
 		 * common for both IQs and OQs
 		 */
 		WRITE_ONCE(d64, octeon_read_csr64(
@@ -760,7 +760,7 @@ static void cn23xx_disable_io_queues(struct octeon_device *oct)
 			schedule_timeout_uninterruptible(1);
 		}
 
-		/* clear the SLI_PKT(0..63)_CNTS[CNT] reg value */
+		/* Clear the SLI_PKT(0..63)_CNTS[CNT] reg value */
 		WRITE_ONCE(d32, octeon_read_csr(
 					oct, CN23XX_SLI_OQ_PKTS_SENT(q_no)));
 		octeon_write_csr(oct, CN23XX_SLI_OQ_PKTS_SENT(q_no),
@@ -793,7 +793,7 @@ static u64 cn23xx_pf_msix_interrupt_handler(void *dev)
 	if (!pkts_sent || (pkts_sent == 0xFFFFFFFFFFFFFFFFULL))
 		return ret;
 
-	/* Write count reg in sli_pkt_cnts to clear these int.*/
+	/* Write count reg in sli_pkt_cnts to clear these int. */
 	if ((pkts_sent & CN23XX_INTR_PO_INT) ||
 	    (pkts_sent & CN23XX_INTR_PI_INT)) {
 		if (pkts_sent & CN23XX_INTR_PO_INT)
@@ -908,7 +908,7 @@ static u32 cn23xx_bar1_idx_read(struct octeon_device *oct, u32 idx)
 	    oct, CN23XX_PEM_BAR1_INDEX_REG(oct->pcie_port, idx));
 }
 
-/* always call with lock held */
+/* Always call with lock held */
 static u32 cn23xx_update_read_index(struct octeon_instr_queue *iq)
 {
 	u32 new_idx;
@@ -919,7 +919,7 @@ static u32 cn23xx_update_read_index(struct octeon_instr_queue *iq)
 	iq->pkt_in_done = pkt_in_done;
 
 	/* Modulo of the new index with the IQ size will give us
-	 * the new index.  The iq->reset_instr_cnt is always zero for
+	 * the new index. The iq->reset_instr_cnt is always zero for
 	 * cn23xx, so no extra adjustments are needed.
 	 */
 	new_idx = (iq->octeon_read_index +
@@ -934,8 +934,8 @@ static void cn23xx_enable_pf_interrupt(struct octeon_device *oct, u8 intr_flag)
 	struct octeon_cn23xx_pf *cn23xx = (struct octeon_cn23xx_pf *)oct->chip;
 	u64 intr_val = 0;
 
-	/*  Divide the single write to multiple writes based on the flag. */
-	/* Enable Interrupt */
+	/* Divide the single write to multiple writes based on the flag. */
+	/* Enable Interrupts */
 	if (intr_flag == OCTEON_ALL_INTR) {
 		writeq(cn23xx->intr_mask64, cn23xx->intr_enb_reg64);
 	} else if (intr_flag & OCTEON_OUTPUT_INTR) {
@@ -990,7 +990,7 @@ static int cn23xx_get_pf_num(struct octeon_device *oct)
 
 	ret = 0;
 
-	/** Read Function Dependency Link reg to get the function number */
+	/* Read Function Dependency Link reg to get the function number */
 	if (pci_read_config_dword(oct->pci_dev, CN23XX_PCIE_SRIOV_FDL,
 				  &fdl_bit) == 0) {
 		oct->pf_num = ((fdl_bit >> CN23XX_PCIE_SRIOV_FDL_BIT_POS) &
@@ -1003,13 +1003,13 @@ static int cn23xx_get_pf_num(struct octeon_device *oct)
 		 * In this case, read the PF number from the
 		 * SLI_PKT0_INPUT_CONTROL reg (written by f/w)
 		 */
-		pkt0_in_ctl = octeon_read_csr64(oct,
-						CN23XX_SLI_IQ_PKT_CONTROL64(0));
+		pkt0_in_ctl =
+			octeon_read_csr64(oct, CN23XX_SLI_IQ_PKT_CONTROL64(0));
 		pfnum = (pkt0_in_ctl >> CN23XX_PKT_INPUT_CTL_PF_NUM_POS) &
 			CN23XX_PKT_INPUT_CTL_PF_NUM_MASK;
 		mac = (octeon_read_csr(oct, CN23XX_SLI_MAC_NUMBER)) & 0xff;
 
-		/* validate PF num by reading RINFO; f/w writes RINFO.trs == 1*/
+		/* Validate PF num by reading RINFO; f/w writes RINFO.trs == 1 */
 		d64 = octeon_read_csr64(oct,
 					CN23XX_SLI_PKT_MAC_RINFO64(mac, pfnum));
 		trs = (int)(d64 >> CN23XX_PKT_MAC_CTL_RINFO_TRS_BIT_POS) & 0xff;
@@ -1252,9 +1252,9 @@ int cn23xx_fw_loaded(struct octeon_device *oct)
 	u64 val;
 
 	/* If there's more than one active PF on this NIC, then that
-	 * implies that the NIC firmware is loaded and running.  This check
+	 * implies that the NIC firmware is loaded and running. This check
 	 * prevents a rare false negative that might occur if we only relied
-	 * on checking the SCR2_BIT_FW_LOADED flag.  The false negative would
+	 * on checking the SCR2_BIT_FW_LOADED flag. The false negative would
 	 * happen if the PF driver sees SCR2_BIT_FW_LOADED as cleared even
 	 * though the firmware was already loaded but still booting and has yet
 	 * to set SCR2_BIT_FW_LOADED.

base-commit: 99fa936e8e4f117d62f229003c9799686f74cebc
-- 
2.48.1


