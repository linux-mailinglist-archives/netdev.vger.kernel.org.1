Return-Path: <netdev+bounces-46708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4665B7E5FC9
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 22:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A27AF280F29
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 21:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F89032C80;
	Wed,  8 Nov 2023 21:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gcQWbgqn"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8676374C8
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 21:13:28 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5C22102
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 13:13:28 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da2b87dd614so187843276.2
        for <netdev@vger.kernel.org>; Wed, 08 Nov 2023 13:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699478007; x=1700082807; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p3r/YXmjVkMwD+ikAEvppZ37LMLhvs43OdVVk7KFtJc=;
        b=gcQWbgqnzmOkR6txPcAEfCUIq7a3ZEH2tuJEQzJLG0Hyc+7k8fGJbQmNlXOWUm7BJe
         7h/mEwXgudq/kRTspPUhddQ+TR75KsrHVd5VWBQS4ytXpGOVXNE2NEK2oiPhEAbAvKhS
         /kjvaOPPRYNh6gkTJmHTAl8h+90RXidO2akrNxEsM/ZYkahaLCrdJDDErtw2UJdjsk8P
         DFPfJ9ZaDx9GtwiBg8ss92fpT2YaIQo5UczoUZhk6u5mEYgoCR4ZbD3augvvIduiJLwk
         N7bbyOLvEalwQNUnE1/HOIKgQwK4MJeCa9NdUTq4e4Z9/z3+lxn1ETIVp3LMyrKpC0AI
         4Peg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699478007; x=1700082807;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p3r/YXmjVkMwD+ikAEvppZ37LMLhvs43OdVVk7KFtJc=;
        b=n9Fud+bipBs1LT1iybyP3Ikvf0zo5s6gWulfropY7hoUnwCDNYR+iHMBP7cLDrbKnU
         fRRll19SPCubAkARSjO67j45VqfRBnA6ZFDNjTBoyegODgEQwTmhrypg/6cxhnJetE+w
         4/Tx1z/hGlBCjSQTu4Hv6RHLHLfKXru3MVZ4GcJCl8jYMBCOF401/7QcNUoNgenMZGO+
         KvKZhyWwdnjDhe8JnTVfM2+KLvsF+R8483S9/o4nPbecwQNehS6T+xHrkyOXzGgMfln+
         Q+TmOWrArnIsVX8b2/3wkGZ9tTWELmoD11GBwHqyrSPbPC6+hpKi3EGfmPX09fjyyWih
         fWXQ==
X-Gm-Message-State: AOJu0Yw6odbeJB2L0zyCQXL6zA7z5qXUlT82Cqb2Qiexs58+gUftUdFE
	mtQNo0ld6PoonsPf0a+Xbd/LYbohmlmb1kWYMATeoa0MeoGatqSfJnumBKdwakuzqv5yzR2WtPr
	ym/BBqM/Q7uO+iKEATi2fh3XSokdcmIOoUumtqzgiEyd67puqteYMrg==
X-Google-Smtp-Source: AGHT+IGqLBAB3R8V9OoSsZ0jXRVZolsHr9fwSwaUvmAJbpZJirwPgaa/MVrwNcdqXbALS7RP5qY/Nmk=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:285:b0:d9a:f3dc:7d18 with SMTP id
 v5-20020a056902028500b00d9af3dc7d18mr73658ybh.13.1699478007382; Wed, 08 Nov
 2023 13:13:27 -0800 (PST)
Date: Wed,  8 Nov 2023 13:13:25 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231108211325.18938-1-sdf@google.com>
Subject: [PATCH net v2] net: set SOCK_RCU_FREE before inserting socket into hashtable
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

__inet_hash can race with lockless (rcu) readers on the other cpus:

  __inet_hash
    __sk_nulls_add_node_rcu
    <- (bpf triggers here)
    sock_set_flag(SOCK_RCU_FREE)

Let's move the SOCK_RCU_FREE part up a bit, before we are inserting
the socket into hashtables. Note, that the race is really harmless;
the bpf callers are handling this situation (where listener socket
doesn't have SOCK_RCU_FREE set) correctly, so the only
annoyance is a WARN_ONCE.

More details from Eric regarding SOCK_RCU_FREE timeline:

Commit 3b24d854cb35 ("tcp/dccp: do not touch listener sk_refcnt under
synflood") added SOCK_RCU_FREE. At that time, the precise location of
sock_set_flag(sk, SOCK_RCU_FREE) did not matter, because the thread calling
__inet_hash() owns a reference on sk. SOCK_RCU_FREE was only tested
at dismantle time.

Commit 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
started checking SOCK_RCU_FREE _after_ the lookup to infer whether
the refcount has been taken care of.

Fixes: 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
Reviewed-by: Eric Dumazet <edumazet@google.com>
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


