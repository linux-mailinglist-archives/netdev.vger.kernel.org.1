Return-Path: <netdev+bounces-219594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F4DB422E8
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 16:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5AA43A670F
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 14:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB64302CB6;
	Wed,  3 Sep 2025 14:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="N9VGlBQf"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB47E1459F7
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908070; cv=none; b=HpVW236BE17LaR9PgW4qnTcmxDHCiape67SXMyYXNriQS180oI2fRepJpSSg4dmo27aXn5jH+f8MSv1f8E5nG3LBnStg7Y/3/0SKMzyLoJrlMKDqo06NVly9+kMgsUWQcwdsZE4J1deRRxEjSjik67S0KEwBMrBVUb288hs9MQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908070; c=relaxed/simple;
	bh=IA2HX5Bs83gvwq1acXAj+29RoUml2OJxYGPpxCkvq4Y=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=H3EtkMH3knQFljG4pGSGwCnjwbo4Cj+CEDXz3t2ZaSTrPiL2+WntWcyLulduhcJg2atwVmz9mc52ir581p+60KfnGoZWc2Ds7yggXamq7umNhRJ+GjseJ1YILJFFMnlzC+Ujb2BYzHV2wU7vJNFYMy3NCnPJ1sbODBOaaATirUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=N9VGlBQf; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UZ535sMG9SHzKQxaCXBfr4JfaELjSThyJX0LteFzYAI=; b=N9VGlBQfCIXoCER8b40eEiqZr0
	45BFRSok5U/ALiTU1M1+lI3qJ6nfVhxGcOASOZWkl8+LvD8pXTeozsI4tpfPYepPFUli2D21WqtXH
	SpvsjTSs+QJLBqMl1JlFMUy4PUPkn4aCyU48XNS+nRbklbntWsS94wIce0rY9A2l3JF4gB/g9iXqI
	lZoNo/IXljxz3/1VFOSeUKmGVRY9N8EtlvDVbBQ0pvAEWQ2aTgNwYpNSsgW7WzHkwgkEmFqoMGKlo
	frhX7jgBWoGJpgmoX84OHYDOB3oNrO/BXidU5ZmfaD48YDTeKFmCjuzUk0f1+vhXQ0lBm3fd150OZ
	w0965dPg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:52698 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uto2d-000000000bz-3Qsc;
	Wed, 03 Sep 2025 15:00:51 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uto2d-00000001se4-0JSY;
	Wed, 03 Sep 2025 15:00:51 +0100
In-Reply-To: <aLhJ8Gzb0T2qpXBE@shell.armlinux.org.uk>
References: <aLhJ8Gzb0T2qpXBE@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>
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
Subject: [PATCH net-next 1/2] net: stmmac: ptp: conditionally populate
 getcrosststamp() method
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uto2d-00000001se4-0JSY@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 03 Sep 2025 15:00:51 +0100

drivers/char/ptp_chardev.c::ptp_clock_getcaps() uses the presence of
the getcrosststamp() method to indicate to userspace whether
rosststamping is supported or not. Therefore, we should not provide
this method unless it is functional. Only set this method pointer
in stmmac_ptp_register() if the platform glue provides the
necessary functionality.

This does not mean that it will be supported (see intel_crosststamp(),
which is the only implementation that may have support) but at least
we won't be suggesting that it is supported on many platforms where
there is no hope.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 3767ba495e78..8b4cf1a31633 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -247,10 +247,7 @@ static int stmmac_get_syncdevicetime(ktime_t *device,
 {
 	struct stmmac_priv *priv = (struct stmmac_priv *)ctx;
 
-	if (priv->plat->crosststamp)
-		return priv->plat->crosststamp(device, system, ctx);
-	else
-		return -EOPNOTSUPP;
+	return priv->plat->crosststamp(device, system, ctx);
 }
 
 static int stmmac_getcrosststamp(struct ptp_clock_info *ptp,
@@ -278,7 +275,6 @@ const struct ptp_clock_info stmmac_ptp_clock_ops = {
 	.gettime64 = stmmac_get_time,
 	.settime64 = stmmac_set_time,
 	.enable = stmmac_enable,
-	.getcrosststamp = stmmac_getcrosststamp,
 };
 
 /* structure describing a PTP hardware clock */
@@ -296,7 +292,6 @@ const struct ptp_clock_info dwmac1000_ptp_clock_ops = {
 	.gettime64 = stmmac_get_time,
 	.settime64 = stmmac_set_time,
 	.enable = dwmac1000_ptp_enable,
-	.getcrosststamp = stmmac_getcrosststamp,
 };
 
 /**
@@ -332,6 +327,9 @@ void stmmac_ptp_register(struct stmmac_priv *priv)
 	if (priv->plat->ptp_max_adj)
 		priv->ptp_clock_ops.max_adj = priv->plat->ptp_max_adj;
 
+	if (priv->plat->crosststamp)
+		priv->ptp_clock_ops.getcrosststamp = stmmac_getcrosststamp;
+
 	rwlock_init(&priv->ptp_lock);
 	mutex_init(&priv->aux_ts_lock);
 
-- 
2.47.2


