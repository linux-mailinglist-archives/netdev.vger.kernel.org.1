Return-Path: <netdev+bounces-248813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9E7D0EF74
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 14:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE4CE30081AA
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 13:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E73339873;
	Sun, 11 Jan 2026 13:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="EV/49LMB"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A4833BBD4
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 13:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768137342; cv=none; b=FeggNBtFj36+0EwSUWg59FycWl/UbUT+/B0I9iTNKhJI4YEPvH5eJtOOozqXOwHMZVKDMw1H4PSy0hrPPguSNsoQPocMSGixzkm5qIihVIrzJbocONa9EI8XdguMreBLGSI+1asxNgK7Iq7hVnyFE69rbAYf2cGlCdwr/8n+yPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768137342; c=relaxed/simple;
	bh=DcEpzS2uINsKoiKHI5QeBCJ506husK4XESUiksdi67M=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=MqXaI8MjpqS6VxaIeFWiWvvzl8gaq6IO4bxfq0XYuxDhMHKHXYG+qbFROE1T4wYpMsEvZxQXYkB9jzn+86pUbbs/U7VUjteNTEi6fD9FuCbOcsxR9Tx+1RRBNFzjjzmWFg8ulGY3mMi5To5SqN6m5FTNOME2BAq5Ki3DCLMR8iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=EV/49LMB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mhHZZmL/NcTBBpVOifiOT25mcW059BgaRnaZdAmQTz8=; b=EV/49LMBt6VNFsFdpMQS8rgGvP
	3EZCbcdowNm30Qx4X/rGGaAzNvX24gj4Od6dqcYBsDuKu2d435qDJ0QGIr4oXPWT4Uk3r77U+vjXG
	WepGdjMn/fAFgatj+IpYBgY+4+nO+sfnj1ke3ch/DKGd85eQj+GBGRFlb3S8fH3qu6jSKyl718e34
	MOcWu5wspOxCURrtrMyCpyLHG2gc523QyC44AHjsa4c4uSkRL9NPh8dye1ucb0v/XDrbgO++IQM7g
	sLe1qQk+0bLUsK4wYi350fW5mRCt34gF+qRd9UsLAoD/EqiaxyGiVQDteML20UiPGAdtcQ08U1lRH
	OEbkPkNQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:48912 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vevI3-000000005Uz-0nSI;
	Sun, 11 Jan 2026 13:15:31 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vevI1-00000002Yp8-3cM3;
	Sun, 11 Jan 2026 13:15:29 +0000
In-Reply-To: <aWOiOfDQkMXDwtPp@shell.armlinux.org.uk>
References: <aWOiOfDQkMXDwtPp@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 5/5] net: stmmac: report PCS link changes to phylink
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vevI1-00000002Yp8-3cM3@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sun, 11 Jan 2026 13:15:29 +0000

Report PCS link changes to phylink, which will allow phylink's inband
support to respoind to link events once the PCS is appropriately
configured.

An expected behavioural change is that should the PCS report that its
link has failed, but phylink is operating in outband mode and the PHY
reports that link is up, this event will cause the netdev's link to
momentarily drop, making the event more noticable, rather than just
producing a "stmmac_pcs: Link Down" message.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
index 28748e7ef7dd..2f826fe7229b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
@@ -62,6 +62,8 @@ void stmmac_integrated_pcs_irq(struct stmmac_priv *priv, u32 status,
 		x->irq_pcs_link_n++;
 		dev_info(priv->device, "PCS Link %s\n",
 			 val & GMAC_AN_STATUS_LS ? "Up" : "Down");
+
+		phylink_pcs_change(&spcs->pcs, val & GMAC_AN_STATUS_LS);
 	}
 }
 
-- 
2.47.3


