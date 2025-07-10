Return-Path: <netdev+bounces-205736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA1DAFFECD
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 12:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 894DF1C8650E
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 10:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDE72D6615;
	Thu, 10 Jul 2025 10:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="qSr2ByKq"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354BD2D839A;
	Thu, 10 Jul 2025 10:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752142321; cv=none; b=ia1AljT77O3WKZALo9CQ8JcaBLsJWXJbGg0PwCJNkvt7Q//RX6JyuoyNwvJrLAjnI4zmeEPp0kOCLZ5XUG+Y75OJJ97D23OvJUx+21wNAMCBrHGNeJsmdu+9rpsqHl3zMclOlnSy21httzMCJWRY7wYC59ehpiahvhKB3xaJ+Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752142321; c=relaxed/simple;
	bh=BTvr7xotmLF7fRPdmL8WTLdh9hY6CFn1R4FF0Cq2rAw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9BdmR0JncPMidgFF+UACojYSG9oZ7LTlAvtTXBFuGMCytSXy8PmYH3T6V+tVoO+N6s/6HJcwC0AJVsip7cf4kfDTxlxBNard4AUqB3EmjIgduoavu+WRTAsOdzQEAlbAvKRkI1oLLfBPnoSJ9tJsMKM0wuJcBrKs+IJpHs73ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=qSr2ByKq; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 072FFA0576;
	Thu, 10 Jul 2025 12:11:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=YXc+01zAlpnPDut2ScqW
	80cTeCPMDR6CpI55Apj8pT0=; b=qSr2ByKqsxK04C/ckwx3vgPYOLzysYXHjOfR
	hS+c3pIoT3mMIMzzoJsckucQLP4Sh7yUdw/uPQxQidSS9MheXuSXFz7KcvDiA//L
	QVhrVMwx5PIx28sq4qfVU9bTVUnob/Xl3NO1AS3ZtKYdyR6s2kPA+9ezE3E11BGh
	Qq+Z73yrn9iduRAqrjdbu8Qgg8CP8c4I8UvoAP9sIMvPYvs5D+YGRjt66PnbZdwn
	fTorEClpADvSChQFLBm0GB9O+QjXI8N6rFg75RnqTNlRTQvllz+XHpYnT7dw5D5T
	vLtP0b/hxtiuCTEpt2O/0G11grmMhlSW82IGGVNtywSVeM3qVtMxVW4aSc3eZuHO
	Z8ROi+nR5YmzkJ/Z7uAf88A8/YmQOQtiIPksCbkmIyTb/Nsif3JtQCGMfzt4zYWC
	xsRiaXTLVJldioG2NQF0zY6kf16zrLs7zoZOK7HH3OfL6zPVbWFV0qcNB5bYhm7V
	DStniSTeo+VE5OWvmvZRjpFXvmMf72uwn9oGBVCrOP/F7un/DKquseT6cOqtnNhd
	t4Ldf1lLCsIKLDXLW/IfCRcSNZbBTsunC1Npwlqb/XIv/7x4wrSDlYQVlAgVSfHL
	yRdXJZgmllDte0BwKQj23Zleh/szoyXntSCkh3vV3qqoiqA09cfDzeIkTV8yMZUy
	1+yzcCE=
Date: Thu, 10 Jul 2025 12:11:46 +0200
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	=?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 3/3] net: mdio: reset PHY before attempting to access
 registers in fwnode_mdiobus_register_phy
Message-ID: <aG-R4gWfI5QKRo5w@debianbuilder>
References: <20250709133222.48802-1-buday.csaba@prolan.hu>
 <20250709133222.48802-4-buday.csaba@prolan.hu>
 <0d0d7e6f-3376-4939-a3f7-8cf5f52e4749@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d0d7e6f-3376-4939-a3f7-8cf5f52e4749@lunn.ch>
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1752142309;VERSION=7994;MC=1631949861;ID=121719;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD515E657066

On Wed, Jul 09, 2025 at 03:41:45PM +0200, Andrew Lunn wrote:
> On Wed, Jul 09, 2025 at 03:32:22PM +0200, Buday Csaba wrote:
> > Some PHYs (e.g. LAN8710A) require a reset after power-on,even for
> > MDIO register access.
> > The current implementation of fwnode_mdiobus_register_phy() and
> > get_phy_device() attempt to read the id registers without ensuring
> > that the PHY had a reset before, which can fail on these devices.
> >
> > This patch addresses that shortcoming, by always resetting the PHY
> > (when such property is given in the device tree). To keep the code
> > impact minimal, a change was also needed in phy_device_remove() to
> > prevent asserting the reset on device removal.
> >
> > According to the documentation of phy_device_remove(), it should
> > reverse the effect of phy_device_register(). Since the reset GPIO
> > is in undefined state before that, it should be acceptable to leave
> > it unchanged during removal.
> >
> > Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
> > Cc: Csókás Bence <csokas.bence@prolan.hu>
>
> This appears to be a respost of the previous patch.
>
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html says:
>
> don’t repost your patches within one 24h period

Sorry for that, this is my first kernel patch, and git send-email tricked me.
I will paste your earlier reply below, and continue in this thread.

>
> This is specific to this device, so the driver for this device should
> take care of the reset.

I think it may affect every chip that has the `PHY_RST_AFTER_CLK_EN`
flag set. That is still not a terribly lot of devices, but it is more than
just this one. There are a lot of DT-s out there which use the (deprecated?)
`phy-reset-gpios` property of the fec driver. When that property is
present, that will reset the PHY chip before it gets to get_phy_device().
Even with this chip, only about 10% of them fail to report their ID without
reset (in our systems and startup configuration).

>
> To solve the chicken/egg, you need to put a compatible in the PHY node
> listing the ID of the PHY. That will cause the correct PHY driver to
> load, and probe. The probe can then reset it.

Yes, that approach does work — and I've tested it successfully with the
other two patches I sent. However, when a PHY ID is specified in the DT, it
is taken directly, not read from the hardware. This may lead to issues with
revision-specific logic, since the revision bits won’t necessarily match
the actual chip. For LAN8710A this isn’t currently a problem, but it may be
for other PHYs.

>
> We have to be careful about changing the reset behaviour, it is likely
> to break PHYs which currently work, but stop working when they get an
> unexpected reset.

I agree that changing the reset logic must be done with caution.

But these lines of code are actually the first, when the kernel tries to 
access the PHY. Is it not a good practice, to do that from a known,
reproducible state? That is what the reset is for. Without the reset, the
PHY may be in whatever state it was left previously. That could lead to 
hard to reproduce effects, like failing after restart, failing because
there was a change in the bootloader, etc.

A few lines later fwnode_mdiobus_phy_device_register() is called
anyway, that will also reset the PHY in the same conditions (DT based
system, and either `reset-gpios` or `reset-ctrl` is defined).

My intent was to ensure that if the system asks for a reset, it actually
happens before the PHY is accessed, rather than mid-way through
registration.

Changing phy_device_remove() may be more concerning. I can create a patch,
that leaves that intact, and only changes reset behaviour during reset, but
that will be a bit longer.

>
>     Andrew
>
> ---
> pw-bot: cr
>

Csaba


