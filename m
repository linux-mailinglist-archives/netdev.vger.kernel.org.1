Return-Path: <netdev+bounces-233822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 499AEC18F75
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 09:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 151F646532E
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 08:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C63A320A31;
	Wed, 29 Oct 2025 08:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsaO2cFj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AEA31E0EA;
	Wed, 29 Oct 2025 08:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725185; cv=none; b=YF9KDDDO7c0S7Wcz4qw/IBFZJ3f9ejMlanmDlvJogN2y+sxpeDg/BSts4fgXDwI16599nxWCTVJYJ4+n77QIbSTsJarRz0R4225S3URzhdJQP/kYs/qZ653yREaXFadSeVefpLLyAX+1pSnYR4kJgdlmKTC9Iu/vrXUSAJHuILU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725185; c=relaxed/simple;
	bh=/oVMgoN0d3ixwVotycgrVVjswd5DG6nEvx4SH9if1No=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sCfYTtMQ5fj2mj3qd8prBZyKLBMtswPLH/FpLRg/5y2QpbhzvQ7cZ/XDiPWWHjF+YT3ZSKqUsgfPXD/5BYSgC14Nng4qDtPna9MSCKbuOPWgcH6PO8oJhH0Jxcw+mgV5qoirBY+4TBC4EyOUQ6hYpr2assCzHWizJUv1ZemXmQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsaO2cFj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB132C116B1;
	Wed, 29 Oct 2025 08:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761725184;
	bh=/oVMgoN0d3ixwVotycgrVVjswd5DG6nEvx4SH9if1No=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZsaO2cFji1crgWSeRKwYEYPtaAyrNGg2KkSsQbSog66qVsns1ISiARgeHk9cMNtbM
	 /uFFf5LBnetXjXQDgJJRLZDjptJqNVnjU9vxXMq8b1hlA1qzHO2iEuyuaTIiQr9qwD
	 6HnTUdCc090XoWit4TBk5nf5sP8TLMolwO99C8Yd+ek4evLsiEaJQcasWB+sgsPRPb
	 IUsLp7aC7f8N/XVsTtJoMCZd+DV+6zMI/ghfnQbP2vjPsn3HyVjMlJ87w7p3psbi7O
	 UJOOmJeQUD7Nn/XKIEEjUSbs/x4dEWvm3CLWb9tXXVUoG201S7vtgsNJWVgGvu9dfk
	 Ho6jPrCK4IvOg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B929DCCF9E9;
	Wed, 29 Oct 2025 08:06:24 +0000 (UTC)
From: Rohan G Thomas via B4 Relay <devnull+rohan.g.thomas.altera.com@kernel.org>
Date: Wed, 29 Oct 2025 16:06:13 +0800
Subject: [PATCH net-next 1/4] net: stmmac: socfpga: Agilex5 EMAC platform
 configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-agilex5_ext-v1-1-1931132d77d6@altera.com>
References: <20251029-agilex5_ext-v1-0-1931132d77d6@altera.com>
In-Reply-To: <20251029-agilex5_ext-v1-0-1931132d77d6@altera.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rohan G Thomas <rohan.g.thomas@altera.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761725182; l=4008;
 i=rohan.g.thomas@altera.com; s=20250815; h=from:subject:message-id;
 bh=fqpheFKts6+7OsBqsj9xRO/POu9s39bQIp1U3z6E4Sk=;
 b=YohBBb/PJcQ7AlroGARqRd4AYmGE4QmSVQzy2BMDhtBTSq+CR5nGjCP4j5YphFG2mIhAp7T9/
 qCSWpLuHYEDAORQd7rU9kKLKkHWQhfhPffjsdxoTfsCfP7J9wp1rmSS
X-Developer-Key: i=rohan.g.thomas@altera.com; a=ed25519;
 pk=5yZXkXswhfUILKAQwoIn7m6uSblwgV5oppxqde4g4TY=
X-Endpoint-Received: by B4 Relay for rohan.g.thomas@altera.com/20250815
 with auth_id=494
X-Original-From: Rohan G Thomas <rohan.g.thomas@altera.com>
Reply-To: rohan.g.thomas@altera.com

From: Rohan G Thomas <rohan.g.thomas@altera.com>

Agilex5 HPS EMAC uses the dwxgmac-3.10a IP, unlike previous socfpga
platforms which use dwmac1000 IP. Due to differences in platform
configuration, Agilex5 requires a distinct setup.

Introduce a setup_plat_dat() callback in socfpga_dwmac_ops to handle
platform-specific setup. This callback is invoked before
stmmac_dvr_probe() to ensure the platform data is correctly
configured. Also, implemented separate setup_plat_dat() callback for
current socfpga platforms and Agilex5.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    | 53 ++++++++++++++++++----
 1 file changed, 43 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 2ff5db6d41ca08a1652d57f3eb73923b9a9558bf..3dae4f3c103802ed1c2cd390634bd5473192d4ee 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -44,6 +44,7 @@
 struct socfpga_dwmac;
 struct socfpga_dwmac_ops {
 	int (*set_phy_mode)(struct socfpga_dwmac *dwmac_priv);
+	void (*setup_plat_dat)(struct socfpga_dwmac *dwmac_priv);
 };
 
 struct socfpga_dwmac {
@@ -441,6 +442,39 @@ static int socfpga_dwmac_init(struct platform_device *pdev, void *bsp_priv)
 	return dwmac->ops->set_phy_mode(dwmac);
 }
 
+static void socfpga_common_plat_dat(struct socfpga_dwmac *dwmac)
+{
+	struct plat_stmmacenet_data *plat_dat = dwmac->plat_dat;
+
+	plat_dat->bsp_priv = dwmac;
+	plat_dat->fix_mac_speed = socfpga_dwmac_fix_mac_speed;
+	plat_dat->init = socfpga_dwmac_init;
+	plat_dat->pcs_init = socfpga_dwmac_pcs_init;
+	plat_dat->pcs_exit = socfpga_dwmac_pcs_exit;
+	plat_dat->select_pcs = socfpga_dwmac_select_pcs;
+}
+
+static void socfpga_gen5_setup_plat_dat(struct socfpga_dwmac *dwmac)
+{
+	struct plat_stmmacenet_data *plat_dat = dwmac->plat_dat;
+
+	socfpga_common_plat_dat(dwmac);
+
+	plat_dat->core_type = DWMAC_CORE_GMAC;
+
+	/* Rx watchdog timer in dwmac is buggy in this hw */
+	plat_dat->riwt_off = 1;
+}
+
+static void socfpga_agilex5_setup_plat_dat(struct socfpga_dwmac *dwmac)
+{
+	struct plat_stmmacenet_data *plat_dat = dwmac->plat_dat;
+
+	socfpga_common_plat_dat(dwmac);
+
+	plat_dat->core_type = DWMAC_CORE_XGMAC;
+}
+
 static int socfpga_dwmac_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat_dat;
@@ -491,31 +525,30 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 	dwmac->ops = ops;
 	dwmac->plat_dat = plat_dat;
 
-	plat_dat->bsp_priv = dwmac;
-	plat_dat->fix_mac_speed = socfpga_dwmac_fix_mac_speed;
-	plat_dat->init = socfpga_dwmac_init;
-	plat_dat->pcs_init = socfpga_dwmac_pcs_init;
-	plat_dat->pcs_exit = socfpga_dwmac_pcs_exit;
-	plat_dat->select_pcs = socfpga_dwmac_select_pcs;
-	plat_dat->core_type = DWMAC_CORE_GMAC;
-
-	plat_dat->riwt_off = 1;
+	ops->setup_plat_dat(dwmac);
 
 	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
 }
 
 static const struct socfpga_dwmac_ops socfpga_gen5_ops = {
 	.set_phy_mode = socfpga_gen5_set_phy_mode,
+	.setup_plat_dat = socfpga_gen5_setup_plat_dat,
 };
 
 static const struct socfpga_dwmac_ops socfpga_gen10_ops = {
 	.set_phy_mode = socfpga_gen10_set_phy_mode,
+	.setup_plat_dat = socfpga_gen5_setup_plat_dat,
+};
+
+static const struct socfpga_dwmac_ops socfpga_agilex5_ops = {
+	.set_phy_mode = socfpga_gen10_set_phy_mode,
+	.setup_plat_dat = socfpga_agilex5_setup_plat_dat,
 };
 
 static const struct of_device_id socfpga_dwmac_match[] = {
 	{ .compatible = "altr,socfpga-stmmac", .data = &socfpga_gen5_ops },
 	{ .compatible = "altr,socfpga-stmmac-a10-s10", .data = &socfpga_gen10_ops },
-	{ .compatible = "altr,socfpga-stmmac-agilex5", .data = &socfpga_gen10_ops },
+	{ .compatible = "altr,socfpga-stmmac-agilex5", .data = &socfpga_agilex5_ops },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, socfpga_dwmac_match);

-- 
2.43.7



