Return-Path: <netdev+bounces-23644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9483876CE2F
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23728281AFE
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 13:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3AE79F8;
	Wed,  2 Aug 2023 13:15:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928B1746F
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 13:15:12 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A022706
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 06:15:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d390abf3319so1530747276.0
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 06:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690982109; x=1691586909;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+X5rd7LwvmiK9lV4qVVWtUJbpvyDCv/hDLGi2uHPzLA=;
        b=f5gfZ9+usb8N221ubEIVPBxJ53H0FpL354cdJMgIsTTYM65dJZBsqiGn9eaX0sfzhh
         QjNZHa7jcVzDbm6eS5asSPCWu4nPp0ns+FzKL3WYWxhlB3Amp6sJfk66jyGZNNuGgjzh
         veP2bnGO2p+OFA1YC7AhR+9S3044qg5SDRE+a5R4PYyRwuQXZMi9VdZJLccACAhstxJN
         3KLFNCUSIumZitVrvF2oiLYXBN9mJIHdSs5vTJaHW6v8s2a6l2LGnkyX8fMk0w6sdmrm
         yBE/t/Vb6hXK9cA6jlJI1xD6A+393D55PMhEJnBjAMYBMdrfl+8P3onWZcNhtJj7ZgId
         ak5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690982109; x=1691586909;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+X5rd7LwvmiK9lV4qVVWtUJbpvyDCv/hDLGi2uHPzLA=;
        b=hoo43Ai5edaVpfpAnDh3N8Wb1Q7RvWMdUxekUQgQp30jiVH0r/c6RA1YKwx3RAPdJ3
         GctgKaDMaZekhGAV2LRfxRJbs7ZKtx2jKZQkJ0MkHC1GINzB9JhvOf3MuwgQXgmIESJi
         fWRSM/JireyzPneSXpmz966o/M9m+r3ozpy+pYm5XoYRq+6Zmsg/t3XkmnhKZbv70A+7
         iPA5EbZaIcMJggMvGMlcvImXiUmzkFTSIuD2NiasVRQxY2vo5tblXmz4a3rQIYxEulVZ
         l7q/d6XwUdNE82wBx5hhpO/Q9JT+Q2mRGJkXv7elFWD2nvMp6hOHE1J5cCigCJppCiTV
         zufQ==
X-Gm-Message-State: ABy/qLaUI9ff0uRAqIMERVOnC5d2gyJ5wAHIH69AOUplYdh1pBGl3yfd
	+wmYwNu8SDcmQ2u5/r2mMVHbSBiwJj3z9A==
X-Google-Smtp-Source: APBJJlHasJzfvvkQc48oM4/vD8A2YSDxnt946dxrTbWDQFpfSOrmVAnYRmAHbF64ZcD/JOQL2o1albxsYxrvZQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1611:b0:d0d:587c:e031 with SMTP
 id bw17-20020a056902161100b00d0d587ce031mr124097ybb.9.1690982109358; Wed, 02
 Aug 2023 06:15:09 -0700 (PDT)
Date: Wed,  2 Aug 2023 13:14:58 +0000
In-Reply-To: <20230802131500.1478140-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230802131500.1478140-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230802131500.1478140-5-edumazet@google.com>
Subject: [PATCH net 4/6] tcp_metrics: annotate data-races around tm->tcpm_vals[]
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

tm->tcpm_vals[] values can be read or written locklessly.

Add needed READ_ONCE()/WRITE_ONCE() to document this,
and force use of tcp_metric_get() and tcp_metric_set()

Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local cache.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_metrics.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index 131fa300496914f78c682182f0db480ceb71b6a0..fd4ab7a51cef210005146dfbc3235a2db717a44f 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -63,17 +63,19 @@ static bool tcp_metric_locked(struct tcp_metrics_block *tm,
 	return READ_ONCE(tm->tcpm_lock) & (1 << idx);
 }
 
-static u32 tcp_metric_get(struct tcp_metrics_block *tm,
+static u32 tcp_metric_get(const struct tcp_metrics_block *tm,
 			  enum tcp_metric_index idx)
 {
-	return tm->tcpm_vals[idx];
+	/* Paired with WRITE_ONCE() in tcp_metric_set() */
+	return READ_ONCE(tm->tcpm_vals[idx]);
 }
 
 static void tcp_metric_set(struct tcp_metrics_block *tm,
 			   enum tcp_metric_index idx,
 			   u32 val)
 {
-	tm->tcpm_vals[idx] = val;
+	/* Paired with READ_ONCE() in tcp_metric_get() */
+	WRITE_ONCE(tm->tcpm_vals[idx], val);
 }
 
 static bool addr_same(const struct inetpeer_addr *a,
@@ -115,13 +117,16 @@ static void tcpm_suck_dst(struct tcp_metrics_block *tm,
 	WRITE_ONCE(tm->tcpm_lock, val);
 
 	msval = dst_metric_raw(dst, RTAX_RTT);
-	tm->tcpm_vals[TCP_METRIC_RTT] = msval * USEC_PER_MSEC;
+	tcp_metric_set(tm, TCP_METRIC_RTT, msval * USEC_PER_MSEC);
 
 	msval = dst_metric_raw(dst, RTAX_RTTVAR);
-	tm->tcpm_vals[TCP_METRIC_RTTVAR] = msval * USEC_PER_MSEC;
-	tm->tcpm_vals[TCP_METRIC_SSTHRESH] = dst_metric_raw(dst, RTAX_SSTHRESH);
-	tm->tcpm_vals[TCP_METRIC_CWND] = dst_metric_raw(dst, RTAX_CWND);
-	tm->tcpm_vals[TCP_METRIC_REORDERING] = dst_metric_raw(dst, RTAX_REORDERING);
+	tcp_metric_set(tm, TCP_METRIC_RTTVAR, msval * USEC_PER_MSEC);
+	tcp_metric_set(tm, TCP_METRIC_SSTHRESH,
+		       dst_metric_raw(dst, RTAX_SSTHRESH));
+	tcp_metric_set(tm, TCP_METRIC_CWND,
+		       dst_metric_raw(dst, RTAX_CWND));
+	tcp_metric_set(tm, TCP_METRIC_REORDERING,
+		       dst_metric_raw(dst, RTAX_REORDERING));
 	if (fastopen_clear) {
 		tm->tcpm_fastopen.mss = 0;
 		tm->tcpm_fastopen.syn_loss = 0;
@@ -667,7 +672,7 @@ static int tcp_metrics_fill_info(struct sk_buff *msg,
 		if (!nest)
 			goto nla_put_failure;
 		for (i = 0; i < TCP_METRIC_MAX_KERNEL + 1; i++) {
-			u32 val = tm->tcpm_vals[i];
+			u32 val = tcp_metric_get(tm, i);
 
 			if (!val)
 				continue;
-- 
2.41.0.640.ga95def55d0-goog


