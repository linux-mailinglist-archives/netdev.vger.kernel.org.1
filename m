Return-Path: <netdev+bounces-46256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6357E2E8C
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 22:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F17A1C20750
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 21:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD052E417;
	Mon,  6 Nov 2023 21:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vv8kFQiu"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695D32D035
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 21:02:42 +0000 (UTC)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D09D51
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 13:02:41 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1cc1ddb34ccso32169285ad.1
        for <netdev@vger.kernel.org>; Mon, 06 Nov 2023 13:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699304560; x=1699909360; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3YVT/6GQJuQ7TjvhzDWajYThozSBRZLd2V3VGmhBHao=;
        b=Vv8kFQiunIrTYiM6C/oHgHrTapbPb7JHDyQy8sV+NGrJVj1vpNrYPabj6l1M/3k/pe
         0KSaaQUhg/ZcT1F6kyHn9rRU9tsCGw6mAcPy1W2Muj+zT0GcbkKhL4D8SwhyL48Uj4UZ
         rFF1SSEqPu+xI1Kekzu58oyXrQ4wUJNx/0fMnKc1m487QZyiAIBOoj05pUveCBtBrMxk
         eFetU/y0BG/3cbcuiXHfrCIGHvvDBx7MW7aUUulBj/sRFKx8ycriSAw+tMYWERMHyG1E
         N4TWBgSpWVRrFhtU7AKB35RgNVw2OAXLY9vuE+BX0uGx/b73D3X4to8/XWfcxOmD2Pvf
         dqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699304560; x=1699909360;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3YVT/6GQJuQ7TjvhzDWajYThozSBRZLd2V3VGmhBHao=;
        b=QXk5BkEsi1rHfk+fFmI5uTCAv76LXC1h+XTIvd1YNlIBY5I+t6OMXkbScFz1mSIxpb
         Nec7ZA7gzBBH/NLu+cz9aTGxTfzKuMrYjj9OxFPdipgJTlZLePkJL32Q8klpqfJplTOB
         UB7mCIb+SyD5vkiy/9pGatn/udwyj5j5Zu7JnUGVuc/C+NEvhOf5QnlcHLqwlbreG8e3
         25gLJBMvU6C9499FhMC/FZ+v1LLPL6NyFvnnk+XB5U2RNeF42jKRTqjo/NpEfmjmyxQq
         NXhM0qivSYWdT1NUM5K4xTgT04Kukn1MDO1AwZ9CuTsS+x76R5RE+nwXoaRRy0Dm3ArB
         SQcw==
X-Gm-Message-State: AOJu0YzHoNvG4TrDnLiIiBCciDVSigDtZGyvbaJBblAh6UmghrnNnOAi
	95Rmpgf+x3lS9vIhw1r/M11m9oA=
X-Google-Smtp-Source: AGHT+IFMk9K2QPc1yRl8QNToni4u3wTj7lMIW1WMnLhrEu9KTQ1j0Kkg7CJFxK+wf+6qBsS5/cJoFOo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:ee14:b0:1ca:b952:f5fa with SMTP id
 z20-20020a170902ee1400b001cab952f5famr509511plb.5.1699304560650; Mon, 06 Nov
 2023 13:02:40 -0800 (PST)
Date: Mon, 6 Nov 2023 13:02:39 -0800
In-Reply-To: <20231106024413.2801438-7-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com> <20231106024413.2801438-7-almasrymina@google.com>
Message-ID: <ZUlUb93BFbPBRJFm@google.com>
Subject: Re: [RFC PATCH v3 06/12] memory-provider: dmabuf devmem memory provider
From: Stanislav Fomichev <sdf@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"Christian =?utf-8?B?S8O2bmln?=" <christian.koenig@amd.com>, Shakeel Butt <shakeelb@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="utf-8"

On 11/05, Mina Almasry wrote:
> Implement a memory provider that allocates dmabuf devmem page_pool_iovs.
> 
> Support of PP_FLAG_DMA_MAP and PP_FLAG_DMA_SYNC_DEV is omitted for
> simplicity.
> 
> The provider receives a reference to the struct netdev_dmabuf_binding
> via the pool->mp_priv pointer. The driver needs to set this pointer for
> the provider in the page_pool_params.
> 
> The provider obtains a reference on the netdev_dmabuf_binding which
> guarantees the binding and the underlying mapping remains alive until
> the provider is destroyed.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
>  include/net/page_pool/helpers.h | 40 +++++++++++++++++
>  include/net/page_pool/types.h   | 10 +++++
>  net/core/page_pool.c            | 76 +++++++++++++++++++++++++++++++++
>  3 files changed, 126 insertions(+)
> 
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
> index 78cbb040af94..b93243c2a640 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -53,6 +53,7 @@
>  #define _NET_PAGE_POOL_HELPERS_H
>  
>  #include <net/page_pool/types.h>
> +#include <net/net_debug.h>
>  
>  #ifdef CONFIG_PAGE_POOL_STATS
>  int page_pool_ethtool_stats_get_count(void);
> @@ -111,6 +112,45 @@ page_pool_iov_binding(const struct page_pool_iov *ppiov)
>  	return page_pool_iov_owner(ppiov)->binding;
>  }
>  
> +static inline int page_pool_iov_refcount(const struct page_pool_iov *ppiov)
> +{
> +	return refcount_read(&ppiov->refcount);
> +}
> +
> +static inline void page_pool_iov_get_many(struct page_pool_iov *ppiov,
> +					  unsigned int count)
> +{
> +	refcount_add(count, &ppiov->refcount);
> +}
> +
> +void __page_pool_iov_free(struct page_pool_iov *ppiov);
> +
> +static inline void page_pool_iov_put_many(struct page_pool_iov *ppiov,
> +					  unsigned int count)
> +{
> +	if (!refcount_sub_and_test(count, &ppiov->refcount))
> +		return;
> +
> +	__page_pool_iov_free(ppiov);
> +}
> +
> +/* page pool mm helpers */
> +
> +static inline bool page_is_page_pool_iov(const struct page *page)
> +{
> +	return (unsigned long)page & PP_DEVMEM;
> +}

Speaking of bpf: one thing that might be problematic with this PP_DEVMEM
bit is that it will make debugging with bpftrace a bit (more)
complicated. If somebody were trying to get to that page_pool_iov from
the frags, they will have to do the equivalent of page_is_page_pool_iov,
but probably not a big deal? (thinking out loud)

