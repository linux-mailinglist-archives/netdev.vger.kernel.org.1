Return-Path: <netdev+bounces-46112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F5A7E16B3
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 21:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D566EB20F5E
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 20:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B15618C27;
	Sun,  5 Nov 2023 20:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R1+nq3Qj"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D981518655
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 20:57:32 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656D8DE
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 12:57:31 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c5028e5b88so53205641fa.3
        for <netdev@vger.kernel.org>; Sun, 05 Nov 2023 12:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699217849; x=1699822649; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9I/5QuNpGxNYQ0Q3gYhof8mVfyBGfSfCNnlFCET9W5g=;
        b=R1+nq3Qjdg2hCgC72Qjgy15PG/WFVs4o/VMBOjsxYk/M5itwqwYMIMVRnAd22QxoGD
         AjpsN4tVjWcRUdYrcNYQQ0zNSdTcyMdJoQ4HZ3h3keqmXIYrrzqCg54mdJhenrqehrhv
         VxqWWydDyDIQCe3iJcd7g5bJCbx6u6iSepetRD3QRrlNm80ZwKK6GI/7eGlQRRFECiJ0
         YWt6h003w9Mtc1bNPOkVx5spZ19e7RIjJj6j768FoelffoHexMhASRHvnADFC+Ak+n6H
         BXh2YrgeISmaZPy8cvgJ3WPiCB2vUwStvwtIxKkznJKdlQvOsL1gfGjIv7ZHRZ6UvYla
         KhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699217849; x=1699822649;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9I/5QuNpGxNYQ0Q3gYhof8mVfyBGfSfCNnlFCET9W5g=;
        b=fT5nuCo4AdYBIM5cBDCAuVjNxdsNmyBBLb8PdxMlVPISfygC9xm1/vium3uIaucl3R
         p6dE2xa+nAupyhuBgamxVSRMQQD43sW8T2mXxd0Ut2HsbUO7QqYG87WJTiUiujgS/RE9
         aSTBrEVK9ciio76X7zzpiCTOyd8AUIUIOYy7U76rI6n6rOPxcDdhgFw6kXqmk5m6wrkj
         ZEbc5QSFfD9a1IooSKIC8TmzV4Mow13x0VBsncrhRabna2gNdikxoFPoggRHqMU8ogTc
         8OVqRcHe7/9oVfrwLO/qV4Vcx3ILABXvL4lSqI4wa5yexvHn+epoyv7qlNondiCf7RM8
         7LKg==
X-Gm-Message-State: AOJu0YwaK1ro9CEfiM/iXJ3GEBTL8fUin7I0x8AKdRX/5N1XczKKbTz9
	cAbHYHF+3eIvqMy1KpGwl9z53g==
X-Google-Smtp-Source: AGHT+IHEu2ba+AMGz02oEBnNqKcgRmT3tE+uIa+goUWOOC86KvEtoEC6fxxX+YOpDBoyi6G/5ZvToQ==
X-Received: by 2002:ac2:5398:0:b0:507:9f69:e8d9 with SMTP id g24-20020ac25398000000b005079f69e8d9mr19751912lfh.49.1699217849468;
        Sun, 05 Nov 2023 12:57:29 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id d12-20020ac24c8c000000b00507c72697d0sm931873lfl.303.2023.11.05.12.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 12:57:28 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 05 Nov 2023 21:57:24 +0100
Subject: [PATCH net v2 2/4] net: ethernet: cortina: Fix max RX frame define
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231105-gemini-largeframe-fix-v2-2-cd3a5aa6c496@linaro.org>
References: <20231105-gemini-largeframe-fix-v2-0-cd3a5aa6c496@linaro.org>
In-Reply-To: <20231105-gemini-largeframe-fix-v2-0-cd3a5aa6c496@linaro.org>
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


