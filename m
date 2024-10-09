Return-Path: <netdev+bounces-133383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09074995C5C
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 02:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4B6B286541
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 00:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD45D3C24;
	Wed,  9 Oct 2024 00:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="nMLWrDcL"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA01F6FC3;
	Wed,  9 Oct 2024 00:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728434331; cv=none; b=gXrRuEU1h6BJiJ2xbZPrEDbtKdBLW/Lkin5Ady2JWFaVkfK5ofWRSdCec9rBDthg2A8VG6GyLo33uT4336d1WVxJalIE62yS7GMhSTNvgSOowjnQeixtymVHrLBK37tFgtxuGmbSyGbeOLbWgetznrY4dSyHRipyatBsoTEVOEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728434331; c=relaxed/simple;
	bh=FNiGcNDdWZAfqdOlNLP8MEL4gG75wdC6blEwsW0IXF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=grjgEWaim4mP0m0Zc/3Jx0RoRO0GsNO9nGfIFucR3wuBiYFuwCKTlH+ZtSQ4a0L4px+20Irt6v6K76ayFq53izYsAJdqMYcuhbsFbWMQzxettKf/ErPBh0nw6S/OKbmHxA2uCZuJH+aV8/BapviDjB42JGNdlQpPTh6zAY2OBQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=nMLWrDcL; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=Y9ujbLGcNFl7q8q9tH5BMo3oqehtyT+2F1O/LhXoBoM=; b=nMLWrDcLoixfAuLS
	RRgIo5tdo4r9N0P525la1hceb0TW5HBIqxAoZ8Cu1cX6EuHvEOJ21A6PMIT6JSoiat+gbU1UCv2aJ
	uz27y/Fjcs5TEWIlBauZOIgNzl2LR3R8SXYgeA3uDCD2xAWUc2HRYrvCPQCZZSZwRE/EYU1sxZBur
	RsS1omPRRYfcBzOKYVU/hu1cy1NM6ayLLJxFG2/mXYW7iShZR7RF3ylAaTHVO6REZth3cdDqxzjx+
	h7Fkz4l753bHqRl17cxu3sv0H2XP0YHj+eqLFqKIfzg6Jci256gTFDNFATQy93/RqYOtPeFUPcUun
	7f9insdf00TuaO2RLA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1syKiw-009q6V-1r;
	Wed, 09 Oct 2024 00:38:42 +0000
From: linux@treblig.org
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next] net: liquidio: Remove unused cn23xx_dump_pf_initialized_regs
Date: Wed,  9 Oct 2024 01:38:41 +0100
Message-ID: <20241009003841.254853-1-linux@treblig.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

cn23xx_dump_pf_initialized_regs() was added in 2016's commit
72c0091293c0 ("liquidio: CN23XX device init and sriov config")

but hasn't been used.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 .../cavium/liquidio/cn23xx_pf_device.c        | 169 ------------------
 .../cavium/liquidio/cn23xx_pf_device.h        |   2 -
 2 files changed, 171 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
index b3c81a2e9d46..9ad49aea2673 100644
--- a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
+++ b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
@@ -36,175 +36,6 @@
  */
 #define CN23XX_INPUT_JABBER 64600
 
-void cn23xx_dump_pf_initialized_regs(struct octeon_device *oct)
-{
-	int i = 0;
-	u32 regval = 0;
-	struct octeon_cn23xx_pf *cn23xx = (struct octeon_cn23xx_pf *)oct->chip;
-
-	/*In cn23xx_soft_reset*/
-	dev_dbg(&oct->pci_dev->dev, "%s[%llx] : 0x%llx\n",
-		"CN23XX_WIN_WR_MASK_REG", CVM_CAST64(CN23XX_WIN_WR_MASK_REG),
-		CVM_CAST64(octeon_read_csr64(oct, CN23XX_WIN_WR_MASK_REG)));
-	dev_dbg(&oct->pci_dev->dev, "%s[%llx] : 0x%016llx\n",
-		"CN23XX_SLI_SCRATCH1", CVM_CAST64(CN23XX_SLI_SCRATCH1),
-		CVM_CAST64(octeon_read_csr64(oct, CN23XX_SLI_SCRATCH1)));
-	dev_dbg(&oct->pci_dev->dev, "%s[%llx] : 0x%016llx\n",
-		"CN23XX_RST_SOFT_RST", CN23XX_RST_SOFT_RST,
-		lio_pci_readq(oct, CN23XX_RST_SOFT_RST));
-
-	/*In cn23xx_set_dpi_regs*/
-	dev_dbg(&oct->pci_dev->dev, "%s[%llx] : 0x%016llx\n",
-		"CN23XX_DPI_DMA_CONTROL", CN23XX_DPI_DMA_CONTROL,
-		lio_pci_readq(oct, CN23XX_DPI_DMA_CONTROL));
-
-	for (i = 0; i < 6; i++) {
-		dev_dbg(&oct->pci_dev->dev, "%s(%d)[%llx] : 0x%016llx\n",
-			"CN23XX_DPI_DMA_ENG_ENB", i,
-			CN23XX_DPI_DMA_ENG_ENB(i),
-			lio_pci_readq(oct, CN23XX_DPI_DMA_ENG_ENB(i)));
-		dev_dbg(&oct->pci_dev->dev, "%s(%d)[%llx] : 0x%016llx\n",
-			"CN23XX_DPI_DMA_ENG_BUF", i,
-			CN23XX_DPI_DMA_ENG_BUF(i),
-			lio_pci_readq(oct, CN23XX_DPI_DMA_ENG_BUF(i)));
-	}
-
-	dev_dbg(&oct->pci_dev->dev, "%s[%llx] : 0x%016llx\n", "CN23XX_DPI_CTL",
-		CN23XX_DPI_CTL, lio_pci_readq(oct, CN23XX_DPI_CTL));
-
-	/*In cn23xx_setup_pcie_mps and cn23xx_setup_pcie_mrrs */
-	pci_read_config_dword(oct->pci_dev, CN23XX_CONFIG_PCIE_DEVCTL, &regval);
-	dev_dbg(&oct->pci_dev->dev, "%s[%llx] : 0x%016llx\n",
-		"CN23XX_CONFIG_PCIE_DEVCTL",
-		CVM_CAST64(CN23XX_CONFIG_PCIE_DEVCTL), CVM_CAST64(regval));
-
-	dev_dbg(&oct->pci_dev->dev, "%s(%d)[%llx] : 0x%016llx\n",
-		"CN23XX_DPI_SLI_PRTX_CFG", oct->pcie_port,
-		CN23XX_DPI_SLI_PRTX_CFG(oct->pcie_port),
-		lio_pci_readq(oct, CN23XX_DPI_SLI_PRTX_CFG(oct->pcie_port)));
-
-	/*In cn23xx_specific_regs_setup */
-	dev_dbg(&oct->pci_dev->dev, "%s(%d)[%llx] : 0x%016llx\n",
-		"CN23XX_SLI_S2M_PORTX_CTL", oct->pcie_port,
-		CVM_CAST64(CN23XX_SLI_S2M_PORTX_CTL(oct->pcie_port)),
-		CVM_CAST64(octeon_read_csr64(
-			oct, CN23XX_SLI_S2M_PORTX_CTL(oct->pcie_port))));
-
-	dev_dbg(&oct->pci_dev->dev, "%s[%llx] : 0x%016llx\n",
-		"CN23XX_SLI_RING_RST", CVM_CAST64(CN23XX_SLI_PKT_IOQ_RING_RST),
-		(u64)octeon_read_csr64(oct, CN23XX_SLI_PKT_IOQ_RING_RST));
-
-	/*In cn23xx_setup_global_mac_regs*/
-	for (i = 0; i < CN23XX_MAX_MACS; i++) {
-		dev_dbg(&oct->pci_dev->dev, "%s(%d)[%llx] : 0x%016llx\n",
-			"CN23XX_SLI_PKT_MAC_RINFO64", i,
-			CVM_CAST64(CN23XX_SLI_PKT_MAC_RINFO64(i, oct->pf_num)),
-			CVM_CAST64(octeon_read_csr64
-				(oct, CN23XX_SLI_PKT_MAC_RINFO64
-					(i, oct->pf_num))));
-	}
-
-	/*In cn23xx_setup_global_input_regs*/
-	for (i = 0; i < CN23XX_MAX_INPUT_QUEUES; i++) {
-		dev_dbg(&oct->pci_dev->dev, "%s(%d)[%llx] : 0x%016llx\n",
-			"CN23XX_SLI_IQ_PKT_CONTROL64", i,
-			CVM_CAST64(CN23XX_SLI_IQ_PKT_CONTROL64(i)),
-			CVM_CAST64(octeon_read_csr64
-				(oct, CN23XX_SLI_IQ_PKT_CONTROL64(i))));
-	}
-
-	/*In cn23xx_setup_global_output_regs*/
-	dev_dbg(&oct->pci_dev->dev, "%s[%llx] : 0x%016llx\n",
-		"CN23XX_SLI_OQ_WMARK", CVM_CAST64(CN23XX_SLI_OQ_WMARK),
-		CVM_CAST64(octeon_read_csr64(oct, CN23XX_SLI_OQ_WMARK)));
-
-	for (i = 0; i < CN23XX_MAX_OUTPUT_QUEUES; i++) {
-		dev_dbg(&oct->pci_dev->dev, "%s(%d)[%llx] : 0x%016llx\n",
-			"CN23XX_SLI_OQ_PKT_CONTROL", i,
-			CVM_CAST64(CN23XX_SLI_OQ_PKT_CONTROL(i)),
-			CVM_CAST64(octeon_read_csr(
-				oct, CN23XX_SLI_OQ_PKT_CONTROL(i))));
-		dev_dbg(&oct->pci_dev->dev, "%s(%d)[%llx] : 0x%016llx\n",
-			"CN23XX_SLI_OQ_PKT_INT_LEVELS", i,
-			CVM_CAST64(CN23XX_SLI_OQ_PKT_INT_LEVELS(i)),
-			CVM_CAST64(octeon_read_csr64(
-				oct, CN23XX_SLI_OQ_PKT_INT_LEVELS(i))));
-	}
-
-	/*In cn23xx_enable_interrupt and cn23xx_disable_interrupt*/
-	dev_dbg(&oct->pci_dev->dev, "%s[%llx] : 0x%016llx\n",
-		"cn23xx->intr_enb_reg64",
-		CVM_CAST64((long)(cn23xx->intr_enb_reg64)),
-		CVM_CAST64(readq(cn23xx->intr_enb_reg64)));
-
-	dev_dbg(&oct->pci_dev->dev, "%s[%llx] : 0x%016llx\n",
-		"cn23xx->intr_sum_reg64",
-		CVM_CAST64((long)(cn23xx->intr_sum_reg64)),
-		CVM_CAST64(readq(cn23xx->intr_sum_reg64)));
-
-	/*In cn23xx_setup_iq_regs*/
-	for (i = 0; i < CN23XX_MAX_INPUT_QUEUES; i++) {
-		dev_dbg(&oct->pci_dev->dev, "%s(%d)[%llx] : 0x%016llx\n",
-			"CN23XX_SLI_IQ_BASE_ADDR64", i,
-			CVM_CAST64(CN23XX_SLI_IQ_BASE_ADDR64(i)),
-			CVM_CAST64(octeon_read_csr64(
-				oct, CN23XX_SLI_IQ_BASE_ADDR64(i))));
-		dev_dbg(&oct->pci_dev->dev, "%s(%d)[%llx] : 0x%016llx\n",
-			"CN23XX_SLI_IQ_SIZE", i,
-			CVM_CAST64(CN23XX_SLI_IQ_SIZE(i)),
-			CVM_CAST64(octeon_read_csr
-				(oct, CN23XX_SLI_IQ_SIZE(i))));
-		dev_dbg(&oct->pci_dev->dev, "%s(%d)[%llx] : 0x%016llx\n",
-			"CN23XX_SLI_IQ_DOORBELL", i,
-			CVM_CAST64(CN23XX_SLI_IQ_DOORBELL(i)),
-			CVM_CAST64(octeon_read_csr64(
-				oct, CN23XX_SLI_IQ_DOORBELL(i))));
-		dev_dbg(&oct->pci_dev->dev, "%s(%d)[%llx] : 0x%016llx\n",
-			"CN23XX_SLI_IQ_INSTR_COUNT64", i,
-			CVM_CAST64(CN23XX_SLI_IQ_INSTR_COUNT64(i)),
-			CVM_CAST64(octeon_read_csr64(
-				oct, CN23XX_SLI_IQ_INSTR_COUNT64(i))));
-	}
-
-	/*In cn23xx_setup_oq_regs*/
-	for (i = 0; i < CN23XX_MAX_OUTPUT_QUEUES; i++) {
-		dev_dbg(&oct->pci_dev->dev, "%s(%d)[%llx] : 0x%016llx\n",
-			"CN23XX_SLI_OQ_BASE_ADDR64", i,
-			CVM_CAST64(CN23XX_SLI_OQ_BASE_ADDR64(i)),
-			CVM_CAST64(octeon_read_csr64(
-				oct, CN23XX_SLI_OQ_BASE_ADDR64(i))));
-		dev_dbg(&oct->pci_dev->dev, "%s(%d)[%llx] : 0x%016llx\n",
-			"CN23XX_SLI_OQ_SIZE", i,
-			CVM_CAST64(CN23XX_SLI_OQ_SIZE(i)),
-			CVM_CAST64(octeon_read_csr
-				(oct, CN23XX_SLI_OQ_SIZE(i))));
-		dev_dbg(&oct->pci_dev->dev, "%s(%d)[%llx] : 0x%016llx\n",
-			"CN23XX_SLI_OQ_BUFF_INFO_SIZE", i,
-			CVM_CAST64(CN23XX_SLI_OQ_BUFF_INFO_SIZE(i)),
-			CVM_CAST64(octeon_read_csr(
-				oct, CN23XX_SLI_OQ_BUFF_INFO_SIZE(i))));
-		dev_dbg(&oct->pci_dev->dev, "%s(%d)[%llx] : 0x%016llx\n",
-			"CN23XX_SLI_OQ_PKTS_SENT", i,
-			CVM_CAST64(CN23XX_SLI_OQ_PKTS_SENT(i)),
-			CVM_CAST64(octeon_read_csr64(
-				oct, CN23XX_SLI_OQ_PKTS_SENT(i))));
-		dev_dbg(&oct->pci_dev->dev, "%s(%d)[%llx] : 0x%016llx\n",
-			"CN23XX_SLI_OQ_PKTS_CREDIT", i,
-			CVM_CAST64(CN23XX_SLI_OQ_PKTS_CREDIT(i)),
-			CVM_CAST64(octeon_read_csr64(
-				oct, CN23XX_SLI_OQ_PKTS_CREDIT(i))));
-	}
-
-	dev_dbg(&oct->pci_dev->dev, "%s[%llx] : 0x%016llx\n",
-		"CN23XX_SLI_PKT_TIME_INT",
-		CVM_CAST64(CN23XX_SLI_PKT_TIME_INT),
-		CVM_CAST64(octeon_read_csr64(oct, CN23XX_SLI_PKT_TIME_INT)));
-	dev_dbg(&oct->pci_dev->dev, "%s[%llx] : 0x%016llx\n",
-		"CN23XX_SLI_PKT_CNT_INT",
-		CVM_CAST64(CN23XX_SLI_PKT_CNT_INT),
-		CVM_CAST64(octeon_read_csr64(oct, CN23XX_SLI_PKT_CNT_INT)));
-}
-
 static int cn23xx_pf_soft_reset(struct octeon_device *oct)
 {
 	octeon_write_csr64(oct, CN23XX_WIN_WR_MASK_REG, 0xFF);
diff --git a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.h b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.h
index e6f31d0d5c0b..234b96b4f488 100644
--- a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.h
+++ b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.h
@@ -59,8 +59,6 @@ int validate_cn23xx_pf_config_info(struct octeon_device *oct,
 
 u32 cn23xx_pf_get_oq_ticks(struct octeon_device *oct, u32 time_intr_in_us);
 
-void cn23xx_dump_pf_initialized_regs(struct octeon_device *oct);
-
 int cn23xx_sriov_config(struct octeon_device *oct);
 
 int cn23xx_fw_loaded(struct octeon_device *oct);
-- 
2.46.2


