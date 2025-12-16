Return-Path: <netdev+bounces-244954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DD2CC3D78
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 16:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A27330B2AEB
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 15:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED5234DCDD;
	Tue, 16 Dec 2025 15:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TytGPF1Y"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A95A34DB6A;
	Tue, 16 Dec 2025 15:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765897684; cv=none; b=m4xAO0FQ1qEwYgROe8x40zoso38tgHoXRsBTebpAmHhDu5zcL1Ou4nA+/NB1/XRUSRZkIXvHkfQqMfxgZHxNyZbG0jMV5u1sKBc6jI0SlB88a5G/rGeQo10+1vlEBfoLwGINZvBUDXzvc6kxl4aOIR4YG8kyyK6s6SO8Usl+PwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765897684; c=relaxed/simple;
	bh=lGkrk2qVInQqDxc1gQaSlJoQNw3ElEUzkO9oX64+liM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=X7lDRIW1w4yvlEltaG9QSHwUHCyFETWc0raZE6CQNe44xA6KO6ZN1Xzkr5wFifWRNbOVCTN2Po8aqvWG4DCrq0eQKf/CNWJ9SQ8PC+kxtNue39ufbFBIHzH31+dHTZS8ITDchhMQv+MYG5S+hp5JezrVzWwNNbv77ZWkUnHDwfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TytGPF1Y; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=wg9Xf8V8em1zSRB
	5KPAJPFBdeTO21Kdvkx26K1bPMoE=; b=TytGPF1YqVKWl4BoIq5EE8XbYRAQ7LM
	ZOYiYT9hIFOq4ZeqQdQRn66lpVV2V6mmUGAKCOuJQT/bSB4bzbX+/GGRWPG8vxYd
	eTnrY0Dn5/jmRwjGk8TT7zvFL9R5n9Ta0NFrThm6kH4UCjOogKEYcBqxBWuFwHm+
	o52c5miM5uls=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDnD+lkdUFpZsvsIQ--.30056S2;
	Tue, 16 Dec 2025 23:06:28 +0800 (CST)
From: Lizhe <sensor1010@163.com>
To: heiko@sntech.de,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org,
	Lizhe <sensor1010@163.com>
Subject: [PATCH 1/2] [PATCH net-next v2 1/2] net: stmmac: dwmac-rk: rename phy_power_on to avoid conflict
Date: Tue, 16 Dec 2025 07:06:11 -0800
Message-Id: <20251216150611.3616-1-sensor1010@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:PSgvCgDnD+lkdUFpZsvsIQ--.30056S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFW5Xw4xCrWfXFyDurWrAFb_yoW8Xr47pa
	97AF9Fyw1kJryxGa12qFsrZa45Cw47try0gF1xZ34fuF13u34qqr10yrW0yF1UKrWkWF9I
	yF4UA3Z7C3W7CrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piG2NtUUUUU=
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xtbC3RQl0GlBdXRpeQAA3F
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Rename local function 'phy_power_on' to 'rk_phy_power_set' to avoid
conflict with PHY subsystem function. Keep original error handling.

Signed-off-by: Lizhe <sensor1010@163.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 0a95f54e725e..2f5a65c235aa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1498,7 +1498,7 @@ static int gmac_clk_enable(struct rk_priv_data *bsp_priv, bool enable)
 	return 0;
 }
 
-static int phy_power_on(struct rk_priv_data *bsp_priv, bool enable)
+static int rk_phy_power_set(struct rk_priv_data *bsp_priv, bool enable)
 {
 	struct regulator *ldo = bsp_priv->regulator;
 	struct device *dev = bsp_priv->dev;
@@ -1692,7 +1692,7 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
 		dev_err(dev, "NO interface defined!\n");
 	}
 
-	ret = phy_power_on(bsp_priv, true);
+	ret = rk_phy_power_set(bsp_priv, true);
 	if (ret) {
 		gmac_clk_enable(bsp_priv, false);
 		return ret;
@@ -1713,7 +1713,7 @@ static void rk_gmac_powerdown(struct rk_priv_data *gmac)
 
 	pm_runtime_put_sync(gmac->dev);
 
-	phy_power_on(gmac, false);
+	rk_phy_power_set(gmac, false);
 	gmac_clk_enable(gmac, false);
 }
 
-- 
2.17.1


