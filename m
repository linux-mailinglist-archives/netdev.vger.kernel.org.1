Return-Path: <netdev+bounces-224078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C75B80767
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08CB21897FFC
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9928C330D30;
	Wed, 17 Sep 2025 15:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SlmhqyFo"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C3C32E726
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 15:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121988; cv=none; b=RWrDGHlKN2mXyngCD0mW0KP6I+hKDAkqYnnx8OWMH0u9IKrXmQrLKKFRX6sptei7eHGDKYhgMXJZl8c0cD9u9FOwF8IuwvEtroDOmauVcZsFbqSSkyBbbQdFNmTq6nFkCGr3qDj6ZXhiuMoJcdcCWbwKaHQ276bZ6fIS8tbNp7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121988; c=relaxed/simple;
	bh=34EJ6pDkqcZsMajuwkSSfulGTOzNogoKVuYbk1fxQVk=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=oQZXbETYF/wNTpKctj+q+tFOWyeFIl+S+4VJYBcmUleyhaONyxipn5gUukqd2/33JkEt+0pnbfk+LRbOBuei4KF7rZBEIDy/w1dIZMNTHq5g7nc+q3VYGQNPHNnwNSM7+qgGikO/INdfxHbKS+UXl8UHXPu6t8fOSGs2lgqlSTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=SlmhqyFo; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/+cmBKge/SratwvlMhVUxHK0tIPiknByDO1rJuSXVm8=; b=SlmhqyFof6KqXA7fToZCjE25Yy
	o0AAvTwle++S1quNnLBsSkVhKVvww69ySqa2zGCigqsKeUU4+QDxcPM0YEwby0YsWD731XCvcH+Kv
	n/dhwMtpmSSh3rgoaDSuTloqwAJCi+Bp/mcQVlMvSX2TdsuxZKMWqTRz2YiGfAtFCZw28UJwl+q6M
	7/1OwJ4c6nc5lFEjP9ZxcgtqNYDnMjSk6ZT9THhK3YELVE2MpJQFX19r67dL09CZ2nSsjq1V9o0bM
	KXGLDeKjwHpbEIqiqk7XEmXeCfKqjJ2uzJH5+anhzui+PsRaGc5hHT3m4HTjJgLRTxhlCT2yM64wJ
	Oeg6d9jg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35114 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uytpf-000000004lf-3YNK;
	Wed, 17 Sep 2025 16:12:32 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uytpa-00000006H2X-3GWx;
	Wed, 17 Sep 2025 16:12:26 +0100
In-Reply-To: <aMrPpc8oRxqGtVPJ@shell.armlinux.org.uk>
References: <aMrPpc8oRxqGtVPJ@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chen-Yu Tsai <wens@csie.org>,
	"David S. Miller" <davem@davemloft.net>,
	Drew Fustini <fustini@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Fu Wei <wefu@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Samuel Holland <samuel@sholland.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH net-next 06/10] net: stmmac: starfive: convert to use
 phy_interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uytpa-00000006H2X-3GWx@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 17 Sep 2025 16:12:26 +0100

dwmac-starfive uses RMII or RGMII interface modes without any PCS,
and selects the dwmac core accordingly using a register field with
the same bit encoding as the core's phy_intf_sel_i signals.

None of the DTS files set "mac-mode", so mac_interface will be
identical to phy_interface.

Convert dwmac-starfive to use phy_interface when determining the
interface mode rather than mac_interface. Also convert the error
prints to use phy_modes() so that we get a meaningful string rather
than a number for the interface mode.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
index 2013d7477eb7..6938dd2a79b7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
@@ -38,7 +38,7 @@ static int starfive_dwmac_set_mode(struct plat_stmmacenet_data *plat_dat)
 	unsigned int mode;
 	int err;
 
-	switch (plat_dat->mac_interface) {
+	switch (plat_dat->phy_interface) {
 	case PHY_INTERFACE_MODE_RMII:
 		mode = STARFIVE_DWMAC_PHY_INFT_RMII;
 		break;
@@ -51,8 +51,8 @@ static int starfive_dwmac_set_mode(struct plat_stmmacenet_data *plat_dat)
 		break;
 
 	default:
-		dev_err(dwmac->dev, "unsupported interface %d\n",
-			plat_dat->mac_interface);
+		dev_err(dwmac->dev, "unsupported interface %s\n",
+			phy_modes(plat_dat->phy_interface));
 		return -EINVAL;
 	}
 
-- 
2.47.3


