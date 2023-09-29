Return-Path: <netdev+bounces-37133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B465C7B3BC0
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 23:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 1764AB20BF3
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 21:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A5D67275;
	Fri, 29 Sep 2023 21:04:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B6767272
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 21:04:49 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D301AE
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 14:04:48 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-69361132a60so306098b3a.1
        for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 14:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696021487; x=1696626287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CokKFnOXsWoIW3z5rGN0Wf39BhyBA5MQUiI1GNXUo2o=;
        b=b6B/NVgoxzdmNEhXVS7Om/yhSOZ7e2mmkdnZxedFI7fOT/bYU9eo4/1KA0K0tfDQIp
         /w6uHnChQTBgujXXdM07QVROOZgLcPZQ1oI71yqST7YxHMbeTgxMNF5KOEwXJ8MaXexz
         4006ov3E/xuojjfkoflhzG+Qy2YAxUuggPzsmZC6S2UAUVZqbAonCJI7Hemi2vmWZTCy
         K/G/3DIH3+GRGiEJFX7gXp3t+djTOUu9Z0Igf0nSBPZbkF8WTPeVMEiD90p43nrEdSrN
         Fo2LbIx9iI9qUCtPsZWz97eXC0Ui7FxbfvwVvK+iRN4ZRYJO893b6iswb7dBNnJSjEmr
         Zz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696021487; x=1696626287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CokKFnOXsWoIW3z5rGN0Wf39BhyBA5MQUiI1GNXUo2o=;
        b=wLMRdXb3OeN+cJlfnXCnmp8cfQMBD8PGOrl1yNBRz1rdWWwW9kTSgKI5haGsouZQYl
         0Y9hFXguz1CKpyhoB1wt8aZEaMgy6PBLzLiOMFst3rwh7cOqwNbPYR2W6ud2VgAmCbO+
         VViH2G/Ub8PDbjekUvHn7Nne2jzfzE3+6O+kWwAXmCgkhEH4A3InvfbQxZF8gZP8P3x0
         hNfJ0AJf3ytFwfrKwHo+/IgCCDL8a72vkpaWMcaP5TlQv/D6kAQ5OTv2mFdcfy4tVc/4
         2x9f2S3Z5OIzm9mOjoTjzDa1MOLjP37rGFE4DR2syz3TwjH0O61iz5mQwT+K2BTk8T27
         1uUw==
X-Gm-Message-State: AOJu0YwYa7IYAtWUS5HxKpB9DKQenFUzMVM3YNtrcTS7w+G/IJGeAPB0
	dKtWSwcGReCZbdfwA5NxGMo=
X-Google-Smtp-Source: AGHT+IFuy+/CwvN94rAjto/5hFBgP2ZzaX6DqhSDINAU2InVrtwc5HEepOH3yrNuKnBbVNc/zI3QTA==
X-Received: by 2002:a05:6a00:3015:b0:68e:25ff:613e with SMTP id ay21-20020a056a00301500b0068e25ff613emr5065592pfb.3.1696021487490;
        Fri, 29 Sep 2023 14:04:47 -0700 (PDT)
Received: from dmoe.c.googlers.com.com (25.11.145.34.bc.googleusercontent.com. [34.145.11.25])
        by smtp.gmail.com with ESMTPSA id g23-20020aa78757000000b00690cd49cee2sm15431120pfo.63.2023.09.29.14.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 14:04:46 -0700 (PDT)
From: David Morley <morleyd.kernel@gmail.com>
To: David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	David Morley <morleyd@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Yuchung Cheng <ycheng@google.com>
Subject: [PATCH net-next v2 1/2] tcp: record last received ipv6 flowlabel
Date: Fri, 29 Sep 2023 21:03:51 +0000
Message-ID: <20230929210352.3411495-2-morleyd.kernel@gmail.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20230929210352.3411495-1-morleyd.kernel@gmail.com>
References: <20230929210352.3411495-1-morleyd.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: David Morley <morleyd@google.com>

In order to better estimate whether a data packet has been
retransmitted or is the result of a TLP, we save the last received
ipv6 flowlabel.

To make space for this field we resize the "ato" field in
inet_connection_sock as the current value of TCP_DELACK_MAX can be
fully contained in 8 bits and add a compile_time_assert ensuring this
field is the required size.

v2: addressed kernel bot feedback about dccp_delack_timer()

Signed-off-by: David Morley <morleyd@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Tested-by: David Morley <morleyd@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/net/inet_connection_sock.h |  5 ++++-
 include/net/tcp.h                  |  2 ++
 net/dccp/timer.c                   |  4 ++--
 net/ipv4/tcp_input.c               | 15 +++++++++++++++
 net/ipv4/tcp_timer.c               |  2 +-
 5 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 5d2fcc137b88..d6d9d1c1985a 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -114,7 +114,10 @@ struct inet_connection_sock {
 		__u8		  quick;	 /* Scheduled number of quick acks	   */
 		__u8		  pingpong;	 /* The session is interactive		   */
 		__u8		  retry;	 /* Number of attempts			   */
-		__u32		  ato;		 /* Predicted tick of soft clock	   */
+		#define ATO_BITS 8
+		__u32		  ato:ATO_BITS,	 /* Predicted tick of soft clock	   */
+				  lrcv_flowlabel:20, /* last received ipv6 flowlabel	   */
+				  unused:4;
 		unsigned long	  timeout;	 /* Currently scheduled timeout		   */
 		__u32		  lrcvtime;	 /* timestamp of last received data packet */
 		__u16		  last_seg_size; /* Size of last incoming segment	   */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 91688d0dadcd..61fe664d109b 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -131,6 +131,8 @@ void tcp_time_wait(struct sock *sk, int state, int timeo);
 #define TCP_FIN_TIMEOUT_MAX (120 * HZ) /* max TCP_LINGER2 value (two minutes) */
 
 #define TCP_DELACK_MAX	((unsigned)(HZ/5))	/* maximal time to delay before sending an ACK */
+static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
+
 #if HZ >= 100
 #define TCP_DELACK_MIN	((unsigned)(HZ/25))	/* minimal time to delay before sending an ACK */
 #define TCP_ATO_MIN	((unsigned)(HZ/25))
diff --git a/net/dccp/timer.c b/net/dccp/timer.c
index b3255e87cc7e..a4cfb47b60e5 100644
--- a/net/dccp/timer.c
+++ b/net/dccp/timer.c
@@ -196,8 +196,8 @@ static void dccp_delack_timer(struct timer_list *t)
 	if (inet_csk_ack_scheduled(sk)) {
 		if (!inet_csk_in_pingpong_mode(sk)) {
 			/* Delayed ACK missed: inflate ATO. */
-			icsk->icsk_ack.ato = min(icsk->icsk_ack.ato << 1,
-						 icsk->icsk_rto);
+			icsk->icsk_ack.ato = min_t(u32, icsk->icsk_ack.ato << 1,
+						   icsk->icsk_rto);
 		} else {
 			/* Delayed ACK missed: leave pingpong mode and
 			 * deflate ATO.
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 584825ddd0a0..abe7494361c0 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -765,6 +765,16 @@ void tcp_rcv_space_adjust(struct sock *sk)
 	tp->rcvq_space.time = tp->tcp_mstamp;
 }
 
+static void tcp_save_lrcv_flowlabel(struct sock *sk, const struct sk_buff *skb)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	struct inet_connection_sock *icsk = inet_csk(sk);
+
+	if (skb->protocol == htons(ETH_P_IPV6))
+		icsk->icsk_ack.lrcv_flowlabel = ntohl(ip6_flowlabel(ipv6_hdr(skb)));
+#endif
+}
+
 /* There is something which you must keep in mind when you analyze the
  * behavior of the tp->ato delayed ack timeout interval.  When a
  * connection starts up, we want to ack as quickly as possible.  The
@@ -813,6 +823,7 @@ static void tcp_event_data_recv(struct sock *sk, struct sk_buff *skb)
 		}
 	}
 	icsk->icsk_ack.lrcvtime = now;
+	tcp_save_lrcv_flowlabel(sk, skb);
 
 	tcp_ecn_check_ce(sk, skb);
 
@@ -4506,6 +4517,9 @@ static void tcp_rcv_spurious_retrans(struct sock *sk, const struct sk_buff *skb)
 	if (TCP_SKB_CB(skb)->seq == tcp_sk(sk)->duplicate_sack[0].start_seq &&
 	    sk_rethink_txhash(sk))
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPDUPLICATEDATAREHASH);
+
+	/* Save last flowlabel after a spurious retrans. */
+	tcp_save_lrcv_flowlabel(sk, skb);
 }
 
 static void tcp_send_dupack(struct sock *sk, const struct sk_buff *skb)
@@ -4822,6 +4836,7 @@ static void tcp_data_queue_ofo(struct sock *sk, struct sk_buff *skb)
 	u32 seq, end_seq;
 	bool fragstolen;
 
+	tcp_save_lrcv_flowlabel(sk, skb);
 	tcp_ecn_check_ce(sk, skb);
 
 	if (unlikely(tcp_try_rmem_schedule(sk, skb, skb->truesize))) {
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 3f61c6a70a1f..0862b73dd3b5 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -322,7 +322,7 @@ void tcp_delack_timer_handler(struct sock *sk)
 	if (inet_csk_ack_scheduled(sk)) {
 		if (!inet_csk_in_pingpong_mode(sk)) {
 			/* Delayed ACK missed: inflate ATO. */
-			icsk->icsk_ack.ato = min(icsk->icsk_ack.ato << 1, icsk->icsk_rto);
+			icsk->icsk_ack.ato = min_t(u32, icsk->icsk_ack.ato << 1, icsk->icsk_rto);
 		} else {
 			/* Delayed ACK missed: leave pingpong mode and
 			 * deflate ATO.
-- 
2.42.0.582.g8ccd20d70d-goog


