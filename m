Return-Path: <netdev+bounces-205451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F084BAFEC03
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 16:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF2F4E6761
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 14:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D312E62D3;
	Wed,  9 Jul 2025 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BU0Lh4cV"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C892D2E610F;
	Wed,  9 Jul 2025 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752071415; cv=none; b=jPS3ivRyWwyMkhvYE4Rpb0tmWje3nXQFhaxtguvWYcoHgPhVPtzclk5cxs0j3PhEm5m3/o5ppTXcOraHizNgK/4bYV7q9ezV5nKpsnBdlVYEpkBXhGGAi67+fRQwIpJunVlLARv4DWet5DAQxQ9AxPwWBUi1MdzYGY0F0l4bFyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752071415; c=relaxed/simple;
	bh=YAldq9AC0L1eKgqS1rWvXdOf4l7f9PE1yyWoJp1WpLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5TxZlSPo0kT0KnqhKe3ef8VtEyzWYzRXSltCmT8l3c3vmzoE0Djc4rupyOcE+QaOIEDHxp4QUXwjhTQCVG0vCvzSUPOivaxzDs5ZevxczN9v0YqGdKigrGWbYEgsUt8XTnzTThetxsz58KLzpHaQCHh6cR1H2Z2TpEnMPUtLjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BU0Lh4cV; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ajTS+ah2xlTtyM+2OdyBW0mQCdQADRwx6tcLGItIUGs=; b=BU0Lh4cVcC9JYAhMHeec6iLzAT
	8B5BDM6aSsgVyvlRIMF6YCm8hNDqSUb2nGDVOWOmgXMvbpfgML81+XLGjklzaaYdNmPIpIZNnReXE
	XlOqfQTEeMzFTwwOKatkqx/5Kn5NqNQT5YPQalMmTq4IzcFAVHjTJG9Q5S2RwwqWa9at6i13H580M
	bku1dmWB+UoihrDFufqoiIoFAmKf8H+67IYEVLSeyIScCP9VR+z3Jx01MAHmZYnaK5BC8EaDKx2Qy
	gfctDV+yS+iGIo50Y7Si6JdllgeBE9inn4Dlo+524ULJ8HmSVIK2IM9sgxHLbjlNPBBddZkkO16va
	GPhq0umw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51968)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uZVo2-00086d-16;
	Wed, 09 Jul 2025 15:29:54 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uZVnv-0002hv-0I;
	Wed, 09 Jul 2025 15:29:47 +0100
Date: Wed, 9 Jul 2025 15:29:46 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: lizhe <sensor1010@163.com>
Cc: Andrew Lunn <andrew@lunn.ch>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, vladimir.oltean@nxp.com,
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Re: Re: Re: [PATCH] net: stmmac: Support gpio high-level reset
 for devices requiring it
Message-ID: <aG582lPgpOr8oyyx@shell.armlinux.org.uk>
References: <20250708165044.3923-1-sensor1010@163.com>
 <52b71fe7-d10a-4680-9549-ca55fd2e2864@lunn.ch>
 <5c7adfef.1876.197ece74c25.Coremail.sensor1010@163.com>
 <aG3vj1WYn3TjcBZe@shell.armlinux.org.uk>
 <5bb49dc0.6933.197ee28444e.Coremail.sensor1010@163.com>
 <aG5ORmbgMYd08eNR@shell.armlinux.org.uk>
 <4cfb4aab.9588.197eefef55f.Coremail.sensor1010@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cfb4aab.9588.197eefef55f.Coremail.sensor1010@163.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jul 09, 2025 at 07:42:55PM +0800, lizhe wrote:
> Hi,
>     i have already declared it in the DTS.
> 
>     &gmac {
>             snps,reset-gpio = <&gpio3 RK_PB7 GPIO_ACTIVE_HIGH>;
>     };

Active high means that the reset is in effect when the output is at the
logic '1' state. So, gpiod_get_value*() will return the same as
gpiod_get_raw_value*().

Active low means that the reset is in effect when the output is at the
logic '0' state, and in that case the return value of
gpiod_get_value*() will return true when the reset is active (at logic
'0' state) whereas gpiod_get_raw_value*() will return zero.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

