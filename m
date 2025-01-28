Return-Path: <netdev+bounces-161364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76382A20D6D
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 140F23A3EDC
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 15:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B0A1D61A1;
	Tue, 28 Jan 2025 15:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="iXi2056j"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ED619DF61
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 15:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738079243; cv=none; b=Ojudgji1tt1ieEHel0FcnPSEQkZdsB6ZTAfQ5PjXtyJbifSPpdbS0HVFYULUEPxKKl67+w4218FB49Za09p5IEMVx1kww5GXtIQt5pH5gluId6TIeP4QUOjpdxukV0foWEii0OK8W86Ud3U5hFvH2bl3drVEooRJGLDjaQjR4m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738079243; c=relaxed/simple;
	bh=3WsnWd1a5z9s0abwveTDxKRxXLr2X7nm3gjHHlWG5UY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=RkwC5/+RyOWW8aWnrkDambUCpO++y4bEyG8/KgqF9NFNkKxGhHukSR46QobtrsyCNgwtCAREjNba84Ee0bjjqRJ8Tplnur/DrKyHlz4o0nVEeQ5G4GAu7MQ4yPAJmbwW9Bj7jJj8kY/5O1zJiGdfKXABbeVV5rJ+lxQbtud6YPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=iXi2056j; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JoLZ33LNKwoAa71fKGzvEpEXOzJfCAkJh5baBBKZatA=; b=iXi2056j0eNW1rMUPL/5DviVLD
	hYmXJaxUnw5pqu415V0u7DVXT6dhWUQ4eHwdn7xOecxV+CUclkNfNC0/cLXjzGab6R4MNB1293iLy
	TyvH6FifIgJS82vrQbzmLvv+P6795fSR3KrbH8vZAr4sBSIke2iy3aakvXX6jMAKMfgRnXg+zXs49
	1Oizn8GpJXQaoQyKfmjC87sBRQMqVcvol5WXk8l/N0HPMA7si9+S0/St47SNADXfTiPqGku1Ixhy8
	n67OJJFNgSbq3SZNKlHnR1UlCt2i2jl+8znfQCuxtHsewggRZaG780e1S6jmKWn2ebFXoo+heUuTS
	qfhiH0XA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:49224 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tcno2-0007T3-1O;
	Tue, 28 Jan 2025 15:47:14 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tcnnj-0037GE-3X; Tue, 28 Jan 2025 15:46:55 +0000
In-Reply-To: <Z5j7yCYSsQ7beznD@shell.armlinux.org.uk>
References: <Z5j7yCYSsQ7beznD@shell.armlinux.org.uk>
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
	Paolo Abeni <pabeni@redhat.com>,
	 Vladimir Oltean <olteanv@gmail.com>,
	 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH RFC net-next 02/22] net: stmmac: ensure LPI is disabled when
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
Message-Id: <E1tcnnj-0037GE-3X@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 28 Jan 2025 15:46:55 +0000

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
index a1a788bbc75a..7480825389e9 100644
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


