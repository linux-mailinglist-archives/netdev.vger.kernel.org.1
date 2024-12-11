Return-Path: <netdev+bounces-150978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E469EC3C8
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 04:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECDD11883C2E
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 03:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C9420A5CC;
	Wed, 11 Dec 2024 03:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/cwhQn3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88AF29A1;
	Wed, 11 Dec 2024 03:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733889316; cv=none; b=iWUOw5QkIFfrWjt6PI7Vd8zuVKAZUn6H6HGwmy5zgWm/9BDVdmANIEbucGjw2DUdXEHsjz6zVsrRD8bt1rBbywHl27q2Ud0yGHPEL/pnwBKyY1/DB3tQJRxKG8pEEtoVyi98ndLe1o8s/ldP3qaobz0J0zZdVmdtmwBF2HEllGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733889316; c=relaxed/simple;
	bh=duFfJF8ookAyE5BNBRU7jhyNsqEpP/YJ3fQVENDIJM4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QpsUl8rVw2h3e1QKYI5bZ4LCFMEML25I+aqqVS7jyIbXKW4XT8D7PnrpIzEW3tfGQ5ZaVfwzmFD2WeHurzgRg39YaHcOJhT6FTRoYTfNxrP9SIEQGPWC4PaCogzE31kSQJWvgiub1GHQAseqLviHA2h5p7dFyNRo3tS1T6AMqSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/cwhQn3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DC9C4CED2;
	Wed, 11 Dec 2024 03:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733889315;
	bh=duFfJF8ookAyE5BNBRU7jhyNsqEpP/YJ3fQVENDIJM4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O/cwhQn3xFOZKc4cI+63XBzOmZn/ElzM5gbRkFDahe/SxtYVK0Hf0NHYSN4IP5uyJ
	 IwWs1ODr2xZl/VTRYzT0jsoHY05EtBUvVyveemXJnmIDmy2DJigc/3M+8x0vQn4GP0
	 SLOj4vvmL+3ckJ1y0F3lZUoRc7NPJAqki7JqCCruM/PPxeieFy7blgAbi+cd7axtQQ
	 rDc4VjZVoi6xNgYBbkGjFXZBcbEp68uzwgRpliLtFFQwAaqI4IqQosL0iNFJpFPc/a
	 sGanydPGdGJN9Svh3lCYI69M/MXv44wqvMC0ib5nuolfRIKlrhQYAmv7OtaOH68QsA
	 yqP5OxV0r5zLw==
Date: Tue, 10 Dec 2024 19:55:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>, Kaiyuan
 Zhang <kaiyuanz@google.com>, Willem de Bruijn <willemb@google.com>,
 Samiullah Khawaja <skhawaja@google.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH net-next v3 5/5] net: Document memory provider driver
 support
Message-ID: <20241210195513.116337b9@kernel.org>
In-Reply-To: <20241209172308.1212819-6-almasrymina@google.com>
References: <20241209172308.1212819-1-almasrymina@google.com>
	<20241209172308.1212819-6-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Dec 2024 17:23:08 +0000 Mina Almasry wrote:
> +================
> +Memory providers
> +================
> +
> +
> +Intro
> +=====
> +
> +Device memory TCP, and likely more upcoming features, are reliant in memory
> +provider support in the driver.

Are "memory providers" something driver authors care about?
I'd go with netmem naming in all driver facing APIs.
Or perhaps say placing data into unreable buffers?

> +Driver support
> +==============
> +
> +1. The driver must support page_pool. The driver must not do its own recycling
> +   on top of page_pool.

I like the rule, but is there a specific reason driver can't do its own
recycling?

> +2. The driver must support tcp-data-split ethtool option.
> +
> +3. The driver must use the page_pool netmem APIs. The netmem APIs are
> +   currently 1-to-1 mapped with page APIs. Conversion to netmem should be

mapped => correspond ?

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
> +     must delegate the dma mapping to the page_pool.
> +   - PP_FLAG_DMA_SYNC_DEV: netmem dma addr is not necessarily dma-syncable
> +     by the driver. The driver must delegate the dma syncing to the page_pool.
> +   - PP_FLAG_ALLOW_UNREADABLE_NETMEM. The driver must specify this flag iff
> +     tcp-data-split is enabled. In this case the netmem allocated by the
> +     page_pool may be unreadable, and netmem_address() will return NULL to
> +     indicate that. The driver must not assume that the netmem is readable.

Should we turn the netmem_address() explanation into a point of its own,
calling out restrictions on use of CPU addresses, netmem_to_page() etc?

> +5. The driver must use page_pool_dma_sync_netmem_for_cpu() in lieu of
> +   dma_sync_single_range_for_cpu(). For some memory providers, dma_syncing for
> +   CPU will be done by the page_pool, for others (particularly dmabuf memory
> +   provider), dma syncing for CPU is the responsibility of the userspace using
> +   dmabuf APIs. The driver must delegate the entire dma-syncing operation to
> +   the page_pool which will do it correctly.

