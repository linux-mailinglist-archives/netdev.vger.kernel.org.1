Return-Path: <netdev+bounces-233856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 631CAC194F5
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 10:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B6664032D9
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 09:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48E82DF6F8;
	Wed, 29 Oct 2025 09:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="d5sgSfoD"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9501C2EC0B5;
	Wed, 29 Oct 2025 09:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761728437; cv=none; b=ao9Yn9I6DdiEl0BTrlEd8lPMBMyvFz6SXutlyV1jO1ztRbg2v68BTIJhB9/gxIhuxiiJx54LtaE21bh+HxvFqvVlKXV/2bKbGHnASwEgVS75SWtAjmGtVvjZAOg8UoJbvft/KzP0VuprqqxSwrkXtqx+bBbtYPJYHMVbXEQJJ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761728437; c=relaxed/simple;
	bh=r+8AkXtHvMdBuc5ddtmrYiAIeDBwDa/C1wlavh7P2cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLcnWC3XF1oyiicPH/hoAy8ydm8xMgKnB6KvVXfpHeIE9Xw9gaTwsbFDacJaCUeot2SchMBOYno5Ab590g0zzH+644WV87bkNsavW6328lrHyZjpG+XHBuZcFSJobPIRmBkA4PqWSA64mERR3irXn1Zq1YYrmIN0ybD92cRNKfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=d5sgSfoD; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zsXgaZ1WpsggfrTMGBX3c0/kSEKjs6qv8khvpgW4L/Q=; b=d5sgSfoD66+VVXT0M/tWTdKuck
	pvi43DUOd0EQYyYKbSXK2pQnAnl04cvG20GRDI+Ho7eYwyTZlZu6ld5S1LtnNiLwi8o7NK8/kSY23
	cKAJm1yBNu4H0U4qcPJ/6Eg28DY5RIjIFKb9d+J02BKggdIRaEKUTEuL/AV9i+iua+iuZl4jdQnzV
	TNiUmBnnMXj5/d3wcDMPn1qSr3RmuG1Uz/XX/z/f3B8SqEuplu4j2UhhtQq4M+LGPZh4AMyWQ/BSv
	mBSanHh1dx1VlJ8tp0EQkRQe9FbViaz9cqR4OOourohrKRLlCVsEyYyQGFNPklsyunj/fb0M4PMzT
	Idcx7tlg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43710)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vE22O-0000000048E-0rrQ;
	Wed, 29 Oct 2025 09:00:12 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vE22I-000000007OI-0McV;
	Wed, 29 Oct 2025 09:00:06 +0000
Date: Wed, 29 Oct 2025 09:00:05 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yanteng Si <si.yanteng@linux.dev>
Cc: Yao Zi <ziyao@disroot.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Qunqin Zhao <zhaoqunqin@loongson.cn>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Furong Xu <0x1207@gmail.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: stmmac: Add generic suspend/resume
 helper for PCI-based controllers
Message-ID: <aQHXlbDRAu76m5by@shell.armlinux.org.uk>
References: <20251028154332.59118-1-ziyao@disroot.org>
 <20251028154332.59118-2-ziyao@disroot.org>
 <aQDoZaET4D64KfQA@shell.armlinux.org.uk>
 <91de05f5-3475-45eb-bbf7-162365186297@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91de05f5-3475-45eb-bbf7-162365186297@linux.dev>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Oct 29, 2025 at 10:27:18AM +0800, Yanteng Si wrote:
> 在 2025/10/28 下午11:59, Russell King (Oracle) 写道:
> > On Tue, Oct 28, 2025 at 03:43:30PM +0000, Yao Zi wrote:
> > > Most glue driver for PCI-based DWMAC controllers utilize similar
> > > platform suspend/resume routines. Add a generic implementation to reduce
> > > duplicated code.
> > > 
> > > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > > ---
> > >   drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 +
> > >   .../net/ethernet/stmicro/stmmac/stmmac_main.c | 37 +++++++++++++++++++
> > I would prefer not to make stmmac_main.c even larger by including bus
> > specific helpers there. We already have stmmac_pltfm.c for those which
> > use struct platform_device. The logical name would be stmmac_pci.c, but
> > that's already taken by a driver.
> > 
> > One way around that would be to rename stmmac_pci.c to dwmac-pci.c
> > (glue drivers tend to be named dwmac-foo.c) and then re-use
> > stmmac_pci.c for PCI-related stuff in the same way that stmmac_pltfm.c
> > is used.
> > 
> > Another idea would be stmmac_libpci.c.
> 
> I also don't want stmmac_main.c to grow larger, and I prefer
> stmmac_libpci.c instead. Another approach - maybe we can
> keep these helper functions in stmmac_pci.c and just declare
> them as extern where needed?

stmmac_pci.c is itself a glue driver, supporting PCI IDs:

	0x0700, 0x1108	- synthetic ID
	0x104a, 0xcc09	- ST Micro MAC
	0x16c3, 0x7102	- Synopsys GMAC5

I don't think we should try to turn a glue driver into a library,
even though it would be the easier option (we could reuse
CONFIG_STMMAC_PCI.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

