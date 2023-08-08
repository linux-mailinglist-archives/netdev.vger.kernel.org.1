Return-Path: <netdev+bounces-25512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D9A77468F
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E63281A0B
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43367154B1;
	Tue,  8 Aug 2023 18:58:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E072156CC
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DA3C433C7;
	Tue,  8 Aug 2023 18:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691521102;
	bh=wso/iwkJg5uChEcf2iUgCpF5Uhzgtx4iLB7JGkBF1D8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WcK8DjG4C9hNmkSLmvCeHJ1Jw0Ca5oj8f66CfX1wPeYE7rA89YuqBDk957ZdbgdDr
	 NTXIYvR+ltd3OniLdIGjelpsUWj0RJhEaevKiO+Z8PqDeDAFVXMrv9eab/RoR05PGM
	 qiVZhiocjBd9/69wCnm4GqVo4Jz2Ntqxmwvw6U6ubSoQ2P4t1+bMes0kl2PnOjYSOi
	 vZ/72Hz9pYso9p1kamSMEsB2nJRleyCAwKQvIfWsf6khzQcVTmlnkFOe24uyknOvRZ
	 ycQW4Oa0BDVatvYxhMnslDhnzeqi+rB2UYh4nAQEHuGaV3+5MDl7AzVkHgd0C2k9kv
	 Y3qisuig1r7MA==
Date: Tue, 8 Aug 2023 21:58:16 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: tariqt@nvidia.com, yishaih@nvidia.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jgg@ziepe.ca, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 09/10] mlx4: Connect the infiniband part to the
 auxiliary bus
Message-ID: <20230808185816.GN94631@unreal>
References: <20230804150527.6117-1-petr.pavlu@suse.com>
 <20230804150527.6117-10-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804150527.6117-10-petr.pavlu@suse.com>

On Fri, Aug 04, 2023 at 05:05:26PM +0200, Petr Pavlu wrote:
> Use the auxiliary bus to perform device management of the infiniband
> part of the mlx4 driver.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> Tested-by: Leon Romanovsky <leon@kernel.org>
> ---
>  drivers/infiniband/hw/mlx4/main.c         | 77 ++++++++++++++++-------
>  drivers/net/ethernet/mellanox/mlx4/intf.c | 13 ++++
>  2 files changed, 67 insertions(+), 23 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

