Return-Path: <netdev+bounces-25498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32459774558
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 627E61C20E80
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE8614F8D;
	Tue,  8 Aug 2023 18:41:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC3413FE6
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:41:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8D6C433C7;
	Tue,  8 Aug 2023 18:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691520072;
	bh=6VD6KFzW7DJTqaWY79jF9GAl8AF9p1AZkcFnQqzYAdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IV4p4AUl6cJ03spnOKSGuL4mpk8Szhw9JfWLI5lJmI8JeK3H+NSSADheC4BBaY/Er
	 v0BSsSIG0g2znSFo39C01W/NClpvBY4Wpm8YqJ3tJX9Yt+XRdFTNpjiuCCbqTNBsON
	 g4vxgy50YR2JpFcN40MISuU2EmcyDsaKV/lbW9BAEYH9MtbWmPYpak/xrVVYhyl8pd
	 0ONF3Q/EQ9J2SIuzokbNj0h++DJCSbeJJPpueYJNTBeNz74icCUg+8UpwPSPGI0eEc
	 6gcU75eSdtmofrTDWiYiH/enU19/9Dzv/AmX6ArjCvcatXWuSyXi3r9GZeOPKc5DSW
	 yWQbkDYHoN12g==
Date: Tue, 8 Aug 2023 21:41:05 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, wangpeiyang1@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 net 3/4] net: hns3: add wait until mac link down
Message-ID: <20230808184105.GE94631@unreal>
References: <20230807113452.474224-1-shaojijie@huawei.com>
 <20230807113452.474224-4-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807113452.474224-4-shaojijie@huawei.com>

On Mon, Aug 07, 2023 at 07:34:51PM +0800, Jijie Shao wrote:
> From: Jie Wang <wangjie125@huawei.com>
> 
> In some configure flow of hns3 driver, for example, change mtu, it will
> disable MAC through firmware before configuration. But firmware disables
> MAC asynchronously. The rx traffic may be not stopped in this case.
> 
> So fixes it by waiting until mac link is down.
> 
> Fixes: a9775bb64aa7 ("net: hns3: fix set and get link ksettings issue")
> Signed-off-by: Jie Wang <wangjie125@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  .../net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

