Return-Path: <netdev+bounces-154770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 238439FFB89
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 17:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57F5A18837E1
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 16:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DDA85931;
	Thu,  2 Jan 2025 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XmGLHJ8e"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D73125D6
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735835177; cv=none; b=IA8ufEkyuQNqwkffHI1zFN53kPJBFTC0u6QDpr8wElBhip+IpNXQgB3mPAouwBrf7BYGWA4mw36iRkTSWctPhP9xPnyS0D+P9eLGYh/EpYvdWOyaL7jzQ4Iu0TLOesTafB5tSPSL7CvZJzaXNs1nV4kfc4fSl3fF0QpJF4HOQHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735835177; c=relaxed/simple;
	bh=d0lIwQKFK2YKg0OceXfJNkCxJdfV8BPySrMGb5xb3xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozkx5s7mDo6l2XLqtpON+ZlNMK4purYcHDEb3SolRgXBKdbx2MyRkjCx8L7UHV+6U1nng00/jm92Jih0bc2RkSfRhEZGR3gRvq+iEFChEyuxnUeNPw4WEMWS3hlfZuB/CRTY0fL6a5Oybj/nEnzdp71w4PsqZvSNy5d2c+obCEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=XmGLHJ8e; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Q/dpMpJ3QkApJYgUd3f2JJMZZA51Gm/b0EDgIufTHCE=; b=XmGLHJ8eaoQOUwIwVA+j4He7zw
	RCZcTj1s1Q3N7vy/0EDNunyw11OTla4TtlMWtiD9FRl7EWyFA3ZYJkQ7qqruTTl0YHFHshX+lvOj6
	LVkJx8XcNUV3o1GG6hFXufERTFPGvXClxsO3zGuGL/QM/eSH2OPwCHMA0GFUqCywICLROVCar9T1o
	0b3JJHETmwSUKLNcWguQj1WBTwgbG6jYiplLbqLIk1rf1IDRxzk+HXahZbAXsImnMPn82R36VZjcE
	6cimktWHoPsDwDwNXNVEgxcT0DEnyQhjH1kY3on8e7Eyc6XhXUYG5+YBKjEaPkMRtibkLqxW51CIy
	Lu6O1zgQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50026)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tTO1O-00029y-2V;
	Thu, 02 Jan 2025 16:26:06 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tTO1M-0000Po-13;
	Thu, 02 Jan 2025 16:26:04 +0000
Date: Thu, 2 Jan 2025 16:26:04 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: mvpp2: tai: warn once if we fail to
 update our timestamp
Message-ID: <Z3a-HOwAVyJGEg67@shell.armlinux.org.uk>
References: <E1tM8cA-006t1i-KF@rmk-PC.armlinux.org.uk>
 <Z10UGg_osMZ6TZrc@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z10UGg_osMZ6TZrc@hoboy.vegasvil.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Dec 13, 2024 at 09:14:02PM -0800, Richard Cochran wrote:
> On Fri, Dec 13, 2024 at 04:34:06PM +0000, Russell King wrote:
> > The hardware timestamps for packets contain a truncated seconds field,
> > only containing two bits of seconds. In order to provide the full
> > number of seconds, we need to keep track of the full hardware clock by
> > reading it every two seconds.
> > 
> > However, if we fail to read the clock, we silently ignore the error.
> > Print a warning indicating that the PP2 TAI clock timestamps have
> > become unreliable.
> 
> Rather than printing a warning that user space might not read, why not
> set a flag and stop delivering time stamps until the upper bits are
> available once again?

If we fail to read the clock, that will be because the hardware didn't
respond to our request to read it, which means the hardware broke in
some way. We could make mvpp22_tai_tstamp() fail and not provide
timestamps until we have successfully read the HW clock, but we would
still want to print a warning to explain why HW timestamps vanish.

However, if this happens, then it also means that the gettimex64 PTP
clock ioctl will also fail, so I would suggest that the user would
find out about it anyway.

So, I don't think the extra complexity is worth doing.

This is to catch a spurious failure that may only affects an occasoinal
attempt to read the HW PTP time. Currently, we would never know,
because the kernel is currently completely silent if that were to ever
happen.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

