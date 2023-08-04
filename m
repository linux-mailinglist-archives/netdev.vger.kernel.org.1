Return-Path: <netdev+bounces-24485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C53DB770539
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 17:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016751C20FAB
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 15:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B7718052;
	Fri,  4 Aug 2023 15:50:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659E1BE7B
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 15:50:18 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD7E49EB
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 08:50:15 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe1e44fd2bso104445e9.0
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 08:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691164214; x=1691769014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/AXdks7So0eRzhXkeFlTCjWz4ERqmUUtiK6gN1WM0Q=;
        b=Pv7+u3gr88KSx4D53jLhLM34y0bTjG1+dA/IFR+cZk6ymQgVJRUPpxZ6qG2pO7xigW
         WlvZbsD8yM1uucu+ZhZyNeMULKmMhAvb8C3LwwjjBEbhPiqShXc3Ukw/L264u4KDa8Fh
         dxcRtudtuUd1VhFuD3Y65N/sV8CsU3tHacwM3CStFgpE2NMqUz6jo7Ihe0PoPeC3QNo1
         aPxxxhVuMXBmDI4a2ZRVKYtVscMoHA0b11R1NbFU3yF3zx136TwEWsO2CdZvPjiT3Hfh
         1E0Up4N0YJGVqPK7vtjyTa3Sjh7xHmRmuU+xW9Sk1dpihrx9h6q3rIzEUHyon142qOyA
         ZYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691164214; x=1691769014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/AXdks7So0eRzhXkeFlTCjWz4ERqmUUtiK6gN1WM0Q=;
        b=jc4ADromlAm8Ieq5ZNJ58wBajCeSdckdg75AF80OqhlRUO1hh2WDtY7dZ7USMeZHuh
         5qUYuhoANNg48gjeWajhEhMNyVL8E6k0Ox/a/BIfPkBeWmD5YIQ+tPlXad6GpN08sHL2
         irW5yH4ji0NAI6DXhTiEeVxNVfJS07SWe4f22lVwJvSmO5bgXRcmv+llmw0BK9SQpVtc
         d7OoL0UxqiJF4D+iGsmH1W9VDIwoDBVBxMNMbtSasnoWQ/EeMtnwyKrqMck4f0Ey59c6
         PnMxf7BXqOBw96EP9J2gGtnX1YkJlfskTkEkH5VXZsRr4Kh736R21iD+Ud20+i2Dy+7y
         mCDA==
X-Gm-Message-State: AOJu0YwvIjF92eQ6MR6aRr8m5hvCAHQnFdOpWNchDOnJM/VXBoCSK9px
	Xpw1MQc9aG+sbGF9A5w5WHwC8ulfl8VDL2SGCj6ZvQ==
X-Google-Smtp-Source: AGHT+IF0CKBhTI2KHruIRpIB1RjpvwdLMCf7ieUXRmMtXNpIofEYM3shIG2i51pqSw3jJI93Frjj++ssu38Sj5UsSzA=
X-Received: by 2002:a05:600c:c1:b0:3f1:73b8:b5fe with SMTP id
 u1-20020a05600c00c100b003f173b8b5femr64151wmm.3.1691164213758; Fri, 04 Aug
 2023 08:50:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230804144616.3938718-1-edumazet@google.com> <20230804144616.3938718-3-edumazet@google.com>
In-Reply-To: <20230804144616.3938718-3-edumazet@google.com>
From: Soheil Hassas Yeganeh <soheil@google.com>
Date: Fri, 4 Aug 2023 11:49:37 -0400
Message-ID: <CACSApvYiV71CN3O8DgEsDNmKOmNPX4PHHqvBRQVE3pztKSPjxQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/6] tcp: set TCP_USER_TIMEOUT locklessly
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 4, 2023 at 10:46=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> icsk->icsk_user_timeout can be set locklessly,
> if all read sides use READ_ONCE().
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Acked-by: Soheil Hassas Yeganeh <soheil@google.com>

> ---
>  include/linux/tcp.h  |  2 +-
>  net/ipv4/tcp.c       | 23 ++++++++++-------------
>  net/ipv4/tcp_timer.c | 37 ++++++++++++++++++++++---------------
>  3 files changed, 33 insertions(+), 29 deletions(-)
>
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index d16abdb3541a6c07a5d7db59915089f74ee25092..3c5efeeb024f651c90ae4a9ca=
704dcf16e4adb11 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -564,6 +564,6 @@ void __tcp_sock_set_nodelay(struct sock *sk, bool on)=
;
>  void tcp_sock_set_nodelay(struct sock *sk);
>  void tcp_sock_set_quickack(struct sock *sk, int val);
>  int tcp_sock_set_syncnt(struct sock *sk, int val);
> -void tcp_sock_set_user_timeout(struct sock *sk, u32 val);
> +int tcp_sock_set_user_timeout(struct sock *sk, int val);
>
>  #endif /* _LINUX_TCP_H */
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index bcbb33a8c152abe2a060abd644689b54bcca1daa..34c2a40b024779866216402e1=
d1de1802f8dfde4 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -3296,11 +3296,16 @@ int tcp_sock_set_syncnt(struct sock *sk, int val)
>  }
>  EXPORT_SYMBOL(tcp_sock_set_syncnt);
>
> -void tcp_sock_set_user_timeout(struct sock *sk, u32 val)
> +int tcp_sock_set_user_timeout(struct sock *sk, int val)
>  {
> -       lock_sock(sk);
> +       /* Cap the max time in ms TCP will retry or probe the window
> +        * before giving up and aborting (ETIMEDOUT) a connection.
> +        */
> +       if (val < 0)
> +               return -EINVAL;
> +
>         WRITE_ONCE(inet_csk(sk)->icsk_user_timeout, val);
> -       release_sock(sk);
> +       return 0;
>  }
>  EXPORT_SYMBOL(tcp_sock_set_user_timeout);
>
> @@ -3464,6 +3469,8 @@ int do_tcp_setsockopt(struct sock *sk, int level, i=
nt optname,
>         switch (optname) {
>         case TCP_SYNCNT:
>                 return tcp_sock_set_syncnt(sk, val);
> +       case TCP_USER_TIMEOUT:
> +               return tcp_sock_set_user_timeout(sk, val);
>         }
>
>         sockopt_lock_sock(sk);
> @@ -3611,16 +3618,6 @@ int do_tcp_setsockopt(struct sock *sk, int level, =
int optname,
>                 err =3D tp->af_specific->md5_parse(sk, optname, optval, o=
ptlen);
>                 break;
>  #endif
> -       case TCP_USER_TIMEOUT:
> -               /* Cap the max time in ms TCP will retry or probe the win=
dow
> -                * before giving up and aborting (ETIMEDOUT) a connection=
.
> -                */
> -               if (val < 0)
> -                       err =3D -EINVAL;
> -               else
> -                       WRITE_ONCE(icsk->icsk_user_timeout, val);
> -               break;
> -
>         case TCP_FASTOPEN:
>                 if (val >=3D 0 && ((1 << sk->sk_state) & (TCPF_CLOSE |
>                     TCPF_LISTEN))) {
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index 66040ab457d46ffa2fac62f875b636f567157793..f99e2d06ae7cae72efcafe2bd=
664545fac8f3fee 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -26,14 +26,15 @@
>  static u32 tcp_clamp_rto_to_user_timeout(const struct sock *sk)
>  {
>         struct inet_connection_sock *icsk =3D inet_csk(sk);
> -       u32 elapsed, start_ts;
> +       u32 elapsed, start_ts, user_timeout;
>         s32 remaining;
>
>         start_ts =3D tcp_sk(sk)->retrans_stamp;
> -       if (!icsk->icsk_user_timeout)
> +       user_timeout =3D READ_ONCE(icsk->icsk_user_timeout);
> +       if (!user_timeout)
>                 return icsk->icsk_rto;
>         elapsed =3D tcp_time_stamp(tcp_sk(sk)) - start_ts;
> -       remaining =3D icsk->icsk_user_timeout - elapsed;
> +       remaining =3D user_timeout - elapsed;
>         if (remaining <=3D 0)
>                 return 1; /* user timeout has passed; fire ASAP */
>
> @@ -43,16 +44,17 @@ static u32 tcp_clamp_rto_to_user_timeout(const struct=
 sock *sk)
>  u32 tcp_clamp_probe0_to_user_timeout(const struct sock *sk, u32 when)
>  {
>         struct inet_connection_sock *icsk =3D inet_csk(sk);
> -       u32 remaining;
> +       u32 remaining, user_timeout;
>         s32 elapsed;
>
> -       if (!icsk->icsk_user_timeout || !icsk->icsk_probes_tstamp)
> +       user_timeout =3D READ_ONCE(icsk->icsk_user_timeout);
> +       if (!user_timeout || !icsk->icsk_probes_tstamp)
>                 return when;
>
>         elapsed =3D tcp_jiffies32 - icsk->icsk_probes_tstamp;
>         if (unlikely(elapsed < 0))
>                 elapsed =3D 0;
> -       remaining =3D msecs_to_jiffies(icsk->icsk_user_timeout) - elapsed=
;
> +       remaining =3D msecs_to_jiffies(user_timeout) - elapsed;
>         remaining =3D max_t(u32, remaining, TCP_TIMEOUT_MIN);
>
>         return min_t(u32, remaining, when);
> @@ -270,7 +272,7 @@ static int tcp_write_timeout(struct sock *sk)
>         }
>         if (!expired)
>                 expired =3D retransmits_timed_out(sk, retry_until,
> -                                               icsk->icsk_user_timeout);
> +                                               READ_ONCE(icsk->icsk_user=
_timeout));
>         tcp_fastopen_active_detect_blackhole(sk, expired);
>
>         if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_RTO_CB_FLAG))
> @@ -384,13 +386,16 @@ static void tcp_probe_timer(struct sock *sk)
>          * corresponding system limit. We also implement similar policy w=
hen
>          * we use RTO to probe window in tcp_retransmit_timer().
>          */
> -       if (!icsk->icsk_probes_tstamp)
> +       if (!icsk->icsk_probes_tstamp) {
>                 icsk->icsk_probes_tstamp =3D tcp_jiffies32;
> -       else if (icsk->icsk_user_timeout &&
> -                (s32)(tcp_jiffies32 - icsk->icsk_probes_tstamp) >=3D
> -                msecs_to_jiffies(icsk->icsk_user_timeout))
> -               goto abort;
> +       } else {
> +               u32 user_timeout =3D READ_ONCE(icsk->icsk_user_timeout);
>
> +               if (user_timeout &&
> +                   (s32)(tcp_jiffies32 - icsk->icsk_probes_tstamp) >=3D
> +                    msecs_to_jiffies(user_timeout))
> +               goto abort;
> +       }
>         max_probes =3D READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_retries2);
>         if (sock_flag(sk, SOCK_DEAD)) {
>                 const bool alive =3D inet_csk_rto_backoff(icsk, TCP_RTO_M=
AX) < TCP_RTO_MAX;
> @@ -734,13 +739,15 @@ static void tcp_keepalive_timer (struct timer_list =
*t)
>         elapsed =3D keepalive_time_elapsed(tp);
>
>         if (elapsed >=3D keepalive_time_when(tp)) {
> +               u32 user_timeout =3D READ_ONCE(icsk->icsk_user_timeout);
> +
>                 /* If the TCP_USER_TIMEOUT option is enabled, use that
>                  * to determine when to timeout instead.
>                  */
> -               if ((icsk->icsk_user_timeout !=3D 0 &&
> -                   elapsed >=3D msecs_to_jiffies(icsk->icsk_user_timeout=
) &&
> +               if ((user_timeout !=3D 0 &&
> +                   elapsed >=3D msecs_to_jiffies(user_timeout) &&
>                     icsk->icsk_probes_out > 0) ||
> -                   (icsk->icsk_user_timeout =3D=3D 0 &&
> +                   (user_timeout =3D=3D 0 &&
>                     icsk->icsk_probes_out >=3D keepalive_probes(tp))) {
>                         tcp_send_active_reset(sk, GFP_ATOMIC);
>                         tcp_write_err(sk);
> --
> 2.41.0.640.ga95def55d0-goog
>

