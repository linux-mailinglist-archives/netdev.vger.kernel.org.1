Return-Path: <netdev+bounces-43017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEDE7D1000
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 14:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA7F281FE1
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 12:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2C31A70E;
	Fri, 20 Oct 2023 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vrrDYhnM"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528EA1A70F
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 12:57:57 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168EFD57
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:57:56 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9cb79eb417so925159276.2
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697806675; x=1698411475; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UzzMk4FpgrpMXYF9vsm1NsquU/PucyXUOOW/Z+ImApo=;
        b=vrrDYhnMlSkxwkmG99RwjgWFZsmwARkI8mVNeUyXz7sqEConKDdxeSzZ5dOIuXUMAf
         +9DYTAGiMJJvVMgGRpuu71kfoUFLpRtqFWkvz0KMvIvceUfG3MZdH2OpegQ7h4oAq0ex
         wGFz9Ptz/6ayvPQvFCDhds+0KQEvQsFxlFXBouR6Ba4P/SsmrbzpJsmr/W85jUGQk4Mq
         nAcEt1gRQGy7kbhs3PvRtvy7Rwq52efLCHIGNoJLJdaRcL7HKwF2Zadupo1WlB7u1qEL
         8ZWKdoUIDbHVtVWAdKVVOsun5rm4w9mLi+xE3tbqFL9qaWG2lNm/28S/Tx8NRzj4RLpZ
         EEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697806675; x=1698411475;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UzzMk4FpgrpMXYF9vsm1NsquU/PucyXUOOW/Z+ImApo=;
        b=RdbMQKrFz0bBpgHaM75xpCKXd8EifghI821feV1BspF5p2uZqRPJSitzKciyVdPaZA
         vKaf5+OkD03Z78CN6xuIbp6i/gBIHhqsWr8DFny6lKU9hYHH0ioZQP21lt57Ev6LSi5j
         w+hGsWiC6ogBL5P6Vdiv9FMFFiVLbpOL+qmWHnNCUbpoFH6ttTCjm0Y9GoCUNB75PuIQ
         4QUJRF2AbiTsD9/ADlfCBEldb8iXYCyztvK2GvEYoy0lRXfgkSGYNEJzGetFRKKAxtIt
         eA7FFy0EAV9P2R6zBABgubzz43PI377LV9ZrEDZjQKpINdD7TaLsJ+M9oqfJ7Yc8nowU
         1a5A==
X-Gm-Message-State: AOJu0YxC/FrV+rXzyEbb9wTwKlaHSsZlRWQhEGqkk6zmJyqF5cJCkjhT
	mvrFowJ+lL1IXny7IGgxDHon2oc4ACp8jQ==
X-Google-Smtp-Source: AGHT+IF9hh2zM1qc8FzaSLKipZM81Ch2kPo8ErRXHRijaoL1udJdNQPl7FusrVX7aRy9vTt03U+4+vbPiFpc7w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:938d:0:b0:d9a:61d2:38ca with SMTP id
 a13-20020a25938d000000b00d9a61d238camr33305ybm.10.1697806675342; Fri, 20 Oct
 2023 05:57:55 -0700 (PDT)
Date: Fri, 20 Oct 2023 12:57:38 +0000
In-Reply-To: <20231020125748.122792-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231020125748.122792-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231020125748.122792-4-edumazet@google.com>
Subject: [PATCH net-next 03/13] tcp: add tcp_time_stamp_ms() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>, Kevin Yang <yyd@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Wei Wang <weiwan@google.com>, Van Jacobson <vanj@google.com>, 
	Florian Westphal <fw@strlen.de>, eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

In preparation of adding usec TCP TS values, add tcp_time_stamp_ms()
for contexts needing ms based values.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h    | 5 +++++
 net/ipv4/tcp_input.c | 2 +-
 net/ipv4/tcp_timer.c | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index d47a57a47b50b4bbc7ff45c76371d39cf6207c54..9fc6dc4ba9e2e2be44318d4495ceb19523395b18 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -804,6 +804,11 @@ static inline u32 tcp_time_stamp(const struct tcp_sock *tp)
 	return div_u64(tp->tcp_mstamp, USEC_PER_SEC / TCP_TS_HZ);
 }
 
+static inline u32 tcp_time_stamp_ms(const struct tcp_sock *tp)
+{
+	return div_u64(tp->tcp_mstamp, USEC_PER_MSEC);
+}
+
 /* Convert a nsec timestamp into TCP TSval timestamp (ms based currently) */
 static inline u64 tcp_ns_to_ts(u64 ns)
 {
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index ab87f0285b728f3829f1e409833ed4feebd7920e..ffce17545b62c78595c5dd569665a6ebe6a29bbc 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -2856,7 +2856,7 @@ void tcp_enter_recovery(struct sock *sk, bool ece_ack)
 static void tcp_update_rto_time(struct tcp_sock *tp)
 {
 	if (tp->rto_stamp) {
-		tp->total_rto_time += tcp_time_stamp(tp) - tp->rto_stamp;
+		tp->total_rto_time += tcp_time_stamp_ms(tp) - tp->rto_stamp;
 		tp->rto_stamp = 0;
 	}
 }
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 0862b73dd3b5299d2b201e9e93dbef8a0617f75b..63247c78dc13d445c1e1c5cf24e7ffd7a1faa403 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -422,7 +422,7 @@ static void tcp_update_rto_stats(struct sock *sk)
 
 	if (!icsk->icsk_retransmits) {
 		tp->total_rto_recoveries++;
-		tp->rto_stamp = tcp_time_stamp(tp);
+		tp->rto_stamp = tcp_time_stamp_ms(tp);
 	}
 	icsk->icsk_retransmits++;
 	tp->total_rto++;
-- 
2.42.0.655.g421f12c284-goog


