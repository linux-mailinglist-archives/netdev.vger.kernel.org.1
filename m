Return-Path: <netdev+bounces-121403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A451F95CFC5
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 16:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A451F25F3F
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 14:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB783189538;
	Fri, 23 Aug 2024 14:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="h38/bthj"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50866188913;
	Fri, 23 Aug 2024 14:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724422355; cv=pass; b=rEo2D0waWVYX+8zccMwCtHC2btP+SsT5zKXejwJl2AJ/pgrgPhm5yW8AN+0jHuF21Q7umwRtXs4xxXU94qoD1jETTYv8vxrjdzeuyab6bsqpwGvyOZ+O7+Scyq33YYcSbEF9zKoKjzcnjhQlPLf8K+Iq8I1syWwMubQHrgNY7ZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724422355; c=relaxed/simple;
	bh=F9XKLNS2sFm/cwhvPffx2XnUiW1+YHzjc+ajIheEVDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jz87eWCmGb+/c/SOi0gK2l97EFf3bR1sBst1l9gMHktTo/b72h9cEBz2U59fWWoqN+Kcoe5eQ1cl+xIyN9wuIu511tzPMLqe06v/iZY/MhMBO/BmN8F5UfufPYv9PghwTRKR70UAcBZNEOnQCqVnomP7dL/Wa6+NrxhsxJr70cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=h38/bthj; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724422314; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=C7PH9zMpE4BMks1lgSGa3vL9pq4gb6RMI+rrRalhUxQv5U4LYS3w1/nN3HJ+xkr8+E/tBYod5/tp6LyVD5KJlBDtx+HMAPR0f8qg4LglJMlPTSgSm3dEdUZM3+cjFrnaxYB5YNqZHSAVQ1/Ic5WkbZMXzdX2RO03ca+EoJwnx6Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724422314; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ROKKRsYio3xxAWmx1+IWV2SIFpDUD68JNopHgT+vf9Y=; 
	b=EIWuVxUovOr0FypNSp/bGh7Tk8d2K7bkzScFAd9T1LMex5aiCsjzNXSiWEF+9HW9xl/VFsHYsY7Wypvqtu5zYr9LLh12si+eqCUIOoZIpPkC6LG3Qw2anTmdr9DdV9fZdvCHfTyNzCp/cwNGZLwrKAg2PBzNyvQJrTU4fWYdJyU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724422314;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ROKKRsYio3xxAWmx1+IWV2SIFpDUD68JNopHgT+vf9Y=;
	b=h38/bthj92pZiGKrNEBgZJC/YYHYYdIJ4g6j2ZvhqXmaU5JT578PI2mdVLUgA8XB
	/Gt2VU/btw7knMxKMWW5dgYytLCYwP7kgzy03eI/+2XKY42ftK84uy5Xnx8zRvHs/rg
	KHvSSBpOJF+NRUzXUCyti4OjC+uMEweVMO0XPifE=
Received: by mx.zohomail.com with SMTPS id 1724422312337529.5391082814358;
	Fri, 23 Aug 2024 07:11:52 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	David Wu <david.wu@rock-chips.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	kernel@collabora.com,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v3 1/3] ethernet: stmmac: dwmac-rk: Fix typo for RK3588 code
Date: Fri, 23 Aug 2024 10:11:13 -0400
Message-ID: <20240823141318.51201-2-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240823141318.51201-1-detlev.casanova@collabora.com>
References: <20240823141318.51201-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Fix SELET -> SELECT in RK3588_GMAC_CLK_SELET_CRU and
RK3588_GMAC_CLK_SELET_IO

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 7ae04d8d291c8..9cf0aa58d13bf 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1141,8 +1141,8 @@ static const struct rk_gmac_ops rk3568_ops = {
 #define RK3588_GMAC_CLK_RMII_MODE(id)		GRF_BIT(5 * (id))
 #define RK3588_GMAC_CLK_RGMII_MODE(id)		GRF_CLR_BIT(5 * (id))
 
-#define RK3588_GMAC_CLK_SELET_CRU(id)		GRF_BIT(5 * (id) + 4)
-#define RK3588_GMAC_CLK_SELET_IO(id)		GRF_CLR_BIT(5 * (id) + 4)
+#define RK3588_GMAC_CLK_SELECT_CRU(id)		GRF_BIT(5 * (id) + 4)
+#define RK3588_GMAC_CLK_SELECT_IO(id)		GRF_CLR_BIT(5 * (id) + 4)
 
 #define RK3588_GMA_CLK_RMII_DIV2(id)		GRF_BIT(5 * (id) + 2)
 #define RK3588_GMA_CLK_RMII_DIV20(id)		GRF_CLR_BIT(5 * (id) + 2)
@@ -1240,8 +1240,8 @@ static void rk3588_set_gmac_speed(struct rk_priv_data *bsp_priv, int speed)
 static void rk3588_set_clock_selection(struct rk_priv_data *bsp_priv, bool input,
 				       bool enable)
 {
-	unsigned int val = input ? RK3588_GMAC_CLK_SELET_IO(bsp_priv->id) :
-				   RK3588_GMAC_CLK_SELET_CRU(bsp_priv->id);
+	unsigned int val = input ? RK3588_GMAC_CLK_SELECT_IO(bsp_priv->id) :
+				   RK3588_GMAC_CLK_SELECT_CRU(bsp_priv->id);
 
 	val |= enable ? RK3588_GMAC_CLK_RMII_NOGATE(bsp_priv->id) :
 			RK3588_GMAC_CLK_RMII_GATE(bsp_priv->id);
-- 
2.46.0


