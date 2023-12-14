Return-Path: <netdev+bounces-57559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D2281364C
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 17:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773241F21F22
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 16:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FC45F1E3;
	Thu, 14 Dec 2023 16:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xl8xhJDR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E210F112
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 08:31:27 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso12276a12.1
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 08:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702571486; x=1703176286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFzsDH4W6g+dzf0ZJqoJe94xr3ifV/aPAfhQwt3xHno=;
        b=Xl8xhJDRkbpU+w537X81m+/fWHUjMBZ8LTZ/5NPz9RuTBl7YSLmOe/IyOQnlwYGDw6
         IHQtzIqThBAUL4e1FD3/2vf95GQ/GQrx8WITBLft7w7MIEjfIKN0JjvVbHg9sty6OjlC
         xffYaqtoqP+OMFeXt3IEvKqtHiiRgrINRu6KSYE418CHj/DpWkR3FZ6UyJghJPLuqRca
         d+9KBzxfQ9veUYld/tQrvD+LSQZdXn+P4eTx8fsdJ9SheypdOrlo7XiH2v4cQyCYJ92l
         z6++uwc69LwZowW0l8uFt8r517+Blo1KyN8LCClBg3m8DAEHTsMuFFxxASYhM6jnb3Ts
         AEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702571486; x=1703176286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFzsDH4W6g+dzf0ZJqoJe94xr3ifV/aPAfhQwt3xHno=;
        b=HWJvRGRZcaiEWrAjClyRvcPG99jV3+78tpGLaQQCjdZKqUTcHgXqGPbuM4bbfRG+xO
         +htHWMz1eLHw9iE0xL5OTevDqRQHHe5iKOlmRA6G1P3v0B53Ffn64uYDF1jO6zs8B7Bq
         jbqUELKT5Qm6Yj2y6e0FkrBu8mDdUg1yL3nW4wAQWRcGhkP21YTiVDDlXZ2MtID7qB9b
         58ofLGUMgbtK+dp5s/WM8e5sDe9IFoInmTohWUhpXXvbAmlNltD/BQFZa8HTJ3bQAp4N
         JXyECGET8CHIk1bwSYHaltShNAOWLEYJL1h54htDnfmYZ5Gbexbp5vofxNY6DR04gOd4
         ZLbg==
X-Gm-Message-State: AOJu0YznmR7xzEUgZapUC0rLXNCNSRBpzegTB1DC3QaTA/7/ULxL4vQ/
	OYSpfpDz9HHC/uYQrpw+wYkO0M6LTanvdNddlTKNq+UuyU1N2ENyN3Y=
X-Google-Smtp-Source: AGHT+IENyyBj8zWcjlR/kWt8zVAzEqsFR9jWrSUwj3CKNn/MeXWePl7Lnr7JJnj9/sGRuxmXWKvhVt/sBBK7oER6hYQ=
X-Received: by 2002:a50:bb26:0:b0:552:365c:6962 with SMTP id
 y35-20020a50bb26000000b00552365c6962mr186983ede.2.1702571486139; Thu, 14 Dec
 2023 08:31:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214155424.67136-1-kuniyu@amazon.com> <20231214155424.67136-4-kuniyu@amazon.com>
In-Reply-To: <20231214155424.67136-4-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 14 Dec 2023 17:31:15 +0100
Message-ID: <CANn89i+8e8VJ8cJX6vwLFhtj=BmT233nNr=F9H3nFs8BZgTbsQ@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/6] bpf: tcp: Handle BPF SYN Cookie in skb_steal_sock().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 4:56=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> We will support arbitrary SYN Cookie with BPF.
>
> If BPF prog validates ACK and kfunc allocates a reqsk, it will
> be carried to TCP stack as skb->sk with req->syncookie 1.  Also,
> the reqsk has its listener as req->rsk_listener with no refcnt
> taken.
>
> When the TCP stack looks up a socket from the skb, we steal
> inet_reqsk(skb->sk)->rsk_listener in skb_steal_sock() so that
> the skb will be processed in cookie_v[46]_check() with the
> listener.
>
> Note that we do not clear skb->sk and skb->destructor so that we
> can carry the reqsk to cookie_v[46]_check().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  include/net/request_sock.h | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/request_sock.h b/include/net/request_sock.h
> index 26c630c40abb..8839133d6f6b 100644
> --- a/include/net/request_sock.h
> +++ b/include/net/request_sock.h
> @@ -101,10 +101,21 @@ static inline struct sock *skb_steal_sock(struct sk=
_buff *skb,
>         }
>
>         *prefetched =3D skb_sk_is_prefetched(skb);
> -       if (*prefetched)
> +       if (*prefetched) {
> +#if IS_ENABLED(CONFIG_SYN_COOKIES)
> +               if (sk->sk_state =3D=3D TCP_NEW_SYN_RECV && inet_reqsk(sk=
)->syncookie) {
> +                       struct request_sock *req =3D inet_reqsk(sk);
> +
> +                       *refcounted =3D false;
> +                       sk =3D req->rsk_listener;
> +                       req->rsk_listener =3D NULL;

I am not sure about interactions with MPTCP.

I would be nice to have their feedback.

> +                       return sk;
> +               }
> +#endif
>                 *refcounted =3D sk_is_refcounted(sk);
> -       else
> +       } else {
>                 *refcounted =3D true;
> +       }
>
>         skb->destructor =3D NULL;
>         skb->sk =3D NULL;
> --
> 2.30.2
>

