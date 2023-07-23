Return-Path: <netdev+bounces-20192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1232375E3AE
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 18:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 429BA1C209CA
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 16:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D9346BA;
	Sun, 23 Jul 2023 16:22:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A930146AC
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 16:22:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81AE9C433C8;
	Sun, 23 Jul 2023 16:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690129336;
	bh=+ysItbKZr2r8wDthNuZTqSVce0mf6PlXK4jyZ+ackfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K8bpSYVX9RUYYhbQaQqgpUmPVLnuD1/g19mdl573T6CZcPKyqBBBBeKKBpn2vH8RV
	 c/nXfG+3ag9VK1FeXznOirepvtWS0r5vtzDQ3QwmhuhGL3mwXa/TIMb9gB/VZz4/7k
	 WYOeFc7KTyiY8+aivYsF37WuKlQnsS2W1JTd2Xn9+pvAhsIVT0hsUTK9ILG+geuQ2t
	 h4u1Dpod4CWczqZhCrjMKl6udaF6Ewa3L81UjWRdfHd3y4sw9mB4DweGRDgSL8w0up
	 dBvG+uBWel61arpomk8HKW5bLnFozmEGG3W6nDlDwNP2u8CtUn2GihZcGC0lUjjeUK
	 l82PKeVU22yhg==
From: Jisheng Zhang <jszhang@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 03/10] net: stmmac: mdio: enlarge the max XGMAC C22 ADDR to 31
Date: Mon, 24 Jul 2023 00:10:22 +0800
Message-Id: <20230723161029.1345-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230723161029.1345-1-jszhang@kernel.org>
References: <20230723161029.1345-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IP can support up to 31 xgmac c22 addresses now.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index 3db1cb0fd160..e6d8e34fafef 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -40,7 +40,7 @@
 #define MII_XGMAC_WRITE			(1 << MII_XGMAC_CMD_SHIFT)
 #define MII_XGMAC_READ			(3 << MII_XGMAC_CMD_SHIFT)
 #define MII_XGMAC_BUSY			BIT(22)
-#define MII_XGMAC_MAX_C22ADDR		3
+#define MII_XGMAC_MAX_C22ADDR		31
 #define MII_XGMAC_C22P_MASK		GENMASK(MII_XGMAC_MAX_C22ADDR, 0)
 #define MII_XGMAC_PA_SHIFT		16
 #define MII_XGMAC_DA_SHIFT		21
-- 
2.40.1


