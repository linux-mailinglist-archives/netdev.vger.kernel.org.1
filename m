Return-Path: <netdev+bounces-238700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6549AC5DFE5
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 16:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3A814366D0C
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 15:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C908932ED5A;
	Fri, 14 Nov 2025 15:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="f+2PkKjc"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB6332ED55
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763134126; cv=none; b=MRYhp7EkuekZZDCA5wEyMLfRyi6K0SY5S+b8hIFWvQ+iPiJbJBKUElowP6yOHjFfhKLKJhYI6B5UBEscg2A+KHAaMpFS3HEs5JRsUNzDUyaQrnuDCtWOt8CT7EmJMuodDaftonyx1JnbVsomTKdon93XZFbSjotEWUFhj5Ki210=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763134126; c=relaxed/simple;
	bh=Jqh1EmWNb426rN+Fedf20x1RQrEEALLGgD/8jdAqgXw=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=MGBCefFHtMXTUiZ5c+4BW/hwmJuOxzln975oXBF+Vy1KHVrd2QR15N5zOzuF5VrxzvOMFW3Pq5LS6NHEFIyHoLA14RhzdahPl4mAnbM+G+2jJs8faYTgPPnYXHUujgnW2s14fvK+tMqVYdfhEK138ymk/N5/j/2qzT21IsW8UkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=f+2PkKjc; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Twus3sbrBSG7NY/CIFTfFSuDbIZ0IfgbuuTAgR3/MuY=; b=f+2PkKjcyy0ZBt+PQ+qC5DuZpm
	LR6aELWhmN121eH9u1WrcaH/3M/jFdUpLigQfEJ8XMHbBrHs1c/NNqiMx78+jEiZk9G0Dgx69YWNz
	VAKW/s9wYIBiHm6YHuQNgzWcBEXYy9+Qy6dFZnF4NQuAnfqOP6D8PZMBCcTfq7QNd69KuGiGBIdNa
	FEMulAkxlJMI85h+oDOmTp3TGH8z6maWTvKgp3IeFMDvYpdbDkypgZWn0pAlea+4zg2GwL3jYc/ty
	08MsZ6zwcnhZIoVoAG312whj+SsMjKxfrP7JeAb505AI2lJLJSvCtXy2FpZwBxqv7BMsEBNNk0ctj
	aM0DcADA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36184 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vJvj1-0000000076b-2knP;
	Fri, 14 Nov 2025 15:28:35 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vJvj0-0000000EVjb-1jDh;
	Fri, 14 Nov 2025 15:28:34 +0000
In-Reply-To: <aRdKVMPHXlIn457m@shell.armlinux.org.uk>
References: <aRdKVMPHXlIn457m@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chen Wang <unicorn_wang@outlook.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	sophgo@lists.linux.dev
Subject: [PATCH net-next 03/11] net: stmmac: move initialisation of clk_csr to
 stmmac_plat_dat_alloc()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vJvj0-0000000EVjb-1jDh@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 14 Nov 2025 15:28:34 +0000

Move the default initialisation of plat_dat->clk_csr to
stmmac_plat_dat_alloc().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c     | 2 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 5 -----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 1851f7d0702d..a36e8a90fcaa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7565,8 +7565,10 @@ struct plat_stmmacenet_data *stmmac_plat_dat_alloc(struct device *dev)
 
 	/* Set the defaults:
 	 * - phy autodetection
+	 * - determine GMII_Address CR field from CSR clock
 	 */
 	plat_dat->phy_addr = -1;
+	plat_dat->clk_csr = -1;
 
 	return plat_dat;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 745032fd46ce..fe3d95274fd6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -480,11 +480,6 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 		plat->bus_id = ++bus_id;
 	}
 
-
-	/* Default to get clk_csr from stmmac_clk_csr_set(),
-	 * or get clk_csr from device tree.
-	 */
-	plat->clk_csr = -1;
 	if (of_property_read_u32(np, "snps,clk-csr", &plat->clk_csr))
 		of_property_read_u32(np, "clk_csr", &plat->clk_csr);
 
-- 
2.47.3


