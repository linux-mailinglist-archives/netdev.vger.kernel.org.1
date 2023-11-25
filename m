Return-Path: <netdev+bounces-51075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14217F8F54
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 21:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7217B20F6F
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 20:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0AB2E82C;
	Sat, 25 Nov 2023 20:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rjDd5Rh+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A07C5
	for <netdev@vger.kernel.org>; Sat, 25 Nov 2023 12:57:27 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da2b8af7e89so3132486276.1
        for <netdev@vger.kernel.org>; Sat, 25 Nov 2023 12:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700945846; x=1701550646; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4vX9YM8MHgVEQMve881EYjRM/+ZNaojP+9UpZf+Krxo=;
        b=rjDd5Rh+zEAeZnfseXOb0fgHk7zdcy7OuaQIsJTOBXeK+AFKIInwhAlzOZfiBl6L/O
         WjOS2DeNuc0OyygwyiXxA2lI8UlKp2I+kcYgxyAp3Uk/mrXGY6xs4qwxLRkGzzAQKni7
         8BxfaOSq7SLaydRePo6Ynonvhhs7JUy0hvDfZmK1FtXqLpCBcs7h5euEfY/YXm8V4cri
         oxkIxL02Qr8ekc8CRbPxJtr2DBC6B4L859ZZyDrphYL+Kw8SzHx7jzMUyKi4n/fPlhlG
         WeIPP/UtG0W8MFb5hSP+Xc/J0vuCO2u+Hjtbr/v1rqPqowGTu9TMAdjjHCwXjZWexrWF
         Dmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700945846; x=1701550646;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4vX9YM8MHgVEQMve881EYjRM/+ZNaojP+9UpZf+Krxo=;
        b=ZtjdMLC3sC9+kBZHzc9igSOVVayQeh4XYipelWencDEK1sn+6liBTxtVRV+kozUUB0
         Zhe/7fz3CUhvLQ0ozpZTkt1MFoSA+OnYkeY5dmJR7IWxls0tPI6ZnJMLZXSboZRPCvVw
         yldUnbN8T728JKTG8vVT7oQ2hAEN+WNLvbRaL66U1TUoUJ3c6xpWTXDuaFS7zSNfp3JJ
         kBEpj+WvITLCyh3Z4EU+PRmGe7jjAeMxixp2NU+pWKrN41o2f63T3QN3QaQrcOqXYHiO
         3t2DSg08VE//97vz8+qFQZL//2AAlrXwmXPEkeViX4IcQX2A6dWHIaD05EJMjcHaaoyA
         eAVQ==
X-Gm-Message-State: AOJu0YxqX7qlooRsA9o6OX3jFwmgT7V8Do7G7rMSRcKs9PdiiOSK4/Kh
	C1zaBSjBvgwT8mUaqu5ms0rqgJ129gJMZw==
X-Google-Smtp-Source: AGHT+IFZPqXdeoIL3lA+C6gvJNzSPcBzBnW3bB5+RcsTg6wN64WQUklxQstI8D+XaYLr1bekAnMyZSmhlIqiBg==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a25:3d05:0:b0:d9b:e3f6:c8c6 with SMTP id
 k5-20020a253d05000000b00d9be3f6c8c6mr220791yba.4.1700945846371; Sat, 25 Nov
 2023 12:57:26 -0800 (PST)
Date: Sat, 25 Nov 2023 20:57:24 +0000
In-Reply-To: <20231122034420.1158898-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231122034420.1158898-1-kuba@kernel.org>
Message-ID: <20231125205724.wkxkpnuknj5bf6c4@google.com>
Subject: Re: [PATCH net-next v3 00/13] net: page_pool: add netlink-based introspection
From: Shakeel Butt <shakeelb@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, almasrymina@google.com, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, dsahern@gmail.com, dtatulea@nvidia.com, 
	willemb@google.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Nov 21, 2023 at 07:44:07PM -0800, Jakub Kicinski wrote:
> We recently started to deploy newer kernels / drivers at Meta,
> making significant use of page pools for the first time.
> We immediately run into page pool leaks both real and false positive
> warnings. As Eric pointed out/predicted there's no guarantee that
> applications will read / close their sockets so a page pool page
> may be stuck in a socket (but not leaked) forever. This happens
> a lot in our fleet. Most of these are obviously due to application
> bugs but we should not be printing kernel warnings due to minor
> application resource leaks.
> 
> Conversely the page pool memory may get leaked at runtime, and
> we have no way to detect / track that, unless someone reconfigures
> the NIC and destroys the page pools which leaked the pages.
> 
> The solution presented here is to expose the memory use of page
> pools via netlink. This allows for continuous monitoring of memory
> used by page pools, regardless if they were destroyed or not.
> Sample in patch 15 can print the memory use and recycling
> efficiency:
> 
> $ ./page-pool
>     eth0[2]	page pools: 10 (zombies: 0)
> 		refs: 41984 bytes: 171966464 (refs: 0 bytes: 0)
> 		recycling: 90.3% (alloc: 656:397681 recycle: 89652:270201)

Hi Jakub, I am wondering if you considered to expose these metrics
through meminfo/vmstat as well, is that a bad idea or is this/netlink
more of a preference?

thanks,
Shakeel

