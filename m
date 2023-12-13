Return-Path: <netdev+bounces-57036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD9E811B22
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 18:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9831281147
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 17:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8543309F;
	Wed, 13 Dec 2023 17:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ey/kStLJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BCBEB
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 09:32:39 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c32bea30dso825e9.0
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 09:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702488757; x=1703093557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rl+/9ezkdOdNopl+5jLne6z0RL5P5lpU3clZliLgB6s=;
        b=ey/kStLJfwXr5IvEQR/wVzaBV/lQUzZnKDj5LUgqW3mwZUTyZMTTQ1Ayq1KxKRTM/E
         j8+8sZslcRBWbm7onGqNZHVOPFXJzMd61uoeMW/T47ygsNHnx8Rhl7BV5AJPh7QOH+Fe
         x9EUZ1LIMYHnXwvoJ9Y4jUhk2vhbNXbJBE8Reyga8ZLeQ8okkPS92XM9gFQmv/kYll0L
         KLrYBSMHyrWu12xsA8ALbzmSdOaLxt60e0dLDX2WBp5+vACawoSGAPuJrom7BRLrnKtV
         e6fa6hDtA8B6PNLupc2pLW26nORj4OU/SmehYPZTzt6gGrSByH9AqO5aq+RoNGaPdItB
         cnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702488757; x=1703093557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rl+/9ezkdOdNopl+5jLne6z0RL5P5lpU3clZliLgB6s=;
        b=w3L+bOA5RTKnrMOr3/HJlXe2c3uzjnJU4Wbx1kQJnoZ8NrfG9HYSOrE4JZ9aIj54gJ
         ZpyA2z5Rh0Aoww9rYumh9X0nI2OopCaDEiyp3bNuXeh1O/O2XIffN4Ibv2wEEZlKKndy
         Sj51GdjSMhutZ0MUXfx3IgBeBGGLdy6GzCHcgjfdJwKZNNsBXq9fJfH0cWetxAnnTwBY
         6f72j4oez0+jqCcT9jsynaZtI6rXYCRsSEZBfjnbHHCfwsDYYPLWUKOwLBsjMov/hRfc
         6mMC+kGLV8SZ7P2W+zeyZUz0xqMl6wxpk4r87LeNCAfIahGhW1qqCiS9fpKjCJzTvTGG
         YCfg==
X-Gm-Message-State: AOJu0YxHwzIMDU1lAJpzGVlGB+pWYlzAituI2x8Oirq0z6mVkjblxnv4
	Pj1JLsM/SwGvyBrHx3MPVj3Mw6cJRhJ9zvZAEkI78Q==
X-Google-Smtp-Source: AGHT+IFcrODzwCmdePDU2XLkkAqw3VscAtaSONUqsPPX59ktLyHNIRMazzSkoNyOPKXuhx9aQgZASdMV1pUP6OJPw8g=
X-Received: by 2002:a05:600c:5113:b0:40b:4221:4085 with SMTP id
 o19-20020a05600c511300b0040b42214085mr432804wms.1.1702488757353; Wed, 13 Dec
 2023 09:32:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208194523.312416-1-thinker.li@gmail.com> <deb7d2b6-1314-4d39-aa6f-2930e5de8d82@kernel.org>
In-Reply-To: <deb7d2b6-1314-4d39-aa6f-2930e5de8d82@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 13 Dec 2023 18:32:24 +0100
Message-ID: <CANn89iKYBjM6O-4=Azo=L3oTjNaFAKFiO62MzHnoAM9x3ZQGoA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/2] Fix dangling pointer at f6i->gc_link.
To: David Ahern <dsahern@kernel.org>
Cc: thinker.li@gmail.com, netdev@vger.kernel.org, martin.lau@linux.dev, 
	kernel-team@meta.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	sinquersw@gmail.com, kuifeng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 6:22=E2=80=AFPM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 12/8/23 12:45 PM, thinker.li@gmail.com wrote:
> > From: Kui-Feng Lee <thinker.li@gmail.com>
> >
> > According to a report [1], f6i->gc_link may point to a free block
> > causing use-after-free. According the stacktraces in the report, it is
> > very likely that a f6i was added to the GC list after being removed
> > from the tree of a fib6_table. The reason this can happen is the
> > current implementation determines if a f6i is on a tree in a wrong
> > way. It believes a f6i is on a tree if f6i->fib6_table is not NULL.
> > However, f6i->fib6_table is not reset when f6i is removed from a tree.
> >
> > The new solution is to check if f6i->fib6_node is not NULL as well.
> > f6i->fib6_node is set/or reset when the f6i is added/or removed from
> > from a tree. It can be used to determines if a f6i is on a tree
> > reliably.
> >
> > The other change is to determine if a f6i is on a GC list.  The
> > current implementation relies on RTF_EXPIRES on fib6_flags. It needs
> > to consider if a f6i is on a tree as well. The new solution is
> > checking hlist_unhashed() on f6i->gc_link, a clear evidence, instead.
> >
> > [1] https://lore.kernel.org/all/20231205173250.2982846-1-edumazet@googl=
e.com/
> >
>
> Eric: can you release the syzbot report for the backtrace listed in [1].
> I would like to make "very likely that a f6i was added to the GC list
> after being removed from the tree of a fib6_table" more certain. Thanks,

I have one, not sure if the tree is recent enough.

