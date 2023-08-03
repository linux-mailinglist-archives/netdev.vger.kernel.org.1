Return-Path: <netdev+bounces-24145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C13276EF75
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 18:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 256D42822A9
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 16:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7171F16D;
	Thu,  3 Aug 2023 16:30:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BA224188
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 16:30:27 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367EE3C15
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 09:30:23 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56942442eb0so12933217b3.1
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 09:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691080223; x=1691685023;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JPNt3kbOsmr8LYaro8WYOloXZJCiVpAzzMdZOeCISJU=;
        b=mtLIlIYpYDHXIB/LElFL5Mgnt71RFE/IpuE+EFv6fIL03RVcrf2qMSx7xcyZD7SDAQ
         q1t9+iiB8lNVtQZTz24kvbbmRkSGBd315uDN1D/UGj3x8Ole/j+FhHmztRuVDhcwGylz
         WPRQhWJfxKuQSrDSACMKVtauXE1NpvGhuIfWz7YEdiDtFKuRpgCE1eoe7yap+jMPVwuy
         P/tOthSzxbVy6jF+FmXche5KRz3WL5LMaGykDFNooX7iHryp8nVmlcNRiWGkQ1Q7VHCv
         f3UThF+ej/JI5SNBo9N08ZC+ILsePoL8Za8hiROHCtTXV1MCLsGXdPTcYFLLVC69V6LL
         lLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691080223; x=1691685023;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JPNt3kbOsmr8LYaro8WYOloXZJCiVpAzzMdZOeCISJU=;
        b=RxRcPIzRsJj2/F5iwc0YLq+xKuIPE+NhW8ubm4MtRbqToXhJ6gXEBxx5Oe8H0hxJQa
         EQ/o7pEdqc5pcybLkqxbvLMCe43z0Hs2zahEAy8aOw8cYNU4vpT7BbAQqVgBk8NIbZst
         0PfN88Lokn4xG1v3ul1/rBPddycNaYeHGOXTZaagt2UNNKAvVHU+6HiGoWv1BUD4lQkB
         R2dneVzLI47x2jaiRMQUzNO5j7kYbNrO5VMZOyNnuIbgOjqXcAgYSY0ykw82Jw22dVb3
         4n8ysFMHinbppOkJKO7G8qja439PgQt9P5/5R00U5xPmegiIaOhjfvaWmVT0Opz4hdU1
         237Q==
X-Gm-Message-State: ABy/qLZNJjhVtizNfjNhlHuGYDrsJtqYNzSRXAH3F1dlHDKjqFjsqbyp
	aSPL2Vn4gTvRSRZ2MX/vJ0GxNDmRpy5YOg==
X-Google-Smtp-Source: APBJJlELvOB3IpvcGUtq357IpwCpw68DfVCZXVnbsa2q/QoHTxQ08VlXuyvu6QV9GJfzrodq2SrKWRgogMdavQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:48a:0:b0:d37:353:b7eb with SMTP id
 132-20020a25048a000000b00d370353b7ebmr82095ybe.11.1691080223220; Thu, 03 Aug
 2023 09:30:23 -0700 (PDT)
Date: Thu,  3 Aug 2023 16:30:21 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230803163021.2958262-1-edumazet@google.com>
Subject: [PATCH net] dccp: fix data-race around dp->dccps_mss_cache
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

dccp_sendmsg() reads dp->dccps_mss_cache before locking the socket.
Same thing in do_dccp_getsockopt().

Add READ_ONCE()/WRITE_ONCE() annotations,
and change dccp_sendmsg() to check again dccps_mss_cache
after socket is locked.

Fixes: 7c657876b63c ("[DCCP]: Initial implementation")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/dccp/output.c |  2 +-
 net/dccp/proto.c  | 10 ++++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/dccp/output.c b/net/dccp/output.c
index b8a24734385ef75c3de33862a6bcd248fdd3d723..fd2eb148d24de4d1b9e40c6721577ed7f11b5a6c 100644
--- a/net/dccp/output.c
+++ b/net/dccp/output.c
@@ -187,7 +187,7 @@ unsigned int dccp_sync_mss(struct sock *sk, u32 pmtu)
 
 	/* And store cached results */
 	icsk->icsk_pmtu_cookie = pmtu;
-	dp->dccps_mss_cache = cur_mps;
+	WRITE_ONCE(dp->dccps_mss_cache, cur_mps);
 
 	return cur_mps;
 }
diff --git a/net/dccp/proto.c b/net/dccp/proto.c
index f331e5977a8447d9884fe1ddbcac72ed32f5dece..4e3266e4d7c3c4595ac7f0f8e5e48c0cc98724de 100644
--- a/net/dccp/proto.c
+++ b/net/dccp/proto.c
@@ -630,7 +630,7 @@ static int do_dccp_getsockopt(struct sock *sk, int level, int optname,
 		return dccp_getsockopt_service(sk, len,
 					       (__be32 __user *)optval, optlen);
 	case DCCP_SOCKOPT_GET_CUR_MPS:
-		val = dp->dccps_mss_cache;
+		val = READ_ONCE(dp->dccps_mss_cache);
 		break;
 	case DCCP_SOCKOPT_AVAILABLE_CCIDS:
 		return ccid_getsockopt_builtin_ccids(sk, len, optval, optlen);
@@ -739,7 +739,7 @@ int dccp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	trace_dccp_probe(sk, len);
 
-	if (len > dp->dccps_mss_cache)
+	if (len > READ_ONCE(dp->dccps_mss_cache))
 		return -EMSGSIZE;
 
 	lock_sock(sk);
@@ -772,6 +772,12 @@ int dccp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		goto out_discard;
 	}
 
+	/* We need to check dccps_mss_cache after socket is locked. */
+	if (len > dp->dccps_mss_cache) {
+		rc = -EMSGSIZE;
+		goto out_discard;
+	}
+
 	skb_reserve(skb, sk->sk_prot->max_header);
 	rc = memcpy_from_msg(skb_put(skb, len), msg, len);
 	if (rc != 0)
-- 
2.41.0.640.ga95def55d0-goog


