Return-Path: <netdev+bounces-24536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C067707A4
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 20:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA192280ED3
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 18:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1213C1BEFA;
	Fri,  4 Aug 2023 18:14:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30DC1BEEE
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 18:14:42 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3339149FF
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 11:14:40 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f58444a410so261e87.0
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 11:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691172878; x=1691777678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdZCwFa36JO7BjsIbThExqBKcO0c7z5StX355eJbFLg=;
        b=B4vuBvEhpk4Vafi4VodSqggfnJv5xvaegTgwDg1KmoR+wxH9QfrK75UPXgOtgto3z+
         IyK/IeaRS6PagqSGvjBmNgTv10I+HqxxTRXJr/hiURPtBhtuFd/bXer5ZoyO4Ozt3sfA
         FXJufW5eM8TcNYvxg/wFI29rrKPs7irClTgKVcPi8uYjbqGzEea0w91nIfomJaI2XSd3
         Yv+TzxLSwT6hOjVfSu4eZr5Fqttuc3zkjRvvt1LYoWW5U8zQr6jVng6BMzSjsmOxNCOI
         pULdwRDrVOeKIsHetyWai2aZeOqYGcJ9QDMLX548Zv5Is6p7TRXQIic+Bs/cde+IFaOZ
         yN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691172878; x=1691777678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cdZCwFa36JO7BjsIbThExqBKcO0c7z5StX355eJbFLg=;
        b=b5ZOlvpSkh/v0SbnPrKXPsmRwz/CMpS018R0b1nTdV5YvkmhbqBulbnrXS9ecmoPBG
         Z5PHB5Bn6HcOCxKDOMQ3BlWHbAZjY8l6VrpLG8i3FDw81SQB00NwaQrpO6JQi2m3tDUX
         nZjmHKK8AuseHIDX1h5J38T8tGRTduN7j8R1v8p8/KVXUks18/lEUCd7C8vZZOrCfUhQ
         /1p+ew/osq60Srqp/sIrFIqvS2hybvOOgh6MeAYZeSAqNyFUKQKZgujMURqvZUL/y/md
         BZijlMMY0tRG+w1YGu6QyROo1jMJTklSYPphWXyZuW7y5+1jL3xXdEsEB3pQStL4y1ws
         PMWQ==
X-Gm-Message-State: AOJu0Yw9n8E9XFpZMFuvB9lWUIJUZ/G9ucA5uBDGSvlFiaU4IBWJHHfA
	FAYenorhteMKwgqx71qd1BxLua+/taBgyGYvkoXNn+yV/RysEM1XbEY=
X-Google-Smtp-Source: AGHT+IEymirBKkbuOvMuquqrRLiBptCAS+xzd4xHI2CiNUt73PeaxC9xk3HwrkjRk/5C/MCL+dgCbYpQxaY72s5/ClI=
X-Received: by 2002:ac2:44cb:0:b0:4fe:3b86:ce7d with SMTP id
 d11-20020ac244cb000000b004fe3b86ce7dmr6508lfm.7.1691172877916; Fri, 04 Aug
 2023 11:14:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230804144616.3938718-1-edumazet@google.com> <20230804144616.3938718-7-edumazet@google.com>
In-Reply-To: <20230804144616.3938718-7-edumazet@google.com>
From: Soheil Hassas Yeganeh <soheil@google.com>
Date: Fri, 4 Aug 2023 14:14:01 -0400
Message-ID: <CACSApva+Yvejq25dwCi7JjodLkuCi9_K+bCb3to0iyND6CnZVw@mail.gmail.com>
Subject: Re: [PATCH net-next 6/6] tcp: set TCP_DEFER_ACCEPT locklessly
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
> rskq_defer_accept field can be read/written without
> the need of holding the socket lock.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Acked-by: Soheil Hassas Yeganeh <soheil@google.com>

Very nice series! Thank you!  I doulbechecked every field and they are
all READ_ONCE/WRITE_ONCE paired.

> ---
>  net/ipv4/tcp.c           | 13 ++++++-------
>  net/ipv4/tcp_input.c     |  2 +-
>  net/ipv4/tcp_minisocks.c |  2 +-
>  3 files changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 5c71b4fe11d1c34456976d60eb8742641111dd62..4fbc7ff8c53c05cbef3d10852=
7239c7ec8c1363e 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -3479,6 +3479,12 @@ int do_tcp_setsockopt(struct sock *sk, int level, =
int optname,
>                 else
>                         WRITE_ONCE(tp->linger2, val * HZ);
>                 return 0;
> +       case TCP_DEFER_ACCEPT:
> +               /* Translate value in seconds to number of retransmits */
> +               WRITE_ONCE(icsk->icsk_accept_queue.rskq_defer_accept,
> +                          secs_to_retrans(val, TCP_TIMEOUT_INIT / HZ,
> +                                          TCP_RTO_MAX / HZ));
> +               return 0;
>         }
>
>         sockopt_lock_sock(sk);
> @@ -3584,13 +3590,6 @@ int do_tcp_setsockopt(struct sock *sk, int level, =
int optname,
>                         tp->save_syn =3D val;
>                 break;
>
> -       case TCP_DEFER_ACCEPT:
> -               /* Translate value in seconds to number of retransmits */
> -               WRITE_ONCE(icsk->icsk_accept_queue.rskq_defer_accept,
> -                          secs_to_retrans(val, TCP_TIMEOUT_INIT / HZ,
> -                                          TCP_RTO_MAX / HZ));
> -               break;
> -
>         case TCP_WINDOW_CLAMP:
>                 err =3D tcp_set_window_clamp(sk, val);
>                 break;
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index f445f5a7c0ebf5f7ab2b2402357f3749d954c0e8..972c3b16369589293eb15febe=
52e72d5c596b032 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -6325,7 +6325,7 @@ static int tcp_rcv_synsent_state_process(struct soc=
k *sk, struct sk_buff *skb,
>                 if (fastopen_fail)
>                         return -1;
>                 if (sk->sk_write_pending ||
> -                   icsk->icsk_accept_queue.rskq_defer_accept ||
> +                   READ_ONCE(icsk->icsk_accept_queue.rskq_defer_accept) =
||
>                     inet_csk_in_pingpong_mode(sk)) {
>                         /* Save one ACK. Data will be ready after
>                          * several ticks, if write_pending is set.
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index c8f2aa0033871ed3f8b6b045c2cbca6e88bf2b61..32a70e3530db3247986ab5cb0=
8c8a46babf86ad6 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -794,7 +794,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk=
_buff *skb,
>                 return sk;
>
>         /* While TCP_DEFER_ACCEPT is active, drop bare ACK. */
> -       if (req->num_timeout < inet_csk(sk)->icsk_accept_queue.rskq_defer=
_accept &&
> +       if (req->num_timeout < READ_ONCE(inet_csk(sk)->icsk_accept_queue.=
rskq_defer_accept) &&
>             TCP_SKB_CB(skb)->end_seq =3D=3D tcp_rsk(req)->rcv_isn + 1) {
>                 inet_rsk(req)->acked =3D 1;
>                 __NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPDEFERACCEPTDRO=
P);
> --
> 2.41.0.640.ga95def55d0-goog
>

