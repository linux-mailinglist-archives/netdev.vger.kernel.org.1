Return-Path: <netdev+bounces-91954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5E68B4867
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 23:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B37C282870
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 21:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D60146A7D;
	Sat, 27 Apr 2024 21:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="QpGLiGpM"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAE3146590
	for <netdev@vger.kernel.org>; Sat, 27 Apr 2024 21:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714254724; cv=none; b=UAnHdreVJgVMYU5oju1jcQvDKm5wPfqAJwAmGz7KZxT8adyzqyAlo+DEt2mXd8h5ECRcqa7gvnUPQI3jyIYqylJrnnqMR5rA8V51L7PsyG+h9/LOF2J/NzrM9T3IKc5Q7m50Zp4OWacON7R4xzglgKKmtRNAmXdvXvikTyHfhH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714254724; c=relaxed/simple;
	bh=fSCR9jlkvww3BdxPh53EyGBp+3yvP8dPcSD/X2bdkuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hec+jGIwrBa9xoFy4lsbNDEG8oWbSEYfOaWVnClZR18sHQxI9ItE2Q98ODWyI7pZn4EZd1SUkUsySuEfDulZa9YXOWvOzmWXUmKmlb5jmIijmrmaVZCFRHcNMhAi3+Q4mWTWy/apGVoLw001kipr+E0+xzR/kIboxLx6eWWQc2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=QpGLiGpM; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 1361C88231;
	Sat, 27 Apr 2024 23:51:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714254714;
	bh=48U1LBTaOC1SkqgfWlUuR9R7PWBy0Mc8YUZg9BWKlxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QpGLiGpM6Xu2iP5B2eMF1KekCdO3PNG+J18g1y0P3SdcCG4xM5yALO73TWesAvskL
	 mUQtoffZLuZNvNLlqyl8f8XMoD+24PPzqMcf61PqQontl2Sf8tWwtVq0xRl481RG9Q
	 cJ7iCAykul+iEDWdjpJoHnTvKZiHm7y3etR3RrQgU2lbcJv0YvG1G8wnY6weSbaU6+
	 5bxYTGfg0sLIInTnq+FonCA5kLq2uT6UAOzb22FWbd0mCDFLMa6IFI5aT6Ay/9fC6B
	 hMeAPbQ2IB0bCVIzPF1xB0UPIbOyqzF4FHTnObPqcF/8uOyCus/022OoGgHToHX3VW
	 gXScieKO0vb/A==
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
Subject: [net-next,RFC,PATCH 3/5] net: stmmac: dwmac-stm32: Extract PMCR configuration
Date: Sat, 27 Apr 2024 23:50:42 +0200
Message-ID: <20240427215113.57548-3-marex@denx.de>
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

Pull the PMCR clock mux configuration into a separate function. This is
the final change of three, which moves external clock rate validation,
external clock selector decoding, and clock mux configuration into
separate functions. This should make the code easier to undrestand.
No functional change intended.

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
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 27 ++++++++++++-------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index e552cc25fb808..3fedb447970a6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -222,15 +222,11 @@ static int stm32mp1_validate_ethck_rate(struct plat_stmmacenet_data *plat_dat)
 	return -EINVAL;
 }
 
-static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
+static int stm32mp1_configure_pmcr(struct plat_stmmacenet_data *plat_dat)
 {
 	struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
 	u32 reg = dwmac->mode_reg;
-	int val, ret;
-
-	ret = stm32mp1_select_ethck_external(plat_dat);
-	if (ret)
-		return ret;
+	int val;
 
 	switch (plat_dat->mac_interface) {
 	case PHY_INTERFACE_MODE_MII:
@@ -265,10 +261,6 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 		return -EINVAL;
 	}
 
-	ret = stm32mp1_validate_ethck_rate(plat_dat);
-	if (ret)
-		return ret;
-
 	/* Need to update PMCCLRR (clear register) */
 	regmap_write(dwmac->regmap, reg + SYSCFG_PMCCLRR_OFFSET,
 		     dwmac->ops->syscfg_eth_mask);
@@ -278,6 +270,21 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 				 dwmac->ops->syscfg_eth_mask, val);
 }
 
+static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
+{
+	int ret;
+
+	ret = stm32mp1_select_ethck_external(plat_dat);
+	if (ret)
+		return ret;
+
+	ret = stm32mp1_validate_ethck_rate(plat_dat);
+	if (ret)
+		return ret;
+
+	return stm32mp1_configure_pmcr(plat_dat);
+}
+
 static int stm32mcu_set_mode(struct plat_stmmacenet_data *plat_dat)
 {
 	struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
-- 
2.43.0


