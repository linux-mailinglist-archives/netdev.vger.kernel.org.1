Return-Path: <netdev+bounces-239988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DBEC6EE7B
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 14:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4471503A4F
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 13:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348EC3612DA;
	Wed, 19 Nov 2025 13:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="G+N5DXY1"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654E93164A0;
	Wed, 19 Nov 2025 13:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763558464; cv=none; b=k85MAQVLkDWHPQxJLnm3aZOtPHwPNIaACPHvSYbIyipC/RRpANowbr+pjEAnHF49YNTuibYvAXJ7fqDuXEVS2j3L/J703RAhD4TaTvE3/zEZ4Mjg5XOZyd46VEzjOQ8s3Uq++75XiFSK7VMh6yH745TuuWB1qHi3UnRInZ8Anrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763558464; c=relaxed/simple;
	bh=HX3P6X6ezc7eTaEs5ry0iSWOJ28kDPigt2yKZotI70k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BI2gV4gc+X97DZhvOuCrXd+7hKF1QwdPf+h24rp+3dFQWyCNbXuEgQokn5erSbwSdVOJtI1dOFQgyc+vyeUB6PVXBhmiV4uFjGl1ML17r+JVI1GIoLEmTGroqccBeUb5T88i95dlBmHhwD1jynzFQgdnnoymRkgyLuP4MDpnKss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=G+N5DXY1; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=27EjsITI7beV3lG4S3UiigGc6q88Wix69xQqEsfUoN8=; b=G+N5DXY1XK3W2yPr5Aok1Lq5Rl
	BlqY5usPlsLgWTh1zDe+T4TyS2hNYNu0QL1mTEktg2oFH6WjfHieBi80Utp2RtTDR+de+79N6bbEr
	uEOZuXFcANKWRs5yAlfZuZ6Lxs/U1gs6mI58cLe05TVl/VS6n3nBHhpu4gA7RA01HJvPPFOCXLYM/
	4SFP25FPN/JFGfHnwjPBTH4VCpxzw3g6i7fa/BPI9JZOKG4kT9zzL5A5y3flk03D2+JuGgWttlVRe
	801L7+omeiOI8jmy7yxWno2003tLs4gTrocLReTsC5hD/tMHZgCUHB2kPWAzOXsRRC6JPA3vyZbyC
	syHr+SWA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42436)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vLi7B-000000004oM-3YPG;
	Wed, 19 Nov 2025 13:20:53 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vLi79-000000003S4-1SHt;
	Wed, 19 Nov 2025 13:20:51 +0000
Date: Wed, 19 Nov 2025 13:20:51 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander Dahl <ada@thorsis.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] net: phy: adin1100: Simplify register value passing
Message-ID: <aR3EM0OK09bvCT0B@shell.armlinux.org.uk>
References: <20251119124737.280939-1-ada@thorsis.com>
 <20251119124737.280939-3-ada@thorsis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119124737.280939-3-ada@thorsis.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Nov 19, 2025 at 01:47:37PM +0100, Alexander Dahl wrote:
> The additional use case for that variable is gone,
> the expression is simple enough to pass it inline now.

Looking at net-next, this patch is wrong. You remove "val" but the code
after the context in this patch is:

        return phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1, ADIN_CRSM_STAT, ret,
                                         (ret & ADIN_CRSM_SFT_PD_RDY) == val,
                                         1000, 30000, true);

which also references "val".

Note that this code is buggy as things stand. "val" will be zero (when
en is false) or 1 (when en is true), whereas ADIN_CRSM_SFT_PD_RDY is 2.
Thus, if en is true, then the condition can never be true.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

