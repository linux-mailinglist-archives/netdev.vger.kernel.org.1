Return-Path: <netdev+bounces-52022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DC67FCFBA
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 08:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 777DD2826A2
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 07:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DED107AD;
	Wed, 29 Nov 2023 07:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNN0ZD+5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2141735
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 23:08:50 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5484ef5e3d2so8209727a12.3
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 23:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701241729; x=1701846529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tiPCgtx3KK6Y+OPc0gpmsjkWj4LuZCAU+LhNn1oeOQ=;
        b=UNN0ZD+52nKJWvv+ohFGQdr2yNXhv3M6FBYv4GX1U2c1ERN4rH0CfRA3XWh+8Imi8G
         xFYNUZqY6xhKJblrVzxqLuOqA0U/rFVz8nNDisfcOLx/BrvQ6wHDCNf+TcT2moXb+GTh
         BYho3wAYjbf5t9R/s/24sktncc3xQrXQ37uYWOr0NRrQlrnQ+UkCi7ouGgoCxGbdW0+D
         kQf+aEay/hqE/7GohjO9UdHgYu10V+Wyrb10GkUHXFFrazB7b4TVdQf5YOlGC0LVu192
         nVXMYNbrI9V9RmtWfnKhDKcvwH1FJ0OXJmN3F7waxt5EiPcGXvvyID/oI1WLp+uHzijV
         qlTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701241729; x=1701846529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5tiPCgtx3KK6Y+OPc0gpmsjkWj4LuZCAU+LhNn1oeOQ=;
        b=cu9IWqTgy4FEBIl2CXn/PrWD1hfO7kakfcVdz0K3E/+KqyrbziSzN/cQwK9PUKpo70
         g0tm9rlgW2WDaOiuJOLgQiXaS9V6QQ3yB5PYiLSF+NLSgvOHhIXqDnWgc/coZJiRel69
         OVM36iqO/qiyRhE0kS1Y8pcxkQW3xvX2t4xuE93A45g4nMOQCqtwILFd+k6U0eHaeLdX
         VrLGGuRNK2wcx0iNSfLYmmtCEDXprT2ROFEheGXd76OxODo7RloAymiVRhTPUd4DZEaX
         zFjoH+DyvetdlW15Y7OisiVLQI8v6BCgkAoJD1Z0ANYpUz0/OAUIoikP3iJuTrt6zR0d
         CZOw==
X-Gm-Message-State: AOJu0YzHicu7gM0hpRstG9lIvjy8Ljn0v5BOQLO89MQBk74rFeEFPTxE
	FVSqTD4B5UEONLqeqyxbYMzB1LM3ZBycppLZbd4=
X-Google-Smtp-Source: AGHT+IHi5amqGdjQMho1OrR+rLW8l2dUNSsa79oIKQqxhrS9IS6HxuA18Cyc3pXEVAdyTv5ogfTYCRw7wl+7gF26KIA=
X-Received: by 2002:a17:906:3e0e:b0:9c1:edd8:43c2 with SMTP id
 k14-20020a1709063e0e00b009c1edd843c2mr12236426eji.42.1701241729201; Tue, 28
 Nov 2023 23:08:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129031201.32014-1-liangchen.linux@gmail.com>
 <20231129031201.32014-5-liangchen.linux@gmail.com> <664e753b-23ba-56b7-a2b7-a2bd83260887@huawei.com>
In-Reply-To: <664e753b-23ba-56b7-a2b7-a2bd83260887@huawei.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Wed, 29 Nov 2023 15:08:35 +0800
Message-ID: <CAKhg4t+dAj=gOSrTw-y0dx_2HDBgx+qY_gv2rEXPRKUiJFMJLA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 4/4] skbuff: Optimization of SKB coalescing
 for page pool
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	netdev@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 11:56=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.c=
om> wrote:
>
> On 2023/11/29 11:12, Liang Chen wrote:
> >
> > +/**
> > + * skb_pp_get_frag_ref() - Increase fragment reference count of a page
> > + * @page:    page of the fragment on which to increase a reference
> > + *
> > + * Increase fragment reference count (pp_ref_count) on a page, but if =
it is
> > + * not a page pool page, fallback to increase a reference(_refcount) o=
n a
> > + * normal page.
> > + */
> > +static inline void skb_pp_get_frag_ref(struct page *page)
>
> Simiar comment for 'inline ' too.
>

Sure.
> Also, Is skb_pp_frag_ref() a better name than skb_pp_get_frag_ref()
> mirroring skb_frag_ref()?
>

Sure. skb_pp_frag_ref sounds better:)
> > +{
> > +     struct page *head_page =3D compound_head(page);
> > +
> > +     if (likely(skb_frag_is_pp_page(head_page)))
> > +             atomic_long_inc(&head_page->pp_ref_count);
>
> As pp_ref_count is supposed to be a internal field to page_pool,
> I am not sure if it matters that much to manipulate pp_ref_count
> directly in skbuff core.
>
> Maybe we can provide a helper for that if it really matter in the
> future.
>
>

Sure. will provide a helper in page_pool/helpers.h
> > +     else
> > +             get_page(head_page);
>
> I suppose we can use page_ref_inc() as we have a compound_head()
> calling in the above.
>

Sure. Thanks!

> Other than the above nits, LGTM.
>
> Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>

