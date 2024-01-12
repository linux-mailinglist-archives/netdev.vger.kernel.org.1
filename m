Return-Path: <netdev+bounces-63298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2121A82C2D8
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 16:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8A71C20853
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 15:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1D26EB4E;
	Fri, 12 Jan 2024 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GtbPoXcp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D018D6A349
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2814fa68eeso563987066b.1
        for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 07:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705073752; x=1705678552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whjPsk4XdEZx10a+QkolkUanx0+H5dgtbjZzT4t8s5c=;
        b=GtbPoXcpXkvkIAcEaDXRbLhGH1dbS67qRZF4fU2HolbUOwDRIlyMUciiaHSdryea4x
         sR3lB530TWujxwL1gm0TQ/5ZSzVav9okuYKfYt2luwT2EXOP1BTHvT14K5IzCU4B4AEX
         q43jzHmK9QzDGngT6jC9qMGYmeNCFsSjtOJxgKHh+pUpPAkUUfVbIdJx4Utuy7MIiIyI
         WPBmRBu9Hg6/BOuVqmymEjCvz/0LaOFY5HK40Ty/uM8s8YU8ZnDpU1UkvoL7tC2oUKWg
         ELRQVP2Owi6Kimd4HuzUufkc1S+WsEJLLp/iNFwls0OxzhiZmAUC6O07y6/TNZmM/qA4
         ixbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705073752; x=1705678552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whjPsk4XdEZx10a+QkolkUanx0+H5dgtbjZzT4t8s5c=;
        b=YEhe4a/59BG8ZYQRjSvWfNPGUeJnG5seNA3h6Q2VlC4mR0/ceZ59JWCXDwVH2lmePj
         DKqblDm6ylV7wnxnOU10fzmk9VC6Q+YNjEk3EAG8drAf+Xvw2wpI+UFV0e8BLp2lsdBG
         FSdOeWwdqTRrHK2s31lOaSgG4KzvAJkVb3HTC+cla2OrM9Vsn5iMbgANTq4Dc8uzjxDh
         0m31v8NOmdaa7bkC0tHi5we4f6u8fLhqCqIp6+v//kJsV2Poao/2bSNTmZqkSvHx/jR+
         oOsvq0Q8n8Oa5S8PMLEm76faEANNv3QsvdcYlXBSs5H5S8sXsxugPbzKRQ0A/87aSOnY
         ITnQ==
X-Gm-Message-State: AOJu0YyvOxeErKXwn8QAedev82316vWhUz1D04mzOyJygccr2Evxo0G0
	hXT57Uyv6yIBw/E3Ai8/kwl8k1PxhVFK+/Gzcr/jLJKzRc2P
X-Google-Smtp-Source: AGHT+IHEB7lPxr/HMDNrYL/Lh+445rPn+RNMn0WtzvLw+Am98T/nWIUH8IZ28TPBOEZmmJ5NzDhXu+JC9MED7ujl43s=
X-Received: by 2002:a17:907:a689:b0:a2c:e323:b71 with SMTP id
 vv9-20020a170907a68900b00a2ce3230b71mr412667ejc.0.1705073751812; Fri, 12 Jan
 2024 07:35:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109011455.1061529-1-almasrymina@google.com>
 <20240109011455.1061529-3-almasrymina@google.com> <5219f2cd-6854-0134-560d-8ae3f363b53f@huawei.com>
 <CAHS8izOtr+jfqQ6xCB3CoN-K_V1-4hPsB4-k5+1z-M3Qy2BbwA@mail.gmail.com> <0711845b-c435-251f-0bbc-20b243721c06@huawei.com>
In-Reply-To: <0711845b-c435-251f-0bbc-20b243721c06@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 12 Jan 2024 07:35:38 -0800
Message-ID: <CAHS8izOxvMVGXKpLBvVgyyS5_94WGG8Aca=O_zGMX+db-3gBXg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v5 2/2] net: add netmem to skb_frag_t
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeelb@google.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 3:51=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/1/12 8:34, Mina Almasry wrote:
> > On Thu, Jan 11, 2024 at 4:45=E2=80=AFAM Yunsheng Lin <linyunsheng@huawe=
i.com> wrote:
> >>
> >> On 2024/1/9 9:14, Mina Almasry wrote:
> >>
> >> ...
> >>
> >>>
> >>> +             if (WARN_ON_ONCE(!skb_frag_page(&skb_shinfo(skb)->frags=
[0]))) {
> >>
> >> I am really hate to bring it up again.
> >> If you are not willing to introduce a new helper,
> >
> > I'm actually more than happy to add a new helper like:
> >
> > static inline netmem_ref skb_frag_netmem();
> >
> > For future callers to obtain frag->netmem to use the netmem_ref directl=
y.
> >
> > What I'm hung up on is really your follow up request:
> >
> > "Is it possible to introduce something like skb_frag_netmem() for
> > netmem? so that we can keep most existing users of skb_frag_page()
> > unchanged and avoid adding additional checking overhead for existing
> > users."
> >
> > With this patchseries, skb_frag_t no longer has a page pointer inside
> > of it, it only has a netmem_ref. The netmem_ref is currently always a
> > page, but in the future may not be a page. Can you clarify how we keep
> > skb_frag_page() unchanged and without checks? What do you expect
> > skb_frag_page() and its callers to do? We can not assume netmem_ref is
> > always a struct page. I'm happy to implement a change but I need to
> > understand it a bit better.


You did not answer my question that I asked here, and ignoring this
question is preventing us from making any forward progress on this
discussion. What do you expect or want skb_frag_page() to do when
there is no page in the frag?

>
> There are still many existing places still not expecting or handling
> skb_frag_page() returning NULL, mostly those are in the drivers not
> supporting devmem,

As of this series skb_frag_page() cannot return NULL.

In the devmem series, all core networking stack places where
skb_frag_page() may return NULL are audited.

skb_frag_page() returning NULL in a driver that doesn't support devmem
is not possible. The driver is the one that creates the devmem frags
in the first place. When the driver author adds devmem support, they
should also add support for skb_frag_page() returning NULL.

> what's the point of adding the extral overhead for
> those driver?
>

There is no overhead with static branches. The checks are no-op unless
the user enables devmem, at which point the devmem connections see no
overhead and non-devmem connections will see minimal overhead that I
suspect will not reproduce any perf issue. If the user is not fine
with that they can simply not enable devmem and continue to not
experience any overhead.

> The networking stack should forbid skb with devmem frag being forwarded
> to drivers not supporting devmem yet. I am sure if this is done properly
> in your patchset yet? if not, I think you might to audit every existing
> drivers handling skb_frag_page() returning NULL correctly.
>

There is no audit required. The devmem frags are generated by the
driver and forwarded to the TCP stack, not the other way around.

>
> >
> >> do you care to use some
> >> existing API like skb_frag_address_safe()?
> >>
> >
> > skb_frag_address_safe() checks that the page is mapped. In this case,
> > we are not checking if the frag page is mapped; we would like to make
> > sure that the skb_frag has a page inside of it in the first place.
> > Seems like a different check from skb_frag_address_safe().
> >
> > In fact, skb_frag_address[_safe]() actually assume that the skb frag
> > is always a page currently, I think I need to squash this fix:
> >
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index e59f76151628..bc8b107d0235 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -3533,7 +3533,9 @@ static inline void skb_frag_unref(struct sk_buff
> > *skb, int f)
> >   */
> >  static inline void *skb_frag_address(const skb_frag_t *frag)
> >  {
> > -       return page_address(skb_frag_page(frag)) + skb_frag_off(frag);
> > +       return skb_frag_page(frag) ?
> > +               page_address(skb_frag_page(frag)) + skb_frag_off(frag) =
:
> > +               NULL;
> >  }
> >
> >  /**
> > @@ -3545,7 +3547,14 @@ static inline void *skb_frag_address(const
> > skb_frag_t *frag)
> >   */
> >  static inline void *skb_frag_address_safe(const skb_frag_t *frag)
> >  {
> > -       void *ptr =3D page_address(skb_frag_page(frag));
> > +       struct page *page;
> > +       void *ptr;
> > +
> > +       page =3D skb_frag_page(frag);
> > +       if (!page)
> > +               return NULL;
> > +
> > +       ptr =3D page_address(skb_frag_page(frag));
> >         if (unlikely(!ptr))
> >                 return NULL;
> >
> >>> +                     ret =3D -EINVAL;
> >>> +                     goto out;
> >>> +             }
> >>> +
> >>>               iov_iter_bvec(&msg.msg_iter, ITER_SOURCE,
> >>> -                           skb_shinfo(skb)->frags, skb_shinfo(skb)->=
nr_frags,
> >>> -                           msize);
> >>> +                           (const struct bio_vec *)skb_shinfo(skb)->=
frags,
> >>> +                           skb_shinfo(skb)->nr_frags, msize);
> >>
> >> I think we need to use some built-time checking to ensure some consist=
ency
> >> between skb_frag_t and bio_vec.
> >>
> >
> > I can add static_assert() that bio_vec->bv_len & bio_vec->bv_offset
> > are aligned with skb_frag_t->len & skb_frag_t->offset.
> >
> > I can also maybe add a helper skb_frag_bvec() to do the cast instead
> > of doing it at the calling site. That may be a bit cleaner.
>
> I think the more generic way to do is to add something like iov_iter_netm=
em()
> instead of doing any cast, so that netmem can be decoupled from bvec comp=
letely.
>
> >
> >>>               iov_iter_advance(&msg.msg_iter, txm->frag_offset);
> >>>
> >>>               do {
> >>>
> >
> >
> >
> > --
> > Thanks,
> > Mina
> > .
> >



--=20
Thanks,
Mina

