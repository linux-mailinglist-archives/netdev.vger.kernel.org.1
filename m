Return-Path: <netdev+bounces-36586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EBA7B0B89
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 19:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E0BEA284591
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 17:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924454BDD5;
	Wed, 27 Sep 2023 17:58:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D5F48E81
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 17:58:20 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8801AB
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 10:58:07 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id d75a77b69052e-41810cfc569so50082821cf.2
        for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 10:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1695837486; x=1696442286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AQzb+SwvsGBOEDzBjP4js4Sz2yj+gakJ7LKev+o0njQ=;
        b=C5IIxI+pINtGg0abOaawu4LgnPahsj3UVakl7upV3RgvtwX5QSy27keLxYbeNHFAG+
         PYWOvUaVPF+pNIe3AeYKSOUNTZD3mfZdI+2LiSyD5xtKScQOqVtcLHlMYTM++WULSUg4
         gQ93CiD3cX4m6hUkyNKBJbTP1QCiYbieQQf1Ipk3X4COFhxHTaZ7t0P9pxzHZMBMAoi+
         5Pj53KLxnQl+qGMlbIsdpn8Mr9R90Za1sgKpBPMU8WRzFMwEmvJHQhw7LgiQYwPig6Tw
         mjbsm/r/h7MaaJGBYw8KNsH0qEc35MSAeA8SyLoxjiMnw+aemWQluvQ3VD6lKmbX6t9b
         RhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695837486; x=1696442286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AQzb+SwvsGBOEDzBjP4js4Sz2yj+gakJ7LKev+o0njQ=;
        b=TeeSS+4GxLRkY/j5zFliZsEy0dC95VO1em5tDpg441MvrMJrENBie9f9926MvDQ6Gj
         Js0vuewoi9gVm+qYz8I+7Cvkdjd2wx3rQYwLK8EuEUqRFtVRmeYy63pRtla2Rp+kW0Dz
         Wp5Bl0iCQQWShs3onhMV0NM6V5EbccPFhRlwJ8CiS40arCYjFKWjTaQUjy50mPPOXm2O
         l/ZtlBrPjio8mkD/sQuYUi8HHSjaZYyaGRghrAyuTxNdaFRqtzwLtl+OQsluDGOk1AJ2
         KbvxMuERg8nHv6vsIrdidneuDTeBXb3fE4RAzRiHS4hzRiUyuTORJTn7rAd/p0wtpdLh
         kbCw==
X-Gm-Message-State: AOJu0YxHukv7iog9xWozJghR/cK36AcYp7D6QEpD4w/jGV69gCZmpql/
	JEW2z0QBgivvvrYDtPHK8g6ysg==
X-Google-Smtp-Source: AGHT+IEBMS9WLtGs4+++Dzkg5Mo5nm24aZkgeo3xhxJJgHUp6UGYBeiOZLJhiw6Jv5TzrYz5ZxgiEQ==
X-Received: by 2002:a05:622a:14b:b0:416:5ead:6171 with SMTP id v11-20020a05622a014b00b004165ead6171mr3362737qtw.47.1695837486383;
        Wed, 27 Sep 2023 10:58:06 -0700 (PDT)
Received: from localhost.localdomain ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id j4-20020ac84c84000000b004195b8554efsm711368qtv.24.2023.09.27.10.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 10:58:05 -0700 (PDT)
From: Ben Wolsieffer <ben.wolsieffer@hefring.com>
To: linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Christophe Roullier <christophe.roullier@st.com>,
	Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: [PATCH net] net: stmmac: dwmac-stm32: fix resume on STM32 MCU
Date: Wed, 27 Sep 2023 13:57:49 -0400
Message-ID: <20230927175749.1419774-1-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The STM32MP1 keeps clk_rx enabled during suspend, and therefore the
driver does not enable the clock in stm32_dwmac_init() if the device was
suspended. The problem is that this same code runs on STM32 MCUs, which
do disable clk_rx during suspend, causing the clock to never be
re-enabled on resume.

This patch adds a variant flag to indicate that clk_rx remains enabled
during suspend, and uses this to decide whether to enable the clock in
stm32_dwmac_init() if the device was suspended.

This approach fixes this specific bug with limited opportunity for
unintended side-effects, but I have a follow up patch that will refactor
the clock configuration and hopefully make it less error prone.

Fixes: 6528e02cc9ff ("net: ethernet: stmmac: add adaptation for stm32mp157c.")
Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index bdb4de59a672..28c8ca5fba6c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -105,6 +105,7 @@ struct stm32_ops {
 	int (*parse_data)(struct stm32_dwmac *dwmac,
 			  struct device *dev);
 	u32 syscfg_eth_mask;
+	bool clk_rx_enable_in_suspend;
 };
 
 static int stm32_dwmac_init(struct plat_stmmacenet_data *plat_dat)
@@ -122,7 +123,8 @@ static int stm32_dwmac_init(struct plat_stmmacenet_data *plat_dat)
 	if (ret)
 		return ret;
 
-	if (!dwmac->dev->power.is_suspended) {
+	if (!dwmac->ops->clk_rx_enable_in_suspend ||
+	    !dwmac->dev->power.is_suspended) {
 		ret = clk_prepare_enable(dwmac->clk_rx);
 		if (ret) {
 			clk_disable_unprepare(dwmac->clk_tx);
@@ -514,7 +516,8 @@ static struct stm32_ops stm32mp1_dwmac_data = {
 	.suspend = stm32mp1_suspend,
 	.resume = stm32mp1_resume,
 	.parse_data = stm32mp1_parse_data,
-	.syscfg_eth_mask = SYSCFG_MP1_ETH_MASK
+	.syscfg_eth_mask = SYSCFG_MP1_ETH_MASK,
+	.clk_rx_enable_in_suspend = true
 };
 
 static const struct of_device_id stm32_dwmac_match[] = {
-- 
2.42.0


