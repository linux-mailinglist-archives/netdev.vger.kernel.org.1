Return-Path: <netdev+bounces-46971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383377E77D3
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 03:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A222812D1
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 02:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DB17EB;
	Fri, 10 Nov 2023 02:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FGLTudEt"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69131100
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 02:59:20 +0000 (UTC)
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CAB448C
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 18:59:20 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-7ba9bd62fdfso649768241.3
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 18:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699585156; x=1700189956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYA5rJpCEqdhu1Dq/5dPoAwsI72d8BAvhnJXT+T4oos=;
        b=FGLTudEtOtFLIoL/GgWV+ido8gkPePNSUayf3jA0TleplXe5ND+6j+yHdWxD5mQ5c7
         Hkcols3CmcF/qhhySrbQd27M5TWfAW9Jds6COx/zPN8yYGGqmfjETSwFBn4WiVebY0ZG
         CYw4yEwu88nhX894adxRz7OGl8YbUQtB+R4hrCu5Y3TcBqVuBPMFpj9BO+TrVq6bDb8e
         jh897MsIQuhJ0E5UVhvGpZLU0L8dI1q0/xgB5RDX6NLRRqbh4xqUPmVWi9gOZOpXP3dr
         kJsQEhtm1C+WNEPY0sYxX9me0I6Lr8q/t4J4OpDf9aSfunXhGyDIDqDqf0YGZFe4PBGn
         I3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699585156; x=1700189956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYA5rJpCEqdhu1Dq/5dPoAwsI72d8BAvhnJXT+T4oos=;
        b=HhoyrgwV157g2MdagIt3Hr1+jJeD8LObCxMHhL5cTeiu9skvbpy9CccxRM/LIcEJJP
         yoFM323GZK7WIv+i9nmF1tgsMNAo1nmwWsGpMLP7jnql6LBdy7+XwCDuzjO6fM5puxzT
         phH56tuIDlE4eKHvRqVX+8F2kMUKuaauetbWHXfRKa0BSmNLzlKuETD3L90l76aZq8Tp
         +1ApqEtF4GDauAGieytpBQytHaHLY3GTzC7pwCNGFC4utwWmN0056LYbQbH8KDu4R1xT
         AOIbWyX3rZsgummARcIfEznVOn8TgbVCgQHqgFCmuG1q4HK1wJ4hVYRIVrO7YxPhZRfl
         JM4A==
X-Gm-Message-State: AOJu0Yxq17sgusqL2v1y5bftrEidWbwKHG1bDI5xKhkWPLcaF5DAbl39
	Kn6OaMVCF8XdXNRzIWuCT1Ir7LD8K4bh7uFGranCZA==
X-Google-Smtp-Source: AGHT+IFOryz0B149KznbXpgkBi69phioiLVC4R9PWdX35ZPDwW1mQdW7sr2TdvnDfhWAyV20CN9DNjJoJE0dCWxIRHw=
X-Received: by 2002:a05:6102:205a:b0:45e:fe97:70a8 with SMTP id
 q26-20020a056102205a00b0045efe9770a8mr6645348vsr.22.1699585155651; Thu, 09
 Nov 2023 18:59:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-5-almasrymina@google.com> <076fa6505f3e1c79cc8acdf9903809fad6c2fd31.camel@redhat.com>
In-Reply-To: <076fa6505f3e1c79cc8acdf9903809fad6c2fd31.camel@redhat.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 9 Nov 2023 18:59:04 -0800
Message-ID: <CAHS8izOGSE-PJ1uShkH_Mr6kUoC1EjM_9P1J=_TO6nLFP9K53Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3 04/12] netdev: support binding dma-buf to netdevice
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 12:30=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> I'm trying to wrap my head around the whole infra... the above line is
> confusing. Why do you increment dma_addr? it will be re-initialized in
> the next iteration.
>

That is just a mistake, sorry. Will remove this increment.

On Thu, Nov 9, 2023 at 1:29=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:> >>>
> >>> gen_pool_destroy BUG_ON() if it's not empty at the time of destroying=
.
> >>> Technically that should never happen, because
> >>> __netdev_devmem_binding_free() should only be called when the refcoun=
t
> >>> hits 0, so all the chunks have been freed back to the gen_pool. But,
> >>> just in case, I don't want to crash the server just because I'm
> >>> leaking a chunk... this is a bit of defensive programming that is
> >>> typically frowned upon, but the behavior of gen_pool is so severe I
> >>> think the WARN() + check is warranted here.
> >>
> >> It seems it is pretty normal for the above to happen nowadays because =
of
> >> retransmits timeouts, NAPI defer schemes mentioned below:
> >>
> >> https://lkml.kernel.org/netdev/168269854650.2191653.846525980849826981=
5.stgit@firesoul/
> >>
> >> And currently page pool core handles that by using a workqueue.
> >
> > Forgive me but I'm not understanding the concern here.
> >
> > __netdev_devmem_binding_free() is called when binding->ref hits 0.
> >
> > binding->ref is incremented when an iov slice of the dma-buf is
> > allocated, and decremented when an iov is freed. So,
> > __netdev_devmem_binding_free() can't really be called unless all the
> > iovs have been freed, and gen_pool_size() =3D=3D gen_pool_avail(),
> > regardless of what's happening on the page_pool side of things, right?
>
> I seems to misunderstand it. In that case, it seems to be about
> defensive programming like other checking.
>
> By looking at it more closely, it seems napi_frag_unref() call
> page_pool_page_put_many() directly=EF=BC=8C which means devmem seems to
> be bypassing the napi_safe optimization.
>
> Can napi_frag_unref() reuse napi_pp_put_page() in order to reuse
> the napi_safe optimization?
>

I think it already does. page_pool_page_put_many() is only called if
!recycle or !napi_pp_put_page(). In that case
page_pool_page_put_many() is just a replacement for put_page(),
because this 'page' may be an iov.

--=20
Thanks,
Mina

