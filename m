Return-Path: <netdev+bounces-248204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1729ED0512A
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 18:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D705301AE0B
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 17:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B9F2DC336;
	Thu,  8 Jan 2026 17:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OOuStifH"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A81D2C21F2
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 17:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767893779; cv=none; b=AqW5M/kV2PVtH6dgApguCKf+lThQeC/ac+xcX21yFUbRImp+sQZU4OQrqNT3ls4tgLoTFnmUWQAYlLSx2mSaWdfrJlX3MAaEm7ahhZObybX/8Rnvw7y3Ti/+oeLCq3KITgKaXhHt7lbuhmwPl3UnEXZyzIoiYOW+8U2AglHQWnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767893779; c=relaxed/simple;
	bh=QIMKzY6cVylmuZ/yj+8b6gJ3JSAzaMaQ/WZE/KG0G+w=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=umS0gLjBYyVhX0HzARAd1kxcILINn+I6LxM7WPNuLOTd4gGtPGUGvAQVFbVgbZ5L7D4XuKMQF7hwkWG09lUdQK5QoHxoa7N2916JYBYPar98gT4IBebhuWEJDxxAFLNzh4UqHlATA8Yt+hKg9fG/A8/ngmXsg9pEp30YKINIdVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=OOuStifH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=35RpguOccMLOmwjQ0po8HZdSkzgWRqD0fcWefyMBX5E=; b=OOuStifHOJrkQ4p5Nf7wt7Ry6V
	feiX6VCyiNvIduBDZ+uGAf+wppTQ3KJQ9FvNCA/NVcclza0lFcO+oqgtcSTTp0QtgQKZ8IFU+5Kpi
	a+FqSTC+RjJDT9/f2oW0v5Vzs9xjrWqVRy4d97ZXfR0+HXKXC2CnOXeOBvZG4TTQFsfPEX5lUR0MQ
	2JWczW40+XYtQQ1r1roOnn+fklXnukH2HkcTO1eSo72WfYjpqVXfSwgmcSbW0oxn//Rv1JxObEELK
	+ozvk2txEYa3s/h7AAEG/9TgLyqttkcjyYVRla1hgwi83pM1vNEppXIm4mnrRkGzmBFOCro25ZV+u
	AeyHfIBg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:52352 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vdtvd-000000002yd-48Rx;
	Thu, 08 Jan 2026 17:36:10 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vdtvd-00000002GtJ-0qFI;
	Thu, 08 Jan 2026 17:36:09 +0000
In-Reply-To: <aV_q2Kneinrk3Z-W@shell.armlinux.org.uk>
References: <aV_q2Kneinrk3Z-W@shell.armlinux.org.uk>
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
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 1/9] net: stmmac: dwmac4: remove duplicated
 definitions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vdtvd-00000002GtJ-0qFI@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 08 Jan 2026 17:36:09 +0000

dwmac4.h duplicates some of the debug register definitions. Remove
the second copy.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h | 29 --------------------
 1 file changed, 29 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
index 3cb733781e1e..fa27639895ce 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
@@ -485,35 +485,6 @@ static inline u32 mtl_low_credx_base_addr(const struct dwmac4_addrs *addrs,
 /* To dump the core regs excluding  the Address Registers */
 #define	GMAC_REG_NUM	132
 
-/*  MTL debug */
-#define MTL_DEBUG_TXSTSFSTS		BIT(5)
-#define MTL_DEBUG_TXFSTS		BIT(4)
-#define MTL_DEBUG_TWCSTS		BIT(3)
-
-/* MTL debug: Tx FIFO Read Controller Status */
-#define MTL_DEBUG_TRCSTS_MASK		GENMASK(2, 1)
-#define MTL_DEBUG_TRCSTS_SHIFT		1
-#define MTL_DEBUG_TRCSTS_IDLE		0
-#define MTL_DEBUG_TRCSTS_READ		1
-#define MTL_DEBUG_TRCSTS_TXW		2
-#define MTL_DEBUG_TRCSTS_WRITE		3
-#define MTL_DEBUG_TXPAUSED		BIT(0)
-
-/* MAC debug: GMII or MII Transmit Protocol Engine Status */
-#define MTL_DEBUG_RXFSTS_MASK		GENMASK(5, 4)
-#define MTL_DEBUG_RXFSTS_SHIFT		4
-#define MTL_DEBUG_RXFSTS_EMPTY		0
-#define MTL_DEBUG_RXFSTS_BT		1
-#define MTL_DEBUG_RXFSTS_AT		2
-#define MTL_DEBUG_RXFSTS_FULL		3
-#define MTL_DEBUG_RRCSTS_MASK		GENMASK(2, 1)
-#define MTL_DEBUG_RRCSTS_SHIFT		1
-#define MTL_DEBUG_RRCSTS_IDLE		0
-#define MTL_DEBUG_RRCSTS_RDATA		1
-#define MTL_DEBUG_RRCSTS_RSTAT		2
-#define MTL_DEBUG_RRCSTS_FLUSH		3
-#define MTL_DEBUG_RWCSTS		BIT(0)
-
 /* SGMII/RGMII status register */
 #define GMAC_PHYIF_CTRLSTATUS_TC		BIT(0)
 #define GMAC_PHYIF_CTRLSTATUS_LUD		BIT(1)
-- 
2.47.3


