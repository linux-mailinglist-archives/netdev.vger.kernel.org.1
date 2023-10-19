Return-Path: <netdev+bounces-42771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AF27D0119
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 20:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78505B210A9
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 18:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA2137155;
	Thu, 19 Oct 2023 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UwIUln6e"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CC032C7D
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 18:01:26 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653B411B
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 11:01:25 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c9b70b9671so17095ad.1
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 11:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697738485; x=1698343285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tI703coXBK6ZyyMiEh9HDIUrG7b///tICFs8SpQIvg=;
        b=UwIUln6eteTwXEZKJ+waWXzaDUfFRivjs+jssz4Egm19Kui8BcXZhniPSNOyROH4U4
         hphUNNFSqQxScXEO08nJ0jHsTmaVLhfapBa+LOAtSirDWT0HJVYun+Hm9DbUJeJo9fML
         q6K0fSm4TuBFE0CAMM+j/EiJNxxQMh9UPfHvLiTtYoacqy1n8ecf1W42lWCljSL/FRJo
         MRKlW2GGh+mMyeOoIA2XQYLz3mNKelBzVggLcJIWsZvk9XxAsNQSZSVB9+Qx6Nl2tcWZ
         g8Gk5yFD+e09Zk+4qCwW7HOzu6N3RvGvRjdSvbhziN93/G0T+ONkCl+rgg35qxrInWIN
         8eGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697738485; x=1698343285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4tI703coXBK6ZyyMiEh9HDIUrG7b///tICFs8SpQIvg=;
        b=kor+Knwv9ZwEftnfU8C0Nhb81nCagEJ1md3TTVbE6nhpyAW8v8dSNQR/5AwN08sZfR
         5z4FAKnTepuwXvNTY4v6rpcb3J7DNwuGoT6LydLAGj1qKcvyw0orVAu8DnUCKZxHwZk3
         jljOgQ0ihUgH9DsDrh6FaDpiXRdSB+hmkDEAs0hkNse2obqBCeHJR7we/RnGt097+Ojn
         f6NVUR4AtOrJkjOK9jkmhCc/oEBsAP1KdKzwBsAUk6Y6fJJS/t1bh/CJovfhKllwlxKh
         A6viUBbekWjNAXlX19jWPEXOsh8MwS7N9vEKFTRgzwr/Hl7g8sR7hrGpfIuhb6TaRlZF
         2HXg==
X-Gm-Message-State: AOJu0YzLysnkHmkzPiI7zbVcrHEbbkeYbYuJ6ksPlhGJQnvnFVgQTGe2
	EdXnl+Bu3Xjj3y5jzuMekP+rzvta4IgzzlEA9hma2Ff8FKBs2WBW4mU=
X-Google-Smtp-Source: AGHT+IGZBZWsSxGE4O6F+RkIFsLeKm1aUwI2KcipjEAPTr1RhgNWvoc0JB6NHxQZrfAIXoOOhSi2yzd8k5yk5AV4u5w=
X-Received: by 2002:a17:902:eb4a:b0:1c2:446:5259 with SMTP id
 i10-20020a170902eb4a00b001c204465259mr4342pli.19.1697738484580; Thu, 19 Oct
 2023 11:01:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231019112457.1190114-1-edumazet@google.com>
In-Reply-To: <20231019112457.1190114-1-edumazet@google.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Thu, 19 Oct 2023 11:01:12 -0700
Message-ID: <CALvZod4PiVHUvsWuLcv=1r9HWGj+my49Xy676AMG4=qFZbcfSw@mail.gmail.com>
Subject: Re: [PATCH v2 net] net: do not leave an empty skb in write queue
To: Eric Dumazet <edumazet@google.com>, Abel Wu <wuyun.abel@bytedance.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Abel Wu

On Thu, Oct 19, 2023 at 4:24=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
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
>                 gfp_memcg_charge() | __GFP_NOFAIL);
>         }
>         return 1;
>     }
>
> Fixes: fdfc5c8594c2 ("tcp: remove empty skb from write queue in error cas=
es")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Shakeel Butt <shakeelb@google.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> ---
> v2: call tcp_remove_empty_skb() before tcp_push()
>
>  net/ipv4/tcp.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index d3456cf840de35b28a6adb682e27d426b0a60f84..3d3a24f795734eecd60fc761f=
25f48b7a27714d4 100644
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
> @@ -1289,6 +1290,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msgh=
dr *msg, size_t size)
>
>  wait_for_space:
>                 set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> +               tcp_remove_empty_skb(sk);
>                 if (copied)
>                         tcp_push(sk, flags & ~MSG_MORE, mss_now,
>                                  TCP_NAGLE_PUSH, size_goal);
> --
> 2.42.0.655.g421f12c284-goog
>

