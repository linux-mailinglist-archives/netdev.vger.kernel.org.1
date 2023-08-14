Return-Path: <netdev+bounces-27299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCFA77B626
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 12:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6FC42810BD
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 10:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63E4AD59;
	Mon, 14 Aug 2023 10:11:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66690AD27
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 10:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E438C433C8;
	Mon, 14 Aug 2023 10:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692007877;
	bh=uxvanIIHvhdIZvWa0ZURaB6hMyqkNSdzk1Vwl2Ugphk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qbwq5yrZW58GOvlUw/BEWbHlCWfcT5bSz/K4lOpXdVNzecfQ1TjWO7eWfaK/a6Ko8
	 C6TK62g5tFHU6tm9GLmgV9gWdFWWIFXJFnRRrANz+JoNl5PYgr3EdIbUPxuloHWDQr
	 ny6vjPD5pOV06y0rdEuXpIuIvLxtcjwR55I2rpmZ5d1InZNA71fuQbWt58g3H6LWbb
	 i6hU2zZo6EvS7dtz//YL4eBCuiJvp8Kp9cNF7b4U+GYsXDwkg1R4/2E28bDNGvoepn
	 j3cAobipHAU5tqKc92ahHHngTC8yUbmoHDLoJV1sO9DGUShpNEllYyEVF9hKiSrFYv
	 6MpJMjG6Uj+qQ==
Date: Mon, 14 Aug 2023 13:11:13 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Li Zetao <lizetao1@huawei.com>
Cc: vadim.fedorenko@linux.dev, davem@davemloft.net, edumazet@google.com,
	elic@nvidia.com, kuba@kernel.org, linux-rdma@vger.kernel.org,
	mbloch@nvidia.com, netdev@vger.kernel.org, pabeni@redhat.com,
	roid@nvidia.com, saeedm@nvidia.com, shayd@nvidia.com,
	vladbu@nvidia.com, kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH -next v2] net/mlx5: Devcom, only use devcom after NULL
 check in mlx5_devcom_send_event()
Message-ID: <20230814101113.GE3921@unreal>
References: <face8e0a-b3f6-85d9-ce1d-8afecdafe2a8@linux.dev>
 <20230814072342.189470-1-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814072342.189470-1-lizetao1@huawei.com>

On Mon, Aug 14, 2023 at 03:23:42PM +0800, Li Zetao wrote:
> There is a warning reported by kernel test robot:
> 
> smatch warnings:
> drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c:264
> 	mlx5_devcom_send_event() warn: variable dereferenced before
> 		IS_ERR check devcom (see line 259)
> 
> The reason for the warning is that the pointer is used before check, put
> the assignment to comp after devcom check to silence the warning.
> 
> Fixes: 88d162b47981 ("net/mlx5: Devcom, Infrastructure changes")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202308041028.AkXYDwJ6-lkp@intel.com/
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
> v1 -> v2: Modify the order of variable declarations to end up with reverse x-mas tree order.
> v1: https://lore.kernel.org/all/20230804092636.91357-1-lizetao1@huawei.com/
> 
>  drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

