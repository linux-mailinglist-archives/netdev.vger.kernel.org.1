Return-Path: <netdev+bounces-43021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 697187D1004
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 14:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA866282407
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 12:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959B31A706;
	Fri, 20 Oct 2023 12:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GBfQ5+wy"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B191A710
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 12:58:04 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1083ED63
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:58:03 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7ba10cb90so10469097b3.3
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697806682; x=1698411482; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IGEMW0yNQTDPUrumdf0Qda7iyiVP01CEwTBL110uSOg=;
        b=GBfQ5+wyfvVd/tdpGR1ZrYG4zINybYKAwBc6fOdoT5Ga2GSfu8OqxX4UedZ+xfjEil
         7iEtyi862NFw9iTq9n1gRENeEgA2CI+06ddpCgABqNPlyRrYLJ8LSCUsyWlVsRRFBQ4K
         kGNkDgFFIE7NPilq2IHzEoCEQAlwQ9twJIVSS+O6izRmVdVoCEHotR+8xu9X6aEjiMw2
         XIQZ+op2HXmVvD82I2Q5p8Z/75snUYwN2ds/D+gyo2v3ugZP20/MbPPiUSkmq3HVwW3n
         9BnvM9c3BqvcjohJvmYfuVjWcnb+kfJz0T2DhxkYBDOK/qM/2filasv+Jwmh1Rmidk1r
         FtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697806682; x=1698411482;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IGEMW0yNQTDPUrumdf0Qda7iyiVP01CEwTBL110uSOg=;
        b=xRWhW/nMmZnJeWB/PWvciRpxNKBbtcO45O+2fO2JpE4RPo6Y9RoKV4WpwWqXbSXyBp
         Q92mmpzW4Pgb2KXidGe2N70ADzqe2WpaVYHLQPRRlKgoo6WfL2AMZuJLTHpmrYKcvKTB
         y2r/YuxOm2JugZ5Vet4sQxDqK7AI34Tb9elgydRnp5DYHbcvJRccYQ5eo3wRTVf2sBiJ
         ST4PGZ5kCM6gDN8boUOEKPNYbOIunk9XWrs1J27d6eJ2O7JkgN1Rbdv/YDC48axQ2KMm
         lRWtUR54R6541SxZVfmZ//qQweOuvU5+tKDzJtq83nxXsPY5zsR/Xl49yPu4VM58Kdgr
         4NBQ==
X-Gm-Message-State: AOJu0Yxlx476fcSyP4gSYahFZpH2lcFb8917DcgJpr4nrPmq2HK//MZa
	F4nuGaPyFED1qKJn/Atqh0ZeWzEwpqvV3A==
X-Google-Smtp-Source: AGHT+IHXRmfM3z+gEY2yIJdpMTmRIEHah4dQ8QUvVFUZGicvM4rP51XSlCIRQyHdfgexPuIBGWfZUWbf7Hlm/g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:4e42:0:b0:59b:db15:498c with SMTP id
 c63-20020a814e42000000b0059bdb15498cmr44137ywb.10.1697806682267; Fri, 20 Oct
 2023 05:58:02 -0700 (PDT)
Date: Fri, 20 Oct 2023 12:57:42 +0000
In-Reply-To: <20231020125748.122792-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231020125748.122792-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231020125748.122792-8-edumazet@google.com>
Subject: [PATCH net-next 07/13] tcp: move tcp_ns_to_ts() to net/ipv4/syncookies.c
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>, Kevin Yang <yyd@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Wei Wang <weiwan@google.com>, Van Jacobson <vanj@google.com>, 
	Florian Westphal <fw@strlen.de>, eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tcp_ns_to_ts() is only used once from cookie_init_timestamp().

Also add the 'bool usec_ts' parameter to enable usec TS later.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h     |  6 ------
 net/ipv4/syncookies.c | 10 +++++++++-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 493f8550055bca09b69a9d3129d6ba781a1233f8..b86abf1fbe46061a00dbd202323792f01a307969 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -824,12 +824,6 @@ static inline u32 tcp_time_stamp_ms(const struct tcp_sock *tp)
 	return div_u64(tp->tcp_mstamp, USEC_PER_MSEC);
 }
 
-/* Convert a nsec timestamp into TCP TSval timestamp (ms based currently) */
-static inline u64 tcp_ns_to_ts(u64 ns)
-{
-	return div_u64(ns, NSEC_PER_SEC / TCP_TS_HZ);
-}
-
 void tcp_mstamp_refresh(struct tcp_sock *tp);
 
 static inline u32 tcp_stamp_us_delta(u64 t1, u64 t0)
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 3b4dafefb4b036c661bf52f5e7e304b943a4fd5e..62395fdb0ca557caee78d84ae70273eb42a837b9 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -51,6 +51,14 @@ static u32 cookie_hash(__be32 saddr, __be32 daddr, __be16 sport, __be16 dport,
 			    count, &syncookie_secret[c]);
 }
 
+/* Convert one nsec 64bit timestamp to ts (ms or usec resolution) */
+static u64 tcp_ns_to_ts(bool usec_ts, u64 val)
+{
+	if (usec_ts)
+		return div_u64(val, NSEC_PER_USEC);
+
+	return div_u64(val, NSEC_PER_MSEC);
+}
 
 /*
  * when syncookies are in effect and tcp timestamps are enabled we encode
@@ -62,7 +70,7 @@ static u32 cookie_hash(__be32 saddr, __be32 daddr, __be16 sport, __be16 dport,
 u64 cookie_init_timestamp(struct request_sock *req, u64 now)
 {
 	const struct inet_request_sock *ireq = inet_rsk(req);
-	u64 ts, ts_now = tcp_ns_to_ts(now);
+	u64 ts, ts_now = tcp_ns_to_ts(false, now);
 	u32 options = 0;
 
 	options = ireq->wscale_ok ? ireq->snd_wscale : TS_OPT_WSCALE_MASK;
-- 
2.42.0.655.g421f12c284-goog


