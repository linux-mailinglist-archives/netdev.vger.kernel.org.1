Return-Path: <netdev+bounces-51730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E75CF7FBE5B
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A737C282766
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06041E49A;
	Tue, 28 Nov 2023 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z8zeHgX+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27AE10EB
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:42:53 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54b0c368d98so10554a12.1
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701186172; x=1701790972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qstXbblwKn4sp8IDzGVKznIdjZXNIG4sDGZiR0UJE4=;
        b=z8zeHgX+HTE+bX17FDR8bXkVsiv/IuzIvONGP/7P+5FcyRQ7v3VS6Mp+5L50PJzVao
         D50nThddpM0Nh3lwJspZ62YrfUFWsk9zCsdqEDbaFWLR5QBf1/azFgSOiiBcxhBEiTBn
         J2oF11hB4EJeiZnte1bd5+JzMMDAYRUuJs/zpw/Y0V4+fuB92qgyOwQ555FVNnhlzg+E
         CZtQLlIOxSBhmA+N75NY2xGV8LXiD2+yoQ55vp0pEtU2iq9TdAz91gUmF+J+rmiRuMK9
         XPaUjm+TMI3Zp8sHzPmmLsXbymKbj6762BDPLZZrkcKr8yjR8sq7lAgZExIzZdUlJm84
         eU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701186172; x=1701790972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qstXbblwKn4sp8IDzGVKznIdjZXNIG4sDGZiR0UJE4=;
        b=a94sWqA3cQFnc9elhLv9v2vuUdRjtrIDU15Mui32W+BB6a+xNpl61/p26ln8DKXqgr
         lBIi3h+iQfAKzUV0fOWKV09by8tcB5tYaUGRiJUQgn3mTizgfH4Jd8seOIXlcis8sJ3b
         t4ej/Bl9b/sUhfgBWvEK8f2KtT4miW8Ax3hUGDlgJJCCiAJEEqs0/gHKK+yC1aJbZoIY
         ENtPgE13n1mOg3YaHZ5aHJglmyi/I+t1dNaLfTeS93H0BHPNi4s6iA10VvZb8efFCfjU
         rB9yQQ8q6fNG110dUA+ZZp4UclKkS8PqD3nIQcTH5DTpoIW5CDP9LulfGT+WGBsjrhUi
         cX4Q==
X-Gm-Message-State: AOJu0YxFZ2ZzYVeU6KqzR1x/umq+ZQpNQ0hhDPRhUUWEF2SCudYf7kd6
	5vdDsmVvLNDnSXcKzcF95ubQbHpueMpXhDrQ/E9TjQ==
X-Google-Smtp-Source: AGHT+IG3M5Ou+AyXXhkH2jqaTfE4kwMyd0feJhDMx0lP/WprJFH1Yy+pTrnhMZ9bIvY8tnO3AwssEjmVNQFp244utG4=
X-Received: by 2002:a05:6402:3815:b0:544:466b:3b20 with SMTP id
 es21-20020a056402381500b00544466b3b20mr835997edb.5.1701186172124; Tue, 28 Nov
 2023 07:42:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231125011638.72056-1-kuniyu@amazon.com> <20231125011638.72056-9-kuniyu@amazon.com>
In-Reply-To: <20231125011638.72056-9-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Nov 2023 16:42:38 +0100
Message-ID: <CANn89iKBaD+4GyZfee58VikB+MPmOS4uUy4dh1taER9PgB7sdQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 8/8] tcp: Factorise cookie-dependent fields
 initialisation in cookie_v[46]_check()
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2023 at 2:20=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> We will support arbitrary SYN Cookie with BPF, and then kfunc at
> TC will preallocate reqsk and initialise some fields that should
> not be overwritten later by cookie_v[46]_check().
>
> To simplify the flow in cookie_v[46]_check(), we move such fields'
> initialisation to cookie_tcp_reqsk_alloc() and factorise non-BPF
> SYN Cookie handling into cookie_tcp_check(), where we validate the
> cookie and allocate reqsk, as done by kfunc later.
>
> Note that we set ireq->ecn_ok in two steps, the latter of which will
> be shared by the BPF case.  As cookie_ecn_ok() is one-liner, now
> it's inlined.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
>  include/net/tcp.h     |  13 ++++--
>  net/ipv4/syncookies.c | 106 +++++++++++++++++++++++-------------------
>  net/ipv6/syncookies.c |  61 ++++++++++++------------
>  3 files changed, 99 insertions(+), 81 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index d4d0e9763175..973555cb1d3f 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -494,7 +494,10 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, st=
ruct sk_buff *skb,
>  int __cookie_v4_check(const struct iphdr *iph, const struct tcphdr *th);
>  struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb);
>  struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_op=
s *ops,
> -                                           struct sock *sk, struct sk_bu=
ff *skb);
> +                                           struct sock *sk, struct sk_bu=
ff *skb,
> +                                           struct tcp_options_received *=
tcp_opt,
> +                                           int mss, u32 tsoff);
> +
>  #ifdef CONFIG_SYN_COOKIES
>
>  /* Syncookies use a monotonic timer which increments every 60 seconds.
> @@ -580,8 +583,12 @@ __u32 cookie_v4_init_sequence(const struct sk_buff *=
skb, __u16 *mss);
>  u64 cookie_init_timestamp(struct request_sock *req, u64 now);
>  bool cookie_timestamp_decode(const struct net *net,
>                              struct tcp_options_received *opt);
> -bool cookie_ecn_ok(const struct tcp_options_received *opt,
> -                  const struct net *net, const struct dst_entry *dst);
> +
> +static inline bool cookie_ecn_ok(const struct net *net, const struct dst=
_entry *dst)
> +{
> +       return READ_ONCE(net->ipv4.sysctl_tcp_ecn) ||
> +               dst_feature(dst, RTAX_FEATURE_ECN);
> +}
>
>  /* From net/ipv6/syncookies.c */
>  int __cookie_v6_check(const struct ipv6hdr *iph, const struct tcphdr *th=
);
> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index f4bcd4822fe0..5be12f186c26 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -270,21 +270,6 @@ bool cookie_timestamp_decode(const struct net *net,
>  }
>  EXPORT_SYMBOL(cookie_timestamp_decode);
>
> -bool cookie_ecn_ok(const struct tcp_options_received *tcp_opt,
> -                  const struct net *net, const struct dst_entry *dst)
> -{
> -       bool ecn_ok =3D tcp_opt->rcv_tsecr & TS_OPT_ECN;
> -
> -       if (!ecn_ok)
> -               return false;
> -
> -       if (READ_ONCE(net->ipv4.sysctl_tcp_ecn))
> -               return true;
> -
> -       return dst_feature(dst, RTAX_FEATURE_ECN);
> -}
> -EXPORT_SYMBOL(cookie_ecn_ok);
> -
>  static int cookie_tcp_reqsk_init(struct sock *sk, struct sk_buff *skb,
>                                  struct request_sock *req)
>  {
> @@ -320,8 +305,12 @@ static int cookie_tcp_reqsk_init(struct sock *sk, st=
ruct sk_buff *skb,
>  }
>
>  struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_op=
s *ops,
> -                                           struct sock *sk, struct sk_bu=
ff *skb)
> +                                           struct sock *sk, struct sk_bu=
ff *skb,
> +                                           struct tcp_options_received *=
tcp_opt,
> +                                           int mss, u32 tsoff)
>  {
> +       struct inet_request_sock *ireq;
> +       struct tcp_request_sock *treq;
>         struct request_sock *req;
>
>         if (sk_is_mptcp(sk))
> @@ -337,40 +326,36 @@ struct request_sock *cookie_tcp_reqsk_alloc(const s=
truct request_sock_ops *ops,
>                 return NULL;
>         }
>
> +       ireq =3D inet_rsk(req);
> +       treq =3D tcp_rsk(req);
> +
> +       req->mss =3D mss;
> +       req->ts_recent =3D tcp_opt->saw_tstamp ? tcp_opt->rcv_tsval : 0;
> +
> +       ireq->snd_wscale =3D tcp_opt->snd_wscale;
> +       ireq->tstamp_ok =3D tcp_opt->saw_tstamp;
> +       ireq->sack_ok =3D tcp_opt->sack_ok;
> +       ireq->wscale_ok =3D tcp_opt->wscale_ok;
> +       ireq->ecn_ok =3D tcp_opt->rcv_tsecr & TS_OPT_ECN;

I doubt this will do what you/we want, because ireq->ecn is not a
bool, it is a one bit field
and TS_OPT_ECN !=3D 1.

I would have used instead :

 ireq->ecn_ok =3D !!(tcp_opt->rcv_tsecr & TS_OPT_ECN);

> +
> +       treq->ts_off =3D tsoff;
> +
>         return req;
>  }

