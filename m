Return-Path: <netdev+bounces-25317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E295773B9B
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 17:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07CE6280982
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 15:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082F5134D1;
	Tue,  8 Aug 2023 15:44:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10D51C29
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:44:19 +0000 (UTC)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E291BC8
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:43:57 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-3490b737f9aso151055ab.0
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 08:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691509437; x=1692114237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zn2bzFezk/UZyxUtkuS/wxumoulHOnZ5vgKYBp+qi5w=;
        b=C9GUiTbucm1/aSD+b9/ASm9MZkMfHwYegEaO3Dku+dQrXjlkMS120cpy0F23YuVJ6/
         BKFj8XBxvsgm2fY2VOdsWBDjtC8cfa1/L7YHBS3SbeoIfha3tsorsqbmP/lmdpiEBzmQ
         I41k58UqsUIFBxi6kl9VHw+v/DHgQWvCoAlAhuxUUWi1sohhC34pBPn3TD7J5B++Aq3v
         TZ8mlPmtKUPyhxx7Hdea6uUuyA7Oy5OQw/DvhwPh8zM0LjfYEy4q/6aK//s3QlXHqFC1
         tA5R8EzD911zhQHNrvsoH+3LxPwcvDf10N6aKYEkfhCduDPS2PDPbkZInTiq06+z7zH8
         ILfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509437; x=1692114237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zn2bzFezk/UZyxUtkuS/wxumoulHOnZ5vgKYBp+qi5w=;
        b=Xm4GW26Q8Yy6yvYjl5ntCY2CqE55auJw+XK4TAphZ1wxYSeqxhZIarbTMxNXv+zpVv
         rwx1UXySUQKMpkgHmlXhlpEXRlTOaguudhqyYZzVMkgOwUbvOhQHEIgGwC77JKBNcVLj
         iYYN5UNTXGQiTN+8/WL4vfRBkfKw1Q9TmbB9Q8siGjfWLN+RX+XTIarBnLLkcg/kiXO4
         N4KPWB8Jw3Lf2D6ZmlhAILWpz1cLO5l6p7n+NJUv51HJu/BJqyo3kOLwEMtWNf3gQJLZ
         Wy/Tmeqbccdhog+bLyV75r9V0XWRG9lzZZqbtA4nH3tKUgvuoe1F11aF176DoW5UxxUx
         XlhQ==
X-Gm-Message-State: AOJu0Yz2QPE8f0pp/9YxmKwWyubI+n+HTe8IOm9eZN8vY8RN0q//QHZh
	DR6kstnwSHm6ARosL4BfyDE5kW861cKnB+htFtFqEhmtFwNMO64B3x0Rkg==
X-Google-Smtp-Source: AGHT+IF/S2chbVVgN+yPnHABejpoo8ifP2bZqpJf8cs3Tyc6YLaH9rDxpT5eAuURhdr8o0ULbCZm5CbGz0HFlBZF3Nc=
X-Received: by 2002:a05:622a:d0:b0:403:aa88:cf7e with SMTP id
 p16-20020a05622a00d000b00403aa88cf7emr595630qtw.29.1691483209473; Tue, 08 Aug
 2023 01:26:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADVnQyn3UMa3Qx6cC1Rx97xLjQdG0eKsiF7oY9UR=b9vU4R-yA@mail.gmail.com>
 <20230808055817.3979-1-me@manjusaka.me>
In-Reply-To: <20230808055817.3979-1-me@manjusaka.me>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 8 Aug 2023 10:26:36 +0200
Message-ID: <CANn89iKxJThy4ZVq4do6Z1bOZsRptfN6N8ydPaHQAmYKCjtOnw@mail.gmail.com>
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

On Tue, Aug 8, 2023 at 7:59=E2=80=AFAM Manjusaka <me@manjusaka.me> wrote:
>
> In normal use case, the tcp_ca_event would be changed in high frequency.
>
> It's a good indicator to represent the network quanlity.

quality ?

Honestly, it is more about TCP stack tracing than 'network quality'

>
> So I propose to add a `tcp:tcp_ca_event` trace event
> like `tcp:tcp_cong_state_set` to help the people to
> trace the TCP connection status
>
> Signed-off-by: Manjusaka <me@manjusaka.me>
> ---
>  include/net/tcp.h          |  9 ++------
>  include/trace/events/tcp.h | 45 ++++++++++++++++++++++++++++++++++++++
>  net/ipv4/tcp_cong.c        | 10 +++++++++
>  3 files changed, 57 insertions(+), 7 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 0ca972ebd3dd..a68c5b61889c 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1154,13 +1154,8 @@ static inline bool tcp_ca_needs_ecn(const struct s=
ock *sk)
>         return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ECN;
>  }
>
> -static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_event=
 event)
> -{
> -       const struct inet_connection_sock *icsk =3D inet_csk(sk);
> -
> -       if (icsk->icsk_ca_ops->cwnd_event)
> -               icsk->icsk_ca_ops->cwnd_event(sk, event);
> -}
> +/* from tcp_cong.c */
> +void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event);
>
>  /* From tcp_cong.c */
>  void tcp_set_ca_state(struct sock *sk, const u8 ca_state);
> diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> index bf06db8d2046..b374eb636af9 100644
> --- a/include/trace/events/tcp.h
> +++ b/include/trace/events/tcp.h
> @@ -416,6 +416,51 @@ TRACE_EVENT(tcp_cong_state_set,
>                   __entry->cong_state)
>  );
>
> +TRACE_EVENT(tcp_ca_event,
> +
> +       TP_PROTO(struct sock *sk, const u8 ca_event),
> +
> +       TP_ARGS(sk, ca_event),
> +
> +       TP_STRUCT__entry(
> +               __field(const void *, skaddr)
> +               __field(__u16, sport)
> +               __field(__u16, dport)
> +               __array(__u8, saddr, 4)
> +               __array(__u8, daddr, 4)
> +               __array(__u8, saddr_v6, 16)
> +               __array(__u8, daddr_v6, 16)
> +               __field(__u8, ca_event)
> +       ),
> +

Please add the family (look at commit 3dd344ea84e1 ("net: tracepoint:
exposing sk_family in all tcp:tracepoints"))



> +       TP_fast_assign(
> +               struct inet_sock *inet =3D inet_sk(sk);
> +               __be32 *p32;
> +
> +               __entry->skaddr =3D sk;
> +
> +               __entry->sport =3D ntohs(inet->inet_sport);
> +               __entry->dport =3D ntohs(inet->inet_dport);
> +
> +               p32 =3D (__be32 *) __entry->saddr;
> +               *p32 =3D inet->inet_saddr;
> +
> +               p32 =3D (__be32 *) __entry->daddr;
> +               *p32 =3D  inet->inet_daddr;

We keep copying IPv4 addresses that might contain garbage for IPv6 sockets =
:/

> +
> +               TP_STORE_ADDRS(__entry, inet->inet_saddr, inet->inet_dadd=
r,
> +                          sk->sk_v6_rcv_saddr, sk->sk_v6_daddr);

I will send a cleanup, because IP_STORE_ADDRS() should really take
care of all details.


> +
> +               __entry->ca_event =3D ca_event;
> +       ),
> +
> +       TP_printk("sport=3D%hu dport=3D%hu saddr=3D%pI4 daddr=3D%pI4 sadd=
rv6=3D%pI6c daddrv6=3D%pI6c ca_event=3D%u",
> +                 __entry->sport, __entry->dport,
> +                 __entry->saddr, __entry->daddr,
> +                 __entry->saddr_v6, __entry->daddr_v6,
> +                 __entry->ca_event)

Please print the symbol instead of numeric ca_event.

Look at show_tcp_state_name() for instance.

