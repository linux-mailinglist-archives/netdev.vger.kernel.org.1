Return-Path: <netdev+bounces-28374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 833A177F354
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 11:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE61281E74
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 09:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4736F125D9;
	Thu, 17 Aug 2023 09:32:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17671125B9
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 09:32:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E20BC433C8;
	Thu, 17 Aug 2023 09:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692264734;
	bh=oS+UJYlaNY8zMJtlxhG+wLZfNeYGmKD5QggZrmixX40=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=d86hVlZvLW+HSN7HD2AsSx7gpaIly2iE0/PzgeEHbJPEtPhQa6yfRsdmu4bHTwCI7
	 w7qRCrv6GVS34aSKWd/O3E1uPAHyFZkIcs07qPET6UtizsWQ8Jyboy41Tqfau0f1y+
	 yK7mXDpQkVkH/BmjArc1+5YqEVMKwIMET3vxjaLHvTm6LKyGKTlD8gKchi3XLljjs6
	 nRfOV9UndES2Daz5ZyOMAU9q+GZfYpMRObz4smpkHqRpySCB2gsLIEYehiPBYGOy2a
	 Kqr6K2hw0IhNvO8o5SRYh7butpm3JbWzkR4j6MAddx1sWTNVqw0Ngx2gvjLXqT5qw+
	 kJE3Vmky6SxbQ==
Message-ID: <d1923d62-ced4-dc16-ccee-bcfff78ccfa7@kernel.org>
Date: Thu, 17 Aug 2023 11:32:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: hawk@kernel.org, ilias.apalodimas@linaro.org,
 aleksander.lobakin@intel.com, linyunsheng@huawei.com, almasrymina@google.com
Subject: Re: [RFC net-next 02/13] net: page_pool: avoid touching slow on the
 fastpath
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
References: <20230816234303.3786178-1-kuba@kernel.org>
 <20230816234303.3786178-3-kuba@kernel.org>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20230816234303.3786178-3-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/08/2023 01.42, Jakub Kicinski wrote:
> To fully benefit from previous commit add one byte of state
> in the first cache line recording if we need to look at
> the slow part.
> 
> The packing isn't all that impressive right now, we create
> a 7B hole. I'm expecting Olek's rework will reshuffle this,
> anyway.
> 
> Signed-off-by: Jakub Kicinski<kuba@kernel.org>
> ---
>   include/net/page_pool/types.h | 2 ++
>   net/core/page_pool.c          | 4 +++-
>   2 files changed, 5 insertions(+), 1 deletion(-)

As followup to 1/13 LGTM

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

