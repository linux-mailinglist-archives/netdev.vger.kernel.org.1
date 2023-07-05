Return-Path: <netdev+bounces-15531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FA774840E
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 14:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F9DC280FDA
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 12:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF00747A;
	Wed,  5 Jul 2023 12:20:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B38D6FDB
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 12:20:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF2BC433C8;
	Wed,  5 Jul 2023 12:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688559601;
	bh=wvYQTxCeQrH3nnRhI5N6qhbgQXfQTM73ZiQwOCcpHiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sUBaVbqlX+9bGFj9UT9J2qEtduLyEZl4sntSdushOY26TFfe8IxD4GERMe1Cw2FOe
	 FrXO9wpMEs71nlnkKn1b6XRBJbJ8mGqs0Ov25UEumckZ9IJIJc1yU03dQ3uezdVfAi
	 9IP3TOxZ12Yb+AjRYXbl0+bIl4o59SuC5CmSKDvPacNvpH6xGWxdnsp9wOEb7EmFeY
	 oSl0xIxPoH5bNeSBVPWMLPpz+PmOgnV6w5oyiywrV2ZRowys8MOJV/r35ays9BZs0R
	 e6KTrC079t2/2Optdhx1mK9I+q6r4u/qpDMjQ8hIzJXVlRhXzEJjewcvI7sqcRVQpb
	 vbs4C+DBR9N9A==
Date: Wed, 5 Jul 2023 15:19:56 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	valex@nvidia.com, kliteyn@nvidia.com, mbloch@nvidia.com,
	danielj@nvidia.com, erezsh@mellanox.com, saeedm@nvidia.com,
	weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net,v2] net/mlx5: DR, fix memory leak in
 mlx5dr_cmd_create_reformat_ctx
Message-ID: <20230705121956.GO6455@unreal>
References: <20230705121527.2230772-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705121527.2230772-1-shaozhengchao@huawei.com>

On Wed, Jul 05, 2023 at 08:15:27PM +0800, Zhengchao Shao wrote:
> when mlx5_cmd_exec failed in mlx5dr_cmd_create_reformat_ctx, the memory
> pointed by 'in' is not released, which will cause memory leak. Move memory
> release after mlx5_cmd_exec.
> 
> Fixes: 1d9186476e12 ("net/mlx5: DR, Add direct rule command utilities")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
> v2: goto label 'err_free_in' to free 'in'
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

