Return-Path: <netdev+bounces-155506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C2DA028DC
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 16:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C2018852E6
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 15:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCF713D638;
	Mon,  6 Jan 2025 15:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="a7PD+k4Q"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E817082A
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736176479; cv=none; b=AnqKSD5NMCTBkEAwkpQkE5n/2TPFRvcxOlsx3YKkcFhK+UIIPwJ7T8+woXq90TDmF+Jl/iLkcvDp0zjWEhyD9DuWZ8bK7DTSGs2/I9GXUtPKNUub5SyX7bljqtPffGStai15VXc6aiWI40duI8HXk8Wr/aNk4wK9SwaSx2WVRRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736176479; c=relaxed/simple;
	bh=g4IkIGqwIxIlz/e+JA5d7+fuGgx/xl9Kk+WLSeJIkSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcdbJ2kERGjut3+DLurqAKGjK75HknqDsBgbTlENMIUuaNOj29lcf1KCq75G0PT+T6InkfWBD4qnZPLt9j7RRebNbeBSGR8HahS0m9Xm1Xk5m/asSX3uAyiZPdfb8ATk0h1GmH27esA+XGnMDy51y8Hkj8sY8T4RroaVDTZ67CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=a7PD+k4Q; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yo1xDq+wfYbwrBDeLDsa/4C2gZAi/9pUb8nmVm9HOpQ=; b=a7PD+k4QqqdNYRLJ6VIfaGwZuL
	eRmzcFxYXk2BrWrUQTsAZDlsqmxRShnCOu5yqHG4sqMUlgBDDvSD0oM/d/nigVu6UHhAbq92U/kKr
	NvkV/dnNcl8LGKtaRWYiovBz1aw/UT++5SxIBxxFCfGnR5eb3kr53E0Q/In5R5laVKt5Ne+LwcyUm
	9ofWVe6Z5irMwRYSKr8JGNBzmuzRHiKeAjYREBfOaSCzex/DFac7rxY12OgTC8f2XKOTzukgPVw+6
	TmvFTbmZx90YNn8TeJa05G6bT/hrMXb9DOF3tsdtgjPVimtk9U5dRHRgdMzQ+/AytzyY/zHNE78xk
	BZyfAYtA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60118)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tUoo9-0006AM-1y;
	Mon, 06 Jan 2025 15:14:21 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tUoo2-0004Nh-0J;
	Mon, 06 Jan 2025 15:14:14 +0000
Date: Mon, 6 Jan 2025 15:14:13 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "Chester A. Unal" <chester.a.unal@arinc9.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>, UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>
Subject: Re: [PATCH net-next 6/9] net: dsa: mt753x: remove ksz_get_mac_eee()
Message-ID: <Z3vzRWimau916tDY@shell.armlinux.org.uk>
References: <Z3vDwwsHSxH5D6Pm@shell.armlinux.org.uk>
 <E1tUllF-007Uz3-95@rmk-PC.armlinux.org.uk>
 <c133c8bf-d28f-437d-b5e1-f575959651ca@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c133c8bf-d28f-437d-b5e1-f575959651ca@arinc9.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 06, 2025 at 01:03:46PM +0000, Chester A. Unal wrote:
> The patch subject mentions ksz_get_mac_eee() instead of
> mt753x_get_mac_eee(). Keep that in mind if you happen to submit a new
> version of this series; this is not enough as the sole reason to submit a
> new version, in my opinion.

Thanks for spotting that, I've fixed it for the next posting!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

