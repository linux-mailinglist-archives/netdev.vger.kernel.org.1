Return-Path: <netdev+bounces-24177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 850DB76F1B1
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 20:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F5402822C9
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 18:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A5A25903;
	Thu,  3 Aug 2023 18:17:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0720F24161
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 18:17:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1AEC433C8;
	Thu,  3 Aug 2023 18:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691086654;
	bh=eFNBhBaVjqMLEN64GMvfHB1O2ZA4bHNQxw/O6nWVKVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hWDLwqkl9cba6rL1dO1czm4V39g6/zrqxlamrZx66fiU3LtcuQEyY3mHSI+Fa9HZI
	 p+cXDuhV7XFg/KOdAtKiQKBnubgXAdivLmEOi9Un8Ie0ZQDxAvzy3eCgRzOrDCW1xK
	 jlowrkuSXugor8/GLskdVyTDRpTIeqT/7J/MtOTwpMx+ZqYdUXvGxbc0IqVbqM9mgm
	 5hlaakfSrINoy+Nh35ewnVCMaxJz64CuhylEV2Z6RKvvusyI3NLHK+TQqxmSykGxAf
	 2XWHPB81AZHabBx1JW2591ozC2/lTsfCZt/2tIw1buHZ13YlkjN7LUr3CYhMcbTYD9
	 NWrYgrBTOVDzQ==
Date: Thu, 3 Aug 2023 21:17:30 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: borisp@nvidia.com, saeedm@nvidia.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net/mlx5: remove many unnecessary NULL values
Message-ID: <20230803181730.GG53714@unreal>
References: <20230801123854.375155-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801123854.375155-1-ruanjinjie@huawei.com>

On Tue, Aug 01, 2023 at 08:38:54PM +0800, Ruan Jinjie wrote:
> Ther are many pointers assigned first, which need not to be initialized, so

Ther -> There

> remove the NULL assignment.

assignment -> assignments.

> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/fpga/core.c   | 4 ++--
>  drivers/net/ethernet/mellanox/mlx5/core/lib/hv_vhca.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

