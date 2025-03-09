Return-Path: <netdev+bounces-173313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3FAA58539
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 16:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60B747A1F50
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 15:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB741552FD;
	Sun,  9 Mar 2025 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Ooz2HD5F"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4459933E4;
	Sun,  9 Mar 2025 15:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741532553; cv=none; b=KdeT4M+7NRbMhgUSBCpLX5EhY9C0BF9EusHtiitDQGSntIVT1DPdcRPXepdq/O+71UDXQweTqdKVKrOE2HbTrUyuhgVSENGVZxSvyjJiqdQ1r5YEoTrt7+rAPuCLhp+/9J6mWMR3Gi8LS42C7gEknqYMHYD6OxZBBmRxAfPEH3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741532553; c=relaxed/simple;
	bh=agWr1+75TSuqDd9vY09zaGOADQvRL8zL6HaI1ZBUQQo=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=VcO7TwywMn+K7sIqlm4myyvssFH19bNozzMpLphxFPU1+gphwujMxOokRLp8txLk1M0hlqTksTCm9VVKoyKYLw74QziAW6OsRQGP2iboHjtf1eCybmJHe3SyajODguQZAFqEpFbYrkeVPr2e3WpDSAjMPZXjTbR/8McT4Cw1Jfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Ooz2HD5F; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1GJLEqJTcLE/j9IX7nk50QB5Lf8CsNQlaa9n2xuwQLA=; b=Ooz2HD5FIp6+6+YlZonvhK1Gr7
	0ijXVuPyeD1k/yWOXlsC7QXI6dEgS16kn5PzaByG9Sbojuk5ODE58UCfceMjAnvVPfzDmZSa/mvmP
	EXLNd5Pso3fUw9N5+X6msZKWedOv5k0pN1ANfC6cWawp0s1GrdBOrXfBs2/TzPIRKUteEyVBkYhq9
	MgRb8KTw7pEcyzNr3DfQkqWwYQDj779X6Dc7+MJLukvWg/WZQGQzXrHqDrBUbxiIPwDr5asF4XB0s
	cR5zX3exc7/0sVTQzzSVXKf56oXC/KJfcJKYRk6u+dUb5fG+avGCyVJHSiq9G5gN/n+nmn453Y45+
	GgTnzHPg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:43088 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1trIAW-0001PS-0X;
	Sun, 09 Mar 2025 15:02:20 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1trIAA-005ntW-OZ; Sun, 09 Mar 2025 15:01:58 +0000
In-Reply-To: <Z82tWYZulV12Pjir@shell.armlinux.org.uk>
References: <Z82tWYZulV12Pjir@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Christophe Roullier <christophe.roullier@st.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	devicetree@vger.kernel.org,
	Emil Renner Berthing <kernel@esmil.dk>,
	Eric Dumazet <edumazet@google.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	netdev@vger.kernel.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH net-next 3/7] net: stmmac: stm32: use PHY capability for TX
 clock stop
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1trIAA-005ntW-OZ@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sun, 09 Mar 2025 15:01:58 +0000

Whether the MII transmit clock can be stopped is primarily a property
of the PHY (there is a capability bit that should be checked first.)
Whether the MAC is capable of stopping the transmit clock is a separate
issue, but this is already handled by the core DesignWare MAC code.

Add the flag to allow the stmmac core to use the PHY capability.

Cc: Christophe Roullier <christophe.roullier@st.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index 1fcb74e9e3ff..c3d321192581 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -538,6 +538,7 @@ static int stm32_dwmac_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	plat_dat->flags |= STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP;
 	plat_dat->bsp_priv = dwmac;
 
 	ret = stm32_dwmac_init(plat_dat, false);
-- 
2.30.2


