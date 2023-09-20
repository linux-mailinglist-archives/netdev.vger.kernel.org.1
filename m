Return-Path: <netdev+bounces-35296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6B67A8AA4
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 19:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013681F20EFF
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 17:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30CD3FB04;
	Wed, 20 Sep 2023 17:29:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A38330F80
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 17:29:55 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90BDD7
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 10:29:52 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59eea906b40so1081307b3.0
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 10:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695230992; x=1695835792; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/VNQSHl9xJ3fOoWfeqforfijrZv9vAu0Dbk3+hPXYcw=;
        b=OONfd3GfJxpCBIrtnbExOMH/fWN+iXLmky8Pydh9S7G1QsOASJRvfRMHIOsrWJ1281
         k62s+5dvmtLeCr0/gAXHNr+dzkdNaNL144SqNaE9WidKKiO7SAx5cqD3aVO/K+OoGs41
         E9BxR9dpFhq6R2/qyhqckVxt3wjI+zWaq4crh77V74AWM6fw5qU0MN0mE4g08eAeu5hm
         3rCGd7oimtpoB3iafYXLPNEQigTZM+kJGXXGMxME2TcAJ5xRKRa1d1fJUthb+nXm/DEm
         o+T6SWmg10MJpW3GdT4moKaijPWl8dV0yfSNl3L/72oboL4OSaktf66ZuExmkVpdGyGp
         imSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695230992; x=1695835792;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/VNQSHl9xJ3fOoWfeqforfijrZv9vAu0Dbk3+hPXYcw=;
        b=WC2PeUv9lGFiq8gPw+ChDCqxeIqBgbsog7sn9n2+iaNABiYKENfsANYo4dNPTzrogQ
         UYftGVGwHjeXh3nhsabMf1+5NiX1aNPgVpfAnIxT3u+3513qM2ux6nzNqu+BvbVd/JiU
         IAzJ2eAMXkxklGTUPk0vRLrgxePrXPIg1gSz9LlSahKi9LSTrJohw7AygajYFibMKSV0
         fCDPGp7pFbIwFclhC9R0F0PV/YDt04Fl5515ylpRwQVVghNIkeyYJU7eGudStHBfUhcV
         Q/r9nTSYjTNIxA1DYE26VAipwAKvHYt+E1BLo9EeswGrLkIDCiYstNdfjnTJo9hJQ6hV
         vSTw==
X-Gm-Message-State: AOJu0YyQULj4LHazwyc6rzvvHu4O8C0UArC8s3oWOtMXKILfiWWatgbL
	fpZjVIWQcXS7tN8vJ7pxHSHWfBtYki1miA==
X-Google-Smtp-Source: AGHT+IEdl6UJqmpGQBOmSbcKOCKSohG/sXJ+Txu/OSiX7JIk5//SNW3hW1GfK5uiErWk64B8+dpzAWDq9+aXiQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:d30d:0:b0:565:9bee:22e0 with SMTP id
 y13-20020a81d30d000000b005659bee22e0mr52854ywi.0.1695230991770; Wed, 20 Sep
 2023 10:29:51 -0700 (PDT)
Date: Wed, 20 Sep 2023 17:29:42 +0000
In-Reply-To: <20230920172943.4135513-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230920172943.4135513-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230920172943.4135513-3-edumazet@google.com>
Subject: [PATCH net-next 2/3] tcp: constify tcp_rto_min() and tcp_rto_min_us() argument
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Make clear these functions do not change any field from TCP socket.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 91688d0dadcd6f72144aac747178de8d85f15bf7..a8db7d43fb6215197af4a80e270b8c82070d55cb 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -719,7 +719,7 @@ static inline void tcp_fast_path_check(struct sock *sk)
 }
 
 /* Compute the actual rto_min value */
-static inline u32 tcp_rto_min(struct sock *sk)
+static inline u32 tcp_rto_min(const struct sock *sk)
 {
 	const struct dst_entry *dst = __sk_dst_get(sk);
 	u32 rto_min = inet_csk(sk)->icsk_rto_min;
@@ -729,7 +729,7 @@ static inline u32 tcp_rto_min(struct sock *sk)
 	return rto_min;
 }
 
-static inline u32 tcp_rto_min_us(struct sock *sk)
+static inline u32 tcp_rto_min_us(const struct sock *sk)
 {
 	return jiffies_to_usecs(tcp_rto_min(sk));
 }
-- 
2.42.0.459.ge4e396fd5e-goog


