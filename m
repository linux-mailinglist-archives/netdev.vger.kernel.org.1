Return-Path: <netdev+bounces-20683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 660DB7609B3
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 07:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E9C1C20DD5
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 05:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A518BE5;
	Tue, 25 Jul 2023 05:47:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AFC186F
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 05:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546E1C433C7;
	Tue, 25 Jul 2023 05:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690264074;
	bh=2ca9JplLXij4jA9NIpNDNheHd1cWOBerRKQ46qKuQrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QKno2qrXd33o/1tfIB9PkikcvEm1HDORPf/3Y5ePAOW4f+SyNI4tZPEIkYQkTPC2v
	 p3mWuH7BcuSYEhCu+hE0dBSnV6zoyct6uRi1r9mwnucpgbYfcHLQOlJ3GuwcbHQcxL
	 5OJlVtKlxuGeDYFQySZ7Jw4TWXrQyx1pkKIeDo3ajbPfkj+MZRmY6NE9rbbUt2nBZ9
	 4Y1VLhApzMboGvbYGIiNwvWXJNX3awEpMqdGCJxPOFM/Wxjd2usX4wivNXKyRJ0zIN
	 jdCL1QuwSLMADUbXgHY28nnsv8Hd1BNu4ZA2D8OTRqJLea5XLqjGleHUQx5e+AW7dV
	 2UrNu12T6yffw==
Date: Tue, 25 Jul 2023 08:47:49 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] net/mlx4: clean up a type issue
Message-ID: <20230725054749.GL11388@unreal>
References: <52d0814a-7287-4160-94b5-ac7939ac61c6@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52d0814a-7287-4160-94b5-ac7939ac61c6@moroto.mountain>

On Tue, Jul 25, 2023 at 08:39:47AM +0300, Dan Carpenter wrote:
> These functions returns type bool, not pointers, so return false instead
> of NULL.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> Not a bug.  Targetting net-next.
> 
>  drivers/net/ethernet/mellanox/mlx4/mcg.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

