Return-Path: <netdev+bounces-212582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17187B214F0
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 20:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9585460D71
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 18:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB2C2E285D;
	Mon, 11 Aug 2025 18:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Vxpiq2pS"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999162E2DE4
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 18:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754938327; cv=none; b=WM4hOiuiQHN1r2svPTnjCjQM1T4s9i2CKcWzLDnWBLRMkk8okYOpIuk3jb2yZfcoQW3MuRHykSOrsNjBFD9e3/6kMTX4hOlhQfOrdaq5O7Pjh45a7ImKpkreDOij6N49nYMOyDvaOCubZIEAGtEKGbtFymGQiEi2UjjIUuMyMCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754938327; c=relaxed/simple;
	bh=glQ5M/FCxF16NNNFI3KQ5jhv/Lt0TH9zNilFUz+18rE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=DIFcSjJ31+3jcxrY0u+CgxeYjiAK7sdosxe/iUZZLYxUJgCx1tk8irR+JMPRETrwKaBVAN8ls0NY+aosKPZdCKFZFb4+boufR/a74ZcQVv20DGY3h71TYxo30Xt4Cz2/bcltt1wpSioSCpFikMTuUatLvd4dOJF0YGHX0Dl6Zes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Vxpiq2pS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=q1KjeJbB49ftbNOn2iCPBabBUaMVVVaJgJNr/pdOrlM=; b=Vxpiq2pSU59mQ/mD4qQ0ewS3My
	cx8Y89kxnQlO2cMXG8zIl+aZlT7kLRvo3tScinz9860YDMaugpKuAxWhHrUooJgQGb37k/uhfaJYg
	MYwGHnfABR6wQhze8fCo6mCfE+N+Y0alWwVuZ+SqqBkEwpaldxt2pzaSksElv7fq4d2sA7gHXu8dN
	hV599OMREjxeaSm2443Nh3rQanaoJKsFbBEJOkzGzB0fQvVVzsRa1FQfRCT8UUxpf/wJ38IwZoYPh
	NOo2JukfcNtlK6m8lKFFZ7SApOoe68l5WXNyGtUAUYIEAH+N4TBhwWeFI8HhNewJW5sWf5C+RrUN9
	oW38ZLYw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:48114 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1ulXcf-0003bj-3D;
	Mon, 11 Aug 2025 19:51:54 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1ulXbx-008gr4-5H; Mon, 11 Aug 2025 19:51:09 +0100
In-Reply-To: <aJo7kvoub5voHOUQ@shell.armlinux.org.uk>
References: <aJo7kvoub5voHOUQ@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 6/9] net: stmmac: pci: convert to suspend()/resume()
 methods
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ulXbx-008gr4-5H@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 11 Aug 2025 19:51:09 +0100

Convert pci to use the new suspend() and resume() methods rather
than implementing these in custom wrappers around the main driver's
suspend/resume methods.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_pci.c  | 73 +++++++++----------
 1 file changed, 35 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
index 9c1b54b701f7..e6a7d0ddac2a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
@@ -138,6 +138,37 @@ static const struct stmmac_pci_info snps_gmac5_pci_info = {
 	.setup = snps_gmac5_default_data,
 };
 
+static int stmmac_pci_suspend(struct device *dev, void *bsp_priv)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int ret;
+
+	ret = pci_save_state(pdev);
+	if (ret)
+		return ret;
+
+	pci_disable_device(pdev);
+	pci_wake_from_d3(pdev, true);
+	return 0;
+}
+
+static int stmmac_pci_resume(struct device *dev, void *bsp_priv)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int ret;
+
+	pci_restore_state(pdev);
+	pci_set_power_state(pdev, PCI_D0);
+
+	ret = pci_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	pci_set_master(pdev);
+
+	return 0;
+}
+
 /**
  * stmmac_pci_probe
  *
@@ -217,6 +248,9 @@ static int stmmac_pci_probe(struct pci_dev *pdev,
 	plat->safety_feat_cfg->prtyen = 1;
 	plat->safety_feat_cfg->tmouten = 1;
 
+	plat->suspend = stmmac_pci_suspend;
+	plat->resume = stmmac_pci_resume;
+
 	return stmmac_dvr_probe(&pdev->dev, plat, &res);
 }
 
@@ -231,43 +265,6 @@ static void stmmac_pci_remove(struct pci_dev *pdev)
 	stmmac_dvr_remove(&pdev->dev);
 }
 
-static int __maybe_unused stmmac_pci_suspend(struct device *dev)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-	int ret;
-
-	ret = stmmac_suspend(dev);
-	if (ret)
-		return ret;
-
-	ret = pci_save_state(pdev);
-	if (ret)
-		return ret;
-
-	pci_disable_device(pdev);
-	pci_wake_from_d3(pdev, true);
-	return 0;
-}
-
-static int __maybe_unused stmmac_pci_resume(struct device *dev)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-	int ret;
-
-	pci_restore_state(pdev);
-	pci_set_power_state(pdev, PCI_D0);
-
-	ret = pci_enable_device(pdev);
-	if (ret)
-		return ret;
-
-	pci_set_master(pdev);
-
-	return stmmac_resume(dev);
-}
-
-static SIMPLE_DEV_PM_OPS(stmmac_pm_ops, stmmac_pci_suspend, stmmac_pci_resume);
-
 /* synthetic ID, no official vendor */
 #define PCI_VENDOR_ID_STMMAC		0x0700
 
@@ -289,7 +286,7 @@ static struct pci_driver stmmac_pci_driver = {
 	.probe = stmmac_pci_probe,
 	.remove = stmmac_pci_remove,
 	.driver         = {
-		.pm     = &stmmac_pm_ops,
+		.pm     = &stmmac_simple_pm_ops,
 	},
 };
 
-- 
2.30.2


