Return-Path: <netdev+bounces-237199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C31C4748F
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 15:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E2D33B4CCE
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 14:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EA7313E15;
	Mon, 10 Nov 2025 14:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Ha0ghIHW"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810F9313556
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762785781; cv=none; b=Uvkr3dBYDrJxZNDP3Ki91vliJuMSap9GtkPDutqKGYMvicq88HLE6ID6Idd1aq/3+Dqk1m0Zg+svzlfsn8D5spnd8KgbSKZvlGb/pz6+bDUoVmlVtHMnNOyap41+/0wDBp13f8DvseCkN1Pbut8Ql3ZtYF0HQGCKIWVl0reISVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762785781; c=relaxed/simple;
	bh=m5cGKxdnlmf4l8LBAgaK1wM/iNA0j7VYq6niNpeu898=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=YCHZMh6D/1XLOlIUc8xwnQ9sU57p94yqFg36V9ulpTi9bxJVA4pOLQMoAEjWY83JuMjr1GPV5xF3qHGUjHiVh0Ddz3edLNNehI6QIICeM3FZ8etT9jlLXNT4HUrXmVP+nIsfn/J4FRcYYMfUNYRvICw1ZQZpOG5/dVOlBPz7FEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Ha0ghIHW; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6E9WIaw66PDGRp95eNuxISWu6H2IBhekM5l5DjplXBU=; b=Ha0ghIHWCt1tD7IXbozdnTAqlB
	jcS7tuK6+jqM/x/oO8Xo5dbnVTq1k2VG5RttnZLIdrLKDYhC8xCTLNHINFXzUF0Dsd4Cv9qNAbVN2
	Xxnh469CV7C6tVXD7U1uh1pmKdZ1f8z0XIDG6QDp2dmqn55wYHcpzvPvvEpe/bd0JwHIyaMTqwK/D
	qiXoQ5KinIu6KRSnaqlMLiwQPyIgsPBjJuRnJHMKUrIsSNEvSkG6nnUjuqIGS1P+ZJqeBMoLTV7nK
	CrXAnVUJiwizZR9NgWWbNfrcjeKC3kE960jDGJ77zRB5KTvTMvS2AAE16qsD84Xf+jUX7e5k7Xy6J
	dxOEjfbQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41020 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vIT6X-000000001EF-0DHb;
	Mon, 10 Nov 2025 14:42:49 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vIT6W-0000000DpPR-0tby;
	Mon, 10 Nov 2025 14:42:48 +0000
In-Reply-To: <aRH50uVDX4_9O5ZU@shell.armlinux.org.uk>
References: <aRH50uVDX4_9O5ZU@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 2/3] net: stmmac: meson8b: use phy_intf_sel
 directly
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vIT6W-0000000DpPR-0tby@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 10 Nov 2025 14:42:48 +0000

Rearrange meson_axg_set_phy_mode() to use phy_intf_sel directly,
converting it to the register field for meson8b_dwmac_mask_bits().

Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-meson8b.c  | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
index f485b9b858bf..865cd6166134 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
@@ -26,8 +26,6 @@
 #define PRG_ETH0_RGMII_MODE		BIT(0)
 
 #define PRG_ETH0_EXT_PHY_MODE_MASK	GENMASK(2, 0)
-#define PRG_ETH0_EXT_RGMII_MODE		PHY_INTF_SEL_RGMII
-#define PRG_ETH0_EXT_RMII_MODE		PHY_INTF_SEL_RMII
 
 /* mux to choose between fclk_div2 (bit unset) and mpll2 (bit set) */
 #define PRG_ETH0_CLK_M250_SEL_MASK	GENMASK(4, 4)
@@ -238,21 +236,19 @@ static int meson8b_set_phy_mode(struct meson8b_dwmac *dwmac)
 
 static int meson_axg_set_phy_mode(struct meson8b_dwmac *dwmac)
 {
+	int phy_intf_sel;
+
 	switch (dwmac->phy_mode) {
 	case PHY_INTERFACE_MODE_RGMII:
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_ID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		/* enable RGMII mode */
-		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
-					PRG_ETH0_EXT_PHY_MODE_MASK,
-					PRG_ETH0_EXT_RGMII_MODE);
+		phy_intf_sel = PHY_INTF_SEL_RGMII;
 		break;
 	case PHY_INTERFACE_MODE_RMII:
 		/* disable RGMII mode -> enables RMII mode */
-		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
-					PRG_ETH0_EXT_PHY_MODE_MASK,
-					PRG_ETH0_EXT_RMII_MODE);
+		phy_intf_sel = PHY_INTF_SEL_RMII;
 		break;
 	default:
 		dev_err(dwmac->dev, "fail to set phy-mode %s\n",
@@ -260,6 +256,10 @@ static int meson_axg_set_phy_mode(struct meson8b_dwmac *dwmac)
 		return -EINVAL;
 	}
 
+	meson8b_dwmac_mask_bits(dwmac, PRG_ETH0, PRG_ETH0_EXT_PHY_MODE_MASK,
+				FIELD_PREP(PRG_ETH0_EXT_PHY_MODE_MASK,
+					   phy_intf_sel));
+
 	return 0;
 }
 
-- 
2.47.3


