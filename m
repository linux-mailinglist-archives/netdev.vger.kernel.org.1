Return-Path: <netdev+bounces-57721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C58E6813FB7
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 03:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 310BBB215AA
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 02:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A397FC;
	Fri, 15 Dec 2023 02:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBokNhAe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A836ED6
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 02:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a1f37fd4b53so23857966b.1
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 18:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702607213; x=1703212013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OebLlHKMOJ1tzPGTLa8EQPWwn+DI+YsfdD53jZ/zLhc=;
        b=bBokNhAefUyLWI7kLN0FdUVKaakO5iswv0xncHdbEHkIo+87RHNYtJargGQh9lRviP
         qvRJEnwT7LMG0c0U0JCmwNZZnLTHIBYctcEziws2WSOGxX2lEjdyous6qH7pU5Dor8JK
         5abx79ILmOmhDyGSnctvNDNajmiEmY3wsRRgnoY6ScjXxVssVWmWW+QQcVWIek0bolWh
         ECarWKMysAvuOselBgbdZSM+yjLrskBBgeU7ORaG2vSFm2JSxwMR9oM7MU61IAMlLeAu
         UBvz78NRj+cnoHwSH44B3IvJq01dVLQhHSJ/wJIOTpQZVD2k+ab8xXayc7A/EXo4Us3H
         ao2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702607213; x=1703212013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OebLlHKMOJ1tzPGTLa8EQPWwn+DI+YsfdD53jZ/zLhc=;
        b=HvhO4oYfdT1Lvl3vgEk1zOZesd85AJQ8HTGdZn5Cs4j6SxuKymHoHIkGoaaeA98jAM
         fsF1xKOSTaqW4nTqYQSvcQywOblettlRFlcrbrv+AOyIfHUTWYFPolZBikWgYFG6q6tL
         sEPoCDTRZBchlo1VmQ0XnjpeOqosAbhAgxn/SwHUyf0Z0jj+XmArU3aTaXCdOwcP9VK+
         BJo+d771vESLOtbO5eYcVPQ4h5m26BzVZSmF7L3w88UVtPM5zfPq2k9P4Mgus+E0FLJ0
         njyKuV7Ci3PjAanbiWbgwUY7KpgeD3uqhDN4R6VmlQrA8Arsu4pbkt6uooC95m+L5wQk
         xEhA==
X-Gm-Message-State: AOJu0YwCf2ea5t9QLazDY4klDJTwNnfL/co6k9oe3CRniQ/3N9m4cHfz
	sNkqzRNcEF4gCqLapCm95CtpQVmBzfQ8YczHULg=
X-Google-Smtp-Source: AGHT+IGVKQsQliRyqxqNEtyrTc31pWSiqEKRNjRIQEPokr6Y59xYQvk3sA+tXT/Lg0FOO1TUfYkXsIGFv2kHLnhNsTg=
X-Received: by 2002:a17:906:209b:b0:a22:f162:c92 with SMTP id
 27-20020a170906209b00b00a22f1620c92mr2882399ejq.136.1702607212534; Thu, 14
 Dec 2023 18:26:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214192939.1962891-1-edumazet@google.com> <20231214192939.1962891-3-edumazet@google.com>
In-Reply-To: <20231214192939.1962891-3-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 15 Dec 2023 10:26:15 +0800
Message-ID: <CAL+tcoBKjW7WFgf_LEee6r_VnVosgSMMXpH=Y4fxNK3XA6BWTQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tcp/dccp: change source port selection at
 connect() time
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 3:30=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> In commit 1580ab63fc9a ("tcp/dccp: better use of ephemeral ports in conne=
ct()")
> we added an heuristic to select even ports for connect() and odd ports fo=
r bind().
>
> This was nice because no applications changes were needed.
>
[...]
> But it added more costs when all even ports are in use,
> when there are few listeners and many active connections.

Yes, I have encountered this issue several times. So internally adding
a switch to decide which selecting port algorithm the connect() phase
should use can address this issue: go back to the original algo
(without splitting ports range) many years ago.

>
> Since then, IP_LOCAL_PORT_RANGE has been added to permit an application
> to partition ephemeral port range at will.
>
> This patch extends the idea so that if IP_LOCAL_PORT_RANGE is set on
> a socket before accept(), port selection no longer favors even ports.
>
> This means that connect() can find a suitable source port faster,
> and applications can use a different split between connect() and bind()
> users.

Great :)

>
> This should give more entropy to Toeplitz hash used in RSS: Using even
> ports was wasting one bit from the 16bit sport.
>
> A similar change can be done in inet_csk_find_open_port() if needed.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Sitnicki <jakub@cloudflare.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks!

> ---
>  net/ipv4/inet_hashtables.c | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index a532f749e47781cc951f2003f621cec4387a2384..9ff201bc4e6d2da04735e8c16=
0d446602e0adde1 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -1012,7 +1012,8 @@ int __inet_hash_connect(struct inet_timewait_death_=
row *death_row,
>         bool tb_created =3D false;
>         u32 remaining, offset;
>         int ret, i, low, high;
> -       int l3mdev;
> +       bool local_ports;
> +       int step, l3mdev;
>         u32 index;
>
>         if (port) {
> @@ -1024,10 +1025,12 @@ int __inet_hash_connect(struct inet_timewait_deat=
h_row *death_row,
>
>         l3mdev =3D inet_sk_bound_l3mdev(sk);
>
> -       inet_sk_get_local_port_range(sk, &low, &high);
> +       local_ports =3D inet_sk_get_local_port_range(sk, &low, &high);
> +       step =3D local_ports ? 1 : 2;
> +
>         high++; /* [32768, 60999] -> [32768, 61000[ */
>         remaining =3D high - low;
> -       if (likely(remaining > 1))
> +       if (!local_ports && remaining > 1)
>                 remaining &=3D ~1U;
>
>         get_random_sleepable_once(table_perturb,
> @@ -1040,10 +1043,11 @@ int __inet_hash_connect(struct inet_timewait_deat=
h_row *death_row,
>         /* In first pass we try ports of @low parity.
>          * inet_csk_get_port() does the opposite choice.
>          */
> -       offset &=3D ~1U;
> +       if (!local_ports)
> +               offset &=3D ~1U;
>  other_parity_scan:
>         port =3D low + offset;
> -       for (i =3D 0; i < remaining; i +=3D 2, port +=3D 2) {
> +       for (i =3D 0; i < remaining; i +=3D step, port +=3D step) {
>                 if (unlikely(port >=3D high))
>                         port -=3D remaining;
>                 if (inet_is_local_reserved_port(net, port))
> @@ -1083,10 +1087,11 @@ int __inet_hash_connect(struct inet_timewait_deat=
h_row *death_row,
>                 cond_resched();
>         }
>
> -       offset++;
> -       if ((offset & 1) && remaining > 1)
> -               goto other_parity_scan;
> -
> +       if (!local_ports) {
> +               offset++;
> +               if ((offset & 1) && remaining > 1)
> +                       goto other_parity_scan;
> +       }
>         return -EADDRNOTAVAIL;
>
>  ok:
> @@ -1109,8 +1114,8 @@ int __inet_hash_connect(struct inet_timewait_death_=
row *death_row,
>          * on low contention the randomness is maximal and on high conten=
tion
>          * it may be inexistent.
>          */
> -       i =3D max_t(int, i, get_random_u32_below(8) * 2);
> -       WRITE_ONCE(table_perturb[index], READ_ONCE(table_perturb[index]) =
+ i + 2);
> +       i =3D max_t(int, i, get_random_u32_below(8) * step);
> +       WRITE_ONCE(table_perturb[index], READ_ONCE(table_perturb[index]) =
+ i + step);
>
>         /* Head lock still held and bh's disabled */
>         inet_bind_hash(sk, tb, tb2, port);
> --
> 2.43.0.472.g3155946c3a-goog
>
>

