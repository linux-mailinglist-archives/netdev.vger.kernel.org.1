Return-Path: <netdev+bounces-234315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2078AC1F4D9
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F410542408E
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 09:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE13C340A67;
	Thu, 30 Oct 2025 09:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="l7+NTHKV"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAAD1E86E;
	Thu, 30 Oct 2025 09:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761816671; cv=none; b=l43gHX77hkUnzUGlka0lptu08y9OKwKJVB0TPCluZPG/X9CHfYERLBA4VwH69g+PV+NiO+6ueXqtKtyfWp+GQ0KQUTE4Lb4D93AL35/cNEk5/8Bw7quXPSMTW5M4PtLaEoPq7z+KLxCnO9V8vZMObGFf4BDWUD6tll4OsLm139s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761816671; c=relaxed/simple;
	bh=S9vnukJqqQFeVIZv9g+eyCejMpmOryovcxfdpb6l6oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yl3NaFhLpcWjEDdAHv3KfvzAtmeT/grmwNJCi/NTUGBsbx59fwJ+HDWGtFjN0SFqJbcWT6GO946VuneHd2fFtUWw3OczL1CoJ4Q2XotWjVE+4wIKxIAdSc1/zDxAGFtYEUsZ1ZFsBbTSrhNORFWAY89b2li+QkCd8l4Y0jgnt0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=l7+NTHKV; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dU5NC2LzF5pwIftbZXjx3Tu7KIS3tnASuqHrZod6Uhg=; b=l7+NTHKVWYrIr2lj0x8o8cotLn
	q6x2b72/5bTqwvje7QfVoxYA2AC8U9H+ICES4uiiUHdDaAA92N9/W9llCEDhrTv+wRjJ0pNgIi7d9
	aOMm5tS2/D0K5TzJ2vrp02VjH/paqpjZeCBrZBzgzGoQlYNTjbrCJodTHygp60fnYAvtFKYwe9jDm
	CaDdvqT/A+dE+R9KSoBDKqDRmuRkDEGbJb9hlX+IwKhyoJb3CP3MU7UZxT7phCxPTVa2GJW97udNI
	RgK4VXpZ/M7pZFJ4ikDUPMusWdXNoL8PFFAHp6RFIGbyeGqoUsqdWSSg/NR0XFV6v1O7SwfOTVi06
	crMNcpyQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46092)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vEOzS-000000005R1-2LYs;
	Thu, 30 Oct 2025 09:30:42 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vEOzL-000000008LF-40VT;
	Thu, 30 Oct 2025 09:30:35 +0000
Date: Thu, 30 Oct 2025 09:30:35 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Yao Zi <ziyao@disroot.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yanteng Si <si.yanteng@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Qunqin Zhao <zhaoqunqin@loongson.cn>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Furong Xu <0x1207@gmail.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] net: stmmac: loongson: Use generic PCI
 suspend/resume routines
Message-ID: <aQMwO9rJnA6THW3M@shell.armlinux.org.uk>
References: <20251030041916.19905-1-ziyao@disroot.org>
 <20251030041916.19905-3-ziyao@disroot.org>
 <da8d9585-d464-4611-98c0-a10d84874297@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da8d9585-d464-4611-98c0-a10d84874297@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Oct 30, 2025 at 08:38:12AM +0100, Maxime Chevallier wrote:
> Hi,
> 
> On 30/10/2025 05:19, Yao Zi wrote:
> > Convert glue driver for Loongson DWMAC controller to use the generic
> > platform suspend/resume routines for PCI controllers, instead of
> > implementing its own one.
> > 
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  1 +
> >  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 36 ++-----------------
> >  2 files changed, 4 insertions(+), 33 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > index 598bc56edd8d..4b6911c62e6f 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > @@ -373,6 +373,7 @@ config DWMAC_LOONGSON
> >  	default MACH_LOONGSON64
> >  	depends on (MACH_LOONGSON64 || COMPILE_TEST) && STMMAC_ETH && PCI
> >  	depends on COMMON_CLK
> > +	depends on STMMAC_LIBPCI
> 
> If we go with a dedicated module for this, "select STMMAC_LIBPCI" would
> make more sense here I think. The same applies for the next patch.

Yes, we need it to be this way around at least initially so that
STMMAC_LIBPCI gets merged into people's configs.

I'd eventually suggest going the other way.

We already have:

config STMMAC_PLATFORM
        tristate "STMMAC Platform bus support"

if STMMAC_PLATFORM

... platform based drivers ...

endif

... three PCI based drivers ...

I'd suggest we do:

config STMMAC_LIBPCI
	tristate "STMMAC PCI bus support"
	depends on PCI
	...

if STMMAC_LIBPCI

... PCI based drivers ...

endif

There's no need to make everything depend on STMMAC_ETH, there's an
outer "if STMMAC_ETH" around all the platforms already.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

