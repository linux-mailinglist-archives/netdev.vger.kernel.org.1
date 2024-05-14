Return-Path: <netdev+bounces-96297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BAA8C4D99
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 10:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9432B1C20DA7
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 08:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056B717BDC;
	Tue, 14 May 2024 08:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ScVB/UTZ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3688217BB9;
	Tue, 14 May 2024 08:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715674798; cv=none; b=FRmcBGHhm9+8vZOycUt7jqPU1ZIVi8mN/folc7xcX/YMERfbVl25r7qWaZDZ2wQWleR7+jV2Mes9TtoFR8AS6KYtAA3fo2oPiWWSPhuR4WGLhOuySxe13W2cbeDeLT9ocQDHq7Rhqm3r8jRCsWLFJJdgNn4p+ZEQBLRPQhXR8Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715674798; c=relaxed/simple;
	bh=QQXv5Hu6cWT+R0cdcaSP5wtju3lA2aIuhqCIT3QXfKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVdvryGp9SejXk8f45wTNqgqxxnQ4il2L36Ct3N/Hf8YfEsMh6weZhtuhy5BO3pAwfOlicq5jdu3cE3JEw5jm2EOHegurtpULZ8OIrQHhZaRkm/ZwHeFtFRHUQLWTAcAg15siDiEkZtXYoczc+W/sP4T9rPxKcK7jHzffC8zE4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ScVB/UTZ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ea1x5TthVhL/eZxigK69/rLLPNFPYqSPY6iTUTHpgq0=; b=ScVB/UTZKYfbLIhP88h9zRctxV
	QhxOy/qSNv1dFvvhYjvTjEP3YGli81IMYiketsStZ35DwUthRMiQ32DfQR4gkD2x/otafT7by4P6o
	7GW/s/wrPtRqXkRi5vUazwBx/K3c3lzoJdVpYm0a1XSDXpeCTEh+DGaPYISnuahl8ZySHq495Ysit
	FAlY7GuDF9elqWyfjQJY4txqyF2D4FLPBiALxM3Pg+NaA7Ji5pPbSXrSiOADkRWd0eDX+FiLyOK74
	+BzSodPafKVsUERvgUevmNWxaMmVGbbYQU3eov/lx3WECstH+vs7Djr3479CTv1B87L1zWrOw0/4T
	py35oo2g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58764)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s6nNy-0002jd-0i;
	Tue, 14 May 2024 09:19:46 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s6nNw-0006vW-Hl; Tue, 14 May 2024 09:19:44 +0100
Date: Tue, 14 May 2024 09:19:44 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, bcm-kernel-feedback-list@broadcom.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2, net-next, 2/2] net: stmmac: PCI driver for BCM8958X
 SoC
Message-ID: <ZkMeoB05cV/pK89B@shell.armlinux.org.uk>
References: <20240510000331.154486-3-jitendra.vegiraju@broadcom.com>
 <20240511015924.41457-1-jitendra.vegiraju@broadcom.com>
 <4ede8911-827d-4fad-b327-52c9aa7ed957@lunn.ch>
 <Zj+nBpQn1cqTMJxQ@shell.armlinux.org.uk>
 <08b9be81-52c9-449d-898f-61aa24a7b276@lunn.ch>
 <CAMdnO-+V2npKBoXW5o-5avS9HP84LV+nQkvW6AxbLwFOrZuAGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMdnO-+V2npKBoXW5o-5avS9HP84LV+nQkvW6AxbLwFOrZuAGg@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, May 13, 2024 at 10:32:19AM -0700, Jitendra Vegiraju wrote:
> +==================================================+
> Since the legacy fixed link cannot support 10G, we are initializing to
> fixed speed 1G.

Or to put it a different way... "I can't represent my hardware so I'm
going to hack around with the kernel in a way that lies to the kernel
about what the hardware is doing but it'll work for me!"

Sorry, but no, this isn't some hacky github project, this is the kernel
where we engineer proper solutions.

I think I've just lost all interest in this... 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

