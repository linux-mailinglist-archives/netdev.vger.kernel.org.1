Return-Path: <netdev+bounces-58522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9FF816BF5
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 12:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92B48B2314B
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 11:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC6D199DF;
	Mon, 18 Dec 2023 11:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kaRcdsjr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3A218E37
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 11:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso13004a12.1
        for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 03:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702897684; x=1703502484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AQLJNbHXm9bw9mH1g4ChmY8Tt43IgcTpCwr8V+S95I=;
        b=kaRcdsjr/daU9csfk49B6e7YkDEeXe+8daoUSl4stDbgvAq4TgAR3sOUDvc/CUxE5S
         ur65bsf/zjpu243JziAXJ47BqFENyXH5LIqSmodfPRUIkNdYlwQdpKi6qoEOV12feCZ2
         A9yKaHjw+6aPlwlH8KvMWJz8czYH3h7ofYXBEy96YX3NpLRZJUa59GVW30Pl1/+InOrR
         1WNaEDuCyMi7p/smItqL/TBPlZJwriR85LaYuQ/dxZ/XSVPq2szfczY4rWMXS/3Y2ZKJ
         b2mhH0X6Qa7RBxkx4ttWijfMego3zCFRVuP9tlMRyWVTkcmM2RTNma6RLMUWI1X3axtQ
         cHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702897684; x=1703502484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4AQLJNbHXm9bw9mH1g4ChmY8Tt43IgcTpCwr8V+S95I=;
        b=PVPbed6onxBwyql8mlgiDOWxsg0ElB4B1tn31ZJE4uACN9PZH8OrOOC5hG97XaBhzs
         y7jQtfayP2muDIfs7S6KzUaNW1hUW6WFDXZPJKWzqVeNcgSVwEgSMkMigP8JypOYWFN4
         bRgies0c9lqdlhuTW4rnJ4gsogcjxXegtXDENfNpsjrTk4e2WItzN1vzDll1hJ5gFynq
         gyHACH0AkHyEPA+f33hvXGQc0a3cjIhX4tmg7513vdDu7tm4whesCizL0T/YJDwpUEe9
         AgTNJW3TktvxKIraW+n/5vQqlN0exXW3aXmUd6QxEi5nZL8V+o7/5RotXy8HjisZCYNn
         GJYw==
X-Gm-Message-State: AOJu0YxKDeNlFOJMZjjP+LL3A9/Q6mZt0IhcBYYry7zgpBla+gBUdvTZ
	1nADN0AFgRhGwt1OqOEfK/Bm7yZWx5sWhjMqfrwuw5H65wsG
X-Google-Smtp-Source: AGHT+IEElFawCpdohsL5MlKQosR21DHdivzVWO+EAMLouO2OGxC74cDSKlU+SWU7Lu+8gFsLHiYjz5ELdJGXwdzmfag=
X-Received: by 2002:a50:cdc6:0:b0:551:9870:472 with SMTP id
 h6-20020a50cdc6000000b0055198700472mr275515edj.1.1702897684321; Mon, 18 Dec
 2023 03:08:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218084252.7644-1-zhangyiqun@phytium.com.cn>
In-Reply-To: <20231218084252.7644-1-zhangyiqun@phytium.com.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 18 Dec 2023 12:07:50 +0100
Message-ID: <CANn89i+t9t5ca=r6ZKw7s-HrxzgJjCB6hmWLccKmmxg8H=HUUA@mail.gmail.com>
Subject: Re: [PATCH] xfrm: Use spin_lock_bh() in xfrm_input()
To: Zhang Yiqun <zhangyiqun@phytium.com.cn>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 9:43=E2=80=AFAM Zhang Yiqun <zhangyiqun@phytium.com=
.cn> wrote:
>
> This patch is to change spin_lock() into spin_lock_bh(), which can
> disable bottem half in calling. If we leave this as spin_lock(),
> it may stuck in a deadlock, because the callback in bottem half in
> crypto driver will also call xfrm_input() again.
>
> Signed-off-by: Zhang Yiqun <zhangyiqun@phytium.com.cn>

When was the bug added ?
We need a FIxes: tag.

Also a stack trace to show the deadlock (or lockdep complaint ) would
be needed as well.

> ---
>  net/xfrm/xfrm_input.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
> index bd4ce21d76d7..f4cd46d73b1e 100644
> --- a/net/xfrm/xfrm_input.c
> +++ b/net/xfrm/xfrm_input.c
> @@ -581,7 +581,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be=
32 spi, int encap_type)
>                 }
>
>  lock:
> -               spin_lock(&x->lock);
> +               spin_lock_bh(&x->lock);
>
>                 if (unlikely(x->km.state !=3D XFRM_STATE_VALID)) {
>                         if (x->km.state =3D=3D XFRM_STATE_ACQ)
> @@ -607,7 +607,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be=
32 spi, int encap_type)
>                         goto drop_unlock;
>                 }
>
> -               spin_unlock(&x->lock);
> +               spin_unlock_bh(&x->lock);
>
>                 if (xfrm_tunnel_check(skb, x, family)) {
>                         XFRM_INC_STATS(net, LINUX_MIB_XFRMINSTATEMODEERRO=
R);

This patch is not correct anyway.
There are five places in xfrm_input() where x->lock is either locked
or unlocked.

Please tell us how this was tested.
Thanks.

