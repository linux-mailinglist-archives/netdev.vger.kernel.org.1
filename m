Return-Path: <netdev+bounces-46789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FADC7E6696
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 10:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B99A3B20C2F
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 09:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433FB111AF;
	Thu,  9 Nov 2023 09:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LQRcVneg"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9723111A8
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 09:22:10 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB432139
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 01:22:10 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507a29c7eefso743649e87.1
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 01:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699521728; x=1700126528; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+Wx3V6wYMO3BPomUTdHwDMuZEQ44tUIs9p9l26tbdjs=;
        b=LQRcVnegrLAkTScfMzpHluNxJAiV5eg1jOj+7MJqQY1WdhTP1pet2kT60GyeTIUdtz
         66AHMxfBJZx130itD7ZZcn7HLC9VjImzJ1la9/QD8f1MyvyhyuSKkMlCl/8Gm0lbZpwB
         BAkv23MIu/EmMnPnbwIsmonidKmXkGzh9KRBi8RG+Ddwwv9RtEmvoUlyKKEspNTbmdTQ
         QZgSg5twnKOlX3Uq8umjnNjxLU+0Ibu8aWHJoyuc6bcSLRRpDG6IxfHcs2lkRDN/iUiu
         fnEe20+r5hVYPnnMhYUBdawzjBr2jhubiubRfre0xdChvu+0WvVaxojXlME2DFWJDd5B
         Exag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699521728; x=1700126528;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Wx3V6wYMO3BPomUTdHwDMuZEQ44tUIs9p9l26tbdjs=;
        b=aJHdivzBmaWBwC8B6l2I1XA1AmGleBp5gBuXxAvw20zWgN1eokWvZAVBmoWSDP9H2W
         0o8N8fbXZWvXEIAGGFTKMk1nZIqROZLBoHTtMxu7AMGTnsRyFFov2piQEB4MFfHQf9gm
         SwTpk/jRb+VGTI1vu1Yuu2l3uOwQA+HQn3CmmoJCV2ExaL5AbveZA62hhhfpclHg3mb6
         T1YW9caz9c+fl+DqP8JJPOgN1SYKc15pH1seDJOQPkYJvovhNafGevr703HDmxQ9iNJD
         QiwM8wbbGE0+xul651WPkgxE4d7y6LFv5xEWqP7nPL/khG3KMB5h1J5dwZX4WFcYg1xK
         BK9w==
X-Gm-Message-State: AOJu0YzytmneSmQwi9n5cSSjLsaZzOvw+TpKiPRYVhRfvbIxD0dxxduB
	Ucs5rN71C6jLah963kmQC8QW8E7Kgcw9J1xdGDDxvg==
X-Google-Smtp-Source: AGHT+IGoTBEmyeGGNIHityZCMMtVft1mbqLpCOIbFzps4nIv426D1ugpou9gIyXDKA4kaMDVSW/914bujviqIjwMxQ0=
X-Received: by 2002:ac2:46d5:0:b0:508:11c3:c8ca with SMTP id
 p21-20020ac246d5000000b0050811c3c8camr698738lfo.7.1699521728250; Thu, 09 Nov
 2023 01:22:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024160220.3973311-1-kuba@kernel.org> <20231024160220.3973311-5-kuba@kernel.org>
In-Reply-To: <20231024160220.3973311-5-kuba@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 9 Nov 2023 11:21:32 +0200
Message-ID: <CAC_iWj+gdrsyumk77mR60o6rw=pUmnXgrkmwJXK_04KPJCMhAw@mail.gmail.com>
Subject: Re: [PATCH net-next 04/15] net: page_pool: id the page pools
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, almasrymina@google.com, hawk@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Oct 2023 at 19:02, Jakub Kicinski <kuba@kernel.org> wrote:
>
> To give ourselves the flexibility of creating netlink commands
> and ability to refer to page pool instances in uAPIs create
> IDs for page pools.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  include/net/page_pool/types.h |  4 ++++
>  net/core/Makefile             |  2 +-
>  net/core/page_pool.c          | 21 +++++++++++++++-----
>  net/core/page_pool_priv.h     |  9 +++++++++
>  net/core/page_pool_user.c     | 36 +++++++++++++++++++++++++++++++++++
>  5 files changed, 66 insertions(+), 6 deletions(-)
>  create mode 100644 net/core/page_pool_priv.h
>  create mode 100644 net/core/page_pool_user.c
>

[...]

> +int page_pool_list(struct page_pool *pool)
> +{
> +       static u32 id_alloc_next;
> +       int err;
> +
> +       mutex_lock(&page_pools_lock);
> +       err = xa_alloc_cyclic(&page_pools, &pool->user.id, pool, xa_limit_32b,
> +                             &id_alloc_next, GFP_KERNEL);
> +       if (err < 0)
> +               goto err_unlock;

A nit really, but get rid of the if/goto and just let this return err; ?

> +
> +       mutex_unlock(&page_pools_lock);
> +       return 0;
> +
> +err_unlock:
> +       mutex_unlock(&page_pools_lock);
> +       return err;
> +}
> +
> +void page_pool_unlist(struct page_pool *pool)
> +{
> +       mutex_lock(&page_pools_lock);
> +       xa_erase(&page_pools, pool->user.id);
> +       mutex_unlock(&page_pools_lock);
> +}
> --
> 2.41.0
>

