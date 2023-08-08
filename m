Return-Path: <netdev+bounces-25497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABF7774552
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB91A1C20F16
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8582214298;
	Tue,  8 Aug 2023 18:41:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECA414F96
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:41:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2236AC433C8;
	Tue,  8 Aug 2023 18:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691520065;
	bh=+f2YihxhO0jWYS9TiQ7dwe3/Y5WOlZkCJXUozzMIN8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TiwXfQp81mCOTX+fFaQs+SOTfJsofSr468SdjRQtV85L2YcuvTNnoQX2lZ53e5v85
	 k85N3sWyxQI7nn21CzQajNtkWevT/dXOLvyV/wBCGhDSFQoDObTk+nc+sN2NRkeXsm
	 VQ8qvyp2BkLrZ15kgHRf0Eh0jYRDZcrLOdfzj4eIVEsTLKdqLRHth/QRpRJ3U4CYJ8
	 jAtiL9CxnfyiDN5+nWFtOyG9wWkZn5+cWjLTsMtPH+wx13Ab+Rhc3wwDQAf2511OSY
	 ubaQAG4KKsRufmhzlnXH91rfTCVKzNIrgx26SmYFUykP4Q/wVMnPabi2AWKIciCquk
	 WjQ/PKTF0oTtw==
Date: Tue, 8 Aug 2023 21:40:58 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, wangpeiyang1@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 net 2/4] net: hns3: refactor
 hclge_mac_link_status_wait for interface reuse
Message-ID: <20230808184058.GD94631@unreal>
References: <20230807113452.474224-1-shaojijie@huawei.com>
 <20230807113452.474224-3-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807113452.474224-3-shaojijie@huawei.com>

On Mon, Aug 07, 2023 at 07:34:50PM +0800, Jijie Shao wrote:
> From: Jie Wang <wangjie125@huawei.com>
> 
> Some nic configurations could only be performed after link is down. So this
> patch refactor this API for reuse.
> 
> Signed-off-by: Jie Wang <wangjie125@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

