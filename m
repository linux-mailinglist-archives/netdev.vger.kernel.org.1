Return-Path: <netdev+bounces-235041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1C6C2B8AE
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 12:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E9AC4F7B63
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 11:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7BB3016F1;
	Mon,  3 Nov 2025 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="oHRCiuX+"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B301303C8E
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762170606; cv=none; b=Icx/hI87zP+eWqF9j2saNtYIFrMK0xhj8oVuIVKHF8ngX+Ur8BQjVBoeBoVL/o1rgRQupSkYWYwYRM++YnnOjz2FrGnfrGxX79kio7UBQug8OhKN3wphjlYwLMW6EDSdK9L+rCs1jJ8hcFJd+tw87jv/41tmRXFnXGGUkyhlgZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762170606; c=relaxed/simple;
	bh=ewOE6YnT3j0Xu8woT0FrilxeSuCBz+Se1xNrBX55jeI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=SlO4vCARHcfO/vVhG3PXEtccRyCMsmTxEbesmLya1lgv7D4Vk3p2/2vCG2vmxCpwTfLuDA/5sn/o1YcatOil7WJtqRP+dTicvMRsSoV2YWjbeMjx/lhSQ1QUgQOEeKHRLlri2UVUDU0nPOQSBTLq52sjO6QpOF3FNvrAxAZGcw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=oHRCiuX+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=F9+uCkTTPZNitcXoasL3jxbNQG9cxbs2rnefJEzDKW0=; b=oHRCiuX+2gLwNnnKwa0RLYg3gL
	EauuF8Y6wW6QGs+5nA7kr5ZfXqQZ8pU0F6xDX4B9MOpQLAz8PD6gOenUyb7/nzNCmVwwBXDgsr93z
	ut8ZdkehwkWGQiyb+YKRfoYUdcZm942v/wUT/Wx6T2tOo0SETfizaXMXtyqmMY0gVB3KM41bTVJUn
	pN1YbcxDKxb+0A/Bo/duo5PHibovEwr3fA44N8LU4BejXMlcFGPBYunbkBvovgc7N0wOAKHbWYyO9
	99XL8I5iLqdXD+hJJlCxE1643AwbW9vmWHVZGKz00Z5r8BE6EQUeZZ/L7tCr3jviMJ80V3RmF/UyF
	J/mU7P7g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:34308 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vFt4O-000000000fE-13d5;
	Mon, 03 Nov 2025 11:49:56 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vFt4N-0000000ChoM-1llp;
	Mon, 03 Nov 2025 11:49:55 +0000
In-Reply-To: <aQiWzyrXU_2hGJ4j@shell.armlinux.org.uk>
References: <aQiWzyrXU_2hGJ4j@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	s32@nxp.com,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH net-next 01/11] net: stmmac: imx: use phylink's interface mode
 for set_clk_tx_rate()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vFt4N-0000000ChoM-1llp@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 03 Nov 2025 11:49:55 +0000

imx_dwmac_set_clk_tx_rate() is passed the interface mode from phylink
which will be the same as plat_dat->phy_interface. Use the passed-in
interface mode rather than plat_dat->phy_interface.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index 4268b9987237..147fa08d5b6e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -195,9 +195,6 @@ static void imx_dwmac_exit(struct platform_device *pdev, void *priv)
 static int imx_dwmac_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
 				     phy_interface_t interface, int speed)
 {
-	struct imx_priv_data *dwmac = bsp_priv;
-
-	interface = dwmac->plat_dat->phy_interface;
 	if (interface == PHY_INTERFACE_MODE_RMII ||
 	    interface == PHY_INTERFACE_MODE_MII)
 		return 0;
-- 
2.47.3


