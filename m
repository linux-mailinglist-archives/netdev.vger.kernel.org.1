Return-Path: <netdev+bounces-50083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728D47F48CF
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 15:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2E18B20FD4
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 14:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E0A4E1AF;
	Wed, 22 Nov 2023 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCm7jE6n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7B34E1AB
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 14:22:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F54C433C8;
	Wed, 22 Nov 2023 14:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700662956;
	bh=jNZLRUD4BjxfEjrGy+tgv/nBOGV6T4Kw8Vh9RRaGAuI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RCm7jE6nUKISYSuXNiVse2Kq/sDXUev0y4913coTUOvwhVjdsAKiYiE9f/oIq16OZ
	 Av6rqGhCcxSuLGwTcQE2z1+CQfJbeo8zRTqvG911J5WUR3HryIcz1lVlZFWDk3ACo3
	 p7NijEevl64SRl0s0sEF7nM47+dhVVbfVN/CaIY9phQoLMX92G/YOijXIRcOmtxCBS
	 So+VZjN7ti7mMt3T6JarzWvFdRHlrN6w3oEyc4TKFk8t4H5p3MmePXH5XHWyP0PrMv
	 bV+cSz+g7oz0jTS63DL6UqpcQ68EMHLRWOnCu8cmm3hXWT02anrIWVoQTaNaPeM6n6
	 pMjylBob8Cq3A==
Message-ID: <2e0722d2-5946-4d74-89e0-b68dd5715d7e@kernel.org>
Date: Wed, 22 Nov 2023 15:22:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 05/13] eth: link netdev to page_pools in
 drivers
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 almasrymina@google.com, ilias.apalodimas@linaro.org, dsahern@gmail.com,
 dtatulea@nvidia.com, willemb@google.com
References: <20231122034420.1158898-1-kuba@kernel.org>
 <20231122034420.1158898-6-kuba@kernel.org>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20231122034420.1158898-6-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/22/23 04:44, Jakub Kicinski wrote:
> Link page pool instances to netdev for the drivers which
> already link to NAPI. Unless the driver is doing something
> very weird per-NAPI should imply per-netdev.
> 
> Add netsec as well, Ilias indicates that it fits the mold.
> 
> Signed-off-by: Jakub Kicinski<kuba@kernel.org>
> ---
> v3: fix netsec build
> v2: add netsec
> ---
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 1 +
>   drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 1 +
>   drivers/net/ethernet/microsoft/mana/mana_en.c     | 1 +
>   drivers/net/ethernet/socionext/netsec.c           | 2 ++
>   4 files changed, 5 insertions(+)

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

