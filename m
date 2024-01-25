Return-Path: <netdev+bounces-65971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE0B83CB50
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 19:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20DC41F22B5C
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 18:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA761F60A;
	Thu, 25 Jan 2024 18:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="efaPwzef"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C108472
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 18:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706208091; cv=none; b=C3U0Ji5Z9wzFanA0Wr0CJQPSehv8Woxs8tCArrwQLyY/4rrvMnyRRAgJAJ4yZRJg58LrZjdbxpBTm9h8wSZMRvylYoC5zvfzBkx7wXWXHR7EI+54IUz4MPeGgNFeueQ8yKjz/8wZfp1ztxQf9Tb5GYkLSbk+YtTWmN+TItQuRTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706208091; c=relaxed/simple;
	bh=6NDbDFa8Oz3LGG4Z3DotWywd8m70TbFflwB0EctoUng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0E9mAyhBfU1S4uIJaPrBw0vriBBAd/g5za/n6skWpGu8DlPSvMmWd2zYQXvDiq2ETuifkODbqVMaoR+5i4aQQ8J/YZNBOEL3o6W0nDc+7e9C9YxEeHuFDqz8lVvKiMWIlr9AMykXBAKtoXk+Jf3npaB+RBQ4P82gl2Lzl2VYwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=efaPwzef; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iOgYNddn5x23XPlnk1Ee15ii2Dew59eyYt712ID8gtE=; b=efaPwzef9Lj/e5HNafAKVey11D
	Vbs6BNdHVyYwcrG2ftGy8linKPgH4P3OKkzE1gqXtHu/YIAABLTG4EwoHM0DjySFXvbtlwsb5sGjG
	/3KjwXdak72wkWdaiq/vIOx5d/C/4pDlYTbIGj1cgJiDCrWarNN18bdKrqdycyHvErRZPL9dNAyi7
	c2suUZdwrc1qE+0BDLUDoEOnF/XpdQx5YGke3uuyhfXQzP885Ji2+wi58DPUJgvMvuQvWGK1YwdES
	nMqDxRMp8cat93MdTBWNJbZxmwgFeM/UH8uUFoP6m8aUxoLBdBBnVHBP2rSPVN4w5trnH5yrwAmve
	sDer44bw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42798)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rT4f3-0001Kn-1E;
	Thu, 25 Jan 2024 18:41:13 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rT4ey-00015B-Sf; Thu, 25 Jan 2024 18:41:08 +0000
Date: Thu, 25 Jan 2024 18:41:08 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Yanteng Si <siyanteng@loongson.cn>, andrew@lunn.ch,
	hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	Jose.Abreu@synopsys.com, chenhuacai@loongson.cn,
	guyinggang@loongson.cn, netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v7 7/9] net: stmmac: dwmac-loongson: Add GNET
 support
Message-ID: <ZbKrRL9W5D1kGn0F@shell.armlinux.org.uk>
References: <cover.1702990507.git.siyanteng@loongson.cn>
 <caf9e822c2f628f09e02760cfa81a1bd4af0b8d6.1702990507.git.siyanteng@loongson.cn>
 <pbju43fy4upk32xcgrerkafnwjvs55p5x4kdaavhia4z7wjoqm@mk55pgs7eczz>
 <ac7cc7fc-60fa-4624-b546-bb31cd5136cb@loongson.cn>
 <ce51f055-7564-4921-b45a-c4a255a9d797@loongson.cn>
 <xrdvmc25btov77hfum245rbrncv3vfbfeh4fbscvcvdy4q4qhk@juizwhie4gaj>
 <44229f07-de98-4b47-a125-3301be185de6@loongson.cn>
 <72hx6yfvbxiuvkunzu2tvn6glum5rjrzqaxsswml2fe6j3537w@ahtfn7q64ffe>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72hx6yfvbxiuvkunzu2tvn6glum5rjrzqaxsswml2fe6j3537w@ahtfn7q64ffe>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jan 25, 2024 at 09:38:30PM +0300, Serge Semin wrote:
> On Thu, Jan 25, 2024 at 04:36:39PM +0800, Yanteng Si wrote:
> > drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c: In function
> > 'loongson_gnet_data':
> > drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c:463:41: warning:
> > conversion from
> > 
> > 'long unsigned int' to 'unsigned int' changes value from
> > '18446744073709551611' to '4294967291' [-Woverflow]
> >   463 |         plat->mdio_bus_data->phy_mask = ~BIT(2);
> >       |                                         ^
> > 
> > Unfortunately, we don't have an unsigned int macro for BIT(nr).
> 
> Then the alternative ~(1 << 2) would be still more readable then the
> open-coded literal like 0xfffffffb. What would be even better than
> that:
> 
> #define LOONGSON_GNET_PHY_ADDR		0x2
> ...
> 	plat->mdio_bus_data->phy_mask = ~(1 << LOONGSON_GNET_PHY_ADDR);

	plat->mdio_bus_data->phy_mask = ~(u32)BIT(2);

would also work.


-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

