Return-Path: <netdev+bounces-25507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2390C77466C
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54A411C20E90
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BFD154A7;
	Tue,  8 Aug 2023 18:56:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC21156CB
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:56:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9C6C433C9;
	Tue,  8 Aug 2023 18:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691520967;
	bh=X7+ZlYY0FSROiWpD/bKqog6jgK40bS0uWHHjKh6wWlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tDG9QJkLhPbqqQfBzt3N7r2dsveLSfJMqJQfcq0fGicrdcP6y78WcyFNVY21Ax8h2
	 xFWsWEeiADuI5XUFS3VMfpTD8uKILykVo32nUMolFaKIW2gRP1f/D/pgT4KQ3WAaq5
	 f5epbNJZuODx4njaDNqmunIVfXtw+XWFGFh6yi9Aj9DA962USo9mS/DDPeUIWLIAuF
	 K2B1YZwIHghG31iZS5eaGN2fifNyuh1XCAlL1DexxeTRTdM5hsw8n60uC0lrkn5QC/
	 Le3r2umH3AE1Hbyct6+Oth8getUwyIa9G9uIyc8PvVPq/FN216Ju1RnHtDN5B57Ju2
	 HPBmj5nge99iA==
Date: Tue, 8 Aug 2023 21:56:01 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: tariqt@nvidia.com, yishaih@nvidia.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jgg@ziepe.ca, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 04/10] mlx4: Get rid of the
 mlx4_interface.activate callback
Message-ID: <20230808185601.GI94631@unreal>
References: <20230804150527.6117-1-petr.pavlu@suse.com>
 <20230804150527.6117-5-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804150527.6117-5-petr.pavlu@suse.com>

On Fri, Aug 04, 2023 at 05:05:21PM +0200, Petr Pavlu wrote:
> The mlx4_interface.activate callback was introduced in commit
> 79857cd31fe7 ("net/mlx4: Postpone the registration of net_device"). It
> dealt with a situation when a netdev notifier received a NETDEV_REGISTER
> event for a new net_device created by mlx4_en but the same device was
> not yet visible to mlx4_get_protocol_dev(). The callback can be removed
> now that mlx4_get_protocol_dev() is gone.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> Tested-by: Leon Romanovsky <leon@kernel.org>
> ---
>  drivers/net/ethernet/mellanox/mlx4/en_main.c | 37 +++++++++-----------
>  drivers/net/ethernet/mellanox/mlx4/intf.c    |  2 --
>  include/linux/mlx4/driver.h                  |  1 -
>  3 files changed, 16 insertions(+), 24 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

