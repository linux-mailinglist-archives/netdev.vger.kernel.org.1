Return-Path: <netdev+bounces-58951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF87E818ABA
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 16:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D563C1C21A6A
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 15:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2868F1BDDE;
	Tue, 19 Dec 2023 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3kBJC7px"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BFB20315
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so15771a12.0
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 07:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702998156; x=1703602956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Px3R+YIh5PQ/gOPwHTyJV+wi4ltg6ySoz0bgIUEmZv0=;
        b=3kBJC7pxxOXIC2nG4XpsNwdmL2tPN0HzIDhadnvzRIMHYkkIKnZVun19a7Nht5B61d
         3OKTgWfaYpJlzjUo0Nixp0KKMRq7+niEOHvj2vI+l/4LL9UaGtsrZcW7/sWga3mCbbY6
         oA/E9LzUdI1qyE911Vm4db/8vdj7vW0U+S1iTrXwBEWbU/B73Jy4FTx1hBwXpVOzeZMF
         S4FSolYYcHmXHeipmYLPAfgTeq3Ng1u90hz/csPjO+w72P+eT+BXB6qg6VeKYsKkax9X
         J8/P8GtZdBHHa7EUpTPyiw+RP0BpkRlmyK4Xgbh/7hNQCEqkig4pYA1AXmn7Hn0c36tS
         xmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702998156; x=1703602956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Px3R+YIh5PQ/gOPwHTyJV+wi4ltg6ySoz0bgIUEmZv0=;
        b=cZPGT98bdpxkmOQICHQPFD6mxsM675Ucdz8RYEU9gmSY8fvyQxBHnXqu9vjFededqs
         Gi/zKJSCHkS/Y0NnZ07rG1eP21DBtoXLImpPFwlFxDbGGGFTUJSPwt+ckTF8igA3P3K4
         Y8WML9EyT55eXkqJrX9XQ+VSvxGM7rE95SK1rF2OSbJg3MYtkCh/uOC+YP1jAY2IJqQv
         UHKsjHN2vtddTVNkoEnTrnecgiZw4A7dYM7xjEVo27lZzZs3EuOhQvBtArBlvsUXpU6R
         SGPG69gSvgyeBfb3bTWGW3ETR68rZfhgXh18AGah0DyXP0yYkKRbGBn8xFckDd//3CT1
         mzgA==
X-Gm-Message-State: AOJu0YxLskH2zUYWZZwY82g194OeHieVYNNUx+kj+Dhre4JpqX+k0JTT
	jKEPzTHBOl0/iib0nmYyrpoFYVFpoXplaFe3t/+pJCbLCMhV
X-Google-Smtp-Source: AGHT+IGRY/3HG+jPsYWUp9SBBE0EvPMT610dURXYSSuBBwZb/+KGVMQ/+H97CcRJf47swMagq4I8Zd2sd7hONSCNkIo=
X-Received: by 2002:a50:d616:0:b0:553:5578:2fc9 with SMTP id
 x22-20020a50d616000000b0055355782fc9mr162639edi.5.1702998155484; Tue, 19 Dec
 2023 07:02:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219125331.4127498-1-edumazet@google.com> <21ccf1acce6f4a711f6323f9392c1254135999b8.camel@redhat.com>
In-Reply-To: <21ccf1acce6f4a711f6323f9392c1254135999b8.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 19 Dec 2023 16:02:24 +0100
Message-ID: <CANn89i+T6oYTNrjeQ4K7D1kYHTQgwJ1uJxCn0LY0ADPEg_bGbw@mail.gmail.com>
Subject: Re: [PATCH net] net: check dev->gso_max_size in gso_features_check()
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 3:42=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Tue, 2023-12-19 at 12:53 +0000, Eric Dumazet wrote:
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 0432b04cf9b000628497345d9ec0e8a141a617a3..b55d539dca153f921260346=
a4f23bcce0e888227 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -3471,6 +3471,9 @@ static netdev_features_t gso_features_check(const=
 struct sk_buff *skb,
> >       if (gso_segs > READ_ONCE(dev->gso_max_segs))
> >               return features & ~NETIF_F_GSO_MASK;
> >
> > +     if (unlikely(skb->len >=3D READ_ONCE(dev->gso_max_size)))
>
> Since we are checking vs the limit supported by the NIC, should the
> above be 'tso_max_size'?
>
> My understanding is that 'gso{,_ipv4}_max_size' is the max aggregate
> size the device asks for, and 'tso_max_size' is the actual limit
> supported by the NIC.
>

Problem is tso_max_size has been added very recently, depending on
this would make backports tricky.

I think the fix using gso_max_size is more portable to stable
versions, and allows the user to tweak the value,
and build tests.

As a bonus, dev->gso_max_size is in the net_device_read_tx cacheline,
while tso_max_size is currently far away.

