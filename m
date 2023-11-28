Return-Path: <netdev+bounces-51635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 244007FB83C
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 11:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 524F71C20F67
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 10:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9354E18C08;
	Tue, 28 Nov 2023 10:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCcJ3ZwP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F3E10E
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 02:42:08 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a03a900956dso998278866b.1
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 02:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701168127; x=1701772927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DozXjJqnuFuq9pSAH2N19zU2gp9mW0B1YAvriLiF6cc=;
        b=MCcJ3ZwPTy8jR7IoVOfoZ9Gah9ndN2m9u5AQoKXMqVJvZzXsSlz0Zrm4JcoXGUdB0M
         f5GU1VVOmrpE8NEzBx3NHPHtYXAtI/HIkKFe4HjA7MHn0UyPLWcqmQtVRJFSABC6ruC9
         Dub5HcTFeVm+PsQi3gaRejPe2z2XcTHCcCcLsxtjpJLA/4SL+fLvYK0Nonmbw3Nm40dj
         8RVaHbx5B0RGkajpf3xRzToeyGHtg6K/ivk7VarOAGXGMPEggP3DQVXzxqBkwEinrdvE
         7nXys+My8TZmx5qjNDIg2BQaDbomMO9iLWYT+c8jqtvXXTGOOgTJy/thYT50ZFNCjAzn
         yskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701168127; x=1701772927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DozXjJqnuFuq9pSAH2N19zU2gp9mW0B1YAvriLiF6cc=;
        b=f7hA97xfYdJeMDTT0YHaKp4oYyKKsK+wEcZt1+G4GA+m4eCxjoAwU58/d+9hreQ538
         9gYJbxWSeAWJvdCwpJUzy7dUL1JfCB9rE1qw+oVtwMn7hD6Y9vWy25XNzuA6UC+GkT/H
         dozDFwzvvpwqw0gCm0d9C34nPYwcLsxa64e9ug+KRFNRBX/6qexBEQKSr9AzWHXIioPG
         15rqnRuTC+Dxywmk1MNrOUUvf1UiEMGp9WNq2Wg3fhepvw//RPJMYeA8h3Y04YU0vcMY
         Ih4HlF74O/WeJQqVpMYUyFQxaJyavgP3fwAVbNmr6mTvSZMcx7KdInOddEjnYOBAN0dg
         mnkA==
X-Gm-Message-State: AOJu0Yy008dut9BD4ve9TBFhyWqK4Zhq6w73oqf7LhyhRtrSjP3dTm4i
	hTpcMMrWtwovu+RxVN4VyAtyCu1MLuk9FPpGN2g=
X-Google-Smtp-Source: AGHT+IGTZIrZa1Lt+/Q5jBFS7D8yaTtRM40DmOkXoDVWsRHMms0pfIOn0To7U9cqouW4Zr2K3C7ygQY9DmN0WRNbSSU=
X-Received: by 2002:a17:906:c791:b0:9ad:8a96:ad55 with SMTP id
 cw17-20020a170906c79100b009ad8a96ad55mr16600400ejb.14.1701168126895; Tue, 28
 Nov 2023 02:42:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124073439.52626-1-liangchen.linux@gmail.com>
 <20231124073439.52626-4-liangchen.linux@gmail.com> <d26decd3-7235-c4ce-f083-16a52d15ff1c@huawei.com>
 <CAKhg4tKtsDgaNkmcH8RXVTVq_c2-SOxZTsTDTw_KH5FZ+sZuBQ@mail.gmail.com> <288af908-eed4-7ba0-17d5-2c7fb2c87233@huawei.com>
In-Reply-To: <288af908-eed4-7ba0-17d5-2c7fb2c87233@huawei.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Tue, 28 Nov 2023 18:41:54 +0800
Message-ID: <CAKhg4tKr5FZyeMq0+dyKQydgeE4WrEimhpxv_nVoqqY96YWK3g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] skbuff: Optimization of SKB coalescing
 for page pool
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	netdev@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 6:48=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2023/11/27 12:23, Liang Chen wrote:
> > On Sat, Nov 25, 2023 at 8:16=E2=80=AFPM Yunsheng Lin <linyunsheng@huawe=
i.com> wrote:
> >>
> >> On 2023/11/24 15:34, Liang Chen wrote:
> >>
> >> ...
> >>
> >>> --- a/include/net/page_pool/helpers.h
> >>> +++ b/include/net/page_pool/helpers.h
> >>> @@ -402,4 +402,26 @@ static inline void page_pool_nid_changed(struct =
page_pool *pool, int new_nid)
> >>>               page_pool_update_nid(pool, new_nid);
> >>>  }
> >>>
> >>> +static inline bool page_pool_is_pp_page(struct page *page)
> >>> +{
> >>
> >> We have a page->pp_magic checking in napi_pp_put_page() in skbuff.c al=
ready,
> >> it seems better to move it to skbuff.c or skbuff.h and use it for
> >> napi_pp_put_page() too, as we seem to have chosen to demux the page_po=
ol
> >> owned page and non-page_pool owned page handling in the skbuff core.
> >>
> >> If we move it to skbuff.c or skbuff.h, we might need a better prefix t=
han
> >> page_pool_* too.
> >>
> >
> > How about keeping the 'page_pool_is_pp_page' function in 'helper.h'
> > and letting 'skbbuff.c' use it? It seems like the function's logic is
> > better suited to be internal to the page pool, and it might be needed
> > outside of 'skbuff.c' in the future.
>
> Yes, we can always extend it outside of 'skbuff' if there is a need in
> the future.
>
> For now, maybe it makes more sense to export as litte as possible in the
> .h file mirroring the napi_pp_put_page().
>

Sure. will be done in v4. Thanks!

> > .
> >

