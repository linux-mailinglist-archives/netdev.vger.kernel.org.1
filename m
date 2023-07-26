Return-Path: <netdev+bounces-21340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BF9763577
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 13:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 364B51C2121E
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 11:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7501A935;
	Wed, 26 Jul 2023 11:42:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7775DBA30
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 11:41:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632ECC433C8;
	Wed, 26 Jul 2023 11:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690371718;
	bh=exhq4U2IdbwszONqSYwEUK7cbNGuFjDmaNPZyLdXnNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PoJqhY2ypW2D2VfIQmaErMhLAGUeXj5TAlsctkGNXx3DU90VXqASZJbFsg2n1vuyk
	 HuXMonI08pnEol+fQkKvxpctYVOE3RoPijnCClHn5+dIkn6z4hbwA6Jm6yfFSl+kN+
	 uLse6e4N90HTm0i+7OMde+xLfvvZdH+NYlU1fm1Xqheqp8VYHf7GQwO4GpgAd7kv83
	 4fkkWLESTDHLkVnp4vyMswWSkUP49vpXON7ylKzsS1YbpXTipBWnthLjPQi49ti6eS
	 uK1dDbWaivhmS7yu452XGhsiB539997PFA/kEEhl+eMkpKvabLt3146Ojwaj9fKIxA
	 cJsFkAnXVWdFw==
Date: Wed, 26 Jul 2023 14:41:53 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Yuanjun Gong <ruc_gongyuanjun@163.com>
Cc: borisp@nvidia.com, netdev@vger.kernel.org, saeedm@nvidia.com
Subject: Re: [PATCH net v2 1/1] net/mlx5e: fix return value check in
 mlx5e_ipsec_remove_trailer()
Message-ID: <20230726114153.GT11388@unreal>
References: <20230717185533.GA8808@unreal>
 <20230725065655.6964-1-ruc_gongyuanjun@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725065655.6964-1-ruc_gongyuanjun@163.com>

On Tue, Jul 25, 2023 at 02:56:55PM +0800, Yuanjun Gong wrote:
> mlx5e_ipsec_remove_trailer() should return an error code if function
> pskb_trim() returns an unexpected value.
> 
> Fixes: 2ac9cfe78223 ("net/mlx5e: IPSec, Add Innova IPSec offload TX data path")
> Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

