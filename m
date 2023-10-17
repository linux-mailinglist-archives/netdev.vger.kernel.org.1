Return-Path: <netdev+bounces-41927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B17A37CC3E3
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 15:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1CD91C209DB
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 13:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7277242BFB;
	Tue, 17 Oct 2023 13:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rPx00GwR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF24942BF6
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 13:03:19 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4FADB
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 06:03:18 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507975d34e8so5829099e87.1
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 06:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697547796; x=1698152596; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bXs0q9mBXE4NFA1doT5CaGDIU8NXELScS6cZ9XMNR7U=;
        b=rPx00GwRt9Lbt7IyotlZsRbO/ONXH9XpNJcRUe4wSiqSVFAYeusc9IcWO2Ht6Jw7E3
         FAPbRwqZN0tgSTa5BqTu6W/cKslNRW81Lr+RNw2MdBYzE2FhsAEVPJZGz/fmzMcTjtE2
         0v/mMGnqPiiADHYICj3JY9XeL2ROckUJr9ee66NS/PSf+bXBN5enukZ7gdKi7eQ6V6+n
         7yt68+AgsduvXXov4GJ7qP0ub/EBzrdUDqOyhbNZx8jZeA6Z1you4/9cGvyt9oN1gsjI
         HbK/5q0SDiPnbpse7E9fwu3FBS3Yak5fq0RO1shhwM54DTGTXsqGgYjINfaGiVo1aWUs
         XTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697547796; x=1698152596;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bXs0q9mBXE4NFA1doT5CaGDIU8NXELScS6cZ9XMNR7U=;
        b=hc9Px0IUpcgAqI2TsqsczFjpos7QPNcO67X/ajf2dxv45577rCZ7XI6Ivna8cT+bdQ
         sPuu1OoW7T6yczme9T0xYFFXfvFKakdgepXrhaq2e0Af8lS3bi1cck7r4Tue5iXbvGMT
         8a6SR9f0KbgnRhXw57uKCT7FMnHarKg748gHSwBnIdmP13cRxcMCmTOYo++PM7GllBhO
         zKAMkbWv2QXzFoLVYczHcgUnm7oThWhC3U+YTmSN3bYIUThGaTGvNHbvjtGlh9L+maGx
         aabEfjvDc9hFfj3mehMjl35XJNSaIlIe58vzUI6SbJQQfkqY5PXqNYKNNKdyhNb9EUX+
         Gmuw==
X-Gm-Message-State: AOJu0YxqPywf7fxlgjyilKTEuAOnBChW4n40f5SjL9bp8dpEQlaoxeXr
	+7gpHQMGm1gB6xexBYRkRPOb3t3hexhMvaZXQ/ka7w==
X-Google-Smtp-Source: AGHT+IF++YlDi1NoCe1h+WHq9g3qbnOigxmvB0ZYJcTY0RXDaQmwTSmc/On4WuvZ0sl+dk+2o8fU+tqucPcC/vLewDI=
X-Received: by 2002:a19:7417:0:b0:502:d743:9fc4 with SMTP id
 v23-20020a197417000000b00502d7439fc4mr1822904lfe.37.1697547796528; Tue, 17
 Oct 2023 06:03:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231013064827.61135-1-linyunsheng@huawei.com>
 <20231013064827.61135-2-linyunsheng@huawei.com> <CAC_iWj+FR+ojP7akSY0azc0hVnrhsPhyFTejNit0sVR742KgEw@mail.gmail.com>
 <e738b0b9-6c60-b971-7fd9-0ec1b14dda3c@huawei.com>
In-Reply-To: <e738b0b9-6c60-b971-7fd9-0ec1b14dda3c@huawei.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 17 Oct 2023 16:02:40 +0300
Message-ID: <CAC_iWjLYZWUt9RFkAMR8=2amscbOUqXbVP8n8oiXHGsXw-ZKCA@mail.gmail.com>
Subject: Re: [PATCH net-next v11 1/6] page_pool: fragment API support for
 32-bit arch with 64-bit DMA
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Alexander Duyck <alexander.duyck@gmail.com>, Liang Chen <liangchen.linux@gmail.com>, 
	Guillaume Tucker <guillaume.tucker@collabora.com>, Matthew Wilcox <willy@infradead.org>, 
	Linux-MM <linux-mm@kvack.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Yunsheng

On Tue, 17 Oct 2023 at 15:53, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>
> On 2023/10/17 20:17, Ilias Apalodimas wrote:
> >>
> >
> > That looks fine wrt what we discussed with Jakub,
> >
> > Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> Thanks. What about other patches in this series? Could you take
> some time to review them too?

Yes I will, I was on nonstop trips, and was a bit cumbersome to
review/test.  Also, there Plumbers is in a month, and I have an idea I
need to discuss with Jakub about adding page pool patches to a CI.
That should make the whole process a bit faster

Thanks
/Ilias
>
> >
> > .
> >

