Return-Path: <netdev+bounces-155961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA97BA04664
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFE5618884A1
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACF31F76B3;
	Tue,  7 Jan 2025 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nsRAKSRg"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5481E0DE6
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 16:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736267400; cv=none; b=TSik3UwL/8L1e3EuBkRO3XdfAPwu1mTt4flDkwcQH/NDBt94gSTxfOhDag1VvyDSDVj0UxVJ4vKYSLF/DNbJ+Ty6CoC2DDeC34tMU87rASJkD9jmoozoxVKl7EUCxyeAIOV6M2hDCSyCjjKCu1BKp7Sp3LOtOcVxdG1eOxYtAhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736267400; c=relaxed/simple;
	bh=53rWGxr7i+69EZqyxSdISgixUGQXESVaECS0S6gLTXo=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=MQ5F0vmH8jJg61V/NmCQDmpyQ9N7EuGfJ6ccFkWtv+l3l6o6YWqQY5TkkFNW+O0YUMvXLVl/XqlKVLcec9gZBvqJfmutXUleFezW2gqzgQiO7OkSFRPz+u4jEskDr+G9mN+Pp6Im55Hn/I5gmmbRS4rhLsLMSkei9EgKUzRxs6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=nsRAKSRg; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4M3GO1u5UO9gUdI/y1VtJSws8EiP+NlPYd8R2GK9U4M=; b=nsRAKSRgFV/Rlj2frgJxeu6KwT
	JwDa8bCCsHm2IM4BTEzxxrX8YavfoFcimxYvb07Q1IRLxJuoQAaZGWAarzBfnO15nyJs094iOXTxo
	Hlwks6/oh66B8AEzWkeA3YJWqDiVRh7VIDBEGdBEa1dShKxRKi1dbAjFnNtbRWLnyOtIUm8zn+It5
	r+NLblaL+M//ZqY3wpb1MOvnsfC7j1lmskrLZSp8jTjYg8S+6t2knoUS9so4yt0VB2kgakUFbskvq
	RGb81qR+j5p6mwLahIqjY1SW/0Smz1SZWw1fX+TMB1AKx3ASxOi8Mr81c4J7OhZMOzYHDA45Zl+6q
	ozvIDauw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42184 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tVCSg-0007op-2g;
	Tue, 07 Jan 2025 16:29:46 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tVCSd-007Y4L-QX; Tue, 07 Jan 2025 16:29:43 +0000
In-Reply-To: <Z31V9O8SATRbu2L3@shell.armlinux.org.uk>
References: <Z31V9O8SATRbu2L3@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v3 15/18] net: stmmac: move setup of eee_ctrl_timer
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
Message-Id: <E1tVCSd-007Y4L-QX@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 07 Jan 2025 16:29:43 +0000

Move the initialisation of the EEE software timer to the probe function
as it is unnecessary to do this each time we enable software LPI.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7c1dbc5fa84b..b003f462006d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -494,7 +494,6 @@ static void stmmac_eee_init(struct stmmac_priv *priv, bool active)
 	}
 
 	if (priv->eee_active && !priv->eee_enabled) {
-		timer_setup(&priv->eee_ctrl_timer, stmmac_eee_ctrl_timer, 0);
 		stmmac_set_eee_timer(priv, priv->hw, STMMAC_DEFAULT_LIT_LS,
 				     STMMAC_DEFAULT_TWT_LS);
 		if (priv->hw->xpcs)
@@ -7405,6 +7404,8 @@ int stmmac_dvr_probe(struct device *device,
 
 	INIT_WORK(&priv->service_task, stmmac_service_task);
 
+	timer_setup(&priv->eee_ctrl_timer, stmmac_eee_ctrl_timer, 0);
+
 	/* Override with kernel parameters if supplied XXX CRS XXX
 	 * this needs to have multiple instances
 	 */
-- 
2.30.2


