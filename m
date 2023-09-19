Return-Path: <netdev+bounces-35056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C057A6B6D
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 21:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0077A2814A4
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 19:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817A32AB3D;
	Tue, 19 Sep 2023 19:20:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0DF28E16
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 19:20:04 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2832EA
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 12:20:02 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id af79cd13be357-773ae5d2b1fso320956785a.2
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 12:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1695151202; x=1695756002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tnm2Moa364NnFvHBWbJW5Miitr7z3kjIIDJjJlIthFQ=;
        b=jqd1UVw6vBz3BQwmehiHhdpaAtVrMwEIx/ar5/0g9Wx3/m7Ea565CyZjxQ/+h9vZK9
         KElcGoOJkimanqMoZrDGWQSghxPLpQ2nSX8Z5WIdLuqylb+0Ya57sQ558zPHcH+bzmGR
         SFxf7HOG9cWUV5bjWxacXbjmqNq6pPty72H/rMR/MGbXzmAii+4IkCIjl8O6F21tU4PO
         TZWYZ4AJ5bPChs3TQ62JZaNStG6gVxdmKqQFDhVBKbEIJ6h/n3C9OkhdtAE08IJeg2gn
         RCRZ00Ou1CdfXBoXKuDoMcOlch6zXH4vWB2hd/1HVmq/9YcEuXCrv/6UiYnDQhGnGm9J
         YYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695151202; x=1695756002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tnm2Moa364NnFvHBWbJW5Miitr7z3kjIIDJjJlIthFQ=;
        b=IriRf4i4m/NqBek6UCaX0zkP8/6S1gmiOBScPN7Op+Uo5OhCyZRFUdfpilsy12Iw4l
         T3ROvTsxhaNM8hNoJTMESWczVwzCfuzUGKlzdo4InA8u/BzvQj56uPlp8PlmrD4qtFO9
         wy4z4/3uuWt07unZH1xNOnb1VSf+r3VTI5POCHv7OD394G+sgWvOKd2X8UvfcPxS2uLG
         Vs3qOVmXLrho7nyMuypXXKCPaOBfo90apPSnNIxbGJc2su33SlBS/SFgbrL8wjFYIBID
         IxjBb1DC8oMxbD9CsqBNtkAL/87KTzY0sZqsXOiye2MjiIYY5AWvk+kw2VY85bJtzTXm
         RsNw==
X-Gm-Message-State: AOJu0YwEAgugluwE12EGNVWaIuT7ZtCYWqV8QV9SFw4XdAih8+kE7Mn3
	xkEYIUvALOCRQnHrto0aC59q4g==
X-Google-Smtp-Source: AGHT+IEtMT18UqS7I4dDjLyzrmF1BJ/xA9i1ZcPz4h6w0cU5Wi2SCvT/zEEnS+t7MQZQTRvyYMQR/w==
X-Received: by 2002:a05:620a:288e:b0:76c:d958:d549 with SMTP id j14-20020a05620a288e00b0076cd958d549mr784459qkp.11.1695151201770;
        Tue, 19 Sep 2023 12:20:01 -0700 (PDT)
Received: from dell-precision-5540.lan ([2601:18c:8002:3d40:df77:9915:c17e:79])
        by smtp.gmail.com with ESMTPSA id x12-20020ae9f80c000000b0076c60b95b87sm4179704qkh.96.2023.09.19.12.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 12:20:01 -0700 (PDT)
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
Subject: [PATCH 1/2] net: stmmac: dwmac-stm32: fix resume on STM32 MCU
Date: Tue, 19 Sep 2023 12:45:35 -0400
Message-ID: <20230919164535.128125-3-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230919164535.128125-2-ben.wolsieffer@hefring.com>
References: <20230919164535.128125-2-ben.wolsieffer@hefring.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
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

Fixes: 6528e02cc9ff ("net: ethernet: stmmac: add adaptation for stm32mp157c.")
Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index 26ea8c687881..a0e276783e65 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -104,6 +104,7 @@ struct stm32_ops {
 	int (*parse_data)(struct stm32_dwmac *dwmac,
 			  struct device *dev);
 	u32 syscfg_eth_mask;
+	bool clk_rx_enable_in_suspend;
 };
 
 static int stm32_dwmac_init(struct plat_stmmacenet_data *plat_dat)
@@ -121,7 +122,8 @@ static int stm32_dwmac_init(struct plat_stmmacenet_data *plat_dat)
 	if (ret)
 		return ret;
 
-	if (!dwmac->dev->power.is_suspended) {
+	if (!dwmac->ops->clk_rx_enable_in_suspend ||
+	    !dwmac->dev->power.is_suspended) {
 		ret = clk_prepare_enable(dwmac->clk_rx);
 		if (ret) {
 			clk_disable_unprepare(dwmac->clk_tx);
@@ -513,7 +515,8 @@ static struct stm32_ops stm32mp1_dwmac_data = {
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


