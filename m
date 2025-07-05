Return-Path: <netdev+bounces-204321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CCEAFA143
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 21:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E389617A6B3
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 19:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6544206F23;
	Sat,  5 Jul 2025 19:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="crpHE89S"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0995B1459FA;
	Sat,  5 Jul 2025 19:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751742386; cv=none; b=tgOCk81zgwjs/z21tevx3OmLLlGS3+Vtt3+VZXdY6z3Jc+sNCrgQNv1oI7k8yHAD72tTRaIa7RBr7NTKL/HvcTIPmiUwpIOd9qyqmMfQgt7Y21XYBN7zCeUU3ane9so7OLvxdRkAg86UQ9KZUDMn9RpGjC9yOAhzy4UDD3Vqo1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751742386; c=relaxed/simple;
	bh=IjofISm0Bqe6s5u2ihK4ud+6Rq2oYoawRHl+kYkR1wM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugl3QH2uEGGA9PAaszVwdwwkjiLPnd7uBfxcqMVz6oHETZNsXyldTqEksViYzh0ZMtaVQcgufq38Y4Ra7WmaGKO2AA7EqXDx0wDG8Ae//AWQIXu30jGaLAI0sS1sYjEHTEHgtFWoNo5Vz3NZwAyuvcARQRbk5obisftFUqCmV0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=crpHE89S; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TYyXTUmQ6H2pM7LO9+5e/crU4wTwt+19ctvCu3a6WU8=; b=crpHE89SFeeAD+PzikEWt5niTi
	1DytHFCl1lFqqQn7Ymhr+6TLp01FywScGWjAg7SaJ9eOhKNRQSsKR2IO8rrpCTddUHBOf+ucRlOXq
	TV06hPV1xscYnr7o0+1X09kJ3/icPmFzozOoe6q3MWyAVekg3lvfLpChfG3LXifOQEofW9ksRwiwe
	uxeEM4uhroXZjLRYhtwQIXfSKQeLZj0NeI87T4H8gMPEl9VIWTblvaA4nbJ7Jmgy0NL5V82xTzD2X
	HG92G9KGylr0duYfut6/XKriOxADDFQAEpqVu+YDOND6h5i76a4XuPxLosSEAW4vnxCzDNmDGPrMm
	N+KFn2UA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44334)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uY8Cy-0003TL-1z;
	Sat, 05 Jul 2025 20:05:58 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uY8Ct-0007I6-0t;
	Sat, 05 Jul 2025 20:05:51 +0100
Date: Sat, 5 Jul 2025 20:05:50 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jisheng Zhang <jszhang@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: stmmac: add support for dwmac 5.20
Message-ID: <aGl3jiAjCiXMF_FK@shell.armlinux.org.uk>
References: <20250705090931.14358-1-jszhang@kernel.org>
 <b4091f34-8901-4a30-937a-a9aac35310b7@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4091f34-8901-4a30-937a-a9aac35310b7@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Jul 05, 2025 at 05:51:11PM +0200, Andrew Lunn wrote:
> On Sat, Jul 05, 2025 at 05:09:30PM +0800, Jisheng Zhang wrote:
> > The dwmac 5.20 IP can be found on some synaptics SoCs. Add a
> > compatibility flag for it.
> 
> Is a compatible flag enough to make it actually work?

Also, shouldn't there be a binding doc update?
-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

