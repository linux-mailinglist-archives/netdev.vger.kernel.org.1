Return-Path: <netdev+bounces-52021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABC77FCFB9
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 08:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 662161C209C1
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 07:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8D5101C9;
	Wed, 29 Nov 2023 07:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MshA/nZs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBB91710
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 23:08:38 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a013d22effcso856065066b.2
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 23:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701241717; x=1701846517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nuvuUMTlyK81QlR7/R4I+To/jaHQwOiJ0V8+2WOZipM=;
        b=MshA/nZsj4sUvuYzcB1BIzy1gPl50j4fprorMUCkXqjwh33zyfv090gBzubAOZwBrl
         eVfn3M81LqOkqFtUMJwhWnqJAn2dgUSTCpdXnh3JgT+CqnDVgl5mrABpakDPq0/E1Dw9
         KYWzp1iBXMTxZcSknt+GV1fuqUdvaZFLHj2DXFTId23CC6A0v06FCRUyYdHEbwIuhZmI
         eQnZdIWHoQwq6SFoW4JZoxlse1sS1p6CgbXTtHmHaa/Xrd+x5uYLI1hEFW+vkM8/IMMM
         RCFGaHXild7p04SqdHW0uHFV6DmvH72rRlm8xW4I/wgG7vTs78f7AZzaR1+jqGa/vstA
         2DSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701241717; x=1701846517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nuvuUMTlyK81QlR7/R4I+To/jaHQwOiJ0V8+2WOZipM=;
        b=rLnCp9TWbENMpg/bpOqQOmhGdSD8UMJnpIrnKf7I4pzcSj304aHe1kCFo5OLVDoKl3
         097tD0BESXSl91tBFtTFcGrdlOfEKnVhG51Gers4w3BDV9151bP9pRx3jb256iw7kR7X
         v+EG6Cw+34Y2warbX7ZnKRDQqfKg83LX7LMF8Ua9KF58jzZ9KAiDikhP1ZLO1lHlV8Yh
         J69GzxnJ3HETQUUmiOOuA7DW2eUOpGihrKD/ZXANwUzOG9760b5xuvBcvBd1qphwxxbs
         ooowUqxz/2qTCmW+5lmI0hUaBs0fw5mhCLl0qxxin/GKueyNovJMrKguP2XA1EXLT1fF
         jp0Q==
X-Gm-Message-State: AOJu0YyaRmlXUsgJg1SrJtQVtDuy0WSf8gNiiksGJemJn6vG+7w4mdV/
	qIjvPMMZ/HtQ1MAPIs72wFr+rZ43f0PHWsu+os/IAg0lAaw=
X-Google-Smtp-Source: AGHT+IFJDQkuDlh+FjWcnfs01grtLcYECj9VOlgqUTv6QhB6owAzWe309QEm8nvYaV8pkisonGKVjZF6aCm5fh4Ym9c=
X-Received: by 2002:a17:906:5293:b0:9bf:63b2:b6e2 with SMTP id
 c19-20020a170906529300b009bf63b2b6e2mr12456418ejm.26.1701241716505; Tue, 28
 Nov 2023 23:08:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129031201.32014-1-liangchen.linux@gmail.com>
 <20231129031201.32014-4-liangchen.linux@gmail.com> <844dc02a-3559-5a53-943d-28f772670879@huawei.com>
In-Reply-To: <844dc02a-3559-5a53-943d-28f772670879@huawei.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Wed, 29 Nov 2023 15:08:24 +0800
Message-ID: <CAKhg4tJ4vFpsO+=JMCboan==JsKhEjGDVeBk=cM+BmVO+xqFNg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/4] skbuff: Add a function to check if a page
 belongs to page_pool
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	netdev@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 11:40=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.c=
om> wrote:
>
> On 2023/11/29 11:12, Liang Chen wrote:
> > Wrap code for checking if a page is a page_pool page into a
> > function for better readability and ease of reuse.
> >
> > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > ---
> >  net/core/skbuff.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index b157efea5dea..310207389f51 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -890,6 +890,11 @@ static void skb_clone_fraglist(struct sk_buff *skb=
)
> >               skb_get(list);
> >  }
> >
> > +static inline bool skb_frag_is_pp_page(struct page *page)
>
> I am not sure about the 'skb_frag' part, But I am not able to come
> up with a better name too:)
>

So, let's leave it there for now:)
> Also, Generally, 'inline' is not really encouraged in c file in
> the networking unless there is a clear justification as the compiler
> can make better decision about whether inlining most of the time.
>

Sure. will remove 'inline' in v5.

> Other than the 'inlining' part, LGTM.
> Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>
>
> > +{
> > +     return (page->pp_magic & ~0x3UL) =3D=3D PP_SIGNATURE;
> > +}
> > +
> >  #if IS_ENABLED(CONFIG_PAGE_POOL)
> >  bool napi_pp_put_page(struct page *page, bool napi_safe)
> >  {
> > @@ -905,7 +910,7 @@ bool napi_pp_put_page(struct page *page, bool napi_=
safe)
> >        * and page_is_pfmemalloc() is checked in __page_pool_put_page()
> >        * to avoid recycling the pfmemalloc page.
> >        */
> > -     if (unlikely((page->pp_magic & ~0x3UL) !=3D PP_SIGNATURE))
> > +     if (unlikely(!skb_frag_is_pp_page(page)))
> >               return false;
> >
> >       pp =3D page->pp;
> >

