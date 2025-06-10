Return-Path: <netdev+bounces-196135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D557AD3A1C
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 16:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BCF47AA7FC
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 13:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2698B29AB1E;
	Tue, 10 Jun 2025 13:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="WZFuKSBc"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D6F299A93;
	Tue, 10 Jun 2025 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749563999; cv=none; b=A8D/pzLJFY5e2DpGaXm0bP3kUcYWT2aE6mXz9BJs4HfKZTVunE4RtoSZf+S86O/5R+ykDoH0pVMZPUygynqjpW2MxgQq/urYH/lzduizQxSfiJn2xXRBr59tqaLUiXbXN92weYcNQJn+0B4ys7e2TijR26VPyLDkq82mJQIroK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749563999; c=relaxed/simple;
	bh=eAh8ZyWA6KDbVv46/CZP4poa7jZ+MNbP0CKOWTJ91uc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=peVvdyKvTGKEaQyWQpTRSH6HtGHVzg8tPsq59R4NsTxXjkvfOVvbBYNNE6Bej2amKxSIWKPhbbjDl/F6vLzgtC7wy/YBfkMJICZGgPEuFmyTsUxD7DlEIsy04yJU3lYmUQlVeLgaKGeOHb80ISb1ItTKZAey+ea6vhCqZtkcy90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=WZFuKSBc; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=nXVFlNAu7TNMAT//O6y0hQEyMgUscesBjEFDmPn96Ts=; b=WZFuKSBcTypsnxz4+Hq0ABDHXm
	gyq2wunk7ZwsDbTF/xfI8rHs5lMYe+y0dd4kxv5NO7fWwq66zb1uZ35EIGr0U0GTU7eVREXQksqKV
	kEVz3nrigdBRvfmZZSMNRtFHzE+LHgSdGwAtIg7+ktiTG/C4FsNiV6OtrsRkYm0avWwMXAl+yEhfk
	un2B6XfQCl4aGEtKJqrxkDXwjMcQDkfnEmY7oC3D7DYSLixm+tXXQeCbv6R+PGObHcky1VpDPKEM5
	keIHgylfjGEcl0caQrM9eNhCkhyIlBMRWesuQcaQxoRDkXj0Rs/d2hqsiicHCZHeQ/5S4UHWlJH46
	X4uRLJkw==;
Received: from [122.175.9.182] (port=48210 helo=cypher.couthit.local)
	by server.couthit.com with esmtpa (Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1uOzW4-0000000AXuj-29B4;
	Tue, 10 Jun 2025 09:59:53 -0400
From: Parvathi Pudi <parvathi@couthit.com>
To: danishanwar@ti.com,
	rogerq@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ssantosh@kernel.org,
	richardcochran@gmail.com,
	s.hauer@pengutronix.de,
	m-karicheri2@ti.com,
	glaroque@baylibre.com,
	afd@ti.com,
	saikrishnag@marvell.com,
	m-malladi@ti.com,
	jacob.e.keller@intel.com,
	diogo.ivo@siemens.com,
	javier.carrasco.cruz@gmail.com,
	horms@kernel.org,
	s-anna@ti.com,
	basharath@couthit.com,
	parvathi@couthit.com
Cc: linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pratheesh@ti.com,
	prajith@ti.com,
	vigneshr@ti.com,
	praneeth@ti.com,
	srk@ti.com,
	rogerq@ti.com,
	krishna@couthit.com,
	pmohan@couthit.com,
	mohan@couthit.com
Subject: [PATCH net-next v8 10/11] net: ti: prueth: Adds support for PRUETH on AM33x and AM43x SOCs
Date: Tue, 10 Jun 2025 19:28:24 +0530
Message-Id: <20250610135825.3369156-11-parvathi@couthit.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610105721.3063503-1-parvathi@couthit.com>
References: <20250610105721.3063503-1-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: parvathi@couthit.com
X-Authenticated-Sender: server.couthit.com: parvathi@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

From: Roger Quadros <rogerq@ti.com>

Adds support for AM335x and AM437x datasets. Dual-EMAC and Switch mode
firmware elf file to switch between protocols at run time.

Added API hooks for IEP module (legacy 32-bit model) to support
timestamping requests from application.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
---
 drivers/net/ethernet/ti/icssg/icss_iep.c     | 61 ++++++++++++++++++++
 drivers/net/ethernet/ti/icssm/icssm_prueth.c | 32 ++++++++++
 2 files changed, 93 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
index 031a6be6a4e3..d0850722814e 100644
--- a/drivers/net/ethernet/ti/icssg/icss_iep.c
+++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
@@ -1006,6 +1006,59 @@ static const struct icss_iep_plat_data am57xx_icss_iep_plat_data = {
 	.config = &am654_icss_iep_regmap_config,
 };
 
+static bool am335x_icss_iep_valid_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case ICSS_IEP_GLOBAL_CFG_REG ... ICSS_IEP_CAPTURE_STAT_REG:
+	case ICSS_IEP_CAP6_RISE_REG0:
+	case ICSS_IEP_CMP_CFG_REG ... ICSS_IEP_CMP0_REG0:
+	case ICSS_IEP_CMP8_REG0 ... ICSS_IEP_SYNC_START_REG:
+		return true;
+	default:
+		return false;
+	}
+
+	return false;
+}
+
+static const struct regmap_config am335x_icss_iep_regmap_config = {
+	.name = "icss iep",
+	.reg_stride = 1,
+	.reg_write = icss_iep_regmap_write,
+	.reg_read = icss_iep_regmap_read,
+	.writeable_reg = am335x_icss_iep_valid_reg,
+	.readable_reg = am335x_icss_iep_valid_reg,
+};
+
+static const struct icss_iep_plat_data am335x_icss_iep_plat_data = {
+	.flags = 0,
+	.reg_offs = {
+		[ICSS_IEP_GLOBAL_CFG_REG] = 0x00,
+		[ICSS_IEP_COMPEN_REG] = 0x08,
+		[ICSS_IEP_COUNT_REG0] = 0x0C,
+		[ICSS_IEP_CAPTURE_CFG_REG] = 0x10,
+		[ICSS_IEP_CAPTURE_STAT_REG] = 0x14,
+
+		[ICSS_IEP_CAP6_RISE_REG0] = 0x30,
+
+		[ICSS_IEP_CAP7_RISE_REG0] = 0x38,
+
+		[ICSS_IEP_CMP_CFG_REG] = 0x40,
+		[ICSS_IEP_CMP_STAT_REG] = 0x44,
+		[ICSS_IEP_CMP0_REG0] = 0x48,
+
+		[ICSS_IEP_CMP8_REG0] = 0x88,
+		[ICSS_IEP_SYNC_CTRL_REG] = 0x100,
+		[ICSS_IEP_SYNC0_STAT_REG] = 0x108,
+		[ICSS_IEP_SYNC1_STAT_REG] = 0x10C,
+		[ICSS_IEP_SYNC_PWIDTH_REG] = 0x110,
+		[ICSS_IEP_SYNC0_PERIOD_REG] = 0x114,
+		[ICSS_IEP_SYNC1_DELAY_REG] = 0x118,
+		[ICSS_IEP_SYNC_START_REG] = 0x11C,
+	},
+	.config = &am335x_icss_iep_regmap_config,
+};
+
 static const struct of_device_id icss_iep_of_match[] = {
 	{
 		.compatible = "ti,am654-icss-iep",
@@ -1015,6 +1068,14 @@ static const struct of_device_id icss_iep_of_match[] = {
 		.compatible = "ti,am5728-icss-iep",
 		.data = &am57xx_icss_iep_plat_data,
 	},
+	{
+		.compatible = "ti,am3356-icss-iep",
+		.data = &am335x_icss_iep_plat_data,
+	},
+	{
+		.compatible = "ti,am4376-icss-iep",
+		.data = &am335x_icss_iep_plat_data,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, icss_iep_of_match);
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
index 0df8631add83..8ec0a09a4fce 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
@@ -2142,6 +2142,10 @@ static int icssm_prueth_probe(struct platform_device *pdev)
 	}
 
 	prueth->ocmc_ram_size = OCMC_RAM_SIZE;
+	/* Decreased by 8KB to address the reserved region for AM33x */
+	if (prueth->fw_data->driver_data == PRUSS_AM33XX)
+		prueth->ocmc_ram_size = (SZ_64K - SZ_8K);
+
 	prueth->mem[PRUETH_MEM_OCMC].va =
 			(void __iomem *)gen_pool_alloc(prueth->sram_pool,
 						       prueth->ocmc_ram_size);
@@ -2385,6 +2389,32 @@ static const struct dev_pm_ops prueth_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(icssm_prueth_suspend, icssm_prueth_resume)
 };
 
+/* AM335x SoC-specific firmware data */
+static struct prueth_private_data am335x_prueth_pdata = {
+	.driver_data = PRUSS_AM33XX,
+	.fw_pru[PRUSS_PRU0] = {
+		.fw_name[PRUSS_ETHTYPE_EMAC] =
+			"ti-pruss/am335x-pru0-prueth-fw.elf",
+	},
+	.fw_pru[PRUSS_PRU1] = {
+		.fw_name[PRUSS_ETHTYPE_EMAC] =
+			"ti-pruss/am335x-pru1-prueth-fw.elf",
+	},
+};
+
+/* AM437x SoC-specific firmware data */
+static struct prueth_private_data am437x_prueth_pdata = {
+	.driver_data = PRUSS_AM43XX,
+	.fw_pru[PRUSS_PRU0] = {
+		.fw_name[PRUSS_ETHTYPE_EMAC] =
+			"ti-pruss/am437x-pru0-prueth-fw.elf",
+	},
+	.fw_pru[PRUSS_PRU1] = {
+		.fw_name[PRUSS_ETHTYPE_EMAC] =
+			"ti-pruss/am437x-pru1-prueth-fw.elf",
+	},
+};
+
 /* AM57xx SoC-specific firmware data */
 static struct prueth_private_data am57xx_prueth_pdata = {
 	.driver_data = PRUSS_AM57XX,
@@ -2400,6 +2430,8 @@ static struct prueth_private_data am57xx_prueth_pdata = {
 
 static const struct of_device_id prueth_dt_match[] = {
 	{ .compatible = "ti,am57-prueth", .data = &am57xx_prueth_pdata, },
+	{ .compatible = "ti,am4376-prueth", .data = &am437x_prueth_pdata, },
+	{ .compatible = "ti,am3359-prueth", .data = &am335x_prueth_pdata, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, prueth_dt_match);
-- 
2.34.1


