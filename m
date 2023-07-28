Return-Path: <netdev+bounces-22308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FB2767018
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 17:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55173280998
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 15:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816301401B;
	Fri, 28 Jul 2023 15:03:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7549B13FEA
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 15:03:30 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9330F2115
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:03:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d1ef70d6a02so2054710276.0
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690556606; x=1691161406;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n0SIKkklUKXz8BROmZbmHRwqxxJVaruqidUm0AjtvKg=;
        b=OH5TsN0+28ZBpftWzz1fpv/mpJ17qjCnCeXd9epMfK4sPMRIlGbJN4JFEbif8IZ+ES
         rM1nqj7EuwkzSoLWSOE+P7PzP8wAp33/G0UJt0ntKec65sHLRw/aCISoJkfdcGrBQVpk
         +n7oxCHGluljb1a3L31wLMlBy6V96r37PRl6qUsQX1+waZbtJZ+drpyCcbKse6ddbmfB
         Vu1Ts8A8fIEcliDB2kHteg37poURthgEahLnbuvdb5QCgs1OJ/n1FY58lViQNcvaqJCc
         O3eE4orGt5+RVsySo5moKyiOjzs5gpYBw31DmvhYgSXhwb35SZ2Xw1ajaOYWCLl2L2I7
         HlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690556606; x=1691161406;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n0SIKkklUKXz8BROmZbmHRwqxxJVaruqidUm0AjtvKg=;
        b=QgXd1C4St8NByaSD8gw7mCtYwibdkKW0/0+z2ndIVLd42BYoMpJkW/dGlCTfopvo1A
         8nfVpYwLGD4tgiKDYYEGGmEOShu8Qfr3sW4bPWmZKMqGYr1IbnW4TssERKb7QHbTC+jn
         Dflt5rKHLVBsvjPj1OnK1+v04NyYNpB4cnu/P/UdfGqfhTyxQDkONxhrkyFH5n58tG1D
         GlrXIBIy4fO/bqi+buN3SbpVPBNO1zwa7MQGbXxdygKb+hVO/h9OnAFpBXNr7YxbBv5w
         uTdLt77HIGzfY2FWjdVkoy8q6hXfzmtB1vXXQzE0Gbq5nvxc+W5UKju0gHoqCQLTE79n
         nsxg==
X-Gm-Message-State: ABy/qLb9cydY9AE6i3y9sn3+eRq7qJ+E2n8vCXBKoB/XLHi/8PX7cA2I
	Yq0+0aFi86E5PkO8sTqlsQT97qt7NAiMWg==
X-Google-Smtp-Source: APBJJlFzHA8Zdrxr8fA6FiYcnE9ViSGoMbTdZeO4Ey63GUc09N4bzTKNDapzETndME1/nWUtEkq1wZTNvnbhEA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:6984:0:b0:d0f:bcfe:bc74 with SMTP id
 e126-20020a256984000000b00d0fbcfebc74mr11105ybc.9.1690556606641; Fri, 28 Jul
 2023 08:03:26 -0700 (PDT)
Date: Fri, 28 Jul 2023 15:03:10 +0000
In-Reply-To: <20230728150318.2055273-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230728150318.2055273-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230728150318.2055273-4-edumazet@google.com>
Subject: [PATCH net 03/11] net: annotate data-races around sk->sk_max_pacing_rate
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

sk_getsockopt() runs locklessly. This means sk->sk_max_pacing_rate
can be read while other threads are changing its value.

Fixes: 62748f32d501 ("net: introduce SO_MAX_PACING_RATE")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/sock.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index adec93dda56af7314f4a63c77f3848441f0d41ae..fec18755f7727206a0b8c0d486b14bde2347296e 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1439,7 +1439,8 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 			cmpxchg(&sk->sk_pacing_status,
 				SK_PACING_NONE,
 				SK_PACING_NEEDED);
-		sk->sk_max_pacing_rate = ulval;
+		/* Pairs with READ_ONCE() from sk_getsockopt() */
+		WRITE_ONCE(sk->sk_max_pacing_rate, ulval);
 		sk->sk_pacing_rate = min(sk->sk_pacing_rate, ulval);
 		break;
 		}
@@ -1903,12 +1904,14 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 #endif
 
 	case SO_MAX_PACING_RATE:
+		/* The READ_ONCE() pair with the WRITE_ONCE() in sk_setsockopt() */
 		if (sizeof(v.ulval) != sizeof(v.val) && len >= sizeof(v.ulval)) {
 			lv = sizeof(v.ulval);
-			v.ulval = sk->sk_max_pacing_rate;
+			v.ulval = READ_ONCE(sk->sk_max_pacing_rate);
 		} else {
 			/* 32bit version */
-			v.val = min_t(unsigned long, sk->sk_max_pacing_rate, ~0U);
+			v.val = min_t(unsigned long, ~0U,
+				      READ_ONCE(sk->sk_max_pacing_rate));
 		}
 		break;
 
-- 
2.41.0.585.gd2178a4bd4-goog


