Return-Path: <netdev+bounces-183229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B158CA8B6CB
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18D971897AAD
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 10:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AF623BCFD;
	Wed, 16 Apr 2025 10:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="T0hEdLtE"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ACB2459FD
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 10:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744799264; cv=none; b=Ev1OetkxsF/gHutr2wHvThU+Gya+bkWrTEc3hblKwOwqT/B/d5m0MX2FOsQ7lD9KoZMacWU10BUNEeiEO6QA5OAdHnqmEWrGhWxpaTngTJ8Tv7aPcETdp9x5XK60kpFlnZbFg6CFwATqW0nYTPvYBXooG5TixoF4TNAG8FJ0Rzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744799264; c=relaxed/simple;
	bh=9mqdtzUxFjx9wokxbxWOravP3ekyW7cve/0DQXTJ1/w=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=BmWjvcDJNkF9F0NQseT1gppYH5IVMlbOGGgq35C0N0nw5gHWfulbNajQyTtn2RIimMuN+0VDhE/zNG6MRg//zecfUi9k080VkR6srIKKU383W/BaxEWdb0vfKLT2PO9vG9V6CZY8yf64e20pMftaCB1WnsRV4/IWzRCNTawGDV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=T0hEdLtE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=M8M+j71R+PmQzROfFMQrSEmQk4KpBHTgVm1xyrexVTI=; b=T0hEdLtEyL0J619DdQWOqxM4UO
	xBB1qJH9adpPP5NggnFTmHlD6zQr7pbj6x28w5wiF+qH78SSWa3nsB4sAiiwT2EY7wEZl/CUM7By/
	9ylxn4P2kYNz126W/fOZNgEWvb6RjN45LGdtpvuwr2S67cZcVHmMKnlOOc5qz+ofgsCs867BEjj/o
	29z5XmyseJ1j7beBK9Y/gzsYwS/Lmy+ijQ7ux5GM2TGTMNA8h6AHyB3vEikWDyJuplszMMGYKTKwN
	VbXWWJNr2iQcTl6k3g83ROrZYAq0oEY6q/BxF/w38XjrKvS58wPlxopvGLF9DZGoCNvY0nZJIv/CB
	Bh9e1VMA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41926 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u4zzJ-00012Q-2v;
	Wed, 16 Apr 2025 11:27:25 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u4zyh-000xVE-PG; Wed, 16 Apr 2025 11:26:47 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net: stmmac: mediatek: stop initialising
 plat->mac_interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u4zyh-000xVE-PG@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 16 Apr 2025 11:26:47 +0100

Mediatek doesn't make use of mac_interface, and none of the in-tree
DT files use the mac-mode property. Therefore, mac_interface already
follows phy_interface. Remove this unnecessary assignment.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
index d178d5ddc7c7..39421d6a34e4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
@@ -581,7 +581,6 @@ static int mediatek_dwmac_common_data(struct platform_device *pdev,
 	int i;
 
 	priv_plat->phy_mode = plat->phy_interface;
-	plat->mac_interface = priv_plat->phy_mode;
 	if (priv_plat->mac_wol)
 		plat->flags &= ~STMMAC_FLAG_USE_PHY_WOL;
 	else
-- 
2.30.2


