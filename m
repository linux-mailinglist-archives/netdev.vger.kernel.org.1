Return-Path: <netdev+bounces-24489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6747077054E
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 17:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 207302827C2
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 15:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E181805F;
	Fri,  4 Aug 2023 15:54:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C770BE7B
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 15:54:03 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9953CB2
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 08:54:01 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5223910acf2so13856a12.0
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 08:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691164440; x=1691769240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BDTTj8vCGel3q1emkoDDclTApo6OkZJlni3NocJTbs=;
        b=X+MepxnImWNMgJLVn1RNJR6gd352DT2kdmEdm3q+tXzQTFpXCuRW0z5Cnbm0PDjSq0
         qkl1WUYxYrba/QHDZkg/+8GIHERoC2+Qnl2m/Jkql+pB+hKRB6vlm7N0HUOF9fHWEiJY
         RCPk/vk74S4mk43OkvlENVmDOqP+3zEwUFrvvdeiR+aY/BDJPdYa+aCL44cT0a5wpVUR
         gj09mRKFYH455pAJPSJeg65eFAixF+mOiGkssMM3V9SA4l9QkyVE19g4WXDEjDGb2NCh
         Pfj4rZoWH3Fc3cBMSQsBD+FbZKTKReRa4ABa7c/jVKB/QXFbAuZyWZwAlhKDryZTBnLo
         wQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691164440; x=1691769240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3BDTTj8vCGel3q1emkoDDclTApo6OkZJlni3NocJTbs=;
        b=iWMg5Zn2fzeWdfc+biyapLsezhd0YcUKfwou2XuiEOW1TqZslfMihEM9hSk/+JTEGA
         0ojcL6d2znF7Kxn8lswq7N+rshMZl0IojWUzyuXK3ISpYkhOgo1h4OksIvJisTK1nMhd
         711sUdpdo8yrQd8rqdSI5L9t51i2YpFcGS1Uhq+Jfj275GMOfJ6A1jrxfA9WMrlkTXhb
         2Oj953x/+Ug6vJiINAOheRpVwo49kIAqNZwvudsquiD7IX1XQ4GhxXgj7ijhshovD1c8
         p2V6qFgwsHGMqRDodMBKOuqrTmsA9ZI1y0tiOTzITVBj5LTKHPU6jWTwOm19GXcXtvv9
         O7lw==
X-Gm-Message-State: AOJu0Yx7uUtNG9GFvLXZOJQ9XPCD6MRnXJ+EJ9cixztNOkJRTjUNx5hh
	zQdz6Cb0WNUOMvGbAfSAzvvyYLb8NYZDMC8Vs2Jdbg==
X-Google-Smtp-Source: AGHT+IH5G666QQgLsy/jglnJoGRia2bH4AzeIn+5LhED9W9vROCmdKMmyDJArnlPBfXZUnJ+reY01bl9FuNpEzCl/OQ=
X-Received: by 2002:a50:c30e:0:b0:523:193b:5587 with SMTP id
 a14-20020a50c30e000000b00523193b5587mr105762edb.6.1691164439957; Fri, 04 Aug
 2023 08:53:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230804144616.3938718-1-edumazet@google.com> <20230804144616.3938718-6-edumazet@google.com>
In-Reply-To: <20230804144616.3938718-6-edumazet@google.com>
From: Soheil Hassas Yeganeh <soheil@google.com>
Date: Fri, 4 Aug 2023 11:53:23 -0400
Message-ID: <CACSApvZjQrgZhYj+2=r7YRABCCAi41oxtvLw+KAUS-zu6LV5Yg@mail.gmail.com>
Subject: Re: [PATCH net-next 5/6] tcp: set TCP_LINGER2 locklessly
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
> tp->linger2 can be set locklessly as long as readers
> use READ_ONCE().
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Acked-by: Soheil Hassas Yeganeh <soheil@google.com>

> ---
>  net/ipv4/tcp.c       | 19 +++++++++----------
>  net/ipv4/tcp_input.c |  2 +-
>  net/ipv4/tcp_timer.c |  2 +-
>  3 files changed, 11 insertions(+), 12 deletions(-)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index e74a9593283c91aa23fe23fdd125d4ba680a542c..5c71b4fe11d1c34456976d60e=
b8742641111dd62 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -2865,7 +2865,7 @@ void __tcp_close(struct sock *sk, long timeout)
>
>         if (sk->sk_state =3D=3D TCP_FIN_WAIT2) {
>                 struct tcp_sock *tp =3D tcp_sk(sk);
> -               if (tp->linger2 < 0) {
> +               if (READ_ONCE(tp->linger2) < 0) {
>                         tcp_set_state(sk, TCP_CLOSE);
>                         tcp_send_active_reset(sk, GFP_ATOMIC);
>                         __NET_INC_STATS(sock_net(sk),
> @@ -3471,6 +3471,14 @@ int do_tcp_setsockopt(struct sock *sk, int level, =
int optname,
>                 return tcp_sock_set_keepintvl(sk, val);
>         case TCP_KEEPCNT:
>                 return tcp_sock_set_keepcnt(sk, val);
> +       case TCP_LINGER2:
> +               if (val < 0)
> +                       WRITE_ONCE(tp->linger2, -1);
> +               else if (val > TCP_FIN_TIMEOUT_MAX / HZ)
> +                       WRITE_ONCE(tp->linger2, TCP_FIN_TIMEOUT_MAX);
> +               else
> +                       WRITE_ONCE(tp->linger2, val * HZ);
> +               return 0;
>         }
>
>         sockopt_lock_sock(sk);
> @@ -3576,15 +3584,6 @@ int do_tcp_setsockopt(struct sock *sk, int level, =
int optname,
>                         tp->save_syn =3D val;
>                 break;
>
> -       case TCP_LINGER2:
> -               if (val < 0)
> -                       WRITE_ONCE(tp->linger2, -1);
> -               else if (val > TCP_FIN_TIMEOUT_MAX / HZ)
> -                       WRITE_ONCE(tp->linger2, TCP_FIN_TIMEOUT_MAX);
> -               else
> -                       WRITE_ONCE(tp->linger2, val * HZ);
> -               break;
> -
>         case TCP_DEFER_ACCEPT:
>                 /* Translate value in seconds to number of retransmits */
>                 WRITE_ONCE(icsk->icsk_accept_queue.rskq_defer_accept,
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 670c3dab24f2b4d3ab4af84a2715a134cd22b443..f445f5a7c0ebf5f7ab2b24023=
57f3749d954c0e8 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -6625,7 +6625,7 @@ int tcp_rcv_state_process(struct sock *sk, struct s=
k_buff *skb)
>                         break;
>                 }
>
> -               if (tp->linger2 < 0) {
> +               if (READ_ONCE(tp->linger2) < 0) {
>                         tcp_done(sk);
>                         NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTOND=
ATA);
>                         return 1;
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index f99e2d06ae7cae72efcafe2bd664545fac8f3fee..d45c96c7f5a4473628bd76366=
c1b5694a2904aec 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -714,7 +714,7 @@ static void tcp_keepalive_timer (struct timer_list *t=
)
>
>         tcp_mstamp_refresh(tp);
>         if (sk->sk_state =3D=3D TCP_FIN_WAIT2 && sock_flag(sk, SOCK_DEAD)=
) {
> -               if (tp->linger2 >=3D 0) {
> +               if (READ_ONCE(tp->linger2) >=3D 0) {
>                         const int tmo =3D tcp_fin_time(sk) - TCP_TIMEWAIT=
_LEN;
>
>                         if (tmo > 0) {
> --
> 2.41.0.640.ga95def55d0-goog
>

