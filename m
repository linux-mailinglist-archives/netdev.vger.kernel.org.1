Return-Path: <netdev+bounces-91956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DCC8B4869
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 23:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16261282A04
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 21:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB94147C64;
	Sat, 27 Apr 2024 21:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Rk4cooLt"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980D6146596
	for <netdev@vger.kernel.org>; Sat, 27 Apr 2024 21:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714254725; cv=none; b=rAEr9VpRojbMunLrQtD2BPBkBbWUkl3Fer5Aty2Dh4bql4p4JC40vVRbLQgwPdL1MAL4BXKlspmLxo8bXoefnE2JYPzJPyXm0mTU4046NIZH2zcETso03S9UFE5+grRmTF2oea9hN12D/SVauSx8KRRG/AuHOF8bz5gBhrknoT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714254725; c=relaxed/simple;
	bh=PAEi78i/q1Ai6HS+RfrS3zjzlK09a0vKprKd+v5SH78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBSYui++CuyY4E8JWSCkXIS0eCldQMHAr8j8db+UaVAlfGzTlQysEdsFTDKuOOTa52mx7T3OIECZMmn1IjlLmQMZWWeoZ/oeU1y5j6CBX1cbuVPndZI+N1/sO8xMa5+JulwcYqSdJUBI+eTkSkmRp+suTL8ruEbtMciLBvfQlvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Rk4cooLt; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 55F6F88273;
	Sat, 27 Apr 2024 23:51:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714254715;
	bh=jKpKs4GtT9EcKjmxAKxi39HW1VXhl5ucGSc5jkdyUGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rk4cooLtRc3Do/WZCiAUbPed3t90hRP+9iOiHt5DKp3Y3y7rBPf4d1WtwtCcfCrDr
	 txcHvCRxP3IcV16hoTc39RRo9v2HZ6qll3aEGTn8rFacWGisS46dK9UPdf1JmovYCV
	 lrdMWhOjgC0BKZqJ6QAVLinjXyBlGu/1KKj8RD+G1e1dZlgqpVaNKfvW8f4San53u6
	 L1ecper7g+nC8sSr0n1MQpnnKt11XDEUk0ZsILGCdnC8e6jpoHiBD0VgW3hmIYVBgD
	 /yKWHTC6y3Q8/XlAunJx2h8E3Fq6iGTpiCULPgTy8+kKc4JHTt9Me7yvfc0CwDjvdR
	 zMcXS33Q2IxvQ==
From: Marek Vasut <marex@denx.de>
To: netdev@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [net-next,RFC,PATCH 5/5] net: stmmac: dwmac-stm32: Fix Mhz to MHz
Date: Sat, 27 Apr 2024 23:50:44 +0200
Message-ID: <20240427215113.57548-5-marex@denx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240427215113.57548-1-marex@denx.de>
References: <20240427215113.57548-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Trivial, fix up the comments using 'Mhz' to 'MHz'.
No functional change.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Christophe Roullier <christophe.roullier@foss.st.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Jose Abreu <joabreu@synopsys.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: netdev@vger.kernel.org
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index 91e1a540616d1..260b5eb27b07c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -58,7 +58,7 @@
  * Below table summarizes the clock requirement and clock sources for
  * supported phy interface modes.
  * __________________________________________________________________________
- *|PHY_MODE | Normal | PHY wo crystal|   PHY wo crystal   |No 125Mhz from PHY|
+ *|PHY_MODE | Normal | PHY wo crystal|   PHY wo crystal   |No 125MHz from PHY|
  *|         |        |      25MHz    |        50MHz       |                  |
  * ---------------------------------------------------------------------------
  *|  MII    |	 -   |     eth-ck    |	      n/a	  |	  n/a        |
@@ -370,7 +370,7 @@ static int stm32mp1_parse_data(struct stm32_dwmac *dwmac,
 	/* Gigabit Ethernet 125MHz clock selection. */
 	dwmac->eth_clk_sel_reg = of_property_read_bool(np, "st,eth-clk-sel");
 
-	/* Ethernet 50Mhz RMII clock selection */
+	/* Ethernet 50MHz RMII clock selection */
 	dwmac->eth_ref_clk_sel_reg =
 		of_property_read_bool(np, "st,eth-ref-clk-sel");
 
-- 
2.43.0


