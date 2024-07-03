Return-Path: <netdev+bounces-108850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F6692606E
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 14:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49892280286
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 12:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF3517335C;
	Wed,  3 Jul 2024 12:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eaea149E"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28D7143C6B
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 12:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010105; cv=none; b=dR32Suj6TQ/kqFnq01BIzuG/nzjeqZV3U3DCett+oUVw2SgKIyS1wjpsPfnE8Mn7RUwrivVtI0WY+nGoC8WdIKudqNTZNIFMnefKlrBFCqJgPojloThBTnab0Bsh1DRHWqvRc+7jFXdVFIJTD/e4znp+xhkyfA3hfHJXiC/AlkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010105; c=relaxed/simple;
	bh=v4/8BGxQtFgVIAVqXcyx74rvV2O6MpzsvonThb1aivs=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=Xx19/wOXj0ODz3laqullywekm/Nntle0ynLoS1Wrkg4ExVpnF1gquRT7lB4VmPi1n6v5bL7zW4CwNjhDgcO12hBubF1xzfYuZ/q8dSkQ5Kcd8n8TTFgu923UH54RqKlyQRQ3NTjZ44YAJDM+fiS4VnLLnv6DLnZR1RibG5PcrfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=eaea149E; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KbSHbMOBCE90JQVtnf7edu8ZUklrZJRldNFyQDvZE6E=; b=eaea149Edup5ie9i6V5fifOFtX
	vGGwzR3rvs3QyTZQhoYKwqIt+Vj2e3Dz80G7D3DwJ4YCL/ZVx4wJ2fLQ4uvYMwRNAmzclHLugSs+X
	HyzGlOelmFHCTmKlLSqx8LVs8DqQxz3j5TU9CtkkmtSnRWbypyjWZn9tN+AJUOHbNawQuIYvrkQVx
	DQG97K1tVqPYYuOihAF+yHU28JFACYQyvewqCunNGCnuhNk2UW/rO3YSyFngXwZQNsjIs2HSGi9Ly
	DvFTcnJPmCAqwecTLzB2RD5rZF6JdR1m045MUtUS3lhnCL6zsjwqi/ATcBs7kvxq6G3Es5DQyo8WG
	vBki/qJQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37350 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sOz2K-0005Yo-17;
	Wed, 03 Jul 2024 13:24:36 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sOz2O-00Gm9W-B7; Wed, 03 Jul 2024 13:24:40 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>,
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	"Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net] net: stmmac: dwmac4: fix PCS duplex mode decode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sOz2O-00Gm9W-B7@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 03 Jul 2024 13:24:40 +0100

dwmac4 was decoding the duplex mode from the GMAC_PHYIF_CONTROL_STATUS
register incorrectly, using GMAC_PHYIF_CTRLSTATUS_LNKMOD_MASK (value 1)
rather than GMAC_PHYIF_CTRLSTATUS_LNKMOD (bit 16). Fix this.

Thanks to Abhishek Chauhan for providing a response on this issue.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index b25774d69195..26d837554a2d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -791,7 +791,7 @@ static void dwmac4_phystatus(void __iomem *ioaddr, struct stmmac_extra_stats *x)
 		else
 			x->pcs_speed = SPEED_10;
 
-		x->pcs_duplex = (status & GMAC_PHYIF_CTRLSTATUS_LNKMOD_MASK);
+		x->pcs_duplex = (status & GMAC_PHYIF_CTRLSTATUS_LNKMOD);
 
 		pr_info("Link is Up - %d/%s\n", (int)x->pcs_speed,
 			x->pcs_duplex ? "Full" : "Half");
-- 
2.30.2


