Return-Path: <netdev+bounces-28939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC30781323
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 20:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 500B91C210A7
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F271B7E4;
	Fri, 18 Aug 2023 18:56:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D3C1B7E7
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 18:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C0FC433C7;
	Fri, 18 Aug 2023 18:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692385001;
	bh=qYe/f9Mr0sh3fGaKQnKLua3hro4AYCmL1Dd+xlaHDXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=obGtvy8AIxx9BfUVTVYRsZrl8CJtuYlurJJfJLfjjQWVqFwRcdR5aSE8BwNFpnVNI
	 Fc2CyvhUsVYr5aKGKPpynFM6bCpiLvM0NTuKzZt6kWI6/JCB2Wvy7N+wEkETBVjLcG
	 3z5WKkrGTzaMyk/axMY3iWxCA0PmZGaoYrd4K0v1Dk/JCi08xJ58tNd8lqEKcTAXiO
	 /wepb9rtGIhuC8SjWZJ6no7dYbHzrpKRjlifi1Tdl+oQoSNLr+oFm/KwiFSvmrTd4V
	 bNMDJ3ZTPeWA2Jkgp3tjibJjTnB1Kjx6TyAQIS6h6vzJDdCkXKQwK2Hbh82zlj/OAj
	 y1zRFadlKY7Kg==
Date: Fri, 18 Aug 2023 21:56:33 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: horatiu.vultur@microchip.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, lars.povlsen@microchip.com,
	Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
	richardcochran@gmail.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2 3/3] net: microchip: sparx5: Update return
 value check for vcap_get_rule()
Message-ID: <20230818185633.GH22185@unreal>
References: <20230818050505.3634668-1-ruanjinjie@huawei.com>
 <20230818050505.3634668-4-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818050505.3634668-4-ruanjinjie@huawei.com>

On Fri, Aug 18, 2023 at 01:05:05PM +0800, Ruan Jinjie wrote:
> As Simon Horman suggests, update vcap_get_rule() to always
> return an ERR_PTR() and update the error detection conditions to
> use IS_ERR(), so use IS_ERR() to check the return value.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> Suggested-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

