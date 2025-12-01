Return-Path: <netdev+bounces-242988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A02C97E98
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 15:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 30BCE342FCB
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 14:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C865131A07B;
	Mon,  1 Dec 2025 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sE+OOrbT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172EE3101A7
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764600673; cv=none; b=nFLd/JScBIO+xAORwdA73fFjDYCIGku6EjNrkdzAo0fJqauH5vAkc35hnXqwEE3Pg0J/kCFsQCD8EYdCfnH7q9lrPKfxzI3HZc4Ntmp30QVwE4aEaAMmAMES5PnFVaL1EI2CpjSgUl//G9VjJ+9st3435LH4VJsGHd8IYN3Gj/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764600673; c=relaxed/simple;
	bh=GUXwEp4BCERIspeav5hcwnir74AkpDW/E+Ji1pgp0W4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=py4fQ6hCd+GUh5a+CBkcng8SvLC8doxt2mwAyCbhsBwGXhtN2MUQIBDxKHadE/41bZ5dvtDOhxFkMwiWpPmf17hrL7+zLSKGawZu7i4G4mPA/nzrNhiWbv2tw3vr2u3kBeFsjsO6E2ir1++NwCuC+RpbRo535jrCnp6dfvSrLhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sE+OOrbT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=J9r8fFObJXa5DBjyXPkjBldkH6IAUdkLbluOsbjvx8I=; b=sE+OOrbT7htgoFdyHzRr7x1bqX
	N4oxyiAoRkGOan/BMn7k6rZLzWRzsOrcWNzwNIPY7XDut3nOGGVh+ZqZvpMTGEkV3UHcCXMshEBi9
	JbkzladXuSa+7znpjbhyLkvcSVlxKoCDV9rPD9TWV+tDsbTy24WrvbTo4ABgzFzpO6mY02N4tezCx
	UttrX9Dx3K9WdzPXXI8EcWH/qZhLI1+YJAto9iOFG7FFzWPI4Lp1VO+T3oOtyTP1sC1xlWGHHSsWM
	OlXIevTVeqAvbXgQ5eOJviNt6uIfjY563R4P1jIB8E3dkLW5H0wARGiwLQD3vbc5DnSvGj3K98bf4
	rE+RowRw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:43544 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vQ5Ew-000000000fU-3De3;
	Mon, 01 Dec 2025 14:50:59 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vQ5Ev-0000000GNvg-3uGh;
	Mon, 01 Dec 2025 14:50:57 +0000
In-Reply-To: <aS2rFBlz1jdwXaS8@shell.armlinux.org.uk>
References: <aS2rFBlz1jdwXaS8@shell.armlinux.org.uk>
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
Subject: [PATCH RFC net-next 03/15] net: stmmac: rk: add SoC specific ->init()
 method
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vQ5Ev-0000000GNvg-3uGh@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 01 Dec 2025 14:50:57 +0000

Add a SoC specific init method.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index f9bc9b145ff4..e9f531d6c22a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -35,6 +35,7 @@ struct rk_reg_speed_data {
 };
 
 struct rk_gmac_ops {
+	int (*init)(struct rk_priv_data *bsp_priv);
 	void (*set_to_rgmii)(struct rk_priv_data *bsp_priv,
 			     int tx_delay, int rx_delay);
 	void (*set_to_rmii)(struct rk_priv_data *bsp_priv);
@@ -1613,6 +1614,14 @@ static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
 
 	bsp_priv->dev = dev;
 
+	if (ops->init) {
+		ret = ops->init(bsp_priv);
+		if (ret) {
+			dev_err_probe(dev, ret, "failed to init BSP\n");
+			return ERR_PTR(ret);
+		}
+	}
+
 	return bsp_priv;
 }
 
-- 
2.47.3


