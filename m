Return-Path: <netdev+bounces-46383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 384DE7E3844
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 10:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E608A281029
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 09:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCB714007;
	Tue,  7 Nov 2023 09:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cw8sWqgK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E59512E69
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 09:54:38 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBDF11A
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 01:54:36 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507d1cc0538so7329193e87.2
        for <netdev@vger.kernel.org>; Tue, 07 Nov 2023 01:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699350875; x=1699955675; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9I/5QuNpGxNYQ0Q3gYhof8mVfyBGfSfCNnlFCET9W5g=;
        b=cw8sWqgK1dCbpTCOVilOsRRpFu+XGwe2A+JlBn9gIc5z+A02F1E55dCZmZVaCzjn65
         tP/PZfyiXANxGB/yXYN/GUwV+cGpYsngXlhPEVRaF0BJ+drRu/8aynJKmGkgwOfzN0gF
         XHBmRvVWb0As33NpAdU6czRD7XoVLMV5SQXXrzGc8To8LRdGn9yaWD3BzoimO5/F7S4F
         FsvHHc81LGD2ZS5I7PWbWggkjq7wLDJM+n1JOuMMLQ2P4FPXLqq6z9nUrjnqT3gbp9uT
         AKWCYboEaQhz758ng27QcAYU8Iuv7WdvYvljrh3zybXkxpR2PDSAp/TKuTxl/9ec/OOy
         NBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699350875; x=1699955675;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9I/5QuNpGxNYQ0Q3gYhof8mVfyBGfSfCNnlFCET9W5g=;
        b=ro2EL7jdfHT8yEdqpa7Siy3fafMRbxCeH1xoFArxa8nGznAR3XpC4WajNL+Z3HjnZK
         0ouyKJIH81uJ2iWU5vcTt8QZ3RkJvXeTZyAHRKaIR/maf5dSevGq/v5KQfwbSoGZL5t9
         qIYxq2xl3/BDW58NW2hfkJA6PRTsK7mnvjKNyb+Wty9V0abDzosqC0j/K4jZ2hXf0NnJ
         O4ne19T3DiUOXzIypfXQ+pEg7it8iMiDEEWovxWgqhUMfP5T3p+On0izVdjDLP/Xv7oV
         Yy1Pc+czboGHuiafJgYfxRBXcqcjrO7VAcRJ6w34p/fLOhlhu/6RZrxeRazlndHc8K86
         BwvQ==
X-Gm-Message-State: AOJu0Yw6r9yCV0Cmnxrd04N/yQx2NUIFoq1A+Tp0IBZ3I3OhRnkeX3EV
	L7518ZdOqpp13E3LU9ig1/ueZg==
X-Google-Smtp-Source: AGHT+IGlT4InGGRd4uD9B/kQKUczRMijoKcGtyPoFdZviLpDAoD/so75+M9LyQ+ioSY6DkDZzqHtaQ==
X-Received: by 2002:a05:6512:358e:b0:505:6cc7:e0f7 with SMTP id m14-20020a056512358e00b005056cc7e0f7mr20581023lfr.44.1699350875084;
        Tue, 07 Nov 2023 01:54:35 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id m25-20020ac24ad9000000b005091314185asm296356lfp.285.2023.11.07.01.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 01:54:34 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 07 Nov 2023 10:54:27 +0100
Subject: [PATCH net v3 2/4] net: ethernet: cortina: Fix max RX frame define
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231107-gemini-largeframe-fix-v3-2-e3803c080b75@linaro.org>
References: <20231107-gemini-largeframe-fix-v3-0-e3803c080b75@linaro.org>
In-Reply-To: <20231107-gemini-largeframe-fix-v3-0-e3803c080b75@linaro.org>
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
index ed9701f8ad9a..b21a94b4ab5c 100644
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
index 201b4efe2937..24bb989981f2 100644
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


