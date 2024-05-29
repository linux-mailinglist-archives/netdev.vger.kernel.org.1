Return-Path: <netdev+bounces-99012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8068D35BF
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 13:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B450282923
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 11:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9A414B952;
	Wed, 29 May 2024 11:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CAgrDmOI"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAE54CB28;
	Wed, 29 May 2024 11:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716983161; cv=none; b=iYywe0IcFPU/APzpyaW5amTTClUyvHW5ZThuFroCPPMaAPa3bHwRLsqAKhAFiHdHPJe0m48MkLgYS6qUq4WuZo840fITuaoMfCgnvG7WVVkBU+mTQ2ijFYMFjHUhbRjwAr/wnX8Gc6jLzl0yVaCLzWMSv6BE/WXdUgTKK+0c7Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716983161; c=relaxed/simple;
	bh=IZsIRbka6hFiTImC0U/pupNdosJ64JWjzl9chiZ04wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqblx3sj+oJMtt4INJU0spB8JWlr8t6iJSvFee+N+tP43nAu/1pEa2xUILAlZv4/UpyDkc8ITAdPAi3KIFufePgdexmDy7HNE3/VP3dQ8u+w5kBCnPf+d7thuJClPDdXzv/wgRCXNQHWPc1q4acqmPSoHPATftK0LbSfRo4HAZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CAgrDmOI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=t9VEsDGggAajKUcBvvIqqFyyn1ptDDc/e1Pdzy7eih8=; b=CAgrDmOI+j7qTDWZBNYH1V2VD2
	3hgkUKuzCDEe8o1v7blMzcPmjFQpbBFzar2oT/yQAcXE41S6F01fHUvYcba1BfiQ0zLdNx8xooY7Q
	fZtqlHftT4h43YqNE7VdGtcBb1Jqx9VX1GpL0dJNQY9O1uUXnSS53yC/v8DhRCsET2G8g3HAjJ95g
	d/htt57vezpzviF6xTJJaYZ3KLyzT+ZGYB9hIEOM8lqvgDwI3GTVsDMkjj8vDc0mDPGcUreX3DTxI
	eOlSd2rr8v7u+Dy0YcOaJeZyBin9mUey83Mlkq6YdOhHjPRIzehNnwBDccWNbWu8Cyum5Afw22AO0
	Iva+zk6A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39870)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sCHkT-00063H-1S;
	Wed, 29 May 2024 12:45:41 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sCHkQ-0004BJ-Fn; Wed, 29 May 2024 12:45:38 +0100
Date: Wed, 29 May 2024 12:45:38 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: xiaolei wang <xiaolei.wang@windriver.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [net PATCH] net: stmmac: update priv->speed to SPEED_UNKNOWN
 when link down
Message-ID: <ZlcVYjOEBGm79Yc9@shell.armlinux.org.uk>
References: <20240528092010.439089-1-xiaolei.wang@windriver.com>
 <Zlbrf8ixl9jeTTIv@shell.armlinux.org.uk>
 <d857ff81-a49c-4dd2-b07d-f17f9019bed1@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d857ff81-a49c-4dd2-b07d-f17f9019bed1@windriver.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, May 29, 2024 at 06:55:21PM +0800, xiaolei wang wrote:
> On 5/29/24 16:46, Russell King (Oracle) wrote:
> > To me, commit 1f705bc61aee ("net: stmmac: Add support for CBS QDISC")
> > just looks very buggy.
> 
> This makes sense. I think it is necessary to update the parameters after
> linking up.
> 
> Does anyone have a better suggestion?

Any setup that a phylink-based MAC driver does which is dependent on
the negotiated media parameters (e.g. speed, duplex etc) _should_
always be done from the .mac_link_up method.

So, from a phylink perspective, what you propose is the correct and
only way.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

