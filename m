Return-Path: <netdev+bounces-29642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 332DD784385
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 16:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E127228101D
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 14:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21AC1CA1A;
	Tue, 22 Aug 2023 14:10:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D791C9FF
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 14:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C85C433BA;
	Tue, 22 Aug 2023 14:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692713433;
	bh=Bk8bmL2ziMya4zvM3/ZvT3gOkTt4BhDmW52iW0JD4I4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lL1DOwoHUf2wkGK3EC/oK2RnaqiVX38OE+092tYWyo9hRXlB69Te3sM1rScTWEtGY
	 bOfwlr4bIxne46VFBlQJXH6FUxOcE5hJTCcIwWVyEZnaPAzD7MCc4264pdhRIv8teH
	 3k7rR244O/m0YIwyRAPCfpkRQrw0YitU5Q4cNjBLTfK48sQrWs4t7VpXryprv6OnNH
	 3sE0c8Y6vIbfZ+qXrWtXkJ1mFp5Fb1qoVC88M4q6a+zb825U7dy/qLgNJOhVtc0oiC
	 dU1VRK43tzCwkVfIN72sD+U8To7+osFs2p4NgLoWOjpUHs1bDXnRIozRHwhzfQ7y5G
	 /pWSXw3XcWi9g==
Date: Tue, 22 Aug 2023 17:10:29 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Yu Liao <liaoyu15@huawei.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	saeedm@nvidia.com, liwei391@huawei.com, davem@davemloft.net,
	maciej.fijalkowski@intel.com, michal.simek@amd.com,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net/mlx5e: Use PTR_ERR_OR_ZERO() to
 simplify code
Message-ID: <20230822141029.GG6029@unreal>
References: <20230822021455.205101-1-liaoyu15@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822021455.205101-1-liaoyu15@huawei.com>

On Tue, Aug 22, 2023 at 10:14:54AM +0800, Yu Liao wrote:
> Use the standard error pointer macro to shorten the code and simplify.
> 
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_fs.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

