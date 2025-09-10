Return-Path: <netdev+bounces-221588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2A7B510F1
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 10:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E53B61C200F1
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 08:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F81430DD0F;
	Wed, 10 Sep 2025 08:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pMyHq+Gb"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E052D0C78;
	Wed, 10 Sep 2025 08:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492182; cv=none; b=YDlko3MCOv1W47lh+6TG/NJ6f8UOfxdZjvxK34ZrLWWC6OguBcAcT5d8rSQ4DDqliMmKQbyxXCRckYHV7Hem1moWV7/agmSBMF2XSYCpCByGAkrP9CACeHHyugHWqsBNpmyysNnoqYp0boGV0T4dXPWrEFS2XzTB1s6zpsGu3xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492182; c=relaxed/simple;
	bh=VXvpfErYuphEm8gkywzlYT1m2RlswIgPxzQfgxnan3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7exxvFWn3Bu7PsEIMNtvDmq6UZk/a0lCknIcz6fHgHMLf5lSy8+twrPPcgNHrCxOB1NsylF9fctzzXGWDaKaccW9uD3gUYkUG0jB5sonlrOJV8TEMrkAkRxZyoLfPhLBDXW+brmvsHDqpMCUc0GnPTjTBmtxDJjIIRzeBBJST8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pMyHq+Gb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1L8uPeYANNO4SmuzyyPj4qmYwusIcBdWqyA0DwPuArM=; b=pMyHq+GbnzCEfZITkR7QEbkxzV
	xob6ep8BmPVw09lorfzGJK3SPPRMCe+fLGwhd5a/4cwD138XPWqoGZ0bNZXkySj3i6tQs5NGJOObG
	yYIcM5VotmF/CTDs/ikm1JLr84Eg++g3zjOthBpevO8Rhqks+YDIplDF2VWQS9YJdVjvuqtYYb7zX
	KYhozppFRiUUaRre8l7gCwajOVRhZRGImyVpwmF9TgMSkACJdl6M+AjYDbSeI9mi8iJtY6O1qg6Vl
	3+K6JNbzhISqSIHKuUDCzHpnt5rdhiZXUowOQQ3szuFcSsMHPsX4ylN9WM1W5EpoV8xJ8Fd+jedCd
	oToqvKVA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49442)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uwFzq-000000001Ko-41AY;
	Wed, 10 Sep 2025 09:16:07 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uwFzj-000000001FR-3wf1;
	Wed, 10 Sep 2025 09:15:59 +0100
Date: Wed, 10 Sep 2025 09:15:59 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: yicongsrfy@163.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	yicong@kylinos.cn
Subject: Re: [PATCH] net: phy: avoid config_init failure on unattached PHY
 during resume
Message-ID: <aMEzv50VmUb2eUMQ@shell.armlinux.org.uk>
References: <20250910025826.3484607-1-yicongsrfy@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910025826.3484607-1-yicongsrfy@163.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Sep 10, 2025 at 10:58:26AM +0800, yicongsrfy@163.com wrote:
> From: Yi Cong <yicong@kylinos.cn>
> 
> When resuming a PHY device that is not attached to a MAC (i.e.
> phydev->attached_dev is NULL), mdio_bus_phy_resume() may call into
> phy_init_hw() -> phydev->drv->config_init(), which can return -EOPNOTSUPP
> (-95) if the driver does not support initialization in this state.
> 
> This results in log messages like:
> [ 1905.106209] YT8531S Gigabit Ethernet xxxxmac_mii_bus-XXXX:00:01:
> PM: dpm_run_callback(): mdio_bus_phy_resume+0x0/0x180 [libphy] returns -95
> [ 1905.106232] YT8531S Gigabit Ethernet xxxxmac_mii_bus-XXXX:00:01:
> PM: failed to resume: error -95
> 
> In practice, only one PHY on the bus (e.g. XXXX:00:00) is typically
> attached to a MAC interface; others (like XXXX:00:01) are probed but
> not used, making such resume attempts unnecessary and misleading.
> 
> Add an early return in mdio_bus_phy_resume() when !phydev->attached_dev,
> to prevent unneeded hardware initialization and avoids false error reports.

PHYs are allowed to be attached without a net device. Your PHY
driver needs to cope with this condition.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

