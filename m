Return-Path: <netdev+bounces-182877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 421F4A8A425
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 18:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E85A7A62D3
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 16:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F3728DF18;
	Tue, 15 Apr 2025 16:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cv+yuFcd"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5EB20A5F2
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 16:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744734592; cv=none; b=mUTKE8cLVXmxcM5IRjfFcQMExO+x6s2AiYFb6cgrGY9VUAfhL/KUIg99+uvc91y0AAZuYYYDo5Ez/M89LDCRgqVRofRZ2FjkGpvLgYNQhsm1ikGlZunfnuLcN3RCWU5TLqMft1SDrMsAWzasSRghATmV3ztvFYeMuNXwhzWlVt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744734592; c=relaxed/simple;
	bh=SqNLD2seLZpye58gORKXZH1fUKMkd249tBAXxnkOndc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=LhJEgVP2Xb3gp9TpIjK81FnQUfZzgv3htDFxND9xK8o1Obg0dtHXOctNu6WazxpW+fzCrNz50n5FEf+djorCjsavIz2zs9YuCOxRjCG0JxMhg9YRMUbA0Ug89P8hRImDyhRpeQG4f14i3HH7qLF69o/g0m7W7XcBxfC70JMhgk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=cv+yuFcd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=z8hTSVnlcCC2WOnj66TO/Zt9nedPd+37sOl0zL+RseU=; b=cv+yuFcdgRsHPbn6xvXd3cs8vi
	54sX8Ma38PHYUmmoHY9kT3b1LiWcyoY2h8dravFRaeA/O0hh0Z3Eph7FKNeb5c+aFHICwA7GC13np
	CqTvKQoUfm0CPY14ofnHiPhfWV7zgvYPk0idwz10fXSzdH/HS3/K70sVamtILY8sHajeiuA+oWTmD
	u83G6tv8IUH4D161dwjGn3k3r/EBUqJCbMlCgfsN8h0eM8vZW0ZZX3JdBol9h9hDcZM1nGXgb3NOs
	NtxsytLX+iQrkgLXNnS1B7M07IPYAUvDBS3MSrSqAy2MIVZxNphM3Lo/aEBE6Wvgm4soFkzYlQzVB
	cw9KEWEQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39600 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u4jAO-0008TK-0P;
	Tue, 15 Apr 2025 17:29:44 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u4j9m-000r1J-Nu; Tue, 15 Apr 2025 17:29:06 +0100
In-Reply-To: <Z_6JaPBiGu_RB4xN@shell.armlinux.org.uk>
References: <Z_6JaPBiGu_RB4xN@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 1/5] net: stmmac: socfpga: init dwmac->stmmac_rst
 before registration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u4j9m-000r1J-Nu@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 15 Apr 2025 17:29:06 +0100

Initialisation/setup after registration is a bug. This is the first of
two patches fixing this in socfpga.

dwmac->stmmac_rst is initialised from the stmmac plat_dat's stmmac_rst
member, which is itself initialised by devm_stmmac_probe_config_dt().
Therefore, this can be initialised before we call stmmac_dvr_probe().
Move it there.

dwmac->stmmac_rst is used by the set_phy_mode() method.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 116855658559..bcdb25ee2a33 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -442,8 +442,6 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 	struct device		*dev = &pdev->dev;
 	int			ret;
 	struct socfpga_dwmac	*dwmac;
-	struct net_device	*ndev;
-	struct stmmac_priv	*stpriv;
 	const struct socfpga_dwmac_ops *ops;
 
 	ops = device_get_match_data(&pdev->dev);
@@ -479,7 +477,13 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* The socfpga driver needs to control the stmmac reset to set the phy
+	 * mode. Create a copy of the core reset handle so it can be used by
+	 * the driver later.
+	 */
+	dwmac->stmmac_rst = plat_dat->stmmac_rst;
 	dwmac->ops = ops;
+
 	plat_dat->bsp_priv = dwmac;
 	plat_dat->fix_mac_speed = socfpga_dwmac_fix_mac_speed;
 	plat_dat->pcs_init = socfpga_dwmac_pcs_init;
@@ -493,15 +497,6 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ndev = platform_get_drvdata(pdev);
-	stpriv = netdev_priv(ndev);
-
-	/* The socfpga driver needs to control the stmmac reset to set the phy
-	 * mode. Create a copy of the core reset handle so it can be used by
-	 * the driver later.
-	 */
-	dwmac->stmmac_rst = stpriv->plat->stmmac_rst;
-
 	ret = ops->set_phy_mode(dwmac);
 	if (ret)
 		goto err_dvr_remove;
-- 
2.30.2


