Return-Path: <netdev+bounces-137497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1B09A6B4C
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 16:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C931F22595
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 14:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFBE1F9A8A;
	Mon, 21 Oct 2024 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KYjF8EqE"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1669C1F940D;
	Mon, 21 Oct 2024 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519193; cv=none; b=DZGQUH0pF3kFW88Og5MP0+294CDJXwhuvhg5ghPlpoe7FVLoBVbPWtuW9yVnjbL4lQzMcya9jhSVM9JMbw094b9FsaLXKqxxPo1iDnPMVaYFSXoVzdcBhZbDuQ8r0MyYM1rqaE1L3J3edD8I9k2lDDyulwETPet8U7ZyjBZ2osA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519193; c=relaxed/simple;
	bh=n652PNeLtD/GJ7AgwunLXk013rJnFWw+WcOoEeziQ08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Il4GfLsxi2FlEqYQWlgxfPl7f1Hqoxgam8QYwjixZYa6Yu96ern4UDWvZqubzgDluhJyzCdLCpjSsPUWtRjc+Lr4yFChl5ve+WtRDvZXShxioIjDj7HHTO2gWcW3FACcBD35tm4ciYozL+z0P9jwBxY+RiGBSU93Om/8Nf/rCPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KYjF8EqE; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729519190; x=1761055190;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=n652PNeLtD/GJ7AgwunLXk013rJnFWw+WcOoEeziQ08=;
  b=KYjF8EqE3MfODver2s2WvuKTTLk03DM/TJg8wcp3mUDAYEQzXv8U3LVH
   4mkyjFN5rdSMtdzW8MgXteoRsrnknes9Lz52jTH9IucHtQS/2KTuniJWE
   3eCbnyiHsFE0dsvHNMaYika63q8QjWlxi5oVXuNXidX74zDC2ivNcNT7+
   PPxID1flHDbBpz24jOQDGcVxmpdfJuZHYfNc1yqz4Yd69PBzQ9uq+irqn
   ZZd+DYYMmikjSKE2NX2FIVpV7FWOzkoZ1giLpsiTKjrMmrABKmSYtG/zz
   N0MT4/vAI1cbgiBaFkGfNn5kutfKq3wQ97Os3rdw2her0y7U2dYNlFozN
   Q==;
X-CSE-ConnectionGUID: n5EyPlFvT6ikwx0IUcXENA==
X-CSE-MsgGUID: TbI+dM3+RMuKNgOj96S7lw==
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="200707780"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Oct 2024 06:59:48 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 21 Oct 2024 06:59:23 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 21 Oct 2024 06:59:19 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 21 Oct 2024 15:58:44 +0200
Subject: [PATCH net-next 07/15] net: lan969x: add register diffs to match
 data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241021-sparx5-lan969x-switch-driver-2-v1-7-c8c49ef21e0f@microchip.com>
References: <20241021-sparx5-lan969x-switch-driver-2-v1-0-c8c49ef21e0f@microchip.com>
In-Reply-To: <20241021-sparx5-lan969x-switch-driver-2-v1-0-c8c49ef21e0f@microchip.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <andrew@lunn.ch>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<horatiu.vultur@microchip.com>, <jensemil.schulzostergaard@microchip.com>,
	<Parthiban.Veerasooran@microchip.com>, <Raju.Lakkaraju@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <jacob.e.keller@intel.com>,
	<ast@fiberby.net>, <maxime.chevallier@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Steen Hegelund
	<steen.hegelund@microchip.com>, <devicetree@vger.kernel.org>
X-Mailer: b4 0.14-dev

Add new file lan969x_regs.c that defines all the register differences
for lan969x, and add it to the lan969x match data.

GW_DEV2G5_PHASE_DETECTOR_CTRL, FP_DEV2G5_PHAD_CTRL_PHAD_ENA and
FP_DEV2G5_PHAD_CTRL_PHAD_FAILED are required by the new register macros
which was introduced earlier. Add these for Sparx5 also.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/lan969x/Makefile    |   2 +-
 drivers/net/ethernet/microchip/lan969x/lan969x.c   |  12 ++
 drivers/net/ethernet/microchip/lan969x/lan969x.h   |  10 +
 .../net/ethernet/microchip/lan969x/lan969x_regs.c  | 223 +++++++++++++++++++++
 .../net/ethernet/microchip/sparx5/sparx5_regs.c    |   5 +-
 .../net/ethernet/microchip/sparx5/sparx5_regs.h    |   5 +-
 6 files changed, 254 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan969x/Makefile b/drivers/net/ethernet/microchip/lan969x/Makefile
index 3755202536e1..41bf66b9fef5 100644
--- a/drivers/net/ethernet/microchip/lan969x/Makefile
+++ b/drivers/net/ethernet/microchip/lan969x/Makefile
@@ -5,7 +5,7 @@
 
 obj-$(CONFIG_LAN969X_SWITCH) += lan969x-switch.o
 
-lan969x-switch-y := lan969x.o
+lan969x-switch-y := lan969x_regs.o lan969x.o
 
 # Provide include files
 ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/sparx5
diff --git a/drivers/net/ethernet/microchip/lan969x/lan969x.c b/drivers/net/ethernet/microchip/lan969x/lan969x.c
index 32f4c1001482..d99c1396e16a 100644
--- a/drivers/net/ethernet/microchip/lan969x/lan969x.c
+++ b/drivers/net/ethernet/microchip/lan969x/lan969x.c
@@ -92,10 +92,22 @@ static const struct sparx5_main_io_resource lan969x_main_iomap[] =  {
 	{ TARGET_ASM,                 0x3200000, 1 }, /* 0xe3200000 */
 };
 
+static const struct sparx5_regs lan969x_regs = {
+	.tsize = lan969x_tsize,
+	.gaddr = lan969x_gaddr,
+	.gcnt = lan969x_gcnt,
+	.gsize = lan969x_gsize,
+	.raddr = lan969x_raddr,
+	.rcnt = lan969x_rcnt,
+	.fpos = lan969x_fpos,
+	.fsize = lan969x_fsize,
+};
+
 const struct sparx5_match_data lan969x_desc = {
 	.iomap      = lan969x_main_iomap,
 	.iomap_size = ARRAY_SIZE(lan969x_main_iomap),
 	.ioranges   = 2,
+	.regs       = &lan969x_regs,
 };
 
 MODULE_DESCRIPTION("Microchip lan969x switch driver");
diff --git a/drivers/net/ethernet/microchip/lan969x/lan969x.h b/drivers/net/ethernet/microchip/lan969x/lan969x.h
index ba6d351f45c8..9059b0dc954c 100644
--- a/drivers/net/ethernet/microchip/lan969x/lan969x.h
+++ b/drivers/net/ethernet/microchip/lan969x/lan969x.h
@@ -12,4 +12,14 @@
 /* lan969x.c */
 extern const struct sparx5_match_data lan969x_desc;
 
+/* lan969x_regs.c */
+extern const unsigned int lan969x_tsize[TSIZE_LAST];
+extern const unsigned int lan969x_raddr[RADDR_LAST];
+extern const unsigned int lan969x_rcnt[RCNT_LAST];
+extern const unsigned int lan969x_gaddr[GADDR_LAST];
+extern const unsigned int lan969x_gcnt[GCNT_LAST];
+extern const unsigned int lan969x_gsize[GSIZE_LAST];
+extern const unsigned int lan969x_fpos[FPOS_LAST];
+extern const unsigned int lan969x_fsize[FSIZE_LAST];
+
 #endif
diff --git a/drivers/net/ethernet/microchip/lan969x/lan969x_regs.c b/drivers/net/ethernet/microchip/lan969x/lan969x_regs.c
new file mode 100644
index 000000000000..aacd3c897477
--- /dev/null
+++ b/drivers/net/ethernet/microchip/lan969x/lan969x_regs.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Microchip lan969x Switch driver
+ *
+ * Copyright (c) 2024 Microchip Technology Inc.
+ */
+
+/* This file is autogenerated by cml-utils 2024-09-30 11:48:29 +0200.
+ * Commit ID: 9d07b8d19363f3cd3590ddb3f7a2e2768e16524b
+ */
+
+#include "lan969x.h"
+#include "sparx5_regs.h"
+
+const unsigned int lan969x_tsize[TSIZE_LAST] = {
+	[TC_DEV10G] = 10,
+	[TC_DEV2G5] = 28,
+	[TC_DEV5G] = 4,
+	[TC_PCS10G_BR] = 10,
+	[TC_PCS5G_BR] = 4,
+};
+
+const unsigned int lan969x_raddr[RADDR_LAST] = {
+	[RA_CPU_PROC_CTRL] = 160,
+	[RA_GCB_SOFT_RST] = 12,
+	[RA_GCB_HW_SGPIO_TO_SD_MAP_CFG] = 20,
+};
+
+const unsigned int lan969x_rcnt[RCNT_LAST] = {
+	[RC_ANA_AC_OWN_UPSID] = 1,
+	[RC_ANA_ACL_VCAP_S2_CFG] = 35,
+	[RC_ANA_ACL_OWN_UPSID] = 1,
+	[RC_ANA_CL_OWN_UPSID] = 1,
+	[RC_ANA_L2_OWN_UPSID] = 1,
+	[RC_ASM_PORT_CFG] = 32,
+	[RC_DSM_BUF_CFG] = 32,
+	[RC_DSM_DEV_TX_STOP_WM_CFG] = 32,
+	[RC_DSM_RX_PAUSE_CFG] = 32,
+	[RC_DSM_MAC_CFG] = 32,
+	[RC_DSM_MAC_ADDR_BASE_HIGH_CFG] = 30,
+	[RC_DSM_MAC_ADDR_BASE_LOW_CFG] = 30,
+	[RC_DSM_TAXI_CAL_CFG] = 6,
+	[RC_GCB_HW_SGPIO_TO_SD_MAP_CFG] = 30,
+	[RC_HSCH_PORT_MODE] = 35,
+	[RC_QFWD_SWITCH_PORT_MODE] = 35,
+	[RC_QSYS_PAUSE_CFG] = 35,
+	[RC_QSYS_ATOP] = 35,
+	[RC_QSYS_FWD_PRESSURE] = 35,
+	[RC_QSYS_CAL_AUTO] = 4,
+	[RC_REW_OWN_UPSID] = 1,
+	[RC_REW_RTAG_ETAG_CTRL] = 35,
+};
+
+const unsigned int lan969x_gaddr[GADDR_LAST] = {
+	[GA_ANA_AC_RAM_CTRL] = 202000,
+	[GA_ANA_AC_PS_COMMON] = 202880,
+	[GA_ANA_AC_MIRROR_PROBE] = 203232,
+	[GA_ANA_AC_SRC] = 201728,
+	[GA_ANA_AC_PGID] = 131072,
+	[GA_ANA_AC_TSN_SF] = 202028,
+	[GA_ANA_AC_TSN_SF_CFG] = 148480,
+	[GA_ANA_AC_TSN_SF_STATUS] = 147936,
+	[GA_ANA_AC_SG_ACCESS] = 202032,
+	[GA_ANA_AC_SG_CONFIG] = 202752,
+	[GA_ANA_AC_SG_STATUS] = 147952,
+	[GA_ANA_AC_SG_STATUS_STICKY] = 202044,
+	[GA_ANA_AC_STAT_GLOBAL_CFG_PORT] = 202048,
+	[GA_ANA_AC_STAT_CNT_CFG_PORT] = 204800,
+	[GA_ANA_AC_STAT_GLOBAL_CFG_ACL] = 202068,
+	[GA_ANA_ACL_COMMON] = 8192,
+	[GA_ANA_ACL_KEY_SEL] = 9204,
+	[GA_ANA_ACL_CNT_B] = 4096,
+	[GA_ANA_ACL_STICKY] = 10852,
+	[GA_ANA_AC_POL_POL_ALL_CFG] = 17504,
+	[GA_ANA_AC_POL_COMMON_BDLB] = 19464,
+	[GA_ANA_AC_POL_COMMON_BUM_SLB] = 19472,
+	[GA_ANA_AC_SDLB_LBGRP_TBL] = 31788,
+	[GA_ANA_CL_PORT] = 65536,
+	[GA_ANA_CL_COMMON] = 87040,
+	[GA_ANA_L2_COMMON] = 561928,
+	[GA_ANA_L3_COMMON] = 370752,
+	[GA_ANA_L3_VLAN_ARP_L3MC_STICKY] = 368580,
+	[GA_ASM_CFG] = 18304,
+	[GA_ASM_PFC_TIMER_CFG] = 15568,
+	[GA_ASM_LBK_WM_CFG] = 15596,
+	[GA_ASM_LBK_MISC_CFG] = 15608,
+	[GA_ASM_RAM_CTRL] = 15684,
+	[GA_EACL_ES2_KEY_SELECT_PROFILE] = 36864,
+	[GA_EACL_CNT_TBL] = 30720,
+	[GA_EACL_POL_CFG] = 38400,
+	[GA_EACL_ES2_STICKY] = 29072,
+	[GA_EACL_RAM_CTRL] = 29112,
+	[GA_GCB_SIO_CTRL] = 560,
+	[GA_HSCH_HSCH_DWRR] = 36480,
+	[GA_HSCH_HSCH_MISC] = 36608,
+	[GA_HSCH_HSCH_LEAK_LISTS] = 37256,
+	[GA_HSCH_SYSTEM] = 37384,
+	[GA_HSCH_MMGT] = 36260,
+	[GA_HSCH_TAS_CONFIG] = 37696,
+	[GA_PTP_PTP_CFG] = 512,
+	[GA_PTP_PTP_TOD_DOMAINS] = 528,
+	[GA_PTP_PHASE_DETECTOR_CTRL] = 628,
+	[GA_QSYS_CALCFG] = 2164,
+	[GA_QSYS_RAM_CTRL] = 2204,
+	[GA_REW_COMMON] = 98304,
+	[GA_REW_PORT] = 49152,
+	[GA_REW_VOE_PORT_LM_CNT] = 90112,
+	[GA_REW_RAM_CTRL] = 93992,
+	[GA_VOP_RAM_CTRL] = 16368,
+	[GA_XQS_SYSTEM] = 5744,
+	[GA_XQS_QLIMIT_SHR] = 6912,
+};
+
+const unsigned int lan969x_gcnt[GCNT_LAST] = {
+	[GC_ANA_AC_SRC] = 67,
+	[GC_ANA_AC_PGID] = 1054,
+	[GC_ANA_AC_TSN_SF_CFG] = 256,
+	[GC_ANA_AC_STAT_CNT_CFG_PORT] = 35,
+	[GC_ANA_ACL_KEY_SEL] = 99,
+	[GC_ANA_ACL_CNT_A] = 1024,
+	[GC_ANA_ACL_CNT_B] = 1024,
+	[GC_ANA_AC_SDLB_LBGRP_TBL] = 5,
+	[GC_ANA_AC_SDLB_LBSET_TBL] = 496,
+	[GC_ANA_CL_PORT] = 35,
+	[GC_ANA_L2_ISDX_LIMIT] = 256,
+	[GC_ANA_L2_ISDX] = 1024,
+	[GC_ANA_L3_VLAN] = 4608,
+	[GC_ASM_DEV_STATISTICS] = 30,
+	[GC_EACL_ES2_KEY_SELECT_PROFILE] = 68,
+	[GC_EACL_CNT_TBL] = 512,
+	[GC_GCB_SIO_CTRL] = 1,
+	[GC_HSCH_HSCH_CFG] = 1120,
+	[GC_HSCH_HSCH_DWRR] = 32,
+	[GC_PTP_PTP_PINS] = 8,
+	[GC_PTP_PHASE_DETECTOR_CTRL] = 8,
+	[GC_REW_PORT] = 35,
+	[GC_REW_VOE_PORT_LM_CNT] = 240,
+};
+
+const unsigned int lan969x_gsize[GSIZE_LAST] = {
+	[GW_ANA_AC_SRC] = 4,
+	[GW_ANA_L2_COMMON] = 712,
+	[GW_ASM_CFG] = 1092,
+	[GW_CPU_CPU_REGS] = 180,
+	[GW_DEV2G5_PHASE_DETECTOR_CTRL] = 12,
+	[GW_FDMA_FDMA] = 448,
+	[GW_GCB_CHIP_REGS] = 180,
+	[GW_HSCH_TAS_CONFIG] = 16,
+	[GW_PTP_PHASE_DETECTOR_CTRL] = 12,
+	[GW_QSYS_PAUSE_CFG] = 988,
+};
+
+const unsigned int lan969x_fpos[FPOS_LAST] = {
+	[FP_CPU_PROC_CTRL_AARCH64_MODE_ENA] = 7,
+	[FP_CPU_PROC_CTRL_L2_RST_INVALIDATE_DIS] = 6,
+	[FP_CPU_PROC_CTRL_L1_RST_INVALIDATE_DIS] = 5,
+	[FP_CPU_PROC_CTRL_BE_EXCEP_MODE] = 4,
+	[FP_CPU_PROC_CTRL_VINITHI] = 3,
+	[FP_CPU_PROC_CTRL_CFGTE] = 2,
+	[FP_CPU_PROC_CTRL_CP15S_DISABLE] = 1,
+	[FP_CPU_PROC_CTRL_PROC_CRYPTO_DISABLE] = 0,
+	[FP_CPU_PROC_CTRL_L2_FLUSH_REQ] = 8,
+	[FP_DEV2G5_PHAD_CTRL_PHAD_ENA] = 5,
+	[FP_DEV2G5_PHAD_CTRL_PHAD_FAILED] = 3,
+	[FP_FDMA_CH_CFG_CH_XTR_STATUS_MODE] = 5,
+	[FP_FDMA_CH_CFG_CH_INTR_DB_EOF_ONLY] = 4,
+	[FP_FDMA_CH_CFG_CH_INJ_PORT] = 3,
+	[FP_PTP_PTP_PIN_CFG_PTP_PIN_ACTION] = 27,
+	[FP_PTP_PTP_PIN_CFG_PTP_PIN_SYNC] = 25,
+	[FP_PTP_PTP_PIN_CFG_PTP_PIN_INV_POL] = 24,
+	[FP_PTP_PHAD_CTRL_PHAD_ENA] = 5,
+	[FP_PTP_PHAD_CTRL_PHAD_FAILED] = 3,
+};
+
+const unsigned int lan969x_fsize[FSIZE_LAST] = {
+	[FW_ANA_AC_PROBE_PORT_CFG_PROBE_PORT_MASK] = 30,
+	[FW_ANA_AC_SRC_CFG_PORT_MASK] = 30,
+	[FW_ANA_AC_PGID_CFG_PORT_MASK] = 30,
+	[FW_ANA_AC_TSN_SF_PORT_NUM] = 7,
+	[FW_ANA_AC_TSN_SF_CFG_TSN_SGID] = 8,
+	[FW_ANA_AC_TSN_SF_STATUS_TSN_SFID] = 8,
+	[FW_ANA_AC_SG_ACCESS_CTRL_SGID] = 8,
+	[FW_ANA_AC_PORT_SGE_CFG_MASK] = 17,
+	[FW_ANA_AC_SDLB_XLB_START_LBSET_START] = 9,
+	[FW_ANA_AC_SDLB_LBGRP_MISC_THRES_SHIFT] = 3,
+	[FW_ANA_AC_SDLB_LBGRP_STATE_TBL_PUP_LBSET_NEXT] = 9,
+	[FW_ANA_AC_SDLB_XLB_NEXT_LBSET_NEXT] = 9,
+	[FW_ANA_AC_SDLB_XLB_NEXT_LBGRP] = 3,
+	[FW_ANA_AC_SDLB_INH_LBSET_ADDR_INH_LBSET_ADDR] = 9,
+	[FW_ANA_L2_AUTO_LRN_CFG_AUTO_LRN_ENA] = 30,
+	[FW_ANA_L2_DLB_CFG_DLB_IDX] = 9,
+	[FW_ANA_L2_TSN_CFG_TSN_SFID] = 8,
+	[FW_ANA_L3_VLAN_MASK_CFG_VLAN_PORT_MASK] = 30,
+	[FW_FDMA_CH_CFG_CH_DCB_DB_CNT] = 2,
+	[FW_GCB_HW_SGPIO_TO_SD_MAP_CFG_SGPIO_TO_SD_SEL] = 7,
+	[FW_HSCH_SE_CFG_SE_DWRR_CNT] = 5,
+	[FW_HSCH_SE_CONNECT_SE_LEAK_LINK] = 14,
+	[FW_HSCH_SE_DLB_SENSE_SE_DLB_DPORT] = 6,
+	[FW_HSCH_HSCH_CFG_CFG_CFG_SE_IDX] = 11,
+	[FW_HSCH_HSCH_LEAK_CFG_LEAK_FIRST] = 14,
+	[FW_HSCH_FLUSH_CTRL_FLUSH_PORT] = 6,
+	[FW_HSCH_FLUSH_CTRL_FLUSH_HIER] = 14,
+	[FW_LRN_COMMON_ACCESS_CTRL_CPU_ACCESS_DIRECT_ROW] = 13,
+	[FW_LRN_MAC_ACCESS_CFG_3_MAC_ENTRY_ISDX_LIMIT_IDX] = 8,
+	[FW_LRN_AUTOAGE_CFG_2_NEXT_ROW] = 13,
+	[FW_PTP_PTP_PIN_INTR_INTR_PTP] = 8,
+	[FW_PTP_PTP_PIN_INTR_ENA_INTR_PTP_ENA] = 8,
+	[FW_PTP_PTP_INTR_IDENT_INTR_PTP_IDENT] = 8,
+	[FW_PTP_PTP_PIN_CFG_PTP_PIN_SELECT] = 3,
+	[FW_QFWD_FRAME_COPY_CFG_FRMC_PORT_VAL] = 6,
+	[FW_QRES_RES_CFG_WM_HIGH] = 11,
+	[FW_QRES_RES_STAT_MAXUSE] = 19,
+	[FW_QRES_RES_STAT_CUR_INUSE] = 19,
+	[FW_QSYS_PAUSE_CFG_PAUSE_START] = 11,
+	[FW_QSYS_PAUSE_CFG_PAUSE_STOP] = 11,
+	[FW_QSYS_ATOP_ATOP] = 11,
+	[FW_QSYS_ATOP_TOT_CFG_ATOP_TOT] = 11,
+	[FW_REW_RTAG_ETAG_CTRL_IPE_TBL] = 6,
+	[FW_XQS_STAT_CFG_STAT_VIEW] = 10,
+	[FW_XQS_QLIMIT_SHR_TOP_CFG_QLIMIT_SHR_TOP] = 14,
+	[FW_XQS_QLIMIT_SHR_ATOP_CFG_QLIMIT_SHR_ATOP] = 14,
+	[FW_XQS_QLIMIT_SHR_CTOP_CFG_QLIMIT_SHR_CTOP] = 14,
+	[FW_XQS_QLIMIT_SHR_QLIM_CFG_QLIMIT_SHR_QLIM] = 14,
+};
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_regs.c b/drivers/net/ethernet/microchip/sparx5/sparx5_regs.c
index 1db212ce3df7..220e81b714d4 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_regs.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_regs.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2024 Microchip Technology Inc.
  */
 
-/* This file is autogenerated by cml-utils 2024-09-24 14:02:24 +0200.
+/* This file is autogenerated by cml-utils 2024-09-30 11:48:29 +0200.
  * Commit ID: 9d07b8d19363f3cd3590ddb3f7a2e2768e16524b
  */
 
@@ -140,6 +140,7 @@ const unsigned int sparx5_gsize[GSIZE_LAST] = {
 	[GW_ANA_L2_COMMON] = 700,
 	[GW_ASM_CFG] = 1088,
 	[GW_CPU_CPU_REGS] = 204,
+	[GW_DEV2G5_PHASE_DETECTOR_CTRL] = 8,
 	[GW_FDMA_FDMA] = 428,
 	[GW_GCB_CHIP_REGS] = 424,
 	[GW_HSCH_TAS_CONFIG] = 12,
@@ -157,6 +158,8 @@ const unsigned int sparx5_fpos[FPOS_LAST] = {
 	[FP_CPU_PROC_CTRL_CP15S_DISABLE] = 6,
 	[FP_CPU_PROC_CTRL_PROC_CRYPTO_DISABLE] = 5,
 	[FP_CPU_PROC_CTRL_L2_FLUSH_REQ] = 1,
+	[FP_DEV2G5_PHAD_CTRL_PHAD_ENA] = 7,
+	[FP_DEV2G5_PHAD_CTRL_PHAD_FAILED] = 6,
 	[FP_FDMA_CH_CFG_CH_XTR_STATUS_MODE] = 7,
 	[FP_FDMA_CH_CFG_CH_INTR_DB_EOF_ONLY] = 6,
 	[FP_FDMA_CH_CFG_CH_INJ_PORT] = 5,
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_regs.h b/drivers/net/ethernet/microchip/sparx5/sparx5_regs.h
index c4e8b581c1f3..ea28130c2341 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_regs.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_regs.h
@@ -4,7 +4,7 @@
  * Copyright (c) 2024 Microchip Technology Inc.
  */
 
-/* This file is autogenerated by cml-utils 2024-09-24 14:02:24 +0200.
+/* This file is autogenerated by cml-utils 2024-09-30 11:48:29 +0200.
  * Commit ID: 9d07b8d19363f3cd3590ddb3f7a2e2768e16524b
  */
 
@@ -151,6 +151,7 @@ enum sparx5_gsize_enum {
 	GW_ANA_L2_COMMON,
 	GW_ASM_CFG,
 	GW_CPU_CPU_REGS,
+	GW_DEV2G5_PHASE_DETECTOR_CTRL,
 	GW_FDMA_FDMA,
 	GW_GCB_CHIP_REGS,
 	GW_HSCH_TAS_CONFIG,
@@ -169,6 +170,8 @@ enum sparx5_fpos_enum {
 	FP_CPU_PROC_CTRL_CP15S_DISABLE,
 	FP_CPU_PROC_CTRL_PROC_CRYPTO_DISABLE,
 	FP_CPU_PROC_CTRL_L2_FLUSH_REQ,
+	FP_DEV2G5_PHAD_CTRL_PHAD_ENA,
+	FP_DEV2G5_PHAD_CTRL_PHAD_FAILED,
 	FP_FDMA_CH_CFG_CH_XTR_STATUS_MODE,
 	FP_FDMA_CH_CFG_CH_INTR_DB_EOF_ONLY,
 	FP_FDMA_CH_CFG_CH_INJ_PORT,

-- 
2.34.1


