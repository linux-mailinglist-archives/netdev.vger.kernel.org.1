Return-Path: <netdev+bounces-57365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1DA812F38
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 12:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A699282C57
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 11:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFA34B5DB;
	Thu, 14 Dec 2023 11:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="gryyX4Y6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B18126
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:46:37 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54f4f7d082cso9028779a12.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1702554396; x=1703159196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lR5Cjb3g5JwSTu3j/K8ArNRp5NJou/sw/M1aYXvPkhE=;
        b=gryyX4Y6UY59iIdoIvoVNQbrEJ94YU9HfU3wjgLIP/OpjCse6cSY9v0Q1yvikxxU58
         AtAFQJ78WRBndmjC0tLCBLt71fUZTVcODl9BRyM2CSNgYw6NkT1x7WhTssQMH9S0pvXw
         xXG4Z56d79I9g5kGyBJXgwN5T3LxmQUi2ROk8n4y3JgH0Xbl4kGIAdqMnP8QEhOSwbal
         xmiN77e4n1g19FI3SRkPV0ZNB9pAY6IlhTj2vxoOTb4RKeLOY1qccznWHhQ1IZ+h1dwZ
         7GldsMsUw9wHI1lgQ9mpbgCO8LA1HiBnRr+8yclOH2tqNbUcq+haASEVPTu0OHeAZWZy
         f87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702554396; x=1703159196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lR5Cjb3g5JwSTu3j/K8ArNRp5NJou/sw/M1aYXvPkhE=;
        b=q9wTxpYGtGd557ZqDt1ELHbwZOF7cL750BxkkwTOv4BN/c6TYN34vt7ugZX9EFKCGl
         nF1FqGZLRgyGFfF6LwoP4MYELWp49jLsauwMQt7ATh76vucPUCvvSs6dWyvtto7iW3qG
         P9jJQSoLTgp7yfZjJrA3gh6qnDiegwbDiqpU33xuEIM/Syb+EOCXbZmLfS+5RIwtVRqB
         hT94hlsKQ9TgC+r9Uxxo6Kj+oJH12XtVNvTDULJeNwQkkT4nLoXfU67Mwbc/6/DPGIn+
         O93r2EgFB5rD3rm8dwkCw3A2tz6kCK+fdZ2xQiMx6WbEsgxaJ/hLOTNqVGPUEH2omJRN
         mbLQ==
X-Gm-Message-State: AOJu0YxZ5t5EWRKqWAQpa+pw8LcfUnEbi22kGSbMDbdYjwmaZRifw0Ks
	/kB7vaZeYCD89602QyJKPTJGeQ==
X-Google-Smtp-Source: AGHT+IGTEA8XdvK5DIgTXUJDZNcrpoxh+EdMHgeULkwRzquHNIZ6hTg2ARSBoQED7sSDbafP7bbF/g==
X-Received: by 2002:a17:906:53:b0:a22:fc0f:9878 with SMTP id 19-20020a170906005300b00a22fc0f9878mr1424003ejg.16.1702554396449;
        Thu, 14 Dec 2023 03:46:36 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id ll9-20020a170907190900b00a1da2f7c1d8sm9240877ejc.77.2023.12.14.03.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:46:36 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	p.zabel@pengutronix.de,
	yoshihiro.shimoda.uh@renesas.com,
	wsa+renesas@sang-engineering.com,
	geert+renesas@glider.be
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v2 11/21] net: ravb: Move DBAT configuration to the driver's ndo_open API
Date: Thu, 14 Dec 2023 13:45:50 +0200
Message-Id: <20231214114600.2451162-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231214114600.2451162-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231214114600.2451162-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

DBAT setup was done in the driver's probe API. As some IP variants switch
to reset mode (and thus registers' content is lost) when setting clocks
(due to module standby functionality) to be able to implement runtime PM
move the DBAT configuration in the driver's ndo_open API.

This commit prepares the code for the addition of runtime PM.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none; this patch is new

 drivers/net/ethernet/renesas/ravb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 04eaa1967651..6b8ca08be35e 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1822,6 +1822,7 @@ static int ravb_open(struct net_device *ndev)
 		napi_enable(&priv->napi[RAVB_NC]);
 
 	ravb_set_delay_mode(ndev);
+	ravb_write(ndev, priv->desc_bat_dma, DBAT);
 
 	/* Device init */
 	error = ravb_dmac_init(ndev);
@@ -2841,7 +2842,6 @@ static int ravb_probe(struct platform_device *pdev)
 	}
 	for (q = RAVB_BE; q < DBAT_ENTRY_NUM; q++)
 		priv->desc_bat[q].die_dt = DT_EOS;
-	ravb_write(ndev, priv->desc_bat_dma, DBAT);
 
 	/* Initialise HW timestamp list */
 	INIT_LIST_HEAD(&priv->ts_skb_list);
-- 
2.39.2


