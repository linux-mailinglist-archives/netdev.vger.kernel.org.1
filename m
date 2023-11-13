Return-Path: <netdev+bounces-47272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEB07E9584
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 04:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C62A1F210AC
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 03:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6B2847E;
	Mon, 13 Nov 2023 03:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CSrHsh9B"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7818829
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 03:29:07 +0000 (UTC)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF2B1727
	for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 19:29:05 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-45d9d28142fso1712438137.2
        for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 19:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699846145; x=1700450945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2dGyXj5qPWx8L/oD7d/kJ2B1kSBzAWVgjHl9+VbT5g=;
        b=CSrHsh9BqDX/+zONieAXevR7NLb18gQCuO78q5RU/ltdr9vQOM6ranCrMqhyi32jaL
         s2UzxX2G44i/g9AwnqRS7KMooFi8rKcU407idcCYkgZgfyIaHJXjIViF1Vf6QgXBhLXp
         TAFJPZ3A5m0olNiegRJtM4hoU/mm7At7ggx1gOSdH2+fi+NDLdLpauJljnDMQBkOHVbg
         l3Q0iMNuJn+Ciz9hUm+CN0g31WPchNENDrmiOz29CF7d1aAI4Os1ZmfxJMukV+0rx6GG
         33ED0ficMpON3UfmQaf2mWdIaNurZPD2uU4wSUJVQ03HqG3Nvg3A5DDiVjVZp5HvN++k
         aJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699846145; x=1700450945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2dGyXj5qPWx8L/oD7d/kJ2B1kSBzAWVgjHl9+VbT5g=;
        b=ggzlxYUmiYzebcR1sd3KPr2g7POolSV7Up051xuKdVPDuPh/p1StldBcpwiqovr6Vx
         L0WuQGYWfAC0ggC0xFkTr5bb4hjFn/yiQUHt8Y1DMsylML6O3KRL+odZCUP8fmN5q7wI
         O+Gf+Xc71DK33A+HYSoaraeiP/jTfGDdQ9vwe2N0l0HDMpUHvrAqPEC/I2QMiJyk5/1B
         mr81vlWHsUI5U58I44U3WjSRaAlX6V0mmrspxL/z4B3OB7slG7X3S6toT3JpMtMIKdX5
         7CWZ08Qb2Al0fK3gNKxySMWgAF6ypGsOI2Qzn8F9nKYIOBD4vczHrp2t1WkgW8FG8USw
         Eadg==
X-Gm-Message-State: AOJu0Yy+/6f2j7ByTsiMbizUAKPcFeSEfJCyoT9VAaHN2Y6IqvK3Z1Ky
	RvBty2mu9+PqeRPbX7ORjlzV4xeMUbxV/w4sBCmHPQ==
X-Google-Smtp-Source: AGHT+IHF2Jct5wlvc5iEDA5CXatiC4I+LjFNu9wrknK+tB6gu0XrkZJBw+kq39swHZW/DhuGkGJI2Nhu4+A/S+uBIBE=
X-Received: by 2002:a05:6102:23cd:b0:45d:989b:da4a with SMTP id
 x13-20020a05610223cd00b0045d989bda4amr4899045vsr.22.1699846144896; Sun, 12
 Nov 2023 19:29:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-3-almasrymina@google.com> <20231110151907.023c61cd@kernel.org>
In-Reply-To: <20231110151907.023c61cd@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 12 Nov 2023 19:28:52 -0800
Message-ID: <CAHS8izPKRh7ukRytXaweKcY_76sE7F_3s1sYVgsUXYGrypK93Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3 02/12] net: page_pool: create hooks for custom page providers
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 3:19=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun,  5 Nov 2023 18:44:01 -0800 Mina Almasry wrote:
> > diff --git a/include/net/page_pool/types.h b/include/net/page_pool/type=
s.h
> > index 6fc5134095ed..d4bea053bb7e 100644
> > --- a/include/net/page_pool/types.h
> > +++ b/include/net/page_pool/types.h
> > @@ -60,6 +60,8 @@ struct page_pool_params {
> >       int             nid;
> >       struct device   *dev;
> >       struct napi_struct *napi;
> > +     u8              memory_provider;
> > +     void            *mp_priv;
> >       enum dma_data_direction dma_dir;
> >       unsigned int    max_len;
> >       unsigned int    offset;
>
> you should rebase on top of net-next
>
> More importantly I was expecting those fields to be gone from params.
> The fact that the page pool is configured to a specific provider
> should be fully transparent to the driver, driver should just tell
> the core what queue its creating the pool from and if there's a dmabuf
> bound for that queue - out pops a pp backed by the dmabuf.
>

My issue with this is that if the driver doesn't support dmabuf then
the driver will accidentally use the pp backed by the dmabuf, allocate
a page from it, then call page_address() on it or something, and
crash.

Currently I avoid that by having the driver be responsible for picking
up the dmabuf from the netdev_rx_queue and giving it to the page pool.
What would be the appropriate way to check for driver support in the
netlink API? Perhaps adding something to ndo_features_check?

--=20
Thanks,
Mina

