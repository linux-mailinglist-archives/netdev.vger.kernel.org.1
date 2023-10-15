Return-Path: <netdev+bounces-41068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C01A7C9856
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 10:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A113B20B84
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 08:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2A9185F;
	Sun, 15 Oct 2023 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjbdxBQ6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F2F23A6
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 08:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3517AC43395;
	Sun, 15 Oct 2023 08:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697357711;
	bh=jt5hQedCcw87t+vMPrrY68DJg6v3/zL7YyUGJol01WA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AjbdxBQ6bkom7FjtqyTD+uNU6MByuiwS5zesLfgwK8Z0aL8kGbvzQi311guozIadg
	 cDj+yea2MYbiIKUpT6eDfrrD4qqfG3bxsk5S4lXG10zhC2HxeU1ZI35ueLrUKK6kwd
	 L6bRsUJRdF8dfhK2MzGf152BSEiaSgJlkmv0Z4UvJLCoYePoMMf0XIxTBXMN8Qsf9s
	 iuAU5rliSCRCqKFcPLAUP7ObtKBvdT/2TPAPVRtOZuyHSIe6CKmPKEgx6qQl2cqOM/
	 x6rQ7AN27aHLaIRqjSHTAiu0PfAR8aaGOhidGb4g+aPdDC9Es8di0FOSuu64wubMpX
	 EhCZbYelG/NRg==
Date: Sun, 15 Oct 2023 11:15:07 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, dsahern@gmail.com, stephen@networkplumber.org,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linuxarm@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 iproute2-next 2/2] rdma: Add support to dump SRQ
 resource in raw format
Message-ID: <20231015081507.GB25776@unreal>
References: <20231010075526.3860869-1-huangjunxian6@hisilicon.com>
 <20231010075526.3860869-3-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010075526.3860869-3-huangjunxian6@hisilicon.com>

On Tue, Oct 10, 2023 at 03:55:26PM +0800, Junxian Huang wrote:
> From: wenglianfa <wenglianfa@huawei.com>
> 
> Add support to dump SRQ resource in raw format.
> 
> This patch relies on the corresponding kernel commit aebf8145e11a
> ("RDMA/core: Add support to dump SRQ resource in RAW format")
> 
> Example:
> $ rdma res show srq -r
> dev hns3 149000...
> 
> $ rdma res show srq -j -r
> [{"ifindex":0,"ifname":"hns3","data":[149,0,0,...]}]
> 
> Signed-off-by: wenglianfa <wenglianfa@huawei.com>
> ---
>  rdma/res-srq.c | 20 ++++++++++++++++++--
>  rdma/res.h     |  2 ++
>  2 files changed, 20 insertions(+), 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

