Return-Path: <netdev+bounces-195481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8BBAD06ED
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 18:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36B227A940C
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 16:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4C32868A7;
	Fri,  6 Jun 2025 16:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cfvTSh0P"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2591B199E89;
	Fri,  6 Jun 2025 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749228413; cv=none; b=fhN8FTa6HsdRk1Nm1inadsKcp6k31A2DmLpHq1zrWPLIhxcsZw/FMXUVhWL85wNNsNbLNFLLRvMOfVnyO+8eoUBaUANECUZUG2kbOMLJuHdetRpG7rbmU6diOdXryiTsCQ7k0uDDnRzN+vGB0fQGLptiGfnHgOcQ7aCSGtXgPuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749228413; c=relaxed/simple;
	bh=6xq/oyb8A+TRQohcI41rVqLHpVK5LY7V7ZyDGoVetRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzpewafBXE8BR+cnxgJ4+/VRarI+LrBCRxyPSMnArZvPjqZgec5lHESYNqgZh2jLtxO1Vlyf1dN+JiaY9/i3oL9qyobm+GPheYMQ9v/EMDnszr3dEhYftDx5rQ2taXTjjiHVjOCasJk6yqpaI7Hz/I7+cA2gzAIFSff6XioSbQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=cfvTSh0P; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2eUBIbHOyubhcMWsju0QiqId4ceda0lLxT+x5k6pgFw=; b=cfvTSh0Pta9FD6eps3ExyBf/CW
	s1Apbuv7hChaGWh5vSuISL+v49r306D2m8jc2CWArFHuv5h7OhpNCxjWKFBBd1baE9QRHx+SUjxcr
	3yyBBEwfR6ZIbjiXPPoBZUcQmbcnlIiB7ZGJcYdG8FuUPvRvY11Xk7GxqFNw9yAuxTJLOCQz0qqwa
	yc4qKRCcakewftXRbtwmA6dXIqY88psUc1NZTpaVbfUo1qWOFHfb1whQotq4kix6Lp9WdAzAjP/Mv
	z/KUtfdLc3mqmi/wF3JQGkJkMdNzx22yCHm/YFUngaOuyLbEtNFzVhzx0o1PtGufdxkHv0+/yF1mt
	e3c4k3dg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60438)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uNaD9-00010W-0F;
	Fri, 06 Jun 2025 17:46:32 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uNaD4-0003Mt-23;
	Fri, 06 Jun 2025 17:46:26 +0100
Date: Fri, 6 Jun 2025 17:46:26 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "Xandy.Xiong" <xiongliang@xiaomi.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Furong Xu <0x1207@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: add support for platform specific config.
Message-ID: <aEMbYjmsMUqdsvP4@shell.armlinux.org.uk>
References: <20250606114155.3517-1-xiongliang@xiaomi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606114155.3517-1-xiongliang@xiaomi.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jun 06, 2025 at 07:41:55PM +0800, Xandy.Xiong wrote:
> This patch adds support for platform-specific init config in the
> stmmac driver. As SMMU remap, must after dma descriptor setup,
> and same mac link caps must init before phy init. To support these feature,
> a new function pointer 'fix_mac_config' is added to the
> plat_stmmacenet_data structure.
> And call the function pointer 'fix_mac_config' in the __stmmac_open().

We need to see the use case for any new hook.

I'm afraid we've seen way too many cases of new hooks added to the
kernel tree only to never see their corresponding implementations
come along, so now there's a requirement to post an implementation
along with a hook.

Also, please review the netdev FAQ, if you can find it... I can't
anymore. It'll tell you how to submit patches, when to submit them,
how to indicate which tree, etc.

You can find the source file for what I think _was_ the FAQ at:

Documentation/process/maintainer-netdev.rst

but this doesn't seem to be in the documentation tree on kernel.org
(or at least is not in an obvious place.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

