Return-Path: <netdev+bounces-213327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EEFB24911
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 14:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8CF97BC69B
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 12:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EC42FDC5C;
	Wed, 13 Aug 2025 12:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1pw9usUP"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAA821257D
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 12:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755086579; cv=none; b=n4EJK8UZupPwAbizw381v6VqbHkE7nINENf389Z5pzZ3e9z6/FkNWNV3gIph55ovKMaJNHT1oEx6k6S/OdnyWsSPr6rGPX5xoDnCfLoBVabasVg/v0cwA9xlG/7qdzdDz6mFL5VmOYtMuFbbTXnZPS1VJ8raGGHByzXD9JwzmWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755086579; c=relaxed/simple;
	bh=8UbHM8ESkqjCMP3mVGJaDboOXO5ZcaVkYdVN7ZKBqY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdIl7XDMGEnGumYnoU1ToeFmn/e2lKipesopPwSbLw+ep4y7D7V9bnep3KVm1n6mAxDKJYGe8L+wceeoXAGt50BBkq4j3C1ScF165bxLNOEwNKLl930LrTWLyljNSQHzyqzBo4PhKDXmdgs4uGla83fT5KdTzIoPrsJa9uCXO6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1pw9usUP; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bBvTyZG6Fgqwu7L3PwR5lpl1Clf/V9AbADcAOJ9Z0uA=; b=1pw9usUPRs6BSrQPnHvjDyuu09
	DhyfdnjfVaT7ne+sbOPwzYPrrzFdHRsgY/vcUPUwlD1GWBvhkbAxv027A4TrR2UkRkX+3Yntshq3e
	DLieV9lKJPEHXfvpUBEnWEbDLatehuSKTExSa9dWn0i2RWaTXAFcxvOtq7dxSbqrficTPE6qMqQjB
	88lJIvTx2kntWi1yqQsobT/6EnzMnnyHXpse4d6wRA1AF/GixczD3cREKCi0IgvwsvUe6wcLEOPpY
	5Ht6T1HJdqvMHoWEMHyAdBCanrNbK4lT51zy+EZyv1dZHn9IEJ00Xg96ky11Fc42id6nwNcOjs28I
	M55nTxnA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53086)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1umABu-0006Zw-0w;
	Wed, 13 Aug 2025 13:02:50 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1umABq-0005jb-2w;
	Wed, 13 Aug 2025 13:02:46 +0100
Date: Wed, 13 Aug 2025 13:02:46 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Daniel Braunwarth <daniel.braunwarth@kuka.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH net-next] net: phy: realtek: fix RTL8211F wake-on-lan
 support
Message-ID: <aJx-5qV7qHxk2Uxe@shell.armlinux.org.uk>
References: <E1um8Ld-008jxD-Mc@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1um8Ld-008jxD-Mc@rmk-PC.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Aug 13, 2025 at 11:04:45AM +0100, Russell King (Oracle) wrote:
> +	/* Mark this PHY as wakeup capable and register the interrupt as a
> +	 * wakeup IRQ if the PHY is marked as a wakeup source in firmware,
> +	 * and the interrupt is valid.
> +	 */
> +	if (device_property_read_bool(dev, "wakeup-source") &&
> +	    phy_interrupt_is_valid(phydev)) {
> +		device_set_wakeup_capable(dev, true);
> +		devm_pm_set_wake_irq(dev, phydev->irq);
> +	}

I'm wondering whether this should just check for the "wakeup-source"
property, which would allow for PMEB mode, and if we don't have a valid
interrupt, we set the INTB/PMEB pin to PMEB mode here. In other words:

	if (device_property_read_bool(dev, "wakeup-source")) {
		device_set_wakeup_capable(dev, true);
		if (phy_interrupt_is_valid(phydev)) {
			devm_pm_set_wake_irq(dev, phydev->irq);
		} else {
			ret = phy_modify_paged(phydev, RTL8211F_INTBCR_PAGE,
					       RTL8211F_INTBCR,
					       RTL8211F_INTBCR_INTB_PMEB,
					       RTL8211F_INTBCR_INTB_PMEB);
		}
	}

this would support example 3 in the wakeup-source document, where the
PHY is connected to an interrupt-less power management controller.

Any thoughts?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

