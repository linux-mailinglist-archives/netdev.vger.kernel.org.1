Return-Path: <netdev+bounces-250741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 38151D390F5
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 21:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9AB6430066D2
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 20:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225792C326C;
	Sat, 17 Jan 2026 20:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="EO2einq2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F25B50095D;
	Sat, 17 Jan 2026 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768683036; cv=none; b=fqkjkOM6xGjjeASJo2T3P90XvncsosIlI5HvgZcm8Xvus6LmZg0lRPhJ145UwsJGT6hhL/YEpYDCLpN1v826k/PFd44+eVFZrCsqh4S9ARlfGPK2XnjhqrbnnO8lo4ziqu5s/jj6iR3JTDwycjSyZhKC3nu+PQjKlbW+hth9Mzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768683036; c=relaxed/simple;
	bh=8+Lt0wHLkliFfdDrOmERdcOPvey2slepLAS2y6g+wgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1sfxcRpPigtY0kIN2iuqsq8MQ5g80c3fmSc1IsBw1OXLhpa7vT2cnxieW8vU+ctew8CZ1B+2onP2R6CfIT0R11raPCbISwD1KItM01F1TN46K1KouUwM7GfRGjv4lL2j7E15VQOdU1Wmt85dZD8JRKBpF7Yyu/z4jIuLFg0ABY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=EO2einq2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9K2q75TKsNQCCs0lg/uHM2KXv09DFsFaURV+ZH8P+68=; b=EO2einq2klJGAwNNhJjvj1IXTL
	4pBBGcLQGnH94dj5/DeZi9pSplhB6mWcVUVm6HV182w3OiIzKlWv6oBPaj0p45JxFI7+e0+LEJT1E
	yB6erLonGANWgkRKUMeVyu8y7a/vBQcmc+oCIInQbjMCMO3gzW9xawsizLRGV4t2LmBI0PTXvCum9
	ZADTMQFJqHWssgBEdS1ry6kn1LT4RSuPRiVLsG3ZNol+oyd8aJ5ySqIh98fL0Nyed7wfXeyv+bp0o
	gaRLRSqJaXMILyFC+ofbOFk9KmGqtRVtTS3JHe2sGgpNGBrBqtMexbRogqukk3RktssuQBMi9oyyu
	mu21r6Jg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58372)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vhDFS-000000003nQ-1xJL;
	Sat, 17 Jan 2026 20:50:18 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vhDFL-000000004tu-0qW1;
	Sat, 17 Jan 2026 20:50:11 +0000
Date: Sat, 17 Jan 2026 20:50:11 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Tao Wang <tao03.wang@horizon.auto>, alexandre.torgue@foss.st.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net v2] net: stmmac: fix transmit queue timed out after
 resume
Message-ID: <aWv2A18ZHP6rV7tp@shell.armlinux.org.uk>
References: <aWlCs5lksxfgL6Gi@shell.armlinux.org.uk>
 <6a946edc-297e-469a-8d91-80430d88f3e5@bootlin.com>
 <51859704-57fd-4913-b09d-9ac58a57f185@bootlin.com>
 <aWmLWxVEBmFSVjvF@shell.armlinux.org.uk>
 <aWo_K0ocxs5kWcZT@shell.armlinux.org.uk>
 <aWp-lDunV9URYNRL@shell.armlinux.org.uk>
 <3a93c79e-f755-4642-a3b0-1cce7d0ea0ef@bootlin.com>
 <aWqP_hhX73x_8Qs1@shell.armlinux.org.uk>
 <aWqmIRFsHkQKkXF-@shell.armlinux.org.uk>
 <20260117090634.26148eb4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260117090634.26148eb4@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Jan 17, 2026 at 09:06:34AM -0800, Jakub Kicinski wrote:
> Letting switches generate pause is
> a recipe for.. not having a network. We'd need to figure out why Netgear
> does what it does in your case, IMHO.

... because they're dumb consumer switches.

Also, the correct term is "a notwork" :D

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

