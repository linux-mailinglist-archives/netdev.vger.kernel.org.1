Return-Path: <netdev+bounces-46494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1067E49CE
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 21:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACB391C20A1B
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 20:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD2136B17;
	Tue,  7 Nov 2023 20:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D9JHd0Ow"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DA4B64B
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 20:26:57 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE8D10CB
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 12:26:56 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so3300a12.0
        for <netdev@vger.kernel.org>; Tue, 07 Nov 2023 12:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699388815; x=1699993615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vq+hA4oPJs3kv1mDEP+OgI0oE3MCcvHPgYBlw1uM86c=;
        b=D9JHd0OwpmV+aQ//uJwTaEnwHyt8Y2ByLwNtNKv/LvQQq9/KKBivD68gP9ubsGLb1O
         0pfs1Nb1wr6Jlx+JBjWw8RAHro8xxg3SZevbjrveL42OC+Cj/xHMtmPf9JedrVF7TAa0
         2rr2HbsuYSuuXdmAbda/RsIYGKWtXmmOiDaAQe7XRUXcltg/n0R8UV3Kv/HnpctfTiEL
         P2ibPztiSEfdWEZkUPVGi1vxOi60J3ES6b0ADrQLnLWUXz/825lJs94kQYmpEcucSuX+
         HTbknJUw0bmcoSxdHJB3otzggyAfDGG+9M3nC1NzEbdn8civhcgPnEkD+KsDFGlQHCEY
         pacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699388815; x=1699993615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vq+hA4oPJs3kv1mDEP+OgI0oE3MCcvHPgYBlw1uM86c=;
        b=j2Wu0SMGs3hSJYYOPWyDuSt2tv9Gl5xf/lQWp/Ux5+dRpf6nwQo+KU9E+FvW37tAoK
         nXV5kZUYmrQdDoFNSskJxP4ireVxA0/4yZv6kntwcvEfXuVFaShQPKPboqakh6bs6UzH
         9TmZCpl7hT+OA2HV2gECdDvhoEWnfrcoWUzaS5rlHSWdy8UpJpRZDYz0Lh5wKgyo8mkK
         B/9uvopSyp9OwZYN9stlcftJ2rVmgtuEivBzTa+focLA+A7y30XbDT/JzL79rMx9imIj
         VCgWyWiQ9wsxdnZUGBxK1NV1JBzpr9b8H2O4vI14XcGD1YhCRuc3f1/fr6Z6H942RAqn
         8PPw==
X-Gm-Message-State: AOJu0YwopBcCAEJutHXDmrxi0uitLYObS9Jg2wJlmgY+xPud9vT+jYH+
	YR7+5SkqSeboFXsAOKYfctm2qb9wmOI/PXoWFB+Sew==
X-Google-Smtp-Source: AGHT+IEXc8pN8rbazqjTkrfrTtqYz18M3ugpAxLj2rmDbUgeReaOx9tXs8Do8h1jpHUCsXy78a+J0EwSyQDY9G9YMgc=
X-Received: by 2002:a50:d604:0:b0:544:24a8:ebd with SMTP id
 x4-20020a50d604000000b0054424a80ebdmr161593edi.4.1699388815164; Tue, 07 Nov
 2023 12:26:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230509180558.2541885-1-morleyd.kernel@gmail.com>
In-Reply-To: <20230509180558.2541885-1-morleyd.kernel@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 7 Nov 2023 21:26:41 +0100
Message-ID: <CANn89iJ4b83GKa+LnGUsaTvBwK+eGwaetktOwXfoR9J5b9JbzQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: make the first N SYN RTO backoffs linear
To: David Morley <morleyd.kernel@gmail.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	David Morley <morleyd@google.com>, Yuchung Cheng <ycheng@google.com>, 
	Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 9, 2023 at 8:06=E2=80=AFPM David Morley <morleyd.kernel@gmail.c=
om> wrote:
>
> From: David Morley <morleyd@google.com>
>
> Currently the SYN RTO schedule follows an exponential backoff
> scheme, which can be unnecessarily conservative in cases where
> there are link failures. In such cases, it's better to
> aggressively try to retransmit packets, so it takes routers
> less time to find a repath with a working link.
>
> We chose a default value for this sysctl of 4, to follow
> the macOS and IOS backoff scheme of 1,1,1,1,1,2,4,8, ...
> MacOS and IOS have used this backoff schedule for over
> a decade, since before this 2009 IETF presentation
> discussed the behavior:
> https://www.ietf.org/proceedings/75/slides/tcpm-1.pdf
>
> This commit makes the SYN RTO schedule start with a number of
> linear backoffs given by the following sysctl:
> * tcp_syn_linear_timeouts
>
> This changes the SYN RTO scheme to be: init_rto_val for
> tcp_syn_linear_timeouts, exp backoff starting at init_rto_val
>
> For example if init_rto_val =3D 1 and tcp_syn_linear_timeouts =3D 2, our
> backoff scheme would be: 1, 1, 1, 2, 4, 8, 16, ...
>
> Signed-off-by: David Morley <morleyd@google.com>
> Signed-off-by: Yuchung Cheng <ycheng@google.com>
> Signed-off-by: Neal Cardwell <ncardwell@google.com>
> Tested-by: David Morley <morleyd@google.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> ---
>  Documentation/networking/ip-sysctl.rst | 17 ++++++++++++++---
>  include/net/netns/ipv4.h               |  1 +
>  net/ipv4/sysctl_net_ipv4.c             | 10 ++++++++++
>  net/ipv4/tcp_ipv4.c                    |  1 +
>  net/ipv4/tcp_timer.c                   | 17 +++++++++++++----
>  5 files changed, 39 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/netwo=
rking/ip-sysctl.rst
> index 6ec06a33688a..3f6d3d5f5626 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -881,9 +881,10 @@ tcp_fastopen_key - list of comma separated 32-digit =
hexadecimal INTEGERs
>  tcp_syn_retries - INTEGER
>         Number of times initial SYNs for an active TCP connection attempt
>         will be retransmitted. Should not be higher than 127. Default val=
ue
> -       is 6, which corresponds to 63seconds till the last retransmission
> -       with the current initial RTO of 1second. With this the final time=
out
> -       for an active TCP connection attempt will happen after 127seconds=
.
> +       is 6, which corresponds to 67seconds (with tcp_syn_linear_timeout=
s =3D 4)
> +       till the last retransmission with the current initial RTO of 1sec=
ond.
> +       With this the final timeout for an active TCP connection attempt
> +       will happen after 131seconds.
>
>  tcp_timestamps - INTEGER
>         Enable timestamps as defined in RFC1323.
> @@ -946,6 +947,16 @@ tcp_pacing_ca_ratio - INTEGER
>
>         Default: 120
>
> +tcp_syn_linear_timeouts - INTEGER
> +       The number of times for an active TCP connection to retransmit SY=
Ns with
> +       a linear backoff timeout before defaulting to an exponential back=
off
> +       timeout. This has no effect on SYNACK at the passive TCP side.
> +
> +       With an initial RTO of 1 and tcp_syn_linear_timeouts =3D 4 we wou=
ld
> +       expect SYN RTOs to be: 1, 1, 1, 1, 1, 2, 4, ... (4 linear timeout=
s,
> +       and the first exponential backoff using 2^0 * initial_RTO).
> +       Default: 4
> +
>  tcp_tso_win_divisor - INTEGER
>         This allows control over what percentage of the congestion window
>         can be consumed by a single TSO frame.
> diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
> index db762e35aca9..a4efb7a2796c 100644
> --- a/include/net/netns/ipv4.h
> +++ b/include/net/netns/ipv4.h
> @@ -194,6 +194,7 @@ struct netns_ipv4 {
>         int sysctl_udp_rmem_min;
>
>         u8 sysctl_fib_notify_on_flag_change;
> +       u8 sysctl_tcp_syn_linear_timeouts;
>
>  #ifdef CONFIG_NET_L3_MASTER_DEV
>         u8 sysctl_udp_l3mdev_accept;
> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> index 40fe70fc2015..6ae3345a3bdf 100644
> --- a/net/ipv4/sysctl_net_ipv4.c
> +++ b/net/ipv4/sysctl_net_ipv4.c
> @@ -34,6 +34,7 @@ static int ip_ttl_min =3D 1;
>  static int ip_ttl_max =3D 255;
>  static int tcp_syn_retries_min =3D 1;
>  static int tcp_syn_retries_max =3D MAX_TCP_SYNCNT;
> +static int tcp_syn_linear_timeouts_max =3D MAX_TCP_SYNCNT;
>  static int ip_ping_group_range_min[] =3D { 0, 0 };
>  static int ip_ping_group_range_max[] =3D { GID_T_MAX, GID_T_MAX };
>  static u32 u32_max_div_HZ =3D UINT_MAX / HZ;
> @@ -1470,6 +1471,15 @@ static struct ctl_table ipv4_net_table[] =3D {
>                 .extra1         =3D SYSCTL_ZERO,
>                 .extra2         =3D &tcp_plb_max_cong_thresh,
>         },
> +       {
> +               .procname =3D "tcp_syn_linear_timeouts",
> +               .data =3D &init_net.ipv4.sysctl_tcp_syn_linear_timeouts,
> +               .maxlen =3D sizeof(u8),
> +               .mode =3D 0644,
> +               .proc_handler =3D proc_dou8vec_minmax,
> +               .extra1 =3D SYSCTL_ZERO,
> +               .extra2 =3D &tcp_syn_linear_timeouts_max,
> +       },
>         { }
>  };
>
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 39bda2b1066e..db24ed8f8509 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -3275,6 +3275,7 @@ static int __net_init tcp_sk_init(struct net *net)
>         else
>                 net->ipv4.tcp_congestion_control =3D &tcp_reno;
>
> +       net->ipv4.sysctl_tcp_syn_linear_timeouts =3D 4;
>         return 0;
>  }
>
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index b839c2f91292..0d93a2573807 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -234,14 +234,19 @@ static int tcp_write_timeout(struct sock *sk)
>         struct tcp_sock *tp =3D tcp_sk(sk);
>         struct net *net =3D sock_net(sk);
>         bool expired =3D false, do_reset;
> -       int retry_until;
> +       int retry_until, max_retransmits;
>
>         if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV)) {
>                 if (icsk->icsk_retransmits)
>                         __dst_negative_advice(sk);
>                 retry_until =3D icsk->icsk_syn_retries ? :
>                         READ_ONCE(net->ipv4.sysctl_tcp_syn_retries);
> -               expired =3D icsk->icsk_retransmits >=3D retry_until;
> +
> +               max_retransmits =3D retry_until;
> +               if (sk->sk_state =3D=3D TCP_SYN_SENT)
> +                       max_retransmits +=3D READ_ONCE(net->ipv4.sysctl_t=
cp_syn_linear_timeouts);
> +
> +               expired =3D icsk->icsk_retransmits >=3D max_retransmits;
>         } else {
>                 if (retransmits_timed_out(sk, READ_ONCE(net->ipv4.sysctl_=
tcp_retries1), 0)) {
>                         /* Black hole detection */
> @@ -577,8 +582,12 @@ void tcp_retransmit_timer(struct sock *sk)
>             icsk->icsk_retransmits <=3D TCP_THIN_LINEAR_RETRIES) {
>                 icsk->icsk_backoff =3D 0;
>                 icsk->icsk_rto =3D min(__tcp_set_rto(tp), TCP_RTO_MAX);
> -       } else {
> -               /* Use normal (exponential) backoff */
> +       } else if (sk->sk_state !=3D TCP_SYN_SENT ||
> +                  icsk->icsk_backoff >
> +                  READ_ONCE(net->ipv4.sysctl_tcp_syn_linear_timeouts)) {
> +               /* Use normal (exponential) backoff unless linear timeout=
s are
> +                * activated.
> +                */

Hi David, back to this patch.

If sysctl_tcp_syn_linear_timeouts is set to a high value, we could end up w=
ith
 icsk->icsk_backoff > 64

This can generate various overflows later, eg from inet_csk_rto_backoff(),
called from tcp_ld_RTO_revert()

More generally tcp_ld_RTO_revert() is not aware of linear timeouts.

Thank you.

