Return-Path: <netdev+bounces-28261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E0C77ED16
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 00:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95EFB281B1A
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 22:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39DB1BF0F;
	Wed, 16 Aug 2023 22:30:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B107A1DA2A
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 22:30:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FEBC433C8;
	Wed, 16 Aug 2023 22:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692225003;
	bh=cI0wR0k/pE6mpn6vcPcsB8A+gD0Y69OMZw94nASdR/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FxM6RusMtyman576DD9+urb0FXEzE6v6cTZfAwlB42x6j/ZOcYWi5fcTdjpvCu3mC
	 HZ+XCZ6ydwoUg7vJBZzVr8/FzoNJpWYCjho9Cs8/IKx4tVQmU3Q3uji1gAKASla2TB
	 83dhzQv/iBGW4QIKoQg01ObadooEHIExXURWxfIfPnuGQujuwFcE0I/17U0apNcUld
	 x9Ek6IrMy5WmHMRFiB2SvyC2gL88dq9BSrEQzNy54FxOoXbEGMvb7Wi/GAp5Dw5OVs
	 HqWS+ZpiHQ8fNqbNojYoJMqtzRygmpTBczeWpHTOHhk4aQXqQ3AyYO2Xk4HPBcLZyG
	 na/6g/JlH5S3A==
Date: Wed, 16 Aug 2023 15:30:01 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, linux-rdma@vger.kernel.org,
	Maor Gottlieb <maorg@nvidia.com>, Mark Zhang <markzhang@nvidia.com>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Raed Salem <raeds@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [GIT PULL] Please pull mlx5 MACsec RoCEv2 support
Message-ID: <ZN1N6WOpHUkhQspA@x130>
References: <20230813064703.574082-1-leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230813064703.574082-1-leon@kernel.org>

On 13 Aug 09:47, Leon Romanovsky wrote:
>Hi,
>
>This PR is collected from https://lore.kernel.org/all/cover.1691569414.git.leon@kernel.org
>and contains patches to support mlx5 MACsec RoCEv2.
>
>It is based on -rc4 and such has minor conflict with net-next due to existance of IPsec packet offlosd
>in eswitch code and the resolution is to take both hunks.

Hi Jakub, 

Are you planing to pull this into net-next? 

There's a very minor conflict as described below and I a would like to
avoid this on merge window.

Thanks,
Saeed.


>
>diff --cc include/linux/mlx5/driver.h
>index 25d0528f9219,3ec8155c405d..000000000000
>--- a/include/linux/mlx5/driver.h
>+++ b/include/linux/mlx5/driver.h
>@@@ -805,6 -806,11 +805,14 @@@ struct mlx5_core_dev
>  	u32                      vsc_addr;
>  	struct mlx5_hv_vhca	*hv_vhca;
>  	struct mlx5_thermal	*thermal;
>+ 	u64			num_block_tc;
>+ 	u64			num_block_ipsec;
>+ #ifdef CONFIG_MLX5_MACSEC
>+ 	struct mlx5_macsec_fs *macsec_fs;
>+ #endif


