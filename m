Return-Path: <netdev+bounces-239946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8594C6E42B
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 12:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6E1F4F0F51
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 11:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974583538B2;
	Wed, 19 Nov 2025 11:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="n81tuClD"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041FA34EEE1
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763551773; cv=none; b=gN5GpDcKGd+vF3AcO+kPG2kwIW8omJ6qy3DHAF6NeDHlI1jFoZ07TVvJlkqymIi2RdDMzQ6QNqxvBVIrvbswm9dvXjnyofCJzwJcFVZqEPYqjJzOE6A2yOI7sySZeUl/44ZxH8900nQ0TsH97+KFqjfIR3EWapa2VPubp6Ym0N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763551773; c=relaxed/simple;
	bh=zxk/OnfIvItykpC4vgYRY0p5LSf7HLHRF8xiObpF5d0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=Bk6BkPlqdgCyzCoJDeycl55hWkNQrS6QvB/hO2zZrHap5ZTrAqFxRmza+crFtvDzIyyzyljWP2kEvIh6u8ZkgmP6kL1uvIOW0dY4/8cAIjLlSIG7t+zEZ99n//h42AcNg5ae4mN8IXvtjCJv201MZDoLaygu7c5ytRJp5VOd6XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=n81tuClD; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=r2DrchsSMJsw6gBUK4BX08ZijAjAZGrjaBRDLmbqutk=; b=n81tuClDJ3OLrzVmm47rB823Ln
	rFhLXfubGPK8H/auYA+vVqWctV+ZczPoFi9WHcgIg7kJbIAhqtDZ7+gRt6FRza06B0cXivW3EICJj
	BZ4WnP2M37Xqra/HKxY1kt0GLR+4QCwrsWXcnEoA+kmcVjqdLkHMlhN6U+x+TYwROIdMWES9lb1kh
	IYsvhlDXeN1HXQ40tpgF7L17JDgl1pY1HiVkmjo87bH9wf5L87B7ezIbEMg0P9C4fIOxvWBiMssQP
	yvJtIXg8nQCKt1P0uATGCsmXdMu0RXXbFk36QGM8Nm2X+VXhcJKkBF6SfVI3pFrLW77E3ET1rVfM1
	oNGzfMLw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36016 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vLgNA-000000004aH-3K0b;
	Wed, 19 Nov 2025 11:29:16 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vLgNA-0000000FMjN-0DSS;
	Wed, 19 Nov 2025 11:29:16 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net: stmmac: rk: use phylink's interface mode for
 set_clk_tx_rate()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vLgNA-0000000FMjN-0DSS@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 19 Nov 2025 11:29:16 +0000

rk_set_clk_tx_rate() is passed the interface mode from phylink which
will be the same as bsp_priv->phy_iface. Use the passed-in interface
mode rather than bsp_priv->phy_iface.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 6bfe82d7001a..0a95f54e725e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1735,8 +1735,7 @@ static int rk_set_clk_tx_rate(void *bsp_priv_, struct clk *clk_tx_i,
 	struct rk_priv_data *bsp_priv = bsp_priv_;
 
 	if (bsp_priv->ops->set_speed)
-		return bsp_priv->ops->set_speed(bsp_priv, bsp_priv->phy_iface,
-						speed);
+		return bsp_priv->ops->set_speed(bsp_priv, interface, speed);
 
 	return -EINVAL;
 }
-- 
2.47.3


