Return-Path: <netdev+bounces-50082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4976D7F48CA
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 15:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759C41C209AC
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 14:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FB04E1AD;
	Wed, 22 Nov 2023 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fy2SQq6W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB2E4E1A1
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 14:21:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4E7C433C8;
	Wed, 22 Nov 2023 14:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700662879;
	bh=xHcqdRS3yV6wY6jMLUUP96QwME6AlSuoh0LofXnfLpI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fy2SQq6WiZi3bN8cg9402CPUOdzjhf6CmPq2BL7TzHG6VJ2y/4BgijOGHZk4kIM4U
	 dHX3BFTJBVxrf8CANwDM6MJ2zXPLF1ixgc4/0skFiFxwhIDv9MmRBzZzwHJNsDYiz+
	 UaD8CD8rU3wHeprez3gzyxDO/AdVW6D68Um+hhL4cVSKWgL/oXSUrnwokcBp7CceaZ
	 H9S2H8uI5a2SjrTihKBwzWKUk+dJB1Jzd1TQqCj6+MlNyil+sj7UDNNgtNEfh3Nfoi
	 2rLPBPt92aKm0qSOmD4ObxGUHYEJnLITXuXc9R2Cb+SE6e3coi4ptBQivt2EW115K3
	 DHNzmJjbANP8g==
Message-ID: <d18db808-a5d5-41a3-a26a-7b5afe045e19@kernel.org>
Date: Wed, 22 Nov 2023 15:21:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 04/13] net: page_pool: stash the NAPI ID for
 easier access
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 almasrymina@google.com, ilias.apalodimas@linaro.org, dsahern@gmail.com,
 dtatulea@nvidia.com, willemb@google.com
References: <20231122034420.1158898-1-kuba@kernel.org>
 <20231122034420.1158898-5-kuba@kernel.org>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20231122034420.1158898-5-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/22/23 04:44, Jakub Kicinski wrote:
> To avoid any issues with race conditions on accessing napi
> and having to think about the lifetime of NAPI objects
> in netlink GET - stash the napi_id to which page pool
> was linked at creation time.
> 
> Signed-off-by: Jakub Kicinski<kuba@kernel.org>
> ---
>   include/net/page_pool/types.h | 1 +
>   net/core/page_pool_user.c     | 4 +++-
>   2 files changed, 4 insertions(+), 1 deletion(-)

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

