Return-Path: <netdev+bounces-28940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B59C781324
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 20:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAC282824C7
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BF91B7EE;
	Fri, 18 Aug 2023 18:57:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6D11B7C2
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 18:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD417C433C8;
	Fri, 18 Aug 2023 18:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692385025;
	bh=02rFAxq3m//7kkrEQ/HxMP0gDpzgenFl4cqjbTs89mU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rbWen395eNq5K6E1tqAjHx+lkHRq0KOaDVanSUjDAiC+UfrBgF9JxFjQe/WIs+nfE
	 EgyNahLrO8jgHWpKcdMHm3R5J9kojxEAt0p2eBIy6083g+ALHtej/fqQEXGuO64MhO
	 weZwiXGsR4uYlXCxzrYmBjSoJtLf6Id86Sv+kSwjncifTEL8fvotOOqyqwszUM8pco
	 gsperSxOlLX8LL+iBeueAR6YXnJFT5ykaWUcf307b4PR06NcYikXh2F4DM/brX0EPI
	 Xguj+jB5FV8aZLAGBWeSseL1hbxKX7MYny/SzkdeclvGSeTaxyQZQUo+PGqrOoFKaT
	 CMO7EbuqneMSQ==
Date: Fri, 18 Aug 2023 21:56:57 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: rafal@milecki.pl, bcm-kernel-feedback-list@broadcom.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, opendmb@gmail.com, florian.fainelli@broadcom.com,
	pgynther@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net v3 2/2] net: bcmgenet: Fix return value check for
 fixed_phy_register()
Message-ID: <20230818185657.GI22185@unreal>
References: <20230818051221.3634844-1-ruanjinjie@huawei.com>
 <20230818051221.3634844-3-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818051221.3634844-3-ruanjinjie@huawei.com>

On Fri, Aug 18, 2023 at 01:12:21PM +0800, Ruan Jinjie wrote:
> The fixed_phy_register() function returns error pointers and never
> returns NULL. Update the checks accordingly.
> 
> Fixes: b0ba512e25d7 ("net: bcmgenet: enable driver to work without a device tree")
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
> v3:
> - Split the err code update code into another patch set as suggested.
> v2:
> - Remove redundant NULL check and fix the return value.
> - Update the commit title and message.
> - Add the fix tag.
> ---
>  drivers/net/ethernet/broadcom/genet/bcmmii.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

