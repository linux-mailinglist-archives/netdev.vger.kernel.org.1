Return-Path: <netdev+bounces-156363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0F5A062A2
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 17:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AE29167832
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79811FFC49;
	Wed,  8 Jan 2025 16:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="A6sszLKe"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC551FF1DD
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736354954; cv=none; b=LVFStgq2FD2cxXz5MCifADOGR6+zlLKuV1nfHOIvcHz/+8nq6u/lEYx0bKXrBxf24BmSPo6BzMzA+cN7I/FIA+tX6I/EKHwxD/4agRgQ+CmpwSUQKj8WlgtdfAk9QLXJbtQZgmpnkzxJHINLJTxR5hcHzZYIj9B/eV7RX6Tz+3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736354954; c=relaxed/simple;
	bh=TBz2nujOAI5/Y8Zg70CFpY+rYmOsL/gsDYa2XanvEww=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=F4+Zw7PK4ApZR06muslh0PwW3TjDFtFKapNLBXV18rZSUTIuPWIKP5girD2CCco8F1nljgPKj2qnitMnEXO0T+0qsHJy9awFEGuGgG5LFfW7VI5TzIjANgKxGLzF05yTTyjpZX+MjNH7i1o2P6QoizHdcGGPC7HXtbTdYW+45Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=A6sszLKe; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yu+9Qz2lxGwIw57DzDZsWsaRAx4ta+qmYcXg3UwOVJo=; b=A6sszLKeP/QSnJl3kDVsu1ch29
	ID2U1+Aww1kOny76+/D9gQQfVNwafxlY/e3YLW0LBpKzMAS9QXVrv8ObbMLTFEDt0m8Z79ZZ33PlM
	zmZCMEXFU/L19Jd1Ws3tk2imaAEihLwQPrBrcCcXxOJpMwCZyMK9HqIHqMhVqLgsO1JMfDeM0WUwo
	Eoypj15LHJi28d3IxPgrUE1PkxQIVEj6weBuf5gLgMc1G35Njz0N2N9E4VotRso/DCvZoil9TuCto
	P1KaWJ4FTz2y85ZzpTwbXDDXf/fItkEYHZ5ImhCTH8Sb+2DT8RTCWSbls9u2CJbyAZ22nvujTcwuE
	bxQsJPVQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46358 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tVZEr-0000xl-2J;
	Wed, 08 Jan 2025 16:49:01 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tVZEW-0002L2-9w; Wed, 08 Jan 2025 16:48:40 +0000
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
Subject: [PATCH net-next v4 14/18] net: stmmac: use boolean for eee_enabled
 and eee_active
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tVZEW-0002L2-9w@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 08 Jan 2025 16:48:40 +0000

priv->eee_enabled and priv->eee_active are both assigned using boolean
values. Type them as bool rather than int.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 1556804cca38..25ad3f92e14d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -305,9 +305,9 @@ struct stmmac_priv {
 	int clk_csr;
 	struct timer_list eee_ctrl_timer;
 	int lpi_irq;
-	int eee_enabled;
-	int eee_active;
 	u32 tx_lpi_timer;
+	bool eee_enabled;
+	bool eee_active;
 	bool eee_sw_timer_en;
 	unsigned int mode;
 	unsigned int chain_mode;
-- 
2.30.2


