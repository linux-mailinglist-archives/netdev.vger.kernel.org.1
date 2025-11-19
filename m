Return-Path: <netdev+bounces-240099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F4098C7074D
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 18:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9899D3423DE
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 17:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1AF359FBE;
	Wed, 19 Nov 2025 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="v5CvUAkT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9743612E8;
	Wed, 19 Nov 2025 17:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763573052; cv=none; b=Xo9zGxN+kG26bX8qD4VaYuJkBr/Ehba1jWGEftheegz7d9Du4iLV+sKvGMmLj31JtABUt8167OMvw91LvX9L5xvTPwLcHrF7uEfuieQA6J5FS6S19zEJ8Wl+Tu+ROO21rUPf77GSQyrqrnyLSC1/6CeTW9jDB5+cVLqLcKSsTqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763573052; c=relaxed/simple;
	bh=c+CxTfJFAihZfmb8pM44lVO6CKJsjHPohT3hdCYU5yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfV1EaAu+P3ZAxa/YaC5r2ZRh7OR5a+rxjNPXl9pwOGDEjL97veKX0aF1C3xthNtg+OTkHDCj5YteGa/DzorgHOdDfu1fgi0tqIvVrseiu81QEf6fXjqgGmRUYQpOY5XeiavD16Qm2B13OIR5DirxmwdUPaj4DzeurT3mTnHFSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=v5CvUAkT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Wn6ONkRCeRKKhGAlDyEAqfV/PcLRTJSDP9TT9+pdRJM=; b=v5CvUAkTlRoZdxsyNwJJf37vPy
	Rlew48/9J/wyYHxHK8KiD95VOftwrpxjPuRYPAgtv9iBmIyK+5z3jPQ38K+++DWJBzWLrq53/lT0T
	7BY68SDPNNiYS06hNCQ7YhjUVw0J0XOCC/Gk4kkJNtpalgRW1mt2xILpAVyHKjOHz6A3cG6rhExiQ
	hZgs1kxiZKdb5moHEdM7nIWlHwZTgalIwiNzygHZnIr2D5b+2JpVDK31jN0/eBHkK7PIsSBrnuH1D
	+gR1A9f+Lvvz+3WyLtHIipFnpFZ8N1Hwe7Qzhj0DygS/799lRY/87gD3v95wZaVs3CHB5LAWEHQ2u
	INBhESjQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46206)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vLluK-000000005Gr-3FgI;
	Wed, 19 Nov 2025 17:23:52 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vLluH-000000003ay-0KzU;
	Wed, 19 Nov 2025 17:23:49 +0000
Date: Wed, 19 Nov 2025 17:23:48 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 14/15] net: dsa: sja1105: replace mdiobus-pcs
 with xpcs-plat driver
Message-ID: <aR39JBrqn5PC911s@shell.armlinux.org.uk>
References: <20251118190530.580267-15-vladimir.oltean@nxp.com>
 <20251118190530.580267-1-vladimir.oltean@nxp.com>
 <20251118190530.580267-15-vladimir.oltean@nxp.com>
 <20251118164130.4e107c93@kernel.org>
 <20251118164130.4e107c93@kernel.org>
 <20251119095942.bu64kg6whi4gtnwe@skbuf>
 <aR2cf91qdcKMy5PB@smile.fi.intel.com>
 <20251119112522.dcfrh6x6msnw4cmi@skbuf>
 <20251119081112.3bcaf923@kernel.org>
 <aR3trBo3xqZ0sDyr@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aR3trBo3xqZ0sDyr@smile.fi.intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Nov 19, 2025 at 06:17:48PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 19, 2025 at 08:11:12AM -0800, Jakub Kicinski wrote:
> > On Wed, 19 Nov 2025 13:25:22 +0200 Vladimir Oltean wrote:
> > > I think it's due to the fact that the "contest" checks are fundamentally
> > > so slow, that they can't be run on individual patch sets, and are run on
> > > batches of patch sets merged into a single branch (of which there seem
> > > to be 8 per day).
> > 
> > Correct, looking at the logs AFAICT coccicheck takes 25min on a
> > relatively beefy machine, and we only run it on path that were actually
> > modified by pending changes. We get 100+ patches a day, and 40+ series,
> > and coccicheck fails relatively rarely. So on the NIPA side it's not
> > worth it.
> > 
> > But, we can certainly integrate it into ingest_mdir.
> > 
> > FTR make htmldocs and of course selftests are also not executed by
> > ingest_mdir.
> 
> Btw, do you do `make W=1` while having CONFIG_WERROR=y?
> And if so, do you also compile with clang?

If you look at any patch in patchwork, e.g.

https://patchwork.kernel.org/project/netdevbpf/patch/E1vLgSZ-0000000FMrW-0cEu@rmk-PC.armlinux.org.uk/

it gives a list of the tests performed. In answer to your questions:

netdev/build_clang 	success 	Errors and warnings before: 1 this patch: 1

So yes, building with clang is tested.

I can say that stuff such as unused const variables gets found by
nipa, via -Wunused-const-variable, which as I understand it is a
W=1 thing.

I suspect CONFIG_WERROR=y isn't used (I don't know) as that would
stop the build on warnings, whereas what is done instead is that
the output of the build is analysed, and the number of warnings
counted and reported in patchwork. Note that the "build" stuff
reports number of errors/warnings before and after the patch.

Hope this answers your question.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

