Return-Path: <netdev+bounces-197026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D58AD762D
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CFA518851D8
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85F72BEC3F;
	Thu, 12 Jun 2025 15:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="voQbuYRq"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A691B2BDC20
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749741731; cv=none; b=ja60UqexsMWvsAQumLGEy4SAIrtdMuu9YaPvJ5VEYXpcZssOWpqmlnNcWwtOjjcGcaG35SflMErZRmzyaqBqNRtbXE8wkrZ2gCJsKXNJdC1CpAyds2CfNlqxvFdrSYvDevWscW+qzRzLR5jF/thHC62LmdKyOftc9F61zc5cOHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749741731; c=relaxed/simple;
	bh=q+qzIUKyi2oftaz4Bsi1fcHA1qk2+IgJaheBq8hyh+M=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=Afe2NAgTESvz/pWHfTs6DrCTuQOBXPeHVr0BnrUolSo2xuwXn4NrEvtT/egWQYbhsG/WHC0eaf3VOwvI4Wo0F8M3rZ8BcOGDujj7aV9HpEqqRQuyMz7ukAufc1p0i8WTs1bFuX3StgEmJ/d/ijw1Q+Howu+tw4LnwJxjIpLGiBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=voQbuYRq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/wF+9Ix/fwH4D/k6aun5wQuB8ja0uch/p72DUM3MFBM=; b=voQbuYRqlPaJqX/FwxM/fkp+7R
	hMhKVZSsMFUVlN3Zr+Cu0s5GByPE+NcxB1GCoctgc7gY+uoJ9CfNsQwXZVI28dT9iBhClE7lgTwnk
	It/xsQd/s35I6/1wRLIe50yQ8SXGdtQaf6npVcOWE7E26uTnI3aIk9MqTpgbTGMnQ2YkJy/PrQe5f
	mwa2DdSxNahrhVthWaStNC14QwiCw+vIjS3kgye/Yur67kpoK2y5Jtyt9fz6z/BfTjOFf0YyHgPhA
	vNNHl7tkLx4s+Y73/N+Vu+1cKPOJPaElYnu5XP/msghik8tvCBG3XUfXT1+BybMSVLwcWyvtu87j/
	OouAJA0Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33414 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uPjkb-00081Y-2V;
	Thu, 12 Jun 2025 16:21:57 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uPjjx-0049r5-NN; Thu, 12 Jun 2025 16:21:17 +0100
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
Subject: [PATCH net-next] net: stmmac: improve .set_clk_tx_rate() method error
 message
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uPjjx-0049r5-NN@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 12 Jun 2025 16:21:17 +0100

Improve the .set_clk_tx_rate() method error message to include the
PHY interface mode along with the speed, which will be helpful to
the RK implementations.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 1369fa70bc58..24a4b82e934b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1062,8 +1062,8 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 						interface, speed);
 		if (ret < 0)
 			netdev_err(priv->dev,
-				   "failed to configure transmit clock for %dMbps: %pe\n",
-				   speed, ERR_PTR(ret));
+				   "failed to configure %s transmit clock for %dMbps: %pe\n",
+				   phy_modes(interface), speed, ERR_PTR(ret));
 	}
 
 	stmmac_mac_set(priv, priv->ioaddr, true);
-- 
2.30.2


