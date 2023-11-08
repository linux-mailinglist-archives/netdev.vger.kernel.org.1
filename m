Return-Path: <netdev+bounces-46703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C7F7E5F8A
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 21:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA75EB20CE9
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 20:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0258636B0F;
	Wed,  8 Nov 2023 20:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gPWDyA6I"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667AB32C80
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 20:58:23 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEE42113
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 12:58:22 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54366bb1c02so340a12.1
        for <netdev@vger.kernel.org>; Wed, 08 Nov 2023 12:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699477101; x=1700081901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PY7xmBs42iykszqt8y/IvRxSzSu34bDZ+s2XJ6E9Ges=;
        b=gPWDyA6ISTiIlRMZvhIzjiHCRopHfxrIBDiBLa7ZyzNOpF8MXUZ67TWKMVT+au0aVr
         fGy/B+dCusqIJN3UhgKMUA6PsawIl+WJ8bKI/IL3J2SJgsrCCFEwwoIYaZdNHC+BF3wg
         VBYL2AxOjavKikGIgHOVC91RaahkHkvKrllsowA17P4zgkLApAqdWix/pMWDDSN0Zxb2
         iLYrBbxcFy7NLKiEyOsMypGPxQIBZ9qFz9dPMaBj1xGauMMwW+ARN89QOrtppQkdlEGW
         0yrez8oT3BhK6+Qw3O3TX7zfu+J40ReICbL8xivlDnX9g7GhhbwLZig5o7vBj7OqgLbA
         LAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699477101; x=1700081901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PY7xmBs42iykszqt8y/IvRxSzSu34bDZ+s2XJ6E9Ges=;
        b=A+9vIQ2qJAWQGoIUSu61rzcSrxAuaSIDL66uyOFXzPjJuT1XBtmShg8SNIsMBsh9bm
         GtWYnKCgKtcVyyQD9FAagHl25Gah6yLqbjMMr8vE/BtA3OAmiL+a+rnTLdm0uUcGl7SF
         AedRWfwSjLVmasOJQQVGGsS8W2kTnjDitJmdfDuEYCQtiqTYlmiL7LF/fpP2Inyxr1mh
         nzk2ayu/uuM6gR8qFhc5zMUiUQBqaYDYo7S9ShB41J35lOeQmCBQsWGHW4YyRkEl9IkD
         Ef617t4TU8y9Yk3mDVztn8aNwnQNlTAToWULsFmbUXfBiSQyU/fZ/C4wsytoRcTz/wRX
         ACRw==
X-Gm-Message-State: AOJu0YwSd/yRdpZgxG195LREKvmzbzSBCx3JF9ZFbJLe1dnzUfSKSb19
	grL9zvbdgjLdG/aC0LOmBK6QBm4OBVLmznq/MveDpwtMijxpl/x7QG264A==
X-Google-Smtp-Source: AGHT+IHkS5WFlz6y7JL+EHyIWhsqK0l51juTDHNB8vV5XNeeGNNiVbcX7iBd4GFut0AaYU9Yi2C/Ovb8j6oHn27rG4o=
X-Received: by 2002:a05:6402:1518:b0:544:f741:62f4 with SMTP id
 f24-20020a056402151800b00544f74162f4mr35059edw.0.1699477100893; Wed, 08 Nov
 2023 12:58:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231108202819.1932920-1-sdf@google.com>
In-Reply-To: <20231108202819.1932920-1-sdf@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 8 Nov 2023 21:58:07 +0100
Message-ID: <CANn89iJnX6sm1UHbU6TKzoWJJyNLGjpN_amb8bkmgnLk8Qj_gQ@mail.gmail.com>
Subject: Re: [PATCH net] net: set SOCK_RCU_FREE before inserting socket into hashtable
To: Stanislav Fomichev <sdf@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 8, 2023 at 9:28=E2=80=AFPM Stanislav Fomichev <sdf@google.com> =
wrote:
>
> We've started to see the following kernel traces:
>
>  WARNING: CPU: 83 PID: 0 at net/core/filter.c:6641 sk_lookup+0x1bd/0x1d0
>
>  Call Trace:
>   <IRQ>
>   __bpf_skc_lookup+0x10d/0x120
>   bpf_sk_lookup+0x48/0xd0
>   bpf_sk_lookup_tcp+0x19/0x20
>   bpf_prog_<redacted>+0x37c/0x16a3
>   cls_bpf_classify+0x205/0x2e0
>   tcf_classify+0x92/0x160
>   __netif_receive_skb_core+0xe52/0xf10
>   __netif_receive_skb_list_core+0x96/0x2b0
>   napi_complete_done+0x7b5/0xb70
>   <redacted>_poll+0x94/0xb0
>   net_rx_action+0x163/0x1d70
>   __do_softirq+0xdc/0x32e
>   asm_call_irq_on_stack+0x12/0x20
>   </IRQ>
>   do_softirq_own_stack+0x36/0x50
>   do_softirq+0x44/0x70
>
> I'm not 100% what is causing them. It might be some kernel change or
> new code path in the bpf program. But looking at the code,
> I'm assuming the issue has been there for a while.
>
> __inet_hash can race with lockless (rcu) readers on the other cpus:
>
>   __inet_hash
>     __sk_nulls_add_node_rcu
>     <- (bpf triggers here)
>     sock_set_flag(SOCK_RCU_FREE)
>
> Let's move the SOCK_RCU_FREE part up a bit, before we are inserting
> the socket into hashtables. Note, that the race is really harmless;
> the bpf callers are handling this situation (where listener socket
> doesn't have SOCK_RCU_FREE set) correctly, so the only
> annoyance is a WARN_ONCE (so not 100% sure whether it should
> wait until net-next instead).
>
> For the fixes tag, I'm using the original commit which added the flag.

When this commit added the flag, precise location of the
sock_set_flag(sk, SOCK_RCU_FREE)
did not matter, because the thread calling __inet_hash() owns a reference o=
n sk.

SOCK_RCU_FREE was tested only at dismantle time.

Back then BPF was not able yet to perform lookups, and double check if
SOCK_RCU_FREE
was set or not.

Checking SOCK_RCU_FREE _after_ the lookup to infer if a refcount has
been taken came
with commit 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")

I think we can be more precise and help future debugging, in case more prob=
lems
need investigations.

Can you augment the changelog and use a different Fixes: tag ?

With that,

Reviewed-by: Eric Dumazet <edumazet@google.com>

>
> Fixes: 3b24d854cb35 ("tcp/dccp: do not touch listener sk_refcnt under syn=
flood")
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  net/ipv4/inet_hashtables.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index 598c1b114d2c..a532f749e477 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -751,12 +751,12 @@ int __inet_hash(struct sock *sk, struct sock *osk)
>                 if (err)
>                         goto unlock;
>         }
> +       sock_set_flag(sk, SOCK_RCU_FREE);
>         if (IS_ENABLED(CONFIG_IPV6) && sk->sk_reuseport &&
>                 sk->sk_family =3D=3D AF_INET6)
>                 __sk_nulls_add_node_tail_rcu(sk, &ilb2->nulls_head);
>         else
>                 __sk_nulls_add_node_rcu(sk, &ilb2->nulls_head);
> -       sock_set_flag(sk, SOCK_RCU_FREE);
>         sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
>  unlock:
>         spin_unlock(&ilb2->lock);
> --
> 2.42.0.869.gea05f2083d-goog
>

