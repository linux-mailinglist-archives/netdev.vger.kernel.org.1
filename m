Return-Path: <netdev+bounces-183244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2972EA8B729
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 295684455C5
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 10:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12655238D45;
	Wed, 16 Apr 2025 10:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="H172t79u"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCA8235345
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 10:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744800700; cv=none; b=m610rs+/C8luRTVxLyksUg8nEcZ6bvPO22/s1dxuHiWGHho0V02Ip8l7aAQ1HOB03Caf+McoTW20kHE679ZkUJybM0YmQUC+dag955tLB6SQIdsN+qccx2j8Du0JpnEg7jorFS8AJbsHMXfLhnSFuvuIRjquwHbeMEDu3+jBjUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744800700; c=relaxed/simple;
	bh=8ltgJaWDDMfnGDhWTTVhAdQ26cUmkN+X9NC44eD+530=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdOFd7/oh6Qem6icOUxhg15qPVtYKsxS8ItFfIJ3E2wK681XhfkF0hsUdMKN/yYM63kVsNCvg95oqxAvX8B4OttWjrwW6l/QW7jTWy2f+LykpAxIPC0q4Qd5yKsgms41/zLIEAJV+5Za7BltWwSaMnY9+lDB6V7y+TKN0Cilawg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=H172t79u; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=acDB+MT9pv2e9KI2UzjPLtfLETXFbYRx016W6dXovVI=; b=H172t79ubc2c1YjBg4uU9Sj9gb
	J0xd9Cm9VLfiITiAzSxH+MkiGfFTKt3iS0aojoegV3lguMAr2m36Mlf88gtvgHIaL97gqMnlQ5tVR
	BqJNFrfPkGDF3wC2fwNFXPwdMUeZP6HWmV1+nwtKRlpGeXi5sNrHik5yM1XDhdSzPoB2Vz7uLM+pT
	gqT/8aBn82JUsB3RitRnfv/D8GE1ZM/2701fVp/8y5SQbkGE9o/vQRDfWQcny1NiP8ZaaTHDJXN3d
	1pPQ7PxHTMRN+ZMa+RocQHgD21BDwAqJ2knh/qqkEoLL09OPVzDkv6HFqgP6jnWL59JYiDR7UKMn4
	w7VU8L0A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46762)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u50Md-0001CR-1Q;
	Wed, 16 Apr 2025 11:51:31 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u50MZ-0001L8-1U;
	Wed, 16 Apr 2025 11:51:27 +0100
Date: Wed, 16 Apr 2025 11:51:27 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH RFC net-next 0/5] Marvell PTP support
Message-ID: <Z_-Lr-w95sX4fLIF@shell.armlinux.org.uk>
References: <Z_mI94gkKkBslWmv@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_mI94gkKkBslWmv@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Apr 11, 2025 at 10:26:15PM +0100, Russell King (Oracle) wrote:
> Hi,
> 
> This series is a work in progress, and represents the current state of
> things, superseding Kory's patches which were based in a very old
> version of my patches - and my patches were subsequently refactored
> and further developed about five years ago. Due to them breaking
> mvpp2 if merged, there was no point in posting them until such time
> that the underlying issues with PTP were resolved - and they now have
> been.
> 
> Marvell re-uses their PTP IP in several of their products - PHYs,
> switches and even some ethernet MACs contain the same IP. It really
> doesn't make sense to duplicate the code in each of these use cases.
> 
> Therefore, this series introduces a Marvell PTP core that can be
> re-used - a TAI module, which handles the global parts of the PTP
> core, and the TS module, which handles the per-port timestamping.
> 
> I will note at this point that although the Armada 388 TRM states that
> NETA contains the same IP, attempts to access the registers returns
> zero, and it is not known if that is due to the board missing something
> or whether it isn't actually implemented. I do have some early work
> re-using this, but when I discovered that the TAI registers read as
> zero and wouldn't accept writes, I haven't progressed that.
> 
> Today, I have converted the mv88e6xxx DSA code to use the Marvell TAI
> module from patch 1, and for the sake of getting the code out there,
> I have included the "hacky" patches in this series - with the issues
> with DSA VLANs that I reported this evening and subsequently
> investigated, I've not had any spare time to properly prepare that
> part of this series. (Being usurped from phylink by stmmac - for which
> I have a big stack of patches that I can't get out because of being
> usurped, and then again by Marvell PTP, and then again by DSA VLAN
> stuff... yea, I'm feeling like I have zero time to do anything right
> now.) The mv88e6xxx DSA code still needs to be converted to use the
> Marvell TS part of patch 1, but I won't be able to test that after
> Sunday, and I'm certainly not working on this over this weekend.
> 
> Anyway, this is what it is - and this is likely the state of it for
> a while yet, because I won't be able to sensibly access the hardware
> for testing for an undefined period of time.
> 
> The PHY parts seem to work, although not 100% reliably, with the
> occasional overrun, particularly on the receive side. I'm not sure
> whether this is down to a hardware bug or not, or MDIO driver bug,
> because we certainly aren't missing timestamping a SKB. This has been
> tested at L2 and L4.
> 
> I'm not sure which packets we should be timestamping (remembering
> that this is global config across all ports.)
> https://chronos.uk/wordpress/wp-content/uploads/TechnicalBrief-IEEE1588v2PTP.pdf
> suggests Sync, Delay_req and Delay_resp need to be timestamped,
> possibly PDelay_req and PDelay_resp as well, but I haven't seen
> those produced by PTPDv2 nor ptp4l.
> 
> There's probably other stuff I should mention, but as I've been at
> this into the evening for almost every day this week, I'm mentally
> exhausted.
> 
> Sorry also if this isn't coherent.

I've just updated this series for the supported pins flags that was
merged into net-next last night.

Kory, if you have any changes you want me to review before sending
out the updates, please send soon. Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

