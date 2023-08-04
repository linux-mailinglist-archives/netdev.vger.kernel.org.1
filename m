Return-Path: <netdev+bounces-24457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB937703AE
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 16:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC152282734
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 14:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28E2CA5E;
	Fri,  4 Aug 2023 14:56:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BD7BA3B
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 14:56:22 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DDE49CC
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 07:56:15 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe32ec7201so78985e9.1
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 07:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691160974; x=1691765774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cY/scggGpO5kzNWgwuSaoYTwhuJc5Hh6OlpDr54KghU=;
        b=EkkEEIxxwfhc1Bygdhuj4QXKiBZOx4sVcd/P0fl25c/skhkV1amoTiiIXMajlyoqvH
         Cm+759+I0KzEr11hk2LBkDNIbc7yh/xvJziAS3kXFQZ2WURVhRvMrVGfc6CCZUH/JbAY
         tJca9JtRuLPoZ+VAF4GjK9ofRpGWjhvETJX4sGiUP3pl3aZZ0ogN6MfLLSTMW34dossX
         asvCtWQAAD2J00rIlwiKBYZHERJDc7pQV98o7Ato5R86lqpPHaxKOPbVeDFPafJSw6AA
         oh4m3YJoNItH4W699jG8mxmm7tJEtQ5V2e48ca72op7m9mO0HzKuELQu/phz8dQpTdOz
         g45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691160974; x=1691765774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cY/scggGpO5kzNWgwuSaoYTwhuJc5Hh6OlpDr54KghU=;
        b=hWQ3ELNpliQHmFQcanYJCLXaQ/Mck8/onnzidgv8IoufPufps0tIex5CHRP5iJ4Cfj
         3XgwLSIYK4k7CeQ5ffd/X6p5xCp6pyIw7ZoRw6l/MGlFxe3kBNeRwHhTJmKvuVjZo5ko
         oa+HHCS6DlsGuPBSUtI0jH/K3lLKCzHBOugV/VRiTWenssBmHVfEE/sg9Q5gqA+t85Ae
         xvGAy8o6G0SMFuwbfpG6fY9rqiIyTt3s+/tj7bjzXl3nQkdf4SwLQZRYl1xhkWwsvWDD
         gcls1d9TEunXODlmYcUCm8mNV1HCcrFn9JbZLf/LQbkKHGVixehPflft/rWcXIRpsuvN
         6IbA==
X-Gm-Message-State: AOJu0YyOTYkH8Csi3sxldahyAcsqCHj1ogsAqI9YZbNQ9xNvHuzP4EQq
	3v+UWuB/UPRdAOcXjsSS9wduvbBsg4P+MzUJh7Ul7g==
X-Google-Smtp-Source: AGHT+IHMY+jdpT2BgchNyNyZimIrzb7WMcUmN11RD1VBbTTfnnY2yfQwmiNLc+L1sGRoqYxn1nHERAgSJbIpsNfYK30=
X-Received: by 2002:a05:600c:4583:b0:3f1:6fe9:4a95 with SMTP id
 r3-20020a05600c458300b003f16fe94a95mr55195wmo.4.1691160973795; Fri, 04 Aug
 2023 07:56:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230804144616.3938718-1-edumazet@google.com> <20230804144616.3938718-2-edumazet@google.com>
In-Reply-To: <20230804144616.3938718-2-edumazet@google.com>
From: Soheil Hassas Yeganeh <soheil@google.com>
Date: Fri, 4 Aug 2023 10:55:37 -0400
Message-ID: <CACSApvaDR4-PSWfwigW5X3simF9gWsY7hVbUKuU4=1i87yk0SQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/6] tcp: set TCP_SYNCNT locklessly
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
> icsk->icsk_syn_retries can safely be set without locking the socket.
>
> We have to add READ_ONCE() annotations in tcp_fastopen_synack_timer()
> and tcp_write_timeout().
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Acked by: Soheil Hassas Yeganeh <soheil@google.com>

> ---
>  net/ipv4/tcp.c       | 15 ++++++---------
>  net/ipv4/tcp_timer.c |  9 ++++++---
>  2 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index aca5620cf3ba20be38d81b1b526c22623b145ff7..bcbb33a8c152abe2a060abd64=
4689b54bcca1daa 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -3291,9 +3291,7 @@ int tcp_sock_set_syncnt(struct sock *sk, int val)
>         if (val < 1 || val > MAX_TCP_SYNCNT)
>                 return -EINVAL;
>
> -       lock_sock(sk);
>         WRITE_ONCE(inet_csk(sk)->icsk_syn_retries, val);
> -       release_sock(sk);
>         return 0;
>  }
>  EXPORT_SYMBOL(tcp_sock_set_syncnt);
> @@ -3462,6 +3460,12 @@ int do_tcp_setsockopt(struct sock *sk, int level, =
int optname,
>         if (copy_from_sockptr(&val, optval, sizeof(val)))
>                 return -EFAULT;
>
> +       /* Handle options that can be set without locking the socket. */
> +       switch (optname) {
> +       case TCP_SYNCNT:
> +               return tcp_sock_set_syncnt(sk, val);
> +       }
> +
>         sockopt_lock_sock(sk);
>
>         switch (optname) {
> @@ -3569,13 +3573,6 @@ int do_tcp_setsockopt(struct sock *sk, int level, =
int optname,
>                 else
>                         WRITE_ONCE(tp->keepalive_probes, val);
>                 break;
> -       case TCP_SYNCNT:
> -               if (val < 1 || val > MAX_TCP_SYNCNT)
> -                       err =3D -EINVAL;
> -               else
> -                       WRITE_ONCE(icsk->icsk_syn_retries, val);
> -               break;
> -
>         case TCP_SAVE_SYN:
>                 /* 0: disable, 1: enable, 2: start from ether_header */
>                 if (val < 0 || val > 2)
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index 470f581eedd438b3bbd6ae4973c7a6f01ee1724f..66040ab457d46ffa2fac62f87=
5b636f567157793 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -239,7 +239,8 @@ static int tcp_write_timeout(struct sock *sk)
>         if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV)) {
>                 if (icsk->icsk_retransmits)
>                         __dst_negative_advice(sk);
> -               retry_until =3D icsk->icsk_syn_retries ? :
> +               /* Paired with WRITE_ONCE() in tcp_sock_set_syncnt() */
> +               retry_until =3D READ_ONCE(icsk->icsk_syn_retries) ? :
>                         READ_ONCE(net->ipv4.sysctl_tcp_syn_retries);
>
>                 max_retransmits =3D retry_until;
> @@ -421,8 +422,10 @@ static void tcp_fastopen_synack_timer(struct sock *s=
k, struct request_sock *req)
>
>         req->rsk_ops->syn_ack_timeout(req);
>
> -       /* add one more retry for fastopen */
> -       max_retries =3D icsk->icsk_syn_retries ? :
> +       /* Add one more retry for fastopen.
> +        * Paired with WRITE_ONCE() in tcp_sock_set_syncnt()
> +        */
> +       max_retries =3D READ_ONCE(icsk->icsk_syn_retries) ? :
>                 READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_synack_retries) +=
 1;
>
>         if (req->num_timeout >=3D max_retries) {
> --
> 2.41.0.640.ga95def55d0-goog
>

