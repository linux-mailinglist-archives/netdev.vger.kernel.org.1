Return-Path: <netdev+bounces-182889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25633A8A46C
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 18:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F87B189EBB5
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 16:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD9E297A49;
	Tue, 15 Apr 2025 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qKUEAxtB"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FED27F74F
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 16:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744735399; cv=none; b=eNL4nGrWvfFXD6N0DbPVOR2+kJVTHycWAEyTDgJrqJqHpJrAI4KhoA7XpIurLF6F6vv7vvRsp42fUcokOvhgo50Oiq1UOU6iU6EnTlsMY4T9JYgU6BDwFW26MqJJvcZ1BcyFKISlC1Xq2aTrsjZ0oNYXf8VuIMC9xMOMjKouh+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744735399; c=relaxed/simple;
	bh=nrl+bjwByDI02WzRE+swFSDDyA9+zzRLRTrYNkeo6oE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=bJF+DfrGkOxYurY50pNQA8PrzxkQM9JjaQuw/+MWSfNRVvxLDn3xU5fKaZkC0Zn6evkOg4SnN6Yhd01Ozhwtgqxo0NQKIullgpd85Dfl7LxnhNbAy05kdtedwtNFruYEAo610fwh9kUaKl5FvFLQv6qa0Pw8UKytM84JUzleVeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qKUEAxtB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3D1RJ0/Ps/DvFGgzYJpHiZKHJVAnkqEv0/IjI/ebBHM=; b=qKUEAxtBHWydPkd/XUkJulqAuq
	USPeyYYN9yYJ+kE4Io4U/4NCtbXseSPJbQh1d855r/jVbfGK5MGB3/LtFBVyGngH4OXZh7XJoFcC8
	+2Jof+xiTsFMEm21T4txvRrZxx0k+UqA+/e/gwF9qmu8A60ILslyaAJyHp8lZu84ALBs6vmAnOLJa
	hMEV+TwLVNttPutLTAULdZ3K1O5VhqkSP+7UjJW1b75ulunlGSFOQ167HfTplV9GbVn8XSFy4psOw
	TtVwrdDuiVvaH6wP1huLvoo05no2pw4wfRSgeRzxVFUDcbu0LF7a1LbDMG5D1XLN7wXui+3fuqIXp
	jfi9uX3Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35474 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u4jNK-0008W4-1c;
	Tue, 15 Apr 2025 17:43:06 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u4jMj-000rCM-31; Tue, 15 Apr 2025 17:42:29 +0100
In-Reply-To: <Z_6Mfx_SrionoU-e@shell.armlinux.org.uk>
References: <Z_6Mfx_SrionoU-e@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 2/3] net: stmmac: sti: convert to
 devm_stmmac_pltfr_probe()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u4jMj-000rCM-31@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 15 Apr 2025 17:42:29 +0100

Convert sti to use the generic devm_stmmac_pltfr_probe() which will
call plat_dat->init()/plat_dat->exit() as appropriate, thus
simplifying the code.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-sti.c   | 54 +++++++++----------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
index c580647ff9dc..b6e09bd33894 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
@@ -233,6 +233,29 @@ static int sti_dwmac_parse_data(struct sti_dwmac *dwmac,
 	return 0;
 }
 
+static int sti_dwmac_init(struct platform_device *pdev, void *bsp_priv)
+{
+	struct sti_dwmac *dwmac = bsp_priv;
+	int ret;
+
+	ret = clk_prepare_enable(dwmac->clk);
+	if (ret)
+		return ret;
+
+	ret = sti_dwmac_set_mode(dwmac);
+	if (ret)
+		clk_disable_unprepare(dwmac->clk);
+
+	return ret;
+}
+
+static void sti_dwmac_exit(struct platform_device *pdev, void *bsp_priv)
+{
+	struct sti_dwmac *dwmac = bsp_priv;
+
+	clk_disable_unprepare(dwmac->clk);
+}
+
 static int sti_dwmac_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat_dat;
@@ -269,34 +292,10 @@ static int sti_dwmac_probe(struct platform_device *pdev)
 
 	plat_dat->bsp_priv = dwmac;
 	plat_dat->fix_mac_speed = data->fix_retime_src;
+	plat_dat->init = sti_dwmac_init;
+	plat_dat->exit = sti_dwmac_exit;
 
-	ret = clk_prepare_enable(dwmac->clk);
-	if (ret)
-		return ret;
-
-	ret = sti_dwmac_set_mode(dwmac);
-	if (ret)
-		goto disable_clk;
-
-	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
-	if (ret)
-		goto disable_clk;
-
-	return 0;
-
-disable_clk:
-	clk_disable_unprepare(dwmac->clk);
-
-	return ret;
-}
-
-static void sti_dwmac_remove(struct platform_device *pdev)
-{
-	struct sti_dwmac *dwmac = get_stmmac_bsp_priv(&pdev->dev);
-
-	stmmac_dvr_remove(&pdev->dev);
-
-	clk_disable_unprepare(dwmac->clk);
+	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
 }
 
 static int sti_dwmac_suspend(struct device *dev)
@@ -334,7 +333,6 @@ MODULE_DEVICE_TABLE(of, sti_dwmac_match);
 
 static struct platform_driver sti_dwmac_driver = {
 	.probe  = sti_dwmac_probe,
-	.remove = sti_dwmac_remove,
 	.driver = {
 		.name           = "sti-dwmac",
 		.pm		= pm_sleep_ptr(&sti_dwmac_pm_ops),
-- 
2.30.2


