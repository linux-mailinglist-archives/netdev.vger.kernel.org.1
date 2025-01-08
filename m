Return-Path: <netdev+bounces-156355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 017E4A0628D
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 17:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CC22163DDA
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7991FFC45;
	Wed,  8 Jan 2025 16:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qo3vSVaT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115331FECC1
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 16:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736354907; cv=none; b=a49Er1XHM2pIywiUbfFYevhS7AoLYeuyBqNc62nE/mRjRot7kdBZqzB8K37hSEkVgqFQPxrdffjizGptX3HpAzuCBjl58hAAnCf1zinlFZuaasaRZUtGbXecj1f5iV8iqBCl0LfRBzujnybMCihf8EwhHtMFG3whSK/6r7WAUeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736354907; c=relaxed/simple;
	bh=cKghFwdyFTGXseJ/FiUx2rt8NhTCh/6HKmNsg2DlHW4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Z2zGZszgfJwT3G9/SR5BiAJv+dCLYHj93pZfomaCjNd52rIgimoNd7gkWWyGpsfwUcS0/We4hYrUrVIG4QqGSCl2ANuv6k5SJ6dJCONEdX0r67aIMBF7InaVVHahAprEhXwnbpwDHSNqO2/6Mo441wvJniB2Hi/XzlNK435xno0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qo3vSVaT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7hE4EeXv53OSz/8DGAk3QLChy+iFvZSWMogT3CTeyGU=; b=qo3vSVaTi7vE+9ljApMVlZoe4e
	LLzERpmhtKQW9OgAlPcVYMfg2willIiLoFqfDECRLzMvp8HzBLfuplt8zL6PEXi95WPm/Oxr/bXlN
	3sJ8fF+GJ/wrAzH35weArJLIXELnX25LHFV1P9ezRvUs/f0/ewBiDL5kHLde99GOJTTwzKjA2adZK
	6U32qv1YKR3i+n3uobMomiLwmrUgQyrkS3TAg7mkAKCHAFV7ODm3mzf0NE8p/qoNm8NxpuUH2n7uz
	FK3O34mDDchdE2Cvjjj40dNCr39DUI2z2qmLPtbMnQD/YriARnQIs+pOLlaTOuzxuMh+nkWQiTbtX
	OF5s9NcA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39630 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tVZEA-0000vf-11;
	Wed, 08 Jan 2025 16:48:18 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tVZDr-0002KF-Cv; Wed, 08 Jan 2025 16:47:59 +0000
In-Reply-To: <Z36sHIlnExQBuFJE@shell.armlinux.org.uk>
References: <Z36sHIlnExQBuFJE@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v4 06/18] net: stmmac: remove redundant code from
 ethtool EEE ops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tVZDr-0002KF-Cv@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 08 Jan 2025 16:47:59 +0000

Setting edata->tx_lpi_enabled in stmmac_ethtool_op_get_eee() gets
overwritten by phylib, so there's no point setting this.

In stmmac_ethtool_op_set_eee(), now that stmmac is using the result of
phylib's evaluation of EEE, there is no need to handle anything in the
ethtool EEE ops other than calling through to the appropriate phylink
function, which will pass on to phylib the users request.

As stmmac_disable_eee_mode() is now no longer called from outside
stmmac_main.c, make it static.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h         | 1 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 9 ---------
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c    | 2 +-
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 984e708d019f..2eee3c5c4d1e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -405,7 +405,6 @@ void stmmac_dvr_remove(struct device *dev);
 int stmmac_dvr_probe(struct device *device,
 		     struct plat_stmmacenet_data *plat_dat,
 		     struct stmmac_resources *res);
-void stmmac_disable_eee_mode(struct stmmac_priv *priv);
 int stmmac_reinit_queues(struct net_device *dev, u32 rx_cnt, u32 tx_cnt);
 int stmmac_reinit_ringparam(struct net_device *dev, u32 rx_size, u32 tx_size);
 int stmmac_bus_clks_config(struct stmmac_priv *priv, bool enabled);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 0429a99a8114..693f59c3c47a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -898,8 +898,6 @@ static int stmmac_ethtool_op_get_eee(struct net_device *dev,
 	if (!priv->dma_cap.eee)
 		return -EOPNOTSUPP;
 
-	edata->tx_lpi_enabled = priv->tx_lpi_enabled;
-
 	return phylink_ethtool_get_eee(priv->phylink, edata);
 }
 
@@ -911,13 +909,6 @@ static int stmmac_ethtool_op_set_eee(struct net_device *dev,
 	if (!priv->dma_cap.eee)
 		return -EOPNOTSUPP;
 
-	if (priv->tx_lpi_enabled != edata->tx_lpi_enabled)
-		netdev_warn(priv->dev,
-			    "Setting EEE tx-lpi is not supported\n");
-
-	if (!edata->eee_enabled)
-		stmmac_disable_eee_mode(priv);
-
 	return phylink_ethtool_set_eee(priv->phylink, edata);
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a0d1144507dd..de06aa1ff3f6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -432,7 +432,7 @@ static int stmmac_enable_eee_mode(struct stmmac_priv *priv)
  * Description: this function is to exit and disable EEE in case of
  * LPI state is true. This is called by the xmit.
  */
-void stmmac_disable_eee_mode(struct stmmac_priv *priv)
+static void stmmac_disable_eee_mode(struct stmmac_priv *priv)
 {
 	if (!priv->eee_sw_timer_en) {
 		stmmac_lpi_entry_timer_config(priv, 0);
-- 
2.30.2


