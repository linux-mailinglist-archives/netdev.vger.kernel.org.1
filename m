Return-Path: <netdev+bounces-43018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B65167D1001
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 14:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79620B214C9
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 12:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC18C1A73C;
	Fri, 20 Oct 2023 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x5tDgOvx"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162BF1A72F
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 12:57:59 +0000 (UTC)
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0269F
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:57:57 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id af79cd13be357-778ac2308e6so57178385a.3
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697806677; x=1698411477; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UTpsbJ07nSayV69jTdmjwmIWvQszRH1HsCpqj2/5XfA=;
        b=x5tDgOvx8kndY3oagKewk3b8QmAgVWVLK+zUkTAEsVF4g1rCjzlRQk/W9eXWiw0J1k
         k/9NTDRqctqadKiQO3F+3BT7Onck55g/qhxQs8krjzC7pUvgbYuPt1uIveKtHpC3CbuF
         7Hzjg4IxS2ReRT+hmghGyFR9skATRAy2khCsk5vn2J+fqT5uPHiS7DcLo8ylEX6o2Jxe
         AFxk7pX290HUeVgV7yuuYuWTfThpnZ4x0B42JLE35sTI3ZGKdIkgZ8BuIspxLESFy4I5
         SUQ6fpNLqnUcMlRobkPfGYXnNQakk5pi0y8HZ5/KfgNj/amBoX/gZtC0FdeKBRLH7jyb
         Xfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697806677; x=1698411477;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UTpsbJ07nSayV69jTdmjwmIWvQszRH1HsCpqj2/5XfA=;
        b=OUAqeaNiG3HaNuiJnodYgQToDtgN5GEGcdUj6k+6w5FH3rjJQNrXsngE9OZyYIar31
         iXp0SPqIuFdrs0xuVOgKSxMSbL4h1v6xPQz++jOf8mnBxhYhNkBAnY2oLstZ/p24kqo4
         3a1SjykJj+Rj9qqaR/5qoMi/ZeqJZImayiyxO15QWBgTvPXe0hhXnDZqjz8BVLK9p5L7
         0E8X0GGsslSkjv4o1m5UFHBfrBJn+WM12wBDrZSeSquqFv30qp4tz95sS3ir9p5z63o5
         rMqG0HaX6FR3ri6gkdmJFq/6dNyl/O18uWRNO3H/fNksNwNqnD/dYKlk/OYidVbYDH8i
         txJw==
X-Gm-Message-State: AOJu0YywZ/D0tPELvP28DZl+uF1UqR6x1vzxmA36xujv3iWt6uC9yjTI
	HAhfdaCC94gdhA0cLQLZxUXbGrOZemDvoA==
X-Google-Smtp-Source: AGHT+IHb6PkM9GgIk0VpcNbqYhljfTvLDziTaumRXsFjKYH/t6RUhcmY5Oprdj82HWKnuyQq5zuEEX6EFXrfYA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:620a:ec2:b0:76d:8404:f17f with SMTP
 id x2-20020a05620a0ec200b0076d8404f17fmr30322qkm.2.1697806677128; Fri, 20 Oct
 2023 05:57:57 -0700 (PDT)
Date: Fri, 20 Oct 2023 12:57:39 +0000
In-Reply-To: <20231020125748.122792-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231020125748.122792-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231020125748.122792-5-edumazet@google.com>
Subject: [PATCH net-next 04/13] tcp: introduce tcp_clock_ms()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>, Kevin Yang <yyd@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Wei Wang <weiwan@google.com>, Van Jacobson <vanj@google.com>, 
	Florian Westphal <fw@strlen.de>, eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

It delivers current TCP time stamp in ms unit, and is used
in place of confusing tcp_time_stamp_raw()

It is the same family than tcp_clock_ns() and tcp_clock_ms().

tcp_time_stamp_raw() will be replaced later for TSval
contexts with a more descriptive name.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h                                     | 5 +++++
 net/ipv4/tcp.c                                        | 6 ++----
 net/ipv4/tcp_minisocks.c                              | 4 ++--
 net/netfilter/nf_synproxy_core.c                      | 2 +-
 tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c | 4 ++--
 5 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 9fc6dc4ba9e2e2be44318d4495ceb19523395b18..3bdf1141f5a2c11e30ad85c68aafd062e7bf548c 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -798,6 +798,11 @@ static inline u64 tcp_clock_us(void)
 	return div_u64(tcp_clock_ns(), NSEC_PER_USEC);
 }
 
+static inline u64 tcp_clock_ms(void)
+{
+	return div_u64(tcp_clock_ns(), NSEC_PER_MSEC);
+}
+
 /* This should only be used in contexts where tp->tcp_mstamp is up to date */
 static inline u32 tcp_time_stamp(const struct tcp_sock *tp)
 {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 56a8d936000f610566e46694fec5ddd1dccd7102..5b034b0356ecbd2b7d2dcafd9caac2b8de5886f1 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3817,10 +3817,8 @@ void tcp_get_info(struct sock *sk, struct tcp_info *info)
 	info->tcpi_total_rto = tp->total_rto;
 	info->tcpi_total_rto_recoveries = tp->total_rto_recoveries;
 	info->tcpi_total_rto_time = tp->total_rto_time;
-	if (tp->rto_stamp) {
-		info->tcpi_total_rto_time += tcp_time_stamp_raw() -
-						tp->rto_stamp;
-	}
+	if (tp->rto_stamp)
+		info->tcpi_total_rto_time += tcp_clock_ms() - tp->rto_stamp;
 
 	unlock_sock_fast(sk, slow);
 }
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 3f87611077ef21edb61f3d6c751c88c515bb4b5b..a9fdba897a28f3a5835a1bd1426f82de0e81a633 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -567,8 +567,8 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 					       USEC_PER_SEC / TCP_TS_HZ);
 		newtp->total_rto = req->num_timeout;
 		newtp->total_rto_recoveries = 1;
-		newtp->total_rto_time = tcp_time_stamp_raw() -
-						newtp->retrans_stamp;
+		newtp->total_rto_time = tcp_clock_ms() -
+					newtp->retrans_stamp;
 	}
 	newtp->tsoffset = treq->ts_off;
 #ifdef CONFIG_TCP_MD5SIG
diff --git a/net/netfilter/nf_synproxy_core.c b/net/netfilter/nf_synproxy_core.c
index 16915f8eef2b16eec7da7ecaaf8b4a4af5dd94e2..467671f2d42f742554d95b017738aaa4ea4c9121 100644
--- a/net/netfilter/nf_synproxy_core.c
+++ b/net/netfilter/nf_synproxy_core.c
@@ -153,7 +153,7 @@ void synproxy_init_timestamp_cookie(const struct nf_synproxy_info *info,
 				    struct synproxy_options *opts)
 {
 	opts->tsecr = opts->tsval;
-	opts->tsval = tcp_time_stamp_raw() & ~0x3f;
+	opts->tsval = tcp_clock_ms() & ~0x3f;
 
 	if (opts->options & NF_SYNPROXY_OPT_WSCALE) {
 		opts->tsval |= opts->wscale;
diff --git a/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c b/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
index 07d786329105da371dd280868981e8e19ac5f6a8..e959336c7a7304be409ffac7d3a34f64538d5f74 100644
--- a/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
+++ b/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
@@ -177,7 +177,7 @@ static __always_inline __u32 tcp_ns_to_ts(__u64 ns)
 	return ns / (NSEC_PER_SEC / TCP_TS_HZ);
 }
 
-static __always_inline __u32 tcp_time_stamp_raw(void)
+static __always_inline __u32 tcp_clock_ms(void)
 {
 	return tcp_ns_to_ts(tcp_clock_ns());
 }
@@ -274,7 +274,7 @@ static __always_inline bool tscookie_init(struct tcphdr *tcp_header,
 	if (!loop_ctx.option_timestamp)
 		return false;
 
-	cookie = tcp_time_stamp_raw() & ~TSMASK;
+	cookie = tcp_clock_ms() & ~TSMASK;
 	cookie |= loop_ctx.wscale & TS_OPT_WSCALE_MASK;
 	if (loop_ctx.option_sack)
 		cookie |= TS_OPT_SACK;
-- 
2.42.0.655.g421f12c284-goog


