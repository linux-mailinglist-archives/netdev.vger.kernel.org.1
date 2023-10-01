Return-Path: <netdev+bounces-37283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B44F67B4853
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 17:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id DF7CF28259C
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 15:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B4A182C8;
	Sun,  1 Oct 2023 15:12:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A02618049
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 15:12:46 +0000 (UTC)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EF6DA
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 08:12:44 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-775751c35d4so391517685a.0
        for <netdev@vger.kernel.org>; Sun, 01 Oct 2023 08:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696173164; x=1696777964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCeAXUJnei9DWaPjcolxH4sM2ArdFIKh6/vloyHm5uM=;
        b=Zrxk1WuQCb9ESb5ylu7Czt0ksRyiHtq1xnLI2f34NXKavy0t36qlhLLRgemSISgTWU
         0jny7iG+uYzTaBEB+FGPWgSgMgaMuuQuGLn+yaXKBkQNE9/JBT0qDG1JP2WN4samoxTz
         bG6oZ7+oXmZ+lb9wXYYhG4X8WzgP2/u/waxis1twQAj0IzaBqOIHmH7ZwsVIob/KRRy8
         9xldaVWk+PkNpz+JsQ3HWvBy4mpYirtTle09/uM/ngcbTekxCM9QhQdl0pDNJ2bj0/tX
         1bSXrcInqhimLICfZrCA907JPiRIfcUjRYpweW2LCpAnLpqPiRwaNOMczkCB8BVmKSpW
         IDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696173164; x=1696777964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCeAXUJnei9DWaPjcolxH4sM2ArdFIKh6/vloyHm5uM=;
        b=YFgaF+gRi+RZsVc6q9xm5MpuhCV9/y76wl7My5zNOl7Jlc9zHcfO+H0JeWIqAgJGOy
         /QO/WhnoKck5Km7lbgco6eifVUgwgUfpHJDyqUS9ZMNkWAD50jzqrYRg/5UGUy9bZchD
         NhLBu0wQLpFMa16UEaiF8jz0V6egYuig9kiaE6t7/pXhYScKXbmqjcJBbZ8O4wDJplyJ
         Yg9l3j8Ef7hZ3Dn7Izuv8fPo13zo+ix6kTOQm+pESR1ytszRYQP1cIN22EEpQfP+wzSt
         KXrM419lTUZqMlsR2wOxGrbjLMdxs51nk8XHBONZklDCWympsr3hel00bF5DqjX15T7v
         Pgow==
X-Gm-Message-State: AOJu0Yy8+/PNF/eicI4ynJhZbAL1bti4Ztem2AVBfswIoRTvWN2i0Do4
	AbqNOW1FFv+j/PhzS45pFpOwPDiT9cY=
X-Google-Smtp-Source: AGHT+IGCqH1AyWWq7plFxP3IFzGK3m9Z9BXwB5VtOJ97z3q/ReW93XVMMGPFY50s4JoF216osI4E4A==
X-Received: by 2002:a05:620a:2988:b0:76f:f0b:a1b8 with SMTP id r8-20020a05620a298800b0076f0f0ba1b8mr13001084qkp.25.1696173163680;
        Sun, 01 Oct 2023 08:12:43 -0700 (PDT)
Received: from soy.nyc.corp.google.com ([2620:0:1003:416:c6ad:8d4d:efac:c523])
        by smtp.gmail.com with ESMTPSA id n18-20020ae9c312000000b0076f13783743sm1433193qkg.92.2023.10.01.08.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 08:12:43 -0700 (PDT)
From: Neal Cardwell <ncardwell.sw@gmail.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,
	Neal Cardwell <ncardwell@google.com>,
	Yuchung Cheng <ycheng@google.com>,
	Xin Guo <guoxin0309@gmail.com>
Subject: [PATCH v2 net 2/2] tcp: fix delayed ACKs for MSS boundary condition
Date: Sun,  1 Oct 2023 11:12:39 -0400
Message-ID: <20231001151239.1866845-2-ncardwell.sw@gmail.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231001151239.1866845-1-ncardwell.sw@gmail.com>
References: <20231001151239.1866845-1-ncardwell.sw@gmail.com>
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

From: Neal Cardwell <ncardwell@google.com>

This commit fixes poor delayed ACK behavior that can cause poor TCP
latency in a particular boundary condition: when an application makes
a TCP socket write that is an exact multiple of the MSS size.

The problem is that there is painful boundary discontinuity in the
current delayed ACK behavior. With the current delayed ACK behavior,
we have:

(1) If an app reads data when > 1*MSS is unacknowledged, then
    tcp_cleanup_rbuf() ACKs immediately because of:

     tp->rcv_nxt - tp->rcv_wup > icsk->icsk_ack.rcv_mss ||

(2) If an app reads all received data, and the packets were < 1*MSS,
    and either (a) the app is not ping-pong or (b) we received two
    packets < 1*MSS, then tcp_cleanup_rbuf() ACKs immediately beecause
    of:

     ((icsk->icsk_ack.pending & ICSK_ACK_PUSHED2) ||
      ((icsk->icsk_ack.pending & ICSK_ACK_PUSHED) &&
       !inet_csk_in_pingpong_mode(sk))) &&

(3) *However*: if an app reads exactly 1*MSS of data,
    tcp_cleanup_rbuf() does not send an immediate ACK. This is true
    even if the app is not ping-pong and the 1*MSS of data had the PSH
    bit set, suggesting the sending application completed an
    application write.

Thus if the app is not ping-pong, we have this painful case where
>1*MSS gets an immediate ACK, and <1*MSS gets an immediate ACK, but a
write whose last skb is an exact multiple of 1*MSS can get a 40ms
delayed ACK. This means that any app that transfers data in one
direction and takes care to align write size or packet size with MSS
can suffer this problem. With receive zero copy making 4KB MSS values
more common, it is becoming more common to have application writes
naturally align with MSS, and more applications are likely to
encounter this delayed ACK problem.

The fix in this commit is to refine the delayed ACK heuristics with a
simple check: immediately ACK a received 1*MSS skb with PSH bit set if
the app reads all data. Why? If an skb has a len of exactly 1*MSS and
has the PSH bit set then it is likely the end of an application
write. So more data may not be arriving soon, and yet the data sender
may be waiting for an ACK if cwnd-bound or using TX zero copy. Thus we
set ICSK_ACK_PUSHED in this case so that tcp_cleanup_rbuf() will send
an ACK immediately if the app reads all of the data and is not
ping-pong. Note that this logic is also executed for the case where
len > MSS, but in that case this logic does not matter (and does not
hurt) because tcp_cleanup_rbuf() will always ACK immediately if the
app reads data and there is more than an MSS of unACKed data.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Reviewed-by: Yuchung Cheng <ycheng@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Cc: Xin Guo <guoxin0309@gmail.com>
---
v2: Fix the details of the description in the commit message of the
  current tcp_cleanup_rbuf() logic, thanks to Xin Guo <guoxin0309@gmail.com>.
 net/ipv4/tcp_input.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 06fe1cf645d5a..8afb0950a6979 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -253,6 +253,19 @@ static void tcp_measure_rcv_mss(struct sock *sk, const struct sk_buff *skb)
 		if (unlikely(len > icsk->icsk_ack.rcv_mss +
 				   MAX_TCP_OPTION_SPACE))
 			tcp_gro_dev_warn(sk, skb, len);
+		/* If the skb has a len of exactly 1*MSS and has the PSH bit
+		 * set then it is likely the end of an application write. So
+		 * more data may not be arriving soon, and yet the data sender
+		 * may be waiting for an ACK if cwnd-bound or using TX zero
+		 * copy. So we set ICSK_ACK_PUSHED here so that
+		 * tcp_cleanup_rbuf() will send an ACK immediately if the app
+		 * reads all of the data and is not ping-pong. If len > MSS
+		 * then this logic does not matter (and does not hurt) because
+		 * tcp_cleanup_rbuf() will always ACK immediately if the app
+		 * reads data and there is more than an MSS of unACKed data.
+		 */
+		if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_PSH)
+			icsk->icsk_ack.pending |= ICSK_ACK_PUSHED;
 	} else {
 		/* Otherwise, we make more careful check taking into account,
 		 * that SACKs block is variable.
-- 
2.42.0.582.g8ccd20d70d-goog


