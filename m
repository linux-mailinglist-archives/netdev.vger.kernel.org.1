Return-Path: <netdev+bounces-265977-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oH55CIfvr2nkdAIAu9opvQ
	(envelope-from <netdev+bounces-265977-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:16:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD382493A5
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D06D306E620
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD6A43E4B8;
	Tue, 10 Mar 2026 10:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhjmPuKM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6B436827B
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773137557; cv=none; b=E1B863DFg4sVMz1SDP2KoA0T9NfdrawcOQvZK7UT6Yo2qVkDc9qj6yk+/m46E1Ad/d4Gq90r7Rdrz3azPZbwa9/yjzSXvxTSuJg5YVkLbRSX1u4m9lPegF3jaSMr0BgYSXFCE+Zp/xK8p0GQ7NOH+kTIf77YahFCDC7g9pkvQAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773137557; c=relaxed/simple;
	bh=9uIYTXQT/vrE0pciQl51dMj6ZKgXp6dNXbfxLZzC9zQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LeeTBPMtpfBFYbnTEeQIb+/YjJ2lgfVpFZL27SjCbjkpP0q7o9F+arwHFwdPO+34hogKhvlkuHw6oT56HLE2HRRlIMCyLPSVlqzXEwpF+0EhzvYM9VFm9cjmCOb7GIgggwqoCnsaTAZUESoI6yihc+lpTHCLabEYfDfojChbrJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhjmPuKM; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-899fc9853b7so125526506d6.2
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 03:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773137555; x=1773742355; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UlnZx41UnzHPZwPjs/1q9jmp+xnPPZBychET8h2+TsY=;
        b=JhjmPuKMC1O2WpXdp79Ob4QgpK4nrF/6QB0IdzK1Q4VdQUY/DT20ATFjZOgDpj2vN4
         ylZ3+osXaTwN5p75ohyu0TkCmEdtxBdYcuYcsbKg26qkMoFKi9Ryv43P0k7EX43bvMC8
         SHtwU+pjJ4cpqj1erG0+zNXgU9bAdLREBPzSAfKwmIGne3l30Ice8Gs03EeEuWFZe1i8
         PgGAjBalqyyTrYrvxC7od+GviTSQqjEt/6HeJ2YT4NXZYG83qzFh+hOBYz0JfwrzVhHc
         394l9FEVgcEGj+Zo3TQZRZjSPXheD9tuEC17zDZCTTDeWbofDzI1kkmXa6NuaCo39YV+
         5p3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773137555; x=1773742355;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UlnZx41UnzHPZwPjs/1q9jmp+xnPPZBychET8h2+TsY=;
        b=lawR9wxgd7v2SYR0k2t0byZCUh8091V8y8YyG/bfxBcWLIGwSIevBxWymxzpDmxNsX
         rjWQLStEHOnrvYj0OTgPvomWF8ZF02U/0t5dMDtNg1XHt7JhHta5iLCf30aN0tS7Hsua
         bZSDX60mxkrOOYPzz29v6sU0Mw7Dd8Sdd/xO6krnMs6iK3SC4icK08xvnx0aogKE33At
         yoxyaRb5aZFZbSsoR/+IA8CH9kB8Ts3jDvWYP+gCD2ihh9P3YbyxpK8fL7TviNP7iqV8
         PryhE7FyCmVepXLA8u2ANFB+uskKRtSTXPPiMjRvUOI4z2ZTa2IrHvWcBTaH759Ah1rs
         mrEQ==
X-Gm-Message-State: AOJu0YxyT38Zv935yEJQUcUDuAOkT5gaotis42o/fbDDBabujpgm0iki
	z67749YUerg9YS7UWPYItF/VK9kMZRk7vwntnXkm78Pm6qQUEIldMvox
X-Gm-Gg: ATEYQzyzhq5FlTMunIaTnYdYv7r2kw5bMBxb12JJog2imND8cPoLJJ6QGuAmjDNw3R+
	U+z0lQoAKEY8W0rpzluQwswOknlo3sCJHUk6ECqES3zmLBECyY+SkAHSOdHbv3aKbqs4laW4Qdb
	f2NBomb5SnDnbYdD467sGrHrO77KbGUglWnAwDbQwlZuVZkDvgwqi8PWinxM4Oc0Tbac01hFSEh
	5sdNGbtbQb/313xM5iBTKjrDbrjMVU04ofKCya8GI0kvNypoHynvFzdD2DcR6luw98X8UN3Komc
	BZLO8KoZEwEGVZ5WUw09Ue1x7zAxK/hnOuCXiwvzDKxyPwJ/D6zM7ACuo1lQUUqtYCcoL9R4WSY
	YxYwnP5XOKfeP/AVvMjpcoPFNT6Zt/M5WWJwRcqNVmycWm/ReFYkmmAvIdN1DQL3spIaTuBcf4g
	gaue6R/hmjtt5Kw2kg4T8Z/rfgKQv4Cgf2
X-Received: by 2002:a05:6214:2124:b0:89a:170b:a6fe with SMTP id 6a1803df08f44-89a30c2df79mr186373196d6.65.1773137555116;
        Tue, 10 Mar 2026 03:12:35 -0700 (PDT)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a57c4a0c6sm18867736d6.52.2026.03.10.03.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 03:12:34 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Date: Tue, 10 Mar 2026 18:12:08 +0800
Subject: [PATCH net-next 2/3] net: macb: Clean up the .init settings in
 macb_config instances
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-macb-cleanup-v1-2-928c1a91a7dc@gmail.com>
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
X-Rspamd-Queue-Id: 8DD382493A5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265977-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

All instances of macb_config currently have the .init field set, but most
of them use macb_init(). In fact, there is no need to duplicate this
across all macb_config instances. Introduce a new macb_init() function
that executes the specific .init if it is set; otherwise, it runs a
default initialization function.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 82d3f6017287af409d0a1908400d9967e634203e..27ec1f16c4f18c2be67f5052fd248ed17ea2281b 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4646,7 +4646,7 @@ static int macb_clk_init(struct platform_device *pdev, struct clk **pclk,
 					  tsu_clk);
 }
 
-static int macb_init(struct platform_device *pdev)
+static int macb_init_dflt(struct platform_device *pdev)
 {
 	struct net_device *dev = platform_get_drvdata(pdev);
 	unsigned int hw_q, q;
@@ -4801,6 +4801,15 @@ static int macb_init(struct platform_device *pdev)
 	return 0;
 }
 
+static int macb_init(struct platform_device *pdev,
+		     const struct macb_config *config)
+{
+	if (config->init)
+		return config->init(pdev);
+	else
+		return macb_init_dflt(pdev);
+}
+
 static const struct macb_usrio_config macb_default_usrio = {
 	.mii = MACB_BIT(MII),
 	.rmii = MACB_BIT(RMII),
@@ -5301,7 +5310,7 @@ static int fu540_c000_init(struct platform_device *pdev)
 	if (IS_ERR(mgmt->reg))
 		return PTR_ERR(mgmt->reg);
 
-	return macb_init(pdev);
+	return macb_init_dflt(pdev);
 }
 
 static int init_reset_optional(struct platform_device *pdev)
@@ -5351,7 +5360,7 @@ static int init_reset_optional(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, ret, "failed to reset controller");
 	}
 
-	ret = macb_init(pdev);
+	ret = macb_init_dflt(pdev);
 
 err_out_phy_exit:
 	if (ret)
@@ -5376,7 +5385,7 @@ static int eyeq5_init(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to init PHY\n");
 
-	ret = macb_init(pdev);
+	ret = macb_init_dflt(pdev);
 	if (ret)
 		phy_exit(bp->phy);
 	return ret;
@@ -5402,28 +5411,24 @@ static const struct macb_config fu540_c000_config = {
 
 static const struct macb_config at91sam9260_config = {
 	.caps = MACB_CAPS_USRIO_HAS_CLKEN | MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII,
-	.init = macb_init,
 	.usrio = &macb_default_usrio,
 };
 
 static const struct macb_config sama5d3macb_config = {
 	.caps = MACB_CAPS_SG_DISABLED |
 		MACB_CAPS_USRIO_HAS_CLKEN | MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII,
-	.init = macb_init,
 	.usrio = &macb_default_usrio,
 };
 
 static const struct macb_config pc302gem_config = {
 	.caps = MACB_CAPS_SG_DISABLED | MACB_CAPS_GIGABIT_MODE_AVAILABLE,
 	.dma_burst_length = 16,
-	.init = macb_init,
 	.usrio = &macb_default_usrio,
 };
 
 static const struct macb_config sama5d2_config = {
 	.caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII | MACB_CAPS_JUMBO,
 	.dma_burst_length = 16,
-	.init = macb_init,
 	.jumbo_max_len = 10240,
 	.usrio = &macb_default_usrio,
 };
@@ -5431,7 +5436,6 @@ static const struct macb_config sama5d2_config = {
 static const struct macb_config sama5d29_config = {
 	.caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII | MACB_CAPS_GEM_HAS_PTP,
 	.dma_burst_length = 16,
-	.init = macb_init,
 	.usrio = &macb_default_usrio,
 };
 
@@ -5439,7 +5443,6 @@ static const struct macb_config sama5d3_config = {
 	.caps = MACB_CAPS_SG_DISABLED | MACB_CAPS_GIGABIT_MODE_AVAILABLE |
 		MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII | MACB_CAPS_JUMBO,
 	.dma_burst_length = 16,
-	.init = macb_init,
 	.jumbo_max_len = 10240,
 	.usrio = &macb_default_usrio,
 };
@@ -5447,7 +5450,6 @@ static const struct macb_config sama5d3_config = {
 static const struct macb_config sama5d4_config = {
 	.caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII,
 	.dma_burst_length = 4,
-	.init = macb_init,
 	.usrio = &macb_default_usrio,
 };
 
@@ -5460,7 +5462,6 @@ static const struct macb_config emac_config = {
 
 static const struct macb_config np4_config = {
 	.caps = MACB_CAPS_USRIO_DISABLED,
-	.init = macb_init,
 	.usrio = &macb_default_usrio,
 };
 
@@ -5478,7 +5479,6 @@ static const struct macb_config zynq_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_NO_GIGABIT_HALF |
 		MACB_CAPS_NEEDS_RSTONUBR,
 	.dma_burst_length = 16,
-	.init = macb_init,
 	.usrio = &macb_default_usrio,
 };
 
@@ -5498,7 +5498,6 @@ static const struct macb_config sama7g5_gem_config = {
 		MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII |
 		MACB_CAPS_MIIONRGMII | MACB_CAPS_GEM_HAS_PTP,
 	.dma_burst_length = 16,
-	.init = macb_init,
 	.usrio = &sama7g5_usrio,
 };
 
@@ -5507,7 +5506,6 @@ static const struct macb_config sama7g5_emac_config = {
 		MACB_CAPS_USRIO_HAS_CLKEN | MACB_CAPS_MIIONRGMII |
 		MACB_CAPS_GEM_HAS_PTP,
 	.dma_burst_length = 16,
-	.init = macb_init,
 	.usrio = &sama7g5_usrio,
 };
 
@@ -5538,7 +5536,6 @@ static const struct macb_config raspberrypi_rp1_config = {
 		MACB_CAPS_GEM_HAS_PTP |
 		MACB_CAPS_EEE,
 	.dma_burst_length = 16,
-	.init = macb_init,
 	.usrio = &macb_default_usrio,
 	.jumbo_max_len = 10240,
 };
@@ -5578,7 +5575,6 @@ static const struct macb_config default_gem_config = {
 		MACB_CAPS_JUMBO |
 		MACB_CAPS_GEM_HAS_PTP,
 	.dma_burst_length = 16,
-	.init = macb_init,
 	.usrio = &macb_default_usrio,
 	.jumbo_max_len = 10240,
 };
@@ -5748,7 +5744,7 @@ static int macb_probe(struct platform_device *pdev)
 		bp->phy_interface = interface;
 
 	/* IP specific init */
-	err = macb_config->init(pdev);
+	err = macb_init(pdev, macb_config);
 	if (err)
 		goto err_out_free_netdev;
 

-- 
2.53.0


