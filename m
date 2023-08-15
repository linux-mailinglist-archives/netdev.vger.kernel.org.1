Return-Path: <netdev+bounces-27763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA2F77D1C9
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 20:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10F1B1C209CA
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 18:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E26318025;
	Tue, 15 Aug 2023 18:26:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10822154AC
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 18:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09FABC433C7;
	Tue, 15 Aug 2023 18:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692123991;
	bh=YJ0/8zdnMDRXvPB3UfHtL9v7XyB4zHHumRxB3bDf6fc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ffs/R70x4VZ5W0eaFayjpGXQgeGGl3eHPoaM13QfOUscjLW86mkgTzKWJC6DqkAmJ
	 bmYXXhiOXdnUHXiT/xDs/8h64qMRj5pEV4kL+XMcFE8zofd11C1ZuZF/+P2zeS0vdw
	 jNt7MEmsDwI/CQ5dpUfdkQnDXBbzSVNRAuXpDMsW5mKNwNjg2SSsoS63hbJg/uiA+k
	 ggxr2OimfFiEnpI5PRRQVCLpdlcKx+6DAT7YqeA6OTvCuHZqu1T1rhMhxijYOQk3Om
	 FhT3QoK+pPy2gEELS4w5BK0zWMXwotBDd9LF9PPllAHX3P0w2KudZHuWKmPU8ONSre
	 xoVGhM1AAY/hA==
Date: Tue, 15 Aug 2023 21:26:27 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] net: hns3: fix wrong rpu tln reg issue
Message-ID: <20230815182627.GS22185@unreal>
References: <20230815060641.3551665-1-shaojijie@huawei.com>
 <20230815060641.3551665-5-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815060641.3551665-5-shaojijie@huawei.com>

On Tue, Aug 15, 2023 at 02:06:41PM +0800, Jijie Shao wrote:
> In the original RPU query command, the status register values of
> multiple RPU tunnels are accumulated by default, which is unreasonable.
> This patch Fix it by querying the specified tunnel ID.
> The tunnel number of the device can be obtained from firmware
> during initialization.
> 
> Fixes: ddb54554fa51 ("net: hns3: add DFX registers information for ethtool -d")
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  1 +
>  .../hisilicon/hns3/hns3pf/hclge_cmd.h         |  4 +-
>  .../hisilicon/hns3/hns3pf/hclge_main.c        |  2 +
>  .../hisilicon/hns3/hns3pf/hclge_regs.c        | 66 ++++++++++++++++++-
>  4 files changed, 71 insertions(+), 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

