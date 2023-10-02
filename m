Return-Path: <netdev+bounces-37374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 178CE7B5100
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 13:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C439C282A4A
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 11:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E101310A18;
	Mon,  2 Oct 2023 11:16:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D172FC2DF
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 11:16:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD45C433C7;
	Mon,  2 Oct 2023 11:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696245396;
	bh=YetwJyqXgZc4sFys8EJFoVJlHDAB5zSfeEgiVGM/8+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ugCf5hAV8WQEFP/wWhwSok2r728oHiw/DEkoHWhit9/Wi3Uqedtv220MRwe9CBC6X
	 KOWmWdCpndOCtPTQCDlAhASIXXw8CwTHPrUJ4LXmhC3keAIaDSdBFvvoMj2gYQUoSr
	 d1QeR8FJrG6YSgFFb+1QmwPFXkhnVYbv2UhCmZwOJhOo6CmuDeMom4cNdUTM6Ae3FD
	 Ulqh6GPKDi4Soc8VNj2hVR7nsMPzI0sWCzhvEcvS+2i1+/YkjTOi6jXC0LGExAteRT
	 Vbtnz2ImCxC3Hncyai61gYJD/W01TAuS+OXbQ0DmPZVwFwdSHocF/jlRt5kW4rT4Zv
	 flKL4w3ZvbXNA==
Date: Mon, 2 Oct 2023 14:16:31 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org, David Ahern <dsahern@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 0/2] rdma: Support dumping SRQ resource in raw format
Message-ID: <20231002111631.GD7059@unreal>
References: <20230928063202.1435527-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928063202.1435527-1-huangjunxian6@hisilicon.com>

On Thu, Sep 28, 2023 at 02:32:00PM +0800, Junxian Huang wrote:
> This patchset adds support to dump SRQ resource in raw format with
> rdmatool. The corresponding kernel commit is aebf8145e11a
> ("RDMA/core: Add support to dump SRQ resource in RAW format")
> 
> Junxian Huang (1):
>   rdma: Update uapi headers
> 
> wenglianfa (1):
>   rdma: Add support to dump SRQ resource in raw format
> 
>  rdma/include/uapi/rdma/rdma_netlink.h |  2 ++
>  rdma/res-srq.c                        | 17 ++++++++++++++++-
>  rdma/res.h                            |  2 ++
>  3 files changed, 20 insertions(+), 1 deletion(-)

rdmatool is part of iproute2 suite and as such To, Cc and Subject should
follow that suite rules. You need to add David to "TO", add Stephen and
netdev and add target (iproute2-next) for this patches.

See this randomly chosen series as an example.
https://lore.kernel.org/netdev/20211014075358.239708-1-markzhang@nvidia.com/

or latest one
https://lore.kernel.org/netdev/20231002104349.971927-1-tariqt@nvidia.com/T/#m7ef8e4ce275052d428b4f13ad9f3b41a4bf5d46b

Thanks

> 
> --
> 2.30.0
> 

