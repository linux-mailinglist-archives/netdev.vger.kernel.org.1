Return-Path: <netdev+bounces-170327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A86E5A48294
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1294C188AF21
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 15:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E23126A0F6;
	Thu, 27 Feb 2025 15:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tlRKRqmf"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AD226A1A8
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740668752; cv=none; b=hWgD/hNXqytcXdsB8IETy9mUd+SHHtjalGW7y4Xq8vbDFT1JufHjUATU/qMjh5a/burm/0Q4EVp7tKABDTW8zeuWvclZpqMxd4xth+q+M2AWjDSEg1x2ehwc4nzN73HjMSNLdMl5ET8m+JyPw64dsoHxK6CEiUuM5LLWFTGUQHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740668752; c=relaxed/simple;
	bh=WLT04tPmBl5Y9wVuo1OAkAcyCmGb8wMVyJ0gD4ei3/s=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=DjoDsD93feOv65pTYTgGRbdWKuwRItIvvtFMKmrT7i6QsL4KDYkhekOnUSUl64zE8qIwxx+CFnSz5R4JQkgeZMuuWgqdplFd+JiYR2ycqLkBKYndfU1kdC6DwMXaJTM6YOCKuam495V/hZ3L1kBpx0RRxL1Y9RT02mnpcPfW9rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=tlRKRqmf; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YCufWFd6G+xrz+BePjT03qTPZYQ4Xqveeaiwin3kBZY=; b=tlRKRqmfRq7SMY6gL21jv5t0mU
	qWtAohbIyGTYR85mQjfixnVJFbC2juOSSXj0NjQgKtr7wJkuXqcYJTRQ1FFywnnuqaWJ3H1UuzZ2F
	D8auRIOmrUdfIqgQZxBufhtUV4nt0czgVFfC9L1R+rdsm37G+bpDz1NRSebDiii7ecEH1MhGfP+81
	ws8HsIdNNco/AZXDIOJY8xzOBS0tpu4tjcq0WeTG6dj7OB/EHW8XMxXwGIhw1MHmLyS1c2I6XUdcj
	/XcsoNotQahe9y5T+CYCs9X5LFLBzc49z1A3mdtER8BZZu1hoBIBlVTH4mXandvaEEM9vwyb0I+M0
	SC1znplw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41118 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tnfSI-0007Xj-2Q;
	Thu, 27 Feb 2025 15:05:42 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tnfRy-0057SX-Lj; Thu, 27 Feb 2025 15:05:22 +0000
In-Reply-To: <Z8B-DPGhuibIjiA7@shell.armlinux.org.uk>
References: <Z8B-DPGhuibIjiA7@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH RFC net-next 5/5] net: stmmac: leave enabling RE and TE to
 stmmac_mac_link_up()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tnfRy-0057SX-Lj@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 27 Feb 2025 15:05:22 +0000

We only need to enable the MAC receiver and transmiter only when the
link has come up.

With commit "net: stmmac: move phylink_resume() after resume setup
is complete" we move the race between stmmac_mac_link_up() and
stmmac_hw_setup(), ensuring that stmmac_mac_link_up() happens
afterwards. This patch is a pre-requisit of this change.

Remove the unnecessary call to stmmac_mac_set(, true) in
stmmac_hw_setup().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index e47b702fb9f9..c80952349eb7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3506,9 +3506,6 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
 		priv->hw->rx_csum = 0;
 	}
 
-	/* Enable the MAC Rx/Tx */
-	stmmac_mac_set(priv, priv->ioaddr, true);
-
 	/* Set the HW DMA mode and the COE */
 	stmmac_dma_operation_mode(priv);
 
-- 
2.30.2


