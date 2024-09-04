Return-Path: <netdev+bounces-125291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 684B296CAD3
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 01:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ED51B24757
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 23:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2ACA16EC19;
	Wed,  4 Sep 2024 23:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfcNiSUl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD62A14D2A7
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 23:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725492956; cv=none; b=a33Fas7dIr9/nqS/aCdqPMVGafjTEJCVXDj+tYEuhh1rClktmd+kBkh30zFTQrOyYjk3OkAr7qVJWrfsa6HR0y71rmv8FuIJYsk0kKIu0z8dsnVZTzDVkiH3PxzZyCgO0nMrDywF/dfi8+ZsfJ7HXElvUGfYmm/mYdTSmt33f1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725492956; c=relaxed/simple;
	bh=MSG5HZkPsg7WjUGAJwN10gVMCaWuUs47JL8O3h+tiuI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ya1l4O93BoVTQjhHKScY10k0cIyQyYpeVe7dSk4fckzzpe6u8XG+5uTM+RClyP3992GmtcffdoXczSMRHm8hERLX6IScE3xMHeJANQZ5ZDlyjIJMHL6PcPxFCLrlQH6LvQllgiQvuLQW08M3mnadJ/7jp/R/9QXCFJ+KJC1qGK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfcNiSUl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C8AC4CEC2;
	Wed,  4 Sep 2024 23:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725492956;
	bh=MSG5HZkPsg7WjUGAJwN10gVMCaWuUs47JL8O3h+tiuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AfcNiSUlJ+LuqSV1x7azpun5BHIB/oOOvlOn1KGHY2LpoTcDpPvfdJLLDXJJ+9hRn
	 D/g5ZU562gCEXhvjPIKOsSPVDLGd202h5rDPyPRVLkTw91JF3M0PhszSmYsSL4br1g
	 ZnHAO1y+z5C9nqbBr3e+T46+gS/slxScjrvzuJjRLAP9PdpD86RF+P9gvZQDbnuMcC
	 DvH/rjsUOjAIXPp69VeDraAMoMMOqVCIZWXhUF2qBzObR31LNYZUZcT0y6i2B9tSc2
	 N+me8Xz8uWj4t9DzyfKXvexvS7Xo1X5sUq8r1nGOM+2ZWwnTYpcCn5V8vlJ5RiEIMG
	 GSZVw0+ifq59Q==
Date: Wed, 4 Sep 2024 16:35:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zhang Zekun <zhangzekun11@huawei.com>
Cc: <jiawenwu@trustnetic.com>, <mengyuanlou@net-swift.com>,
 <avem@davemloft.net>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: txgbe: Simplify code with pci_dev_id()
Message-ID: <20240904163555.7a8812e9@kernel.org>
In-Reply-To: <20240903072301.117767-1-zhangzekun11@huawei.com>
References: <20240903072301.117767-1-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Sep 2024 15:23:01 +0800 Zhang Zekun wrote:
> Use pci_dev_id() to get the BDF number of a pci device, and we don't
> calculate it manually. This can simplify the code a bit.
> 
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
> ---
>  drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> index 5f502265f0a6..e8e293b1dd61 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> @@ -689,7 +689,7 @@ static int txgbe_ext_phy_init(struct txgbe *txgbe)
>  	mii_bus->phy_mask = GENMASK(31, 1);
>  	mii_bus->priv = wx;
>  	snprintf(mii_bus->id, MII_BUS_ID_SIZE, "txgbe-%x",
> -		 (pdev->bus->number << 8) | pdev->devfn);
> +		 pci_dev_id(pdev));
>  
>  	ret = devm_mdiobus_register(&pdev->dev, mii_bus);
>  	if (ret) {

Already done and slightly more cleanly in d76867efebcb20752345
by who I presume is your coworker.

