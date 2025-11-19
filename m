Return-Path: <netdev+bounces-239990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C487C6ED68
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 14:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id D40FE29595
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 13:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B85352FA2;
	Wed, 19 Nov 2025 13:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="LGaS4xCx"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C6B307ACB;
	Wed, 19 Nov 2025 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763558554; cv=none; b=dAIs4l0Wr6xJuFrbzCz6Bst101MUcg9A4lnlr2oG0X/gWXOIEV6Zi79xtSQZvFbs2g3KrVbOw+Nkga3Cx7jrcpcNu/bwLfI1vrur2VFGyTgngS2TcStercGbQNlmsJvsav2Jp9/U69JKSIynceukIcETnZ+yH/Z8Wx2IUfdHR7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763558554; c=relaxed/simple;
	bh=gl/pav7B0B7LwaMQwMJdDV1m0fox+j7HbHgltcPB+/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVwvbRs5us/ej0oHE8QzJZrv3y/R4xCgF3M9aEKdMAw3ax7OWEEtoN+cPRcT0th5uTGIwsMhc0nGV6ZIPauXUrK8z+sr1gMUZHZ5B3U/OoibysClBKSujE7k+hlWonqsN79MSOc6Vw294htFylFhvelu8SaV2XsYkqlcFiLm1dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=LGaS4xCx; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WG8CT4InpdUiFN/DE5Jo9FeqYVIv2AZvkMViEGDpw5U=; b=LGaS4xCxY9/Sd/b87G+xNTLSqv
	/BmpIhx1L1cUrlrtF2zQ1urLUg+yXNiVYr4qayTm9C71zJFUZ2SKar/9Ki21NMMkG7hC8utYTbkwF
	ihosHgTAX8ugsSiXljtEA/TNanu19FgXSVuyDUub4ph4vOHaGFy8qtFyp0QsOafpLNw4+qgem+xEi
	MswQ6q442Mccsth693fpqnBWOzv0Zxj0kiWt7LVXtDCJyfiCIXZxAglrcwXdBby+0Pn3ujZ2PmIcG
	8urSuGH2x8I/vJNa4iTzsp+bSbkncxweR5KOlCn0E1/61D+5orebsPCUanumttvauZJfDd66DnejA
	Wacs4q3w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57292)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vLi8j-000000004oz-18Ig;
	Wed, 19 Nov 2025 13:22:29 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vLi8i-000000003SO-0GdS;
	Wed, 19 Nov 2025 13:22:28 +0000
Date: Wed, 19 Nov 2025 13:22:27 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander Dahl <ada@thorsis.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] net: phy: adin1100: Simplify register value passing
Message-ID: <aR3Ek7LUsjGt6EZE@shell.armlinux.org.uk>
References: <20251119124737.280939-1-ada@thorsis.com>
 <20251119124737.280939-3-ada@thorsis.com>
 <aR3EM0OK09bvCT0B@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aR3EM0OK09bvCT0B@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Nov 19, 2025 at 01:20:51PM +0000, Russell King (Oracle) wrote:
> On Wed, Nov 19, 2025 at 01:47:37PM +0100, Alexander Dahl wrote:
> > The additional use case for that variable is gone,
> > the expression is simple enough to pass it inline now.
> 
> Looking at net-next, this patch is wrong. You remove "val" but the code
> after the context in this patch is:
> 
>         return phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1, ADIN_CRSM_STAT, ret,
>                                          (ret & ADIN_CRSM_SFT_PD_RDY) == val,
>                                          1000, 30000, true);
> 
> which also references "val".
> 
> Note that this code is buggy as things stand. "val" will be zero (when
> en is false) or 1 (when en is true), whereas ADIN_CRSM_SFT_PD_RDY is 2.
> Thus, if en is true, then the condition can never be true.

Sorry, missed the first patch (the two patches arrived in reverse
order.) Please ignore this comment.

For the patch:

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

