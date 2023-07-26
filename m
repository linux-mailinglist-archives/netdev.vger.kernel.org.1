Return-Path: <netdev+bounces-21519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 935B2763C8B
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 18:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40BC128201F
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 16:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FA4EA8;
	Wed, 26 Jul 2023 16:32:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0FA18024
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 16:32:04 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB1F269E;
	Wed, 26 Jul 2023 09:32:03 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbc63c2e84so71144925e9.3;
        Wed, 26 Jul 2023 09:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690389122; x=1690993922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tjPMb9HkbGw8tTyajg7c43jaFapql171y86o5wmOzBc=;
        b=i8nLO/Svs8W9bsskGYQos6XO8qAO77J7FTAbvitLedxNiCuYkhan+NpOXxpecunaj3
         rL/28meURqT/Cr4qBwsp7morWkSsyqZGRhqSa148JhhNL3h16PEizsVS8EZh2xJ4nSnm
         Mns76R9u/czKHJ+qrcwpl60gopwTU3NPO56A+CLCcavpWYqBGwbukE08Ro0TrfT7WtVu
         DNlz+v4WILDBBgbpptPPPLohM2MigKmSzqtiZx5p2U1jM3fqlSPOcgPaERZRq137ViXz
         fZCoYQbxhr7X1dsMsdLgyL6ebqzdRgHM8qfLTfzbhUsODZ2zRes5CwhscOAtamzD5DoU
         RAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690389122; x=1690993922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tjPMb9HkbGw8tTyajg7c43jaFapql171y86o5wmOzBc=;
        b=MqGbWDr7VnuN5PnXA9W4/M8mW28nG9H8EUolz87d3IYjIHmwb17WQ9eDlosHiBC5D+
         TYA4BNWBH8qD3Y4zk+7O95hN8B7EiB7ub4wH7kcc50PRdqWo2bVVLhczp0jtq8wMfuik
         kbJpaiCcpYeEdPOYndQXF0vpSvj/RCWRxpm7nX4JeFOjpH5z7Ipq/cBHbkpeweJIlj9n
         AW7a4aDkJfacOPWUaYYHcb/1FP/+N9TnmE1iCMtqYW+CbmiKwZkb0qEnFIwLnULaFOnK
         m1LD1k0KbMhN0HNUGSLmeU4oVPjbVxHtXyaj/mt5ap6F38ol9/5ExGgzgyvt+lY2dRG+
         PAyA==
X-Gm-Message-State: ABy/qLaLdgGW9rtB6/GGlY1PNgynDq1OtN/ekw4oLChcgd4+iR6LFfoP
	76I+YWERi1jIF07umwa7HD4=
X-Google-Smtp-Source: APBJJlE/4DBmZ/C4HcUl8ceh4QCbZN09IERbJ2EaO1wfE/YP8sE9KJmVC4EHYm1G8MzJLqOeRE/GMQ==
X-Received: by 2002:a05:600c:20d4:b0:3fb:b67b:7f15 with SMTP id y20-20020a05600c20d400b003fbb67b7f15mr2040587wmm.21.1690389121401;
        Wed, 26 Jul 2023 09:32:01 -0700 (PDT)
Received: from localhost (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c511400b003f7f475c3bcsm11205528wms.1.2023.07.26.09.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 09:32:01 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jon Hunter <jonathanh@nvidia.com>,
	netdev@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH] net: stmmac: tegra: Properly allocate clock bulk data
Date: Wed, 26 Jul 2023 18:32:00 +0200
Message-ID: <20230726163200.2138394-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Thierry Reding <treding@nvidia.com>

The clock data is an array of struct clk_bulk_data, so make sure to
allocate enough memory.

Fixes: d8ca113724e7 ("net: stmmac: tegra: Add MGBE support")
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
index 99e2e5a5cd60..78a492b91bc6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
@@ -234,7 +234,8 @@ static int tegra_mgbe_probe(struct platform_device *pdev)
 	res.addr = mgbe->regs;
 	res.irq = irq;
 
-	mgbe->clks = devm_kzalloc(&pdev->dev, sizeof(*mgbe->clks), GFP_KERNEL);
+	mgbe->clks = devm_kcalloc(&pdev->dev, ARRAY_SIZE(mgbe_clks),
+				  sizeof(*mgbe->clks), GFP_KERNEL);
 	if (!mgbe->clks)
 		return -ENOMEM;
 
-- 
2.41.0


