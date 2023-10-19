Return-Path: <netdev+bounces-42584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4E97CF6A6
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 13:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6871E281F87
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 11:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABB519457;
	Thu, 19 Oct 2023 11:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0+depZFx"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A947219452
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 11:25:01 +0000 (UTC)
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD62813A
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 04:24:59 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id d75a77b69052e-41b83b8dbe1so30423121cf.1
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 04:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697714699; x=1698319499; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uiLT4tDlDqX86Iu+wnfOwZeKpJFfEFGhGUw8sUPj5Ok=;
        b=0+depZFxPuXoeudRbnmh55umGOpoZwAI3OqtlxNbTARMhOP2YhURjbhzArtaNgSppC
         SGkxeRazb5H+mrbUswTc7qXWibMNLX85YU4aJQFy4KdBooHR4hK8/yr4rLLwnMJQqPTM
         NmF7tzVdJ243W8WQeKgoxjKnZF5IjW97nWaWA0pjWTw9RorlW6OF1xfEg//mOZtVi9cD
         bECz5ZsNvCojELBdABRldNa19Wy7NYuqi2QMpeupAeLRqGaGn+Y93UxQM5rBzB+rsLMD
         0tnG5AnfGujbgD98DgZwEuj0LJtsTB3RxuHp6ALp+NPT1ayTY7nypalSXoBPT9mATvw4
         gbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697714699; x=1698319499;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uiLT4tDlDqX86Iu+wnfOwZeKpJFfEFGhGUw8sUPj5Ok=;
        b=GukMPhpqt11APF1ptHo81BOJUYel1BIRffLh4szizzeVwyTvqvXkfNCfwLf6H5xrSa
         uzyOaxDmf1WCrD5Nmj1n420SfKDY10G5K1NrQ6Z5MhOrjpw9ztgiUWXbuqw0NWlEAz38
         UGjvb5XAHdjQb4VjbJFel4JvAGECQyf0NBZkkkWxeKwwZWPDt5s+1ciux5hXhaKm2BZr
         pJ2MbQIevvg/NlXnGuMiqHC03xM1CV/FVRSCwUEe2DpAwKYr4SGM0kDEUN4uyqZUiN2b
         7u/nNdCQHKrq/WQUrxCn6B170o1UDAYUwnuSocWbCfuz96RqH/EoOAEzP+G1Lzl43wm0
         wV/g==
X-Gm-Message-State: AOJu0YyQ55VRD3y+cUgw1Xxtt62SBEwb4ksNyKKBwGEaYAu6/B6L6jSM
	v/o9xnvEemVcD1z/fekUtw48BfgiK1dscA==
X-Google-Smtp-Source: AGHT+IGV9tlAKmvJ2SnzccC5mTFi1pW3X5wlPzb/MAXv0sPnDGiTotg42SbDY2uaCpTlZ5P/yXR2fPuHDkx8wQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:ac8:4586:0:b0:410:a249:bee5 with SMTP id
 l6-20020ac84586000000b00410a249bee5mr30907qtn.9.1697714699017; Thu, 19 Oct
 2023 04:24:59 -0700 (PDT)
Date: Thu, 19 Oct 2023 11:24:57 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231019112457.1190114-1-edumazet@google.com>
Subject: [PATCH v2 net] net: do not leave an empty skb in write queue
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"

Under memory stress conditions, tcp_sendmsg_locked()
might call sk_stream_wait_memory(), thus releasing the socket lock.

If a fresh skb has been allocated prior to this,
we should not leave it in the write queue otherwise
tcp_write_xmit() could panic.

This apparently does not happen often, but a future change
in __sk_mem_raise_allocated() that Shakeel and others are
considering would increase chances of being hurt.

Under discussion is to remove this controversial part:

    /* Fail only if socket is _under_ its sndbuf.
     * In this case we cannot block, so that we have to fail.
     */
    if (sk->sk_wmem_queued + size >= sk->sk_sndbuf) {
        /* Force charge with __GFP_NOFAIL */
        if (memcg_charge && !charged) {
            mem_cgroup_charge_skmem(sk->sk_memcg, amt,
                gfp_memcg_charge() | __GFP_NOFAIL);
        }
        return 1;
    }

Fixes: fdfc5c8594c2 ("tcp: remove empty skb from write queue in error cases")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Shakeel Butt <shakeelb@google.com>
---
v2: call tcp_remove_empty_skb() before tcp_push()

 net/ipv4/tcp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index d3456cf840de35b28a6adb682e27d426b0a60f84..3d3a24f795734eecd60fc761f25f48b7a27714d4 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -927,10 +927,11 @@ int tcp_send_mss(struct sock *sk, int *size_goal, int flags)
 	return mss_now;
 }
 
-/* In some cases, both sendmsg() could have added an skb to the write queue,
- * but failed adding payload on it.  We need to remove it to consume less
+/* In some cases, sendmsg() could have added an skb to the write queue,
+ * but failed adding payload on it. We need to remove it to consume less
  * memory, but more importantly be able to generate EPOLLOUT for Edge Trigger
- * epoll() users.
+ * epoll() users. Another reason is that tcp_write_xmit() does not like
+ * finding an empty skb in the write queue.
  */
 void tcp_remove_empty_skb(struct sock *sk)
 {
@@ -1289,6 +1290,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 
 wait_for_space:
 		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+		tcp_remove_empty_skb(sk);
 		if (copied)
 			tcp_push(sk, flags & ~MSG_MORE, mss_now,
 				 TCP_NAGLE_PUSH, size_goal);
-- 
2.42.0.655.g421f12c284-goog


