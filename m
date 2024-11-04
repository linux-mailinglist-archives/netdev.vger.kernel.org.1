Return-Path: <netdev+bounces-141603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 622E69BBB04
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 18:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DBC91F22875
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 17:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967401CDA25;
	Mon,  4 Nov 2024 17:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KrYfvu8U"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897331CB9EB;
	Mon,  4 Nov 2024 17:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730739784; cv=none; b=FjsijVVE2BxYZ0ejkK3o36fK4fwMeP9lKMtJvlT98I+pr2MPO8bN9arzPYwJ9896jgkNpHPbx3iZf7hwOmrnNZ/FWBPnUu1kn175sxTx3Qkj1AsJsvN4YtUEh39ML+CpeSvAzCbHyOdYT4FVcFxUHHjnRohq/AwO6jeR5J3CW7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730739784; c=relaxed/simple;
	bh=P16V2mkI4qSBlelW6W/sXFScztNs05ZbmwbDljXRKr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjOvG420E99bzjkpzkSNPLANOW44wVJLco1fQ8lMoEcdNr5EgQ2hcCQ7joj94RjU2c6gP1KVsaI9RUh1Zp0YE1UN7EdgyKyo16qsvOL9+/L07PQ+lkOGLF1CZZN9cU7yzD0Kvg5amdZJE5QMy21Z0UilwQR+EOO0ZwaPbWSuYsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KrYfvu8U; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 273D46000D;
	Mon,  4 Nov 2024 17:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730739780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XDh3EdnrR/PCsOp5ZedOmai1CHRqkh3yfIKuvIijDks=;
	b=KrYfvu8UGeDJygxO2L11K7UVqHgApKJ6B5G0XrJMQIaknLfvN9O3oLj6VKn4iOwqPDa/uu
	EhN13ONnoDp3uK44HuLR8PjaIsGDhxayoGp6XlN6xWZ0vKUJlZmpk3Wef12J9DfQF4yL3o
	qM53QmE/Km5NHFcwl/T2SFrG/xo8XyMinYndAxh03PHlN/fEKtaNeL08f6hiXo0UjiniHJ
	g4rMCdzmBsX79GI2ttDupJSVo0MnV8gKUqaGKlmviuGke0jDKAJCEeZW2Jr6t66fK1lpPg
	g5r9NG9D0k7Xl4s93XjRSQ1xCkLM/8oVqsDF0yRDRzpeqQ8TVEheT5eXVlfauA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 6/9] net: stmmac: Enable timestamping interrupt on dwmac1000
Date: Mon,  4 Nov 2024 18:02:46 +0100
Message-ID: <20241104170251.2202270-7-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104170251.2202270-1-maxime.chevallier@bootlin.com>
References: <20241104170251.2202270-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

The default configuration for the interrupts on dwmac1000 have the
timestamping interrupt masked. Now that the timestamping has been
adapted to dwmac1000, enable the timestamping interrupt on these
platforms.

On dwmac1000, the external snapshot interrupt is configured through a
dedicated bit, that is set as reserved on other dwmac variants. The
timestaming interrupt is acknowledged by reading the
GMAC3_X_TIMESTAMP_STATUS register.

Make sure that this interrupt is enabled when snapshot is enabled, and
masked when disabled.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V2: Make that interrupt unmasked only when necessary

 .../net/ethernet/stmicro/stmmac/dwmac1000_core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index dbbd834f9fc8..37374f5a15c4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -595,6 +595,20 @@ void dwmac1000_timestamp_interrupt(struct stmmac_priv *priv)
 
 /* DWMAC 1000 ptp_clock_info ops */
 
+static void dwmac1000_timestamp_interrupt_cfg(struct stmmac_priv *priv, bool en)
+{
+	void __iomem *ioaddr = priv->ioaddr;
+
+	u32 intr_mask = readl(ioaddr + GMAC_INT_MASK);
+
+	if (en)
+		intr_mask &= ~GMAC_INT_DISABLE_TIMESTAMP;
+	else
+		intr_mask |= GMAC_INT_DISABLE_TIMESTAMP;
+
+	writel(intr_mask, ioaddr + GMAC_INT_MASK);
+}
+
 int dwmac1000_ptp_enable(struct ptp_clock_info *ptp,
 			 struct ptp_clock_request *rq, int on)
 {
@@ -628,6 +642,8 @@ int dwmac1000_ptp_enable(struct ptp_clock_info *ptp,
 		ret = readl_poll_timeout(ptpaddr + PTP_TCR, tcr_val,
 					 !(tcr_val & GMAC_PTP_TCR_ATSFC),
 					 10, 10000);
+
+		dwmac1000_timestamp_interrupt_cfg(priv, on);
 		break;
 
 	default:
-- 
2.47.0


