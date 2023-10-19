Return-Path: <netdev+bounces-42545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38C07CF495
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 12:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E50151C20A22
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 10:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3881A17985;
	Thu, 19 Oct 2023 10:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ck2Oc8B6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C5814F90
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:02:41 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B67AB8
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 03:02:40 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a818c1d2c7so102617667b3.0
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 03:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697709759; x=1698314559; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XXej4bLFXi2dtVQl8h2CdM3Z6BqazTAm6S6SBKZ+9pw=;
        b=Ck2Oc8B6so8iDISCrY7pcUmWLBS0xk2mzJVIXkL7u+xQ3eBp1HE1V70BCGSv9dLz/e
         gEi2LT9y5wAB7PfCbEnxMvi0eLjc//pMnizkCybT00K0YYd3hjqaHget3SMbkgR9Mmcc
         T/EGR5Lonv6asWMJMtIWsTtaP+6ztRe+a62fayaD3aA3BgTPRXNIfjMI0KR+1jZUFCx6
         hpYHGD8EnYi31CbtCoETJWTEjh8y2rg6RbBJh+5La253hR+6AQwvP0OHXRZbvfmDErXC
         TxT/oeH4c+k1FPkqlHUIuqsb4OFZicPVj68ncIihuHATKKGUukEQNT6JlEA5xwXRMA5O
         VvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697709759; x=1698314559;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XXej4bLFXi2dtVQl8h2CdM3Z6BqazTAm6S6SBKZ+9pw=;
        b=nNv1wXzQc/q8n6D55UxBlp5eLnJdD2ILpHV4DWVCQtk5Slv8Yf/wXNUT22wily6kjk
         y2BfcwReQ/eMo9KHNpjoFNX1jhfX/3rMINPjNx6ksa5LgLYanXAJ6oRIwoK8MC2aQak8
         7WzliD5ZBzVjEo+MOC3/obyfKYmPajBowafHeIxEfbh5dVf2MEVxrRSTeL4Iu31WsaqK
         BbRGDOwuKH7lTXPJX/rNXvahznhamSDJJIB9tJQaxBkd8hjjIjPQTYHhys7AVr2+tokT
         Ou/iQYe1Kf30Q+4+cpO33UuZR7pHKI5bW4KV59UKY8ogITwKxO/RtciNiq8Znaefi+bL
         /NqQ==
X-Gm-Message-State: AOJu0YyJYVK0YHVzC0ugNK2uE0owmgE2PMMgASbsFuJuKveOr2aYA5B1
	elgQYhhhrTGVQoCPCxYRbayP4uZ3+WJUQw==
X-Google-Smtp-Source: AGHT+IG0UEV8CYEimESFcWQQfGu0VqSHiRz1W1aG0bbRibXdNi85lRhX5VZ0rTS9MwxHACRhXUgNQCazaxUrfA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:6c4f:0:b0:592:8069:540a with SMTP id
 h76-20020a816c4f000000b005928069540amr37291ywc.8.1697709759352; Thu, 19 Oct
 2023 03:02:39 -0700 (PDT)
Date: Thu, 19 Oct 2023 10:02:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231019100237.1118733-1-edumazet@google.com>
Subject: [PATCH net] net: do not leave an empty skb in write queue
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
 net/ipv4/tcp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index d3456cf840de35b28a6adb682e27d426b0a60f84..a9a49e1d3da11bc6f9ed3baad5dd581400d50c69 100644
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
@@ -1293,6 +1294,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 			tcp_push(sk, flags & ~MSG_MORE, mss_now,
 				 TCP_NAGLE_PUSH, size_goal);
 
+		tcp_remove_empty_skb(sk);
 		err = sk_stream_wait_memory(sk, &timeo);
 		if (err != 0)
 			goto do_error;
-- 
2.42.0.655.g421f12c284-goog


