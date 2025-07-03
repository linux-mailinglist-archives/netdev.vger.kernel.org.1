Return-Path: <netdev+bounces-203880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4752AF7DBC
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 18:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3DC581F5D
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 16:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB70724C076;
	Thu,  3 Jul 2025 16:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qfuQz9I9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFE424C09E;
	Thu,  3 Jul 2025 16:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751559962; cv=none; b=B8g7G7muRyCbAP4sOT0wgHwbq519678DTBipd82EBoDYADBoxkasM1xNzjJ+SPhyyMmiQZ8mIaiS8XPBhFZxPB1kcukC2JI5yzzUe2vFKSlPivemOcEFwFyvGSrrkV1hhLKslMp2fcZEepZgakPzE1+C/wS3XDMiwhDNXafSEow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751559962; c=relaxed/simple;
	bh=QebVaURP5uWhfVmJTa2ANVbxyzaQ3bbX6YuMh/FiStU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uryOEcSqdNpwBZSyYJa49sY+7QFcLNkoNVj/vsbk0jLy716vra6XUvr4Mf5YObFyLh1YP53rPhY/euj+h4W5jZKn/z7bENgiRs5i/qqJOSBMW0LBLiJEiF1tcIKStwqo13U5Zwk5ZkT+dqyFzapWGU/e+6ZThqZPTm/ItLR4XCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qfuQz9I9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qnHNMB9Wfamba1Y4mNkWqdOlZbzxSMLmhoIZOCtejcY=; b=qfuQz9I9tdu+smZ2gd5rOAhiwq
	wFjbdh+nAEOUd4BEdVsi5KxZYYbKz0yxUDGD2JX9Wm2o5M/RmZaeZGJ379YwoEJldFY7Z6u9HF8Nc
	J7Ie0cUhJYCUEX7qbRI5CLtmWuq2S4eQG15GFb9cZlnlEPhrbfkL/ydo9iA5URW8ttgA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uXMkT-0007PZ-4b; Thu, 03 Jul 2025 18:25:21 +0200
Date: Thu, 3 Jul 2025 18:25:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dong Yibo <dong100@mucse.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	andrew+netdev@lunn.ch, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/15] net: rnpgbe: Add build support for rnpgbe
Message-ID: <0bf45c1a-96ec-4a9d-9c41-fcb3d366d6a3@lunn.ch>
References: <20250703014859.210110-1-dong100@mucse.com>
 <20250703014859.210110-2-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703014859.210110-2-dong100@mucse.com>

> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16001,11 +16001,7 @@ F:	tools/testing/vma/
>  
>  MEMORY MAPPING - LOCKING
>  M:	Andrew Morton <akpm@linux-foundation.org>
> -M:	Suren Baghdasaryan <surenb@google.com>
> -M:	Liam R. Howlett <Liam.Howlett@oracle.com>
> -M:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> -R:	Vlastimil Babka <vbabka@suse.cz>
> -R:	Shakeel Butt <shakeel.butt@linux.dev>
> +M:	Suren Baghdasaryan <surenb@google.com> M:	Liam R. Howlett <Liam.Howlett@oracle.com> M:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com> R:	Vlastimil Babka <vbabka@suse.cz> R:	Shakeel Butt <shakeel.butt@linux.dev>

You clearly have not reviewed your own patch, or you would not be
changing this section of the MAINTAINERs file.

> +if NET_VENDOR_MUCSE
> +
> +config MGBE
> +	tristate "Mucse(R) 1GbE PCI Express adapters support"
> +        depends on PCI
> +	select PAGE_POOL
> +        help
> +          This driver supports Mucse(R) 1GbE PCI Express family of
> +          adapters.
> +
> +	  More specific information on configuring the driver is in
> +	  <file:Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst>.
> +
> +          To compile this driver as a module, choose M here. The module
> +          will be called rnpgbe.

There is some odd indentation here.

> +#include <linux/string.h>
> +#include <linux/etherdevice.h>
> +
> +#include "rnpgbe.h"
> +
> +char rnpgbe_driver_name[] = "rnpgbe";
> +static const char rnpgbe_driver_string[] =
> +	"mucse 1 Gigabit PCI Express Network Driver";
> +#define DRV_VERSION "1.0.0"
> +const char rnpgbe_driver_version[] = DRV_VERSION;

Driver versions are pointless, since they never change, yet the kernel
around the driver changes all the time. Please drop.

> +static const char rnpgbe_copyright[] =
> +	"Copyright (c) 2020-2025 mucse Corporation.";

Why do you need this as a string?

> +static int rnpgbe_add_adpater(struct pci_dev *pdev)
> +{
> +	struct mucse *mucse = NULL;
> +	struct net_device *netdev;
> +	static int bd_number;
> +
> +	pr_info("====  add rnpgbe queues:%d ====", RNPGBE_MAX_QUEUES);

If you are still debugging this driver, please wait until it is mostly
bug free before submitting. I would not expect a production quality
driver to have prints like this.

> +	netdev = alloc_etherdev_mq(sizeof(struct mucse), RNPGBE_MAX_QUEUES);
> +	if (!netdev)
> +		return -ENOMEM;
> +
> +	mucse = netdev_priv(netdev);
> +	memset((char *)mucse, 0x00, sizeof(struct mucse));

priv is guaranteed to be zero'ed.

> +static void rnpgbe_shutdown(struct pci_dev *pdev)
> +{
> +	bool wake = false;
> +
> +	__rnpgbe_shutdown(pdev, &wake);

Please avoid using __ function names. Those are supposed to be
reserved for the compiler. Sometimes you will see single _ for
functions which have an unlocked version and a locked version.

> +static int __init rnpgbe_init_module(void)
> +{
> +	int ret;
> +
> +	pr_info("%s - version %s\n", rnpgbe_driver_string,
> +		rnpgbe_driver_version);
> +	pr_info("%s\n", rnpgbe_copyright);

Please don't spam the log. Only print something on error.

	Andrew

