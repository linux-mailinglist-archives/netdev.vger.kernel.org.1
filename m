Return-Path: <netdev+bounces-37628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E66337B662C
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 12:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 59B3DB20951
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 10:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC671D548;
	Tue,  3 Oct 2023 10:17:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4EAD50B
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 10:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B6FC433CC;
	Tue,  3 Oct 2023 10:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696328226;
	bh=BU1F0aZ2dBmGtP4Oin7uow9Zzh2Uzhr2vEEZr2qQ3u4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GRlQK/L9J913AV0+rRzNUGtWPbQU4fZqR0qWNtgENGKltG0MVlI4R7/BJocuvBUmW
	 NtryPYQaWUiusk4i8Hn0qBMsy/ryvIZ0H3NQfBaWg9i/2YljxX7f8OfdRtdkB39ccu
	 qEwzE+2sC6ZuO0++4Q5q2OyEd9fWzD4ej/1VHxYvNyi+m0LqsSQKQgANdTV5p69flw
	 qsNJMLNXmoXOVOA/uLZQH5y982djM5eHt5/xtP9Ya4DO3hfj1vuXumDPFQn5IxZGDT
	 /qB1ZvgxnRAqOJfDMo0khQtegvfvfLvcDIDqt+Yj+nS+EpxiI3XZM1XtQbumraoS51
	 aIMpeph+Oa8zg==
Date: Tue, 3 Oct 2023 13:17:01 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>, Jiri Pirko <jiri@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Patrisious Haddad <phaddad@nvidia.com>
Subject: Re: linux-next: manual merge of the mlx5-next tree with the net-next
 tree
Message-ID: <20231003101701.GB51282@unreal>
References: <20231003103712.5703b5e0@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003103712.5703b5e0@canb.auug.org.au>

On Tue, Oct 03, 2023 at 10:37:12AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the mlx5-next tree got a conflict in:
> 
>   include/linux/mlx5/device.h
> 
> between commit:
> 
>   ac5f395685bd ("net/mlx5: SF, Implement peer devlink set for SF representor devlink port")
> 
> from the net-next tree and commit:
> 
>   0d293714ac32 ("RDMA/mlx5: Send events from IB driver about device affiliation state")
> 
> from the mlx5-next tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc include/linux/mlx5/device.h
> index 8fbe22de16ef,26333d602a50..000000000000
> --- a/include/linux/mlx5/device.h
> +++ b/include/linux/mlx5/device.h
> @@@ -366,7 -366,8 +366,9 @@@ enum mlx5_driver_event 
>   	MLX5_DRIVER_EVENT_UPLINK_NETDEV,
>   	MLX5_DRIVER_EVENT_MACSEC_SA_ADDED,
>   	MLX5_DRIVER_EVENT_MACSEC_SA_DELETED,
>  +	MLX5_DRIVER_EVENT_SF_PEER_DEVLINK,
> + 	MLX5_DRIVER_EVENT_AFFILIATION_DONE,
> + 	MLX5_DRIVER_EVENT_AFFILIATION_REMOVED,
>   };

Thanks a lot

>   
>   enum {



