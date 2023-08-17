Return-Path: <netdev+bounces-28347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2422A77F1C2
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 10:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D047C281C50
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 08:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B95DDCC;
	Thu, 17 Aug 2023 08:04:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFB9DDC1
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 08:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3448C433C9;
	Thu, 17 Aug 2023 08:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692259479;
	bh=Cw0XQl3BaK0D6VfgszJfeoFplbc/dWb5o9/u6km+WLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SZxucbe8544jY2UCgx3oMPP8O2YVYaGWd6O8dEhqke6F9c+GZiUA8d5zXK3oeAwbt
	 XVMVZXPpaPm/yaZfw/+uoUeT7yCjUZ4122q1x67TST4AkLUwzqkgWPUcuOoTVKhAEQ
	 HmtDSo9aaFO666btxgfl97NXupnvU+C5a547yG//f6999AdVBNep1FCCzYfmM8ABhY
	 qSftvWTFORpkDUcg89x0TBZOgSBwMl2FNnVZfXzvkRanrXmW7g5CnMjMmkTQyDY2yK
	 xAyhZwz7tvDYyxlAnfLt0nB5Khfr65V0DnvdE6uwVO2l9ulFQsxONaq+Omj3+rzh6R
	 89BFHT0T9DXVg==
Date: Thu, 17 Aug 2023 11:04:34 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: Shyam-sundar.S-k@amd.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, yisen.zhuang@huawei.com,
	salil.mehta@huawei.com, iyappan@os.amperecomputing.com,
	keyur@os.amperecomputing.com, quan@os.amperecomputing.com,
	andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	yankejian@huawei.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] net: Fix return value check for
 get_phy_device()
Message-ID: <20230817080434.GF22185@unreal>
References: <20230817074000.355564-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817074000.355564-1-ruanjinjie@huawei.com>

On Thu, Aug 17, 2023 at 03:39:57PM +0800, Ruan Jinjie wrote:
> The get_phy_device() function returns error pointers and never
> returns NULL. Update the checks accordingly.
> 
> And get_phy_device() returns -EIO on bus access error and -ENOMEM
> on kzalloc failure in addition to -ENODEV, return PTR_ERR is more
> sensible.
> 
> Ruan Jinjie (3):
>   net: mdio: Fix return value check for get_phy_device()
>   amd-xgbe: Return proper error code for get_phy_device()
>   net: hisilicon: hns: Fix return value check for get_phy_device()
> 
>  drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c       | 2 +-
>  drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c | 4 ++--
>  drivers/net/mdio/mdio-xgene.c                     | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

