Return-Path: <netdev+bounces-24051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6126A76E9F5
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 15:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E92282152
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C521F176;
	Thu,  3 Aug 2023 13:21:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862271E528
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 13:20:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B56FC433C8;
	Thu,  3 Aug 2023 13:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691068859;
	bh=x2/Zq9o6dLg9X74csTMPPMs7aiPYYlz2kT0Afe7Zbrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tmc+3SrmPSHBODRkYoKjilOJtCnLhAWCWLbhEGrzGfDMbpQzCtx2Pv7loyUtjOyTV
	 I5JIxXO/0iyY3NYGp9sSbT2oqlR9WrbPhQgukKPGL13nrx3Hll4kXEHIYQjHph7YgW
	 xEOCk/ZoF9Ic4G6gVcsZJdEuGzH692CIACmYaJzTSDYBfYSjODF8WBkDpd3Kjtp1Rh
	 9LBFScEcIXqgMWsL5jqaootxW9ufh9AcCke9HoNXXY1dkJWKfsb/SFsbWBNcxxJxcU
	 FAY8SBpUbXlNKdooOKmOjcSjaKXdvgtFkkkZCMEXCHkWpt9LeR5qExn1q6mEZVyUy2
	 1aZ+M14s0v2hQ==
Date: Thu, 3 Aug 2023 16:20:54 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: tariqt@nvidia.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net/mlx4: Remove many unnecessary NULL values
Message-ID: <20230803132054.GE53714@unreal>
References: <20230802040026.2588675-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802040026.2588675-1-ruanjinjie@huawei.com>

On Wed, Aug 02, 2023 at 12:00:26PM +0800, Ruan Jinjie wrote:
> The NULL initialization of the pointers assigned by kzalloc() first is
> not necessary, because if the kzalloc() failed, the pointers will be
> assigned NULL, otherwise it works as usual. so remove it.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
> v2:
> - add the wrong removed NULL hunk code in mlx4_init_hca().
> - update the commit message.
> ---
>  drivers/net/ethernet/mellanox/mlx4/en_ethtool.c | 10 +++++-----
>  drivers/net/ethernet/mellanox/mlx4/en_netdev.c  |  4 ++--
>  drivers/net/ethernet/mellanox/mlx4/main.c       |  8 ++++----
>  3 files changed, 11 insertions(+), 11 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

