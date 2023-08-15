Return-Path: <netdev+bounces-27606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AE577C85F
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 09:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 123F128138F
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 07:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30548A927;
	Tue, 15 Aug 2023 07:13:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1946D185D
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 07:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D952DC433C8;
	Tue, 15 Aug 2023 07:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692083590;
	bh=i1KPXV4pn+K3x9Hh+ikyP03jgvCUaA4Eo11CSMNa9m8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IQYVHSU8sVuO7NUhtQt2Pu9+a0/fEVDiAfs+/HS/Z/tEcUhxTZH3ZN5IIAXrqzu+Z
	 uA7SZqcHSgTj5fUfiB7kAnBN5msRcnm0JZw/OPrhJ1Shr+gz0qVEEbwITMpYl/tkLl
	 mBB5PMtqe5+SHg6Tt2Co9zdU7Ie0DlaDg3uRcMYeG/8/5CzdImcz7oHtMkYIU7P9Mw
	 946CJq26zHcJ/qQ0mFD6FbrXzDcyNniclJs1AGrIQkayznEOIEzRPdo8CIf0+whDrF
	 o15O0ne+Aql2vuIG+q8OS0sF6Dd3QBZi8ynDlNQ0RYeLwY2dePWa+dt7rc2OtDHRXB
	 eDrc7q18fvH1Q==
Date: Tue, 15 Aug 2023 09:13:05 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: saeedm@nvidia.com, leon@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	borisp@nvidia.com, tariqt@nvidia.com, lkayal@nvidia.com,
	msanalla@nvidia.com, kliteyn@nvidia.com, valex@nvidia.com,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next] net/mlx5: Remove unused declaration
Message-ID: <ZNslgQSTPHh4Ab5M@vergenet.net>
References: <20230814140804.47660-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814140804.47660-1-yuehaibing@huawei.com>

On Mon, Aug 14, 2023 at 10:08:04PM +0800, Yue Haibing wrote:
> Commit 2ac9cfe78223 ("net/mlx5e: IPSec, Add Innova IPSec offload TX data path")
> declared mlx5e_ipsec_inverse_table_init() but never implemented it.
> Commit f52f2faee581 ("net/mlx5e: Introduce flow steering API")
> declared mlx5e_fs_set_tc() but never implemented it.
> Commit f2f3df550139 ("net/mlx5: EQ, Privatize eq_table and friends")
> declared mlx5_eq_comp_cpumask() but never implemented it.
> Commit cac1eb2cf2e3 ("net/mlx5: Lag, properly lock eswitch if needed")
> removed mlx5_lag_update() but not its declaration.
> Commit 35ba005d820b ("net/mlx5: DR, Set flex parser for TNL_MPLS dynamically")
> removed mlx5dr_ste_build_tnl_mpls() but not its declaration.
> 
> Commit e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
> declared but never implemented mlx5_alloc_cmd_mailbox_chain() and mlx5_free_cmd_mailbox_chain().
> Commit 0cf53c124756 ("net/mlx5: FWPage, Use async events chain")
> removed mlx5_core_req_pages_handler() but not its declaration.
> Commit 938fe83c8dcb ("net/mlx5_core: New device capabilities handling")
> removed mlx5_query_odp_caps() but not its declaration.
> Commit f6a8a19bb11b ("RDMA/netdev: Hoist alloc_netdev_mqs out of the driver")
> removed mlx5_rdma_netdev_alloc() but not its declaration.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Thanks Yue Haibing,

I appreciate you grouping these into a single patch.

Reviewed-by: Simon Horman <horms@kernel.org>


