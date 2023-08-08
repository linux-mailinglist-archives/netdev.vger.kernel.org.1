Return-Path: <netdev+bounces-25496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 045AB774551
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 354A41C20E68
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F050B14298;
	Tue,  8 Aug 2023 18:40:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90568134BD
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1714BC433C7;
	Tue,  8 Aug 2023 18:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691520057;
	bh=izSNwFnda6h0Un6PypnWGVheuJkWo9/X0Ob6dyB+nIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bEk8gebSl+EOpmPGjpsUFZUwrNfkbhTdSgL61ucTkGe+upaditmqfLn+sbFtG2toQ
	 LZAHIdTm52x917COSvVBwd1pVcBcdAig+JE3YqRdBfUGc+e8cH5f3yo/ivRJq9iUJg
	 ItthR9DoWmhZWuHv7XOEqgoXuY2cOBuInQP+NyxX28juQE6YCVVlAxRigvcbXYYbmo
	 YjLiWFZIfTKoP9vOrnoHES4ls3zl6ub0UDzfAsUVvBTykKQXCT29apCfk8RjegvPBO
	 yvhukPtfN+PaFiSqGjH0+tWDZKyA9ducYoPIKBh+qtHnFAyyMkYDMlXQDOfbOYHN5E
	 f0zm1BOi1s/EA==
Date: Tue, 8 Aug 2023 21:40:49 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, wangpeiyang1@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 net 1/4] net: hns3: restore user pause configure when
 disable autoneg
Message-ID: <20230808184049.GC94631@unreal>
References: <20230807113452.474224-1-shaojijie@huawei.com>
 <20230807113452.474224-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807113452.474224-2-shaojijie@huawei.com>

On Mon, Aug 07, 2023 at 07:34:49PM +0800, Jijie Shao wrote:
> From: Jian Shen <shenjian15@huawei.com>
> 
> Restore the mac pause state to user configuration when autoneg is disabled
> 
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 5 ++++-
>  drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c   | 2 +-
>  drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h   | 1 +
>  3 files changed, 6 insertions(+), 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

