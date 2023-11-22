Return-Path: <netdev+bounces-50169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 101DE7F4C1F
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 17:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421DB1C2088C
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38734D5AD;
	Wed, 22 Nov 2023 16:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8glaV16"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FB4208AF
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 16:17:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195D5C433C7;
	Wed, 22 Nov 2023 16:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700669825;
	bh=GL696i0Rm2juk0wrUg+z1s5Qm76DlIPSLHX0iQAtuDg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u8glaV16GxKs8UoXJCvLnPdiKrz5NcN4SCdOyXqSmuWyWjHIDxTtKt4N16QKWQ4LX
	 M66BAa/HTHgFRNj08w4MSM39y6gSCxMC4fhSswN60nPj+8NV0v+Rzv3uIE39H9AKI1
	 7aCTkYSiXjhFa8F796Z0LO1dgRFBOBx17mhGsYdUs77vOT78bgBxPeoKa3YWI/6mUX
	 4u51QEnq8HrberbFV2AGI4gBKXYRoZVEfEjtEErHHd5yAv7/heGnsVHk8g10FxF4+o
	 RF2vN9mfpRg3IND0EMwfNhz50HJKXoar/d2gQqV0yQn5dGsYhKFNLXb/OxR1Tdr5zr
	 W/1Hv4MBhJYnQ==
Message-ID: <2491069a-f9ff-46bd-a468-0ab3d9eb6371@kernel.org>
Date: Wed, 22 Nov 2023 17:17:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 13/13] tools: ynl: add sample for getting
 page-pool information
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 almasrymina@google.com, ilias.apalodimas@linaro.org, dsahern@gmail.com,
 dtatulea@nvidia.com, willemb@google.com,
 kernel-team <kernel-team@cloudflare.com>
References: <20231122034420.1158898-1-kuba@kernel.org>
 <20231122034420.1158898-14-kuba@kernel.org>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20231122034420.1158898-14-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/22/23 04:44, Jakub Kicinski wrote:
> Regenerate the tools/ code after netdev spec changes.
> 
> Add sample to query page-pool info in a concise fashion:
> 
> $ ./page-pool
>      eth0[2]	page pools: 10 (zombies: 0)
> 		refs: 41984 bytes: 171966464 (refs: 0 bytes: 0)
> 		recycling: 90.3% (alloc: 656:397681 recycle: 89652:270201)
> 
> Signed-off-by: Jakub Kicinski<kuba@kernel.org>
> ---
>   tools/include/uapi/linux/netdev.h     |  36 +++
>   tools/net/ynl/generated/netdev-user.c | 419 ++++++++++++++++++++++++++
>   tools/net/ynl/generated/netdev-user.h | 171 +++++++++++
>   tools/net/ynl/lib/ynl.h               |   2 +-
>   tools/net/ynl/samples/.gitignore      |   1 +
>   tools/net/ynl/samples/Makefile        |   2 +-
>   tools/net/ynl/samples/page-pool.c     | 147 +++++++++
>   7 files changed, 776 insertions(+), 2 deletions(-)
>   create mode 100644 tools/net/ynl/samples/page-pool.c

Nice a sample tool.

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

Let me provide some lore links[1][2] to this, if someone want to take a
look at extracting for their own monitoring system... ;-)

[1] 
https://lore.kernel.org/netdev/20231122034420.1158898-14-kuba@kernel.org/

[2] 
https://lore.kernel.org/netdev/20231122034420.1158898-14-kuba@kernel.org/#Z31tools:net:ynl:samples:page-pool.c

[3] 
https://lore.kernel.org/netdev/20231122034420.1158898-14-kuba@kernel.org/#Z31tools:net:ynl:generated:netdev-user.c


