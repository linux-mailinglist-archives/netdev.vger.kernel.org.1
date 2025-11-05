Return-Path: <netdev+bounces-235798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F711C35D2D
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 14:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33EC218C14B9
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 13:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F106C31D735;
	Wed,  5 Nov 2025 13:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="x5BCoxqn"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4AF31C56A
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 13:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762349181; cv=none; b=EV5p+aUm78KGwsTbWpdDtFhGR9UQH9/VFA0f5qSsVH4f8SLhPEaf8JXzCFkOj8iMO/9qw1lkGWroN8bh27lbuGQvFue6pNOUE1B1igtmo8lv41Fh+vLaF+eFGBH6yimOTMOeHLJJHDGA27Non1OEyMbWXCYQb0THiE2rf6T28JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762349181; c=relaxed/simple;
	bh=A11yE0gELJxjGJ3mPN5xUExSw1JGYBDP+PFixcDyOeY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=GZK+pMKZcx57TdCarsjPsNfkf3195KXa1pTBub8L0X6EXDNlRWqVYo0sEgC35FUAvChftJuF6enaLM2lviKedq76Hbg4gF+2SiRMtiEGWPwg4p2hQZx7jnHLJ6ZYUUaYAFSJAV20ypJI8Bzcnw7JeRmwmQretQcyQ+V9pcnsHRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=x5BCoxqn; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Usa7VIevC0jki+KrHbnrqazXMhE2dQaXFRN8HRS1gCQ=; b=x5BCoxqnsEofAQun7W6ay5xmwK
	DtHk1mRhAm+EzI8kJGFNFyXZzYayDkMMyu9yoW0ENOa2C7+cMfpHxw82xQM1hyYfZsu3aISs3+2z0
	FpUYSUMh55mVoyW86mMrpFDA7uH45CEoOvAOUwhNGUTZULLh3wjdMviS1qk6vZaRGeF+nRJp07GVT
	QfnyRVwiryDfgADiSXQ9hZoYLKB0SLtQw8hlcGqP81WnDxLqx8CElcK2gcLSVud8phiWTOiFS6YiZ
	NrNhoaYgMHErHXnhKsOb1y62ebQ08gBUupr/OK948Yc3tAMF+ZtUl0BfVdcvPAkgItQFpq9oulfpY
	xL0oprbg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:40214 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vGdWf-000000003Ra-39Wa;
	Wed, 05 Nov 2025 13:26:13 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vGdWf-0000000ClnO-03pS;
	Wed, 05 Nov 2025 13:26:13 +0000
In-Reply-To: <aQtQYlEY9crH0IKo@shell.armlinux.org.uk>
References: <aQtQYlEY9crH0IKo@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 01/11] net: stmmac: ingenic: move ingenic_mac_init()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vGdWf-0000000ClnO-03pS@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 05 Nov 2025 13:26:13 +0000

Move ingenic_mac_init() to between variant specific set_mode()
implementations and ingenic_mac_probe(). No code changes.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../ethernet/stmicro/stmmac/dwmac-ingenic.c   | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
index c1670f6bae14..8d0627055799 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
@@ -71,20 +71,6 @@ struct ingenic_soc_info {
 	int (*set_mode)(struct plat_stmmacenet_data *plat_dat);
 };
 
-static int ingenic_mac_init(struct platform_device *pdev, void *bsp_priv)
-{
-	struct ingenic_mac *mac = bsp_priv;
-	int ret;
-
-	if (mac->soc_info->set_mode) {
-		ret = mac->soc_info->set_mode(mac->plat_dat);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
 static int jz4775_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
 {
 	struct ingenic_mac *mac = plat_dat->bsp_priv;
@@ -234,6 +220,20 @@ static int x2000_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
 	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, val);
 }
 
+static int ingenic_mac_init(struct platform_device *pdev, void *bsp_priv)
+{
+	struct ingenic_mac *mac = bsp_priv;
+	int ret;
+
+	if (mac->soc_info->set_mode) {
+		ret = mac->soc_info->set_mode(mac->plat_dat);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int ingenic_mac_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat_dat;
-- 
2.47.3


