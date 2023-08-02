Return-Path: <netdev+bounces-23642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DB476CE28
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C44C28193F
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 13:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9658E79C0;
	Wed,  2 Aug 2023 13:15:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF3E7475
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 13:15:08 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E392722
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 06:15:06 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d1ef70d6a02so7268769276.0
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 06:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690982106; x=1691586906;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1JCIVgbGVC1vIPKcKvazfuU4hxao5y7U3s1kkl2kXNo=;
        b=JnTRKTDTJauvdS+d2gJNJts7Rb3lhE1oErk5DJwkc7DCUfYJPpF2fXxt4q+Ypc/4pV
         rUTyfdjSAU+pxSIIcj4y36Ep318SDuiaQsvVuykz0d5P2aB02UB7S3TpE9L/x1fiHdGD
         unC7zo8tjvSN8/aAwtQ+eS8nP4mmKqxk5owV4b1yT3FIuLmyD502R0kqF0sqGJIjcUsz
         5iSGrbIq3sAGcuzMxpcrK8Z2o4BwX4e3/WgcEaaLOiIOfDPJc14v4IzVz0CKi6t/1mUo
         PgN+QGMgLho91oogpX5iNLKSlvUDY9syRP9dpzT7wNl/DxLVOndHXp7DkGgWtIDmZhYC
         6TiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690982106; x=1691586906;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1JCIVgbGVC1vIPKcKvazfuU4hxao5y7U3s1kkl2kXNo=;
        b=TULtzlhIRVdMqybvE6lCMjNlcDQ7WMCslLibWCvwR493atS9YcLzyUcvdVBCepTWjW
         khF8XCBhERD5mhhdskMhQ1bMqh942ODh6UMaIxVOJsM8LJHcHmXVb8+SigH1BeB9tJgz
         XKzWX5rBvKul/ONzrIGsslNbtoYr8nrVIRWTnmeC86UCIjVTHCcBZeAb6fsPnM4/WxSE
         LQADcWNqlW5MSfYlydegrcjvr7gE3YZ25175476+b4ZtIlP8G8eWHxwv1/DP+DIxMiAa
         UJmZtj/qrs3x7FB4PbayE/Q3Jx2HwOkBtbrbbrJRMld4ZeoED8xeZ2SO+oe7VY8gpCIA
         1r7g==
X-Gm-Message-State: ABy/qLbYdYEopE1rb0Y7lAK1xwggbzH+tibPtN7HWCOauUWr8Wgv5C69
	WCklbbnDVyhJS0PnCi/3h1f86VTcV9LGrA==
X-Google-Smtp-Source: APBJJlFwiEore1PPqgvm1xPzaQn+vHHnpiPQaChjJlHVRYbDNeOK/IjYr5Z+yJAjlsFqvyxhOuztEVWAYVpVAQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:aa69:0:b0:d05:98ef:c16b with SMTP id
 s96-20020a25aa69000000b00d0598efc16bmr111968ybi.5.1690982106115; Wed, 02 Aug
 2023 06:15:06 -0700 (PDT)
Date: Wed,  2 Aug 2023 13:14:56 +0000
In-Reply-To: <20230802131500.1478140-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230802131500.1478140-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230802131500.1478140-3-edumazet@google.com>
Subject: [PATCH net 2/6] tcp_metrics: annotate data-races around tm->tcpm_stamp
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

tm->tcpm_stamp can be read or written locklessly.

Add needed READ_ONCE()/WRITE_ONCE() to document this.

Also constify tcpm_check_stamp() dst argument.

Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local cache.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_metrics.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index c4daf0aa2d4d9695e128b67df571d91d647a254d..83861658879638149d2746290a285a4f75fc3117 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -97,7 +97,7 @@ static void tcpm_suck_dst(struct tcp_metrics_block *tm,
 	u32 msval;
 	u32 val;
 
-	tm->tcpm_stamp = jiffies;
+	WRITE_ONCE(tm->tcpm_stamp, jiffies);
 
 	val = 0;
 	if (dst_metric_locked(dst, RTAX_RTT))
@@ -131,9 +131,15 @@ static void tcpm_suck_dst(struct tcp_metrics_block *tm,
 
 #define TCP_METRICS_TIMEOUT		(60 * 60 * HZ)
 
-static void tcpm_check_stamp(struct tcp_metrics_block *tm, struct dst_entry *dst)
+static void tcpm_check_stamp(struct tcp_metrics_block *tm,
+			     const struct dst_entry *dst)
 {
-	if (tm && unlikely(time_after(jiffies, tm->tcpm_stamp + TCP_METRICS_TIMEOUT)))
+	unsigned long limit;
+
+	if (!tm)
+		return;
+	limit = READ_ONCE(tm->tcpm_stamp) + TCP_METRICS_TIMEOUT;
+	if (unlikely(time_after(jiffies, limit)))
 		tcpm_suck_dst(tm, dst, false);
 }
 
@@ -174,7 +180,8 @@ static struct tcp_metrics_block *tcpm_new(struct dst_entry *dst,
 		oldest = deref_locked(tcp_metrics_hash[hash].chain);
 		for (tm = deref_locked(oldest->tcpm_next); tm;
 		     tm = deref_locked(tm->tcpm_next)) {
-			if (time_before(tm->tcpm_stamp, oldest->tcpm_stamp))
+			if (time_before(READ_ONCE(tm->tcpm_stamp),
+					READ_ONCE(oldest->tcpm_stamp)))
 				oldest = tm;
 		}
 		tm = oldest;
@@ -434,7 +441,7 @@ void tcp_update_metrics(struct sock *sk)
 					       tp->reordering);
 		}
 	}
-	tm->tcpm_stamp = jiffies;
+	WRITE_ONCE(tm->tcpm_stamp, jiffies);
 out_unlock:
 	rcu_read_unlock();
 }
@@ -647,7 +654,7 @@ static int tcp_metrics_fill_info(struct sk_buff *msg,
 	}
 
 	if (nla_put_msecs(msg, TCP_METRICS_ATTR_AGE,
-			  jiffies - tm->tcpm_stamp,
+			  jiffies - READ_ONCE(tm->tcpm_stamp),
 			  TCP_METRICS_ATTR_PAD) < 0)
 		goto nla_put_failure;
 
-- 
2.41.0.640.ga95def55d0-goog


