Return-Path: <netdev+bounces-46107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE22D7E1626
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 20:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761711F216FE
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 19:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAA118057;
	Sun,  5 Nov 2023 19:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XWpfQs1Q"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3603212
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 19:59:34 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EDEDE
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 11:59:31 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40837124e1cso59735e9.0
        for <netdev@vger.kernel.org>; Sun, 05 Nov 2023 11:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699214370; x=1699819170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFIPYnVdamLKhFflgsxmJ79fD0yXj+XAKLnTfE6bT4E=;
        b=XWpfQs1Q2bILvQCuj/N1O4YB40ZvD1BourJMl2eSjtiXMxC5BzJsahaTVKuZ8yCOp8
         CNAgeAs9/Ws6KnPgSMTPOX2H3DVlPWkZZGaAwH9iGxoFfA/6SvRL/X8fS4oTZ5vWTbLt
         pDqgiim9iqQGywxJLAvNTR0WEvchboTaG9jX0WNH8vJJes+XY3szQeUzxKwMvxi30aYj
         4iX9rrXzB61yutbdD3FoAMVuVHZ0CnZh0onjx4roNghPPSY0lhl9cFDjqLh1ERdclm8p
         +Qe7kboAJ+sGxv+C5mtCfv6PydPg5Hvt3wz+06qyy5N2lY3wcnZrNghuCr1zbEHUtZnj
         /8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699214370; x=1699819170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tFIPYnVdamLKhFflgsxmJ79fD0yXj+XAKLnTfE6bT4E=;
        b=HvoRVz6xbPyDtT3Q6aaEXaGn2cC0/Mrbi2UVjv8AfZiZNxGdVGa6sdrpPZQoCsO8MI
         fYp//XyG6Nu/vSjOo972NjcQNlAK6SrXEe/5GEETtirqL1XUJphe05+JQcCXcm4rDszL
         HerSbabe5shc1417iIBdv8bWM5Nu+AXX/hLgD8lucVdJm9J6ioUtPMTFtW7RBgcdKXvW
         ifDFKymVVxnV16768cbOfdsaC/9GvwJCD1X/QZyvA/gGVpPMHojeS4eyigNwXDEfUT48
         jggje0dAHQMRPU8iHVHu1f9g7+YFZMNZ2f6Sxx57oNKsEME71Z/dFp0xz4O6hkRFO5Gr
         jsDw==
X-Gm-Message-State: AOJu0YyFF6fhEB+n4PSK4l6d7tkRHpQPwtAqNjb8bMDEOw40hVhXDAPf
	mF42R0GBBTciVG7zpcaOcBnhLNiKLpz/8+qddNf4Dg==
X-Google-Smtp-Source: AGHT+IG6h8cw+Mxa4Zm6/AqXHuovmIrUlnPfE2l9vGfthCt4OLZDPeV0ZQErMwjrgllfTniJBenjIlc3pQmGStLYI+Q=
X-Received: by 2002:a05:600c:1c8f:b0:3fe:eb42:7ec with SMTP id
 k15-20020a05600c1c8f00b003feeb4207ecmr69404wms.1.1699214369933; Sun, 05 Nov
 2023 11:59:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231104210053.343149-1-maze@google.com> <1654342n-nn1q-959p-s6r0-3846psss5on6@vanv.qr>
In-Reply-To: <1654342n-nn1q-959p-s6r0-3846psss5on6@vanv.qr>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Sun, 5 Nov 2023 11:59:18 -0800
Message-ID: <CANP3RGdCQ6REeZV9hE2HjaAN0gMtT8nuBhwQ-CQxVPTD1=k_zg@mail.gmail.com>
Subject: Re: [PATCH net] net: xt_recent: fix (increase) ipv6 literal buffer length
To: Jan Engelhardt <jengelh@inai.de>
Cc: "David S . Miller" <davem@davemloft.net>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, 
	Linux Network Development Mailing List <netdev@vger.kernel.org>, 
	Netfilter Development Mailing List <netfilter-devel@vger.kernel.org>, Patrick McHardy <kaber@trash.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 5, 2023 at 12:08=E2=80=AFAM Jan Engelhardt <jengelh@inai.de> wr=
ote:
>
>
> On Saturday 2023-11-04 22:00, Maciej =C5=BBenczykowski wrote:
> >
> >IPv4 in IPv6 is supported by in6_pton [...]
> >but the provided buffer is too short:
>
> If in6_pton were to support tunnel traffic.. wait that sounds
> unusual, and would require dst to be at least 20 bytes, which the
> function documentation contradicts.
>
> As the RFCs make no precise name proposition
>
>         (IPv6 Text Representation, third alternative,
>         IPv4 "decimal value" of the "four low-order 8-bit pieces")
>
> so let's just call it
>
>         "low-32-bit dot-decimal representation"
>
> which should avoid the tunnel term.

Resent [ https://patchwork.kernel.org/project/netdevbpf/patch/2023110519560=
0.522779-1-maze@google.com/
], hopefully this is better.
Also:
- used your (Jan's) new email in the CC.
- changed net to netfilter in the commit title
(but as it is such a trivial bug fix, it does still feel like it
should go straight into net/main... rather than via netfilter repos)

Cheers,
Maciej

