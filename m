Return-Path: <netdev+bounces-221613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EE7B51354
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 11:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17ADC188EC31
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 09:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05966314A9E;
	Wed, 10 Sep 2025 09:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="RwzL2ROA"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A06B25771;
	Wed, 10 Sep 2025 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757498261; cv=none; b=a0syVUwYacLkoIb6FbcQrIkSgO/cLB3dfwZMDX7XexCCgs2gdbG7APvnwTL/TsHPatDNOxjbDmaPLjWUjQlJwI1eNbcAoQe4GdRhy4tcSPw3D9TwscVcCknfDjdN9zCvuO0zZQp/3bkOvD1LwX7fukC0lIQqN4cSYTUALyHXbos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757498261; c=relaxed/simple;
	bh=P4ej+3A+Iyp7JyhajhEF8Z9mZpG0Xa99HNWlv60xFn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJxtw1RKTZdcnWfLh8i/bBgLv+r03lrffHGz6hDpeBFviYItwFiuJBeD3jlchzs4oDxoxFP6hjk9SVc9fU8/U3QAGAOUoXaUGFmIWGY8OC4a/yButEbLkegMGnl3cviqU/cwTxsU6rvkKEwsnGOEUTKILrsLy/DdpBMGC/Apta4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=RwzL2ROA; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=601O/6NcYDYFYDwAkPHaLCrx7FThiMsVN77zsHJHI+Y=; b=RwzL2ROA7UH4SVTDFFso/hDqL/
	qUHoKyZMWQqXSQc7e1N0J0Txq2JpYlE2SJb4ritw1hY0dWv02Ps4PQGLBZ+FqvuzJ2sU4X37If4qe
	XN9ry3zmulz+nr4Rg9c67dWvQbHxwPq6IMDfLErdEtREn8hwN74cK5mELqEyE02I+ou4ATvKRdozE
	OWrTDWJ3+4LLo4fIndnKcg4Av3paa4QC+PDXr47UBx/0oPvO2S6+woTLrWBCK0n2mVMe5PW4WDtRm
	EK8MJHZ3rBbY6qvor5BeaXBj0E03bUYtKjJ48L74poC6qlGJYE6owAIMFxRGPxPyvMbqFq4Efa40W
	b/Ozoq2g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49204)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uwHa2-000000001TW-1eF8;
	Wed, 10 Sep 2025 10:57:34 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uwHa0-000000001If-1O1n;
	Wed, 10 Sep 2025 10:57:32 +0100
Date: Wed, 10 Sep 2025 10:57:32 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: yicongsrfy@163.com
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	hkallweit1@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, yicong@kylinos.cn
Subject: Re: [PATCH] net: phy: avoid config_init failure on unattached PHY
 during resume
Message-ID: <aMFLjHDH71fTwLwj@shell.armlinux.org.uk>
References: <20250910091703.3575924-1-yicongsrfy@163.com>
 <20250910093100.3578130-1-yicongsrfy@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910093100.3578130-1-yicongsrfy@163.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Sep 10, 2025 at 05:31:00PM +0800, yicongsrfy@163.com wrote:
> One more point: in the suspend flow as shown below:
> `mdio_bus_phy_suspend`
>     => `mdio_bus_phy_may_suspend`
> there is also a check whether `phydev->attached_dev` is NULL.

Yes, it checks, but only to bypass checking for things that are
dependent on whether a netdev exists. It doesn't _stop_ a netdev-less
PHY being suspended. What you're proposing _stops_ a netdev-less PHY
being resumed. You are proposing to break stuff.

> Therefore, my idea is to make this modification to maintain consistency in the logic.

No, it's making inconsistency. mdio_bus_phy_resume() will only resume a
PHY that has previously been suspended by mdio_bus_phy_suspend(). See
the phydev->suspended_by_mdio_bus flag.

Fix the motorcomm driver.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

