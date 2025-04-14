Return-Path: <netdev+bounces-182084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A53A87B72
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 11:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E95D0188DD0D
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 09:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0809125A622;
	Mon, 14 Apr 2025 09:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Ksk8Fdnd"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0CF2580DD
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 09:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744621610; cv=none; b=WR2HmXAMtnV/KaAAwDsNrPoT9IPCuvAb1WEaqyyOq0Gq8w53yyE6Y2dYkttYlTAau4qF3IpYBn4SM+gzVsfhwE98P98FDPmjah7zw1ozQ+YgVyW+JKfojLb+3W+mUhYlrlX+TJbt3a5DnDl8UT3M3BHB1yLEGZlwtu9b24e0Kks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744621610; c=relaxed/simple;
	bh=zH/5phUGJR8FARgeqvxh5Rf6IpaCrTawyqfihw4DW78=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=iMdNicVS8x79A5jbn0gglvMGsiMa7Htyfbp7vfJMHNCrDEGLBKuNmbEg9cuSycZfTFhYzWEaBCHCzz6bboXhZVPcN6TeBRp5XpTNjdlU5ahKPoo5doYyFq+9Bguj1Ki1fegmzUwQ/491czpU/LjzGdlxmnA0prceIOFPbugU2eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Ksk8Fdnd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+yO9l6NypA73F3si3x4Rah7yT1uH33qyI9s83W5hLGc=; b=Ksk8FdndM/GvS83XU3Qi1TovIF
	vpPq5U5SvLmfp2wxasbmXUh9qY3X2YoHgIJO6b3oub93pP7Dd1egaT4m9heeT9eGCPcOGZvmbKgf9
	9Z8KTbCeaQEw0+OCkZq/mcxgMwqk4XSCabtddXndmXVLrufATGSM+RfOY95CuknWnmKcrhGStynCV
	ZR3IdSgt/rZ6h6J9S1rj3wHIkTC9QtFePf5zyzu1I11pzxmpl6twZFvW/fmukxnfXgN/ZcoAznrMh
	dRjL+235NHC0AwvnSZebXC/KKzpUog2GsnIaZLqm8e5+mHONY382QqHFMVTw6kF7lIigFrpt7sdfx
	CAzmR4NA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46022 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u4Fm1-0006CQ-1T;
	Mon, 14 Apr 2025 10:06:37 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u4FlQ-000XjA-2V; Mon, 14 Apr 2025 10:06:00 +0100
In-Reply-To: <Z_zP9BvZlqeq3Ssl@shell.armlinux.org.uk>
References: <Z_zP9BvZlqeq3Ssl@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v2 1/4] net: stmmac: anarion: clean up
 anarion_config_dt() error handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u4FlQ-000XjA-2V@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 14 Apr 2025 10:06:00 +0100

When enabled, print a user friendly description of the error when
failing to ioremap() the control resource, and use ERR_CAST() when
propagating the error. This allows us to get rid of the "err" local
variable in anarion_config_dt().

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
index 37fe7c288878..232aae752690 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
@@ -65,13 +65,12 @@ anarion_config_dt(struct platform_device *pdev,
 {
 	struct anarion_gmac *gmac;
 	void __iomem *ctl_block;
-	int err;
 
 	ctl_block = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(ctl_block)) {
-		err = PTR_ERR(ctl_block);
-		dev_err(&pdev->dev, "Cannot get reset region (%d)!\n", err);
-		return ERR_PTR(err);
+		dev_err(&pdev->dev, "Cannot get reset region (%pe)!\n",
+			ctl_block);
+		return ERR_CAST(ctl_block);
 	}
 
 	gmac = devm_kzalloc(&pdev->dev, sizeof(*gmac), GFP_KERNEL);
-- 
2.30.2


