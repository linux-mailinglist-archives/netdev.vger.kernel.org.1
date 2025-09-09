Return-Path: <netdev+bounces-221440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E06BB50828
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 23:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F20744332F
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 21:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E2325BEF1;
	Tue,  9 Sep 2025 21:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1LRDSCbT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AC826056E
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 21:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757453249; cv=none; b=N3juWcbjcmKUUpvAwUq4QYvvCHReVowgATid15BG6v8voLjNIA5tb/Dqykq4w93vZq88ADrSLnpi41DNcaIHUso4TdKOzdg232if2zuGvbQ3MkTfvwSCZnPKAFlOSRmbHv9SoV/q0mwmSIoNDCjjyWw3HXXbcisUHna9yqtlmd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757453249; c=relaxed/simple;
	bh=VSY2ZUYBdJQW75BpcGsTEdNVj7L2uDv+9DNixuhTXOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrs/YMc5EtHLjUXJHO7EUQGISHB1JSBqd2P8eFLVKMsK6ZPJwqA2d5i62NUcO0H5Oan6NgjdkTlf+y9c64iZS4HzBH8HwRYEeOkV3pallBUeeKE/XezeeBic6ES4kTpzkqnkc7ylYtPjW8OmuH3Ydiw/ndnOhAVFmfHtrnAnziU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1LRDSCbT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=N03zdNgtItkqN4Mh3Jm7W6OkT0fS/nkoYagMTQ3Nx8Q=; b=1LRDSCbTrmJojjinbBBIfHz7kH
	cyE4/Tm7esCMuTaVebpmjjR1aR1BOH4KCl2zq2MYVw1sWA0Fni7shloTwt+9BZglRdSgYPAndYPq3
	ETBIKa6reRV2Hiprtve3dZI5lYxA1Yy41YUPsKv/kQ7gn+0eTq8xvil/SrfaHSLjl8vY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uw5s0-007rV0-RA; Tue, 09 Sep 2025 23:27:20 +0200
Date: Tue, 9 Sep 2025 23:27:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] net: phylink: warn if deprecated
 array-style fixed-link binding is used
Message-ID: <c9d4aa1a-6d94-4110-87fa-8c5670c3c75d@lunn.ch>
References: <964df2db-082b-4977-b4c9-fbdcfc902f9e@gmail.com>
 <bca6866a-4840-4da0-a735-1a394baadbd8@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bca6866a-4840-4da0-a735-1a394baadbd8@gmail.com>

On Tue, Sep 09, 2025 at 09:16:36PM +0200, Heiner Kallweit wrote:
> The array-style fixed-link binding has been marked deprecated for more
> than 10 yrs, but still there's a number of users. Print a warning when
> usage of the deprecated binding is detected.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

It should be a pretty mechanical transformation to convert them. How
many are there?

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

