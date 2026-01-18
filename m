Return-Path: <netdev+bounces-250823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B092D393CD
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 11:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 58797300463E
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 10:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3F12D8379;
	Sun, 18 Jan 2026 10:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="afZ6jmAo"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2952DBF45;
	Sun, 18 Jan 2026 10:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768730908; cv=none; b=HqJKbWeSh+FZUPrRoVf8FUZ6U3V07pRkyUn+8zJw7hDJvGK7L+aBqgLmbruHP2LRLuRbaBBs6vQOtYldhorrUGcLMkwUE7pJDONWUAGVwhHhs2CkDoyDpS9cVpb0vmImAEriPN3Q09peImPFsGc3U93NlW0PymdK9pSQ/xeYkBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768730908; c=relaxed/simple;
	bh=zfG9kR6GVytGzJo0EGQoTa6uMlq3njmHNwkLqAF/SGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8w1ZlYC3qJCxqL6AhkbO2pQmlb2peQLEIkZEYhnw2IzFNzg6CH2WU3ARAXH7vdHMPV9Ao3HyYw6+eEWSxHBEyETm/5WYRA60HDjrJIV1boUn4Df9HeRNQRwN59bY6yvGi2VMbj3dlXFZLZu3WYUAZIz1Qhvy7j5FSYywuhd7/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=afZ6jmAo; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gykQHQfAXfGx+5mcrgwAVp3gTYmzOFfNes+NNjpoUjk=; b=afZ6jmAobpwl3nv90bjh5cQDLP
	rT0PLqvLQt3p1ixKGks/TSBYIMQ3lM9Sey+nzKRhsd4/Z2rqnxqnGn6+1EzyXX6u6A6s0hlwu1hFE
	EMofF3I4mdKYyR7bCgZe2gtE3oTpTrm9fOI4ymXGqqVoESebCFbHX8Y6UKw2lFbhohvR5GpV0X084
	aBcyZDSLyn+k2Ayn+9NwXGiDD9AK1VAhp4BWdHOA3oJbcz/KJNjQyAzDtXDm73+FdP6TQ/GnilhMm
	B398TAji6ZO5NKlKroUtGoyVl9yL+mEOxbPvAS27bXg9N/TrYj0zfqHWjPPn+ZeFRx0BSLkN2M8yq
	zPduy8Iw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41614)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vhPhf-0000000047p-3qWx;
	Sun, 18 Jan 2026 10:08:15 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vhPhc-000000005Vf-2krW;
	Sun, 18 Jan 2026 10:08:12 +0000
Date: Sun, 18 Jan 2026 10:08:12 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Subject: Re: [PATCH net-next v5] net: sfp: extend SMBus support
Message-ID: <aWyxDI6-sKc6BNQE@shell.armlinux.org.uk>
References: <20260116113105.244592-1-jelonek.jonas@gmail.com>
 <6a87648c-a1e8-49a2-a201-91108669ab44@bootlin.com>
 <6987689b-35ac-4c15-addb-1c8e54144fa7@gmail.com>
 <5e7c71f6-80dd-408b-a346-888e6febf07a@lunn.ch>
 <fcf7b3f2-eaf3-4da6-ab9a-a83acc9692b0@bootlin.com>
 <fe1bf7b6-d024-447c-a672-e84f4e77f8d7@lunn.ch>
 <91442f3f-0da9-4c52-89ce-2ca0a3188836@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91442f3f-0da9-4c52-89ce-2ca0a3188836@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Jan 18, 2026 at 10:43:12AM +0100, Jonas Jelonek wrote:
> Looking at the SFP MSA [1], some sentences sound like one could assume
> byte access is needed at least for SFP. In Section B4, there are statements
> like:
> - "The memories are organized as a series of 8-bit data words that can be
>     addressed individually..."
> - "...provides sequential or random access to 8 bit parameters..."
> - "The protocol ... sequentially transmits one or more 8-bit bytes..."
> 
> But that may be too vague and I can't judge if that's a valid argument to not
> care about word-only here.

There's a whole bunch of documents. You also need to look at SFF-8472.
This contains the following paragraph:

 To guarantee coherency of the diagnostic monitoring data, the host is
 required to retrieve any multi-byte fields from the diagnostic
 monitoring data structure (e.g. Rx Power MSB - byte 104 in A2h, Rx
 Power LSB - byte 105 in A2h) by the use of a single two-byte read
 sequence across the 2-wire interface.

Hence why we don't allow hwmon when only byte accesses are available.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

