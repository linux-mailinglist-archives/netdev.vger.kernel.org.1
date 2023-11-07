Return-Path: <netdev+bounces-46523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7337E4B35
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 22:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5911AB20E71
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 21:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD712F859;
	Tue,  7 Nov 2023 21:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CUOVXhdc"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A873E2F852
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 21:57:05 +0000 (UTC)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3097910DF
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 13:57:05 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a7fb84f6ceso69126797b3.1
        for <netdev@vger.kernel.org>; Tue, 07 Nov 2023 13:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699394224; x=1699999024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=za6M8Y2d+jQ3Qt9gKNkmeDGWA71k/TCax11+8YIBTGE=;
        b=CUOVXhdcdM/DQfztHuawAMT/L1AEUiCtEV2qbEKvyBblelqOQ7FpmGm4sHhCGxAeoe
         oP6P8k57YbO7+F6hhZ9vXMM1mS9jEDh2/SYP5nAb97NkFWkbTi0GFdUJ6BS1oILnmWwz
         EExeVBxBu+WYAg8g4urdIcThxuVtP8FW3wM2u/KF9qnt3ZF2cVhWAo0dKZQbc7OT1Jm+
         LWMiyXp1A56lWxWQR6gk9WhQ+nb3FNLTJE6AkD2heKaNp4fKArs0VzfO+rsRA6umIfHM
         6si0lUZgbIAm/xkJsDPmfyna+uGmHUF6GYOmFTZSHHd49uT2FjkNkK+GvtqSz2pLZakA
         8r/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699394224; x=1699999024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=za6M8Y2d+jQ3Qt9gKNkmeDGWA71k/TCax11+8YIBTGE=;
        b=M1OEFCSeCXaTrxWs/P5V+rYtvmgxCaBYnL6S9GsnzWayEjA924+Z4QUjheJa6YxID4
         P4MhAwX2JLwpJrXtS7SpGkYZeEqyfc8GcfvkdfvU6HCeINhcYxCMu/7rpVZRbXo7ahss
         vDs9zmV0R91cre10RA/0qDi67q4HAdA6OeiGHvewr0L92yrr6KLv17iNV7gdCU5jqJmM
         LZgTD7xX6+vw6AEm2WkdjtEPlam83lVOLcRYCWnUZcddiL3escOi/SdzRRdlYwv71grf
         Xip9BfkF9qUS/FV1F5IHyi3lm0iiXdlUB55uBqkIJLFAZ8/SyihrKabtDE416uCWAzde
         i+Aw==
X-Gm-Message-State: AOJu0YyOxKFWTEm0Q2N1LK6hsAcMrKgbwHal6CSx333gN36oJFlFrwLv
	dayrbTzVfI5zrajjvXpvarPfDWOhs7udU9jWnlMz/A==
X-Google-Smtp-Source: AGHT+IF/bsw99ICNUinQH8HJWUTE/TqZCFPYGxxxKhtjJLazoPWjgkibzNnUub2UFOZbJnwmVInaoZNQXuN3J7zXnD4=
X-Received: by 2002:a05:690c:15:b0:5b3:3eb5:6624 with SMTP id
 bc21-20020a05690c001500b005b33eb56624mr13539795ywb.46.1699394224143; Tue, 07
 Nov 2023 13:57:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-8-almasrymina@google.com> <4a0e9d53-324d-e19b-2a30-ba86f9e5569e@huawei.com>
In-Reply-To: <4a0e9d53-324d-e19b-2a30-ba86f9e5569e@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 7 Nov 2023 13:56:51 -0800
Message-ID: <CAHS8izNbw7vAGo2euQGA+TF9CgQ8zwrDqTVGsOSxh22_uo0R1w@mail.gmail.com>
Subject: Re: [RFC PATCH v3 07/12] page-pool: device memory support
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 12:00=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2023/11/6 10:44, Mina Almasry wrote:
> > Overload the LSB of struct page* to indicate that it's a page_pool_iov.
> >
> > Refactor mm calls on struct page* into helpers, and add page_pool_iov
> > handling on those helpers. Modify callers of these mm APIs with calls t=
o
> > these helpers instead.
> >
> > In areas where struct page* is dereferenced, add a check for special
> > handling of page_pool_iov.
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > ---
> >  include/net/page_pool/helpers.h | 74 ++++++++++++++++++++++++++++++++-
> >  net/core/page_pool.c            | 63 ++++++++++++++++++++--------
> >  2 files changed, 118 insertions(+), 19 deletions(-)
> >
> > diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/he=
lpers.h
> > index b93243c2a640..08f1a2cc70d2 100644
> > --- a/include/net/page_pool/helpers.h
> > +++ b/include/net/page_pool/helpers.h
> > @@ -151,6 +151,64 @@ static inline struct page_pool_iov *page_to_page_p=
ool_iov(struct page *page)
> >       return NULL;
> >  }
> >
> > +static inline int page_pool_page_ref_count(struct page *page)
> > +{
> > +     if (page_is_page_pool_iov(page))
> > +             return page_pool_iov_refcount(page_to_page_pool_iov(page)=
);
>
> We have added a lot of 'if' for the devmem case, it would be better to
> make it more generic so that we can have more unified metadata handling
> for normal page and devmem. If we add another memory type here, do we
> need another 'if' here?

Maybe, not sure. I'm guessing new memory types will either be pages or
iovs, so maybe no new if statements needed.

> That is part of the reason I suggested using a more unified metadata for
> all the types of memory chunks used by page_pool.

I think your suggestion was to use struct pages for devmem. That was
thoroughly considered and intensely argued about in the initial
conversations regarding devmem and the initial RFC, and from the
conclusions there it's extremely clear to me that devmem struct pages
are categorically a no-go.

--
Thanks,
Mina

