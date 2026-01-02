Return-Path: <netdev+bounces-246562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAB4CEE56B
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 12:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A598F30000B4
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 11:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776DD2F25F1;
	Fri,  2 Jan 2026 11:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Uasb2mcM"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F36A2F1FFE;
	Fri,  2 Jan 2026 11:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767353220; cv=none; b=WQW9ZfWRawT+sRvXKruLuZNjk1tkVaUoseLNM8/5Q1wbt4WDHoE2ApO3iwVLX6pzdXESEr5stbnTi+YowQqgmcPoLUKwQRdusZX1e5y+3mDPH+CLAhBA0defIpzBfF2SGq4850U9Bz581u4nEn0Mi9jkvLCASYxaRJI32Q7su6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767353220; c=relaxed/simple;
	bh=UB077yAvkyjN9xN8LS3a3pxuklfixfjAsULpclHu9ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyfkFAnX2S+neXwtPey/O84eXAACLn2BkHMaVgqTm7VFMhOT95N69sNf+CApZkpnarde2P9gJ0wunnFnBOZ/DXcI89DxvtBUSXmFTOJsa18NLrRTavCQ4mefzFwoTB3/0hCFovGm4Y8wBJYITYK8rhu20SxShIRdreOMIzGGVzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Uasb2mcM; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=odedTxf2YcsS+g4Rff2E3sp3+zkz31xR0hil2t4ziQw=; b=Uasb2mcMr0//wmw6Xk9kzzQHT7
	k/24ehR0oVxJbwkPguIMxGRo7SuxcPROE9XT6c3oUhmcDUlGosN58EqOLANBk8lIvvdfrQPPz20+w
	qhdRpn9vljdeNwgrUi4mU2u15+FiVLVWNfGcEMuyN9ik9Z6i87mnyIlHJRmsfzAzhwyAlCoD/BCov
	cHa86alF1MbNBtKKXzT6OmS5ce25QIFRmKB0WmKdNXM2QaNV9xbXxMxb6pZ5UmNOhWrFYqZQ3zPNl
	X8DZeqZgUktu/kPJc2sgaZHuj0EPBPjO2ow5L89ac3Nz0wt0APJtUdmiZaHsHNWXii+dsCWDRH0ex
	nJEvQ9sw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34094)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vbdIT-000000005uS-2kmg;
	Fri, 02 Jan 2026 11:26:21 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vbdIP-00000000501-2PgP;
	Fri, 02 Jan 2026 11:26:17 +0000
Date: Fri, 2 Jan 2026 11:26:17 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jijie Shao <shaojijie@huawei.com>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	horms@kernel.org, Frank.Sae@motor-comm.com, hkallweit1@gmail.com,
	shenjian15@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, jonathan.cameron@huawei.com,
	salil.mehta@huawei.com, shiyongbang@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 2/6] net: phy: add support to set default
 rules
Message-ID: <aVerWcPPteVKRHv1@shell.armlinux.org.uk>
References: <20251215125705.1567527-1-shaojijie@huawei.com>
 <20251215125705.1567527-3-shaojijie@huawei.com>
 <fe22ae64-2a09-45ce-8dbf-a4683745e21c@lunn.ch>
 <647f91c7-72c2-4e9d-a26d-3f1b5ee42b21@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <647f91c7-72c2-4e9d-a26d-3f1b5ee42b21@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Dec 17, 2025 at 08:54:59PM +0800, Jijie Shao wrote:
> 
> on 2025/12/16 15:09, Andrew Lunn wrote:
> > On Mon, Dec 15, 2025 at 08:57:01PM +0800, Jijie Shao wrote:
> > > The node of led need add new property: rules,
> > > and rules can be set as:
> > > BIT(TRIGGER_NETDEV_LINK) | BIT(TRIGGER_NETDEV_RX)
> > Please could you expand this description. It is not clear to my why it
> > is needed. OF systems have not needed it so far. What is special about
> > your hardware?
> 
> I hope to configure the default rules.
> Currently, the LED does not configure rules during initialization; it uses the default rules in the PHY registers.
> I would like to change the default rules during initialization.

One of the issues here is that there are boards out there where the boot
loader has configured the PHY LED configuration - and doesn't supply it
via DT (because PHY LED configuration in the kernel is a new thing.)

Adding default rules for LEDs will break these platforms.

Please find a way to provide the LED rules via firmware rather than
introducing some kind of rule defaulting.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

