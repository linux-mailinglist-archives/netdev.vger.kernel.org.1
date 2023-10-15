Return-Path: <netdev+bounces-41067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC757C9855
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 10:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FD8DB209F5
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 08:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035DA20F9;
	Sun, 15 Oct 2023 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/hTz3pV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D48185F
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 08:15:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B029EC433C8;
	Sun, 15 Oct 2023 08:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697357700;
	bh=Qy3H3n+ebGcSxm6wqtM0xJech7O0PnKT9MlWPvzGbPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o/hTz3pVaEgnklnkt43BnIuqemZvLp1juOTiNMV8lA5T8OsVbUh0mvQEnhWKd0kQk
	 8fxYul5QTFbWoWhBWU7svN2QS3GRz2kuRmGQmgsHp1mNPtX8skm/NASXhOwhC6DHbi
	 VemHIezE9Q2yftfyrmNOXay4I9dUCfJtiYxWObNJdcAi/mgpeTjZPiUY0H+WMXJQ5D
	 Ub0y9shnTpCOT0XOxTY1ldYUI0bPT3i4Q1a7yuf9aIynwxTCO4JM9pGWHTxHMqg8lZ
	 MNPtTQKlGJSNSmAKpuNM6geDH5sEVqCkFHewoZuSqB/nhzClJ40dy9wcBsOatEYbJ+
	 KOuJv7a0jpPow==
Date: Sun, 15 Oct 2023 11:14:55 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, dsahern@gmail.com, stephen@networkplumber.org,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linuxarm@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 iproute2-next 1/2] rdma: Update uapi headers
Message-ID: <20231015081455.GA25776@unreal>
References: <20231010075526.3860869-1-huangjunxian6@hisilicon.com>
 <20231010075526.3860869-2-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010075526.3860869-2-huangjunxian6@hisilicon.com>

On Tue, Oct 10, 2023 at 03:55:25PM +0800, Junxian Huang wrote:
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

