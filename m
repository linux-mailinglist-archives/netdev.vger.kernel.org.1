Return-Path: <netdev+bounces-36610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E8D7B0BEC
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 20:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8F7B1283E86
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 18:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990E04CFAE;
	Wed, 27 Sep 2023 18:28:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137A1262AD
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 18:28:05 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBDCDD
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 11:28:04 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a707bc2397so1770706b6e.0
        for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 11:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695839283; x=1696444083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Z8SxYQHK3aEziaESVM6XkdTJOxrhF2ghym6v8e8Xs0=;
        b=jjUdOdPGIeHshL1htdiTvPrCGyvvEif4weU4qWBv9ySNVmqMg+4SFJ0ajoTvcgLagR
         BGWaOanIWJlodmkHB9wIVN3Qd2JncivaPBP4rXuav1kqpTBqZmjO3FuT1jqlh10fh6Z2
         VbskzNnwCLZv/1KKw6g0t+tGj1CAMTWVQRiZVNubGsiyP8dugUTFwqzHPVIwjDCCb21Z
         93juKMhH72ykYa0RoF443r9vNLJ4Zcpvl5ryfQsn5oG8AIbVAisD3fTwsQnwv/zrAoy7
         L/Fe0X0Di6eIgBAvLJH8x+ZuY7AC3P5xct4p8wz5Xnm3UPUVQyeo93sbBlikAgu1TRMJ
         ZjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695839283; x=1696444083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Z8SxYQHK3aEziaESVM6XkdTJOxrhF2ghym6v8e8Xs0=;
        b=H3XZj9uPDeKiFlrsMyMXtxcgBelCZ5PFeqCMYrvDcaTEEXlnhwXRWZ/KDYYNYYB2Uh
         dcVl9mCbwvdwI7j9W/qLXRIvHtJxsbnARsSON9TghJOE+xNjz8pIY76TBWx7JNNiAiZU
         zIMDdk63huI0r8Vs+K/3KezDL9SD5lCvtKyOBZkmUNSLNTUE4qNmKZTmUHnpLADxnVaY
         U+kxdrbJm5FZMc3MieICSlTfabmW3qjfy6RvYI3faB9q0jMojubmGXz6NS/4nqreQo//
         dF+ji6T91koWZClSrSbFK61MEQEAselvsdhfJF9bIrYo9uCZYF/cE+XOFI1/wTM93okq
         ZDoQ==
X-Gm-Message-State: AOJu0YxKd71nccufiabBUnbP8est+NqijZ0r1KOJnqOGvMs+b2ixL8iK
	E0Foag8BnuVURyyt8Qn2C+w6lvRcnS0=
X-Google-Smtp-Source: AGHT+IG+goqeLjr4xTZTmKHKOrhWXYoUDY9nrvZJJf84CTbNOqUyjvvMj4Qd2mARS3YAM3LgXah0xA==
X-Received: by 2002:a05:6808:3a13:b0:3ae:df5:6d0d with SMTP id gr19-20020a0568083a1300b003ae0df56d0dmr3501656oib.2.1695839283308;
        Wed, 27 Sep 2023 11:28:03 -0700 (PDT)
Received: from dmoe.c.googlers.com.com (25.11.145.34.bc.googleusercontent.com. [34.145.11.25])
        by smtp.gmail.com with ESMTPSA id o9-20020a639a09000000b0056c2f1a2f6bsm11658599pge.41.2023.09.27.11.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 11:28:02 -0700 (PDT)
From: David Morley <morleyd.kernel@gmail.com>
To: David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	David Morley <morleyd@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Yuchung Cheng <ycheng@google.com>
Subject: [PATCH net-next 1/2] tcp: record last received ipv6 flowlabel
Date: Wed, 27 Sep 2023 18:27:45 +0000
Message-ID: <20230927182747.2005960-1-morleyd.kernel@gmail.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
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

Signed-off-by: David Morley <morleyd@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Tested-by: David Morley <morleyd@google.com>
---
 include/net/inet_connection_sock.h |  5 ++++-
 include/net/tcp.h                  |  2 ++
 net/ipv4/tcp_input.c               | 15 +++++++++++++++
 net/ipv4/tcp_timer.c               |  2 +-
 4 files changed, 22 insertions(+), 2 deletions(-)

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
index 91688d0dadcd..8a3720c7d082 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -131,6 +131,8 @@ void tcp_time_wait(struct sock *sk, int state, int timeo);
 #define TCP_FIN_TIMEOUT_MAX (120 * HZ) /* max TCP_LINGER2 value (two minutes) */
 
 #define TCP_DELACK_MAX	((unsigned)(HZ/5))	/* maximal time to delay before sending an ACK */
+static_assert(1<<ATO_BITS > TCP_DELACK_MAX);
+
 #if HZ >= 100
 #define TCP_DELACK_MIN	((unsigned)(HZ/25))	/* minimal time to delay before sending an ACK */
 #define TCP_ATO_MIN	((unsigned)(HZ/25))
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


