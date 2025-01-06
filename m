Return-Path: <netdev+bounces-155446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56265A0255D
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 13:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 367381638B7
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 12:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915491DDC22;
	Mon,  6 Jan 2025 12:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ET5LMLXh"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865101DDC35
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 12:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736166367; cv=none; b=B7OZEws5M2glhrdM3huvHFQkYMH/4LWgIlg6j3w1rTqyVBh15kUckrhhPL53iqEsSCXO9Wxy9FBVYdLSHV33f6Z6qZvA6QCQ5hKO/eqeJFXuHxS/UUizjrvZY4C+zToMwD16WkfnoB+BdFdq/hzHd3XcwMNp41OXHjV8d28Dlo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736166367; c=relaxed/simple;
	bh=VxHuPhKUYFfBqU3+wFytuGY2l/x1vJIxM3AmAd3/qTM=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=VbWHqZzSypD9OsaWh33fKZ3/cV7ILy17gsUgFDEB0sX/R7Tpr6iTtby6RDBiR49A4Y2bshuf3ftbWK7YPWuVOIIQw/Atkg9dyV3vccFt/3KcaZooSd9zjiMpKnpbfc+sP1g4fSLWfybpjnzyXzwupAh5ueku6JjPLhWpNC4eCJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ET5LMLXh; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YRoEPXMnuvWAlKLiIj/33TvZCcNaaMUqV2ZCf8NplQI=; b=ET5LMLXh2i7t3Hquxxv9WUCwg5
	CoqjNHrafHutcPwgU0wCcTQO3LNbN5J+iWrK7MJEPdvlZwi3utCGD6AiClBwLvkrsom1SS3HqZ8pp
	O7CZwL4wXZz4H2GvX/TvvsRa/OttjnzpFmFpNwY9hko8XHCC1hS9ThuDrNUJN8/5BOtLFvDtLenb2
	xXkSZp32EUSrc5lYHP1ZF0fgiuxPCBgJPmxc45zboXO3c5qurOeYAIExkdrp3IHJhZ36fugbYqRLc
	QxOmBXkwCppIuLPN3eAfG4Fe7c4QJGmVusu7RGTOBjgpqAsIocrJh7uH5BpkGzNoLP/quN2EIwsPk
	zvmiesaw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51898 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tUmBC-0005tv-1N;
	Mon, 06 Jan 2025 12:25:58 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tUmB9-007VXz-8c; Mon, 06 Jan 2025 12:25:55 +0000
In-Reply-To: <Z3vLbRQ9Ctl-Rpdg@shell.armlinux.org.uk>
References: <Z3vLbRQ9Ctl-Rpdg@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v2 14/17] net: stmmac: move setup of eee_ctrl_timer
 to stmmac_dvr_probe()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tUmB9-007VXz-8c@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 06 Jan 2025 12:25:55 +0000

Move the initialisation of the EEE software timer to the probe function
as it is unnecessary to do this each time we enable software LPI.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 1aedb49944ec..aac45c16d7b5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -495,7 +495,6 @@ static void stmmac_eee_init(struct stmmac_priv *priv, bool active)
 	}
 
 	if (priv->eee_active && !priv->eee_enabled) {
-		timer_setup(&priv->eee_ctrl_timer, stmmac_eee_ctrl_timer, 0);
 		stmmac_set_eee_timer(priv, priv->hw, STMMAC_DEFAULT_LIT_LS,
 				     STMMAC_DEFAULT_TWT_LS);
 		if (priv->hw->xpcs)
@@ -7399,6 +7398,8 @@ int stmmac_dvr_probe(struct device *device,
 
 	INIT_WORK(&priv->service_task, stmmac_service_task);
 
+	timer_setup(&priv->eee_ctrl_timer, stmmac_eee_ctrl_timer, 0);
+
 	/* Override with kernel parameters if supplied XXX CRS XXX
 	 * this needs to have multiple instances
 	 */
-- 
2.30.2


