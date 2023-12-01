Return-Path: <netdev+bounces-53024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7833801219
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92765281BBC
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 17:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A8E4EB30;
	Fri,  1 Dec 2023 17:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dFnb0GoW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D901FC
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 09:51:15 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54c52baaa59so353a12.0
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 09:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701453073; x=1702057873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3pnThC3OPQt1u7swR/CEmmm2L1BbqHWt2vccyU+wqY=;
        b=dFnb0GoWAqwCCJgSyyNchhPslfWB1/pjpjSaF7b3RaPqQkAlf8xrITTLEF+WWgGI4t
         fASC1mMdLnQQ9/xQu56JXkMlcQzF7whgRuX80ZsDwxmYJtTCRhjTuWVj9uT1gwbwE3Eu
         d3oLDOuN33ic1mD5qvdgXQ+13E22lROqJ+zGIz6SlPe9BQ6g9jTMnBaST8vWsjTlTOWZ
         12vo0Bwinsodc4bCxJnqprKV8U7Qlcv9lrLEjE4JSx7XPj3egtAvuRUhdHkh5yKj+cpT
         FvPKoufQOvhqjQ5wTcL4SNgs8b3JYjG7/NDxYHlkVdJEYPp2yPUffjJDREfM9nTjEUYQ
         NVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701453073; x=1702057873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3pnThC3OPQt1u7swR/CEmmm2L1BbqHWt2vccyU+wqY=;
        b=q5uhBdGjDkyYxrB3bLe0zQiZ9/92oLam4vBnWsrWhwxRCyVxs7JnLZgCayMGCxPufe
         UjVsbSBSVW8YWxApbLQ5PLhfHFg3hicyGCYTZymAoVkNCGh6zxleufL1xtXx9NOjo9dH
         whDbsAKKFUDrDxwm9tYbSO/CEW8emNnSlW4TyjTE+5obRXw4wc+YQxZh9dVMOEEOkB7/
         9hGbziFwuYbv4nq/CeuBdnK8spqYABIcx3YCcaQPBlqMgZt+IbG7ZMrY4u2+EH/cm2O6
         js8lb/cqLijITuXYNdscBdZTO+OcHFuzstH/2YUtHzSVjIUNfpAps8osyGEQUhfd9Mrp
         Xpow==
X-Gm-Message-State: AOJu0YwTJemoqcve4ebyui5iap6RVpoflCmkZh5wKeBxtF6nah7Iogtl
	uJv/50v/WleYTmoNWVuAv0WvHaV9njIQzuUNKjZyfQ==
X-Google-Smtp-Source: AGHT+IF+QIR6TaWoGuTkiAnwgaJjp4j91us2yyByWB+XCzNBr5ZqeJ+yZO8B/pZ5Twzrl27VU8eKH2lxWwExO89XVXc=
X-Received: by 2002:a50:aacf:0:b0:54b:321:ef1a with SMTP id
 r15-20020a50aacf000000b0054b0321ef1amr152058edc.6.1701453073216; Fri, 01 Dec
 2023 09:51:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZWobMUp22oTpP3FW@debian.debian>
In-Reply-To: <ZWobMUp22oTpP3FW@debian.debian>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 1 Dec 2023 18:51:02 +0100
Message-ID: <CANn89iLLnXVBvajLA-FLwBSN4uRNZKJYAvwvKEymGsvOQQJs1A@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] packet: add a generic drop reason for receive
To: Yan Zhai <yan@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Weongyo Jeong <weongyo.linux@gmail.com>, 
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com, 
	Jesper Brouer <jesper@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 6:43=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wrote:
>
> Commit da37845fdce2 ("packet: uses kfree_skb() for errors.") switches
> from consume_skb to kfree_skb to improve error handling. However, this
> could bring a lot of noises when we monitor real packet drops in
> kfree_skb[1], because in tpacket_rcv or packet_rcv only packet clones
> can be freed, not actual packets.
>
> Adding a generic drop reason to allow distinguish these "clone drops".
>
> [1]: https://lore.kernel.org/netdev/CABWYdi00L+O30Q=3DZah28QwZ_5RU-xcxLFU=
K2Zj08A8MrLk9jzg@mail.gmail.com/
> Fixes: da37845fdce2 ("packet: uses kfree_skb() for errors.")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> ---
>  include/net/dropreason-core.h |  6 ++++++
>  net/packet/af_packet.c        | 22 +++++++++++++---------
>  2 files changed, 19 insertions(+), 9 deletions(-)
>
> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.=
h
> index 3c70ad53a49c..278e4c7d465c 100644
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h
> @@ -86,6 +86,7 @@
>         FN(IPV6_NDISC_NS_OTHERHOST)     \
>         FN(QUEUE_PURGE)                 \
>         FN(TC_ERROR)                    \
> +       FN(PACKET_SOCK_ERROR)           \
>         FNe(MAX)
>
>  /**
> @@ -378,6 +379,11 @@ enum skb_drop_reason {
>         SKB_DROP_REASON_QUEUE_PURGE,
>         /** @SKB_DROP_REASON_TC_ERROR: generic internal tc error. */
>         SKB_DROP_REASON_TC_ERROR,
> +       /**
> +        * @SKB_DROP_REASON_PACKET_SOCK_ERROR: generic packet socket erro=
rs
> +        * after its filter matches an incoming packet.
> +        */
> +       SKB_DROP_REASON_PACKET_SOCK_ERROR,
>         /**
>          * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
>          * shouldn't be used as a real 'reason' - only for tracing code g=
en
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index a84e00b5904b..0a7c05d8fe9f 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -2128,6 +2128,7 @@ static int packet_rcv(struct sk_buff *skb, struct n=
et_device *dev,
>         int skb_len =3D skb->len;
>         unsigned int snaplen, res;
>         bool is_drop_n_account =3D false;

Why keeping is_drop_n_account  then ?


> +       enum skb_drop_reason drop_reason =3D SKB_CONSUMED;
>
>         if (skb->pkt_type =3D=3D PACKET_LOOPBACK)
>                 goto drop;
> @@ -2161,6 +2162,10 @@ static int packet_rcv(struct sk_buff *skb, struct =
net_device *dev,
>         res =3D run_filter(skb, sk, snaplen);
>         if (!res)
>                 goto drop_n_restore;
> +
> +       /* skb will only be "consumed" not "dropped" before this */
> +       drop_reason =3D SKB_DROP_REASON_PACKET_SOCK_ERROR;
> +
>         if (snaplen > res)
>                 snaplen =3D res;
>
> @@ -2227,10 +2232,7 @@ static int packet_rcv(struct sk_buff *skb, struct =
net_device *dev,
>                 skb->len =3D skb_len;
>         }
>  drop:
> -       if (!is_drop_n_account)

Because after your patch it will be set but never read.

> -               consume_skb(skb);
> -       else
> -               kfree_skb(skb);
> +       kfree_skb_reason(skb, drop_reason);
>         return 0;
>  }
>
> @@ -2253,6 +2255,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct =
net_device *dev,
>         bool is_drop_n_account =3D false;

Same remark here.

>         unsigned int slot_id =3D 0;
>         int vnet_hdr_sz =3D 0;
> +       enum skb_drop_reason drop_reason =3D SKB_CONSUMED;
>
>         /* struct tpacket{2,3}_hdr is aligned to a multiple of TPACKET_AL=
IGNMENT.
>          * We may add members to them until current aligned size without =
forcing
> @@ -2355,6 +2358,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct=
 net_device *dev,
>                         vnet_hdr_sz =3D 0;
>                 }
>         }
> +
> +       /* skb will only be "consumed" not "dropped" before this */
> +       drop_reason =3D SKB_DROP_REASON_PACKET_SOCK_ERROR;
> +
>         spin_lock(&sk->sk_receive_queue.lock);
>         h.raw =3D packet_current_rx_frame(po, skb,
>                                         TP_STATUS_KERNEL, (macoff+snaplen=
));
> @@ -2498,10 +2505,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct=
 net_device *dev,
>                 skb->len =3D skb_len;
>         }
>  drop:
> -       if (!is_drop_n_account)
> -               consume_skb(skb);
> -       else
> -               kfree_skb(skb);
> +       kfree_skb_reason(skb, drop_reason);
>         return 0;
>
>  drop_n_account:
> @@ -2510,7 +2514,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct =
net_device *dev,
>         is_drop_n_account =3D true;
>
>         sk->sk_data_ready(sk);
> -       kfree_skb(copy_skb);
> +       kfree_skb_reason(copy_skb, drop_reason);
>         goto drop_n_restore;
>  }
>
> --
> 2.30.2
>

