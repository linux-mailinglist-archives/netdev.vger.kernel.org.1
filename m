Return-Path: <netdev+bounces-183200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BCDA8B571
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 11:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC3BE5A1607
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 09:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4575A2356C3;
	Wed, 16 Apr 2025 09:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lfACA7dD"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0FA23536F
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 09:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744795953; cv=none; b=AiUqjSb4X/NlgsZx9tCowl4LIZmuw/fW28xhclfvpsljss7Y3cri0oF/2aiB76I3WLboiycLeROduR34LIaK7HRjqiYXIEHfXXw1034bvl4KGCIzGbvVEmnsWNDtZGYD9dyphOQU7akqAtJWi26zxFee2/GbIG0jlYY3OiL15PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744795953; c=relaxed/simple;
	bh=TwDz3TDNqvJqCkFQm7H4X30ItLunZD9sTp0ZyNrGCd0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Z7gGVAVnKBsgQmhsRM0j3mArCo8oSxDEXJmOnbrd7zqlh/4bbtojKllU2rGQ4xnrlEz2MLRe4Vi7CHfhYyiIJSaGT/J/X4pChu0AAZpVfAam5mbb7QFJoAXpQ3AcmTvFseUQArqZH8iK2Efxa2dhV42ou/77FHKLU5J3uqA+8uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=lfACA7dD; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Av+e+xwJa3OI09Ag1r1Hzotm7mvuweVojm+b6LjeE4s=; b=lfACA7dDTBUWIPCipjvBcvAexG
	VnUrbZkaBEYTYsE22ujoo1nty1nc86lyIb2TaYin1pMPt/y4PGcCR2/EzB/ootNYtYfdLFc42EiJK
	15oSr5h1UQgu/16sYWrEXQfJ0jtGlwWiJ73+aN5Oknsz6oM7BLFnLmUnwtDt7e/p9EtJsvZrTLTNG
	vHCCAnEE/YwJQpxXTG2BcN0aHvAY3pW1FhQVS3pJyDYoLl7vcrpFUjD6724XgNRW2a7aTGL28qHvG
	RK1b32dU8gHQQfvkowKIDwrYF+e6b2K0SeipRBL4xFG0DkdCBvbnXRNcUF8p9nSV6WEaQpximcrgF
	stjtMm7A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:45066 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u4z81-0000zW-1Y;
	Wed, 16 Apr 2025 10:32:21 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u4z7P-000xC0-8U; Wed, 16 Apr 2025 10:31:43 +0100
In-Reply-To: <Z_95AM64tt_4ri1j@shell.armlinux.org.uk>
References: <Z_95AM64tt_4ri1j@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v2 5/5] net: stmmac: socfpga: convert to
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
Message-Id: <E1u4z7P-000xC0-8U@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 16 Apr 2025 10:31:43 +0100

Convert socfpga to use devm_stmmac_pltfr_probe() to further simplify
the probe function, wrapping the call to the set_phy_mode() method
into socfpga_dwmac_init() which can be called from the plat_dat->init()
method. Also call this from socfpga_dwmac_resume() thereby simplifying
that function.

Using the devm variant also means we can remove the call to
stmmac_pltfr_remove().

Unfortunately, we can't also convert to stmmac_pltfr_pm_ops as there is
extra work done in socfpga_dwmac_resume().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index c7c120e30297..59f90b123c5b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -500,11 +500,7 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 
 	plat_dat->riwt_off = 1;
 
-	ret = socfpga_dwmac_init(pdev, dwmac);
-	if (ret)
-		return ret;
-
-	return stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
+	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
 }
 
 static const struct socfpga_dwmac_ops socfpga_gen5_ops = {
@@ -524,7 +520,6 @@ MODULE_DEVICE_TABLE(of, socfpga_dwmac_match);
 
 static struct platform_driver socfpga_dwmac_driver = {
 	.probe  = socfpga_dwmac_probe,
-	.remove = stmmac_pltfr_remove,
 	.driver = {
 		.name           = "socfpga-dwmac",
 		.pm		= &stmmac_pltfr_pm_ops,
-- 
2.30.2


