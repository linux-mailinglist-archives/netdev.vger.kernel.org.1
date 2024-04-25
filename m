Return-Path: <netdev+bounces-91337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72468B242D
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 16:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A732FB21150
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 14:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD953BBCF;
	Thu, 25 Apr 2024 14:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="kofmOGNw"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4169D3BBE2
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 14:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714055804; cv=none; b=iWBWRuTRGzr9MI+GDiqj2tzKDDBa4N88eF0vtYx3GIiyrD1jhO0KdoCthGFIWt4BvlUyQPdjd1OR04anv+VMrJaiyhEP0vlixZ45q4Xi7JkdbcgWKWIwabMGztBUix849Lvveq8nAA2wrR8xFs1X7SxIjDNaBMymuZp1qdteL7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714055804; c=relaxed/simple;
	bh=kcnvUjXAK22JOpU+8lstt4h4AwWBEXToY6n/x4QuFNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvtZW3dKkzMj+fh4arMB90lo70H6IZpvNr642ZQEZ6tkAkyXkYdttB+XYOP5kOtqc8+d7wpX36t1jsrKnKECLynZUodUcpnhKVaN0LEM+73zIjjI97Frgr594MDOpeOIc+vlj8BN/C5CeMyVptcwGWh4hVjvyEyhnLZOeRcd1k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=kofmOGNw; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eLTCy9qtemtl4kX+38DvE5xtfhuMeiL/c8cALdJG1po=; b=kofmOGNwxqof6EDyJrvcXfU85q
	zHFshVkN/IQFUWDmpHoJO2Z45pM/qQJjIHffqzMzYBkKy81Ny6J56XI8Acv3yvHWMMYINc14p5yu4
	SzV6VvVh3Av3AcwdFJfu/a57mOsFEz1Wjz7kJGPNSpNmk1Qs7MDbvTEF2jBpsXvdES2u/TK1K5eXK
	vR5d2KECcKuljXGNT5R7e+Qev3rjUZK5v2uYGDqZWYvoKHpeJ/R4Ee3R3daar1Y6Vyno7XT49ib1v
	BecWCOcd2ORvvb6gjkvet7bl06kNWCqMqK2TYGMKQQD/dpcns4Fm+wN1D5KDx3s7esdR1Ne187+Tr
	9noHejMg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46878)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s00D5-0007X9-22;
	Thu, 25 Apr 2024 15:36:27 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s00D2-0005ej-AU; Thu, 25 Apr 2024 15:36:24 +0100
Date: Thu, 25 Apr 2024 15:36:24 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	fancer.lancer@gmail.com, Jose.Abreu@synopsys.com,
	chenhuacai@kernel.org, guyinggang@loongson.cn,
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com,
	siyanteng01@gmail.com
Subject: Re: [PATCH net-next v12 09/15] net: stmmac: dwmac-loongson: Add
 phy_interface for Loongson GMAC
Message-ID: <ZipqaHivDaK/FJAs@shell.armlinux.org.uk>
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <d0ca47778a424a142abbfa7947d8413dfbffc104.1714046812.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0ca47778a424a142abbfa7947d8413dfbffc104.1714046812.git.siyanteng@loongson.cn>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Apr 25, 2024 at 09:06:12PM +0800, Yanteng Si wrote:
> The mac_interface of gmac is PHY_INTERFACE_MODE_RGMII_ID.

No it isn't!

> +	plat->phy_interface = PHY_INTERFACE_MODE_RGMII_ID;

You don't touch mac_interface here. Please read the big comment I put
in include/linux/stmmac.h above these fields in struct
plat_stmmacenet_data to indicate what the difference between
mac_interface and phy_interface are, and then correct which-ever
of the above needs to be corrected.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

