Return-Path: <netdev+bounces-227326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B50BAC910
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 12:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2B153A49BD
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 10:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B1C275AF6;
	Tue, 30 Sep 2025 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nT2/Pjya"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E11FC0A;
	Tue, 30 Sep 2025 10:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759229662; cv=none; b=MKit0eUetKAVAXlNpiXfu0sC3NzXI0hg8eB1M5FJLyOuKnEBkOw0iDUmgzXAZ4+n030JuU2UcePucFd7ZY6qyCSlzB4EbVG2WT+5wYXvHsFC3joAn4FxeskmMS24eNFopIO5e8SkRXem7F5UjzgnHymY/m4cYAyVNXv4TVJHVek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759229662; c=relaxed/simple;
	bh=e+CJRVZySin4BQkwE/eUO0PrQTAz/XyD+muCH4daoCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lw8g87w8Otg/48N/bu+VJkFUo4fMDbuXcHCjUmjA0kilbjoaugXr6+51vRExW4ov5YZGg6xg7nNQP8YmdMSXWa+WcOE/Udu/prBTqFWLtVgxLDLJxE08I+M6p+JsYYZgaBHyDOn0RqGxYau2k3WlubqSkIqPU5/Jopm1D8iTooE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=nT2/Pjya; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wEl8Vu88HbCShDFSr5D6DQceYwmi4hJ5JAfySeh3vM0=; b=nT2/PjyaS3+5akC+nlaDg1dnl2
	qySlS/urecJfiMgtpqDdIAeNmqXaaJ7jgItB6dkul7Pu0XCdCkJvY7quTX7Nx/HVJErSznFhOVMW3
	l2IF65Ho7x7uhudSAuT9mGvMQHXP/AYmgKipOCZfuga9k8wR2Q9GY2rAnJCVe1WXspiKk9gmRg6Zu
	EIBzDlzP6HMuvyOc2agL26rCwn0RYze2vwHeEKs/X1iK3hbAEDO9dEvGREHG7jrABtAGlWHXiboom
	iIVV5KEackWguKVh2fCjZUfXrfDOrN1c4okkChlg9xbaUCqnriRndVGocSFImsJErd6bvo9A19r0p
	ROXO0TIA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36802)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v3Xzh-000000007iL-0Awj;
	Tue, 30 Sep 2025 11:54:05 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v3Xzc-000000004Rc-0Mbn;
	Tue, 30 Sep 2025 11:54:00 +0100
Date: Tue, 30 Sep 2025 11:53:59 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Tristram Ha <Tristram.Ha@microchip.com>
Subject: Re: [PATCH RFC net-next 2/6] net: phy: add phy_may_wakeup()
Message-ID: <aNu2xxrOuFuFc7wE@shell.armlinux.org.uk>
References: <aNj4HY_mk4JDsD_D@shell.armlinux.org.uk>
 <E1v2nFD-00000007jXP-0fX2@rmk-PC.armlinux.org.uk>
 <2e23535f-f0a2-4111-ae64-6f496a72f27d@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e23535f-f0a2-4111-ae64-6f496a72f27d@foss.st.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Sep 30, 2025 at 11:04:28AM +0200, Gatien CHEVALLIER wrote:
> Hi Russell,
> 
> First of all, thank you for taking the time to propose something.
> 
> IIUC, using ethtool to enable WoL with, e.g: "ethtool -s end0 wol g"
> even if the WoL isn't really supported will prevent the phy suspend.

This is correct - whenever a PHY has WoL enabled, it won't be suspended
as it has to listen for the configured wake-up packet(s).

> Therefore, PHY drivers should be adapted to implement something like:
> 
> 	if (!device_can_wakeup(&dev->mdio.dev))
> 		return -EOPNOTSUPP;
> 
> in their set_wol() ops to fully adapt to what you propose, right?

That's not sufficient. Yes, it's one of the things they need to do.

1. get_wol() should set ->supported to 0 (or at least not add anything
   to it) if wake-up is not possible.

2. set_wol() should not enable WoL modes or return -EOPNOTSUPP as you
   have above if wake-up is not possible. It should also call
   device_set_wakeup_enable() to indicate whether wake-up has been
   enabled for this device or not.

3. the PHY driver's probe function needs to be modified to call 
   device_set_wakeup_capable() to configure whether this device _really_
   can wake-up the system. See realtek_main.c::rtl8211f_probe() and
   broadcom.c as examples.

4. if using interrupt-based wake-up, use devm_pm_set_wake_irq() so
   the driver core can manage the irq-wake configuration.

See realtek_main.c - that's the driver I recently fixed (it had many
issues).

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

