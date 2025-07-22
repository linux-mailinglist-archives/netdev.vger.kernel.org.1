Return-Path: <netdev+bounces-208771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BB6B0D065
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 05:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C9D91AA3A66
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 03:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60422576;
	Tue, 22 Jul 2025 03:38:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444B4272E6B
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 03:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753155538; cv=none; b=YkcThG40LEovJxl4rSt9hOyA9Dw/fSUMSB82mKOCz5z/DDo/LOuI9r4HH3smAwgGBGKhWiRXGI20YVMvYRoqwNTuZKu0bJropkmzpL6Oo3qRrR1mVMMDemAXr88l3R+RaY9+bY5lwF/TWWFZLcNjiQ0XnkIuGl9HIqIUUtJUrOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753155538; c=relaxed/simple;
	bh=CvelI9zXSMjW54GHbS7XiMPu4D8m9MuULB9676cVDHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpTniCPrOCMkXtD02fLXfLVis1dW/KfyBVsRh6mt7kWBAKDtVB3Q06oqMVUfv7P097dGTgojbmHJY2U9QtP6RwGpbot4qEOo3e79IWbrs3YDyJmRleAv3SIL3JbfQ5JD6x02kK5IzxbY+OLEVM/O9KTSGIqdT8q5/h+6BnyAarA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz11t1753155523t60719c4b
X-QQ-Originating-IP: rGKK2gBVdzPN5TgvQBUmot4Rr8VPOlaWYRddqIOqpEU=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Jul 2025 11:38:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8527283144807688706
Date: Tue, 22 Jul 2025 11:38:41 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/15] net: rnpgbe: Add build support for rnpgbe
Message-ID: <146B634370ED44A0+20250722033841.GB96891@nic-Precision-5820-Tower>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-2-dong100@mucse.com>
 <552cb3f0-bf17-449b-b113-02202127e650@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <552cb3f0-bf17-449b-b113-02202127e650@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M5fvx+1r+K0Qd0nHq6mDKwzdYYM5/zjn4UimkjJnum96ZHYMcad7v2Og
	80wW98cl9DHgcez7BDcgvXcaRjOe0Rd41vzpXy35APTLkCQDxBE+AM6Cy3KMx+u17I6SrNR
	17cLgW9Wp47sJoElOlz5u8cCrlrnigtjcGH7QWRUHG6fgILDTdEDSyXilmqXZcbphDbGydZ
	SigXXFnDhKYjIdRuSV3IvOiila5RAfIS1Dt4ny25yf8In+U0om7n0jfpJ6Wv1MazjBU8VkK
	1SEDXkmHxLhHb1edLR9dBBHGmeepnpfuqWn2SwMmoOhp0R4BKqazuMXr5v3TJFbtuMF67J8
	+gkV/5g1y6zlycgM7ks5virEgEnrH7cXhdhrC4f/eFUMw2AiokSs1+s5H8x9i3wsynVp0NM
	JQGsQo4UdwrxZo1fxKI5ND6PDm5uF7aLWWcpwd5nwZCT6Dqts+VbpfNbsntEccDM4g1hzhx
	c1gFKglZpqfOqkmrpHRz9ClkpGhMg+J4RdIQqYYyyAGYyWJyeM+c4wPwWXWMdO1Fdi4Lbaf
	NWK00vSqXNfkiWXfFSqJZIAH8Pob0W94TbVJVtEbuaNfLojSw6gfdzU1erRJ1HEvl+NwJ7+
	T1DUtqOl0yzUgoivAVdTh7pJw/C94ifmyQav+uzflPalyURGhvdr66v1zyhDRTetuMZuzRA
	RvJxpETFd/q760M7wJD9p3z9WsN+/o2WIGxEZTp3he7QEIZ9/NLZG/RFxYMUMfhgh+geDy8
	uG5XrrYDYNxEPMiMRScJw4ND4mgh2L8seWc0Lnb+tMopViYtf1s7lBbHCw3yLBE0VVnT+zV
	T0EbGNcNqZdsAseJP8q9Jk4xjZf3SJCYginsIiseR5fQsYWEv9v2p+gDlemnyarnACHd/nk
	VH0WMz4UuQpxMBNFWjQ7aMJ4uGwBR6s4kTIqspP4r2iPcOYASN5sczAs7wsDmwY94LGPfsc
	+NuA/lMbU9tEV41FQnAbm6kaZjbgBGveRRi8YkrbrJvuugrqO4oa974sfXQ27h3A81Vrcou
	cG4SSYcQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

On Mon, Jul 21, 2025 at 04:55:02PM +0200, Andrew Lunn wrote:
> > +++ b/Documentation/networking/device_drivers/ethernet/index.rst
> > @@ -61,6 +61,7 @@ Contents:
> >     wangxun/txgbevf
> >     wangxun/ngbe
> >     wangxun/ngbevf
> > +   mucse/rnpgbe
> 
> This list is sorted. Please keep with the order.
> 
> Sorting happens all other the kernel. Please keep an eye out of it,
> and ensure you insert into the correct location.
> 

Got it, I will fix this.

> > +++ b/drivers/net/ethernet/Kconfig
> > @@ -202,5 +202,6 @@ source "drivers/net/ethernet/wangxun/Kconfig"
> >  source "drivers/net/ethernet/wiznet/Kconfig"
> >  source "drivers/net/ethernet/xilinx/Kconfig"
> >  source "drivers/net/ethernet/xircom/Kconfig"
> > +source "drivers/net/ethernet/mucse/Kconfig"
> 
> Another sorted list.
> 

Got it.

> > +#include <linux/types.h>
> > +#include <linux/module.h>
> > +#include <linux/pci.h>
> > +#include <linux/netdevice.h>
> > +#include <linux/string.h>
> > +#include <linux/etherdevice.h>
> 
> It is also reasonably normal to sort includes.
> 

Got it, I will also check all other files. But what rules should be
followed? General to specific?

> > +static int rnpgbe_add_adapter(struct pci_dev *pdev)
> > +{
> > +	struct mucse *mucse = NULL;
> > +	struct net_device *netdev;
> > +	static int bd_number;
> > +
> > +	netdev = alloc_etherdev_mq(sizeof(struct mucse), 1);
> 
> If you only have one queue, you might as well use alloc_etherdev().
> 

Ok, I got it.

> > +	if (!netdev)
> > +		return -ENOMEM;
> > +
> > +	mucse = netdev_priv(netdev);
> > +	mucse->netdev = netdev;
> > +	mucse->pdev = pdev;
> > +	mucse->bd_number = bd_number++;
> > +	snprintf(mucse->name, sizeof(netdev->name), "%s%d",
> > +		 rnpgbe_driver_name, mucse->bd_number);
> 
> That looks wrong. The point of the n in snprintf is to stop you
> overwriting the end of the destination buffer. Hence you should be
> passing the length of the destination buffer, not the source buffer.
> 
> I've not looked at how mucse->name is used, but why do you need yet
> another name for the device? There is pdev->dev->name, and soon there
> will be netdev->name. Having yet another name just makes it confusing.
> 
> 	Andrew
> 

Yes, 'sizeof(netdev->name)' is wrong. Actually, mucse->name is not used,
I should remove it.

thanks for your feedback.



