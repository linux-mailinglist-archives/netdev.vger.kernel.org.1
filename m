Return-Path: <netdev+bounces-35607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0087A9FF8
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 22:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A8E22819BF
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 20:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8612F18C38;
	Thu, 21 Sep 2023 20:29:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9C318C20
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 20:29:36 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7F4B0A22
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 13:28:55 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59c0eb18f09so19227187b3.2
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 13:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695328112; x=1695932912; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qQlu8AcxqDlthTNfcXPJSX8cyQ36W0kmNhwkM5OL+9o=;
        b=O3QDVY5iV+/2ikZvzXQZzgzAf7WI2TFkeFpfixCnF9YCLGk1N1nAG4CI8SsJf7xkAl
         vCwIzwWITTfI4SY5W7DSOr0DlGFi1iyq1Tn7NpC/jVt1lEy2plBy7Q6L7fO/ZZjp4Yy5
         Rq/Hpp7wVJQLXxSMLwc3vNsv4xdWVQ96QqYpbXqM6+D9xiCXPbEMU/OKncS15Mn7zd2A
         1jQr6OM6h0ADvykpcSlYS8NgRyrWuEZhbDXGzDbV7mk6KmfVqicR+9qcJDyAAeNa4yA5
         MdNhh1SSgWZjHy4y/vCu9UuOI0ETCiHcXJhaVqbVBEu8pzKxnc/aHqUCaZZ8eRQAwaiW
         UkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695328112; x=1695932912;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQlu8AcxqDlthTNfcXPJSX8cyQ36W0kmNhwkM5OL+9o=;
        b=sc9Wqci3ikmAwwE3PQpaPTLDKb2UL/KpDKZH/dfRRM+EckGqkUQ09iWOtu/IZ5Ww0P
         rGuPNmMVczlbnbtX0yJCQ4XlsLr1K4pFXadRTHpUHHS/aVe4CDHeQL+vrWZscEfzo77s
         84GAbzePprLwNTzWtQs88K4SpZzuscPTt1IO05rHe6rTNI66bFHUE8ZWYm/b1/NimFvO
         UjG3i5me2GkqABUPlF5wtts5YIlZ2onkdzwE7zGxErjx8d3q/u/hxULUNw109g5nWt2M
         pqBdSA+8fitB+t/2UJsxo5Q3s+rzroarf/1fpeJ/hZNWGbP8bTX/p8c1fCi2H6t0Fq5C
         9prQ==
X-Gm-Message-State: AOJu0YwKf/pwFu6KGR0n610eGjzTmD1ejyjf3GaBxDWTXe5xvsZNXsCz
	8Kxt8Tif8oUanq1gCNvaYQaAfwIXzqyENA==
X-Google-Smtp-Source: AGHT+IG0SQDQPySfuvY7ur/80FbXyLjLsiEX1dBefE0VZoo7LXPBIcMP8l/xDgGXKmtJtvck4SthIK1D5Nl22g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:8b0c:0:b0:cf9:3564:33cc with SMTP id
 i12-20020a258b0c000000b00cf9356433ccmr106334ybl.13.1695328111955; Thu, 21 Sep
 2023 13:28:31 -0700 (PDT)
Date: Thu, 21 Sep 2023 20:28:17 +0000
In-Reply-To: <20230921202818.2356959-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230921202818.2356959-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230921202818.2356959-8-edumazet@google.com>
Subject: [PATCH net-next 7/8] net: annotate data-races around sk->sk_tx_queue_mapping
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This field can be read or written without socket lock being held.

Add annotations to avoid load-store tearing.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 56ac1abadea59e6734396a7ef2e22518a0ba80a1..f33e733167df8c2da9240f4af5ed7d715f347394 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2007,21 +2007,33 @@ static inline void sk_tx_queue_set(struct sock *sk, int tx_queue)
 	/* sk_tx_queue_mapping accept only upto a 16-bit value */
 	if (WARN_ON_ONCE((unsigned short)tx_queue >= USHRT_MAX))
 		return;
-	sk->sk_tx_queue_mapping = tx_queue;
+	/* Paired with READ_ONCE() in sk_tx_queue_get() and
+	 * other WRITE_ONCE() because socket lock might be not held.
+	 */
+	WRITE_ONCE(sk->sk_tx_queue_mapping, tx_queue);
 }
 
 #define NO_QUEUE_MAPPING	USHRT_MAX
 
 static inline void sk_tx_queue_clear(struct sock *sk)
 {
-	sk->sk_tx_queue_mapping = NO_QUEUE_MAPPING;
+	/* Paired with READ_ONCE() in sk_tx_queue_get() and
+	 * other WRITE_ONCE() because socket lock might be not held.
+	 */
+	WRITE_ONCE(sk->sk_tx_queue_mapping, NO_QUEUE_MAPPING);
 }
 
 static inline int sk_tx_queue_get(const struct sock *sk)
 {
-	if (sk && sk->sk_tx_queue_mapping != NO_QUEUE_MAPPING)
-		return sk->sk_tx_queue_mapping;
+	if (sk) {
+		/* Paired with WRITE_ONCE() in sk_tx_queue_clear()
+		 * and sk_tx_queue_set().
+		 */
+		int val = READ_ONCE(sk->sk_tx_queue_mapping);
 
+		if (val != NO_QUEUE_MAPPING)
+			return val;
+	}
 	return -1;
 }
 
-- 
2.42.0.515.g380fc7ccd1-goog


