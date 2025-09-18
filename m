Return-Path: <netdev+bounces-224506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A907EB85B6D
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCB2F1895548
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70922311954;
	Thu, 18 Sep 2025 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="F7JJb73T"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5C630EF94;
	Thu, 18 Sep 2025 15:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209829; cv=none; b=A8Ryp5RKZYB4sJfTfJsZIe23WfROmKt/Qaodz0a8K2tkcdkyvPWBJeF4mqyeXBrYYCV3e6q6DbdgNu6d46AY/69ypUuNsTwRqDlrw54cs9DONE7O3iJxAr3FJgP3799D5GAFOOg+Es/AKjKnIvmAHDX7eShntqlLvAPuTpzgEKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209829; c=relaxed/simple;
	bh=AjBGs66bwYcRT0DYbNaapwReZ4uUeTrPz4K6vm2LwC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSNv7AZb3STm8W4vgNoEDF3gTJyv83062FBDlSFq+ZsVyV2+2UEixvAKZMPX7UKY6OUe8P1K2b/lkXYg27/xSEkYHtivKU5Neyq+FUsCRSeQnsKIGT3T23IAB93fPbG3kRVDZy9W7CFtRf2To3qNbZzF3u1jnHIziHRIb8UVbHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=F7JJb73T; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aM9defDUbxftG1qhQP/TtclfqCxbcheJJLtqcFMRzU4=; b=F7JJb73THAOqRK1K8GFdiT/8Ej
	gj9W1dfgE4nWfaTkdI63AdaKD9zzZMlzAxOzu/aVmbYNPPczfMsbitvrzmw7CZnzqz/C9q3imUOni
	DrjmmEfLd4yPeTmSp8UTMZiFZhZVOCF/DbW5nbpr95AdhrtzhSqzme+mDJkXUlfUxPsOgtLSizXEI
	aKmM1UInF0ZFJyDXT4Q/TiHrZbxO+8cSKNzxhzXu4mZcNN4QEbc2pAfsUEqW1Dfh8v32Pv/wPfA9I
	6e+qoV4lDUliCYjwrwt3A8JGGBM4o8WYYgFiQYMG0kH0PY/hQ7LWOjWw3XYtpBs06bmGxtzkqmwLx
	q1UygtCQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43486)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uzGgg-000000001BG-1j6Y;
	Thu, 18 Sep 2025 16:36:46 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uzGgc-000000001Hk-0d9w;
	Thu, 18 Sep 2025 16:36:42 +0100
Date: Thu, 18 Sep 2025 16:36:41 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Tristram Ha <Tristram.Ha@microchip.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/4] net: stmmac: stm32: add WoL from PHY
 support
Message-ID: <aMwnCWT5JFY4jstm@shell.armlinux.org.uk>
References: <20250917-wol-smsc-phy-v2-0-105f5eb89b7f@foss.st.com>
 <20250917-wol-smsc-phy-v2-2-105f5eb89b7f@foss.st.com>
 <aMriVDAgZkL8DAdH@shell.armlinux.org.uk>
 <72ad4e2d-42fa-41c2-960d-c0e7ea80c6ff@foss.st.com>
 <aMwQKERA1p29BeKF@shell.armlinux.org.uk>
 <64b32996-9862-4716-8d14-16c80c4a2b10@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64b32996-9862-4716-8d14-16c80c4a2b10@foss.st.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Sep 18, 2025 at 05:07:00PM +0200, Gatien CHEVALLIER wrote:
> On 9/18/25 15:59, Russell King (Oracle) wrote:
> >  > So no. In a situation like this, either we want to be in interrupt
> > mode (in which case we have an interrupt), or the pin is wired to
> > a power management controller and needs to be in PME mode, or it isn't
> > wired.
> > 
> 
> If you are in interrupt mode, plugging a cable would trigger a
> system wakeup in low-power mode if the INTB/PMEB line is wired to a
> power management controller and the WoL is enabled because we're no
> longer in polling mode, wouldn't it?

What Andrew suggested, which is what I implemented for Realtek, other
interrupts get disabled when we enter suspend:

static int rtl8211f_suspend(struct phy_device *phydev)
{
...
        /* If a PME event is enabled, then configure the interrupt for
         * PME events only, disabling link interrupt. We avoid switching
         * to PMEB mode as we don't have a status bit for that.
         */
        if (device_may_wakeup(&phydev->mdio.dev)) {
                ret = phy_write_paged(phydev, 0xa42, RTL821x_INER,
                                      RTL8211F_INER_PME);

This disables all other interrupts when entering suspend _if_ WoL
is enabled and only if WoL is enabled.

If you're getting woken up when you unplug/replug the ethernet cable
when WoL is disabled, that suggests you have something wrong in your
interrupt controller - the wake-up state of the interrupt is managed
by core driver-model code. I tested this on nVidia Jetson Xavier NX
and if WoL wasn't enabled at the PHY, no wakeup occurred.

> You can argue that as per the Realtek 8211F datasheet:
> "The interrupts can be individually enabled or disabled by setting or
> clearing bits in the interrupt enable register INER". That requires
> PHY registers handling when going to low-power mode.

... which is what my patch does.

> There are PHYs like the LAN8742 on which 3 pins can be configured
> as nINT(equivalent to INTB), and 2 as nPME(equivalent to PMEB). The
> smsc driver, as is, contains hardcoded nPME mode on the
> LED2/nINT/nPME/nINTSEL pin. What if a manufacturer wired the power
> management controller to the LED1/nINT/nPME/nINTSEL?
> This is where the pinctrl would help even if I do agree it might be a
> bit tedious at first. The pinctrl would be optional though.

I'm not opposing the idea of pinctrl on PHYs. I'm opposing the idea
of tying it into the WoL code in a way that makes it mandatory.
Of course, if it makes sense for a PHY driver to do pinctrl stuff
then go ahead - and if from that, the driver can work out that
the PHY is wake-up capable, even better.

What I was trying to say is that in such a case as the Realtek
driver, I don't want to see pinctrl forced upon it unless there is
a real reason and benefit, especially when there are simpler ways
to do this.

I also think that it would be helpful to add the wakeup-source
property where PHYs are so capable even if the PHY driver doesn't
need it for two reasons. 1. OS independence. 2. it's useful docs.
3. just because our driver as it stands at whatever moment in time
doesn't make use of it doesn't mean that will always be the case.
(e.g., we may want to have e.g. phylib looking at that property.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

