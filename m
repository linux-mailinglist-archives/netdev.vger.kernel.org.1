Return-Path: <netdev+bounces-195728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00D9AD217A
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 16:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654CC163265
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 14:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDF21993B7;
	Mon,  9 Jun 2025 14:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ijo6sDti"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D8772606
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 14:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749481061; cv=none; b=NtWFM4G469lBJI/1g5VXtoDuj89ppRiJLNi73AHNwfvwacxmIsNN2cjGSIsNGNrbzrL+XgbFWGLToIVCA/WUEhHCfu2QAnfU9vSICRIE3szs+NuMWI0TBUqzsedc0tiR4KTe2SRHnZxlKSUKkayjHZTVKhMl1CW2XBYHHUFx2eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749481061; c=relaxed/simple;
	bh=axF4YFc8aCsMymAOweKIPggR4dfT2HNoFB1dEThim0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRJAhV0+slGT3EH+q4s2ZXUQELixVQpG5B/0h4ziSPlrMJISJKDi/hLtNLLCuCTT+EUrQ0G4B+aLZZ111oUBhQSNBnXAnd5qjI5TREbdKQDQmn9Ffi7/ZSm/qhTvHK2F/gu7T3U0JJvEx0BAPvlR6VlKT/Fkk2do8sLEdGwWfc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ijo6sDti; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RZbrlmbQfw9ffnRVInscW32tCgzTe4ZefU0JgdfbVwo=; b=ijo6sDtih+TZxHscjcQG6qfZOp
	Tkod5mVWoSs4ovM7g8ubqGCB378LxtILT7SD16rezL4hMfLYu7wwr5QfDYRX75CVS0Ud8W+JAZkcX
	30cbzR/6oCFJKaDSyiLGcx9undVPgT8U1ibgaggSO3G9MHOHS+FQNB2WhRKfp8ISniqFe/Ab2eL1k
	ICusJ771X4nZanp9KSOXwlnnLkugyIw+TBzoEpv7vtUP2tqJ5NzdWjkGC1XQ6rHmkVqrGrdNWmtrO
	rBE3WcC/FSkGe8NzjzcdVzhcfo8UsO0YhSpHNqY3xl9TrNsWAlV7ohKF/ZlNcEB/qftIeTuE6TIkr
	58DPIJpA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38086)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uOdwJ-0003Oo-2f;
	Mon, 09 Jun 2025 15:57:31 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uOdwH-0006Ji-1O;
	Mon, 09 Jun 2025 15:57:29 +0100
Date: Mon, 9 Jun 2025 15:57:29 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Raczynski <j.raczynski@samsung.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, netdev@vger.kernel.org,
	wenjing.shan@samsung.com
Subject: Re: [PATCH] net/mdiobus: Fix potential out-of-bounds read/write
 access
Message-ID: <aEb2WfLHcGBdI3_G@shell.armlinux.org.uk>
References: <CGME20250609144014eucas1p2ee94d7aabff15fbadcc1af1fa64ce22d@eucas1p2.samsung.com>
 <20250609143758.1407718-1-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609143758.1407718-1-j.raczynski@samsung.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jun 09, 2025 at 04:37:58PM +0200, Jakub Raczynski wrote:
> When using publicly available tools like 'mdio-tools' to read/write data
> from/to network interface and its PHY via mdiobus, there is no verification of
> parameters passed to the ioctl and it accepts any mdio address.
> Currently there is support for 32 addresses in kernel via PHY_MAX_ADDR define,
> but it is possible to pass higher value than that via ioctl.
> While read/write operation should generally fail in this case,
> mdiobus provides stats array, where wrong address may allow out-of-bounds
> read/write.
> 
> Fix that by adding address verification before read/write operation.
> While this excludes this access from any statistics, it improves security of
> read/write operation.
> 
> Fixes: 080bb352fad00 ("net: phy: Maintain MDIO device and bus statistics")
> Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
> Reported-by: Wenjing Shan <wenjing.shan@samsung.com>

This is insufficient on its own. If you check the clause 45 accessors,
they have the same issue, so this should also be fixed.

Your patch would've been fine for the blamed commit, but we've had
4e4aafcddbbf ("net: mdio: Add dedicated C45 API to MDIO bus drivers")
in v6.3.

For easier back-porting, it probably makes sense to have this patch
and another separate patch addressing the ones introduced in the
more recent commit - and the two patches sent as a patch series.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

