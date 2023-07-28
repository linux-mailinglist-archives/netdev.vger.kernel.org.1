Return-Path: <netdev+bounces-22310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A335476701A
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 17:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D41651C21926
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 15:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324991427D;
	Fri, 28 Jul 2023 15:03:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DF114268
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 15:03:32 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9174205
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:03:30 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-573cacf4804so23017247b3.1
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690556609; x=1691161409;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dukpCyw6fa5wMeppCkxjAb74NBGNhWB1WuCyGXnSn/k=;
        b=qyzEJ7HN004H4HAojVgC5YKQ3J6JoByF6i5MsKQ5qKMdsYFp4C7zbE23MNO9+5Kyam
         E/HBEadAqYBCuF69xp8kxMdaS70pkr85D6W23a+FTLWLxAq1aJqA3+RwoBzUCECWRKBq
         htlaYidsM6aZjQKQMquhh5WJ/+911FUYgMAEzxKH/fOYkATFRS7ImLhW3DlNP3Cq5ltv
         txd/uicxfCmjIqB86IP0az6m3dpCPmda0Og6mWhg/OPq7xyr6W96kmB1/DEzNcLq48JX
         ECtz/LkkhF1QGswGIEoe7ySkWOIJvWUSADIhIEUKWY6lGd40A1gEgDXqvlXLudwobQy2
         WYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690556609; x=1691161409;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dukpCyw6fa5wMeppCkxjAb74NBGNhWB1WuCyGXnSn/k=;
        b=X1DTMirY9mLKUlft9pByNiZHhYiiFp1cnEM8Y9epAViA4rSzS6oiS0dHQnNLeIVlKE
         dQfc2EI5bTJmsVROs160J7K6TT/jR991JQo/r0JF5Um4u6hkgbrqBIgIHSTyBB/jHCQ+
         V75McaDD5ODmx6R82NhiCUNgMOl88/58qACvsv7Hs1uVs8xmvSeJDLx2aahcNY8TYgnO
         papaw+7uIeNEqmOMomYocG1ixuGLVxBQyo61umEjN3zGOddDzka4XVX0VkFrCIYL/9Qz
         p6rDZMSbOin2Gx2FAUCWbRjfbb+SU0hyeYo/OmF6YQdBDckjg8ind6zQfuybLSzSIEg4
         D/Bw==
X-Gm-Message-State: ABy/qLbLnxfP8rPKzZsMHpZAJJQtKGgbPUmqyytGbQBiNPFkIfBRINyE
	ajTDFP8mnxbTOkbrJpZrR07jhBDjMa7+Bg==
X-Google-Smtp-Source: APBJJlFU41kpu8gFKB4pyDgTOwzbQ5ipxVtNuAK2zPahdtcmOBLjemAP4o/XW5SmqCeOnRdaxgiW57v9R9DNPA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:b724:0:b0:580:8dfc:7f85 with SMTP id
 v36-20020a81b724000000b005808dfc7f85mr13095ywh.9.1690556609797; Fri, 28 Jul
 2023 08:03:29 -0700 (PDT)
Date: Fri, 28 Jul 2023 15:03:12 +0000
In-Reply-To: <20230728150318.2055273-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230728150318.2055273-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230728150318.2055273-6-edumazet@google.com>
Subject: [PATCH net 05/11] net: annotate data-races around sk->sk_{rcv|snd}timeo
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

sk_getsockopt() runs without locks, we must add annotations
to sk->sk_rcvtimeo and sk->sk_sndtimeo.

In the future we might allow fetching these fields before
we lock the socket in TCP fast path.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/sock.c     | 24 ++++++++++++++----------
 net/sched/em_meta.c |  4 ++--
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 08e60500160571e46c798e6cd71d56234a516fd3..264c99c190ac9a550d93b760d78f006b216fcb75 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -429,6 +429,7 @@ static int sock_set_timeout(long *timeo_p, sockptr_t optval, int optlen,
 {
 	struct __kernel_sock_timeval tv;
 	int err = sock_copy_user_timeval(&tv, optval, optlen, old_timeval);
+	long val;
 
 	if (err)
 		return err;
@@ -439,7 +440,7 @@ static int sock_set_timeout(long *timeo_p, sockptr_t optval, int optlen,
 	if (tv.tv_sec < 0) {
 		static int warned __read_mostly;
 
-		*timeo_p = 0;
+		WRITE_ONCE(*timeo_p, 0);
 		if (warned < 10 && net_ratelimit()) {
 			warned++;
 			pr_info("%s: `%s' (pid %d) tries to set negative timeout\n",
@@ -447,11 +448,12 @@ static int sock_set_timeout(long *timeo_p, sockptr_t optval, int optlen,
 		}
 		return 0;
 	}
-	*timeo_p = MAX_SCHEDULE_TIMEOUT;
-	if (tv.tv_sec == 0 && tv.tv_usec == 0)
-		return 0;
-	if (tv.tv_sec < (MAX_SCHEDULE_TIMEOUT / HZ - 1))
-		*timeo_p = tv.tv_sec * HZ + DIV_ROUND_UP((unsigned long)tv.tv_usec, USEC_PER_SEC / HZ);
+	val = MAX_SCHEDULE_TIMEOUT;
+	if ((tv.tv_sec || tv.tv_usec) &&
+	    (tv.tv_sec < (MAX_SCHEDULE_TIMEOUT / HZ - 1)))
+		val = tv.tv_sec * HZ + DIV_ROUND_UP((unsigned long)tv.tv_usec,
+						    USEC_PER_SEC / HZ);
+	WRITE_ONCE(*timeo_p, val);
 	return 0;
 }
 
@@ -813,9 +815,9 @@ void sock_set_sndtimeo(struct sock *sk, s64 secs)
 {
 	lock_sock(sk);
 	if (secs && secs < MAX_SCHEDULE_TIMEOUT / HZ - 1)
-		sk->sk_sndtimeo = secs * HZ;
+		WRITE_ONCE(sk->sk_sndtimeo, secs * HZ);
 	else
-		sk->sk_sndtimeo = MAX_SCHEDULE_TIMEOUT;
+		WRITE_ONCE(sk->sk_sndtimeo, MAX_SCHEDULE_TIMEOUT);
 	release_sock(sk);
 }
 EXPORT_SYMBOL(sock_set_sndtimeo);
@@ -1721,12 +1723,14 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 
 	case SO_RCVTIMEO_OLD:
 	case SO_RCVTIMEO_NEW:
-		lv = sock_get_timeout(sk->sk_rcvtimeo, &v, SO_RCVTIMEO_OLD == optname);
+		lv = sock_get_timeout(READ_ONCE(sk->sk_rcvtimeo), &v,
+				      SO_RCVTIMEO_OLD == optname);
 		break;
 
 	case SO_SNDTIMEO_OLD:
 	case SO_SNDTIMEO_NEW:
-		lv = sock_get_timeout(sk->sk_sndtimeo, &v, SO_SNDTIMEO_OLD == optname);
+		lv = sock_get_timeout(READ_ONCE(sk->sk_sndtimeo), &v,
+				      SO_SNDTIMEO_OLD == optname);
 		break;
 
 	case SO_RCVLOWAT:
diff --git a/net/sched/em_meta.c b/net/sched/em_meta.c
index af85a73c4c5458ec9b018e5f43f420a3b2079917..6fdba069f6bfd306fa68fc2e68bdcaf0cf4d4e9e 100644
--- a/net/sched/em_meta.c
+++ b/net/sched/em_meta.c
@@ -568,7 +568,7 @@ META_COLLECTOR(int_sk_rcvtimeo)
 		*err = -1;
 		return;
 	}
-	dst->value = sk->sk_rcvtimeo / HZ;
+	dst->value = READ_ONCE(sk->sk_rcvtimeo) / HZ;
 }
 
 META_COLLECTOR(int_sk_sndtimeo)
@@ -579,7 +579,7 @@ META_COLLECTOR(int_sk_sndtimeo)
 		*err = -1;
 		return;
 	}
-	dst->value = sk->sk_sndtimeo / HZ;
+	dst->value = READ_ONCE(sk->sk_sndtimeo) / HZ;
 }
 
 META_COLLECTOR(int_sk_sendmsg_off)
-- 
2.41.0.585.gd2178a4bd4-goog


