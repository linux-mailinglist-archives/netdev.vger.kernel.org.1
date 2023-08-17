Return-Path: <netdev+bounces-28535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D2D77FC5F
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 18:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA6501C21491
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 16:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C36168BE;
	Thu, 17 Aug 2023 16:54:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0838233D1
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 16:54:30 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4202D7D
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 09:54:29 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4ff9121fd29so3291294e87.3
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 09:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692291267; x=1692896067;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L1BANa0cLnYnCLTKYRjoL1wcN7eSVYD7mfDdLVXed1E=;
        b=ICtjtnmNZe/QLBtSLxtsk0iQRJ2a3PL74/ldCfQ/yjkiKphGQyAEh9q6U93CoIIvyx
         tRMKHqF9ETJOtoL357pv8sMl28nW8CNDMiiPw2v84mFmETgmxKmvvzkNoWQ3YwzFQ5Jy
         JRQGO37a+oAwygBoFtNyM/dkqGHD3rX7wQBca6QJ/IZN6aqGbiqpilixTRt8YkvToa+/
         1tW/I0QwEd2Y1bEhHhxtVFj633XHSEWWInqdAMgKnRfBiXitK1F2PglV4rZxOjNAPaaj
         jtfObZ+Qnw4KwwriaZ37PywH//KorQdgbX+Gloq/zYd1H2mUuNVtz4/ZP5ZIT2mpvHCk
         mCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692291267; x=1692896067;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L1BANa0cLnYnCLTKYRjoL1wcN7eSVYD7mfDdLVXed1E=;
        b=bQTIKaTx4+iJTgAoq3TGdXYklsFRYdXJaQMBpw00xO3c8/3p3z4QP+OhkewUV4E//d
         iSX820dA7MaERHchlu1KAleP/SLosk8Nq+X4BAW8rHLhFyDdJF4luJO0hRiH9dWkJwOw
         ea5OeYUdVHgU/F2cTcFPCC3nHMaxHJnSOntOA15PZxgQMQkimEzKeUNbr8i0eHks/jBP
         RUX//vweHXSfBgYzVIWa6bP8OWRYNJHzuWgTU9c3vs/mFSVuGv35Qv+NZ4/jzBUHbCGK
         y2klwfCKBp7oY0ohUPdF0aGdqH7JTL9+Xu7+4eaO5or+RnnrucMcb+6uk/3shXiV2u7M
         +57w==
X-Gm-Message-State: AOJu0YyGCi7cIVpgaq1B0zCgTuGgvILq106YHg8S+nT8vFaDpY2qftq9
	Cos8pJr18jApJcSlTo2YuCY+E2bKLj255i4XXGMAcA==
X-Google-Smtp-Source: AGHT+IGICpTnVA5JBxYAjK0RzTKhuNFzWao4s+SfdkiVmLLDbWpm2nDKwvVIfhMZDTKryniBl1oPS0pi336/ykQIWcM=
X-Received: by 2002:a05:6512:23a4:b0:4fe:19ef:879e with SMTP id
 c36-20020a05651223a400b004fe19ef879emr5724413lfv.28.1692291267120; Thu, 17
 Aug 2023 09:54:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230816234303.3786178-1-kuba@kernel.org> <20230816234303.3786178-4-kuba@kernel.org>
 <CAC_iWjLRR3sEZNDTAtD2sZ4UY3aZxGZSyA8y9mOB3SkZsVp7ZA@mail.gmail.com> <20230817092556.57a7e82e@kernel.org>
In-Reply-To: <20230817092556.57a7e82e@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 17 Aug 2023 19:53:50 +0300
Message-ID: <CAC_iWjJzT+dF+co-QKsU9PhJM42+bDPiQkepHkyXRLYYFYd65Q@mail.gmail.com>
Subject: Re: [RFC net-next 03/13] net: page_pool: factor out uninit
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, hawk@kernel.org, aleksander.lobakin@intel.com, 
	linyunsheng@huawei.com, almasrymina@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 17 Aug 2023 at 19:25, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Thu, 17 Aug 2023 10:40:09 +0300 Ilias Apalodimas wrote:
> > > +static void page_pool_uninit(struct page_pool *pool)
> > > +{
> > > +       ptr_ring_cleanup(&pool->ring, NULL);
> > > +
> > > +       if (pool->p.flags & PP_FLAG_DMA_MAP)
> > > +               put_device(pool->p.dev);
> > > +
> > > +#ifdef CONFIG_PAGE_POOL_STATS
> > > +       free_percpu(pool->recycle_stats);
> > > +#endif
> > > +}
> >
> > I am not sure I am following the reasoning here.  The only extra thing
> > page_pool_free() does is disconnect the pool. So I assume no one will
> > call page_pool_uninit() directly.  Do you expect page_pool_free() to
> > grow in the future, so factoring out the uninit makes the code easier
> > to read?
>
> I'm calling it from the unwind patch of page_pool_create() in the next
> patch, because I'm adding another setup state after page_pool_init().
> I can't put the free into _uninit() because on the unwind path of
> _create() that's an individual step.

Yea fair enough, I went through that patch a few minutes ago, so this
one makes sense
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

