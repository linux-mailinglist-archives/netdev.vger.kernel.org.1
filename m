Return-Path: <netdev+bounces-46781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 627717E6624
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 10:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25D9BB20C85
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 09:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E38710A3E;
	Thu,  9 Nov 2023 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mYpbZa3v"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B5B10A0A
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 09:03:18 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C862592
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 01:03:17 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c523ac38fbso7102781fa.0
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 01:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699520595; x=1700125395; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vzJIeWNq2FEaPyhEpEI6+O7cf3g+sTgw9uPY1dLEPEs=;
        b=mYpbZa3vIe9EoNguaotcW/iuSHQ5nJBhgru7WF6umoDpHN8iwGyMUVIzZqeN7eSC3l
         bUROfxyTyv02qOd4rGh8NC+KC69rP6AUrqfKFV3nAS4z7hQulpEAySIvj2YDKQls4mlI
         AojGS0iRcvbzcwYkXhI/m40+2CgdjYHgCcJQBpDpurkLQGVCPZCZc5IdPJg0d+t1y9f0
         RgujTfifKDufDowdBz6SUtKczS1KGL8L7QqF9lfjQH1xFJmd36RoajCR9HwiPFBrc8ue
         NKBDQnl6UlkdtCu2HTrURXahxmyMNTRihtRx+iwZ2j0MGLkytjexc5aCbi/1wx1Okb92
         12Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699520595; x=1700125395;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzJIeWNq2FEaPyhEpEI6+O7cf3g+sTgw9uPY1dLEPEs=;
        b=ATjKWn7DABuxNjAXLk/42lTWcZHxCd3VJLfvxH+Q4J0OUFqqJlEnjoFOJ8mVqdZZIr
         D612aShPDqr7o0o7Sq1KKkogSzmsm6Y/TD7eu4gORz78epUNIPQzt+cT3tezeV5OYweH
         vLRE4s1TTk0VhMvGqoRU51ILJixOk0kUe1001a9kFcuUWh3FO0d3dJQ07GMZHgkCleh9
         H2TQarh84R8QIH81SsJI3Y0HWeVGl8kUF7tPNn6IPsqu8pwUPQUz2k/OUW54AfgZ+8ce
         sO0dTrO7GVB66lfacpzXJisXrXdcuYQCUb8raqJ4CT881AOCAZ2ePZ1YZAlLPohqbc/O
         3lWg==
X-Gm-Message-State: AOJu0YwpKY0L4kfATIHYYfiEpjrV23x5un4c5Gd4fZZHwiTKux4WaxHk
	DRbapk2tpQdI8VY5aXW49oE9Vw==
X-Google-Smtp-Source: AGHT+IH0sjqNLl/veK2UKnVf2/NE7U4+3ND+oxhdQlRbHZbnIHRAFaAKtPKKAo+K3oMuEO5OM9Y+qA==
X-Received: by 2002:a2e:9e53:0:b0:2c5:cac:e9a3 with SMTP id g19-20020a2e9e53000000b002c50cace9a3mr3404465ljk.52.1699520594884;
        Thu, 09 Nov 2023 01:03:14 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id h19-20020a05651c159300b002bbacc6c523sm2212383ljq.49.2023.11.09.01.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 01:03:14 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 09 Nov 2023 10:03:12 +0100
Subject: [PATCH net v4 1/3] net: ethernet: cortina: Fix max RX frame define
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231109-gemini-largeframe-fix-v4-1-6e611528db08@linaro.org>
References: <20231109-gemini-largeframe-fix-v4-0-6e611528db08@linaro.org>
In-Reply-To: <20231109-gemini-largeframe-fix-v4-0-6e611528db08@linaro.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

Enumerator 3 is 1548 bytes according to the datasheet.
Not 1542.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 4 ++--
 drivers/net/ethernet/cortina/gemini.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index a8b9d1a3e4d5..5bdd1b252840 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -432,8 +432,8 @@ static const struct gmac_max_framelen gmac_maxlens[] = {
 		.val = CONFIG0_MAXLEN_1536,
 	},
 	{
-		.max_l3_len = 1542,
-		.val = CONFIG0_MAXLEN_1542,
+		.max_l3_len = 1548,
+		.val = CONFIG0_MAXLEN_1548,
 	},
 	{
 		.max_l3_len = 9212,
diff --git a/drivers/net/ethernet/cortina/gemini.h b/drivers/net/ethernet/cortina/gemini.h
index 9fdf77d5eb37..99efb1155743 100644
--- a/drivers/net/ethernet/cortina/gemini.h
+++ b/drivers/net/ethernet/cortina/gemini.h
@@ -787,7 +787,7 @@ union gmac_config0 {
 #define  CONFIG0_MAXLEN_1536	0
 #define  CONFIG0_MAXLEN_1518	1
 #define  CONFIG0_MAXLEN_1522	2
-#define  CONFIG0_MAXLEN_1542	3
+#define  CONFIG0_MAXLEN_1548	3
 #define  CONFIG0_MAXLEN_9k	4	/* 9212 */
 #define  CONFIG0_MAXLEN_10k	5	/* 10236 */
 #define  CONFIG0_MAXLEN_1518__6	6

-- 
2.34.1


