Return-Path: <netdev+bounces-182319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C6FA887C9
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F3771892FCD
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D7D274FE5;
	Mon, 14 Apr 2025 15:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Wbl8gfon"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA2F253938
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744645912; cv=none; b=jYRyM+reWE0aHtnwyc3PKAMjkiHJxkdToqGCoVnRjI2BPyXJr072Ae0L3u0JoFCBvW/erewnnaNN3RpPizMlk/4TGbMN+e3mXeHvuqcG/oUdZLPZVNJxSjVZITdwgC8NY/ukFAmikzbedqlZX/NucxFULMOx5zDWQ/c5JJKDk0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744645912; c=relaxed/simple;
	bh=GVmgyE4Vbzi9knYGLrIXCjSqCsshNxkBt5vGwKTRyBE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=eUGv9zJyEW4FQvIeZohOavS/vjj1+RdoKK2S3lSls3hOkh4tDt5HVDz3zcEJIy2/YupQSIRJWJ/BkngzlR8FozQza8W1x9BS6JZGAjhgshgiv7MOxBOHEjwFJI4mNfTt2mAp1B3N4hXrF42tj2P/ivfjF0e1KqApsJSR483jFek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Wbl8gfon; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HhFzwgkdtFig+wSBVpbiTQ6PyiK1BHIb2bxLfvyCxnQ=; b=Wbl8gfonUQZznefGkRxyfoZSbu
	XayvzADa8sqk88ah+QtUcvFL0yjtwd9Uh8eyEICwpjndetOBUPoDA0JBnK4iKMsdfOhNmM+un+VDJ
	IxpfD2jYyC/FI2WoAOJVh46fjXy0oCffACU1we/+Fc78LhkyzpI/YHsuDjM+AqUpKACcVGUWQ8tgD
	N4LUjaBK5Xnyzdk8qCA0j9ZrXYWNTiZ9bziBUdzLxlHi+KNKjTE7BgH4RoB7bPogmnEaVwts6pamj
	SzCmSR5Q/qUUg7d997Ieid+JzBHU29ho1a8znibPA4M16MD3jsL40Hn1ZrMrrLBftNeY6oP769Aqs
	vLI5vW+g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:47062 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u4M63-0006oO-2G;
	Mon, 14 Apr 2025 16:51:43 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u4M5S-000YGJ-9K; Mon, 14 Apr 2025 16:51:06 +0100
In-Reply-To: <Z_0u9pA0Ziop-BuU@shell.armlinux.org.uk>
References: <Z_0u9pA0Ziop-BuU@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 2/2] net: stmmac: ingenic: convert to
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
Message-Id: <E1u4M5S-000YGJ-9K@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 14 Apr 2025 16:51:06 +0100

As Ingenic now uses the stmmac platform PM ops, convert it to use
devm_stmmac_pltfr_probe() which will call the plat_dat->init() method
before stmmac_drv_probe() and appropriately cleaning up via the
->exit() method, thus simplifying the code. Using the devm_*()
variant also allows removal of the explicit call to
stmmac_pltfr_remove().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
index 607e467324a4..15abe214131f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
@@ -290,11 +290,7 @@ static int ingenic_mac_probe(struct platform_device *pdev)
 	plat_dat->bsp_priv = mac;
 	plat_dat->init = ingenic_mac_init;
 
-	ret = ingenic_mac_init(pdev, mac);
-	if (ret)
-		return ret;
-
-	return stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
+	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
 }
 
 static struct ingenic_soc_info jz4775_soc_info = {
@@ -345,7 +341,6 @@ MODULE_DEVICE_TABLE(of, ingenic_mac_of_matches);
 
 static struct platform_driver ingenic_mac_driver = {
 	.probe		= ingenic_mac_probe,
-	.remove		= stmmac_pltfr_remove,
 	.driver		= {
 		.name	= "ingenic-mac",
 		.pm		= &stmmac_pltfr_pm_ops,
-- 
2.30.2


