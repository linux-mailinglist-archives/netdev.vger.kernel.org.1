Return-Path: <netdev+bounces-42565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DABB27CF54F
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 12:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 458E0B2142A
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 10:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6045718658;
	Thu, 19 Oct 2023 10:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NN0eH8Rb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FB7171D7
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:29:39 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FC4119
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 03:29:38 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53f647c84d4so8568a12.0
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 03:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697711376; x=1698316176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tl59jjLu8+lWOCaLg5DJNl4ZcDTOOZVmQkXhfSEyjCI=;
        b=NN0eH8RbsOz569IboTvo5q7MYy+8G4xPYKiWfU9Uu2CNboin3hmo9E+a9vLBG0cGAQ
         fBWabhgYhvR8/pLxHSCMqoQ3QFlRq5KRfZDRDuxfXIIVPgGsbknna7YRlu8IXJEqqO+8
         ud27CG8PttyQDQvd4YxkpOcu3a/2GOECkrwEnqva7YQPPeAN/XZ31gEvoEsdbF0bXYPu
         H9o0qeK6SoAI8/8F4mVHqiPx5IOIAQ/gD2NrtzOxIZMiokONOHJoc1sqa3oEuuAPIvSZ
         JlBGM7IvnK6BAetX+kLSC6vfoIVCCBJ6ZtC11wCy9AbNJ8DW8yLV+8bL8fDjkXgYmL1r
         j+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697711376; x=1698316176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tl59jjLu8+lWOCaLg5DJNl4ZcDTOOZVmQkXhfSEyjCI=;
        b=HxY9Xa407ZyYG4Yusp7gGBXpVyBd4JUFYJPWmj5G3TW0mhvnJn+FhQrSPS4xrw+Quw
         b0lQNJKqgoGIsaQ/pV4+AK5t5S6tjUQr2IGEwYtJfiT6YW41fM1CwyadMYK8drfp050K
         fv9pomygIqIFJcRz9meDcUIT45F4baj3TXCNTt4IKG25Bjj2MLziEhBAbGSpOw1t4HxK
         DznJ/Gx8Kd94Av6v412d82aqayyv3pSwp1DOsjqTeuvEZVjrf5RYAtEmrc15z1egRUzv
         Fz8CF6lds2Kfy6VwbcW1Y3AXsYV2iOST2snS0PJH64YWhevB4XqJq/7Rpbnt3bJFkkg6
         PlcQ==
X-Gm-Message-State: AOJu0YzoBCAL+I7DC7Dk0Kv2Jr7ninYmTn9UPn3dBkHNh9I7sPRXFMJV
	UFv77Htobu2jKf5pSU0f8PDzNZm0HZIQsh1SqnnjRQ==
X-Google-Smtp-Source: AGHT+IHAnfKHdXXJb/348RxKyewv81hGuaU6X/2RMF6+MDYRS3t56/EoGYyigGhhatc1vLoTKUkbLRo95++7/i2AR10=
X-Received: by 2002:a05:6402:2cd:b0:53f:9243:310c with SMTP id
 b13-20020a05640202cd00b0053f9243310cmr73367edx.1.1697711376346; Thu, 19 Oct
 2023 03:29:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231019100237.1118733-1-edumazet@google.com>
In-Reply-To: <20231019100237.1118733-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 19 Oct 2023 12:29:23 +0200
Message-ID: <CANn89i+Np15xv7m1q0E6ZF5ZF2figQ2Ydyf9gdhHFamcCuwi8w@mail.gmail.com>
Subject: Re: [PATCH net] net: do not leave an empty skb in write queue
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 12:02=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> Under memory stress conditions, tcp_sendmsg_locked()
> might call sk_stream_wait_memory(), thus releasing the socket lock.
>
> If a fresh skb has been allocated prior to this,
> we should not leave it in the write queue otherwise
> tcp_write_xmit() could panic.
>
> This apparently does not happen often, but a future change
> in __sk_mem_raise_allocated() that Shakeel and others are
> considering would increase chances of being hurt.
>
> Under discussion is to remove this controversial part:
>
>     /* Fail only if socket is _under_ its sndbuf.
>      * In this case we cannot block, so that we have to fail.
>      */
>     if (sk->sk_wmem_queued + size >=3D sk->sk_sndbuf) {
>         /* Force charge with __GFP_NOFAIL */
>         if (memcg_charge && !charged) {
>             mem_cgroup_charge_skmem(sk->sk_memcg, amt,
>                         gfp_memcg_charge() | __GFP_NOFAIL);
>         }
>         return 1;
>     }
>
> Fixes: fdfc5c8594c2 ("tcp: remove empty skb from write queue in error cas=
es")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> ---
>  net/ipv4/tcp.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index d3456cf840de35b28a6adb682e27d426b0a60f84..a9a49e1d3da11bc6f9ed3baad=
5dd581400d50c69 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -927,10 +927,11 @@ int tcp_send_mss(struct sock *sk, int *size_goal, i=
nt flags)
>         return mss_now;
>  }
>
> -/* In some cases, both sendmsg() could have added an skb to the write qu=
eue,
> - * but failed adding payload on it.  We need to remove it to consume les=
s
> +/* In some cases, sendmsg() could have added an skb to the write queue,
> + * but failed adding payload on it. We need to remove it to consume less
>   * memory, but more importantly be able to generate EPOLLOUT for Edge Tr=
igger
> - * epoll() users.
> + * epoll() users. Another reason is that tcp_write_xmit() does not like
> + * finding an empty skb in the write queue.
>   */
>  void tcp_remove_empty_skb(struct sock *sk)
>  {
> @@ -1293,6 +1294,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msgh=
dr *msg, size_t size)
>                         tcp_push(sk, flags & ~MSG_MORE, mss_now,
>                                  TCP_NAGLE_PUSH, size_goal);
>
> +               tcp_remove_empty_skb(sk);

I will send a v2, moving this before calling tcp_push(), to be on the safe =
side.

