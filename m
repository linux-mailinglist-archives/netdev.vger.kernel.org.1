Return-Path: <netdev+bounces-49566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F1E7F273B
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 09:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF6B5282864
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 08:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAECD38FA1;
	Tue, 21 Nov 2023 08:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wOeDfqCq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486B1D6A
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 00:18:23 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-548c6efc020so10239a12.0
        for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 00:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700554702; x=1701159502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tImNK0HAC3h8at2LMrscyPDeWDs8XsM3oVqLvSbzmek=;
        b=wOeDfqCqaS4Ko7m87tAz7uHmUec2HNOSrmyIDv2VdVz4EJuUd+u9HxiWxKUC1zFw/v
         3OTYIZ6mJ7pLr3hsg3nuu4mAqVJpDWtROwz/JadzJVqK1pcn9jL/Sj19vcw61ov4XZDB
         Yn+0zH5bFhNlsd2XJa0Rksxww8zV7fwao51C7D3ac9ZccnKUJ/N+d+vWdJj9fJKDZ4Xz
         MO6XpzOHFMAv+KnRDC+UEeGzcED6zHopDcIiIH9jn6JqYUEe/TcAq3lVAy8P93qscKYS
         uVQDNhmVpGaNNjGXk8gNinxlbhXFp4o0zMjlH6XuI9qYnj0nhPC7gSveYwfNn1xKAmVN
         0tlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700554702; x=1701159502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tImNK0HAC3h8at2LMrscyPDeWDs8XsM3oVqLvSbzmek=;
        b=p/xmM1C47Zu7EtwSuWNbXhpw4vztut4qBn67nwPltaYufEFArsVRIjhrTytMrbiWxU
         8im1nU6ryu+MKvtoI3jbJEUDDsrW97ZyGdFvNS2Lkm5yS8TuGhAma5+SCEjfLvQ+1/yY
         kjVzepG4Su4+aYTo8/2+AaAmWGeQOeuKeYdhoMRYxRE4D/omuioifIxjJLH9S4kp6QDp
         I95ECgtn8bZ7P4spa5hGh01UmJYfBA5vM4dvsXCvgVPyCPUrduIuE5dhxgjB1IIvhrlt
         laAFSZojkiLLzA5H5t7VeRC4f4nDFOW6m0vTGQk7KfKuWPqSPdCLBmCpuSN5dycKhOjJ
         mI7g==
X-Gm-Message-State: AOJu0Yy3BLWpOrigGzr9HIwBrwsPoog+QA6xnzpxa8ULazGe8f2gSHrb
	T+ZDHm/fR4Rn8T2/KN96fU6+/68pAFS3YtyXks2NGp+c7eCo9yqP7BA=
X-Google-Smtp-Source: AGHT+IGLvpulRLsnUca8HoXd1vl18gKSh3Wwuxd2H4xwr46yVqyIzu+oZh97J0GTnolApKOSie5JTcYWtw796idZICY=
X-Received: by 2002:a05:6402:10ca:b0:544:466b:3b20 with SMTP id
 p10-20020a05640210ca00b00544466b3b20mr501485edu.5.1700554701871; Tue, 21 Nov
 2023 00:18:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121020111.1143180-1-dima@arista.com> <20231121020111.1143180-5-dima@arista.com>
In-Reply-To: <20231121020111.1143180-5-dima@arista.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 21 Nov 2023 09:18:10 +0100
Message-ID: <CANn89i+xvBQY5HLXNkjW0o9R4SX1hqRisJnr54ZqwuOpEJdHeA@mail.gmail.com>
Subject: Re: [PATCH 4/7] net/tcp: Reset TCP-AO cached keys on listen() syscall
To: Dmitry Safonov <dima@arista.com>
Cc: David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
	Dmitry Safonov <0x7f454c46@gmail.com>, Francesco Ruggeri <fruggeri05@gmail.com>, 
	Salam Noureddine <noureddine@arista.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 3:01=E2=80=AFAM Dmitry Safonov <dima@arista.com> wr=
ote:
>
> TCP_LISTEN sockets are not connected to any peer, so having
> current_key/rnext_key doesn't make sense.
>
> The userspace may falter over this issue by setting current or rnext
> TCP-AO key before listen() syscall. setsockopt(TCP_AO_DEL_KEY) doesn't
> allow removing a key that is in use (in accordance to RFC 5925), so
> it might be inconvenient to have keys that can be destroyed only with
> listener socket.

I think this is the wrong way to solve this issue. listen() should not
mess with anything else than socket state.

>
> Fixes: 4954f17ddefc ("net/tcp: Introduce TCP_AO setsockopt()s")
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  include/net/tcp_ao.h |  5 +++++
>  net/ipv4/af_inet.c   |  1 +
>  net/ipv4/tcp_ao.c    | 14 ++++++++++++++
>  3 files changed, 20 insertions(+)
>
> diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
> index 647781080613..e36057ca5ed8 100644
> --- a/include/net/tcp_ao.h
> +++ b/include/net/tcp_ao.h
> @@ -270,6 +270,7 @@ int tcp_v6_ao_synack_hash(char *ao_hash, struct tcp_a=
o_key *ao_key,
>  void tcp_ao_established(struct sock *sk);
>  void tcp_ao_finish_connect(struct sock *sk, struct sk_buff *skb);
>  void tcp_ao_connect_init(struct sock *sk);
> +void tcp_ao_listen(struct sock *sk);
>  void tcp_ao_syncookie(struct sock *sk, const struct sk_buff *skb,
>                       struct tcp_request_sock *treq,
>                       unsigned short int family, int l3index);
> @@ -330,6 +331,10 @@ static inline void tcp_ao_connect_init(struct sock *=
sk)
>  {
>  }
>
> +static inline void tcp_ao_listen(struct sock *sk)
> +{
> +}
> +
>  static inline int tcp_ao_get_mkts(struct sock *sk, sockptr_t optval, soc=
kptr_t optlen)
>  {
>         return -ENOPROTOOPT;
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index fb81de10d332..a08d1266344f 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -200,6 +200,7 @@ int __inet_listen_sk(struct sock *sk, int backlog)
>          * we can only allow the backlog to be adjusted.
>          */
>         if (old_state !=3D TCP_LISTEN) {
> +               tcp_ao_listen(sk);

Ouch...

Please add your hook in tcp_disconnect() instead of this layering violation=
.

I think you missed the fact that applications can call listen(fd,
backlog) multiple times,
if they need to dynamically adjust backlog.

