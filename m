Return-Path: <netdev+bounces-46893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA947E6FA9
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 17:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2494B2810A7
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 16:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856A31379;
	Thu,  9 Nov 2023 16:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XDOpazy9"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEBB2908
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 16:49:18 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D383B1BE7
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 08:49:17 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507a5f2193bso1212085e87.1
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 08:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699548555; x=1700153355; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JJNGdCZhukqGgVMqepI4fzoMex8TB7y6/OCtEgdYFaQ=;
        b=XDOpazy9jN+xnsVDb+qZ8nF0mNDDcEcXjjpqBj6TRsPCXP+0nb1RWA4FdLIPrcBPTj
         yCuYTcMacamNJC69oJJOlViH/pj8VL0IcoOtKD4LWbiB296g9XUI8rfH+46UY7Ac6M1N
         Q/dXQ6nngx6L0xjwhayx6zJP4EygmSgjAue9o8CTDiil+1RzxMYY2yaiPS5HRE6G7V9G
         93O2aRUsVMlXeCwrk9AXPeTppgV2b4s+ItPl8BtMdHHtOkXxn5ErOB9+bj4EAIWqPBR7
         iw1dJOs+5sTlJFjglMZNMX191A9xixrBPy6a3Zmfgpu06rxjckLWoWG/YzO72U97ygM6
         TtBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699548555; x=1700153355;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JJNGdCZhukqGgVMqepI4fzoMex8TB7y6/OCtEgdYFaQ=;
        b=QEsTtb4Qaas5z5j8E1ACE2KghUjIimpYmX7Lu2u8HopH2ZqIGDnaDIkT7/z1SHS35+
         MbmpUcjxLCrskIj5soAC8DzQaGdSNc8F+TCzZsnX9SzsSHFrUqJZ+JKD1FU8weGvGj2N
         NVnmEXDKCHmOZV1xIij9iw7fhLhcLZvtOBCrPLdjo/Rj2Gbo8jTEpnkDmZNy9xaVJUE9
         VBlxXxMt61M7pX9yWLK4004K5bBJhbGv2Aaq9ts4mskUeenhdA6qPNR298rgFvix4JWj
         gZJXAX4wrD7Cjupt2YvuzrH+aKk0tuzy2Lvtbi6NLyzRNG3BCK4VXqHyHf/zzfHGLSng
         uILQ==
X-Gm-Message-State: AOJu0Yyo9hFUbv29G7NvP2uSUghsfAeUJIZ/oB7Ha9to8LBcTogZroxQ
	7XoXBwZPq9xPEs9+RGtZEI5HwiaFlLUrdttvdJ0emg==
X-Google-Smtp-Source: AGHT+IEN2QlSzR/7/pWaIp2u+TjNhH03TEK5AFWDweew5FLGInanY6+al6By6UCPTP51RzlE2fEd2HWPTBKh9nohmBg=
X-Received: by 2002:a05:6512:218b:b0:509:4ffc:fb9c with SMTP id
 b11-20020a056512218b00b005094ffcfb9cmr927018lft.9.1699548555663; Thu, 09 Nov
 2023 08:49:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024160220.3973311-1-kuba@kernel.org> <20231024160220.3973311-5-kuba@kernel.org>
 <CAC_iWj+gdrsyumk77mR60o6rw=pUmnXgrkmwJXK_04KPJCMhAw@mail.gmail.com> <20231109082219.5ee1d0cf@kernel.org>
In-Reply-To: <20231109082219.5ee1d0cf@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 9 Nov 2023 18:48:39 +0200
Message-ID: <CAC_iWj+CekrT6gPqs47_hgBGCCuEeHYLf8pOgzc2xn-1u96gzw@mail.gmail.com>
Subject: Re: [PATCH net-next 04/15] net: page_pool: id the page pools
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, almasrymina@google.com, hawk@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Nov 2023 at 18:22, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Thu, 9 Nov 2023 11:21:32 +0200 Ilias Apalodimas wrote:
> > > +       mutex_lock(&page_pools_lock);
> > > +       err = xa_alloc_cyclic(&page_pools, &pool->user.id, pool, xa_limit_32b,
> > > +                             &id_alloc_next, GFP_KERNEL);
> > > +       if (err < 0)
> > > +               goto err_unlock;
> >
> > A nit really, but get rid of the if/goto and just let this return err; ?
>
> There's more stuff added here by a subsequent patch. It ends up like
> this:
>
> int page_pool_list(struct page_pool *pool)
> {
>         static u32 id_alloc_next;
>         int err;
>
>         mutex_lock(&page_pools_lock);
>         err = xa_alloc_cyclic(&page_pools, &pool->user.id, pool, xa_limit_32b,
>                               &id_alloc_next, GFP_KERNEL);
>         if (err < 0)
>                 goto err_unlock;
>
>         if (pool->slow.netdev) {
>                 hlist_add_head(&pool->user.list,
>                                &pool->slow.netdev->page_pools);
>                 pool->user.napi_id = pool->p.napi ? pool->p.napi->napi_id : 0;
>
>                 netdev_nl_page_pool_event(pool, NETDEV_CMD_PAGE_POOL_ADD_NTF);
>         }
>
>         mutex_unlock(&page_pools_lock);
>         return 0;
>
> err_unlock:
>         mutex_unlock(&page_pools_lock);
>         return err;
> }
>
> Do you want me to combine the error and non-error paths?
> I have a weak preference for not mixing, sometimes err gets set
> to a positive value and that starts to propagate, unlikely to
> happen here tho.

Nop that's fine -- I actually prefer it myself. I just haven't got the
follow up patches yet


Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

