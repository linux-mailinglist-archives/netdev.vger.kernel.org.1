Return-Path: <netdev+bounces-46029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 495087E0F70
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 13:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05539281B35
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 12:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA741A581;
	Sat,  4 Nov 2023 12:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fzaz3lDG"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE4918022
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 12:43:55 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909C1194
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 05:43:53 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507a62d4788so3892608e87.0
        for <netdev@vger.kernel.org>; Sat, 04 Nov 2023 05:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699101832; x=1699706632; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QWgOFAkaCrL22TdDDJiVpTuZM0XAGRWs9ieW0NKW7II=;
        b=fzaz3lDGtWmN0cUCFT7Iva7piX0heeiCfuSuxVjUKedBm5fMw95+gqlowm+R+MZyDU
         a17jaZu2Sv6XTm7lV2c+JzMpwpVFhpwK/rpMPPUp8is4Dgl+KS8T7k9xQu90hk6t9oM7
         ++j5sJtL6YfD3+quANzBVwUZsn3LeDz9PAsLEAlKEnoM45GAG5FrQblDkUeXhx6oE2fL
         /X3NxBLBsyWcvYLtlAOaEw8EjoAQA75WNNP82gQsRFdHrEOqV3nglXOq3S6499pGUZOt
         9uz3CKOupefq9pmCS4+H7hf61RpUq6v4x1ibGWjm2R/3NGz/d1i3quuQGJia63CqrF3f
         xbDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699101832; x=1699706632;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWgOFAkaCrL22TdDDJiVpTuZM0XAGRWs9ieW0NKW7II=;
        b=qpo7jfNzQXlQQW92U2Tbm0cwbIgt3dyDKhYJ6QXoI0FEE91U4UvLwsUacZXABF/Gap
         3CJWDugfoCRvhf9uTDSQVY+skNRL9DPOZoeFZDZBItc1NpckZH6lZP1914EILjSkbQnT
         wYYzDMr8vKQNp2DB3/jGsSmTtWeGZUebj8yCAnTaPOvqSV6JcRutRIVNkp1lgMq7tXV1
         G/6phuVuETYE7HL3DWCcqvOzV1sAUHM38Ob0RZKvCfEI/p1wSUE3/2m+tl7J9RtS9/wv
         sTiAi1oVcKQQ5BWk5V4cYjJwJ1dwZfA9bd9DvkZQLvnKVTt4yTu1LH/Fh9qqK3/0+FLA
         bMRA==
X-Gm-Message-State: AOJu0YxyGGPay9FN4vhagw1A/lva4FWUUDcdY6QW3VVBp6eY6SSviPRp
	AwZCx8uyFqM4nQLz+bCltTjCbg==
X-Google-Smtp-Source: AGHT+IE/D76DP6LP5S/bC2ZUouN5nx6tvXDeDM1odIxhJnsb2wJCBGqDcoLyl8FiiBhU1HViFRqPDQ==
X-Received: by 2002:a05:6512:3196:b0:4fa:f96c:745f with SMTP id i22-20020a056512319600b004faf96c745fmr23906142lfe.38.1699101831782;
        Sat, 04 Nov 2023 05:43:51 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id u22-20020ac24c36000000b005093312f66fsm496100lfq.124.2023.11.04.05.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 05:43:51 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 04 Nov 2023 13:43:49 +0100
Subject: [PATCH net 2/4] net: ethernet: cortina: Fix max RX frame define
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231104-gemini-largeframe-fix-v1-2-9c5513f22f33@linaro.org>
References: <20231104-gemini-largeframe-fix-v1-0-9c5513f22f33@linaro.org>
In-Reply-To: <20231104-gemini-largeframe-fix-v1-0-9c5513f22f33@linaro.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Vladimir Oltean <olteanv@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

Enumerator 3 is 1548 bytes according to the datasheet.
Not 1542.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 4 ++--
 drivers/net/ethernet/cortina/gemini.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index e12d14359133..fd08f098850b 100644
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
index d7101bfcb4a0..e4b9049b6400 100644
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


