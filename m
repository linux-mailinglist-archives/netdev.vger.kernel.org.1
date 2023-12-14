Return-Path: <netdev+bounces-57221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADF4812607
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 04:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E45BA1F217C7
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 03:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8AA15BD;
	Thu, 14 Dec 2023 03:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsMKCoM3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DA4D5
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 19:43:13 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a1d93da3eb7so884041166b.0
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 19:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702525391; x=1703130191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2WGt1iOHhVDfW5ZHKas6GVSb+Ng42t2kZtg5/jXbwA=;
        b=MsMKCoM31C8faiYdxfhlEb8bl0Yf8tYKbHaA2WUAb0DIIf7pLz1IVSITDKlib4ooWK
         i0l91x6SErPrHl+esrk7uL07pmwq55uCAwAaid8rYO4Xg1Lma0rBTdp3IiAWNVTOCrcp
         vjCsVeGey08Ln+LOKJfFv5q9RUFT4Kzb1d8Tp7KfiJA5dFdgXQ8WL/z45//QllD3v02b
         nrOq4TiiL4jhKOGRcyt8KgU5bjYE94XKdYrInGzjHWs7dezQsFxJ/onKyGSlQD5cydAT
         7L6fzmkfHUuwkminAt6To198jW7K9a5oSpRDa97o+z73ndkpsZkQZzr2LfrYmc7dowhZ
         8vBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702525391; x=1703130191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b2WGt1iOHhVDfW5ZHKas6GVSb+Ng42t2kZtg5/jXbwA=;
        b=NtOfaQc7bTlM6b+VPLmftZlkUdiOoiV0YCa0EMmk1OFNHlpE28CRkKtOapldPGS7zH
         QMoN6plaLr8g0D/BVoy64726kt3Vkh+eqfRC1JgSuipR9U/scT/qm0daXV/bsV/vELVJ
         qb2Sd9NR18idWhSsgscDJZsGHOZ/hcNOIRsd09mERgmcuyniJ0J7mHKvKYgYIqQ2trOu
         SdMmrLqOYC/Bcfhf0DbTsPi27un2VOP71xfZZpWsGLuXyZGp5ouRS1EIGHuuZRmba8LJ
         uRK1oLwqdhobtjA1M1slUVmX1fUo8a150bJNc4+oV260+TCrD9KCjmEcGXt4F1jQAiAF
         wESA==
X-Gm-Message-State: AOJu0YxI6o6xuf6AdHa3Jq0rgHc5wGzWcXhswjsCOY0yrDaefBA9yfgI
	ZIBy9FKl4WBKs3rdP9B86QlaFtLbtI5iyGb9RfE=
X-Google-Smtp-Source: AGHT+IE/3z30N9khrYjubXRqX3YFcEc4YjKA1QJLauUNwbTUZACmQpujd07osQ0KV5t2OJgZJsgbl409NaUYN6Sd0wA=
X-Received: by 2002:a17:907:7ea1:b0:a1d:1fb9:5e39 with SMTP id
 qb33-20020a1709077ea100b00a1d1fb95e39mr5314773ejc.15.1702525391288; Wed, 13
 Dec 2023 19:43:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212044614.42733-1-liangchen.linux@gmail.com>
 <20231212044614.42733-3-liangchen.linux@gmail.com> <CAC_iWjK88W3xHEuL+7XZ4bZXk0HrQZ4vNEFtevrX_Edrx_Md4Q@mail.gmail.com>
In-Reply-To: <CAC_iWjK88W3xHEuL+7XZ4bZXk0HrQZ4vNEFtevrX_Edrx_Md4Q@mail.gmail.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Thu, 14 Dec 2023 11:42:58 +0800
Message-ID: <CAKhg4tJP1dNZfeMPZLv6n_ocuQq-4xM3a5uRMGqcnHrfkoozDg@mail.gmail.com>
Subject: Re: [PATCH net-next v9 2/4] page_pool: halve BIAS_MAX for multiple
 user references of a fragment
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, linyunsheng@huawei.com, 
	netdev@vger.kernel.org, linux-mm@kvack.org, jasowang@redhat.com, 
	almasrymina@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 7:39=E2=80=AFPM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Liang,
>
> On Tue, 12 Dec 2023 at 06:47, Liang Chen <liangchen.linux@gmail.com> wrot=
e:
> >
> > Referring to patch [1], in order to support multiple users referencing =
the
> > same fragment and prevent overflow from pp_ref_count growing, the initi=
al
> > value of pp_ref_count is halved, leaving room for pp_ref_count to incre=
ment
> > before the page is drained.
> >
> > [1]
> > https://lore.kernel.org/all/20211009093724.10539-3-linyunsheng@huawei.c=
om/
>
> We only need this if patch #4 is merged.  In that case, I'd like to
> describe the changelog a bit better.
> Something along the lines of
> "Up to now, we were only subtracting from the number of used page
> fragments to figure out when a page could be freed or recycled. A
> following patch introduces support for multiple users referencing the
> same fragment. So reduce the initial page fragments value to half to
> avoid overflowing"
>

Sure. Thanks for the suggestion!

> Thanks
> /Ilias
> > same fragment
>
>
>
> >
> > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>
> > ---
> >  net/core/page_pool.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > index 106220b1f89c..436f7ffea7b4 100644
> > --- a/net/core/page_pool.c
> > +++ b/net/core/page_pool.c
> > @@ -26,7 +26,7 @@
> >  #define DEFER_TIME (msecs_to_jiffies(1000))
> >  #define DEFER_WARN_INTERVAL (60 * HZ)
> >
> > -#define BIAS_MAX       LONG_MAX
> > +#define BIAS_MAX       (LONG_MAX >> 1)
> >
> >  #ifdef CONFIG_PAGE_POOL_STATS
> >  /* alloc_stat_inc is intended to be used in softirq context */
> > --
> > 2.31.1
> >

