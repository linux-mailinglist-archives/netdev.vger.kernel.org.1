Return-Path: <netdev+bounces-38993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B63A7BD581
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 10:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BD751C208DE
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 08:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6000800;
	Mon,  9 Oct 2023 08:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgtUSwKO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846DD1C2B
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 08:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF20C433C8;
	Mon,  9 Oct 2023 08:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696841094;
	bh=BdiL0ogG95EcNukp4NUdQg+5yQVYpVSwTkw1zXb/ZuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MgtUSwKOHf6TKRBuu0opli+JsD3UFrN+Q2EmS2TfaJ/M8Atn3BboGdFVKOLjg0nTf
	 m5Q9RhJ3odC8Vx2Vs0zggxNsUzbgvca8Ilc3VHibJsWqEGrbRmiPRCxP3k8DqKNuiQ
	 v5nSgUhAZEUw2R0BjL16xjNR8A9qc3GZ12dBfEBrIhp+cJ45vBF+84Keiba6t/R5st
	 tJuRseTQ67JJcGjDNGEGdv7JpqHuhYTzxNQzsxxsf0WUYA2FqgkQh61V/U5aHR3QNV
	 eM6Lye8/CwwSyZB+Sn9/mTVMpX5d7qYHiGw6HlVgN6NGpeaoA5SLLJXCHEQdpzg2K4
	 q29FSnErYRWgQ==
Date: Mon, 9 Oct 2023 11:44:49 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, dsahern@gmail.com, stephen@networkplumber.org,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linuxarm@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH iproute2-next 1/2] rdma: Update uapi headers
Message-ID: <20231009084449.GD5042@unreal>
References: <20231007035855.2273364-1-huangjunxian6@hisilicon.com>
 <20231007035855.2273364-2-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007035855.2273364-2-huangjunxian6@hisilicon.com>

On Sat, Oct 07, 2023 at 11:58:54AM +0800, Junxian Huang wrote:
> Update rdma_netlink.h file upto kernel commit aebf8145e11a
> ("RDMA/core: Add support to dump SRQ resource in RAW format")
> 
> Signed-off-by: wenglianfa <wenglianfa@huawei.com>
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
>  rdma/include/uapi/rdma/rdma_netlink.h | 2 ++
>  1 file changed, 2 insertions(+)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

