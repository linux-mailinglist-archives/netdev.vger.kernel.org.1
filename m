Return-Path: <netdev+bounces-155445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53906A02560
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 13:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36111886291
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 12:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976251D9A56;
	Mon,  6 Jan 2025 12:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HY3Od1+I"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922D11DD525
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 12:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736166363; cv=none; b=EWNbqbZZcXiQgkpgFh9QgizVMHBJZfI4w4sAtCgyAJsYTEKg3RMfJmoJLWatITbN8mzdPkPb8VtE3BByATOXSTC9hKZhLaG38R5iGngPKGjrv3yuvFuV3BboUEjb7LxPzbe7yt7cFxqACofce2UhjQpUmb8ihi3/MeWukEN4OX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736166363; c=relaxed/simple;
	bh=gndDZPmXbKVXypRHchjLwjG2a6em7RHNy8/Z1UNA+GI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=kTlIloCPwkDGhz/rM2S3/JXkGqj/CZ8eQsJZsEaSTydpABwscbydV181JitXKOQZrMyezD13nCBxkdFrqeUsblIL8MxhJt1kFHFZDkiej+OWfvyeOhuKWGJg4bVCX2rXv7twFuNkLcckadHqh1I5AEPZv95S2HJsZpYlRAqBDGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HY3Od1+I; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=45CZAwIamAG8WuVB/J0OCl/kYd5Vjv/J3SFjjvjhd8s=; b=HY3Od1+Ij8S9Dc5yXZIy0tcbPp
	V5WeSzIWqR3LYC8fEfuwpKIL4rUjnA4rdNQouwbOPk2TgItgnz+zS2is6y+tAcZvVyhSISkf26iVh
	0shJxh9XKjBgW2YAc87jff0WURuq3A1Jr+sUmEAS2fiGUeLggMFpdxsuxhNAFh7qk3Q0cGv+QCej/
	KDfJHvXwXnpJkDTG51xBH+jgXXO7Sb1jbMO0AF/k5K4nyyMlg19eyWQrzMqlLPGswmjhWumqZ+LvI
	nFoR9EdtSJJbwHfAwGv3oxkeg/JnNi8YFPmwQvODGwZ3yjbxj7pIBiwL7JbdzTmRLMfW8thh4lwCh
	J/LTwVuA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51890 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tUmB7-0005tc-0F;
	Mon, 06 Jan 2025 12:25:53 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tUmB4-007VXt-4o; Mon, 06 Jan 2025 12:25:50 +0000
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
Subject: [PATCH net-next v2 13/17] net: stmmac: use boolean for eee_enabled
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
Message-Id: <E1tUmB4-007VXt-4o@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 06 Jan 2025 12:25:50 +0000

priv->eee_enabled and priv->eee_active are both assigned using boolean
values. Type them as bool rather than int.

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


