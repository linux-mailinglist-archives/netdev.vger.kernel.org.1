Return-Path: <netdev+bounces-248909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C8CD10FAC
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 08:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AA92304F2CC
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 07:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4FC33987E;
	Mon, 12 Jan 2026 07:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="dekvvaUB"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2487E3382E8;
	Mon, 12 Jan 2026 07:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768204362; cv=pass; b=rNPH658rS8k7hGKMYPVyBPMcsUZQXi6dfeHXj5nCzt0iSaRxWwa305gjmpPVozO11SadNcJA+PIjJ/6kY+0fes0bIENAk4dQfv+8ge1SU1yfNif9bCllA8XCWe9+23q2s4Q/3b9spDGk/KdeRBm5RiBCdRIrVzora+kSVmOcHvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768204362; c=relaxed/simple;
	bh=jVHTsvL19Y7PhfTK1gHG53kuijo2TcrJJ98gw03bqF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsgcG7guXXiNsdDKCo2ejDgHrtVkiN9APBA4Ratkg2aPssr5CKTSlraM4cfI62z1x9+WykNvpTLYV3hyfjj+X5C0U1x5pJoquUivSkebX8SZ5UqTH2bljX+23gJ05/TDIB1nZL9WAaYbOL+liRjKEZ6kcP33hdXVY+twdF7hLyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=dekvvaUB; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1768204310; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Y4FPmIjlPWYrGO7vwM1RZ0pKDsXtt5Y7NHbBHcaSZDD3EDcNX0pDwstqLj2iuCROOMjx5QQzfpNp/lx2IlrlaSGVfW6nC3oYIzxPcdLdLuCLi39rIPf6sbvxtTLWJgmr2JeWopw4ObXk1/U09WMGUpQN7kL1CUphwdPKzwdKpek=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768204310; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/U1whJfeIeOAez4jVNR+GpdMr1BCrwk6CMiD5RunnZM=; 
	b=PRKuoGv8BgOPAxLpwSNCBmXV6jz5374XgBPDboMP5K9ZEgn6//Raj/qUSxvd7PBoE4iyoIB2c1zKoxCMZQHORnhFEm23QsDGDKuQhKG7KK4Zthpv2HO0S3YBPyu7/YKYaxQAQCi2ouPZJemFwesGmzJEO+d3qXOnSjKGHdxpxME=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768204310;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=/U1whJfeIeOAez4jVNR+GpdMr1BCrwk6CMiD5RunnZM=;
	b=dekvvaUBPwTsJAwzP0nfZDxZGgy9ZZ6Ht0V+meJBUNp1ZY/pQE9dMxvmAJrtRa5p
	dnyJ3fgTrRT2uZhSSmGTvhqFxQDnAYhTIc1mObOsPtZUtgoq/wfDBkmVjAaNQ0kX+np
	51go6uolxKcjksfe0N5w6F3U7xgsUbIrNzvnQaaY=
Received: by mx.zohomail.com with SMTPS id 1768204305759488.36230350277333;
	Sun, 11 Jan 2026 23:51:45 -0800 (PST)
Date: Mon, 12 Jan 2026 07:51:35 +0000
From: Yao Zi <me@ziyao.cc>
To: Sai Krishna Gajula <saikrishnag@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Chen-Yu Tsai <wens@csie.org>, Jisheng Zhang <jszhang@kernel.org>,
	Furong Xu <0x1207@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>,
	Runhua He <hua@aosc.io>, Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH RESEND net-next v6 2/3] net: stmmac: Add glue driver for
 Motorcomm YT6801 ethernet controller
Message-ID: <aWSoBzEBUVj-RblG@pie>
References: <20260109093445.46791-2-me@ziyao.cc>
 <20260109093445.46791-4-me@ziyao.cc>
 <BYAPR18MB3735FED933ED0F7536C07A59A081A@BYAPR18MB3735.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR18MB3735FED933ED0F7536C07A59A081A@BYAPR18MB3735.namprd18.prod.outlook.com>
X-ZohoMailClient: External

On Mon, Jan 12, 2026 at 06:10:26AM +0000, Sai Krishna Gajula wrote:
> 
> 
> > -----Original Message-----
> > From: Yao Zi <me@ziyao.cc>
> > Sent: Friday, January 9, 2026 3:05 PM
> > To: Andrew Lunn <andrew+netdev@lunn.ch>; David S. Miller
> > <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> > Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Frank
> > <Frank.Sae@motor-comm.com>; Heiner Kallweit <hkallweit1@gmail.com>;
> > Russell King <linux@armlinux.org.uk>; Russell King (Oracle)
> > <rmk+kernel@armlinux.org.uk>; Vladimir Oltean
> > <vladimir.oltean@nxp.com>; Chen-Yu Tsai <wens@csie.org>; Jisheng Zhang
> > <jszhang@kernel.org>; Furong Xu <0x1207@gmail.com>
> > Cc: linux-kernel@vger.kernel.org; netdev@vger.kernel.org; Mingcong Bai
> > <jeffbai@aosc.io>; Kexy Biscuit <kexybiscuit@aosc.io>; Yao Zi <me@ziyao.cc>;
> > Runhua He <hua@aosc.io>; Xi Ruoyao <xry111@xry111.site>
> > Subject: [PATCH RESEND net-next v6 2/3] net: stmmac: Add glue
> > driver for Motorcomm YT6801 ethernet controller
> > 
> > Motorcomm YT6801 is a PCIe ethernet controller based on DWMAC4 IP. It
> > integrates an GbE phy, supporting WOL, VLAN tagging and various types of
> > offloading. It ships an on-chip eFuse for storing various vendor configuration,
> > including MAC address.
> > Motorcomm YT6801 is a PCIe ethernet controller based on DWMAC4 IP. It
> > integrates an GbE phy, supporting WOL, VLAN tagging and various types of
> > offloading. It ships an on-chip eFuse for storing various vendor configuration,
> > including MAC address.
> > 
> > This patch adds basic glue code for the controller, allowing it to be set up and
> > transmit data at a reasonable speed. Features like WOL could be implemented
> > in the future.
> > 
> > Signed-off-by: Yao Zi <me@ziyao.cc>
> > Tested-by: Mingcong Bai <jeffbai@aosc.io>
> > Tested-by: Runhua He <hua@aosc.io>
> > Tested-by: Xi Ruoyao <xry111@xry111.site>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/Kconfig   |   9 +
> >  drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
> >  .../ethernet/stmicro/stmmac/dwmac-motorcomm.c | 384
> > ++++++++++++++++++
> >  3 files changed, 394 insertions(+)

...

> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c
> > b/drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c
> > new file mode 100644
> > index 000000000000..8b45b9cf7202
> > --- /dev/null
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c

...

> > +static int motorcomm_efuse_read_patch(struct dwmac_motorcomm_priv
> > *priv,
> > +				      u8 index,
> > +				      struct motorcomm_efuse_patch *patch) {
> Minor nit
> This format breaks  kernel style function definition, use as below ( "{" in next line)
> static int motorcomm_efuse_read_patch(struct dwmac_motorcomm_priv
>                                                                           *priv,
> 				                 u8 index,
> 				                 struct motorcomm_efuse_patch *patch) 
> {

This is strange, I didn't put the left curly brace in the same line as
the argument list. You could confirm this in the mbox archived by
lore[1]. Same for other functions.

I've talked to other recipients of the patch, and one uses Outlook as
MTA reported similar issues. It seems Outlook MTA (not the server)
automatically removes the line break and the plus sign before the curly
brace.

I checked your Message-ID and found you're also using Outlook as service
provider, if Outlook is also your MTA, could you try turn off option
"Remove extra line breaks in plain text messages" and see whether the
problem gets fixed?

...

> > +static int motorcomm_setup_irq(struct pci_dev *pdev,
> > +			       struct stmmac_resources *res,
> > +			       struct plat_stmmacenet_data *plat) {
> > +	int ret;
> > +
> > +	ret = pci_alloc_irq_vectors(pdev, 6, 6, PCI_IRQ_MSIX);
> > +	if (ret > 0) {
> > +		res->rx_irq[0]	= pci_irq_vector(pdev, 0);
> > +		res->tx_irq[0]	= pci_irq_vector(pdev, 4);
> > +		res->irq	= pci_irq_vector(pdev, 5);
> > +
> > +		plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
> > +	} else {
> > +		dev_info(&pdev->dev, "failed to allocate MSI-X vector: %d\n",
> > +			 ret);
> > +		dev_info(&pdev->dev, "try MSI instead\n");
> > +
> > +		ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
> > +		if (ret < 0)
> > +			return dev_err_probe(&pdev->dev, ret,
> > +					     "failed to allocate MSI\n");
> > +
> > +		res->irq = pci_irq_vector(pdev, 0);
> > +	}
> 
> If possible, add enum for MAX MSIX count (in this case 6 ), or dynamic values as per hardware. 

The only Motorcomm PCIe ethernet controller I could find is YT6801, so
I don't think there's a need for per-hardware values (at least for now).
Will add a constant to represent MSI-X count in the next version.

...

> Reviewed-by: Sai Krishna <saikrishnag@marvell.com>

Thanks for reviewing.

Best regards,
Yao Zi

[1]: https://lore.kernel.org/all/20260109093445.46791-4-me@ziyao.cc/raw

