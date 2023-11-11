Return-Path: <netdev+bounces-47171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7457E8825
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 03:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565F91C2097C
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 02:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4032A4405;
	Sat, 11 Nov 2023 02:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1+rZdFdj"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45723C2B
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 02:19:40 +0000 (UTC)
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0493F3C39
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 18:19:39 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7ba6fa81aabso1103845241.0
        for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 18:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699669178; x=1700273978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgqBnf0ilIbbmVz4uCSI7pHuUwmF6tF2MbGnmYFmbLE=;
        b=1+rZdFdjFSthMrsgVq4lr5yiWG2/2crNAzZriXlHWiM+p8m6VZrMRS2cTYEt4AJmMg
         Vw+MLQtZuDncZLp2zMwgS5VVoz2T67+jXsb3xI7voYek+oxYh78djVY1JZNH5+Ljr8Vk
         xNHRs06dXbOm/7XxkYdVYDaXKbrNWQMzlnyLyMeXeNTBpRANi2uDsKZnRwqi64LtsO5x
         pUm5+4a/4reIXei27neTKjb0XFjJb0mu5/c1RYP2YLKcRbyZRzVpEsocdxG1BfHniNSU
         bAE6L5zuymEAE5ng57YS9/lK3Q8gJrL/CIIEziTm5BwKqwtb0mrJpq36lM5c7UEfwpCw
         LTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699669178; x=1700273978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgqBnf0ilIbbmVz4uCSI7pHuUwmF6tF2MbGnmYFmbLE=;
        b=W4ulFHiK0jOjLCE3i1XxXYNMbtMK39Vm3MiAXIo71M1Qpd9RU3bR2sm1KwkTnRxCkH
         Gp325+zR7NKnAeykiUUtAAbtckM6/EkL4pFgZW5X9h3MagoYtet9t9IDd6qcSLO8RRzb
         Wn2hFHGFyqj4xLF11vBJjvYjdzy/WlsJX7LY4RevyoiEfRY/afvMlb/BNPDDa0CDlK6y
         aBHmxEtGzd1MCRQs5akYYNoGF3tDKiYLA+wvQi7f4kpGA2JOTlTEd1xdhRU5NrYMi82V
         NfTKC9Wx+uV2WJEUpTiuf/lE5IFosDPqI1YmKgKu5n9FsvEnlum8sbJ2DXt7Q1a+BZHM
         07Sw==
X-Gm-Message-State: AOJu0Yz6hrAi9qYyfm138t6jOViklwJ512rK4TD/zbc1+TI1PlxzABAH
	8GxH5T2rrEXyRBUSPaenfaWH8x/oMMPoSMWy+aNtdw==
X-Google-Smtp-Source: AGHT+IF27drF2ibPIv5e35tDpvNbfT/4JCRv/7iIXX2a/YulrAcvekKKHgSNmcTCaUBg7ZoYtol1hSAIqIT6V1YCrfg=
X-Received: by 2002:a05:6102:5f09:b0:460:f40a:95f8 with SMTP id
 ik9-20020a0561025f0900b00460f40a95f8mr1152743vsb.24.1699669177954; Fri, 10
 Nov 2023 18:19:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-5-almasrymina@google.com> <20231110151953.75c03297@kernel.org>
In-Reply-To: <20231110151953.75c03297@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 10 Nov 2023 18:19:24 -0800
Message-ID: <CAHS8izOx99K=0O1fkb93mS54Yw0dqMj31D68gLG6OpH1J9LBhQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 04/12] netdev: support binding dma-buf to netdevice
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
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 3:20=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun,  5 Nov 2023 18:44:03 -0800 Mina Almasry wrote:
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -52,6 +52,8 @@
> >  #include <net/net_trackers.h>
> >  #include <net/net_debug.h>
> >  #include <net/dropreason-core.h>
> > +#include <linux/xarray.h>
> > +#include <linux/refcount.h>
> >
> >  struct netpoll_info;
> >  struct device;
> > @@ -808,6 +810,84 @@ bool rps_may_expire_flow(struct net_device *dev, u=
16 rxq_index, u32 flow_id,
> >  #endif
> >  #endif /* CONFIG_RPS */
> >
> > +struct netdev_dmabuf_binding {
>
> Similar nitpick to the skbuff.h comment. Take this somewhere else,
> please, it doesn't need to be included in netdevice.h
>
> > +     struct netdev_dmabuf_binding *rbinding;
>
> the 'r' in rbinding stands for rx? =F0=9F=A4=94=EF=B8=8F
>

reverse binding. As in usually it's netdev->binding, but the reverse
map holds the bindings themselves so we can unbind them from the
netdev.
--=20
Thanks,
Mina

