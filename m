Return-Path: <netdev+bounces-60598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C048201F0
	for <lists+netdev@lfdr.de>; Fri, 29 Dec 2023 22:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 062411F22093
	for <lists+netdev@lfdr.de>; Fri, 29 Dec 2023 21:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C53E14299;
	Fri, 29 Dec 2023 21:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fTZbI8j/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7811A14A85
	for <netdev@vger.kernel.org>; Fri, 29 Dec 2023 21:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dafe04717baso4917505276.1
        for <netdev@vger.kernel.org>; Fri, 29 Dec 2023 13:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703886101; x=1704490901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=da9LGeyuvTZGILTbTs18YHdm2o/r2BCEHsPfsaIYle8=;
        b=fTZbI8j/IwqmO12QKy+ohJJzmK80phWuVl+OO9nIJp4H4Lbk4VWZI86YYOYMAzbhBO
         k+0v7yqCkBIj1p/H42cAyy+bLQEYHnyLzWz8zsb7IPlwFTv9glXYGXBofzLhj5aI3DZG
         1wonxch+QbxFj71Z4uv620LbRfCHJBAD6OmzBZgylKrGhhyQ2SLx5WzuqfeIxrnIPLbF
         wVKG2IbfOgl4Cr/HxQPjqaHxzwamW6lkDafVIAbk/wacPcVQFkSKFM/2xL/MSgSBwzIl
         dikbkrqQVV7z+W+8/ogbeha3tiVTYU4f467yxa/NpFduyqYmpIp/Y3yLnrHuQe7o4O2O
         Abrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703886101; x=1704490901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=da9LGeyuvTZGILTbTs18YHdm2o/r2BCEHsPfsaIYle8=;
        b=VtZA0GmaB3pral8KT+b8d1GY3UmWCDG1BwMx30QsJtTXq+rYAvVV/XMUkAt6LwU8c4
         8bFk9+ShfKT+C8Cf41deBSDXg59naexFvPojVe1TnaF+ilR3muUMAv10/Jf2dBE9zeAu
         1Tv0FdXtgD/j5rKJAbWRW9sjUfH0f4n/KfFtOgMX+cASg+8tF53ghGGPmpQV3r2PrQgK
         h5v2eijjzqtOkRG8MdD7v3rVI6MsVjIYm7vvDX5GcVleZRkbT6IwRio9O0CDyzyzoKql
         pDsLFYZ6Hss9BmJa65jnoLsf+VZW3rznViru/piNNnbtmmU4Hc5ynjX2mzieW2GoJ2Os
         0lSw==
X-Gm-Message-State: AOJu0YwFjVpdO1OtEpALImbGSbBAIjTNzE/dcXXLriRAxL7C53hlBdva
	1+ZM37g7bI2YFbL96WhBUQFekZ3zLnzQSuo+uAlCXHoVcA3f
X-Google-Smtp-Source: AGHT+IG40QhkJB2MDQvx8W4bpKyDJtlQbBUDvyWAIZcCsg/w1+WXXeJSaR1uUj7T7Vz2iAnBIyhxdVpgURwUsxzF2/8=
X-Received: by 2002:a25:aba4:0:b0:dbc:dfa4:b96b with SMTP id
 v33-20020a25aba4000000b00dbcdfa4b96bmr6835344ybi.93.1703886101421; Fri, 29
 Dec 2023 13:41:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228113917.62089-1-mic@digikod.net> <CAHC9VhQMbHLYkhs-k9YEjeAFH7_JOk3RUKAa7jD7HP0NW1cBdA@mail.gmail.com>
 <20231229.Phaengue0aib@digikod.net>
In-Reply-To: <20231229.Phaengue0aib@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 29 Dec 2023 16:41:30 -0500
Message-ID: <CAHC9VhQcBEmF_pL9pk0O84aWyrZxSX9y1i0i=c+a3dQQawgEMA@mail.gmail.com>
Subject: Re: [PATCH] selinux: Fix error priority for bind with AF_UNSPEC on
 AF_INET6 socket
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Eric Paris <eparis@parisplace.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 12:19=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
>
> (Removing Alexey Kodanev because the related address is no longer
> valid.)
>
> On Thu, Dec 28, 2023 at 07:19:07PM -0500, Paul Moore wrote:
> > On Thu, Dec 28, 2023 at 6:39=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > >
> > > The IPv6 network stack first checks the sockaddr length (-EINVAL erro=
r)
> > > before checking the family (-EAFNOSUPPORT error).
> > >
> > > This was discovered thanks to commit a549d055a22e ("selftests/landloc=
k:
> > > Add network tests").
> > >
> > > Cc: Alexey Kodanev <alexey.kodanev@oracle.com>
> > > Cc: Eric Paris <eparis@parisplace.org>
> > > Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> > > Cc: Paul Moore <paul@paul-moore.com>
> > > Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > > Closes: https://lore.kernel.org/r/0584f91c-537c-4188-9e4f-04f19256566=
7@collabora.com
> > > Fixes: 0f8db8cc73df ("selinux: add AF_UNSPEC and INADDR_ANY checks to=
 selinux_socket_bind()")
> > > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > > ---
> > >  security/selinux/hooks.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > index feda711c6b7b..9fc55973d765 100644
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -4667,6 +4667,10 @@ static int selinux_socket_bind(struct socket *=
sock, struct sockaddr *address, in
> > >                                 return -EINVAL;
> > >                         addr4 =3D (struct sockaddr_in *)address;
> > >                         if (family_sa =3D=3D AF_UNSPEC) {
> > > +                               if (sock->sk->__sk_common.skc_family =
=3D=3D
> > > +                                           AF_INET6 &&
> > > +                                   addrlen < SIN6_LEN_RFC2133)
> > > +                                       return -EINVAL;
> >
> > Please use sock->sk_family to simplify the conditional above, or
> > better yet, use the local variable @family as it is set to the sock's
> > address family near the top of selinux_socket_bind()
>
> Correct, I'll send a v2 with that.
>
> > ... although, as
> > I'm looking at the existing code, is this patch necessary?
> >
> > At the top of the AF_UNSPEC/AF_INET case there is an address length che=
ck:
> >
> >   if (addrlen < sizeof(struct sockaddr_in))
> >     return -EINVAL;
>
> This code is correct but not enough in the case of an IPv6 socket.

Okay, I see now.  Let me follow-up in your v2, we may want to fix this
another way.

--=20
paul-moore.com

