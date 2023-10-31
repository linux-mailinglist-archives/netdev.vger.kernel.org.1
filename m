Return-Path: <netdev+bounces-45376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E40247DC66F
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 07:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E01B281613
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 06:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811CB101C9;
	Tue, 31 Oct 2023 06:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1YwGAc9z"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6E2883D
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 06:19:49 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E806C0
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 23:19:48 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7d261a84bso55594397b3.3
        for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 23:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698733187; x=1699337987; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ozvrg33795mIjslsmMi2idVYeAKPsB68HiBbX7wbkD8=;
        b=1YwGAc9z3URoT5wZBV2EeS744ohX5SGo9mH9oM/pl8T3vnWBfnn6eHuLFUkp/UGqmm
         XueJPEpeA63jwlCzyqIgR2wVH0MEYk7FEfa5vevKzedNFDg8pJsXvqx703Ggfz9y4Ooa
         GgaKFCi0zIjMrqxCqF4BpNhTtv+zDziO5tzTN+iC3TYIDqatoTM6HtELBcrBMQPz8ecV
         GIqPpHc50r4o/xD3oqO4uH2G3plMairOryfHZw2coul9YbHzJI5fsPoAef2fqzqi5HQJ
         axGSyELnlUiWaH0iqzlxcBxUA1pBFIRsph0wwge4GIEizo+/nj2UEZwTUvLJghfZLFGJ
         VHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698733187; x=1699337987;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ozvrg33795mIjslsmMi2idVYeAKPsB68HiBbX7wbkD8=;
        b=dc/Bnz6kMJXKP9pVlWTUNztXQw34FGZqnkMEEVZZI86cQVrkUx8T4ohPANWWa7+RQ6
         SVufIhki1TVCKedZ+svj8WyNOiRBDMNtYo9ptMi+pm9AZ5PtWuPjDMr+M4I8dLvZsJYx
         vnkm0pdrUxR4T0hbfZ4z1yRGDu2rIq0KXqeyaEUnc4pOKVqohETeR0FLhgjMWJ4J/M+A
         901L20GbJz2NOEwzWo2hAJLYyjPGan6jvDlD6bwWz9AoHy8Lfx0YDT2aL3JCsImRWgSD
         tNq6t9ulRGHoyKMF3NTqMpLmGvJAB1kBXLl5gSkPMn5vhf16fP9LGSn/U+9RndInIsV+
         nTQA==
X-Gm-Message-State: AOJu0Yz/OM0bANtEY7PQ7xEhn0KkVnncEtidGmDNxURcm0kN2XuQpgnW
	FdG4FyPwv14aPhnVODylxCMroIHfmKXWIQ==
X-Google-Smtp-Source: AGHT+IHc6iAvFoDLTG9104ofuDM2l5fbfzw6AZAYu3KssSYLgZ6I+ZOwu30X1Y4lDfEBcRmrzr49u9F1UIYcPA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a0d:dfce:0:b0:5a7:af47:9dda with SMTP id
 i197-20020a0ddfce000000b005a7af479ddamr246295ywe.9.1698733187572; Mon, 30 Oct
 2023 23:19:47 -0700 (PDT)
Date: Tue, 31 Oct 2023 06:19:45 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231031061945.2801972-1-edumazet@google.com>
Subject: [PATCH net] tcp: fix fastopen code vs usec TS
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, kernel test robot <oliver.sang@intel.com>, 
	Neal Cardwell <ncardwell@google.com>, David Morley <morleyd@google.com>
Content-Type: text/plain; charset="UTF-8"

After blamed commit, TFO client-ack-dropped-then-recovery-ms-timestamps
packetdrill test failed.

David Morley and Neal Cardwell started investigating and Neal pointed
that we had :

tcp_conn_request()
  tcp_try_fastopen()
   -> tcp_fastopen_create_child
     -> child = inet_csk(sk)->icsk_af_ops->syn_recv_sock()
       -> tcp_create_openreq_child()
          -> copy req_usec_ts from req:
          newtp->tcp_usec_ts = treq->req_usec_ts;
          // now the new TFO server socket always does usec TS, no matter
          // what the route options are...
  send_synack()
    -> tcp_make_synack()
        // disable tcp_rsk(req)->req_usec_ts if route option is not present:
        if (tcp_rsk(req)->req_usec_ts < 0)
                tcp_rsk(req)->req_usec_ts = dst_tcp_usec_ts(dst);

tcp_conn_request() has the initial dst, we can initialize
tcp_rsk(req)->req_usec_ts there instead of later in send_synack();

This means tcp_rsk(req)->req_usec_ts can be a boolean.

Many thanks to David an Neal for their help.

Fixes: 614e8316aa4c ("tcp: add support for usec resolution in TCP TS values")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202310302216.f79d78bc-oliver.sang@intel.com
Suggested-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: David Morley <morleyd@google.com>
---
 include/linux/tcp.h   | 2 +-
 net/ipv4/syncookies.c | 2 +-
 net/ipv4/tcp_input.c  | 7 ++++---
 net/ipv4/tcp_output.c | 2 --
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index ec4e9367f5b03be610f5f88621855f3a512604eb..68f3d315d2e18d93a356b0738e4ed855fac94591 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -152,7 +152,7 @@ struct tcp_request_sock {
 	u64				snt_synack; /* first SYNACK sent time */
 	bool				tfo_listener;
 	bool				is_mptcp;
-	s8				req_usec_ts;
+	bool				req_usec_ts;
 #if IS_ENABLED(CONFIG_MPTCP)
 	bool				drop_req;
 #endif
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 98b25e5d147bac5262982681b0bc5b38434a473a..d37282c06e3da05fd36c48e6b4236d74ac2b7fe2 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -306,7 +306,7 @@ struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
 	treq->af_specific = af_ops;
 
 	treq->syn_tos = TCP_SKB_CB(skb)->ip_dsfield;
-	treq->req_usec_ts = -1;
+	treq->req_usec_ts = false;
 
 #if IS_ENABLED(CONFIG_MPTCP)
 	treq->is_mptcp = sk_is_mptcp(sk);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 50aaa1527150bd8adabce125775aab8b97018d53..bcb55d98004c5213f0095613124d5193b15b2793 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7115,7 +7115,7 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	req->syncookie = want_cookie;
 	tcp_rsk(req)->af_specific = af_ops;
 	tcp_rsk(req)->ts_off = 0;
-	tcp_rsk(req)->req_usec_ts = -1;
+	tcp_rsk(req)->req_usec_ts = false;
 #if IS_ENABLED(CONFIG_MPTCP)
 	tcp_rsk(req)->is_mptcp = 0;
 #endif
@@ -7143,9 +7143,10 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	if (!dst)
 		goto drop_and_free;
 
-	if (tmp_opt.tstamp_ok)
+	if (tmp_opt.tstamp_ok) {
+		tcp_rsk(req)->req_usec_ts = dst_tcp_usec_ts(dst);
 		tcp_rsk(req)->ts_off = af_ops->init_ts_off(net, skb);
-
+	}
 	if (!want_cookie && !isn) {
 		int max_syn_backlog = READ_ONCE(net->ipv4.sysctl_max_syn_backlog);
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index f558c054cf6e7538ecc3d711637af0bd44872318..0d8dd5b7e2e5e078d3e4bcc0d4270215f1be366d 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3693,8 +3693,6 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 	mss = tcp_mss_clamp(tp, dst_metric_advmss(dst));
 
 	memset(&opts, 0, sizeof(opts));
-	if (tcp_rsk(req)->req_usec_ts < 0)
-		tcp_rsk(req)->req_usec_ts = dst_tcp_usec_ts(dst);
 	now = tcp_clock_ns();
 #ifdef CONFIG_SYN_COOKIES
 	if (unlikely(synack_type == TCP_SYNACK_COOKIE && ireq->tstamp_ok))
-- 
2.42.0.820.g83a721a137-goog


