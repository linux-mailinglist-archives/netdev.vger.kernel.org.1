Return-Path: <netdev+bounces-172169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAAAA50741
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 18:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 286803AE46E
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 17:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABBA252905;
	Wed,  5 Mar 2025 17:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BRg5SuOY"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588802517AF
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 17:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197291; cv=none; b=RFDiSSkLFUNl5RmcRoFyyX7WvwvzO9w6aKthRVGPEnVTCPRJ8zHNHZH6B+jIJd3ELmExCk/2aj2fjs/XUUOy3fZrec3mLDUZN12veQiO6/HCurKm6SOLtCX/ZysvCzU3c6Oojhol1UpOVon8gv/PTrefIKCpcMgJEcnJl39JVPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197291; c=relaxed/simple;
	bh=DrGGhikndIM7l/25RHgZJS9KsGcmeV9ghoZydBoYdxU=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=f8jqkAN1AVtcJqHLyhYa1zfuTVBR/dIjotVLRyNon92JPDDJ3H25JTDW6REcxkOcBWR9ArzZkpKz3EP14Y5Bgnz+s/TiXQjAKRLxYbmYrVEXXeu2HFUj8yg4MflGez5nsO+n1htNTPJr+1uJn0od9CxV5cAPHZo9UVOElfTrUcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BRg5SuOY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=f3zqw2rI6Ot+kpRpJsM9K8AbmzF/0A2htE0cEidTpwI=; b=BRg5SuOYfwKsjDO94VckjEKjz5
	Ix65H73pJlKNe7luPxaNcX4eqWu7crJuCOa07l32YnztoTnFcszvQF799kmicI6+LVlKjCd/qS8l/
	6vPFgHs8ibT5mX+HA6VCN022smM4U44xs11Nhw8krI5dSGCslmHUbAv8GuRPml///U4sGXRJLENbK
	TT39/QO57epGGhM4P7WURBqh+LKTVULrRNr6Pt3ZJam02MNMB2Hyz2p0QXu9Q5rA3ivWR+70YOBn2
	6YryLZLlFlL2pSzlqEdtyMO47+H0M1GCcp4Ogn//lMZ4YyyRcfTemLukqJ7//+h3LLfgKaUWNfPZJ
	dwROq5Ow==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51332 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tpsx8-0004ff-09;
	Wed, 05 Mar 2025 17:54:42 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tpswn-005U6I-TU; Wed, 05 Mar 2025 17:54:21 +0000
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
Subject: [PATCH net-next] net: stmmac: mostly remove "buf_sz"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tpswn-005U6I-TU@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 05 Mar 2025 17:54:21 +0000

The "buf_sz" parameter is not used in the stmmac driver - there is one
place where the value of buf_sz is validated, and two places where it
is written. It is otherwise unused.

Remove these accesses. However, leave the module parameter in place as
removing it could cause module load to fail, breaking user setups.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index cb5099caecd0..037039a9a33b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -101,6 +101,7 @@ static int tc = TC_DEFAULT;
 module_param(tc, int, 0644);
 MODULE_PARM_DESC(tc, "DMA threshold control value");
 
+/* This is unused */
 #define	DEFAULT_BUFSIZE	1536
 static int buf_sz = DEFAULT_BUFSIZE;
 module_param(buf_sz, int, 0644);
@@ -218,8 +219,6 @@ static void stmmac_verify_args(void)
 {
 	if (unlikely(watchdog < 0))
 		watchdog = TX_TIMEO;
-	if (unlikely((buf_sz < DEFAULT_BUFSIZE) || (buf_sz > BUF_SIZE_16KiB)))
-		buf_sz = DEFAULT_BUFSIZE;
 	if (unlikely((pause < 0) || (pause > 0xffff)))
 		pause = PAUSE_TIME;
 
@@ -4018,7 +4017,6 @@ static int __stmmac_open(struct net_device *dev,
 		}
 	}
 
-	buf_sz = dma_conf->dma_buf_sz;
 	for (int i = 0; i < MTL_MAX_TX_QUEUES; i++)
 		if (priv->dma_conf.tx_queue[i].tbs & STMMAC_TBS_EN)
 			dma_conf->tx_queue[i].tbs = priv->dma_conf.tx_queue[i].tbs;
@@ -7973,9 +7971,6 @@ static int __init stmmac_cmdline_opt(char *str)
 		} else if (!strncmp(opt, "phyaddr:", 8)) {
 			if (kstrtoint(opt + 8, 0, &phyaddr))
 				goto err;
-		} else if (!strncmp(opt, "buf_sz:", 7)) {
-			if (kstrtoint(opt + 7, 0, &buf_sz))
-				goto err;
 		} else if (!strncmp(opt, "tc:", 3)) {
 			if (kstrtoint(opt + 3, 0, &tc))
 				goto err;
-- 
2.30.2


