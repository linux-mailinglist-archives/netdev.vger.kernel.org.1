Return-Path: <netdev+bounces-265976-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACBNFZfur2nkdAIAu9opvQ
	(envelope-from <netdev+bounces-265976-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:12:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EACA22492DF
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4FF43031345
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7CF44D011;
	Tue, 10 Mar 2026 10:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FE9jATVP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8A143E4AB
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773137554; cv=none; b=c9U+3hV2Hz8ZeKsWKW3vJObyJsvcqjonTLXFapb6uWdCTZckA3T1FGaWb/0krDxdN+xzsMQAmZqmAmIOo5nRsTsWGeF50Vu09ZB17qxekFkyUJEBP8HCvjPCEPw2J5nggE+l+IjOiJMbLFk/v8kJldDILagfK5LrEllBKJotbIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773137554; c=relaxed/simple;
	bh=RA60J6Sab9JeFHeHAlHx57uZaBzR5VdRouw6IrlD4yg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FfQFcywskcEr+s/ZFabWfH8sBj+EFUFKgQvLkgeuSTK2nH9IEYg9/lT/lHkRr3HAzfRPsltQ91heT7/Ihl59556+/pUn/8zumb/aG7B2A4G6M5I4etjc3A5n9mQMWCFWz38gRAT7Q2qsMCe6NBfRRI2snFk3+uo8xKeXHuULOwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FE9jATVP; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-899ee491af3so95546856d6.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 03:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773137552; x=1773742352; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/WWBPIPyom5p0QfOeCcv3s2P2ZGkGJ0Z8fV9acPCWD8=;
        b=FE9jATVP8xxqINDjO9wPXU8ztQUkKa44rf/k2/pOxdjh8Mw5L61TmJjZP6df88hah8
         byud57Yev2cmk5ZMfH90by4j8qHUUvUFs2nxjJdzmCbvvjifmI7ql2DHiZ4vpL2U/mbe
         T7siSm3IKkE7l7EVyVs6vBxkjzWN3UbVquUIGc39GNu9ZHBExtEUOYkNwukdR/EX4EFt
         9NVF/Sw4VcsdGGX00SUTxU8xsQfu44po4qQKiT4Yh+F8kVPazY4vngIRMLhsmaii0Q8P
         sq+59xYNk9NScRefsCD2qd6hGI4Qq8wtESKIWBMI7Kx9oYwaKoYXC1ldhX6HjEc5+K5z
         8pbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773137552; x=1773742352;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/WWBPIPyom5p0QfOeCcv3s2P2ZGkGJ0Z8fV9acPCWD8=;
        b=GUR6VrYRqdqUdx0EPQ8vGH1OkmdB11lC/ga6nFRjfhZLjjZiK/KZRK60LrDxTwuAge
         mZDb2Q7F2zjX6nVqTqIOwpC+cRASWXKTTNJnbUsHl0A+O2XsTwb7LTIfrzCE8A7+6x1B
         wu7NIL6AviOmHtE+3qXhICFE4Xb7EMs4fm1xo6GJUixZXn1jsmvesE23MaYRg7N2ghxb
         ygdSbnWRVQbj1AAeEBfTBfdJxEhSoITi1s84ODUKAnmI1Qdzrc07BQtTZF9ogePjHsmo
         xQMOvGfVGFXhGpAdAwL+/beO6ZECuNFdE7co3/jfHgQ/QRdHnAHTOMp4UUdHB5M0V1qc
         pkyQ==
X-Gm-Message-State: AOJu0Yx/EBhvjJbhOO7Wui1BNSNKGLicHoNwDALie31wwU4+q8dFo3UI
	B3mE9ieS1gb0Xb+MwgkaYsJj9E0OZlWAkEocXaSALxDZRvEEDS+ugQ2V
X-Gm-Gg: ATEYQzzt+5uQEFOw7wTtXHxryBocYGp8MIZRNM7RU6BXbPeEIBMdiUeOg6u5DDiYrNC
	JscFPfxUW2VT6om67VKArTFhh5gTwPmWoovtWwMJE4F4/nvYHnBdyohm4dnfKooy/vh7fs0Dbkx
	GsnLuL7vyIhk3dfeGLFziqos7gFOt0TbCA7a9/+Ue6iUh0l1JMKpP4EySa83FMMj1f3Vmvo97G0
	HJ/Da85rUJyw/HrZAnnBf1BOuF/TtJ/fQfzEqj+zA5C2M3iAm/yPPT3EaYFHn+7Lt7ec2284vXd
	KdfrAHhE+6fyHgRVac99hbsvVo55+f/7beLwyu2z4DZgijm0Utsj/QO9WDd9vvuX6QdboYMEwpK
	O/HU6MzQD7JYIBQoCnPUH/yw+PGZyYXfayMZvAGz6xvMh/DRNRcHdr2Na+gXKKY47mqx4fAXDEP
	xCw0qekNncB3j1UGkHrbXtOZBBKfcCBYoJ+AtXCSp1HoQ=
X-Received: by 2002:a05:6214:4014:b0:899:afef:2167 with SMTP id 6a1803df08f44-89a30a29bcbmr209297826d6.12.1773137551385;
        Tue, 10 Mar 2026 03:12:31 -0700 (PDT)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a57c4a0c6sm18867736d6.52.2026.03.10.03.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 03:12:31 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Date: Tue, 10 Mar 2026 18:12:07 +0800
Subject: [PATCH net-next 1/3] net: macb: Clean up the .clk_init setting in
 the macb_config instances
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-macb-cleanup-v1-1-928c1a91a7dc@gmail.com>
References: <20260310-macb-cleanup-v1-0-928c1a91a7dc@gmail.com>
In-Reply-To: <20260310-macb-cleanup-v1-0-928c1a91a7dc@gmail.com>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Kevin Hao <haokexin@gmail.com>
X-Mailer: b4 0.14.2
X-Rspamd-Queue-Id: EACA22492DF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265976-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

All instances of macb_config currently have .clk_init set, but most of
them use macb_clk_init(). In fact, there is no need to duplicate this
across all macb_config instances. Introduce a new macb_clk_init()
function that executes the specific .clk_init if it is set; otherwise,
it runs the default clock initialization function.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 41 +++++++++++++++-----------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 3dcae4d5f74c9709a86fae837d25501da4484bf7..82d3f6017287af409d0a1908400d9967e634203e 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4548,9 +4548,9 @@ static void macb_clks_disable(struct clk *pclk, struct clk *hclk, struct clk *tx
 	clk_bulk_disable_unprepare(ARRAY_SIZE(clks), clks);
 }
 
-static int macb_clk_init(struct platform_device *pdev, struct clk **pclk,
-			 struct clk **hclk, struct clk **tx_clk,
-			 struct clk **rx_clk, struct clk **tsu_clk)
+static int macb_clk_init_dflt(struct platform_device *pdev, struct clk **pclk,
+			      struct clk **hclk, struct clk **tx_clk,
+			      struct clk **rx_clk, struct clk **tsu_clk)
 {
 	struct macb_platform_data *pdata;
 	int err;
@@ -4633,6 +4633,19 @@ static int macb_clk_init(struct platform_device *pdev, struct clk **pclk,
 	return err;
 }
 
+static int macb_clk_init(struct platform_device *pdev, struct clk **pclk,
+			 struct clk **hclk, struct clk **tx_clk,
+			 struct clk **rx_clk, struct clk **tsu_clk,
+			 const struct macb_config *config)
+{
+	if (config->clk_init)
+		return config->clk_init(pdev, pclk, hclk, tx_clk, rx_clk,
+					tsu_clk);
+	else
+		return macb_clk_init_dflt(pdev, pclk, hclk, tx_clk, rx_clk,
+					  tsu_clk);
+}
+
 static int macb_init(struct platform_device *pdev)
 {
 	struct net_device *dev = platform_get_drvdata(pdev);
@@ -5241,7 +5254,7 @@ static int fu540_c000_clk_init(struct platform_device *pdev, struct clk **pclk,
 	struct clk_init_data init;
 	int err = 0;
 
-	err = macb_clk_init(pdev, pclk, hclk, tx_clk, rx_clk, tsu_clk);
+	err = macb_clk_init_dflt(pdev, pclk, hclk, tx_clk, rx_clk, tsu_clk);
 	if (err)
 		return err;
 
@@ -5389,7 +5402,6 @@ static const struct macb_config fu540_c000_config = {
 
 static const struct macb_config at91sam9260_config = {
 	.caps = MACB_CAPS_USRIO_HAS_CLKEN | MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII,
-	.clk_init = macb_clk_init,
 	.init = macb_init,
 	.usrio = &macb_default_usrio,
 };
@@ -5397,7 +5409,6 @@ static const struct macb_config at91sam9260_config = {
 static const struct macb_config sama5d3macb_config = {
 	.caps = MACB_CAPS_SG_DISABLED |
 		MACB_CAPS_USRIO_HAS_CLKEN | MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII,
-	.clk_init = macb_clk_init,
 	.init = macb_init,
 	.usrio = &macb_default_usrio,
 };
@@ -5405,7 +5416,6 @@ static const struct macb_config sama5d3macb_config = {
 static const struct macb_config pc302gem_config = {
 	.caps = MACB_CAPS_SG_DISABLED | MACB_CAPS_GIGABIT_MODE_AVAILABLE,
 	.dma_burst_length = 16,
-	.clk_init = macb_clk_init,
 	.init = macb_init,
 	.usrio = &macb_default_usrio,
 };
@@ -5413,7 +5423,6 @@ static const struct macb_config pc302gem_config = {
 static const struct macb_config sama5d2_config = {
 	.caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII | MACB_CAPS_JUMBO,
 	.dma_burst_length = 16,
-	.clk_init = macb_clk_init,
 	.init = macb_init,
 	.jumbo_max_len = 10240,
 	.usrio = &macb_default_usrio,
@@ -5422,7 +5431,6 @@ static const struct macb_config sama5d2_config = {
 static const struct macb_config sama5d29_config = {
 	.caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII | MACB_CAPS_GEM_HAS_PTP,
 	.dma_burst_length = 16,
-	.clk_init = macb_clk_init,
 	.init = macb_init,
 	.usrio = &macb_default_usrio,
 };
@@ -5431,7 +5439,6 @@ static const struct macb_config sama5d3_config = {
 	.caps = MACB_CAPS_SG_DISABLED | MACB_CAPS_GIGABIT_MODE_AVAILABLE |
 		MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII | MACB_CAPS_JUMBO,
 	.dma_burst_length = 16,
-	.clk_init = macb_clk_init,
 	.init = macb_init,
 	.jumbo_max_len = 10240,
 	.usrio = &macb_default_usrio,
@@ -5440,7 +5447,6 @@ static const struct macb_config sama5d3_config = {
 static const struct macb_config sama5d4_config = {
 	.caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII,
 	.dma_burst_length = 4,
-	.clk_init = macb_clk_init,
 	.init = macb_init,
 	.usrio = &macb_default_usrio,
 };
@@ -5454,7 +5460,6 @@ static const struct macb_config emac_config = {
 
 static const struct macb_config np4_config = {
 	.caps = MACB_CAPS_USRIO_DISABLED,
-	.clk_init = macb_clk_init,
 	.init = macb_init,
 	.usrio = &macb_default_usrio,
 };
@@ -5464,7 +5469,6 @@ static const struct macb_config zynqmp_config = {
 		MACB_CAPS_JUMBO |
 		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH,
 	.dma_burst_length = 16,
-	.clk_init = macb_clk_init,
 	.init = init_reset_optional,
 	.jumbo_max_len = 10240,
 	.usrio = &macb_default_usrio,
@@ -5474,7 +5478,6 @@ static const struct macb_config zynq_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_NO_GIGABIT_HALF |
 		MACB_CAPS_NEEDS_RSTONUBR,
 	.dma_burst_length = 16,
-	.clk_init = macb_clk_init,
 	.init = macb_init,
 	.usrio = &macb_default_usrio,
 };
@@ -5484,7 +5487,6 @@ static const struct macb_config mpfs_config = {
 		MACB_CAPS_JUMBO |
 		MACB_CAPS_GEM_HAS_PTP,
 	.dma_burst_length = 16,
-	.clk_init = macb_clk_init,
 	.init = init_reset_optional,
 	.usrio = &macb_default_usrio,
 	.max_tx_length = 4040, /* Cadence Erratum 1686 */
@@ -5496,7 +5498,6 @@ static const struct macb_config sama7g5_gem_config = {
 		MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII |
 		MACB_CAPS_MIIONRGMII | MACB_CAPS_GEM_HAS_PTP,
 	.dma_burst_length = 16,
-	.clk_init = macb_clk_init,
 	.init = macb_init,
 	.usrio = &sama7g5_usrio,
 };
@@ -5506,7 +5507,6 @@ static const struct macb_config sama7g5_emac_config = {
 		MACB_CAPS_USRIO_HAS_CLKEN | MACB_CAPS_MIIONRGMII |
 		MACB_CAPS_GEM_HAS_PTP,
 	.dma_burst_length = 16,
-	.clk_init = macb_clk_init,
 	.init = macb_init,
 	.usrio = &sama7g5_usrio,
 };
@@ -5517,7 +5517,6 @@ static const struct macb_config versal_config = {
 		MACB_CAPS_NEED_TSUCLK | MACB_CAPS_QUEUE_DISABLE |
 		MACB_CAPS_QBV,
 	.dma_burst_length = 16,
-	.clk_init = macb_clk_init,
 	.init = init_reset_optional,
 	.jumbo_max_len = 10240,
 	.usrio = &macb_default_usrio,
@@ -5528,7 +5527,6 @@ static const struct macb_config eyeq5_config = {
 		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_QUEUE_DISABLE |
 		MACB_CAPS_NO_LSO | MACB_CAPS_EEE,
 	.dma_burst_length = 16,
-	.clk_init = macb_clk_init,
 	.init = eyeq5_init,
 	.jumbo_max_len = 10240,
 	.usrio = &macb_default_usrio,
@@ -5540,7 +5538,6 @@ static const struct macb_config raspberrypi_rp1_config = {
 		MACB_CAPS_GEM_HAS_PTP |
 		MACB_CAPS_EEE,
 	.dma_burst_length = 16,
-	.clk_init = macb_clk_init,
 	.init = macb_init,
 	.usrio = &macb_default_usrio,
 	.jumbo_max_len = 10240,
@@ -5581,7 +5578,6 @@ static const struct macb_config default_gem_config = {
 		MACB_CAPS_JUMBO |
 		MACB_CAPS_GEM_HAS_PTP,
 	.dma_burst_length = 16,
-	.clk_init = macb_clk_init,
 	.init = macb_init,
 	.usrio = &macb_default_usrio,
 	.jumbo_max_len = 10240,
@@ -5611,7 +5607,8 @@ static int macb_probe(struct platform_device *pdev)
 	if (!macb_config)
 		macb_config = &default_gem_config;
 
-	err = macb_config->clk_init(pdev, &pclk, &hclk, &tx_clk, &rx_clk, &tsu_clk);
+	err = macb_clk_init(pdev, &pclk, &hclk, &tx_clk, &rx_clk, &tsu_clk,
+			    macb_config);
 	if (err)
 		return err;
 

-- 
2.53.0


