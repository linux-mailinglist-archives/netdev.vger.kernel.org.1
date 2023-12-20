Return-Path: <netdev+bounces-59168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B938199E7
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 08:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D4A5282C36
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 07:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E823168C8;
	Wed, 20 Dec 2023 07:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zzLyB38g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8194B1CA8C
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 07:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e3901c2e2so3805256e87.0
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 23:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703059034; x=1703663834; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xhzDs4fQYzZp/6r6fTf/FxMWbjIgjGBLAvcDTnyWS/c=;
        b=zzLyB38gxCR1ktyw7qfpvJqxRMvPIkZh7s6RvZ0taXE60ZJ8SG1YNGS5U+7wvU0M3R
         C37tgSFZc3Sjsaeq5guxABhsnjAZLeoRAdO3vS0VgMt1aCLsqB5df+zF/FXNPm4xVAU6
         G74CWk638IYR1k4m2VbrfP85bX3Fz99Vyzu9jgkqS0g6sSzoiHyV7fDH90rsPqTHQfWE
         DXzNiisaATuu0K1MlXjR3moPzWxQ6rMdf50+gJdmU28NcOf8FNteU5ZJUxf15BvDKH8U
         IVkNMTyhcdhx66YIviX+ovgD2DIwgHnNtnHCu/kAeQbZkOUe3IjZBRsCvPEZdPQzsWIO
         HwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703059034; x=1703663834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xhzDs4fQYzZp/6r6fTf/FxMWbjIgjGBLAvcDTnyWS/c=;
        b=vYQvVYDWP01/hv/zIULMor2ICs/rc9B6U71QwLSNFUwx9LASfKcEp3sJxGqyvHHSIk
         jp2A7mnP0/EIDF/qjis2yj7eh8bmCtV+DGY17H/Y/rzI7qMdbemlrU3CfHU/UdVtNzT6
         zGP3SbOJUCa27N3V0nHl+WVFm0drMpl9l4T6Wxw1FdRjCsU0OX1Qh2IJ0yLvsQvGy17c
         hoeXwUD5g5YDmfGAGzh9r2DU00uW7e3feT2idfPnfjgj9OGdmI93UtjDqHqUX5bN2sZ3
         iGnv262Vz29EDQ26UDGx2iCWzYvYOtZGjURnPi6SwNtnObUP3cfKCCwLR1rkRV7Jais7
         /MuA==
X-Gm-Message-State: AOJu0YxFlu1PDZFc7Yk2QDwWJzyWyEWuo0JfVDnutHX43flBKlV07jz0
	f5BrvcPku07idPWRuasFqVrrAl4PaQCP0GDrM6Bt+w==
X-Google-Smtp-Source: AGHT+IF4cEe5qD0TAD4NRf5ALUwrzG2wKsHgN3POJBugKH427YT7T/Wbew8AfhuW+6eC+mk5ZJQ4BQBicBs6EObCmgM=
X-Received: by 2002:ac2:562c:0:b0:50e:3b91:99a1 with SMTP id
 b12-20020ac2562c000000b0050e3b9199a1mr2022467lff.86.1703059034592; Tue, 19
 Dec 2023 23:57:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215073119.543560-1-ilias.apalodimas@linaro.org>
 <6fddeb22-0906-e04c-3a84-7836bef9ffa2@huawei.com> <CAC_iWjLiOdUqLmRHjZmwv9QBsBvYNV=zn30JrRbJa05qMyDBmw@mail.gmail.com>
 <fb0f33d8-d09a-57fc-83b0-ccf152277355@huawei.com>
In-Reply-To: <fb0f33d8-d09a-57fc-83b0-ccf152277355@huawei.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 20 Dec 2023 09:56:38 +0200
Message-ID: <CAC_iWjKH5ZCUwVWc2EisfjeLVF=ko967hqpdAc7G4FdsZCq7NA@mail.gmail.com>
Subject: Re: [PATCH net-next] page_pool: Rename frag_users to frag_cnt
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: netdev@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Yunsheng,

On Fri, 15 Dec 2023 at 14:34, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>
> On 2023/12/15 19:58, Ilias Apalodimas wrote:
> > Hi Yunsheng,
> >
> > On Fri, 15 Dec 2023 at 13:10, Yunsheng Lin <linyunsheng@huawei.com> wrote:
> >>
> >> On 2023/12/15 15:31, Ilias Apalodimas wrote:
> >>> Since [0] got merged, it's clear that 'pp_ref_count' is used to track
> >>> the number of users for each page. On struct_page though we have
> >>> a member called 'frag_users'. Despite of what the name suggests this is
> >>> not the number of users. It instead represents the number of fragments of
> >>> the current page. When we have a single page this is set to one. When we
> >>> split the page this is set to the actual number of frags and later used
> >>> in page_pool_drain_frag() to infer the real number of users.
> >>>
> >>> So let's rename it to something that matches the description above
> >>>
> >>> [0]
> >>> Link: https://lore.kernel.org/netdev/20231212044614.42733-2-liangchen.linux@gmail.com/
> >>> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >>> ---
> >>>  include/net/page_pool.h | 2 +-
> >>>  net/core/page_pool.c    | 8 ++++----
> >>>  2 files changed, 5 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/include/net/page_pool.h b/include/net/page_pool.h
> >>> index 813c93499f20..957cd84bb3f4 100644
> >>> --- a/include/net/page_pool.h
> >>> +++ b/include/net/page_pool.h
> >>> @@ -158,7 +158,7 @@ struct page_pool {
> >>>       u32 pages_state_hold_cnt;
> >>>       unsigned int frag_offset;
> >>>       struct page *frag_page;
> >>> -     long frag_users;
> >>> +     long frag_cnt;
> >>
> >> I would rename it to something like refcnt_bais to mirror the pagecnt_bias
> >> in struct page_frag_cache.
> >
> > Sure
> >
> >>
> >>>
> >>>  #ifdef CONFIG_PAGE_POOL_STATS
> >>>       /* these stats are incremented while in softirq context */
> >>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> >>> index 9b203d8660e4..19a56a52ac8f 100644
> >>> --- a/net/core/page_pool.c
> >>> +++ b/net/core/page_pool.c
> >>> @@ -659,7 +659,7 @@ EXPORT_SYMBOL(page_pool_put_page_bulk);
> >>>  static struct page *page_pool_drain_frag(struct page_pool *pool,
> >>>                                        struct page *page)
> >>>  {
> >>> -     long drain_count = BIAS_MAX - pool->frag_users;
> >>> +     long drain_count = BIAS_MAX - pool->frag_cnt;
> >>
> >> drain_count = pool->refcnt_bais;
> >
> > I think this is a typo right? This still remains
>
> It would be better to invert logic too, as it is mirroring:
>
> https://elixir.bootlin.com/linux/v6.7-rc5/source/mm/page_alloc.c#L4745

This is still a bit confusing for me since the actual bias is the
number of fragments that you initially split the page. But I am fine
with having a common approach. I'll send the rename again shortly, and
I can send the logic invert a bit later (or feel free to send it,
since it was your idea).

Thanks
/Ilias

