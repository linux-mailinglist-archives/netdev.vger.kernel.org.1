Return-Path: <netdev+bounces-158129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2339BA10865
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 15:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6FAA3A2A27
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8006C7DA84;
	Tue, 14 Jan 2025 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0GXKuHue"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07B913C67E
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736863386; cv=none; b=ulTE7u6xcdsMLTcfv2Ml2+Ypv+JRWLpvDro+esmzPxD1EJujmeUyCoN3LlYjWYqYW+Na1cgkuLkw3UoKetpTrwrfxzFcF5bueBuaem+nPEd9en35EH04Vij/B9Vfy9uw5y23/tQ3zlxusjQHZ9n2LjzgOCOP6gcTaqGn/V4GeOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736863386; c=relaxed/simple;
	bh=RwBpNhDTxbL0EDbsUykxhLfFb/kb3Gf+Pc2ahz1koPI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=aM+I+ewUkC1xy2RYyd3jIcn9w2MZq733Ct45Omay0PSm09KtnBAEZX9Q9q87C8kK+v8N1uY2MsBp2zTsgLjKVsJCV65OfxEK4AmkxzIuBQIUr5o7pj3eRNT0puKpuEK1uDT1s1332Dw08iILNbNXO7Kgv/9Tfad9ypWh4Y+mpKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0GXKuHue; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BMwZqYMExIOn36De5aHwt8X+eNPnw8Db/HdEs1fJA6I=; b=0GXKuHueZx/5xrO6yxWbwAcsuI
	tJnwz+jq/enF2snYl7Cfd4ofhb5nxlJHZ1gIq7DgF31tav4EYPe9obbdeLEUiMLGqgbacPenA9o7v
	QotbQ4vgl4qzslVSl0G/DFR3DoldKoJIdQfRwxEeMk9v+KqgGSceYPssdjDvQ/JpMAr+XTid+gsRT
	RPk0tWmLO5sjOVbWhXOpyXX3OCdN9ddD2MvXXTL8kV9BZ1h58Qj5LB6zK0L8jchjwK5bWVwE1gYND
	vMimLfB7vYQnATVMIaAsF/1LJaGsyH8UNdlTGbZ56nNqry13qWgODwIWC4IDHrp5IpYvN8bk3VO7b
	uCPMjEGQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42216 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tXhVN-0008AY-2W;
	Tue, 14 Jan 2025 14:02:54 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tXhV4-000n0q-LU; Tue, 14 Jan 2025 14:02:34 +0000
In-Reply-To: <Z4ZtoeeHIXPucjUv@shell.armlinux.org.uk>
References: <Z4ZtoeeHIXPucjUv@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH RFC net-next 07/10] net: lan743x: use netdev in
 lan743x_phylink_mac_link_down()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tXhV4-000n0q-LU@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 14 Jan 2025 14:02:34 +0000

Use the netdev that we already have in lan743x_phylink_mac_link_down().

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 4dc5adcda6a3..8d7ad021ac70 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -3029,7 +3029,7 @@ static void lan743x_phylink_mac_link_down(struct phylink_config *config,
 	struct net_device *netdev = to_net_dev(config->dev);
 	struct lan743x_adapter *adapter = netdev_priv(netdev);
 
-	netif_tx_stop_all_queues(to_net_dev(config->dev));
+	netif_tx_stop_all_queues(netdev);
 	lan743x_mac_eee_enable(adapter, false);
 }
 
-- 
2.30.2


