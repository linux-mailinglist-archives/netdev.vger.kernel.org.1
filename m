Return-Path: <netdev+bounces-142977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C119C0D44
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 18:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FC321F232E8
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEC62170C9;
	Thu,  7 Nov 2024 17:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XLVZ4gSe"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD13216E1B;
	Thu,  7 Nov 2024 17:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731001879; cv=none; b=JovFYJnbo8fSPmuK5OBiJCaEt9sQUBwyxShsGI+tG91UniW3VHVHTJIJT09yZ/DknaRI6Q1WoyztIim5wxIhVJ2tlgHwetqlDvbuvbAft6+sFWQL3bfwHNXa7llik9KTpBPxolx5cMLjaxDi+oaW0Fwxqwa7Hh8LhuWMJ5BI10k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731001879; c=relaxed/simple;
	bh=h09SlzBjsMOpNTxOjIGgJnsIz4PPHohRSdHWl7WjL2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcrlL+rlzoIxouNo9ecRqnRw6jnnE6xn1Ki5/VkekGl3SyxTjfBMEWAMEfc3pSPXLRQQMWBXl1pN9CcPVNts1Pa926wSyNGWqQU9Yf/7EWDAVDrDqOI2p/Q2816jFhW+xDwSJuxjex1B38tVVVqQbTGx1wr8ja4nJwltgFCrmMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=XLVZ4gSe; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3ZjI5bVISFgrCE/xP6ZKnp6e6AW65IJOtxsC7dqm3II=; b=XLVZ4gSeBQYGLf2fIefGLyZsDy
	nqeGeXQpxeRgb1XHS3+SkVu8898FvRotg9X1lpbvV6SNqEC7qo9v/3uFy5IOGz5poFykhbQ1gMDHy
	k7NTwhJwg+t0hztPbCGEA3Q27VOof4QFyh9JcCWWC1jKPkBeyoV6dZ0DFHEGgYX5msqaRADS0CbEi
	MYna/+GKPnuA6CI/8d2P0En0pHPpQedYGEFytM08SJcRdVLRuHsE7BjdtD/h/hNH1HzuOd1W+LSAO
	CvmAaVPrnKTgjgSgXhAYOBjihghvb5QEdKChyLgk+L+hAHWWf3XcKuHcAHbkuq3hfJYFaKdsQ5O2R
	/xIkojSg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48104)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1t96ez-0003aF-08;
	Thu, 07 Nov 2024 17:51:09 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1t96ev-0001TM-1g;
	Thu, 07 Nov 2024 17:51:05 +0000
Date: Thu, 7 Nov 2024 17:51:05 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Herve Codina <herve.codina@bootlin.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next 2/7] net: freescale: ucc_geth: split adjust_link
 for phylink conversion
Message-ID: <Zyz-CcO1inN06mtm@shell.armlinux.org.uk>
References: <20241107170255.1058124-1-maxime.chevallier@bootlin.com>
 <20241107170255.1058124-3-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107170255.1058124-3-maxime.chevallier@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Nov 07, 2024 at 06:02:49PM +0100, Maxime Chevallier wrote:
> Preparing the phylink conversion, split the adjust_link callbaclk, by
> clearly separating the mac configuration, link_up and link_down phases.

I'm not entirely sure what the point of this patch is, given that in
patch 7, all this code gets deleted, or maybe moved?

If it's moved, it may be better in patch 7 to ensure that doesn't
happen, and move it in a separate patch - right now patch 7 is horrible
to review as there's no way to see what the changes are in these
link_up()/link_down() functions.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

