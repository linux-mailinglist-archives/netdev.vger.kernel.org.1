Return-Path: <netdev+bounces-19550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEB775B2B9
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 17:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1BD81C214CA
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 15:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D8418C32;
	Thu, 20 Jul 2023 15:31:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA9918C20
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 15:31:00 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F312D2D4E
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 08:30:48 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99313a34b2dso142894566b.1
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 08:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1689867047; x=1690471847;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7e9oh+9LnMfaXU1MFDWJ7nss1s82p+q6AYSCKvh2eww=;
        b=biegx0KiRjSA4nZtnuMMsITXNs7RAZ2ClIwyPfZzvakWr34l+F/bq4o5L7cjfBdVnU
         49XFgZDMNPsCw3OnuVfO0UTB+OFH6J+QH80U+zE99E4M5odDM4/YmE3x2JwErWG0NYLO
         PO6eo+Uxi8IPtVwXvV+GFgXZdCm8ycUEiT01IhDruhHN3zmi0lfjPVylf3X/s2EJUFvQ
         R4aCuRAtKXQPBxTxDWSBdbBr38PQWaHsUWlcKHg8Nd7SBU/3yj+X/LYjZoubwAwfuIdW
         OkCXXRvNSrW8wYMUBUJSpoHGwFDs0syscCba8bmwSsw2Olvfvf72VF2lR/SZRkxj84ax
         qwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689867047; x=1690471847;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7e9oh+9LnMfaXU1MFDWJ7nss1s82p+q6AYSCKvh2eww=;
        b=fziPxcRlBfYNyuWMd2aDp0NSqis8ME0bv4H3l9Edr6MykuPiGX1be+OS8eJlVg4Yzo
         QaAlpEqzZLOmw9CA+uBdwMdIDEunvhfg+5/XiY3BxCBd5A+w2q0Tq4TFSfA+P9gCnm/c
         rq4OmdGB7f6ujJ/zCZvt488L2E0AzsV5zXNK1Ncbpvc0MYIJiWP1PRFIwTMLccVUUScF
         xTohRrLaxFap4TzD22Ysy1ADJqOYS4tU6R4MEVjQ+Ay5Iw2CrdrEi76wpDrSMxNhWWgp
         tM0PsRl/UBGU++1pEElyfyIFrFJBguNWzTYmcifSnu+aRn5rqzsjCsOoRxhulQ4SatKv
         FcSQ==
X-Gm-Message-State: ABy/qLYk3AaP/t1xy6QvevO2dle0n4xxCqgIkpuQIQ9MB/3p7LJDKWwR
	UzaurSLwmOOuGJ2ybFDe6f4a+Q==
X-Google-Smtp-Source: APBJJlENGdJS+typQZ+t3KY8DaWXkzQoF441OBU2uObBSsVHMzW7z6B+7SsFtf72iKkx72cKfiUdGw==
X-Received: by 2002:a17:906:5345:b0:993:f996:52cf with SMTP id j5-20020a170906534500b00993f99652cfmr5550063ejo.28.1689867047000;
        Thu, 20 Jul 2023 08:30:47 -0700 (PDT)
Received: from [192.168.188.151] (p200300c1c7176000b788d2ebe49c4b82.dip0.t-ipconnect.de. [2003:c1:c717:6000:b788:d2eb:e49c:4b82])
        by smtp.gmail.com with ESMTPSA id x10-20020a170906804a00b009893b06e9e3sm851007ejw.225.2023.07.20.08.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 08:30:46 -0700 (PDT)
From: Lorenz Bauer <lmb@isovalent.com>
Date: Thu, 20 Jul 2023 17:30:06 +0200
Subject: [PATCH bpf-next v6 2/8] bpf: reject unhashed sockets in
 bpf_sk_assign
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230720-so-reuseport-v6-2-7021b683cdae@isovalent.com>
References: <20230720-so-reuseport-v6-0-7021b683cdae@isovalent.com>
In-Reply-To: <20230720-so-reuseport-v6-0-7021b683cdae@isovalent.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, 
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Joe Stringer <joe@wand.net.nz>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Hemanth Malla <hemanthmalla@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Lorenz Bauer <lmb@isovalent.com>, 
 Joe Stringer <joe@cilium.io>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The semantics for bpf_sk_assign are as follows:

    sk = some_lookup_func()
    bpf_sk_assign(skb, sk)
    bpf_sk_release(sk)

That is, the sk is not consumed by bpf_sk_assign. The function
therefore needs to make sure that sk lives long enough to be
consumed from __inet_lookup_skb. The path through the stack for a
TCPv4 packet is roughly:

  netif_receive_skb_core: takes RCU read lock
    __netif_receive_skb_core:
      sch_handle_ingress:
        tcf_classify:
          bpf_sk_assign()
      deliver_ptype_list_skb:
        deliver_skb:
          ip_packet_type->func == ip_rcv:
            ip_rcv_core:
            ip_rcv_finish_core:
              dst_input:
                ip_local_deliver:
                  ip_local_deliver_finish:
                    ip_protocol_deliver_rcu:
                      tcp_v4_rcv:
                        __inet_lookup_skb:
                          skb_steal_sock

The existing helper takes advantage of the fact that everything
happens in the same RCU critical section: for sockets with
SOCK_RCU_FREE set bpf_sk_assign never takes a reference.
skb_steal_sock then checks SOCK_RCU_FREE again and does sock_put
if necessary.

This approach assumes that SOCK_RCU_FREE is never set on a sk
between bpf_sk_assign and skb_steal_sock, but this invariant is
violated by unhashed UDP sockets. A new UDP socket is created
in TCP_CLOSE state but without SOCK_RCU_FREE set. That flag is only
added in udp_lib_get_port() which happens when a socket is bound.

When bpf_sk_assign was added it wasn't possible to access unhashed
UDP sockets from BPF, so this wasn't a problem. This changed
in commit 0c48eefae712 ("sock_map: Lift socket state restriction
for datagram sockets"), but the helper wasn't adjusted accordingly.
The following sequence of events will therefore lead to a refcount
leak:

1. Add socket(AF_INET, SOCK_DGRAM) to a sockmap.
2. Pull socket out of sockmap and bpf_sk_assign it. Since
   SOCK_RCU_FREE is not set we increment the refcount.
3. bind() or connect() the socket, setting SOCK_RCU_FREE.
4. skb_steal_sock will now set refcounted = false due to
   SOCK_RCU_FREE.
5. tcp_v4_rcv() skips sock_put().

Fix the problem by rejecting unhashed sockets in bpf_sk_assign().
This matches the behaviour of __inet_lookup_skb which is ultimately
the goal of bpf_sk_assign().

Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
Cc: Joe Stringer <joe@cilium.io>
Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
 net/core/filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 797e8f039696..b5b51ef48c5f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7353,6 +7353,8 @@ BPF_CALL_3(bpf_sk_assign, struct sk_buff *, skb, struct sock *, sk, u64, flags)
 		return -ENETUNREACH;
 	if (unlikely(sk_fullsock(sk) && sk->sk_reuseport))
 		return -ESOCKTNOSUPPORT;
+	if (sk_unhashed(sk))
+		return -EOPNOTSUPP;
 	if (sk_is_refcounted(sk) &&
 	    unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
 		return -ENOENT;

-- 
2.41.0


