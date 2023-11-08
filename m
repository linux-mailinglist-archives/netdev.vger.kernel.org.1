Return-Path: <netdev+bounces-46699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B72647E5F26
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 21:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F805B20CE0
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 20:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1651537175;
	Wed,  8 Nov 2023 20:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MnzUy7B2"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC6437165
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 20:28:22 +0000 (UTC)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12353213B
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 12:28:22 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-6bfd5856509so76983b3a.1
        for <netdev@vger.kernel.org>; Wed, 08 Nov 2023 12:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699475301; x=1700080101; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nJ7dhVrvftTSGMishXKG7UPJ2Zh5KwTGEHl/0K/q/64=;
        b=MnzUy7B2dT9izmCakZ/o9y+ufxTw6PLngLWOgOrdckh3hr4iLS3FTuz2CtgSaS381+
         6MHj3dI+qSSaXK/eHnoC9KZ1DmiAHrwf5fVeUZT8eh+Y34R9c+H/yh++DxDcm8GRd3e/
         Hb3cXlIdzl4Qa2qTIhCBDMnN5di9BPA6xrMJdvFTr3YuBRGBDk3URwjkWKdVclFkIYcD
         S99hYx+ZmkKyMxdH11dXyOg8fe/BCG1K4bUS3dReF9UIj/hHrA03O/J3fZmHOcCskb4h
         yx+p8QurVKXRgNoGLX3QIsFW+tE+CAfpSsLm1BXxU/a2Zsdkd+tj/hxqg8bzSICo8nLg
         c2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699475301; x=1700080101;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nJ7dhVrvftTSGMishXKG7UPJ2Zh5KwTGEHl/0K/q/64=;
        b=aiIEIplM2iOYMb563FjGmsb98Dk/h4AsHx/BfUqWs20yZuIwydQeMDA/yGVgDfotm+
         oVME67bfXgP9xWX2zJAuVBAvE7x2EYfiPvQ1lWBsTi2s8qncqwk9Nmuj9EaxOmqijTbH
         eMFOQa6x6CGAQWnSTz6u8ml4pK8XT1F0jlYWcerO6ZvCFZRb6xRBrO429kbwM0bG+rUv
         OGwzu5TCgD9ayfN+gx6vF4I8Q3qyfTCVMyjEu7b5i1rwgUJnUGg75QrS25YJ8l9k+Mri
         /yHoJp7QfMr+0NDD0nSXFKbVzpV4/oqR4zFbq8SNVzduweFe81gAbr6vseBVrkiWKH1A
         Mh7Q==
X-Gm-Message-State: AOJu0YxhidHSqmtJS/8vd9pZYKaIT7so/uV77EjguTzBdX7XLMuwc+Hz
	DIezhDRvgvB5ZJk7c4KrCoe+/R3f3QaMYpnH0HIW94X0cIY6X0Op5xrUykpBcvlYAETnPtGlrkQ
	m8X+Ag/f/kLeTBcLqR+217WeNVd5PGw6nk3SJrzenlymUDcPt7P8YLw==
X-Google-Smtp-Source: AGHT+IErqP1X3lNdSHTKHqxL90uuypvWnFzYs9btcEfPoG4V9UEYt+O0dvmgx3/NKIw0ou9a/IQk+zo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:2141:b0:6c3:9efc:683f with SMTP id
 o1-20020a056a00214100b006c39efc683fmr69850pfk.0.1699475301443; Wed, 08 Nov
 2023 12:28:21 -0800 (PST)
Date: Wed,  8 Nov 2023 12:28:19 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231108202819.1932920-1-sdf@google.com>
Subject: [PATCH net] net: set SOCK_RCU_FREE before inserting socket into hashtable
From: Stanislav Fomichev <sdf@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"

We've started to see the following kernel traces:

 WARNING: CPU: 83 PID: 0 at net/core/filter.c:6641 sk_lookup+0x1bd/0x1d0

 Call Trace:
  <IRQ>
  __bpf_skc_lookup+0x10d/0x120
  bpf_sk_lookup+0x48/0xd0
  bpf_sk_lookup_tcp+0x19/0x20
  bpf_prog_<redacted>+0x37c/0x16a3
  cls_bpf_classify+0x205/0x2e0
  tcf_classify+0x92/0x160
  __netif_receive_skb_core+0xe52/0xf10
  __netif_receive_skb_list_core+0x96/0x2b0
  napi_complete_done+0x7b5/0xb70
  <redacted>_poll+0x94/0xb0
  net_rx_action+0x163/0x1d70
  __do_softirq+0xdc/0x32e
  asm_call_irq_on_stack+0x12/0x20
  </IRQ>
  do_softirq_own_stack+0x36/0x50
  do_softirq+0x44/0x70

I'm not 100% what is causing them. It might be some kernel change or
new code path in the bpf program. But looking at the code,
I'm assuming the issue has been there for a while.

__inet_hash can race with lockless (rcu) readers on the other cpus:

  __inet_hash
    __sk_nulls_add_node_rcu
    <- (bpf triggers here)
    sock_set_flag(SOCK_RCU_FREE)

Let's move the SOCK_RCU_FREE part up a bit, before we are inserting
the socket into hashtables. Note, that the race is really harmless;
the bpf callers are handling this situation (where listener socket
doesn't have SOCK_RCU_FREE set) correctly, so the only
annoyance is a WARN_ONCE (so not 100% sure whether it should
wait until net-next instead).

For the fixes tag, I'm using the original commit which added the flag.

Fixes: 3b24d854cb35 ("tcp/dccp: do not touch listener sk_refcnt under synflood")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 net/ipv4/inet_hashtables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 598c1b114d2c..a532f749e477 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -751,12 +751,12 @@ int __inet_hash(struct sock *sk, struct sock *osk)
 		if (err)
 			goto unlock;
 	}
+	sock_set_flag(sk, SOCK_RCU_FREE);
 	if (IS_ENABLED(CONFIG_IPV6) && sk->sk_reuseport &&
 		sk->sk_family == AF_INET6)
 		__sk_nulls_add_node_tail_rcu(sk, &ilb2->nulls_head);
 	else
 		__sk_nulls_add_node_rcu(sk, &ilb2->nulls_head);
-	sock_set_flag(sk, SOCK_RCU_FREE);
 	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 unlock:
 	spin_unlock(&ilb2->lock);
-- 
2.42.0.869.gea05f2083d-goog


