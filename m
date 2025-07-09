Return-Path: <netdev+bounces-205262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62001AFDEC3
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 06:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4B2916B7E3
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 04:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985E31E521A;
	Wed,  9 Jul 2025 04:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MsmRFSig"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C1C29D05;
	Wed,  9 Jul 2025 04:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752035131; cv=none; b=ff+NbD4WyWyAU53mh6qcTzHf0gVYRk83ployPTQcdwsujgXqXW4kL8vKBS288OtgRPybPJ9QiHV1b2eY/u3z3lGJ9vqB5eo+DAEruvMN+N5XhCKc4CscwTx2uKBCzuuWXpxUsX2+TP3A/U9jnOWmZGKCnS4IXCRL8NGueiNzrig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752035131; c=relaxed/simple;
	bh=gsgp8/vgeHGjM6XpFgNr2Zi7Omy8rgp1/hLWZF7YhsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnih3J90UhigLBMc5JbdzjP3ctB0epRGn3g5hlE7okACcF5006aZ1NWIFmrdBG6eES1QUntsIReJbXjialtGRCh+U9bqh5mAUTRd1f8ZO8vA3k7W2fWZRsTQjcoUbACAKE731shPkTUzs5T3A3C7SY3yBc7z0bf/RqQ69JVb1NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MsmRFSig; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aQhCFUQXqPLefJ8ih+mruiWIMzk9Nrdb8hgYrHL70VE=; b=MsmRFSigcjwHp0/QI7Y+z2ad1J
	OzLRdnjHBrSem8CT+BNtEr0BbPkjhzGoFsa1LbsaUYxWHeXYMcJVKktOo9a9MV4eqJdtbiAut7gV5
	lnpQ+Q1frb/YoQaniLYJiURHOU+AmNJHwZpEyC+Pvb4ZI2PtUNsTUVwIpjIImJHU2Z1EDk5/9kCyG
	19W6fUV9LeNj9HoVjeF4J4VjtLPkWFQBdniGEckrsA1QYBjmRJB8bWP3Xy0CBJ2HYXz8dTe0jb01C
	dG0J0wR8oEyLHinHhRXPuwXtBU8eCITvAaHdkZYsCvr4IImrHSA37oMbERsb7+Trttb6kiB46XqQm
	wdxltntA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59580)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uZMMq-0007Pm-0q;
	Wed, 09 Jul 2025 05:25:12 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uZMMi-0002Dj-0p;
	Wed, 09 Jul 2025 05:25:04 +0100
Date: Wed, 9 Jul 2025 05:25:04 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: lizhe <sensor1010@163.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, vladimir.oltean@nxp.com,
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] net: stmmac: Support gpio high-level reset for
 devices requiring it
Message-ID: <aG3vIMHkPezr4rJT@shell.armlinux.org.uk>
References: <20250708165044.3923-1-sensor1010@163.com>
 <aG1X9pPYDGO8kfM9@shell.armlinux.org.uk>
 <2588871d.189d.197ece7c486.Coremail.sensor1010@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2588871d.189d.197ece7c486.Coremail.sensor1010@163.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jul 09, 2025 at 09:58:21AM +0800, lizhe wrote:
> Hi, 
> 
> Thx !
> 
> i conducted an experiment, and no matter whether i configured it as 
> GPIO_ACTIVE_LOW or GPIO_ACTIVE_HIGH in the dts, the resulting
> GPIO pin state was 0, indicating a low level.
> 
> 
> if (delays[2])
>     msleep(DIV_ROUND_UP(DELAYS[2], 1000));
> 
> + gpio_state = gpiod_get_value_can_sleep(reset_gpio);
> + pr_info("gpio_state: %d\n", gpio_state);

Use gpiod_get_raw_value_cansleep().

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

