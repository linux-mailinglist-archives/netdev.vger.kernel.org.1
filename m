Return-Path: <netdev+bounces-16886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C386C74F4A5
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 18:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54DA41C20EDE
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 16:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C99F19BDB;
	Tue, 11 Jul 2023 16:15:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D4218AFE
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 16:15:22 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A450170A
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 09:15:19 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99313a34b2dso686341666b.1
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 09:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1689092117; x=1691684117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0cPI8Zq0PeegUi44hkwFDNWJ9aJ3HVoZc/kLcQkpf4=;
        b=UuD8b+Afj9oDvXQEwsLdh6bNZbU5rx8jYmvqtU7VORiVL9R/oX7NzGZJhYCqpd7LRU
         RMZ4psdDy39BM26u+YM9UyVJUIITTEdeBE2HshuXlY/5/T7uCwIReB1KUeS0+OUTdO3f
         XJS6BuPYccXg3zKRC0EW8rvRtEyUPmRDMuuZ4FYziBxY3OqPYakIwzuSvT/lx1n+yr+0
         AAuLAY2175VPPwnLh1YxdFYVZ1aqt83GSGkH33DBYkTMFSaj47/Ij13OsDIo2rh3q6K2
         rM3xeYRk7MzMvAt33Kd+/8lYusal4Y05a0KOr4nfVX2fDwQFBhkaR7RoNFSyyEoZZxXF
         owKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689092117; x=1691684117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0cPI8Zq0PeegUi44hkwFDNWJ9aJ3HVoZc/kLcQkpf4=;
        b=b/OTaqCCoBHSkOIRR05Ed+4QS23DYCCFDGGBeId7iF4W0sHYDHtRosXQimCi53ni9r
         FyCl47QxCWiX91QYCPpwzVd7bg67p7/HusVLwP/aDjqXFn2ncii/WmkOSxBVfXGQe4R9
         lgDzdKOtGFvzVtGTgxgVgUpXPcs7ZBvgK1YMN69ML3lxELG+rS3kVX3tsoHHwyX0sTex
         uhBHsnsn6Rd2HUEoHLOtcDam/qKHFSYEpV0jahyDBd1dPNYVp1JIH4A7dsymm+VnU5a7
         TcM3ueP0i2n2M52B6v8lC5V3dev0Ubg3ldVQqEbvh6Mo9qqWCOFxgfYbBQWEgNgAZ7cI
         nGFA==
X-Gm-Message-State: ABy/qLaovlDjCehAASsfVwkTaTQAXAtw1vd/jNKk0ohPjZjCSbyrLg5q
	d26X0DO47ordmwCzX4zpcpjem3ac7ucarvQ6PocL0g==
X-Google-Smtp-Source: APBJJlGXOjWPnshsxM3cflnDdAoKzmU0dGcvL7PnEhcWaR8Lg6sC3dcHMdy6YJfU/8Us0J91zcM6RceD9a9eOwGczcY=
X-Received: by 2002:a17:906:21a:b0:994:1ef9:91dc with SMTP id
 26-20020a170906021a00b009941ef991dcmr1792295ejd.15.1689092117275; Tue, 11 Jul
 2023 09:15:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230613-so-reuseport-v5-0-f6686a0dbce0@isovalent.com> <20230613-so-reuseport-v5-6-f6686a0dbce0@isovalent.com>
In-Reply-To: <20230613-so-reuseport-v5-6-f6686a0dbce0@isovalent.com>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Tue, 11 Jul 2023 17:15:06 +0100
Message-ID: <CAN+4W8gs84r+PVWgMbic29Opj2EviNMh7AzcP=BR3CLvYHiQWg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 6/7] bpf, net: Support SO_REUSEPORT sockets
 with bpf_sk_assign
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Joe Stringer <joe@wand.net.nz>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Hemanth Malla <hemanthmalla@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Joe Stringer <joe@cilium.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 4, 2023 at 2:46=E2=80=AFPM Lorenz Bauer <lmb@isovalent.com> wro=
te:
>
> +static inline
> +struct sock *inet6_steal_sock(struct net *net, struct sk_buff *skb, int =
doff,
> +                             const struct in6_addr *saddr, const __be16 =
sport,
> +                             const struct in6_addr *daddr, const __be16 =
dport,
> +                             bool *refcounted, inet6_ehashfn_t *ehashfn)
> +{
> +       struct sock *sk, *reuse_sk;
> +       bool prefetched;
> +
> +       sk =3D skb_steal_sock(skb, refcounted, &prefetched);
> +       if (!sk)
> +               return NULL;
> +
> +       if (!prefetched)
> +               return sk;
> +
> +       if (sk->sk_protocol =3D=3D IPPROTO_TCP) {
> +               if (sk->sk_state !=3D TCP_LISTEN)
> +                       return sk;
> +       } else if (sk->sk_protocol =3D=3D IPPROTO_UDP) {
> +               if (sk->sk_state !=3D TCP_CLOSE)
> +                       return sk;
> +       } else {
> +               return sk;
> +       }
> +
> +       reuse_sk =3D inet6_lookup_reuseport(net, sk, skb, doff,
> +                                         saddr, sport, daddr, ntohs(dpor=
t),
> +                                         ehashfn);
> +       if (!reuse_sk)
> +               return sk;
> +
> +       /* We've chosen a new reuseport sock which is never refcounted. T=
his
> +        * implies that sk also isn't refcounted.
> +        */
> +       WARN_ON_ONCE(*refcounted);
> +
> +       return reuse_sk;
> +}

Hi Kuniyuki,

Continuing the conversation from v5 of the patch set, you wrote:

In inet6?_steal_sock(), we call inet6?_lookup_reuseport() only for
sk that was a TCP listener or UDP non-connected socket until just before
the sk_state checks.  Then, we know *refcounted should be false for such
sockets even before inet6?_lookup_reuseport().

This makes sense for me in the TCP listener case. I understand UDP
less, so I'll have to rely on your input. I tried to convince myself
that all UDP sockets in TCP_CLOSE have SOCK_RCU_FREE set. However, the
only place I see sock_set_flag(sk, SOCK_RCU_FREE) in the UDP case is
in udp_lib_get_port(). That in turn seems to be called during bind.
So, what if BPF does bpf_sk_assign() of an unbound and unconnected
socket? Wouldn't that trigger the warning?

To maybe sidestep this question: do you think the location of the
WARN_ON_ONCE has to prevent this patch set from going in? I've been
noodling at it for quite a while already and it would be good to see
it land.

Thanks

Lorenz

