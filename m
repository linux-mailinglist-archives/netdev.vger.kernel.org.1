Return-Path: <netdev+bounces-158643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA1EA12CE1
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 21:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 503C4188980F
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 20:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58B91D88BE;
	Wed, 15 Jan 2025 20:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="G8qgLKFh"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3215E1D935A
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 20:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736973808; cv=none; b=Rt8GEVKSiHa+KfuImL4oquoEs2Ev2I0hgXrH78ge5xYAcGBwzFkiHLWFGVs58gUIwEVQGbU5Jzcg1qfj0azvk3WgflisYvuTjasGfkkHX606ogud8mUKu3wZFfrMNTijMMBzsQcnsj5b1AfbKqEF/39jjzWCyuaMSf1p70C2GC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736973808; c=relaxed/simple;
	bh=RwBpNhDTxbL0EDbsUykxhLfFb/kb3Gf+Pc2ahz1koPI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=WYsPQ3GWLMFLxNOrkaE5pP+UW0UapkuAW02deoisTxNwMviT83FdNdDWH5HjIG6hXFLwT9ulCAKz/k9fq5ML6s6t+NyxhE8rdRkbbOXc2hzkFf485qTFlbOHC6LWyk5LI4y5FO9YPZKMaZ/4w8U4rw0U6oWVhVBZs0LHCH4a7ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=G8qgLKFh; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BMwZqYMExIOn36De5aHwt8X+eNPnw8Db/HdEs1fJA6I=; b=G8qgLKFhc9ROjP/KLKF+NkRSSD
	k6Eci8r8v1pMhvFmQ9BOpTQnXxKFw9hfZer5zf4J7nw7SMCp3+O5MdnjtAwPlWJyGVzJZRUruTrNG
	IKzenkJAWXAuwn0Kied2rMI4r7s6sZQzs+wO55fkBNPJlwJS3F5IyaPz/wHw/v37Z6ohL92JzGHGV
	hvQOKIz/+9MvwAXMucJUUf7Aekscem/UR2PNxbl44p1175UrYRkAkW6FZNHv4I3KZLm+f169jd9NX
	LsNWki+iykzAf/fLd5Lq+CIS80yS6pUpSefUleQsm6CDYKGcti+Ca910QgzTPbwso/EFbmL5cCyfO
	8hY2zqpA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46372 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tYAEP-0001jw-1M;
	Wed, 15 Jan 2025 20:43:17 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tYAE5-0014Q5-Up; Wed, 15 Jan 2025 20:42:58 +0000
In-Reply-To: <Z4gdtOaGsBhQCZXn@shell.armlinux.org.uk>
References: <Z4gdtOaGsBhQCZXn@shell.armlinux.org.uk>
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
	UNGLinuxDriver@microchip.com
Subject: [PATCH net-next 7/9] net: lan743x: use netdev in
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
Message-Id: <E1tYAE5-0014Q5-Up@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 15 Jan 2025 20:42:57 +0000

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


