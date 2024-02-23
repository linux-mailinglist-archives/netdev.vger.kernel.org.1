Return-Path: <netdev+bounces-74492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF0F86179D
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 17:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91D41F22389
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 16:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A01F1292DF;
	Fri, 23 Feb 2024 16:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Mx9yZqOo"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB487126F18;
	Fri, 23 Feb 2024 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708705169; cv=none; b=SG3gXirCibveFGtMK7exyNRKHk+SvnISTBE8m/PtGagAqGf6WhVvnGWoO6UkDA1HxsfM1VZRPDlgx5QSNxY8kZWhZiowSaeDGzhOc97eC7NiOsDpxTBN/EMrxhxSkoEtclXbrVfxhdIaZfFp9FfyxAyim/3awQysoxAc9MfFnrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708705169; c=relaxed/simple;
	bh=joPzG+++ezLaON59rVXad40IOG8lQR6Z/NTYgQe0+1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjpiHHO9CXF5n4SzlJbM6YQbtVQPr2qwggTU4UKIzZlEiW0GuAg7dZKAGumKlGHfWnQNGQTvUDOOJ7wTgN2tcK97zwmujAtZRBQCC6x30i6CfY1YtWugov3R8A3LVuEOrXioc0I+/KA78HzZ5UMab9sXLcylGG/pvddiOFRZ6sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Mx9yZqOo; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OEEu+Q+qWiDYEjhlF6uweUjaZhpoREuloxHpZyOQEjg=; b=Mx9yZqOo0DdCDnT5R6zSlsy58r
	IF4clhpSA1fM7tinhRx+lZHvNdkip/ih+F/m8QYC5tRiwnWCz0ZSlZ9I1JI8Mwfmp8mCTCA/ZwYVc
	JQr510o5AyWBBjathdb2eiLgAHqQ0+rT539FAjg2c6fnOHPKpLyKsH9B1q0RRg0CsPSyf4XCWVDFI
	4BzI1pPQLkBD0PNZoi/RBPNxAS9ogu5Jhbb5qf8mGrKuYKbhCY6qcZCS3zE53280vRb4Ax15lQocC
	wb8RDktmUljlsrBbi1JubvVqgH6tyN6sM5PmO/rAq1907FdqHdb4CkL2DssSauClhT+ztAQCE9ye8
	fz5NNZBA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60606)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rdYGV-0000Af-0X;
	Fri, 23 Feb 2024 16:19:11 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rdYGU-0003kX-DS; Fri, 23 Feb 2024 16:19:10 +0000
Date: Fri, 23 Feb 2024 16:19:10 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Johan Hovold <johan@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: phy_device: free the phy_device on the
 phy_device_create error path
Message-ID: <ZdjFfh/HGj6BZCXC@shell.armlinux.org.uk>
References: <20240223160155.861528-1-maxime.chevallier@bootlin.com>
 <20240223170607.0d2aa8b1@device-28.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223170607.0d2aa8b1@device-28.home>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Feb 23, 2024 at 05:06:07PM +0100, Maxime Chevallier wrote:
> On Fri, 23 Feb 2024 17:01:54 +0100
> Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:
> 
> > When error'ing out from phy_device_create(), the previously kzalloc'd "dev"
> > pointer gets overwritten with an error pointer, without freeing it
> > beforehand, thus leaking the allocated phy_device. Add the missing kfree
> > back.
> 
> Disregard , I immediatly realised that this was freed in
> phy_device_release in our case. Sorry about the noise.

Sorry your emails came in in reverse order.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

