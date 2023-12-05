Return-Path: <netdev+bounces-53890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1637805178
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 12:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AFD91F214A4
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 11:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318F151005;
	Tue,  5 Dec 2023 11:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TwA03H8X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FD610F
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 03:03:23 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2ca0288ebc5so26518021fa.0
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 03:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701774202; x=1702379002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJd4oMd5EA5C/VFOZRiD6wc4ORLmC56RXNr+hZDHSaM=;
        b=TwA03H8X7Ia1n4atLzYTV+GORT3fVQbdx7gSYzKWOFljdJf1fZAuHoV5hAiLO4jspk
         ahb+KJM+U2eayY0sm0Am6ZLR5sOUD/6N9k3IBFHv03QeJLxalNDAfFlBbrOmABsXNQUM
         qyMmC/1hAJJpOGyDiWd4HO/S/QMYMuiOi1JJqv8TzJQLaMEqyEk1RXXAWD9cIGc5pHhY
         MZ9+ekWTGG58W9BddIol6+DtCVcfYE9ZM9CGRWXPBI5oy3Nf+7tsoXsNofw4OzhlcEBA
         jCXd/rS1SGKjR/lAZVvdUA0FeuPD63o7cJRXTuvUJmO9C9K8ZuVXRPHbWFZ3ltfU5jZc
         +zJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701774202; x=1702379002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJd4oMd5EA5C/VFOZRiD6wc4ORLmC56RXNr+hZDHSaM=;
        b=V0gjOz16ZGKxfRPfl3t2llIiQ6n1MHm7ubtNlUHG6w0oF0rD6l5EblskqHjJBokf/t
         P3lsgCAksZqjlHxL/anuSFckfKz7aK4OWAfjQ8YSwl2JtOYdWxdmfCi17wMsl1zMP5gB
         HqlGK9f1eu9OOH7FEx+3tM6GugqpVDJPsJMu2mCexYCg3CsMz0zWVt3G+OlDU9ThvOb6
         dqbPw+ls8HkqHNpKuFoeJhZMja38B5pLFTIcTyi6vKtjAkcEgMfZlxYoDVe4QxCOq+La
         2fvcASmavDq1XsHCm577ycIk7SoM+YpdrCwzMlpMA/wnm3CWe1jkz8NX4q0beHa33TBD
         q8vw==
X-Gm-Message-State: AOJu0Yxlyj51ffQGrZWHJQz3UqOBfodva85w18zDNxSVdiQbkOMcCv3B
	EQT0FXQPaIRmU1eAY6/YPtQkcyJau30AGCmdXV3Nig==
X-Google-Smtp-Source: AGHT+IG7SpDz/QiWwULBTrktELF3o8Kag0qEqzvmNnF2brmckaGERotIYRE7mpIFn9MaR99qqMKPKTAhMHwYrBaUaOk=
X-Received: by 2002:a2e:b615:0:b0:2ca:fe7:1ec9 with SMTP id
 r21-20020a2eb615000000b002ca0fe71ec9mr726188ljn.44.1701774202088; Tue, 05 Dec
 2023 03:03:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130115611.6632-1-liangchen.linux@gmail.com>
 <20231130115611.6632-4-liangchen.linux@gmail.com> <CAC_iWjJUaUiQfq6Lw+D-ruf3p0L3WVVYXZSL-pAKpbeH=nu-CA@mail.gmail.com>
 <CAKhg4t+hBgmEnZ6d+GKBRN7+wCqHVrOhEaaTAUViME_Mmu1K5w@mail.gmail.com>
In-Reply-To: <CAKhg4t+hBgmEnZ6d+GKBRN7+wCqHVrOhEaaTAUViME_Mmu1K5w@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 5 Dec 2023 13:02:46 +0200
Message-ID: <CAC_iWj+8srOuAxEMe5rt7vk1d=6V2ZDzjsHameaSt0a+rxwdhA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 3/4] skbuff: Add a function to check if a page
 belongs to page_pool
To: Liang Chen <liangchen.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, linyunsheng@huawei.com, 
	netdev@vger.kernel.org, linux-mm@kvack.org, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Liang,

On Mon, 4 Dec 2023 at 04:40, Liang Chen <liangchen.linux@gmail.com> wrote:
>
> On Fri, Dec 1, 2023 at 6:23=E2=80=AFPM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > The second time is the charm, apologize for the noise.. resending it
> > as plain-text
> >
> > On Thu, 30 Nov 2023 at 13:59, Liang Chen <liangchen.linux@gmail.com> wr=
ote:
> > >
> > > Wrap code for checking if a page is a page_pool page into a
> > > function for better readability and ease of reuse.
> > >
> > > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > > Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>
> > > ---
> > >  net/core/skbuff.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > index b157efea5dea..31e57c29c556 100644
> > > --- a/net/core/skbuff.c
> > > +++ b/net/core/skbuff.c
> > > @@ -890,6 +890,11 @@ static void skb_clone_fraglist(struct sk_buff *s=
kb)
> > >                 skb_get(list);
> > >  }
> > >
> > > +static bool skb_frag_is_pp_page(struct page *page)
> > > +{
> > > +       return (page->pp_magic & ~0x3UL) =3D=3D PP_SIGNATURE;
> > > +}
> > > +
> >
> > That's fine, but why _frag? The same logic applies to non-fragmented pa=
ges no?
> > So rename it to skb_from_pp()?
> >
>
> Yeah, the same logic applies to non-fragmented pages. How about
> changing it to 'is_pp_page'? It takes a page as an argument instead of
> the entire skb.

Naming stuff is always hard. Any of skb_from_pp/is_pp_page would work for m=
e

Thanks
/Ilias
> > [...]
> >
> > Thanks
> > /Ilias

