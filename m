Return-Path: <netdev+bounces-49562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D437F26F7
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 09:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AFC22823D0
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 08:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707CC38F88;
	Tue, 21 Nov 2023 08:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="COEgIEDE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09AC114
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 00:09:04 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-548db776f6cso6737a12.1
        for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 00:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700554143; x=1701158943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKicp15faTy9dxr+lo3vJn4RmNCBFdNPH9aMUCXaj3A=;
        b=COEgIEDEqYeeTZAhnrdzaWBpwGIcQGx/OrLX5I+ZGW7BBzOGRa1KgP+YLh+UVpJ0TB
         yA2g/2jQ5kl1gjltZwGHDWB5sVCz703V1J0vkWMQD6Xpa+K/FYKlNjt7xE9iPH5pcxG7
         KGH4BREMUO3FEK4fTA2lPXwhgpMHZ1IF6e0WSWr2OtYF3+sVaE/QIBn19zr6YbmZF9ZC
         gU+9JKODmbTOf9VQVRP4TqfQICzUbuX7wxIaqwiOEoQDChRJSkw4zcCImL0oXu7fASdp
         o2+jA+qPjx4seSSvZLMHL/vnJ45hwN/U6WV3ubC87i/wZfhk2TLrFYJEluqsRp9AruLq
         l58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700554143; x=1701158943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKicp15faTy9dxr+lo3vJn4RmNCBFdNPH9aMUCXaj3A=;
        b=Qz8dEQu8QOHiMU0sISCONklTu6vJgsqCBSNF8VO8qz+I9RcotNkUWwoEF/6A1XE6fl
         1QXyCRJXjncYnDxF2xh5Ctao+LDBDC5kFM3hfOrWgImthKvPwvdr1S3ae8xkLycISaiN
         5gU999rlxJnopbeOT3ZpqILWpO1btB3Yy/BxORqzON9oIi+sMMEbtrE4HZQUa7xOe5ng
         QlwG940qqbcB0OkKn65rzhSgQCCpZ8fY2IDJrnHZgxOPPmlZ1pGb4X6fEXSLX9WXGtRw
         nGspPiRsxsiySz2uoXPSosOy5tVLgW4OResSg0wV1Bv9vbdyrCdO/J4Z5nY9b7Rpti90
         E2fQ==
X-Gm-Message-State: AOJu0YxzVnCcgtvE+iDL9HbQHyTKrNjaWgAxp1FWGb6Elyx+0tPOBlr0
	Nw9LviU104G3rWoS/qHTVpDSH3vgx1YKUSqP1ffCfg==
X-Google-Smtp-Source: AGHT+IFk7rTNn469v7x2wpKCPVaSegxVKameTngvf3SmEjxXVkO7FQ2gV5Q2EICNAOLjWO6335FnMrlK5knzBXdZPJY=
X-Received: by 2002:a05:6402:12:b0:547:e5b:6e17 with SMTP id
 d18-20020a056402001200b005470e5b6e17mr502485edu.2.1700554142874; Tue, 21 Nov
 2023 00:09:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121020111.1143180-1-dima@arista.com> <20231121020111.1143180-7-dima@arista.com>
In-Reply-To: <20231121020111.1143180-7-dima@arista.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 21 Nov 2023 09:08:49 +0100
Message-ID: <CANn89iLEANNvZ45PaPL8miZeyMUTAcLoVR4WS55gbtfiMPbueQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] net/tcp: ACCESS_ONCE() on snd/rcv SNEs
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
> SNEs need READ_ONCE()/WRITE_ONCE() for access as they can be written and
> read at the same time.
>
> This is actually a shame: I planned to send it in TCP-AO patches, but
> it seems I've chosen a wrong commit to git-commit-fixup some time ago.
> It ended up in a commit that adds a selftest. Human factor.
>
> Fixes: 64382c71a557 ("net/tcp: Add TCP-AO SNE support")
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  net/ipv4/tcp_ao.c    | 4 ++--
>  net/ipv4/tcp_input.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> index 122ff58168ee..9b7f1970c2e9 100644
> --- a/net/ipv4/tcp_ao.c
> +++ b/net/ipv4/tcp_ao.c
> @@ -956,8 +956,8 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_=
buff *skb,
>                 if (unlikely(th->syn && !th->ack))
>                         goto verify_hash;
>
> -               sne =3D tcp_ao_compute_sne(info->rcv_sne, tcp_sk(sk)->rcv=
_nxt,
> -                                        ntohl(th->seq));
> +               sne =3D tcp_ao_compute_sne(READ_ONCE(info->rcv_sne),
> +                                        tcp_sk(sk)->rcv_nxt, ntohl(th->s=
eq));


I think this is a wrong fix. Something is definitely fishy here.

Update side should only happen for an established socket ?

And the read side should have locked the socket before calling
tcp_inbound_ao_hash(),
otherwise reading other fields (like tcp_sk(sk)->rcv_nxt) would be racy any=
way.


>                 /* Established socket, traffic key are cached */
>                 traffic_key =3D rcv_other_key(key);
>                 err =3D tcp_ao_verify_hash(sk, skb, family, info, aoh, ke=
y,
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index bcb55d98004c..78896c8be0d4 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c

tcp_snd_sne_update() definitely only deals with full sockets
(TCP_AO_ESTABLISHED)

> @@ -3583,7 +3583,7 @@ static void tcp_snd_sne_update(struct tcp_sock *tp,=
 u32 ack)
>         ao =3D rcu_dereference_protected(tp->ao_info,
>                                        lockdep_sock_is_held((struct sock =
*)tp));
>         if (ao && ack < tp->snd_una)
> -               ao->snd_sne++;
> +               WRITE_ONCE(ao->snd_sne, ao->snd_sne + 1);
>  #endif
>  }
>
> @@ -3609,7 +3609,7 @@ static void tcp_rcv_sne_update(struct tcp_sock *tp,=
 u32 seq)
>         ao =3D rcu_dereference_protected(tp->ao_info,
>                                        lockdep_sock_is_held((struct sock =
*)tp));
>         if (ao && seq < tp->rcv_nxt)
> -               ao->rcv_sne++;
> +               WRITE_ONCE(ao->rcv_sne, ao->rcv_sne + 1);
>  #endif
>  }
>
> --
> 2.42.0
>

