Return-Path: <netdev+bounces-150300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAADB9E9D42
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99C1A166A16
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 17:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D811ACEDA;
	Mon,  9 Dec 2024 17:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CLZFPInh"
X-Original-To: netdev@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E748D1A2393;
	Mon,  9 Dec 2024 17:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733766234; cv=none; b=YLOyy/fC/4be5dSd8FewunJrQcB8bu/tC9LMXwWtaFy1RW4bj0OXFY9uPyc6ciBZ7rbF2kCJ87t5eGb/WB2V2AwnSwUhnwqo5SS0UYlcmq41d2AnX34UaUZbZF6336uJZeCnKlU+ENSInnB82sXMrrE3y4r6toSYGckEhENnsfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733766234; c=relaxed/simple;
	bh=uZeGdcmoZGrzQG/kE6egUJ3MFszdKX/w6FnuEtoq1Bw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HwIm1ZZ+rZ7tcIuycyAdagVgyY0We+jpl52mS9RMSdALfRO16hdfTtFvmlBPxfRO0Sy5eqrQ4RQsE/y9f0W8a3gS/H79rDBRcsgCXZpUEi3DmlJ8GqJSp/iCk/WFuI46DpCvRHpBcdvNjQL+2g0iVfNNrBPPQCIaZAf7g3Ba158=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CLZFPInh; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=3n4mk41KOvsqhkn6/DLv+bmkARAl5o1h7ZvAJsqYTjI=; b=CLZFPInhD+iyUCfhlfjuEOlEz3
	oEc/YrZMgjHXx8COZatpTv7tquVca67K15qwRRUEZpHf4VTfKpOD0WO0aiBU/rZ3HaT8scU2Y4TRh
	73xTtJevAqy2YL7As75PnoXDRYn5hRAIDXNJ87aDVO6GHcE6CQFJz5OJ0UIbAb8rxcs5g2jxLlktD
	AlfXlQGGV1MbOjbcq9KOGMhT0ngq7arQZOfZ/4O4UeA7UjHg/usgoPwHYpK9R6cwk1AmUPn82Cqdy
	Q4lYuctb6RznC7M292cmXyTXdh7iCoM21C+RS6hyzvsRn8Ek1P9XVzI4+5zmH9JZzFULpJJI9tEGK
	+mNvrYPA==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tKhnQ-00000003Ysv-49UH;
	Mon, 09 Dec 2024 17:43:49 +0000
Message-ID: <da1583ed-21cb-4606-8aaf-cc55390cc3a8@infradead.org>
Date: Mon, 9 Dec 2024 09:43:43 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 5/5] net: Document memory provider driver
 support
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>, Willem de Bruijn <willemb@google.com>,
 Samiullah Khawaja <skhawaja@google.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20241209172308.1212819-1-almasrymina@google.com>
 <20241209172308.1212819-6-almasrymina@google.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20241209172308.1212819-6-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 12/9/24 9:23 AM, Mina Almasry wrote:
> Document expectations from drivers looking to add support for device
> memory tcp or other memory provider based features.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
>  Documentation/networking/index.rst           |  1 +
>  Documentation/networking/memory-provider.rst | 52 ++++++++++++++++++++
>  2 files changed, 53 insertions(+)
>  create mode 100644 Documentation/networking/memory-provider.rst
> 

> diff --git a/Documentation/networking/memory-provider.rst b/Documentation/networking/memory-provider.rst
> new file mode 100644
> index 000000000000..4eee3b01eb18
> --- /dev/null
> +++ b/Documentation/networking/memory-provider.rst
> @@ -0,0 +1,52 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +================
> +Memory providers
> +================
> +
> +
> +Intro

Full word, please.

> +=====
> +
> +Device memory TCP, and likely more upcoming features, are reliant in memory
> +provider support in the driver.

I can't quite parse after "features." Maybe "are reliant on"?
Maybe "in-memory"?
Should it be "reliable" instead of "reliant"? Internet tells me that
reliant means dependent on.

> +
> +
> +Driver support
> +==============
> +
> +1. The driver must support page_pool. The driver must not do its own recycling
> +   on top of page_pool.
> +
> +2. The driver must support tcp-data-split ethtool option.

                  must support the

> +
> +3. The driver must use the page_pool netmem APIs. The netmem APIs are
> +   currently 1-to-1 mapped with page APIs. Conversion to netmem should be
> +   achievable by switching the page APIs to netmem APIs and tracking memory via
> +   netmem_refs in the driver rather than struct page * :
> +
> +   - page_pool_alloc -> page_pool_alloc_netmem
> +   - page_pool_get_dma_addr -> page_pool_get_dma_addr_netmem
> +   - page_pool_put_page -> page_pool_put_netmem
> +
> +   Not all page APIs have netmem equivalents at the moment. If your driver
> +   relies on a missing netmem API, feel free to add and propose to netdev@ or
> +   reach out to almasrymina@google.com for help adding the netmem API.
> +
> +4. The driver must use the following PP_FLAGS:
> +
> +   - PP_FLAG_DMA_MAP: netmem is not dma mappable by the driver. The driver

                                       dma-mappable

> +     must delegate the dma mapping to the page_pool.
> +   - PP_FLAG_DMA_SYNC_DEV: netmem dma addr is not necessarily dma-syncable
> +     by the driver. The driver must delegate the dma syncing to the page_pool.
> +   - PP_FLAG_ALLOW_UNREADABLE_NETMEM. The driver must specify this flag iff
> +     tcp-data-split is enabled. In this case the netmem allocated by the
> +     page_pool may be unreadable, and netmem_address() will return NULL to
> +     indicate that. The driver must not assume that the netmem is readable.
> +
> +5. The driver must use page_pool_dma_sync_netmem_for_cpu() in lieu of
> +   dma_sync_single_range_for_cpu(). For some memory providers, dma_syncing for
> +   CPU will be done by the page_pool, for others (particularly dmabuf memory
> +   provider), dma syncing for CPU is the responsibility of the userspace using
> +   dmabuf APIs. The driver must delegate the entire dma-syncing operation to
> +   the page_pool which will do it correctly.

thanks.
-- 
~Randy


