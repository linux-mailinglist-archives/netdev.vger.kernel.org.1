Return-Path: <netdev+bounces-35297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3442B7A8AA6
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 19:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD0F91F20F3C
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 17:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F713FB22;
	Wed, 20 Sep 2023 17:29:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D210E3E47E
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 17:29:55 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC7BEA
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 10:29:54 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58cb845f2f2so956957b3.1
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 10:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695230993; x=1695835793; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QuG2xwFPQ/mM2UVIxlon4tt+NKqQZGnzoeq9fbEVUA8=;
        b=K8RCUJ71JJX6g8lEsbodbJV/oOmi1sHOyaKOeOfFPB3O1ev+faYAqusmfG2FdeDnOG
         nCs9eb9O/tHcTbHyxxaRlkBE3WrNsrwfjVqmH8m86WfItvbk9cj0ryRO7NNVOr/2p0t4
         OwUwFzELQBvO9FDjlFfBRtSyn6mSEVR/xLa2sffkO1xgVVRrtwRXuYlU7m/B7quXbWeG
         DAiZm/Rv2KBhf1mqQi+lAD0+vxrlAKKAeMfg0J/xa1L3k/5YxgiSWD8J6xAGCkxRuSUY
         KY1tFRwY2F3Mpwar8a+Ym7jKwBoytJRO+J5ZOVasr39tXkZB5ZzhqCxOOyouGISKtvAu
         bZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695230993; x=1695835793;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QuG2xwFPQ/mM2UVIxlon4tt+NKqQZGnzoeq9fbEVUA8=;
        b=mETBld8ZZceRPGtZr8ZUrwt7DuxSI4yWDd21BfkLq6aie1L0DgyMqIfNGfAl0+aM8y
         3H2inw7OTYx0iOjc230u4WajXoR+NMYBfDdutreohsndA6F0kL6bneRwVyevQmoUIH/c
         4Mr6mDmvChKhlhnPcK/viy5A9Ssnjlts0IRqlUim9jc3cE0VGU5kZh0wXYqzNpxE4Tb5
         3WC42Ne4hCdknkPOe6EjOl2mIConLOCDC0pyR5ig3MJZ8I5i117mFYqpu6RnzIem+gCh
         OA4g3KGWmnan1ONuRbUo+N2sjLfxcB5PouWt9hd1Nqhr8v6UlN30V4d9OZUIVdye7wkB
         G5ow==
X-Gm-Message-State: AOJu0YwL4L8ekVMCrcwAfv0VstD4PaAd2fmEP/Sx1ou5i4jlpE8ELjnY
	iKJcphBaHEPb1hGFjX2VTOZ1G4wUt/DJSQ==
X-Google-Smtp-Source: AGHT+IGZckk+2SV54l8W3g8cCGhzehM0JLDI+9M0BS7JDcy0FaXDcTq/NluaLFC4UDG4PmhDWsosQo3fWJrilg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:dfcf:0:b0:d85:4f44:1407 with SMTP id
 w198-20020a25dfcf000000b00d854f441407mr48548ybg.8.1695230993214; Wed, 20 Sep
 2023 10:29:53 -0700 (PDT)
Date: Wed, 20 Sep 2023 17:29:43 +0000
In-Reply-To: <20230920172943.4135513-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230920172943.4135513-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230920172943.4135513-4-edumazet@google.com>
Subject: [PATCH net-next 3/3] tcp: derive delack_max from rto_min
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

While BPF allows to set icsk->->icsk_delack_max
and/or icsk->icsk_rto_min, we have an ip route
attribute (RTAX_RTO_MIN) to be able to tune rto_min,
but nothing to consequently adjust max delayed ack,
which vary from 40ms to 200 ms (TCP_DELACK_{MIN|MAX}).

This makes RTAX_RTO_MIN of almost no practical use,
unless customers are in big trouble.

Modern days datacenter communications want to set
rto_min to ~5 ms, and the max delayed ack one jiffie
smaller to avoid spurious retransmits.

After this patch, an "rto_min 5" route attribute will
effectively lower max delayed ack timers to 4 ms.

Note in the following ss output, "rto:6 ... ato:4"

$ ss -temoi dst XXXXXX
State Recv-Q Send-Q           Local Address:Port       Peer Address:Port  Process
ESTAB 0      0        [2002:a05:6608:295::]:52950   [2002:a05:6608:297::]:41597
     ino:255134 sk:1001 <->
         skmem:(r0,rb1707063,t872,tb262144,f0,w0,o0,bl0,d0) ts sack
 cubic wscale:8,8 rto:6 rtt:0.02/0.002 ato:4 mss:4096 pmtu:4500
 rcvmss:536 advmss:4096 cwnd:10 bytes_sent:54823160 bytes_acked:54823121
 bytes_received:54823120 segs_out:1370582 segs_in:1370580
 data_segs_out:1370579 data_segs_in:1370578 send 16.4Gbps
 pacing_rate 32.6Gbps delivery_rate 1.72Gbps delivered:1370579
 busy:26920ms unacked:1 rcv_rtt:34.615 rcv_space:65920
 rcv_ssthresh:65535 minrtt:0.015 snd_wnd:65536

While we could argue this patch fixes a bug with RTAX_RTO_MIN,
I do not add a Fixes: tag, so that we can soak it a bit before
asking backports to stable branches.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h     |  2 ++
 net/ipv4/tcp.c        |  3 ++-
 net/ipv4/tcp_output.c | 16 +++++++++++++++-
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index a8db7d43fb6215197af4a80e270b8c82070d55cb..af9cb37fbe53ec60b4e545e8aa0740bbf30da7b6 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -718,6 +718,8 @@ static inline void tcp_fast_path_check(struct sock *sk)
 		tcp_fast_path_on(tp);
 }
 
+u32 tcp_delack_max(const struct sock *sk);
+
 /* Compute the actual rto_min value */
 static inline u32 tcp_rto_min(const struct sock *sk)
 {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 69b8d707370844020770438cc4f31aeda4830b3d..e54f91eb943b2f09f303951cc72cbea61ada519d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3762,7 +3762,8 @@ void tcp_get_info(struct sock *sk, struct tcp_info *info)
 		info->tcpi_options |= TCPI_OPT_SYN_DATA;
 
 	info->tcpi_rto = jiffies_to_usecs(icsk->icsk_rto);
-	info->tcpi_ato = jiffies_to_usecs(icsk->icsk_ack.ato);
+	info->tcpi_ato = jiffies_to_usecs(min(icsk->icsk_ack.ato,
+					      tcp_delack_max(sk)));
 	info->tcpi_snd_mss = tp->mss_cache;
 	info->tcpi_rcv_mss = icsk->icsk_ack.rcv_mss;
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 1fc1f879cfd6c28cd655bb8f02eff6624eec2ffc..2d1e4b5ac1ca41ff3db8dc58458d4e922a2c4999 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3977,6 +3977,20 @@ int tcp_connect(struct sock *sk)
 }
 EXPORT_SYMBOL(tcp_connect);
 
+u32 tcp_delack_max(const struct sock *sk)
+{
+	const struct dst_entry *dst = __sk_dst_get(sk);
+	u32 delack_max = inet_csk(sk)->icsk_delack_max;
+
+	if (dst && dst_metric_locked(dst, RTAX_RTO_MIN)) {
+		u32 rto_min = dst_metric_rtt(dst, RTAX_RTO_MIN);
+		u32 delack_from_rto_min = max_t(int, 1, rto_min - 1);
+
+		delack_max = min_t(u32, delack_max, delack_from_rto_min);
+	}
+	return delack_max;
+}
+
 /* Send out a delayed ack, the caller does the policy checking
  * to see if we should even be here.  See tcp_input.c:tcp_ack_snd_check()
  * for details.
@@ -4012,7 +4026,7 @@ void tcp_send_delayed_ack(struct sock *sk)
 		ato = min(ato, max_ato);
 	}
 
-	ato = min_t(u32, ato, inet_csk(sk)->icsk_delack_max);
+	ato = min_t(u32, ato, tcp_delack_max(sk));
 
 	/* Stay within the limit we were given */
 	timeout = jiffies + ato;
-- 
2.42.0.459.ge4e396fd5e-goog


