Return-Path: <netdev+bounces-19251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DDA75A096
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 23:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA58281AF5
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0092516E;
	Wed, 19 Jul 2023 21:29:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F67A22EF5
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 21:29:15 +0000 (UTC)
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A53F1FC0
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:29:14 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id 6a1803df08f44-6351121aa10so1739486d6.0
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689802153; x=1690406953;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G94ezoHZMZuYDPgjgZLd+f5Vev61fu4eKkIxqkHMlhA=;
        b=SdyviGB+3Qnuec43vCdOXdEm4dGEbEJWnI3mYISgtWruvl0L/Ym2n+bLR8jSxt4Sjk
         UFCV5JmAgEF8mawBE5hlFR8h9bleMohATNzSZlIVY/cZfTec72gy2UgKA59Swbdt+v5V
         AYryTc+NT7o0A6PjsYEf50uuUvRKPh7vdLuq05+eLrTxIx4U2ZAwqS8bInFQit36pv8o
         HI1P5Qa8XkH0oF/D/ljGfGS75NeAFMI9BNE/YkPmsuTfLmgIAKQFjXcOtSEXq5m3pdF5
         rF3Q3BkOBDlRv+DeNfE5uLrbrX/JYmTyov60t9CHhO7fuHrHXdTDvxHGe3UjtNf3BRTX
         vLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689802153; x=1690406953;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G94ezoHZMZuYDPgjgZLd+f5Vev61fu4eKkIxqkHMlhA=;
        b=cpt23ptZMbifzFpckz6fVhXw6JRDNMZHQMcUFSac7P7hV2B+6BW0QNx8LVDmpkLtnU
         t6WZA4UK3ewpf4mlGaDLz0VOVNoHa9c9MeO11rpUuaJRmvtz9O0s1QcawzIRiXJYZ105
         hUs6EWK2omKS3324MqgQL/fhFh4IxNnscMe99QwS1STtdUdbQwECUlUWJXb/h0mFnbbC
         ghubtLfbv5kGZBN/oQbHAAarGUR3KPOIr5ghC29gmE0+nuy4NhTk73EbavQvSq9NhT4X
         aEfRku3OP9Pve115fmeqcfIsf6fK0BbRzZ1mjiXxRDAyJaH8gAbENtBHjq23FnBGGt3l
         K+bQ==
X-Gm-Message-State: ABy/qLaeFveDziw3QZ0Vw6iqZIEEdvN16PabtEgzkxzh7C1pLfy0fKF+
	7ON0FQrZYDNru6bfoeva5V4L2qWOb5ZYvw==
X-Google-Smtp-Source: APBJJlH1CFGLNSFTGyV2SUQN+RM8iK0bqB/oI1q/pSBl8NMm2nUCn5TVmcOlDB+vB6NhIf4ErmRrQuehTBulzw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:ad4:5503:0:b0:635:ec4c:975d with SMTP id
 pz3-20020ad45503000000b00635ec4c975dmr94592qvb.1.1689802153369; Wed, 19 Jul
 2023 14:29:13 -0700 (PDT)
Date: Wed, 19 Jul 2023 21:28:51 +0000
In-Reply-To: <20230719212857.3943972-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230719212857.3943972-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230719212857.3943972-6-edumazet@google.com>
Subject: [PATCH net 05/11] tcp: annotate data-races around tp->keepalive_probes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

do_tcp_getsockopt() reads tp->keepalive_probes while another cpu
might change its value.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h | 9 +++++++--
 net/ipv4/tcp.c    | 5 +++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 79af16a4028665d51f6ea5f1a4382265b8163309..855dbe72e431776257037d75e32037b44905453c 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1531,9 +1531,14 @@ static inline int keepalive_time_when(const struct tcp_sock *tp)
 static inline int keepalive_probes(const struct tcp_sock *tp)
 {
 	struct net *net = sock_net((struct sock *)tp);
+	int val;
+
+	/* Paired with WRITE_ONCE() in tcp_sock_set_keepcnt()
+	 * and do_tcp_setsockopt().
+	 */
+	val = READ_ONCE(tp->keepalive_probes);
 
-	return tp->keepalive_probes ? :
-		READ_ONCE(net->ipv4.sysctl_tcp_keepalive_probes);
+	return val ? : READ_ONCE(net->ipv4.sysctl_tcp_keepalive_probes);
 }
 
 static inline u32 keepalive_time_elapsed(const struct tcp_sock *tp)
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index d55fe014e7c902859243cdb619d94a230e44f708..574fd0da167339512077c36958578fde2b1181e8 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3357,7 +3357,8 @@ int tcp_sock_set_keepcnt(struct sock *sk, int val)
 		return -EINVAL;
 
 	lock_sock(sk);
-	tcp_sk(sk)->keepalive_probes = val;
+	/* Paired with READ_ONCE() in keepalive_probes() */
+	WRITE_ONCE(tcp_sk(sk)->keepalive_probes, val);
 	release_sock(sk);
 	return 0;
 }
@@ -3565,7 +3566,7 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		if (val < 1 || val > MAX_TCP_KEEPCNT)
 			err = -EINVAL;
 		else
-			tp->keepalive_probes = val;
+			WRITE_ONCE(tp->keepalive_probes, val);
 		break;
 	case TCP_SYNCNT:
 		if (val < 1 || val > MAX_TCP_SYNCNT)
-- 
2.41.0.255.g8b1d071c50-goog


