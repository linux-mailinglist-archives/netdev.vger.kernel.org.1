Return-Path: <netdev+bounces-247663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B2DCFCFAE
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 10:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D5B63015113
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 09:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3962FCBE5;
	Wed,  7 Jan 2026 09:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Fj1xK8wV"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABE32FD68B;
	Wed,  7 Jan 2026 09:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767779445; cv=none; b=I5IChHdyXSFqkxsBN1egmf2faapStAwkMCSV4SRDWVI9vjcHP+tkTSgkZPkiEis9c6jwrJeFAIGsxxWGtWSls4z1Sde8xHrmryGMFhHftLe3qFsavJoe5yzDoYhG7rg599ym90I93QW7zbOBZPSbAVHkTFqDug+/nRZ4Bt/zCtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767779445; c=relaxed/simple;
	bh=s36ctYcNy4Vzxq93WlQu/9txP+PqQvXrxF16njdDAHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7sToN+Hg2BR3W9QPGNilQqPVJ4jSJ0YAe0qu2SHMFIb6GrFFHVLuCjy1l+Y8qRbkIpg+cw8A41yA6acRs6d0vjUKz6FPgt+5DPgLNPlJUIylOZtfgg2nDGztSOZGEunwW2WbFACq7+oGbriwXBsAcd3HEIo9MmpBSSJi49DDJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Fj1xK8wV; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tBRKSt2dyqR0s90Y7GVNDkqm9S9FCIJZ4rJuhPgGBv4=; b=Fj1xK8wVOVCeli9QMOCiLSS2IV
	MYdeV/nhwFPW4s/C3wlfsLCHc5jNvaJ8pmutv+9Y6ffNgeQUnJ7L0uVpHjpTxXADAMthHZH34b3hL
	m0lwJ8+Ov2WJsLuypZsOcSjbSknHz4i03M9y7RrbRKrbKFw795T/r2pBqr92hLRzUKA30szm2hf2S
	IohnMYeCDFmSzmcD0JJcJKSHvZGZkj2rAyIXtl0ccdehAetTcAz/povQw3PG4aN50DSVcDgowdd6S
	AR8KR83jEh1a5ev9T38lAnSzO2y86Yn7r/X5xJEvw6d4U+Qn+wr/jjC5DC21CyOhJ29PHnmDDkmV2
	LvOtVKvA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48840)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vdQB6-000000001Ua-20gm;
	Wed, 07 Jan 2026 09:50:08 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vdQB0-000000001J0-2rw1;
	Wed, 07 Jan 2026 09:50:02 +0000
Date: Wed, 7 Jan 2026 09:50:02 +0000
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
Message-ID: <aV4sSr79IBIQRj9x@shell.armlinux.org.uk>
References: <20251215125705.1567527-1-shaojijie@huawei.com>
 <20251215125705.1567527-3-shaojijie@huawei.com>
 <fe22ae64-2a09-45ce-8dbf-a4683745e21c@lunn.ch>
 <647f91c7-72c2-4e9d-a26d-3f1b5ee42b21@huawei.com>
 <aVerWcPPteVKRHv1@shell.armlinux.org.uk>
 <2d94db98-9484-438f-8e25-6b836c63ff71@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d94db98-9484-438f-8e25-6b836c63ff71@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 07, 2026 at 05:43:08PM +0800, Jijie Shao wrote:
> 
> on 2026/1/2 19:26, Russell King (Oracle) wrote:
> > On Wed, Dec 17, 2025 at 08:54:59PM +0800, Jijie Shao wrote:
> > > on 2025/12/16 15:09, Andrew Lunn wrote:
> > > > On Mon, Dec 15, 2025 at 08:57:01PM +0800, Jijie Shao wrote:
> > > > > The node of led need add new property: rules,
> > > > > and rules can be set as:
> > > > > BIT(TRIGGER_NETDEV_LINK) | BIT(TRIGGER_NETDEV_RX)
> > > > Please could you expand this description. It is not clear to my why it
> > > > is needed. OF systems have not needed it so far. What is special about
> > > > your hardware?
> > > I hope to configure the default rules.
> > > Currently, the LED does not configure rules during initialization; it uses the default rules in the PHY registers.
> > > I would like to change the default rules during initialization.
> > One of the issues here is that there are boards out there where the boot
> > loader has configured the PHY LED configuration - and doesn't supply it
> > via DT (because PHY LED configuration in the kernel is a new thing.)
> > 
> > Adding default rules for LEDs will break these platforms.
> > 
> > Please find a way to provide the LED rules via firmware rather than
> > introducing some kind of rule defaulting.
> 
> 
> Actually, in my code, `default_rules` is an optional configuration;
> you can choose not to set default rules.

How is that achieved?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

