Return-Path: <netdev+bounces-43162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62587D19DD
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 02:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1651C21005
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 00:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDDA364;
	Sat, 21 Oct 2023 00:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImGqPcHB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8378362
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 00:20:24 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24D9D66
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 17:20:18 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ca72f8ff3aso11121475ad.0
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 17:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697847618; x=1698452418; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXJFlBwFhwHfvM5JYVMsvzxUtnjiNmN8uQfhF+Uy0bE=;
        b=ImGqPcHBWD4J42vZEUF86q6WFXUZEIUagDVRVFeY5aFbL2GhZRgIkBde1kBdty9+bQ
         Dil0D4NS8POrXt5hCwKZMOtAvy8cZX2BY6wX4cfuOPW4rgV2h7ePf5/OnDQI1emJ4viu
         Dp/ooDTs8KAMIIysTOnngF7zcnhLtB0ANXkuzQeK+qvZWByo//7LVcVvG/R1OPneCfq0
         GVzawTXJSHO2j6beEPiXlEbNmS+ndZ6eTjP4pwRFuF1TpqZ/Ab78FC5BpFxauM/ZKzfc
         UjJFvWwama6jnVtYT3IjpxvITqsisd173RFm0mGdbJ8X2qfCeCU497o17nkd4WPWTmGN
         HVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697847618; x=1698452418;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rXJFlBwFhwHfvM5JYVMsvzxUtnjiNmN8uQfhF+Uy0bE=;
        b=otYdhCYj8nOMBEmNe3f0cN9jmK2UMtF3K5bHH1Qpj3jaYx9m2iio2Ta+hMg7gVGlfs
         M30t50ghmprae7CmX2+4ekGLAplAvJS4rYuUmwovhV2KedTm2luQHTAWXMIuxVxHASta
         jxKMFMCLnb+c6EDCk1cah2rez8LtyLIxOHYntq73ORX++DKpolV79LUimEZl90P84Z6e
         ilVXDSCiTd/aK3MNNVyVBjh7ROtxjWt9qXIxtuyjxoPhLngL1iOWROESCaEiWA0sAQ1n
         LuCPIhrnEsjsh7s/KCBU4gPesTNrC4SKhriwH9e7w/Uxmjkxki7t8/+kVUAhB5Rez99o
         kbGg==
X-Gm-Message-State: AOJu0YyVKlGH6ctjGiYaACgLLxL3xQkYB+PFQOflKnZ7P5QT1xx3q5U+
	g5Zv6DmGUcusb6UVHzE+5sd2qV4ejnnY3w==
X-Google-Smtp-Source: AGHT+IGZ7S7Pij1979mrkM5EbQOERSTVRgZSsL0jAgkMv+zRT5y85P7tTiPO9VxqudH28UUjSCdM3g==
X-Received: by 2002:a17:902:f9cb:b0:1ca:87c9:d4df with SMTP id kz11-20020a170902f9cb00b001ca87c9d4dfmr3061023plb.11.1697847618090;
        Fri, 20 Oct 2023 17:20:18 -0700 (PDT)
Received: from localhost ([117.147.38.229])
        by smtp.gmail.com with ESMTPSA id i17-20020a17090332d100b001c32fd9e412sm2079458plr.58.2023.10.20.17.20.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Oct 2023 17:20:17 -0700 (PDT)
From: Fred Chen <fred.chenchen03@gmail.com>
To: edumazet@google.com,
	davem@davemloft.net,
	netdev@vger.kernel.org
Cc: yangpc@wangsu.com,
	ycheng@google.com,
	ncardwell@google.com,
	Fred Chen <fred.chenchen03@gmail.com>
Subject: [PATCH v1] tcp: fix wrong RTO timeout when received SACK reneging
Date: Sat, 21 Oct 2023 08:19:47 +0800
Message-Id: <1697847587-6850-1-git-send-email-fred.chenchen03@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

This commit fix wrong RTO timeout when received SACK reneging.

When an ACK arrived pointing to a SACK reneging, tcp_check_sack_reneging()
will rearm the RTO timer for min(1/2*srtt, 10ms) into to the future.

But since the commit 62d9f1a6945b ("tcp: fix TLP timer not set when
CA_STATE changes from DISORDER to OPEN") merged, the tcp_set_xmit_timer()
is moved after tcp_fastretrans_alert()(which do the SACK reneging check),
so the RTO timeout will be overwrited by tcp_set_xmit_timer() with
icsk_rto instead of 1/2*srtt.

Here is a packetdrill script to check this bug:
0     socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+0    bind(3, ..., ...) = 0
+0    listen(3, 1) = 0

// simulate srtt to 100ms
+0    < S 0:0(0) win 32792 <mss 1000, sackOK,nop,nop,nop,wscale 7>
+0    > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 7>
+.1    < . 1:1(0) ack 1 win 1024

+0    accept(3, ..., ...) = 4

+0    write(4, ..., 10000) = 10000
+0    > P. 1:10001(10000) ack 1

// inject sack
+.1    < . 1:1(0) ack 1 win 257 <sack 1001:10001,nop,nop>
+0    > . 1:1001(1000) ack 1

// inject sack reneging
+.1    < . 1:1(0) ack 1001 win 257 <sack 9001:10001,nop,nop>

// we expect rto fired in 1/2*srtt (50ms)
+.05    > . 1001:2001(1000) ack 1

This fix remove the FLAG_SET_XMIT_TIMER from ack_flag when
tcp_check_sack_reneging() set RTO timer with 1/2*srtt to avoid
being overwrited later.

Fixes: 62d9f1a6945b ("tcp: fix TLP timer not set when CA_STATE changes from DISORDER to OPEN")
Signed-off-by: Fred Chen <fred.chenchen03@gmail.com>
---
 net/ipv4/tcp_input.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index ab87f02..eee4e95 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -2222,16 +2222,17 @@ void tcp_enter_loss(struct sock *sk)
  * restore sanity to the SACK scoreboard. If the apparent reneging
  * persists until this RTO then we'll clear the SACK scoreboard.
  */
-static bool tcp_check_sack_reneging(struct sock *sk, int flag)
+static bool tcp_check_sack_reneging(struct sock *sk, int *ack_flag)
 {
-	if (flag & FLAG_SACK_RENEGING &&
-	    flag & FLAG_SND_UNA_ADVANCED) {
+	if (*ack_flag & FLAG_SACK_RENEGING &&
+	    *ack_flag & FLAG_SND_UNA_ADVANCED) {
 		struct tcp_sock *tp = tcp_sk(sk);
 		unsigned long delay = max(usecs_to_jiffies(tp->srtt_us >> 4),
 					  msecs_to_jiffies(10));
 
 		inet_csk_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
 					  delay, TCP_RTO_MAX);
+		*ack_flag &= ~FLAG_SET_XMIT_TIMER;
 		return true;
 	}
 	return false;
@@ -3009,7 +3010,7 @@ static void tcp_fastretrans_alert(struct sock *sk, const u32 prior_snd_una,
 		tp->prior_ssthresh = 0;
 
 	/* B. In all the states check for reneging SACKs. */
-	if (tcp_check_sack_reneging(sk, flag))
+	if (tcp_check_sack_reneging(sk, ack_flag))
 		return;
 
 	/* C. Check consistency of the current state. */
-- 
1.8.3.1


