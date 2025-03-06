Return-Path: <netdev+bounces-172487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0F9A54F6A
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 16:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F1416A329
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 15:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1143F20E703;
	Thu,  6 Mar 2025 15:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zg5fWzzg"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00B7148FF5;
	Thu,  6 Mar 2025 15:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741275887; cv=none; b=fYQYxO63SXqApByXCT8A8Nvd+PlDkKti0xdhGyIeKi96sqkmZ4OfPoagEkNjO34NzV//s6xljsMz16DyZHyE2CSVA7nwXxTOfxAV/14d8gNmKhGhL/R5ML9jnCyHe1Mp1PmroLHX3V51Zgol62V4mGBEug36t/6ZfKbjGxN5FqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741275887; c=relaxed/simple;
	bh=aixKISa0kyko036hL5V+qG8LL9qF3VO6FIAxvZvxJ70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1b5oS+VmPT+Smfy7w3WnN2IzyEnfQjqxaUjsr4H7gYWaLAhLC/SLMV/8oie7uA4AWxOtXBVAMc8lFsYMABDbk/LckkKHB8qFsdT9oiizCTQ7uWXXJmReKFq/dlPGkP23EFOVqoFzkqhl8sAxemuenXQUdMzYnFLx7Gnn9mG390=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zg5fWzzg; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iqLTGgFW/Idb/RWJchf5+oj54Xp1Xr/3EggXQFnKjbg=; b=zg5fWzzg0ciofiTPI5rB/vbzNy
	WfPtrhrK/GWO2fk4YllvIpM+OR9zwj+nAcHdFxGejKYSLJxFb14lamIUz029dUennkO+S/8xVwuKc
	pWpGlU0OakPqbwkewGvaK7xfdpzRob+q6JwaxaXhNoWbqP9Op+aRtpsOdJre4ZOSQX1nrxyDbY+36
	dwWYXr59SJGNLnf9PF1mlryhiM4aHClD6+aAm22Y4/shvpvQn0l2CNkrHW7lUv7g6/QFOfOTssfz+
	4myjdw/1c6uQYOEnEyXLxfIhfWMGyWFfhFtY6V5aE6sU8xkDUpYR9cz8mguYi05IG5uCLynbEIjiF
	Xtu/bAfA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36454)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tqDOj-00067c-2X;
	Thu, 06 Mar 2025 15:44:33 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tqDOh-0006uz-01;
	Thu, 06 Mar 2025 15:44:31 +0000
Date: Thu, 6 Mar 2025 15:44:30 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Thierry Reding <treding@nvidia.com>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH RFC 0/5] net: stmmac: fix resume failures due to RX clock
Message-ID: <Z8nC3vvZWAl5_8WZ@shell.armlinux.org.uk>
References: <Z8B4tVd4nLUKXdQ4@shell.armlinux.org.uk>
 <f783cf9c-9f79-4680-a6e9-d078abbd96ec@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f783cf9c-9f79-4680-a6e9-d078abbd96ec@nvidia.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Mar 06, 2025 at 11:30:53AM +0000, Jon Hunter wrote:
> Hi Russell,
> 
> On 27/02/2025 14:37, Russell King (Oracle) wrote:
> > Hi,
> > 
> > This series is likely dependent on the "net: stmmac: cleanup transmit
> > clock setting" series which was submitted earlier today.
> 
> I tested this series without the above on top of mainline and I still saw
> some issues with suspend. However, when testing this on top of -next (which
> has the referenced series) it works like a charm. So yes it does appear to
> be dependent indeed.
> 
> I have tested this on Tegra186, Tegra194 and Tegra234 with -next and all are
> working fine. So with that feel free to add my ...
> 
> Tested-by: Jon Hunter <jonathanh@nvidia.com>

Hi Jon,

I came up with an alternative approach which should make this safer -
for example, if the PHY remains linked with the partner over an
ifdown or module remove/re-insert.

Please see v2 of "net: stmmac: approach 2 to solve EEE LPI reset
issues" which replaces this series.

https://lore.kernel.org/r/Z8m-CRucPxDW5zZK@shell.armlinux.org.uk

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

