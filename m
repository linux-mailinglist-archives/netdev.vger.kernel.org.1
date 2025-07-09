Return-Path: <netdev+bounces-205378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AB2AFE71A
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 13:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29E5F1668A5
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 11:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685F228C852;
	Wed,  9 Jul 2025 11:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YvNUzQZE"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893442701CE;
	Wed,  9 Jul 2025 11:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059489; cv=none; b=DABH78rZ+obVP2y/nf0ruMNVipWmznJuijT8SFFcjFQKwu4rHpZ2Jeoxa48r253J0kjSfRVHcR9VgKPhNaZYbbLmiYfQuATTxZ4b8BGzXVjOu/ZHDTg8tLnohCwv3iryD58nM1jZJxFvsCJSsL2eYLj+AWwGHMosEQSBCZMeWM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059489; c=relaxed/simple;
	bh=VYDWf/aAkJYjnnaRdav3Kgh7Iq+nP304+3f+U8BMrlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M71hcCqfx3EkgjidFyo0xoloJ0WCG2sFdoGaf0yCmkJjDWDtAo97T2qexAXc9K1g4qS0J3cSOEF9YEsUflPKZ6jp24OSF0Psrrjn5aH8xmWID7bDXLmcvc6ZddjMp2zp//jlX6NUXM0pLWiXvrT/fPguYd/h2k5/ynFLJmIOVnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=YvNUzQZE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vvZq130tiT45bvyCEcIJ+K9zjA5skCS0X4i6X4l6Bi0=; b=YvNUzQZEcwdbrQV8j3ZTIqZJZa
	4HP+dnk7X61abQxSvtPEiHSu67e/O70tubpndvJGshW1wE7Rw645Ghcv6TIyLcFBige9a9uYqop0I
	R+OOU+roJBWbQIWazOyqgOYN03OH07FCTN1B+SCFOc+GyasPNYxKsT+rRiyl9Miig+bNXl/9jzseA
	Ex/MpQ1pYFn0Z9pAdk4tUwreZdx4z7qxGTsudBKN75fGUIXOFkF8Ld2b3KcO2bX2CqnUyg7K2HQls
	mQhCdO2KqiqrVlw89GJpy1CPr2OQLsJyqVOieoY5DpNj0+86Jd41OsT+AMSNe/oyayroPljcDFRWQ
	S4S+1uCw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55728)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uZShg-0007qh-2n;
	Wed, 09 Jul 2025 12:11:09 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uZSha-0002bB-1i;
	Wed, 09 Jul 2025 12:11:02 +0100
Date: Wed, 9 Jul 2025 12:11:02 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: lizhe <sensor1010@163.com>
Cc: Andrew Lunn <andrew@lunn.ch>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, vladimir.oltean@nxp.com,
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Re: Re: [PATCH] net: stmmac: Support gpio high-level reset for
 devices requiring it
Message-ID: <aG5ORmbgMYd08eNR@shell.armlinux.org.uk>
References: <20250708165044.3923-1-sensor1010@163.com>
 <52b71fe7-d10a-4680-9549-ca55fd2e2864@lunn.ch>
 <5c7adfef.1876.197ece74c25.Coremail.sensor1010@163.com>
 <aG3vj1WYn3TjcBZe@shell.armlinux.org.uk>
 <5bb49dc0.6933.197ee28444e.Coremail.sensor1010@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bb49dc0.6933.197ee28444e.Coremail.sensor1010@163.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jul 09, 2025 at 03:48:25PM +0800, lizhe wrote:
> Hi, 
> 
> after replacing with this function, the function returns 0, meaning the gpio is
> still at a low voltage level.
> 
> +              int gpio_state = -1;
> 
> 
>                 if (delays[2])
>                         msleep(DIV_ROUND_UP(delays[2], 1000));
> +
> +               gpio_state = gpiod_get_raw_value_cansleep(reset_gpio);
> +               pr_info("gpio_state: %d\n", gpio_state);
> +               pr_info("gpio_state: %d\n", gpio_state);
> 
>  gpio-111 (                    |snps,reset          ) out lo
> 
> 
> [    3.899319] gpio_state: 0
> [    3.899324] gpio_state: 0

How have you declared the snps,reset-gpio property in DT?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

