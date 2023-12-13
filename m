Return-Path: <netdev+bounces-56923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 556BA811602
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 16:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1ED81C21017
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 15:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F0F31596;
	Wed, 13 Dec 2023 15:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWuCP1dQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F215C10B
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 07:19:37 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5d3644ca426so69149827b3.1
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 07:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702480777; x=1703085577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4SiqgWE2z2nnUJVxQ9cK7e0IWmQ+Y1XMshpCBescfs=;
        b=SWuCP1dQ6ILcxJNT5VX2GOFzgAC55FGNuKK0lCFGNMN94JVDHHw5rDmgJ2dtGfnYCK
         1JWAGYCfty68+aEqKas25dNFHhtWFgCXswqz2AMEtZafqFJd4sQGqPE8B2aomsK1C3pc
         bIbOnaZX/f0coNvtI7V+c6nfMjuzAs97xSt3l2dAWRy0I8SgBzmr9zye43UiVYtcrAlq
         JFSc24Pb5DdcxJyvcHtUQkvhQuXzp75fR6upghjS/+NcXdmkFbxwGHoi/XQ5TYUozn0x
         GZ+fRh/u1TH5MkFvTX9buDztlFuWCFOKJ/CTV151h8U2+M8xOoB6dhY1iOUGV29WwSil
         JIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702480777; x=1703085577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4SiqgWE2z2nnUJVxQ9cK7e0IWmQ+Y1XMshpCBescfs=;
        b=nE+nlugGXrQSOIBhQZ4+BD0I5/R0S+6asUqak8PazexbkDRelwqbFNfY7rltHvkUUE
         +x831ZTU0yX578VBr14cX6KQ9gpnlK/yrR8xFvtZrPwDce6EU0vQGuyQSICoSEnKuZmC
         DuuywU23/UbQMK9xXU16WaUi8RsuBLQeZxwD//+JZktcl4myv3WTQuUcZ1p7XD0C52da
         xOhc4NOOwqb7spiRNkEluxw8Gy+skIP1InET/G10d6fU3YfYGfHmnrxCIvJ2HwhmurzF
         kanQxoHoh/KYLIB9oOGEkpM7Qm8k0JKwgb4TrRAimmAT3l4QJ+pRrskwjivJlTDdag2u
         hmcg==
X-Gm-Message-State: AOJu0YwGs2w7CRZb6XuLdH+2qTe+TLY6aZ/lh3QOm2JY9uf3tCY/Wt5m
	E88y8RbdM9HiuJ1ZKYWT03XA7uuX9oyQ3x26ckw=
X-Google-Smtp-Source: AGHT+IE9ELuWOZH8Sc9Ev+ayLljTbQ5fYm6nyiOuTgf7AeoZL2xXcV2osQBFuD3KQ1pHT5NzOc5f+dtBB6jY5vzfYQE=
X-Received: by 2002:a81:84c8:0:b0:5d3:9f4d:dae0 with SMTP id
 u191-20020a8184c8000000b005d39f4ddae0mr5834278ywf.24.1702480777052; Wed, 13
 Dec 2023 07:19:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212145550.3872051-1-edumazet@google.com>
In-Reply-To: <20231212145550.3872051-1-edumazet@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 13 Dec 2023 10:19:25 -0500
Message-ID: <CADvbK_fiHwCXQZxOh7poK7gxv2t20D7KwR0Yi1wm7zWqHPN+6Q@mail.gmail.com>
Subject: Re: [PATCH net-next] sctp: support MSG_ERRQUEUE flag in recvmsg()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 9:55=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> For some reason sctp_poll() generates EPOLLERR if sk->sk_error_queue
> is not empty but recvmsg() can not drain the error queue yet.
I'm checking the code but can't see how SCTP may enqueue skbs into
sk->sk_error_queue. Have you ever seen it happen in any of your cases?

>
> This is needed to better support timestamping.
I think SCTP doesn't support timestamping, there's no functions like
tcp_tx_timestamp()/tcp_gso_tstamp() to enable it.

Or do you mean SO_TXTIME socket option, and then tc-etf may
enqueue a skb into sk->sk_error_queue if it's enabled?

>
> I had to export inet_recv_error(), since sctp
> can be compiled as a module.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Xin Long <lucien.xin@gmail.com>
> Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> Cc: Willem de Bruijn <willemb@google.com>
> ---
>  net/ipv4/af_inet.c | 1 +
>  net/sctp/socket.c  | 3 +++
>  2 files changed, 4 insertions(+)
>
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index fbeacf04dbf3744e5888360e0b74bf6f70ff214f..835f4f9d98d25559fb8965a75=
31c6863448a55c2 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -1633,6 +1633,7 @@ int inet_recv_error(struct sock *sk, struct msghdr =
*msg, int len, int *addr_len)
>  #endif
>         return -EINVAL;
>  }
> +EXPORT_SYMBOL(inet_recv_error);
>
>  int inet_gro_complete(struct sk_buff *skb, int nhoff)
>  {
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index 7f89e43154c091f6f7a3c995c1ba8abb62a8e767..5fb02bbb4b349ef9ab9c2790c=
ccb30fb4c4e897c 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -2099,6 +2099,9 @@ static int sctp_recvmsg(struct sock *sk, struct msg=
hdr *msg, size_t len,
>         pr_debug("%s: sk:%p, msghdr:%p, len:%zd, flags:0x%x, addr_len:%p)=
\n",
>                  __func__, sk, msg, len, flags, addr_len);
>
> +       if (unlikely(flags & MSG_ERRQUEUE))
> +               return inet_recv_error(sk, msg, len, addr_len);
> +
>         lock_sock(sk);
>
>         if (sctp_style(sk, TCP) && !sctp_sstate(sk, ESTABLISHED) &&
> --
> 2.43.0.472.g3155946c3a-goog
>

