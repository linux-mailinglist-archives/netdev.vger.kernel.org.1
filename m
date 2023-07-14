Return-Path: <netdev+bounces-18038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47810754572
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 01:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F238E282329
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 23:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B93A2AB30;
	Fri, 14 Jul 2023 23:38:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9E12C80
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 23:38:54 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC89A2D5D
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 16:38:52 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-307d58b3efbso2585914f8f.0
        for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 16:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689377931; x=1691969931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBT3rUjJGAxYbppKiA656uXoRrGlh1XdLp4eh9nDCrQ=;
        b=p2J7w1ajpOdvwrAGvge0quNYmL6gv7jREgk3lB+pZPHG8ZNS/mdOZ80VZXHKw3CVR3
         tNLxlc1PxlmwAQSpmcMhF1laQQZL8/quot+4wRhUysKnqpDGqM/QPeUIvhj6rWzttEwj
         OBviYO6vvg7P6SS6qBZc3j2mh77sZTstHPKyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689377931; x=1691969931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zBT3rUjJGAxYbppKiA656uXoRrGlh1XdLp4eh9nDCrQ=;
        b=CmpcnzOQFol6N6sX5aj2LTHLFCFN7D0oMhUExwUp9Q4QN4zQli+S9Oh+O276G93eex
         ws5Zxjhu59oIKSJ/txfinbDqlQp2OWiQShmzHhXlopeZ+C0Hdei720nkdaiMY8fYjMOg
         RO3rkq3lmNSH9PCmjG07mNSN6a37PXvLuHQY3Il/AVhQ3YWcd1YN6bFfTgDUYuw+sJLn
         vUm8qL6xrxeq7dghAY2+Q0IuBsZJy1OZKdXw48ee6gslBem7iidbZu6DnCOWUwVGB1WC
         LjIrjvV8z4yrm/oOAmW8Lz2dA+ieS4ZG1FMTcQCes7b1LEr+nK8c80Jb+X51gKngmzzR
         L2Pg==
X-Gm-Message-State: ABy/qLYViAL+k37JPn8i24UgYu5xkPzpi/b+u6HDyBT9QilPzFjYqfYn
	s1yYiBUQHmuhYVsne5u5O40w8Xp+3diFXh89KKRitw==
X-Google-Smtp-Source: APBJJlFI8UT7ttHWMWTChD+OoeAiz8TeEiUAizhofk5qBde1N/nlsvJ0HFW4KXpG76GQ43uNhHOFDgHRwjioOZyHVSY=
X-Received: by 2002:a5d:5505:0:b0:313:f98a:1fd3 with SMTP id
 b5-20020a5d5505000000b00313f98a1fd3mr5794979wrv.27.1689377931105; Fri, 14 Jul
 2023 16:38:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230711043453.64095-1-ivan@cloudflare.com> <20230711193612.22c9bc04@kernel.org>
 <CAO3-PbrZHn1syvhb3V57oeXigE_roiHCbzYz5Mi4wiymogTg2A@mail.gmail.com>
 <20230712104210.3b86b779@kernel.org> <CABWYdi3VJU7HUxzKJBKgX9wF9GRvmA0TKVpjuHvJyz_EdpxZFA@mail.gmail.com>
 <c015fdb8-9ac1-b45e-89a2-70e8ababae17@kernel.org>
In-Reply-To: <c015fdb8-9ac1-b45e-89a2-70e8ababae17@kernel.org>
From: Ivan Babrou <ivan@cloudflare.com>
Date: Fri, 14 Jul 2023 16:38:40 -0700
Message-ID: <CABWYdi010VpHHi6-PLyBB3F_btFggm7XLxstboCRBvBLdoKdmA@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] tcp: add a tracepoint for tcp_listen_queue_drop
To: David Ahern <dsahern@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 14, 2023 at 8:09=E2=80=AFAM David Ahern <dsahern@kernel.org> wr=
ote:
> > We can start a separate discussion to break it down by category if it
> > would help. Let me know what kind of information you would like us to
> > provide to help with that. I assume you're interested in kernel stacks
> > leading to kfree_skb with NOT_SPECIFIED reason, but maybe there's
> > something else.
>
> stack traces would be helpful.

Here you go: https://lore.kernel.org/netdev/CABWYdi00L+O30Q=3DZah28QwZ_5RU-=
xcxLFUK2Zj08A8MrLk9jzg@mail.gmail.com/

> > Even if I was only interested in one specific reason, I would still
> > have to arm the whole tracepoint and route a ton of skbs I'm not
> > interested in into my bpf code. This seems like a lot of overhead,
> > especially if I'm dropping some attack packets.
>
> you can add a filter on the tracepoint event to limit what is passed
> (although I have not tried the filter with an ebpf program - e.g.,
> reason !=3D NOT_SPECIFIED).

Absolutely, but isn't there overhead to even do just that for every freed s=
kb?

> > If you have an ebpf example that would help me extract the destination
> > port from an skb in kfree_skb, I'd be interested in taking a look and
> > trying to make it work.
>
> This is from 2020 and I forget which kernel version (pre-BTF), but it
> worked at that time and allowed userspace to summarize drop reasons by
> various network data (mac, L3 address, n-tuple, etc):
>
> https://github.com/dsahern/bpf-progs/blob/master/ksrc/pktdrop.c

It doesn't seem to extract the L4 metadata (local port specifically),
which is what I'm after.

> > The need to extract the protocol level information in ebpf is only
> > making kfree_skb more expensive for the needs of catching rare cases
> > when we run out of buffer space (UDP) or listen queue (TCP). These two
> > cases are very common failure scenarios that people are interested in
> > catching with straightforward tracepoints that can give them the
> > needed information easily and cheaply.
> >
> > I sympathize with the desire to keep the number of tracepoints in
> > check, but I also feel like UDP buffer drops and TCP listen drops
> > tracepoints are very much justified to exist.
>
> sure, kfree_skb is like the raw_syscall tracepoint - it can be more than
> what you need for a specific problem, but it is also give you way more
> than you are thinking about today.

I really like the comparison to raw_syscall tracepoint. There are two flavo=
rs:

1. Catch-all: raw_syscalls:sys_enter, which is similar to skb:kfree_skb.
2. Specific tracepoints: syscalls:sys_enter_* for every syscall.

If you are interested in one rare syscall, you wouldn't attach to a
catch-all firehose and the filter for id in post. Understandably, we
probably can't have a separate skb:kfree_skb for every reason.
However, some of them are more useful than others and I believe that
tcp listen drops fall into that category.

We went through a similar exercise with audit subsystem, which in fact
always arms all syscalls even if you audit one of them:

* https://lore.kernel.org/audit/20230523181624.19932-1-ivan@cloudflare.com/=
T/#u

With pictures, if you're interested:

* https://mastodon.ivan.computer/@mastodon/110426498281603668

Nobody audits futex(), but if you audit execve(), all the rules run
for both. Some rules will run faster, but all of them will run. It's a
lot of overhead with millions of CPUs, which I'm trying to avoid (the
planet is hot as it is).

Ultimately my arguments for a separate tracepoint for tcp listen drops
are at the bottom of my reply to Jakub:

* https://lore.kernel.org/netdev/CABWYdi2BGi=3DiRCfLhmQCqO=3D1eaQ1WaCG7F9Ws=
Jrz-7=3D=3DocZidg@mail.gmail.com/

