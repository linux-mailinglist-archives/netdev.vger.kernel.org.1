Return-Path: <netdev+bounces-103166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2268F906A29
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 12:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F82A1C2261C
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 10:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BB71411FD;
	Thu, 13 Jun 2024 10:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FtphimOK"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE5F1411E1
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 10:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718274998; cv=none; b=YnmlYb/TA8Zn71zOm+85JNFsyl1vb6ETC21q7P095SUUqoIpb9Rf4QvnVDkoLlhx0zVV/V4f0234gTSQpyDl+1hjThIsJ5Rh+qPPmsumM4weYTK/uPOXuRaVrGBj8T8bw6xXrB45iKcv1cCl7WoapLeqaWHfxANU+KGdwQ3am4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718274998; c=relaxed/simple;
	bh=to99i3WcWB8bdM8MV5dcZ4PqJgggYIvi4uKgWQmpRW0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=lc7uuwWIXDbuPmFu8bgajduZ5ciDCvAgiXfIpuo2IdbX+1VhzCy77v127Bg+49JZQ3NxOKMZ+fmgBSAlvRM4vcbdQfoyUk+d0bmcjwYbcTUZ7Z0oic5aABHMcOjorW5Whwkjb3gODXcjgStwfp8CXz6ilFIMbxw7lZKDDEpaG4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FtphimOK; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3YcU0h+RwRCQqxSXT+1nqupcEZSyGlWJEzarU5h90wc=; b=FtphimOK42g+MzpDJZTh89RCMf
	uS/RWeRemihhB2lMmciXr2h9x3RjIIX/RD3UH9HUUAC6Qs1W7Raap3hL+gBAixczQqzMbdORNHVvC
	LjvxzrXj06SDd4SFf9nD8uvS965gzBl1UVKx1gJuTsP+Sl8P6Ltvn1x3tObXf487MvBfAZ5u2G8hj
	oUQYjBbWXxmCjjphiBNydGV0yR4I7E38DOXYtSQ6ZQfaAiLHZjf4obaTTbN4LeVr82/gvADKVnDOa
	jTK8w0PpSD/FwKeo7e36HPWe0i2OFNL/La7mqzUvYbVPBnvMchSnxelz/mJM9eLVyeQoLQlf7QdbW
	CJWA49MQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:45514 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sHhoZ-00065z-1i;
	Thu, 13 Jun 2024 11:36:19 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sHhob-00FetN-Vp; Thu, 13 Jun 2024 11:36:22 +0100
In-Reply-To: <ZmrLbdwv6ALoy+gs@shell.armlinux.org.uk>
References: <ZmrLbdwv6ALoy+gs@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH net-next v2 4/5] net: stmmac: dwmac-socfpga: provide
 select_pcs() implementation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sHhob-00FetN-Vp@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 13 Jun 2024 11:36:21 +0100

Provide a .select_pcs() implementation which returns the phylink PCS
that was created in the .pcs_init() method.

Reviewed-by: Romain Gantois <romain.gantois@bootlin.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index b3d45f9dfb55..fdb4c773ec98 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -429,6 +429,12 @@ static void socfpga_dwmac_pcs_exit(struct stmmac_priv *priv)
 		lynx_pcs_destroy(priv->hw->phylink_pcs);
 }
 
+static struct phylink_pcs *socfpga_dwmac_select_pcs(struct stmmac_priv *priv,
+						    phy_interface_t interface)
+{
+	return priv->hw->phylink_pcs;
+}
+
 static int socfpga_dwmac_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat_dat;
@@ -478,6 +484,7 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 	plat_dat->fix_mac_speed = socfpga_dwmac_fix_mac_speed;
 	plat_dat->pcs_init = socfpga_dwmac_pcs_init;
 	plat_dat->pcs_exit = socfpga_dwmac_pcs_exit;
+	plat_dat->select_pcs = socfpga_dwmac_select_pcs;
 
 	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
 	if (ret)
-- 
2.30.2


