Return-Path: <netdev+bounces-41099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A99CC7C9A6C
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 19:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6EC81C208F8
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 17:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C8AE57C;
	Sun, 15 Oct 2023 17:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7Biw7jZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D970C79CB
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 17:47:16 +0000 (UTC)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782FFB7
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 10:47:15 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-41819a68143so27386931cf.3
        for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 10:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697392034; x=1697996834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MnRPBLG8Gl9FqAIR4CqqPLpgWr0IqIpDqTf+JYgTtXM=;
        b=I7Biw7jZuXX+jbqwF1tg8pAP9d4096anix4aLA6NsHrflJT4w0iBKAprXBkTVOZ2TS
         FXhz+dxgq7wDiLvN7xKMIA3D3lhfF+fCnYxvngzNuUnyGPMYweV64/3zaGCAQugwshmg
         YNpG24IT2obXiUpjPERwqBwy/5iP0CBJAzOt+GnEdNtrPdX2/VGHcSmIMophOjrClzEI
         /HuYYiWIRvDaeLg0tfetWO4q9ClXmyMJJjTYGOeaHACG/x3hNTQty0t4u6SRn/jCuE89
         YUZhpy9Js3YlWQSns5Bx0FPwGZ9p1IPWMKDfwuRWlPFdcr1kei4WPgP1HtX3lXNeYg6q
         qCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697392034; x=1697996834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MnRPBLG8Gl9FqAIR4CqqPLpgWr0IqIpDqTf+JYgTtXM=;
        b=Jzg7HOdOJ/YOn463sn9d2mQRcRM0tsKXtfbgW6eUuPjZhew7QK5nx0i7Drw/JFf8jO
         lE/3QCWcuLNz0FJ/xPv8HVqGb0Pbn3ege0UYGphkXr5ORv6NMdlxNz5bJQcWnQs3n0Bw
         EemokG4oMYOwrmtl5drFB2Nsc/PUeln7y8nBAcG0i0NGGyO3TFw6XCd8vLJ8RFyr2gYM
         ulD68HnjUcu9Ml3frwYuzIbrfo65DwDHx19TgBw0zsKmSeGOH0akWFFI92PlZsRy8uUc
         sCnsKXvdBN+I+xupJw0nhWkJ987dNMzfWIW7Atc9Ijn+gygcwy8Wv6PLnZ59J3l4UK7q
         /Bag==
X-Gm-Message-State: AOJu0Yx0TSgaU+t4cvNBt7nR0TQaxlN5yzTiyqq9QJexOC+wkiV45YjU
	Mo0bdiKqK4NeuFV3DphVWbI=
X-Google-Smtp-Source: AGHT+IHsgu2vmm1porFj9zeh5kpBGr7MsgXtQ17lvCEcadfy9v/fXIDN/YtchzVygE+z7viBxumpqg==
X-Received: by 2002:a05:622a:42:b0:418:1071:7303 with SMTP id y2-20020a05622a004200b0041810717303mr40855833qtw.31.1697392034513;
        Sun, 15 Oct 2023 10:47:14 -0700 (PDT)
Received: from soy.nyc.corp.google.com ([2620:0:1003:416:43d4:d5e0:dc61:6cc2])
        by smtp.gmail.com with ESMTPSA id z22-20020ac87116000000b0041b016faf7esm2397669qto.58.2023.10.15.10.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 10:47:14 -0700 (PDT)
From: Neal Cardwell <ncardwell.sw@gmail.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,
	Neal Cardwell <ncardwell@google.com>,
	Yuchung Cheng <ycheng@google.com>
Subject: [PATCH net] tcp: fix excessive TLP and RACK timeouts from HZ rounding
Date: Sun, 15 Oct 2023 13:47:00 -0400
Message-ID: <20231015174700.2206872-1-ncardwell.sw@gmail.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
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

We discovered from packet traces of slow loss recovery on kernels with
the default HZ=250 setting (and min_rtt < 1ms) that after reordering,
when receiving a SACKed sequence range, the RACK reordering timer was
firing after about 16ms rather than the desired value of roughly
min_rtt/4 + 2ms. The problem is largely due to the RACK reorder timer
calculation adding in TCP_TIMEOUT_MIN, which is 2 jiffies. On kernels
with HZ=250, this is 2*4ms = 8ms. The TLP timer calculation has the
exact same issue.

This commit fixes the TLP transmit timer and RACK reordering timer
floor calculation to more closely match the intended 2ms floor even on
kernels with HZ=250. It does this by adding in a new
TCP_TIMEOUT_MIN_US floor of 2000 us and then converting to jiffies,
instead of the current approach of converting to jiffies and then
adding th TCP_TIMEOUT_MIN value of 2 jiffies.

Our testing has verified that on kernels with HZ=1000, as expected,
this does not produce significant changes in behavior, but on kernels
with the default HZ=250 the latency improvement can be large. For
example, our tests show that for HZ=250 kernels at low RTTs this fix
roughly halves the latency for the RACK reorder timer: instead of
mostly firing at 16ms it mostly fires at 8ms.

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Fixes: bb4d991a28cc ("tcp: adjust tail loss probe timeout")
---
 include/net/tcp.h       | 3 +++
 net/ipv4/tcp_output.c   | 9 +++++----
 net/ipv4/tcp_recovery.c | 2 +-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 7b1a720691aec..4b03ca7cb8a5e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -141,6 +141,9 @@ void tcp_time_wait(struct sock *sk, int state, int timeo);
 #define TCP_RTO_MAX	((unsigned)(120*HZ))
 #define TCP_RTO_MIN	((unsigned)(HZ/5))
 #define TCP_TIMEOUT_MIN	(2U) /* Min timeout for TCP timers in jiffies */
+
+#define TCP_TIMEOUT_MIN_US (2*USEC_PER_MSEC) /* Min TCP timeout in microsecs */
+
 #define TCP_TIMEOUT_INIT ((unsigned)(1*HZ))	/* RFC6298 2.1 initial RTO value	*/
 #define TCP_TIMEOUT_FALLBACK ((unsigned)(3*HZ))	/* RFC 1122 initial RTO value, now
 						 * used as a fallback RTO for the
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 9c8c42c280b76..bbd85672fda70 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2788,7 +2788,7 @@ bool tcp_schedule_loss_probe(struct sock *sk, bool advancing_rto)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
-	u32 timeout, rto_delta_us;
+	u32 timeout, timeout_us, rto_delta_us;
 	int early_retrans;
 
 	/* Don't do any loss probe on a Fast Open connection before 3WHS
@@ -2812,11 +2812,12 @@ bool tcp_schedule_loss_probe(struct sock *sk, bool advancing_rto)
 	 * sample is available then probe after TCP_TIMEOUT_INIT.
 	 */
 	if (tp->srtt_us) {
-		timeout = usecs_to_jiffies(tp->srtt_us >> 2);
+		timeout_us = tp->srtt_us >> 2;
 		if (tp->packets_out == 1)
-			timeout += TCP_RTO_MIN;
+			timeout_us += tcp_rto_min_us(sk);
 		else
-			timeout += TCP_TIMEOUT_MIN;
+			timeout_us += TCP_TIMEOUT_MIN_US;
+		timeout = usecs_to_jiffies(timeout_us);
 	} else {
 		timeout = TCP_TIMEOUT_INIT;
 	}
diff --git a/net/ipv4/tcp_recovery.c b/net/ipv4/tcp_recovery.c
index acf4869c5d3b5..bba10110fbbc1 100644
--- a/net/ipv4/tcp_recovery.c
+++ b/net/ipv4/tcp_recovery.c
@@ -104,7 +104,7 @@ bool tcp_rack_mark_lost(struct sock *sk)
 	tp->rack.advanced = 0;
 	tcp_rack_detect_loss(sk, &timeout);
 	if (timeout) {
-		timeout = usecs_to_jiffies(timeout) + TCP_TIMEOUT_MIN;
+		timeout = usecs_to_jiffies(timeout + TCP_TIMEOUT_MIN_US);
 		inet_csk_reset_xmit_timer(sk, ICSK_TIME_REO_TIMEOUT,
 					  timeout, inet_csk(sk)->icsk_rto);
 	}
-- 
2.42.0.655.g421f12c284-goog


