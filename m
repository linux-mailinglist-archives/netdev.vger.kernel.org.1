Return-Path: <netdev+bounces-25375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB21773D02
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1731C21163
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFE814014;
	Tue,  8 Aug 2023 15:57:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614E7168C6
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:57:33 +0000 (UTC)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339AE4AA81
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:57:17 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-3492e05be7cso149835ab.0
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 08:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691510199; x=1692114999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCOXJYzxETCH/0UcvxLQeHGSMM7DSEXKUT9P3Dlmymo=;
        b=cLIT7/OnwIxfvET50ifT6MCrXAjnvdvbPEKEhwjKBDckGPRWZgSlLMX3fvwd3pJlXm
         xvJzJIU1ByFXsdgv5kYewTHGM54Bf/JCDqOgd8QJQNDRHZMsWdNDInr4JE9zQnKuGyhd
         MfX0Pl/xKWnWfbpq4RsRaIH+Jnx4z0PIaPuvjj+TnrN2nqe/qBP2T9oCVr9/iH+XzoYG
         aQTUoFY2FMwV0pvOt8Kvep3/LZgLMJBo3CJ4jadKSqXKKzKcIARLxj2fct0ck5jhbDWx
         qc9+oZfIT31LoaldNM6me5+vhCRB0q5szSbnrktWoReUPZLNCrqxSHP/xBtDe6RVmkEC
         Jmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510199; x=1692114999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCOXJYzxETCH/0UcvxLQeHGSMM7DSEXKUT9P3Dlmymo=;
        b=Lfu8P69d5p46TJS9hfoBO+NDtLPX9FQhOGXjAxDMwlaJv3OWSQ4nIhAHr9izbV4qh4
         0kQrF7AA/ummVm8wukM/m9e8NwgOO3U6Z8yPNGQxwMu1UP8qrhNFqJ2Ig6VZDsdB7N+X
         3NC5kpuClmYd9qV2LcE7DgBQ8A5h2zI3l3KE8L4/cBH0BvOzLZWY3et+Tu2XuCdosi8b
         WvVAgqtY/S0VFagYtuNxKkgjtw5DKXQDon+XFSde+yc5kYZxnA2EuUSxvmsY2ZOEHbLV
         30uURvvD7mixISJ+/2Y8KyZ6szcM8on5Oql+CG03MOC5qE5x8oKE+tEXfBXBki1HBSg+
         swVw==
X-Gm-Message-State: AOJu0Yz0sOtF57GU0PEpuLISEO0eDux0muRkKQwpuwPFy2od89INeeA+
	3YOQUSRFXCo2ZfWR3ULyer1DUNTmpm2iQczL6X0rYZYNNNEckkKOpOw=
X-Google-Smtp-Source: AGHT+IEfM3zZpi2A8IEkcUU11DnAyYRP6HYaBR73Q/AKzK2pHMPvaVHfkSYylHJ4uhb2VI1kTwpMv6BetR8BNyyQJjc=
X-Received: by 2002:ac8:5951:0:b0:403:96e3:4745 with SMTP id
 17-20020ac85951000000b0040396e34745mr749543qtz.20.1691484513351; Tue, 08 Aug
 2023 01:48:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADVnQyn3UMa3Qx6cC1Rx97xLjQdG0eKsiF7oY9UR=b9vU4R-yA@mail.gmail.com>
 <20230808055817.3979-1-me@manjusaka.me> <CANn89iKxJThy4ZVq4do6Z1bOZsRptfN6N8ydPaHQAmYKCjtOnw@mail.gmail.com>
 <af02d2a9-4655-45a1-8c3a-d9921bfdbc35@manjusaka.me>
In-Reply-To: <af02d2a9-4655-45a1-8c3a-d9921bfdbc35@manjusaka.me>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 8 Aug 2023 10:48:21 +0200
Message-ID: <CANn89iKQXhqgOTkSchH6Bz-xH--pAoSyEORBtawqBTvgG+dFig@mail.gmail.com>
Subject: Re: [PATCH v2] tracepoint: add new `tcp:tcp_ca_event` trace event
To: Manjusaka <me@manjusaka.me>
Cc: ncardwell@google.com, bpf@vger.kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-16.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 8, 2023 at 10:46=E2=80=AFAM Manjusaka <me@manjusaka.me> wrote:
>
>
>
> On 2023/8/8 16:26, Eric Dumazet wrote:
> > On Tue, Aug 8, 2023 at 7:59=E2=80=AFAM Manjusaka <me@manjusaka.me> wrot=
e:
> >>
> >> In normal use case, the tcp_ca_event would be changed in high frequenc=
y.
> >>
> >> It's a good indicator to represent the network quanlity.
> >
> > quality ?
> >
> > Honestly, it is more about TCP stack tracing than 'network quality'
> >
> >>
> >> So I propose to add a `tcp:tcp_ca_event` trace event
> >> like `tcp:tcp_cong_state_set` to help the people to
> >> trace the TCP connection status
> >>
> >> Signed-off-by: Manjusaka <me@manjusaka.me>
> >> ---
> >>  include/net/tcp.h          |  9 ++------
> >>  include/trace/events/tcp.h | 45 +++++++++++++++++++++++++++++++++++++=
+
> >>  net/ipv4/tcp_cong.c        | 10 +++++++++
> >>  3 files changed, 57 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/include/net/tcp.h b/include/net/tcp.h
> >> index 0ca972ebd3dd..a68c5b61889c 100644
> >> --- a/include/net/tcp.h
> >> +++ b/include/net/tcp.h
> >> @@ -1154,13 +1154,8 @@ static inline bool tcp_ca_needs_ecn(const struc=
t sock *sk)
> >>         return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ECN;
> >>  }
> >>
> >> -static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_ev=
ent event)
> >> -{
> >> -       const struct inet_connection_sock *icsk =3D inet_csk(sk);
> >> -
> >> -       if (icsk->icsk_ca_ops->cwnd_event)
> >> -               icsk->icsk_ca_ops->cwnd_event(sk, event);
> >> -}
> >> +/* from tcp_cong.c */
> >> +void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event);
> >>
> >>  /* From tcp_cong.c */
> >>  void tcp_set_ca_state(struct sock *sk, const u8 ca_state);
> >> diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> >> index bf06db8d2046..b374eb636af9 100644
> >> --- a/include/trace/events/tcp.h
> >> +++ b/include/trace/events/tcp.h
> >> @@ -416,6 +416,51 @@ TRACE_EVENT(tcp_cong_state_set,
> >>                   __entry->cong_state)
> >>  );
> >>
> >> +TRACE_EVENT(tcp_ca_event,
> >> +
> >> +       TP_PROTO(struct sock *sk, const u8 ca_event),
> >> +
> >> +       TP_ARGS(sk, ca_event),
> >> +
> >> +       TP_STRUCT__entry(
> >> +               __field(const void *, skaddr)
> >> +               __field(__u16, sport)
> >> +               __field(__u16, dport)
> >> +               __array(__u8, saddr, 4)
> >> +               __array(__u8, daddr, 4)
> >> +               __array(__u8, saddr_v6, 16)
> >> +               __array(__u8, daddr_v6, 16)
> >> +               __field(__u8, ca_event)
> >> +       ),
> >> +
> >
> > Please add the family (look at commit 3dd344ea84e1 ("net: tracepoint:
> > exposing sk_family in all tcp:tracepoints"))
> >
> >
> >
> >> +       TP_fast_assign(
> >> +               struct inet_sock *inet =3D inet_sk(sk);
> >> +               __be32 *p32;
> >> +
> >> +               __entry->skaddr =3D sk;
> >> +
> >> +               __entry->sport =3D ntohs(inet->inet_sport);
> >> +               __entry->dport =3D ntohs(inet->inet_dport);
> >> +
> >> +               p32 =3D (__be32 *) __entry->saddr;
> >> +               *p32 =3D inet->inet_saddr;
> >> +
> >> +               p32 =3D (__be32 *) __entry->daddr;
> >> +               *p32 =3D  inet->inet_daddr;
> >
> > We keep copying IPv4 addresses that might contain garbage for IPv6 sock=
ets :/
> >
> >> +
> >> +               TP_STORE_ADDRS(__entry, inet->inet_saddr, inet->inet_d=
addr,
> >> +                          sk->sk_v6_rcv_saddr, sk->sk_v6_daddr);
> >
> > I will send a cleanup, because IP_STORE_ADDRS() should really take
> > care of all details.
> >
> >
> >> +
> >> +               __entry->ca_event =3D ca_event;
> >> +       ),
> >> +
> >> +       TP_printk("sport=3D%hu dport=3D%hu saddr=3D%pI4 daddr=3D%pI4 s=
addrv6=3D%pI6c daddrv6=3D%pI6c ca_event=3D%u",
> >> +                 __entry->sport, __entry->dport,
> >> +                 __entry->saddr, __entry->daddr,
> >> +                 __entry->saddr_v6, __entry->daddr_v6,
> >> +                 __entry->ca_event)
> >
> > Please print the symbol instead of numeric ca_event.
> >
> > Look at show_tcp_state_name() for instance.
>
> Thanks for the kindness code review, I still get some issue here(Sorry fo=
r the first time to contribute):
>
> 1. > We keep copying IPv4 addresses that might contain garbage for IPv6 s=
ockets :/
>
> I'm not getting your means, would you mean that we should only save the I=
Pv4 Address here?
>
> 2. > I will send a cleanup, because IP_STORE_ADDRS() should really take c=
are of all details.
>
> I think you will make the address assignment code in TP_fast_assign as a =
new function.
>
> Should I submit the new change until you send the cleanup patch or I can =
make this in my patch(cleanup the address assignment)
>

Wait a bit, I am sending fixes today, so that no more copy/paste
duplicates the issues.

