Return-Path: <netdev+bounces-53374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2D8802A5E
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 03:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5942E1F20F1D
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 02:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F19C814;
	Mon,  4 Dec 2023 02:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kv70FrkW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C609C3
	for <netdev@vger.kernel.org>; Sun,  3 Dec 2023 18:40:19 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c0a11a914so6483835e9.2
        for <netdev@vger.kernel.org>; Sun, 03 Dec 2023 18:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701657618; x=1702262418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6ad35jf8C8Ph7dsQvygt2QEuwxMTGgW33q/fgDf/SM=;
        b=Kv70FrkW1NkBRn5thnqxjIgnVI2tcbd6fKm0iHondbVFDcPy4hPy6Uy/GilFyXTnr2
         xZGyPb/KinCjQPlNQXWCJpx3ScNp6sRj15W6Aiyfw65RkUToBmnL7dij+ys6VoUs0lJB
         TURVs/+tJRGWxi+PN+LER2BSCnKCFsEgJu+5BZ9FMTLLXwxHr7dP6QrkL8f0sgdJhlWu
         uz4GjQEuLg7yUF6Q82SXz16jxbWDq7nHvtVrDtZg26XpUchY7NJY3daSkbw79oAlgNcW
         y3GyQjefziKtfXoy5qoj0FRmKp8qr5+lJdDAwCu7kdKwgcJxQKYhpgqaWxkHEy7CsU+P
         C5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701657618; x=1702262418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6ad35jf8C8Ph7dsQvygt2QEuwxMTGgW33q/fgDf/SM=;
        b=QamddQiolK+MZS7+ep5cwPoDBoJtQNbNYHOLdmTPU0C8vz+497ILFyRrGd/lvDmaF8
         3u7fdagFgawJZoV+Bxn1kIjBu8SCZaObfUiNKTnMS+uvI1qmMyaWeJxa9Uwx3aibiVjH
         cwqz0EVgWtiO5+6NDM0JV4ObOwq3QQfYQ0tj80bSZv1OhVjBqA8VPWpZVsxvej5Miqaq
         zaOcavDIB519FbqFkw2VqVTTnhDPIUtUyEw38d1lhJPHFUFyNrjA03SSpuUIx5w4EtPT
         tYzH/mLUgyAl7+nY4d+zuKzh707yaXt53zGCUcXEcmWenvXGVjDTvDQifrKGScJqL/q7
         6Ccg==
X-Gm-Message-State: AOJu0YyqggTOj1HQQIZbxKv0gxzCmdeOYroiBxCUi8x+XyyIAN521ZTD
	y/HAg4o77DOqSuzMnSoGB0Yr7c7IRAiHwQQKVbc=
X-Google-Smtp-Source: AGHT+IHvpQzHOa6JyrsYbT48kgHxpqhNoY1BCpvOXKIE0ASxxvQvE22pbm9FbiDKAy0qr7L+P/CArsAr28TXXdX+yI8=
X-Received: by 2002:a05:600c:a06:b0:40b:5e1e:b3b6 with SMTP id
 z6-20020a05600c0a0600b0040b5e1eb3b6mr2085201wmp.52.1701657617452; Sun, 03 Dec
 2023 18:40:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130115611.6632-1-liangchen.linux@gmail.com>
 <20231130115611.6632-4-liangchen.linux@gmail.com> <CAC_iWjJUaUiQfq6Lw+D-ruf3p0L3WVVYXZSL-pAKpbeH=nu-CA@mail.gmail.com>
In-Reply-To: <CAC_iWjJUaUiQfq6Lw+D-ruf3p0L3WVVYXZSL-pAKpbeH=nu-CA@mail.gmail.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Mon, 4 Dec 2023 10:40:04 +0800
Message-ID: <CAKhg4t+hBgmEnZ6d+GKBRN7+wCqHVrOhEaaTAUViME_Mmu1K5w@mail.gmail.com>
Subject: Re: [PATCH net-next v6 3/4] skbuff: Add a function to check if a page
 belongs to page_pool
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, linyunsheng@huawei.com, 
	netdev@vger.kernel.org, linux-mm@kvack.org, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 6:23=E2=80=AFPM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> The second time is the charm, apologize for the noise.. resending it
> as plain-text
>
> On Thu, 30 Nov 2023 at 13:59, Liang Chen <liangchen.linux@gmail.com> wrot=
e:
> >
> > Wrap code for checking if a page is a page_pool page into a
> > function for better readability and ease of reuse.
> >
> > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>
> > ---
> >  net/core/skbuff.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index b157efea5dea..31e57c29c556 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -890,6 +890,11 @@ static void skb_clone_fraglist(struct sk_buff *skb=
)
> >                 skb_get(list);
> >  }
> >
> > +static bool skb_frag_is_pp_page(struct page *page)
> > +{
> > +       return (page->pp_magic & ~0x3UL) =3D=3D PP_SIGNATURE;
> > +}
> > +
>
> That's fine, but why _frag? The same logic applies to non-fragmented page=
s no?
> So rename it to skb_from_pp()?
>

Yeah, the same logic applies to non-fragmented pages. How about
changing it to 'is_pp_page'? It takes a page as an argument instead of
the entire skb.
> [...]
>
> Thanks
> /Ilias

