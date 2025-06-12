Return-Path: <netdev+bounces-196759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8EDAD6490
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 02:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FB761891949
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 00:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9461E487;
	Thu, 12 Jun 2025 00:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gs8Ktq8o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CEE8BE8
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 00:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749688587; cv=none; b=kw0dEq3LQhwbqnx7fG+Vs8woVSDFB7/BaeddpVpFaQKr64qZCw+MxWXCZOJ43qdxZM9ujGjRZfxccT3qFyGkgHYOvAeMaNXMmxFgxNWhU6jgyfgZaSSzv9H/ehqyR5Qb1wXNOu9UCqf6pW2ENYHqAcd+2KXiNJ10cwyjw5ZH0I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749688587; c=relaxed/simple;
	bh=VX2z2/FTyVn7BQpo+/VJOHyJJYMp0fe/rlbeOnwg8S8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGDKAVsPnzCKM9rSkS2KXpIfEHCW8GEh4lTGlExZbszrhNjac88PgSP7EVUBKXnzr9eUJkiB+RODkNOBiOE6PQfeXXN+BxdoGfjTCNIBE8yvlY41aWXA3b/nNb/h2yGMfqyM56Z12hZ5qgU0InEb4tlrcAcdY4fE1ZI6WAHymKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gs8Ktq8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0CEC4CEE3;
	Thu, 12 Jun 2025 00:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749688587;
	bh=VX2z2/FTyVn7BQpo+/VJOHyJJYMp0fe/rlbeOnwg8S8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gs8Ktq8oAq+gDWOf1HIkw1MKCjkvLUD34+FWmtdYgVDcMktaU8GYHoBfX87Y0SOQN
	 j712zYHBDZbysi8LQDV6hLTiAk9E15f0PjFmRABnbS3MiBl4dqJRQAn/rnekjgX2Y1
	 bW+lTZ2OUHhB0IbqfqnDueXhcyWZwR1f3gt6AGEjWbRRNddUmQzB8d2eB7huh4AiQj
	 t90s0vnkhMn3itY4Cx4MU8ENXBhHLU4L1prU3J3M7hQx0wr0W5LEgmWFt6q7edqW6k
	 cLTKz8/faCH5zcZyM8ZKVMeadORQw6ceFG49PlUd5WCD+PMC1YLk7q0daBgwMQWK5t
	 eQxr7fkyGGavA==
Date: Wed, 11 Jun 2025 17:36:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Add TCP LRO support
Message-ID: <20250611173626.54f2cf58@kernel.org>
In-Reply-To: <aEg1lvstEFgiZST1@lore-rh-laptop>
References: <20250610-airoha-eth-lro-v1-1-3b128c407fd8@kernel.org>
	<CANn89iJsNWkWzAJbOvaBNjozuLOQBcpVo1bnvfeGq5Zm6h9e=Q@mail.gmail.com>
	<aEg1lvstEFgiZST1@lore-rh-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 15:39:34 +0200 Lorenzo Bianconi wrote:
> > Tell us more... It seems small LRO packets will consume a lot of
> > space, incurring a small skb->len/skb->truesize ratio, and bad TCP WAN
> > performance.  
> 
> I think the main idea is forward to hw LRO queues (queues 24-31 in this
> case) just specific protocols with mostly big packets but I completely
> agree we have an issue for small packets. One possible approach would be
> to define a threshold (e.g. 256B) and allocate a buffer or page from the
> page allocator for small packets (something similar to what mt7601u driver
> is doing[0]).  What do you think?

I'm not Eric but FWIW 256B is not going to help much. It's best to keep
the len / truesize ratio above 50%, so with 32k buffers we're talking
about copying multiple frames.

> > And order-5 pages are unlikely to be available in the long run anyway.  
> 
> I agree. I guess we can reduce the order to ~ 2 (something similar to
> mtk_eth_soc hw LRO implementation [1]).

Would be good to test. SW GRO can "re-GRO" the partially coalesced
packets, so it's going to be diminishing returns.

> > LRO support would only make sense if the NIC is able to use multiple
> > order-0 pages to store the payload.  
> 
> The hw supports splitting big packets over multiple order-0 pages if we
> increase the MTU over one page size, but according to my understanding
> hw LRO requires contiguous memory to work.

Hm, you're already passing buffers smaller than normal TSO so
presumably having a smaller buffers will break the sessions more 
often but still work?

You mean want to steal some of the code from:
https://lore.kernel.org/all/20250421222827.283737-1-kuba@kernel.org/
and make the buffer size user-configurable. But not a requirement.
Let's at least get some understanding of the perf benefit of 
32k vs 16k or 8k
-- 
pw-bot: cr

