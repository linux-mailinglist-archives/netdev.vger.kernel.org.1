Return-Path: <netdev+bounces-211009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8933CB1629C
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 16:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3ED2620031
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 14:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B072D9EEA;
	Wed, 30 Jul 2025 14:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eE4jNhLU"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1309D2D9ECD
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 14:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753885396; cv=none; b=lyfe0CloRDphYm0f0rOcng0Eq0X9RgsnSGl/UAqGi5Sz4xPwtFiXCln8OXaXON3W9awyXnSl6SS68d8DFQeWYgXK8Bi3+Zdrs5J+U1PLS4Z2944K4KHBLldd6tz2/z1l4aWHJ5jghmpOEVfTzN2uUTfuuMJduzvG3TWmAvQ7qpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753885396; c=relaxed/simple;
	bh=JDG6xp9TUSJxGOg4WSyioaRBxUHGXguYSSOTuA67VNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3eeGfriP8kwrjTvlKqmpe0iwm6A3QT7dZS/c+rnqpnlZgU69B8e/On/PxQrTwfnixFV6lxlVmxvHtAgeANAG6tVJ7H7lnfQW1PHwn/EZ1gxPDYqPBR9GMeyi+S5sHRz5zReHPxN9eivWfrCpXGM6EUTKu7wmJpT+qP4BcNR5m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=eE4jNhLU; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qFnJTBNOnfCyWGVeulsQ9imeMiSLi8CQ7pnaMQeRwmE=; b=eE4jNhLUzcD4MhHcFEYEDAzpnQ
	sZiaW5tq8tuCIfaR/KBlD4pqn/1nzSM2GBnDYrhIDw+y8CecCVGI1vdue4r8sbV/vL+QefGicRN9U
	LbrZFkrcsC8sG4zgLbnt9pdVXuHGslO4K95fnvs01y1p7jH64dBe6vqTH+zcwdgKBhQAkPhbV+gHQ
	tW6zFg8FhhyjhwB4rxo/TapmheNvUB0pzcKPuvahFgx6VGkS0wGDBtV8ZjK+6QAMSVGE7UphOwROc
	5y8rhKXeDWZVsrhVFV6jGhPydry/KBDgne5IZm930olrmwoWueRxmRbZVY33yQdGcv8FoBFqqIUvl
	zjiTYo6w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33826)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uh7hp-0003ax-2i;
	Wed, 30 Jul 2025 15:22:57 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uh7hl-0008VF-2P;
	Wed, 30 Jul 2025 15:22:53 +0100
Date: Wed, 30 Jul 2025 15:22:53 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Daniel Braunwarth <daniel.braunwarth@kuka.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Gatien CHEVALLIER <gatien.chevallier@foss.st.com>,
	Jakub Kicinski <kuba@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH RFC ???net???] net: phy: realtek: fix wake-on-lan support
Message-ID: <aIoqvaRk3lL1Zeig@shell.armlinux.org.uk>
References: <E1uh2Hm-006lvG-PK@rmk-PC.armlinux.org.uk>
 <a14075fe-a0fc-4c59-b4d3-1060f6fd2676@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a14075fe-a0fc-4c59-b4d3-1060f6fd2676@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jul 30, 2025 at 03:59:32PM +0200, Andrew Lunn wrote:
> > 2. detect whether we can support wake-up by having a valid interrupt,
> >    and the "wakeup-source" property in DT. If we can, then we mark
> >    the MDIO device as wakeup capable, and associate the interrupt
> >    with the wakeup source.
> 
> We should document "wakeup-source" in ethernet-phy.yaml.
> 
> What are the different hardware architectures?
> 
> 1) A single interrupt line from the PHY to the SoC, which does both
> link status and WoL.
> 
> 2) The PHY has a dedicated WoL output pin, which is connected to an
> interrupt.
> 
> 3) The PHY has a dedicated WoL output pin, which is connected directly
> to a PMIC. No software involved, the pin toggling turns the power back
> on.
> 
> For 1), i don't think 'wakeup-source' tells us anything useful. The
> driver just needs to check that interrupts are in use.

Not all interrupts are capable of waking the system up, and there is
no way for a PHY to know whether it's connected to an interrupt that
has that ability.

As things currently stand with how Jetson Xavier NX DT describes the
PHY's connection, it falls into this "it has an interrupt which can't
wake the system" - so these cases really do exist in the real world.

So, we _need_ to have some way to differentiate these two cases, and
I put the question to you - if not by "wakeup-source" then how do we
determine whether a PHY, which itself is capable of signalling wakeup
through its interrupt pin, can actually wake the system, and thus
should expose WoL functionality?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

