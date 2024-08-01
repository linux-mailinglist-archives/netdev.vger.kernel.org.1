Return-Path: <netdev+bounces-114770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB9B943FEF
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 03:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF691C21FE9
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 01:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE415338D;
	Thu,  1 Aug 2024 01:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Qhpd+P5f"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25B71514DC;
	Thu,  1 Aug 2024 01:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722474823; cv=none; b=HzST3KEVyIoIkRyOXX149pofXOneNYIQF0aSrsaTsrk3OXlmMjhs7IHwMQCHBH2iavgJDi3FJ0ou7HJKZaoPMUDM+BHAufxeMWk96oU0+rBSbVpmKbPdQQAasOa1begbBD0w1+9NS/D+/OZFpWKvR71ynoqrISG5iz3THKFp56M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722474823; c=relaxed/simple;
	bh=Sc2L9FmvJUOj/vSm51/hIH353apQq4db3uUU3zSvBoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4jpmx03KZOioLDwR2BcGjpxb4/rDJy1oVINZktbMNcX5NiymobIHB/CtCV8bZV8DSXzoNfxhGM1QoKhIO4eBTifP/Oxvs0NmeZ+9jW0xXT82YBJmJ8Pe4AEIuaOqD50KCycvP45h9yIQq/DIVTr2tzKYcaX+WYRxxXeq5lYcC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Qhpd+P5f; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ARbD44MpDD7+Kxfy/q9fBBwtFNS3dL+GrbSVVXS2AZk=; b=Qhpd+P5fQcY31LHSHXYzaW91Uc
	m9Mv05nw4KQWw2Zyg9LTsURDIfPcWgqg6Yx5vAIt8IW3TaR+Idp/T6ABgFC1ffrmMZPloZ5ni3wic
	cQTdU8Yaj/+hSEfweQNKGSJ7RQb8rLLk3WIQNZFJ8oB27eWQfKQc88VJe16KxwcEMI1E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sZKNn-003j4O-QP; Thu, 01 Aug 2024 03:13:31 +0200
Date: Thu, 1 Aug 2024 03:13:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, sudongming1@huawei.com,
	xujunsheng@huawei.com, shiyongbang@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 09/10] net: hibmcge: Add a Makefile and
 update Kconfig for hibmcge
Message-ID: <49d41bc0-7a9e-4d2a-93c7-4e2bcb6d6987@lunn.ch>
References: <20240731094245.1967834-1-shaojijie@huawei.com>
 <20240731094245.1967834-10-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731094245.1967834-10-shaojijie@huawei.com>

On Wed, Jul 31, 2024 at 05:42:44PM +0800, Jijie Shao wrote:
> Add a Makefile and update Kconfig to build hibmcge driver.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  drivers/net/ethernet/hisilicon/Kconfig          | 17 ++++++++++++++++-
>  drivers/net/ethernet/hisilicon/Makefile         |  1 +
>  drivers/net/ethernet/hisilicon/hibmcge/Makefile | 10 ++++++++++
>  3 files changed, 27 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/Makefile
> 
> diff --git a/drivers/net/ethernet/hisilicon/Kconfig b/drivers/net/ethernet/hisilicon/Kconfig
> index 3312e1d93c3b..372854d15481 100644
> --- a/drivers/net/ethernet/hisilicon/Kconfig
> +++ b/drivers/net/ethernet/hisilicon/Kconfig
> @@ -7,7 +7,7 @@ config NET_VENDOR_HISILICON
>  	bool "Hisilicon devices"
>  	default y
>  	depends on OF || ACPI
> -	depends on ARM || ARM64 || COMPILE_TEST
> +	depends on ARM || ARM64 || COMPILE_TEST || X86_64

It is normal to have COMPILE_TEST last.

Any reason this won't work on S390, PowerPC etc?

> +if ARM || ARM64 || COMPILE_TEST
> +

You would normally express this with a depends on.

	Andrew

