Return-Path: <netdev+bounces-39273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7F37BE98C
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 20:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF23A1C20A62
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 18:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3823F3B288;
	Mon,  9 Oct 2023 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xZH9r6R6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF7E3B290
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 18:35:01 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA6FD60
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 11:34:46 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d865a8a7819so6652956276.2
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 11:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696876485; x=1697481285; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bM4vdckG8rnY8B9pZotgnlGAv6uavP2L8KjGx2+6gvw=;
        b=xZH9r6R6hvMY68Tiu3kpxICYzqQU7DV9Ehb/DiweNr4TSZB0dUV8rz1exoiibYEpal
         Uh7HGc7YYn173RlkOrHG94VBRnrNoNLHpUzDvnlJYKDdThv7A7Qne0fxigSMQ7NsMIsF
         wVir/Ab7d5KHeH4O2x8p07s28fAtSk6xRBzWVJvQZiK+DzOW0583kXdVYu/L3TBeknOJ
         OXYkXK8c9YkXO8SePZflGPT288tE+qM9BiWYl8p8Pcr0E93x5r+WpuuU0ambtsyX1j2z
         RG1Kzuaiv76PghMoa7D/L/5KF+pxj2zKRAiUA3kPXZ5ImczIScSkzIhmUCE7Bt6Ns2IK
         Z7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876485; x=1697481285;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bM4vdckG8rnY8B9pZotgnlGAv6uavP2L8KjGx2+6gvw=;
        b=UIXWB+/b+kBfJjL/RRGXvbGRyDO6dnK3dbvaJW9IskPAYOfjb7pJLgPGEJOfkrkows
         txPZXCScXW7fLWVFFm/x6/tSNcsBCAv/KM7Sj3yv5BYSu8RJ0ntk/mZ5eL2bpKdP8q8x
         Rm+tzZ1Z+V4y8dV3Pxvo9j+PQ5rBpDKFHxlto+2sQzoP4MZKaJYTSQNwWJdY9ssxKOQ9
         4kh2Njfnut1TL2U3eEV4Sh4S+kwvXVfDpCu1h53o5cbKpTnmIhUbRiJuqSWxhlW/wP/L
         VkuCbfxvlmZV1I4FJONjvvosQznw77udhVXAPUdrSVwPrOrhEJZEz9Kso+WU6npXfXtH
         M56w==
X-Gm-Message-State: AOJu0YwfI0ZvvSja4WQC1bxnWt+cMcsJ6z5MJ9HaewzV5l2Bf+b8nuTF
	U6XIGiwH4Ntqqk3LVOSSwUZHOeZLOFnHoF5bZA==
X-Google-Smtp-Source: AGHT+IHMz+HoiK4CgCHFqTdRUktcbV79j9WV7kYPpy2lP7Lwe/7Y/FP6kzM8Y3AsOSe6R0NaeE49wvFHxld6DNL7jg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:ca11:0:b0:d89:42af:d46f with SMTP
 id a17-20020a25ca11000000b00d8942afd46fmr249115ybg.12.1696876485366; Mon, 09
 Oct 2023 11:34:45 -0700 (PDT)
Date: Mon, 09 Oct 2023 18:34:45 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMRHJGUC/x2NMQ6DMAwAv4I811IIDLRfqTqAbahVkVAbISrE3
 xsx3HDL3QEupuLwqA4w2dQ1pyL1rQJ692kSVC4OMcSmDuGOvlqi5Ydsuok5JlmRvccvXXQfpDz POSEhc6SuHWIz8AgluJiMul+z5+s8/1JexLp8AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696876484; l=1550;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=72/H5p/SqqXCeml5lTqSbORWxP5Dde/Rx27bjYoRkyI=; b=uiIFKsYNOtyGmZZuRJCdtAqcUUTlXBnxMGZ7beN4zUUJbUF5DJ7nGEjqPX9DJ4N7NrHcNyVwn
 5RXoS8GIPeZDyfLDD4QRTM4rqMjNrzqzx7FnEz2V2ZPC7M66FEmogNL
X-Mailer: b4 0.12.3
Message-ID: <20231009-strncpy-drivers-net-dsa-qca-qca8k-common-c-v1-1-34c8040e0f32@google.com>
Subject: [PATCH] net: dsa: qca8k: replace deprecated strncpy with ethtool_sprintf
From: Justin Stitt <justinstitt@google.com>
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

ethtool_sprintf() is designed specifically for get_strings() usage.
Let's replace strncpy in favor of this more robust and easier to
understand interface.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/net/dsa/qca/qca8k-common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
index fce04ce12cf9..9ff0a3c1cb91 100644
--- a/drivers/net/dsa/qca/qca8k-common.c
+++ b/drivers/net/dsa/qca/qca8k-common.c
@@ -487,8 +487,7 @@ void qca8k_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 		return;
 
 	for (i = 0; i < priv->info->mib_count; i++)
-		strncpy(data + i * ETH_GSTRING_LEN, ar8327_mib[i].name,
-			ETH_GSTRING_LEN);
+		ethtool_sprintf(&data, "%s", ar8327_mib[i].name);
 }
 
 void qca8k_get_ethtool_stats(struct dsa_switch *ds, int port,

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231009-strncpy-drivers-net-dsa-qca-qca8k-common-c-dd2c84b23bdf

Best regards,
--
Justin Stitt <justinstitt@google.com>


