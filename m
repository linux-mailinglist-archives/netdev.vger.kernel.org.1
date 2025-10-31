Return-Path: <netdev+bounces-234666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB52C25C10
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 16:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48B3C4613EE
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 15:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E00029992B;
	Fri, 31 Oct 2025 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hotEvunY"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1B3283FE6;
	Fri, 31 Oct 2025 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761922844; cv=none; b=ojkWYoLhbFcHEb96SNmCnXJT1S34Tbq3cFTz3Bt7uw+bW6ll7A9hh1NZdBz6MzcE+aJ8Pn1dPJuJjAvz7HRdAr9VezZxv79cY36vJTLJwdvnXtK7U2xxK9gOLcgZCWHKN3X6Yczld/O0DmW5YlmPUDokBuoatdpre5henpV0Rr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761922844; c=relaxed/simple;
	bh=K2JkzXJyto64vFIMGACLhIM7SQhDaRpjDaTlRGAPssU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlERKZ9pm3akq4EJEeEzYGur7YkiBqMnva6mbd/YhYJC+kN2IOO040NkgWb4qyro8wxs27BmLu0lSBSA2LIzuMSrkvbBJZTLYvtZm6Y7qXB9rvN/uHQHWglJ/60uTihN2eQfoQS1GO1LEjzY394qIAljB3jLinaD9Pc6b+dpHzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hotEvunY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7Q4Twy4Y1QOfkJL+S+cNyBpbzf2AU2ulqu3nqATyQik=; b=hotEvunYFMhfYxplPP5MSJzCoy
	SFLpp3ZNUYJu1cd/JKzzr75UynwUYqsxhPnapVJIywt4aM3ahRdyNKCePKKq602QGGfs5hQWK/+Ot
	ZuPOwH4Wvw9Yufis4QVavftXiH9cupui4tQpDI6DX/GtMyrz9Vk3dOuIFm45OVWExxoVBfCvp62eA
	Cqj0EGRa/lPvTdo41G92b2kPUsUd6/kmIrHlEw9UwMhoJo1X/tjSobMP9ealozLx35Eczvf4TPmBL
	Tug2C5mB8rQESSd8foSgy93Qgj1vYpCjOXdDpYAry6vFmJNMDi4nLrpqmODpZsQQKgt7X93yNLB6S
	RMnjh7Ig==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47922)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vEqcF-0000000072f-43PF;
	Fri, 31 Oct 2025 15:00:36 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vEqcE-0000000013a-3b1q;
	Fri, 31 Oct 2025 15:00:34 +0000
Date: Fri, 31 Oct 2025 15:00:34 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 2/2] net: phy: micrel: lan8842 errata
Message-ID: <aQTPEu5LBJMabjy8@shell.armlinux.org.uk>
References: <20251031121629.814935-1-horatiu.vultur@microchip.com>
 <20251031121629.814935-3-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031121629.814935-3-horatiu.vultur@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Oct 31, 2025 at 01:16:29PM +0100, Horatiu Vultur wrote:
> Add errata for lan8842. The errata document can be found here [1].
> This is fixing the module 7 ("1000BASE-T PMA EEE TX wake timer is
> non-compliant")
> 
> [1] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/Errata/LAN8842-Errata-DS80001172.pdf
> 
> Fixes: 5a774b64cd6a ("net: phy: micrel: Add support for lan8842")
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Same comment.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

