Return-Path: <netdev+bounces-225531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98373B9526F
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 11:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FC657AC65D
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 09:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391D131DD87;
	Tue, 23 Sep 2025 09:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UXfEpc5V"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B54631E888;
	Tue, 23 Sep 2025 09:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758618568; cv=none; b=ENOgGYngPwM3IiK1p0x4I1oZlZpxPIhWU7Sx5UxiMKqzR1kXu7Yuz+Kw7mqX2K+astdChTlEE+zmuiWBACd6hx+zXSzoLs4XjRjV+ft0GDTd2OCkxN71thD7ubwBpSx+DRtr3qYasuZGadxGfJy2W/QdguS9i3wHSb9VHEDslhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758618568; c=relaxed/simple;
	bh=Bf18cj0HZKW8sv39LhYfAvcFyUTklun49FrjVhZCSkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzX2M2Uu2Aql6Bllh2Yrvua/C3ioxLt89ONpGRSxaJP/cH94o8Aw8KlSSOu/MJ+hSoQukMZMn5ZIZXpJINMn01mrMcB1GgYhVYV8V339LEbanblL55X7SrZ0wgu8v4xx21KG/F7teMLBriH/0ll/4d7qGVNLnrP5NKfl/+KsNnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=UXfEpc5V; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LNfWHKHbRyM/GBX0pKVevF1bo7N98M4gqN+Cm7IF6fk=; b=UXfEpc5VubhTvRh2RDuRRIh8YM
	wHrPPSm8C2tHgvqzoDIfqk5TMwb2k4m1mgnmfhb57jFA+ehquSFq7dsoduoRpaanDbZDZLrYuRqLI
	+9U6n+BiDgOP1U3DoVWYzWXrAFhuu2uP/VZa9LaZ9rF73VrsQStK5HypqZGevNgJoY0zGqTKn9kH3
	u3wB7yiR64cNSEjnmx+d++TN++QcI+NaYMZ2cIZdogktMk4wtW4rHUP9r2n6Sx+YlW30DufLLJZgi
	hkOYu+egUknb6FZx53Z59xf8bRp3IQVV6jXtvVtZLivTnVsknAh2L8lahjY8QxwTG3SfaGNGPBgd2
	rT6EeylA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33712)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v0z1P-000000006rv-3pdk;
	Tue, 23 Sep 2025 10:09:16 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v0z1G-0000000060w-2BgJ;
	Tue, 23 Sep 2025 10:09:06 +0100
Date: Tue, 23 Sep 2025 10:09:06 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: =?utf-8?B?6Z+m5bCa5aif?= <weishangjuan@eswincomputing.com>
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, vladimir.oltean@nxp.com,
	yong.liang.choong@linux.intel.com, anthony.l.nguyen@intel.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, jan.petrous@oss.nxp.com,
	jszhang@kernel.org, inochiama@gmail.com, 0x1207@gmail.com,
	boon.khai.ng@altera.com, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, lizhi2@eswincomputing.com,
	pinkesh.vaghela@einfochips.com
Subject: Re: Re: [PATCH v7 2/2] ethernet: eswin: Add eic7700 ethernet driver
Message-ID: <aNJjshm4Z8H2Z8_V@shell.armlinux.org.uk>
References: <20250918085612.3176-1-weishangjuan@eswincomputing.com>
 <20250918090026.3280-1-weishangjuan@eswincomputing.com>
 <aMw-dgNiXgPeqeSz@shell.armlinux.org.uk>
 <30080c70.16e1.199748921d3.Coremail.weishangjuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30080c70.16e1.199748921d3.Coremail.weishangjuan@eswincomputing.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Sep 23, 2025 at 11:06:08AM +0800, 韦尚娟 wrote:
> In the current eic7700_dwmac glue driver, the regmap_read()/write()
> operations(for phy_ctrl1, axi_lp_ctrl1, and the RX/TX delay registers))are 
> performed directly in the probe() function. Would it be cleaner to move these
> register configurations into the init() callback instead, so that they are
> also reapplied during resume()?

This is a question I can't answer definitively as I don't know what
happens during a suspend on your hardware, and thus which registers
are lost / reset by the time the system resumes. So I can only give
the obvious guidance.

If the settings in the delay registers are lost over a suspend/resume
then they need to be re-initialised after resume.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

