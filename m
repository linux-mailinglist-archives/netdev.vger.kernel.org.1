Return-Path: <netdev+bounces-18748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C670175884A
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 00:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CFD21C20E3C
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 22:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F3617AA1;
	Tue, 18 Jul 2023 22:11:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E0715AEA
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 22:11:51 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00BC198D
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 15:11:49 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so62639335e9.3
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 15:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689718308; x=1692310308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBFuzfdAmNaYm1a7M+xjqXL6se2cAULTKm86TtuRY5Q=;
        b=YQODveK83sfIFQaoJ9d2zHDCyX1sM75EscthSqX1VQKlA33+o/qSgy2s6aznlG0XY8
         7fWjzJxVNc0uyMvVShNQ5m8RdzyHyHV1/jromJ5LgLj1ZMxlzZf29yM0IowIbBRdnaRT
         e6nMJIwJty6B0fD2T7D99k/IRTZgUGndgrsf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689718308; x=1692310308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBFuzfdAmNaYm1a7M+xjqXL6se2cAULTKm86TtuRY5Q=;
        b=UrtrRtr60pFi+x+d9kGPSghAPW4rJ3kSqusjyCaghXkQee6hDlGFQdZlS3iHUe5Nwv
         eiT8YzxGera4iWQni2G/qtwEmKEeXHr7WZhvU9nF/d8Bmmsj8KlrYyjgNy0E+XWVFSFq
         scm7JA4xXBnATUmt6iiJVbD60jRjubMIMNnL4viFvWYYG6R2wijQKmLFAs3qJOtCBv0H
         8pufG7AIhzXg2rcVDQHc1OOMgc0KZnwFrF/4U2UKYtwSxqBTUUjLFFq04RPeg5t8bdl+
         +Ej6kPUliflo2MlsIrEbq1MAqxpdkBr+GKfifs+0N6uKV4ROCBu1VpbDgKohPQ83xpFq
         VtNA==
X-Gm-Message-State: ABy/qLZSsENGI/DUrKjcUH4lkVFtEdr6uLQ4tTODq7XBCcoltqERIUhl
	6AK7LM8gcIo7zTWu6E+MT0qhhvi41K0Fo2cOb8QbRaHsVcIdogbBMko=
X-Google-Smtp-Source: APBJJlHcLp3LZZT8ePqg38XVu9BXhK2EmR1zn3gSPLE3NZgfENsHW5sZJR+iNbZcyUFGp2gYHgl19eG9XtgqPXSwOAg=
X-Received: by 2002:a7b:c347:0:b0:3fb:b637:22a7 with SMTP id
 l7-20020a7bc347000000b003fbb63722a7mr3021125wmj.4.1689718308375; Tue, 18 Jul
 2023 15:11:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230711043453.64095-1-ivan@cloudflare.com> <20230711193612.22c9bc04@kernel.org>
 <CAO3-PbrZHn1syvhb3V57oeXigE_roiHCbzYz5Mi4wiymogTg2A@mail.gmail.com>
 <20230712104210.3b86b779@kernel.org> <CABWYdi3VJU7HUxzKJBKgX9wF9GRvmA0TKVpjuHvJyz_EdpxZFA@mail.gmail.com>
 <20230713201427.2c50fc7b@kernel.org> <CABWYdi2BGi=iRCfLhmQCqO=1eaQ1WaCG7F9WsJrz-7==ocZidg@mail.gmail.com>
 <20230718145700.5d6f766d@kernel.org>
In-Reply-To: <20230718145700.5d6f766d@kernel.org>
From: Ivan Babrou <ivan@cloudflare.com>
Date: Tue, 18 Jul 2023 15:11:37 -0700
Message-ID: <CABWYdi2sBOTehNRGVhqftqJhAQ6558RtFKbYrXq5PUe=1dPExQ@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] tcp: add a tracepoint for tcp_listen_queue_drop
To: Jakub Kicinski <kuba@kernel.org>
Cc: Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 18, 2023 at 2:57=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 14 Jul 2023 16:21:08 -0700 Ivan Babrou wrote:
> > > Just the stacks.
> >
> > Here you go: https://lore.kernel.org/netdev/CABWYdi00L+O30Q=3DZah28QwZ_=
5RU-xcxLFUK2Zj08A8MrLk9jzg@mail.gmail.com/
>
> Thanks! I'll follow the discussion there. Just the one remaining
> clarification here:
>
> > > > Even if I was only interested in one specific reason, I would still
> > > > have to arm the whole tracepoint and route a ton of skbs I'm not
> > > > interested in into my bpf code. This seems like a lot of overhead,
> > > > especially if I'm dropping some attack packets.
> > >
> > > That's what I meant with my drop vs exception comment. We already hav=
e
> > > two tracepoints on the skb free path (free and consume), adding anoth=
er
> > > shouldn't rise too many eyebrows.
> >
> > I'm a bit confused. Previously you said:
> >
> > > Specifically what I'm wondering is whether we should also have
> > > a separation between policy / "firewall drops" and error / exception
> > > drops. Within the skb drop reason codes, I mean.
> >
> > My understanding was that you proposed adding more SKB_DROP_REASON_*,
> > but now you seem to imply that we might want to add another
> > tracepoint. Could you clarify which path you have in mind?
>
> What I had in mind was sorting the drop reasons to be able to easily
> distinguish policy drops from error drops.
>
> > We can add a few reasons that would satisfy my need by covering
> > whatever results into tcp_listendrop() calls today. The problem is:
> > unless we remove some other reasons from kfree_skb, adding more
> > reasons for firewall drops / exceptions wouldn't change the cost at
> > all. We'd still have the same number of calls into the tracepoint and
> > the condition to find "interesting" reasons would be the same:
> >
> > if (reason =3D=3D SKB_DROP_REASON_TCP_OVERFLOW_OR_SOMETHING)
> >
> > It still seems very expensive to consume a firehose of kfree_skb just
> > to find some rare nuggets.
>
> Let me show you a quick mock-up of a diff:
>
> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.=
h
> index a2b953b57689..86ee70fcf540 100644
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h
> @@ -5,12 +5,18 @@
>
>  #define DEFINE_DROP_REASON(FN, FNe)    \
>         FN(NOT_SPECIFIED)               \
> +       /* Policy-driven/intentional drops: */  \
> +       FN(NETFILTER_DROP)              \
> +       FN(BPF_CGROUP_EGRESS)           \
> +       FN(TC_INGRESS)                  \
> +       FN(TC_EGRESS)                   \
> +       FN(XDP)                         \
> +       /* Errors: */                   \
>         FN(NO_SOCKET)                   \
>         FN(PKT_TOO_SMALL)               \
>         FN(TCP_CSUM)                    \
>         FN(SOCKET_FILTER)               \
>         FN(UDP_CSUM)                    \
> -       FN(NETFILTER_DROP)              \
>         FN(OTHERHOST)                   \
>         FN(IP_CSUM)                     \
>         FN(IP_INHDR)                    \
> @@ -41,17 +47,13 @@
>         FN(TCP_OFO_QUEUE_PRUNE)         \
>         FN(TCP_OFO_DROP)                \
>         FN(IP_OUTNOROUTES)              \
> -       FN(BPF_CGROUP_EGRESS)           \
>         FN(IPV6DISABLED)                \
>         FN(NEIGH_CREATEFAIL)            \
>         FN(NEIGH_FAILED)                \
>         FN(NEIGH_QUEUEFULL)             \
>         FN(NEIGH_DEAD)                  \
> -       FN(TC_EGRESS)                   \
>         FN(QDISC_DROP)                  \
>         FN(CPU_BACKLOG)                 \
> -       FN(XDP)                         \
> -       FN(TC_INGRESS)                  \
>         FN(UNHANDLED_PROTO)             \
>         FN(SKB_CSUM)                    \
>         FN(SKB_GSO_SEG)                 \
> @@ -80,6 +82,8 @@
>         FN(IPV6_NDISC_NS_OTHERHOST)     \
>         FNe(MAX)
>
> +#define        __SKB_POLICY_DROP_END   SKB_DROP_REASON_NO_SOCKET
> +
>  /**
>   * enum skb_drop_reason - the reasons of skb drops
>   *
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 6c5915efbc17..a36c498eb693 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1031,6 +1031,8 @@ bool __kfree_skb_reason(struct sk_buff *skb, enum s=
kb_drop_reason reason)
>
>         if (reason =3D=3D SKB_CONSUMED)
>                 trace_consume_skb(skb, __builtin_return_address(0));
> +       else if (reason < __SKB_POLICY_DROP_END)
> +               trace_drop_skb(skb, __builtin_return_address(0), reason);
>         else
>                 trace_kfree_skb(skb, __builtin_return_address(0), reason)=
;
>         return true;

I see what you mean now. This makes sense.

