Return-Path: <netdev+bounces-163009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB22A28C05
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 14:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71BFC1889273
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 13:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5104513C9C4;
	Wed,  5 Feb 2025 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="toDTZCjE"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E7513B5AE
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762819; cv=none; b=RW00nJT8eC2c8pkF5YpdLXwTgYq7tler+YIhaT3VRKA+/6HpIT6vL+nWYaZKMpOC+k60g2y37502ieAr2LEDRqoRynuLPsKefDt0IHUmiDUChPKqbwF7AZOVEF9cglF1pDbjvrjAanePLDANT162kebbFRJWnnHcENAvv5UW69E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762819; c=relaxed/simple;
	bh=uSEVB1pvmguIIlH0fUVPUGcdjkFucOrC5F7SXXmeAxk=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=fNPqDBlLNrxA0IRD9osM8d4QBFp+JgeoEqL6rYS+uVlGsJsiMsa6loM03wcsYjNL3zdFsAcEe16E/h2AI5i9r4v7cLas4UHyOOxFyVLOY3kSDfUAIlMpm/R+WWQWLhGwBh0MIpIy3maDEAhkZhqQyy/JaRacAT+98TthyaQgeyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=toDTZCjE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FDvCujIEp/SdELCYe35PqbWkz1VVUTMUDBCM2w2Hyqo=; b=toDTZCjEt1Z1payNKwdOEoU4Rz
	RSLl7VWBADFbs5REecXoleFlzhnewJAar3lwKGOUY+aChvvyiqUdX+gHARNvjWalMHTidPCaGTE2b
	/Cku0w4aTqAbpbEbOR2bJynFNF/QacJFFkmYCClGhoXjfFKW9No5mwyryzO4xLeSp3tfgVxpuHL98
	NnJX/ZlJWWKhc1KTtILvXTG8KzJJgE+9/QQE+FBbRSM/tzuA5d4fddX/mKFY+6TOMlvyUhojjxEq4
	x+IECyrHuVQdwPuqiM7i8FVxQmWKgvM1m3QpK6KkrshkU8nwzws9amcPonBaNWQOiGPA9xzOKAZEf
	kVg/Xcqw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:47366 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tffdR-0007A6-2g;
	Wed, 05 Feb 2025 13:40:09 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tffd8-003ZHb-AX; Wed, 05 Feb 2025 13:39:50 +0000
In-Reply-To: <Z6NqGnM2yL7Ayo-T@shell.armlinux.org.uk>
References: <Z6NqGnM2yL7Ayo-T@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 02/14] net: stmmac: ensure LPI is disabled when
 disabling EEE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tffd8-003ZHb-AX@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 05 Feb 2025 13:39:50 +0000

When EEE is disabled, we call stmmac_set_eee_lpi_timer(..., 0).

For dwmac4, this will result in LPIATE being cleared, but LPIEN and
LPITXA being set, causing LPI mode to be signalled (if it wasn't
before).

For others MACs, stmmac_set_eee_lpi_timer() does nothing, which means
that LPI mode will continue to be signalled despite the expectation
for it to be disabled.

In both cases, LPI mode will be terminated when the transmitter has
a packet to send, and LPIEN will be cleared by hardware.

Call stmmac_reset_eee_mode() to ensure that LPI mode is disabled when
EEE mode is requested to be disabled.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 9b44f4a8b7af..fecf9e8b29bf 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -494,6 +494,7 @@ static void stmmac_eee_init(struct stmmac_priv *priv, bool active)
 			priv->eee_sw_timer_en = false;
 			del_timer_sync(&priv->eee_ctrl_timer);
 			stmmac_disable_hw_lpi_timer(priv);
+			stmmac_reset_eee_mode(priv, priv->hw);
 			stmmac_set_eee_timer(priv, priv->hw, 0,
 					     STMMAC_DEFAULT_TWT_LS);
 			if (priv->hw->xpcs)
-- 
2.30.2


