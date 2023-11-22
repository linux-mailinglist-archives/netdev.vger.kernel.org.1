Return-Path: <netdev+bounces-50078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B057F48B1
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 15:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 569F61C20925
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 14:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E403D3A9;
	Wed, 22 Nov 2023 14:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bvs2l/uX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA814E613
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 14:15:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A346C433CA;
	Wed, 22 Nov 2023 14:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700662541;
	bh=vYOswDHWBu8XM5+4mnHar4WQgCUOSNRDIy/RJB2RvjU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Bvs2l/uXg5oz1hcT3N1tgexuqUGy95Z2z88pUsKW/Tdf8i+s2LC1nPpMW7eA1/TPM
	 KnT1/6Lh4z8moQtOjomPSl6rW8Q6ZCjc2KzmTe+/lIsUSEP6C4uOQgMVgCkfqWyvCc
	 79mhYCwmT4c7HUGfqIOU+XeZsLkcdJkSvaRcAlfjN/q5iM/o5IaDaASZQa8kseTPpP
	 8eTcDY7BK8fQ1oAMV2/YNl43a0hRzBXh/P97TD+IryGmieuUyGdxKmzw2lSZzPdO8W
	 H4xGiRNL92pgTkkk747vEF0xmswQBSSMF7X8A8SovuBLdvOAjFvD2JSOQD/bwGdpLD
	 djrapRE/Im6vg==
Message-ID: <f6f0ac53-7ae5-4c02-bed0-12a511f581a0@kernel.org>
Date: Wed, 22 Nov 2023 15:15:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 01/13] net: page_pool: factor out uninit
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 almasrymina@google.com, ilias.apalodimas@linaro.org, dsahern@gmail.com,
 dtatulea@nvidia.com, willemb@google.com
References: <20231122034420.1158898-1-kuba@kernel.org>
 <20231122034420.1158898-2-kuba@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20231122034420.1158898-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/22/23 04:44, Jakub Kicinski wrote:
> We'll soon (next change in the series) need a fuller unwind path
> in page_pool_create() so create the inverse of page_pool_init().
> 
> Reviewed-by: Ilias Apalodimas<ilias.apalodimas@linaro.org>
> Signed-off-by: Jakub Kicinski<kuba@kernel.org>
> ---
>   net/core/page_pool.c | 21 +++++++++++++--------
>   1 file changed, 13 insertions(+), 8 deletions(-)

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

