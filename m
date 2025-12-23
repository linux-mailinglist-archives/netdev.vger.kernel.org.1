Return-Path: <netdev+bounces-245825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 169BFCD8BD0
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 11:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73F493074341
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 10:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A5C340A47;
	Tue, 23 Dec 2025 10:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oCy7WE21"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D9D33893E;
	Tue, 23 Dec 2025 10:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766484191; cv=none; b=E0Txa/fh53hCPzwcdLxz2O266kt3kddOM+n+WXTwegS1rcXwp4q/l2f7sVefi+2QzmI6WgvrfB+XVqLW7qR6hE08tbpobwJD0MFdBhntOSXV4rcXYyv1tKmcWrNWMpYu3TH0FXvcAqqkbwMt+XM/q5pocUzfmUpKn/yIbVmY0s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766484191; c=relaxed/simple;
	bh=U+tbKM4F+Du3elwL7/+bSqYSagS2tMs6YYP5KjJHgpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4iaxB/zxKs+JrwQjGJsRHjacRcbx/mDy839m6AHEJnwyAGr2OMhoqc6cE77uB/m81te5If939kUf0dByPG8lGbCMByMF09hgXnJxkZ3XRbSKrjQk+cFvuBoMCWZFDb1Bmmo8zReyLzk7ukwebb8SSbB34PfnjsfTb6TqGeLDEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oCy7WE21; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AQFDYWqSkDriuWAbN7InAfyNwsqwAPRnfhoRrmIYFKc=; b=oCy7WE21C1bdo4sF0tAANbR4Sv
	mCUh9rW51XPkefJyihI9ocBlqz/eLZZPj/vdp/8zjq9h1cFTRzVcp6MO3OcLYqMuVKb0YQzFMQv9H
	wUz4eFXVSqPgznljnurfg7nspu99Bf+XOIrQqc8PCOFQ8yTWTSSzqX1Vgl3FggonF0JU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vXzEJ-000HdJ-CK; Tue, 23 Dec 2025 11:02:59 +0100
Date: Tue, 23 Dec 2025 11:02:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com, netdev@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 net-next 01/15] net/nebula-matrix: add minimum nbl
 build framework
Message-ID: <b5c1c892-540b-495a-a138-781f12c3ddd7@lunn.ch>
References: <20251223035113.31122-1-illusion.wang@nebula-matrix.com>
 <20251223035113.31122-2-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223035113.31122-2-illusion.wang@nebula-matrix.com>

> @@ -27628,6 +27628,16 @@ F:	Documentation/networking/device_drivers/ethernet/wangxun/*
>  F:	drivers/net/ethernet/wangxun/
>  F:	drivers/net/pcs/pcs-xpcs-wx.c
>  
> +NEBULA-MATRIX ETHERNET DRIVER (nebula-matrix)
> +M:	Illusion.Wang <illusion.wang@nebula-matrix.com>
> +M:	Dimon.Zhao <dimon.zhao@nebula-matrix.com>
> +M:	Alvin.Wang <alvin.wang@nebula-matrix.com>
> +M:	Sam Chen <sam.chen@nebula-matrix.com>
> +L:	netdev@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/networking/device_drivers/ethernet/nebula-matrix/*
> +F:	drivers/net/ethernet/nebula-matrix/

This file is sorted, so please insert in the correct location.

> +
>  WATCHDOG DEVICE DRIVERS
>  M:	Wim Van Sebroeck <wim@linux-watchdog.org>
>  M:	Guenter Roeck <linux@roeck-us.net>
> diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
> index 4a1b368ca7e6..3995f75f1016 100644
> --- a/drivers/net/ethernet/Kconfig
> +++ b/drivers/net/ethernet/Kconfig
> @@ -204,5 +204,6 @@ source "drivers/net/ethernet/wangxun/Kconfig"
>  source "drivers/net/ethernet/wiznet/Kconfig"
>  source "drivers/net/ethernet/xilinx/Kconfig"
>  source "drivers/net/ethernet/xircom/Kconfig"
> +source "drivers/net/ethernet/nebula-matrix/Kconfig"

Also sorted.

>  
>  endif # ETHERNET
> diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
> index 2e18df8ca8ec..632dac9c4b75 100644
> --- a/drivers/net/ethernet/Makefile
> +++ b/drivers/net/ethernet/Makefile
> @@ -108,4 +108,5 @@ obj-$(CONFIG_NET_VENDOR_XILINX) += xilinx/
>  obj-$(CONFIG_NET_VENDOR_XIRCOM) += xircom/
>  obj-$(CONFIG_NET_VENDOR_SYNOPSYS) += synopsys/
>  obj-$(CONFIG_NET_VENDOR_PENSANDO) += pensando/
> +obj-$(CONFIG_NET_VENDOR_NEBULA_MATRIX) += nebula-matrix/

This is not strictly sorted, but mostly sorted. Please insert in the
correct location.

Sorting avoids merge conflicts when everybody adds to the end of the
file.

> +if NET_VENDOR_NEBULA_MATRIX
> +
> +config NBL_CORE

Why core? Is it shared by multiple other drivers?

> +#define NBL_CAP_SET_BIT(loc)			(1 << (loc))

Please don't re-implement existing functionality. Why are you not using BIT()?

> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h

Please include the needed headers in the .c file. A large proportion
of compile time is spent processing headers. So including headers you
don't actually need into every C file just slows down the build for
everybody.

> +#define NBL_DRIVER_VERSION				"25.11-1.16"

Driver versions are generally pointless, since they never change, but
the kernel around it is changing all the time.

> +
> +#define NBL_FLOW_INDEX_BYTE_LEN				8
> +
> +#define NBL_RATE_MBPS_100G				(100000)
> +#define NBL_RATE_MBPS_25G				(25000)
> +#define NBL_RATE_MBPS_10G				(10000)

Pointless ()

> +#define NBL_NEXT_ID(id, max)	({ typeof(id) _id = (id); ((_id) == (max) ? 0 : (_id) + 1); })
> +#define NBL_IPV6_U32LEN					4
> +
> +#define NBL_MAX_FUNC					(520)
> +#define NBL_MAX_MTU					15

You can only send 15 byte packets? Very odd hardware.

> +static int nbl_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *id)
> +{
> +	struct device *dev = &pdev->dev;
> +
> +	dev_info(dev, "nbl probe finished\n");

Please don't spam the log in the 'happy case'. dev_dbg(), or nothing
at all.


> +static int __maybe_unused nbl_suspend(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static int __maybe_unused nbl_resume(struct device *dev)
> +{
> +	return 0;
> +}

You should be able to add these when you add suspend/resume support.

> +static int __init nbl_module_init(void)
> +{
> +	int status;
> +
> +	status = pci_register_driver(&nbl_driver);

There are helpers for PCI drivers which should mean you don't need
this or nbl_module_exit().

    Andrew

---
pw-bot: cr

