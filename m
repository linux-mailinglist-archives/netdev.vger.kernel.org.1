Return-Path: <netdev+bounces-203959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD7BAF8577
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 04:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D421582628
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 02:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141551A4E9E;
	Fri,  4 Jul 2025 02:12:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CF0CA5E;
	Fri,  4 Jul 2025 02:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751595148; cv=none; b=Mk6sNgW6pswyRhvThhe8gtMj+qyzwV2nG4Ovm37HphwTvGxSSSx5ffBpWoxYsgUxv5V/O4XrYVo52HC0ujo5gEXEg1zYrDgVSgfhLYkG4Mx/1ZR86YK4Dn/cp+z4OIeYiYEsw9oulCMAGiRk/80Lbq9G830Rd8XTNr6FFTiQwsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751595148; c=relaxed/simple;
	bh=l5Z1XwVZK0CEsUxeMWRLgj/aKkruRmu8OfSCitscVSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpEF0H1p3AuQ2wmz+VIkpU8f//k29oQ3HLlmp0DGBwp9mGoHg/RJM3N+vL5WfJeYz81cG74LdZoqJuDnnhDKaEL+aIGfPnIVK99UYnBYcj9uFlKDpq38oIJpB75oNuV3k6r47iy1O97kXKrz6LCD4idm7S7nQ3zNDgx4prvOYrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz16t1751595038t1e63eead
X-QQ-Originating-IP: 5wwB7UPN9ZXhl6owE/sV1BbjFqm1YCytAG48UIsJwzQ=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 04 Jul 2025 10:10:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17059888424814569184
Date: Fri, 4 Jul 2025 10:10:36 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	andrew+netdev@lunn.ch, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/15] net: rnpgbe: Add build support for rnpgbe
Message-ID: <CD062DF313EAF6E1+20250704021036.GA26457@nic-Precision-5820-Tower>
References: <20250703014859.210110-1-dong100@mucse.com>
 <20250703014859.210110-2-dong100@mucse.com>
 <0bf45c1a-96ec-4a9d-9c41-fcb3d366d6a3@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bf45c1a-96ec-4a9d-9c41-fcb3d366d6a3@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: ODc4ukgihQJXBomECV5UpbB47HfVKGz7fBqteSWzVrczpndUMTabIMlg
	ORwsIse+5JzL3y9rLpNGsa5ad96nWxoKJisun/7gshcRZIhf4KPlF7I7pjQeXZEo70TYlsr
	F0Wxex7mzmX64hYu/vr5JT1Jt0A18suxsGBKYfvafcGIHSQqCYdTT5wNGAj9CMYcJ+S4yPX
	4lRZ0BWzIupFEWcCHP/gyj6E2Ypdmx/u9zZsweutfHn0gU9/XjmIlW1WXZvtaUF0xC/1cAB
	PVujCIUKODqww41/paULST4kPSWoZm6sSO0bJOAYIZ5BiGz7Hc9o0mQoBa+pkN8AAY7Ihvy
	l6aFXCFqgmcWlywxJm8GfE+e7+TwzcA+312cHxfD/ss7pPB4RHx9S9HWw17wB9PsS/VWuVW
	Q/vA1AW+H1ScO/zkfwknNo/Sl24PwdFgfVkfTlDpcnk8XOp+AVplLW3gC2ylv1GmktQhYUT
	wahmKSa68sfpx7w2Qbx8twKvpwVLJWacDZBe47tpwJcAx03mlW/DYsKiEF+X3jfKtGXXjlr
	Ggx1SVqDMNCzb10C+7weRUOGcuCEHCO49JdRCJt+PSu00NUVQfSVLOusHuNwrljdV18ABU2
	nWZ2vA3GRDqiblDpB1kJ66A8JLTrYfn29rSfDvBjKsI1htAxDDSv2v2fUamUnsF5J4wXqAm
	SV0qI9Z4tpZFsOsMgFbBhRPXEIiH2M18xYYjki5IfWEhRZfCWasidxRihI8sVl4jd3m+3/D
	0zWpOrpV4xrXsdqR8fhFftM/D9F+jCltoXnftJLIJPA1a2aw20GPBCCyMtP5AtQZNmZRXo2
	ZNhydnA4Cba6hqlmfo0j5tMBTtSMi/Y831+Q+riGohLCPf4l1MgVugEgIlvt2ZRhopHJoZB
	3QLK3XoRKIhg9cU1LbV4G0t0jezjGLvK4jIbGH9j2AhXR+mOdO43EncJpg5ykn0PB1tZ253
	oNa2Oc2rsNPtit7rrgfA1ncWAbiAqCjVWruA6wrNZ27PyoDOolkn6hprIOmYlIil+RSJu9m
	YbzcG/7DMMTopirsKQBMIwcts+nzxVuUUGEVEcxK8omJCUe/ZDGTgRn4RLLVc=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

On Thu, Jul 03, 2025 at 06:25:21PM +0200, Andrew Lunn wrote:
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -16001,11 +16001,7 @@ F:	tools/testing/vma/
> >  
> >  MEMORY MAPPING - LOCKING
> >  M:	Andrew Morton <akpm@linux-foundation.org>
> > -M:	Suren Baghdasaryan <surenb@google.com>
> > -M:	Liam R. Howlett <Liam.Howlett@oracle.com>
> > -M:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > -R:	Vlastimil Babka <vbabka@suse.cz>
> > -R:	Shakeel Butt <shakeel.butt@linux.dev>
> > +M:	Suren Baghdasaryan <surenb@google.com> M:	Liam R. Howlett <Liam.Howlett@oracle.com> M:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com> R:	Vlastimil Babka <vbabka@suse.cz> R:	Shakeel Butt <shakeel.butt@linux.dev>
> 
> You clearly have not reviewed your own patch, or you would not be
> changing this section of the MAINTAINERs file.
> 
Sorry, I didn't review it carefully. I will correct this error and
review all the remaining patches.
> > +if NET_VENDOR_MUCSE
> > +
> > +config MGBE
> > +	tristate "Mucse(R) 1GbE PCI Express adapters support"
> > +        depends on PCI
> > +	select PAGE_POOL
> > +        help
> > +          This driver supports Mucse(R) 1GbE PCI Express family of
> > +          adapters.
> > +
> > +	  More specific information on configuring the driver is in
> > +	  <file:Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst>.
> > +
> > +          To compile this driver as a module, choose M here. The module
> > +          will be called rnpgbe.
> 
> There is some odd indentation here.
> 
I will correct this in v1.
> > +#include <linux/string.h>
> > +#include <linux/etherdevice.h>
> > +
> > +#include "rnpgbe.h"
> > +
> > +char rnpgbe_driver_name[] = "rnpgbe";
> > +static const char rnpgbe_driver_string[] =
> > +	"mucse 1 Gigabit PCI Express Network Driver";
> > +#define DRV_VERSION "1.0.0"
> > +const char rnpgbe_driver_version[] = DRV_VERSION;
> 
> Driver versions are pointless, since they never change, yet the kernel
> around the driver changes all the time. Please drop.
> 
OK, I got it.
> > +static const char rnpgbe_copyright[] =
> > +	"Copyright (c) 2020-2025 mucse Corporation.";
> 
> Why do you need this as a string?
> 
I printed this in 'pr_info' before. Of course, I should remove this belong
with 'pr_info'.
> > +static int rnpgbe_add_adpater(struct pci_dev *pdev)
> > +{
> > +	struct mucse *mucse = NULL;
> > +	struct net_device *netdev;
> > +	static int bd_number;
> > +
> > +	pr_info("====  add rnpgbe queues:%d ====", RNPGBE_MAX_QUEUES);
> 
> If you are still debugging this driver, please wait until it is mostly
> bug free before submitting. I would not expect a production quality
> driver to have prints like this.
> 
Got it, I will remove 'pr_info'.
> > +	netdev = alloc_etherdev_mq(sizeof(struct mucse), RNPGBE_MAX_QUEUES);
> > +	if (!netdev)
> > +		return -ENOMEM;
> > +
> > +	mucse = netdev_priv(netdev);
> > +	memset((char *)mucse, 0x00, sizeof(struct mucse));
> 
> priv is guaranteed to be zero'ed.
> 
I will remove 'memset' here.
> > +static void rnpgbe_shutdown(struct pci_dev *pdev)
> > +{
> > +	bool wake = false;
> > +
> > +	__rnpgbe_shutdown(pdev, &wake);
> 
> Please avoid using __ function names. Those are supposed to be
> reserved for the compiler. Sometimes you will see single _ for
> functions which have an unlocked version and a locked version.
> 
Got it, I will fix this.
> > +static int __init rnpgbe_init_module(void)
> > +{
> > +	int ret;
> > +
> > +	pr_info("%s - version %s\n", rnpgbe_driver_string,
> > +		rnpgbe_driver_version);
> > +	pr_info("%s\n", rnpgbe_copyright);
> 
> Please don't spam the log. Only print something on error.
> 
> 	Andrew
> 
I will remove the log, thanks for your feedback.

