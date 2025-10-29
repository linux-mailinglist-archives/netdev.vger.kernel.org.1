Return-Path: <netdev+bounces-233705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E1FC1777C
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 01:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3FBE1A6428B
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 00:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324971D6BB;
	Wed, 29 Oct 2025 00:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qNo6Hxck"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCFB22097
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 00:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761696238; cv=none; b=GEVpFh2gFp3DxCdqHzHjMyGv2QiOzqyJKVBcL9irCukh34Bq4dhXdZjwybam69jyHMSzcuiHoUpNvCkEBrmckp5IB8RA0U4spfGjCRlNQPbStrcg5poRWEHMyZ4hyDUXD4BW9Nc1/ANjjTZ+Gx0X38VcWmcn73wWyH/aWvqTXBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761696238; c=relaxed/simple;
	bh=LB2WzEmY87kqYYrXuAoO4gJ3DJD8M6dLg78UaDCNX8o=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=fauNQ71o+HLX7bPyRUiY7GWN2d77jExRkAcio0KHagFKu86pS/YecjWL8LyMzXavg2t4B77z56EMqlnsqT0fsBBaureviUFNGa00KJ10DGKj0XZTmdSEkZ3zTRz8SGosLhzLQ8RQ6D/7XeiiDrG+BRoiYfLPXlt6xWMYXVhoOWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qNo6Hxck; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7E9UCKOGhnfa2ypmdjOo3R2weofKULZMGq7rFUzr9E8=; b=qNo6HxckVlgt8I514NMy1fgbU7
	l96+ieXUMOOuek7us2R4Y4G/K0nyci+qhf9FHpRUjEQIjPo7eQocE7VTb1Qvgakvk/EJ4rSFe9gtj
	T2GROr/rVio0jHrd6bay7vWyo7FhPshwgnpPBGMlZOnTbuo3Jqf7SWEBi/xj/HeVxvti8FmE0wLP2
	V2WKH1rLZTRlhbf9RECYI2paoTz0rXwyy/SpnTk9xiQ4a1MTwuJuflUyVYVLyvYcJoSFPvyWUkcKX
	tTnAoZEZp768vpsE2Npl5b5CumQhEek4n+eQeRqs6bOWzAHKSzkO9/j3fZIEhvFrrkvx5mokFtnnf
	GmvRmDiQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44822 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vDtfI-000000003ic-0LZW;
	Wed, 29 Oct 2025 00:03:48 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vDtfG-0000000CCCX-2YwQ;
	Wed, 29 Oct 2025 00:03:46 +0000
In-Reply-To: <aQFZVSGJuv8-_DIo@shell.armlinux.org.uk>
References: <aQFZVSGJuv8-_DIo@shell.armlinux.org.uk>
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
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH net-next v3 8/8] net: stmmac: reorganise stmmac_hwif_init()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vDtfG-0000000CCCX-2YwQ@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 29 Oct 2025 00:03:46 +0000

Reorganise stmmac_hwif_init() to handle the error case of
stmmac_hwif_find() in the indented block, which follows normal
programming pattern.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Tested-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.c | 72 ++++++++++++----------
 1 file changed, 38 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index e1f99b9d9d7f..8212441f9826 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -366,41 +366,45 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
 
 	/* Use synopsys_id var because some setups can override this */
 	entry = stmmac_hwif_find(core_type, priv->synopsys_id, version.dev_id);
-	if (entry) {
-		/* Only use generic HW helpers if needed */
-		mac->desc = mac->desc ? : entry->desc;
-		mac->dma = mac->dma ? : entry->dma;
-		mac->mac = mac->mac ? : entry->mac;
-		mac->ptp = mac->ptp ? : entry->hwtimestamp;
-		mac->mode = mac->mode ? : entry->mode;
-		mac->tc = mac->tc ? : entry->tc;
-		mac->mmc = mac->mmc ? : entry->mmc;
-		mac->est = mac->est ? : entry->est;
-		mac->vlan = mac->vlan ? : entry->vlan;
-
-		priv->hw = mac;
-		priv->fpe_cfg.reg = entry->regs.fpe_reg;
-		priv->ptpaddr = priv->ioaddr + entry->regs.ptp_off;
-		priv->mmcaddr = priv->ioaddr + entry->regs.mmc_off;
-		memcpy(&priv->ptp_clock_ops, entry->ptp,
-		       sizeof(struct ptp_clock_info));
-		if (entry->est)
-			priv->estaddr = priv->ioaddr + entry->regs.est_off;
-
-		/* Entry found */
-		if (needs_setup) {
-			ret = entry->setup(priv);
-			if (ret)
-				return ret;
-		}
+	if (!entry) {
+		dev_err(priv->device,
+			"Failed to find HW IF (id=0x%x, gmac=%d/%d)\n",
+			version.snpsver, core_type == DWMAC_CORE_GMAC,
+			core_type == DWMAC_CORE_GMAC4);
+
+		return -EINVAL;
+	}
 
-		/* Save quirks, if needed for posterior use */
-		priv->hwif_quirks = entry->quirks;
-		return 0;
+	/* Only use generic HW helpers if needed */
+	mac->desc = mac->desc ? : entry->desc;
+	mac->dma = mac->dma ? : entry->dma;
+	mac->mac = mac->mac ? : entry->mac;
+	mac->ptp = mac->ptp ? : entry->hwtimestamp;
+	mac->mode = mac->mode ? : entry->mode;
+	mac->tc = mac->tc ? : entry->tc;
+	mac->mmc = mac->mmc ? : entry->mmc;
+	mac->est = mac->est ? : entry->est;
+	mac->vlan = mac->vlan ? : entry->vlan;
+
+	priv->hw = mac;
+	priv->fpe_cfg.reg = entry->regs.fpe_reg;
+	priv->ptpaddr = priv->ioaddr + entry->regs.ptp_off;
+	priv->mmcaddr = priv->ioaddr + entry->regs.mmc_off;
+	memcpy(&priv->ptp_clock_ops, entry->ptp,
+	       sizeof(struct ptp_clock_info));
+
+	if (entry->est)
+		priv->estaddr = priv->ioaddr + entry->regs.est_off;
+
+	/* Entry found */
+	if (needs_setup) {
+		ret = entry->setup(priv);
+		if (ret)
+			return ret;
 	}
 
-	dev_err(priv->device, "Failed to find HW IF (id=0x%x, gmac=%d/%d)\n",
-		version.snpsver, core_type == DWMAC_CORE_GMAC,
-		core_type == DWMAC_CORE_GMAC4);
-	return -EINVAL;
+	/* Save quirks, if needed for posterior use */
+	priv->hwif_quirks = entry->quirks;
+
+	return 0;
 }
-- 
2.47.3


