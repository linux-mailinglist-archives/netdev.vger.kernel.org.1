Return-Path: <netdev+bounces-23643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7695376CE2A
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 420D21C210BF
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 13:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752CA7480;
	Wed,  2 Aug 2023 13:15:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694BA79D9
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 13:15:11 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2AD26AF
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 06:15:08 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-cf4cb742715so6799025276.2
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 06:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690982107; x=1691586907;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l0vHCgRpUBo/F+/BDWKMEw0HS3H02SomExXf56aFSm4=;
        b=Zs08ByXbaIj1GMreb3Rx9pWjL25xU9+XsaQIPIAZwrKd9ful5UfAJdx5/kp2NT98yH
         vaJURuUSnIso/KoH8xRRds7KJzGjBIqv+rYGHc/D9XpoboDRBzjK2DDOWUWqHFqFspKx
         m2IpSdSfcVXySOljGQ6WNSSj8pp4TZNHTmFpCRrnZnRfott+4nt2bTVBQ/G/jaoIMxam
         dNtjdVXAFj6x6BZPOd1cH/7t1znZBLQU1HQnsTGqZjRsqaYOaqp/e923X//u6dhRq7QS
         D8dsJa243cZu9F3Jy0O0fP6JYJfDIloxi7iN560sP2NM8zvzSEndos81M/CQmE2IPX5h
         NJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690982107; x=1691586907;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l0vHCgRpUBo/F+/BDWKMEw0HS3H02SomExXf56aFSm4=;
        b=D1zTyvY4j7grfSkJLLZXgL6+BgjdTuL8YaV3DArdCu320Dy9orh72CAa/NdEUciJAB
         0sQQaZlGemc8NvlnSOwWy2CMOjyPWL1kyKgp/dP/hp4Jq1t28KaeqNDJmW8DhheD9tB4
         kj3/zSVyoO7WuZFj+niaKdi8Yf0y+MLlTyJY/hDyIr+72/D/08SCWhDEvtmehMg4tars
         upQTcu65Zp8HvI63+Oc9+jwecw4Kl45cJ0uaVLdKa0elUrjXTexqtz4twVa3COplVcw1
         yn7/f5aooX05MxlwcD2kT95i+LTYOB7gX7S7eoIVVA0ctE/DJR5beBNXXT1rTuBlVdO6
         wAzA==
X-Gm-Message-State: ABy/qLYdTT5Qo8wjwcNZ/nod5HrMoQchapiM7Um1AMydTl7oYx9INuYH
	IpTMGLUJEQX8LmWBGBUQCuLKINYv9qMQFQ==
X-Google-Smtp-Source: APBJJlH7tOElTJyt7sNYx5CYBjQZc/gmdYkQtY6e4VsOE7NjbXaii0VHpvi9RuTvZO7XmZ7tljQluo55flSwHw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:7341:0:b0:d0b:ca14:33fd with SMTP id
 o62-20020a257341000000b00d0bca1433fdmr102924ybc.8.1690982107828; Wed, 02 Aug
 2023 06:15:07 -0700 (PDT)
Date: Wed,  2 Aug 2023 13:14:57 +0000
In-Reply-To: <20230802131500.1478140-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230802131500.1478140-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230802131500.1478140-4-edumazet@google.com>
Subject: [PATCH net 3/6] tcp_metrics: annotate data-races around tm->tcpm_lock
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

tm->tcpm_lock can be read or written locklessly.

Add needed READ_ONCE()/WRITE_ONCE() to document this.

Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local cache.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_metrics.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index 83861658879638149d2746290a285a4f75fc3117..131fa300496914f78c682182f0db480ceb71b6a0 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -59,7 +59,8 @@ static inline struct net *tm_net(struct tcp_metrics_block *tm)
 static bool tcp_metric_locked(struct tcp_metrics_block *tm,
 			      enum tcp_metric_index idx)
 {
-	return tm->tcpm_lock & (1 << idx);
+	/* Paired with WRITE_ONCE() in tcpm_suck_dst() */
+	return READ_ONCE(tm->tcpm_lock) & (1 << idx);
 }
 
 static u32 tcp_metric_get(struct tcp_metrics_block *tm,
@@ -110,7 +111,8 @@ static void tcpm_suck_dst(struct tcp_metrics_block *tm,
 		val |= 1 << TCP_METRIC_CWND;
 	if (dst_metric_locked(dst, RTAX_REORDERING))
 		val |= 1 << TCP_METRIC_REORDERING;
-	tm->tcpm_lock = val;
+	/* Paired with READ_ONCE() in tcp_metric_locked() */
+	WRITE_ONCE(tm->tcpm_lock, val);
 
 	msval = dst_metric_raw(dst, RTAX_RTT);
 	tm->tcpm_vals[TCP_METRIC_RTT] = msval * USEC_PER_MSEC;
-- 
2.41.0.640.ga95def55d0-goog


