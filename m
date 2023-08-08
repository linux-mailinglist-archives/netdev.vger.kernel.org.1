Return-Path: <netdev+bounces-25513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F33774691
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E762281A1E
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2977154B2;
	Tue,  8 Aug 2023 18:58:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE9B1401B
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:58:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719F8C433C7;
	Tue,  8 Aug 2023 18:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691521116;
	bh=3eJT8c5liB8+ruQaGOmsFlAOd7SD1h25ExJ3H0VtLl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MlDo7JyuuWgVE9WVNT4mQCslSwD/WDfZDU3fIPK7DL88e9XBS+s77ctY4PeuRvfQM
	 bqvo4Q8y5HmhDUHkPQgSM3Q2kdhz3zruTXViyCcGMTvD9659sbG4xk+mJJMJzlQD6z
	 w6z8rlqTlQywytE747gJpV/dvC9bTrdoQfo5618sk+8kDKmUkP7pnCk0/gyIwUawE5
	 t4J3WdSbsFDiBT7m5GHVwWuE7rnOGr5ikjTF/scWZPLSLqh/UFFjYQDhZj/KDs5rua
	 xjeSA52c1XiUCZi/C6eDAmSzTN39oOHMzqou9xveq39FMJll79e5MlR6u8t8OZpl1D
	 u/4Zk/kG2GBWQ==
Date: Tue, 8 Aug 2023 21:58:28 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: tariqt@nvidia.com, yishaih@nvidia.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jgg@ziepe.ca, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 10/10] mlx4: Delete custom device management
 logic
Message-ID: <20230808185828.GO94631@unreal>
References: <20230804150527.6117-1-petr.pavlu@suse.com>
 <20230804150527.6117-11-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804150527.6117-11-petr.pavlu@suse.com>

On Fri, Aug 04, 2023 at 05:05:27PM +0200, Petr Pavlu wrote:
> After the conversion to use the auxiliary bus, the custom device
> management is not needed anymore and can be deleted.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> Tested-by: Leon Romanovsky <leon@kernel.org>
> ---
>  drivers/net/ethernet/mellanox/mlx4/intf.c | 125 ----------------------
>  drivers/net/ethernet/mellanox/mlx4/main.c |  28 -----
>  drivers/net/ethernet/mellanox/mlx4/mlx4.h |   3 -
>  include/linux/mlx4/driver.h               |  10 --
>  4 files changed, 166 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

