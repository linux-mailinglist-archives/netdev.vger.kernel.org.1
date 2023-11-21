Return-Path: <netdev+bounces-49567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 687697F275D
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 09:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 093D7B2187A
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 08:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1240A3A278;
	Tue, 21 Nov 2023 08:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EeiNnOVB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F42F9
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 00:22:06 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso6656a12.1
        for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 00:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700554925; x=1701159725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCK1g9YM8XFjym+Y1ma/CnG4HTN5lgzW4MRhGnM9Ctg=;
        b=EeiNnOVB61DSfWZT9NiKt2naE2DONQ3VnXhdeyq1oif3E2uLjHqe8NkhtUTkXNLqQR
         aqZksBmH+efpSrmqVfxtSsGpLeKixUl9TQyp+AzQeVnYnQ1F6VgUoEA1ysokhZP9hHT/
         HP7Oo7nFZ/BjpoBWv7STFJPpRup4sxdefBsI40vk+ThVvb6vWQAIiqTkZbtiAEMER7BI
         W4acUuzSCi8bTGLQfVNeSJqkqHZ9HOgYurOLetOjYe/NpW5/XUsAWJ4AEaAoqjpDDizt
         OFHdnIg4nhf7fWm3ID63MP67mjRvtJgMh/v5uXxx2JGnlptz8GwElIVnxL0CWRX4wf5M
         FAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700554925; x=1701159725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCK1g9YM8XFjym+Y1ma/CnG4HTN5lgzW4MRhGnM9Ctg=;
        b=TMV488gRf4ygJXmIEkXcsh75aan3cIKFH9R+gbzqIRIsaSDqvyiHV77n/MwuEujHqJ
         ZChb2NhdS5SmT73VkJ+zZpEKewmVlOxL1NU+q79E7w7WBL8UCLQrLGi9IjVJZ5Gi/4+h
         /iAoYq03sAs6MT57ffQo/516uDqcpsC1VA+WVf02xDLAQdwBVJUPVUDU0isyXytzihrQ
         Ftr8AVXPh+hNzqZswdm4dN0G3RUVQgimk4lHno0etsSrypavOFoHMWy8oh8oiHvl0Mn3
         VbLQorGzMXWWeejLt4yxspgxu8wbcsuYSByYjWgOIrgqqGprZe+LxfbTHQNXGVf0Q5w8
         cS8A==
X-Gm-Message-State: AOJu0YxRrgrXJp80a1STMj62eAq/LPwczkwVAXkXfjJloOKeFjYhbLuf
	mrPRJv53qeIMNZ4j5bEc13NE5kFetulUs+ozJA53RQ==
X-Google-Smtp-Source: AGHT+IEQIy1UWv0nXe/YssFHF48Ncyrazvf+xBS3VY2h5GiT2ncZWuBZH2HEP6iMFMutvlKr9G8jO5eCeWr5mET04R0=
X-Received: by 2002:a05:6402:4414:b0:544:e2b8:ba6a with SMTP id
 y20-20020a056402441400b00544e2b8ba6amr463035eda.3.1700554924840; Tue, 21 Nov
 2023 00:22:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121020111.1143180-1-dima@arista.com> <20231121020111.1143180-4-dima@arista.com>
In-Reply-To: <20231121020111.1143180-4-dima@arista.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 21 Nov 2023 09:21:53 +0100
Message-ID: <CANn89i+2xLv=bR5u0iGcmZhZ8WZjPHyzaqAe3cZAhmc95KSVag@mail.gmail.com>
Subject: Re: [PATCH 3/7] net/tcp: Limit TCP_AO_REPAIR to non-listen sockets
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
> Listen socket is not an established TCP connection, so
> setsockopt(TCP_AO_REPAIR) doesn't have any impact.
>
> Restrict this uAPI for listen sockets.
>
> Fixes: faadfaba5e01 ("net/tcp: Add TCP_AO_REPAIR")
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  net/ipv4/tcp.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 53bcc17c91e4..2836515ab3d7 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -3594,6 +3594,10 @@ int do_tcp_setsockopt(struct sock *sk, int level, =
int optname,
>                 break;
>
>         case TCP_AO_REPAIR:
> +               if (sk->sk_state =3D=3D TCP_LISTEN) {
> +                       err =3D -ENOSTR;

ENOSTR is not used a single time in linux.

I suggest you use tcp_can_repair_sock() helper (and return -EPERM as
other TCP_REPAIR options)

> +                       break;
> +               }
>                 err =3D tcp_ao_set_repair(sk, optval, optlen);
>                 break;
>  #ifdef CONFIG_TCP_AO
> @@ -4293,6 +4297,8 @@ int do_tcp_getsockopt(struct sock *sk, int level,
>         }
>  #endif
>         case TCP_AO_REPAIR:
> +               if (sk->sk_state =3D=3D TCP_LISTEN)
> +                       return -ENOSTR;
>                 return tcp_ao_get_repair(sk, optval, optlen);
>         case TCP_AO_GET_KEYS:
>         case TCP_AO_INFO: {
> --
> 2.42.0
>

