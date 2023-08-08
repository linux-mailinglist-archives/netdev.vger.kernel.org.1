Return-Path: <netdev+bounces-25511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3967F77468B
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E63B52819C4
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA15D154B1;
	Tue,  8 Aug 2023 18:58:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B978D15480
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:58:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FABC433C8;
	Tue,  8 Aug 2023 18:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691521081;
	bh=JpEp1q/5j145kEI+TKH57hGxoJcTj0+HrVYhtLQCxFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=agcNmbkZLw2KXR79UXP6iEWbQvgdNoSinUj3/5NClh9SMeknkcRhGYfexIeO08FxX
	 /gFggAfW0GwaeUQs2DLx3iyBFre53I9Hgm56Z+oLaE82GnNRdZfTso+lMBmnSKpgWR
	 bFO4rJ/ghuW040vYS95nD1y4d8GPeX/ZzuFbrB88+dykK1qO4ObadanLaGErIIDQF0
	 OK2KXvtYlKDeMLDny0IzvOAiO+YpV4LUaN1hKjeUXJlkkQe/VAVzDhEzwRPBC1KjmU
	 3oXQ7Ao2f8Ia1hM7yFUnRf0GQXdxUwSc1KzYsxTVw5PEC0fpFGeXD52TXL1C+/xxkX
	 tjY8B872wa1zA==
Date: Tue, 8 Aug 2023 21:57:54 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: tariqt@nvidia.com, yishaih@nvidia.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jgg@ziepe.ca, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 08/10] mlx4: Connect the ethernet part to the
 auxiliary bus
Message-ID: <20230808185754.GM94631@unreal>
References: <20230804150527.6117-1-petr.pavlu@suse.com>
 <20230804150527.6117-9-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804150527.6117-9-petr.pavlu@suse.com>

On Fri, Aug 04, 2023 at 05:05:25PM +0200, Petr Pavlu wrote:
> Use the auxiliary bus to perform device management of the ethernet part
> of the mlx4 driver.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> Tested-by: Leon Romanovsky <leon@kernel.org>
> ---
>  drivers/net/ethernet/mellanox/mlx4/en_main.c | 67 ++++++++++++++------
>  drivers/net/ethernet/mellanox/mlx4/intf.c    | 13 +++-
>  2 files changed, 59 insertions(+), 21 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

