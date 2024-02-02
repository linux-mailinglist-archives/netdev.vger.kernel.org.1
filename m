Return-Path: <netdev+bounces-68249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6E18464F2
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 01:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C7F228D55B
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 00:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D046188;
	Fri,  2 Feb 2024 00:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GIs5bjs3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417DE7E9
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 00:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706832842; cv=none; b=f9dSKGoax2hN4e64SXXeeOe6C8yreGTeMtlf953wLk7hGiI+P8j1btyvif2QwL9w3hTG3BZ/8ow9ZfP9MaNb3Xiu/wbZtrzmXNiE4qb9CO3gAApqI3XJXxudoaWZzqCdguafBQ4Ew/DVGjo4FmBrwWJUfwCt6+1agRn3B3iomvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706832842; c=relaxed/simple;
	bh=z9kOMI0/6NKVR2wyFflgRTS+rQ7pJ+Q+s6HpJseNlgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2L5Wv7JsNg0Q18ogG0oApR2sOy+fg6zrEj7gI+c2kdDSv/9falr36beX6YImkYzA7zweHkFd4ywUS6etB8iEXY9OvcmddufsjVaJO2R53IV3GKXpN2LOXgBS+PFK8zFSmUI2pjQFIGY4Twhnrqvm4D39rilzvUA4/4wgxUf5uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GIs5bjs3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=m5YvAq02mp7AyyyF8JuXavXDNj6v4ZiHmwdrWAV2zpY=; b=GIs5bjs3hQq4IL/FqCe/iiTYoN
	6D6swlIwaAGHR0ZherdOjCtqhcjFc0OMY81GMxwZOeVPMPRFCqJAbPYokidhwUw4RrerC2/9t21mI
	kfUYUCWN7EtcRSwchQMLNCqDMOUVBc+8dNgzyQa0+vAuFqp33iT+0NmRZxILHFox+phU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rVhBl-006jWe-Ox; Fri, 02 Feb 2024 01:13:49 +0100
Date: Fri, 2 Feb 2024 01:13:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Joe Salmeri <jmscdba@gmail.com>
Subject: Re: [PATCH net-next] net: phy: realtek: add support for
 RTL8126A-integrated 5Gbps PHY
Message-ID: <dd6f6137-91a6-437e-9251-0a4bee5cdbc2@lunn.ch>
References: <0c8e67ea-6505-43d1-bd51-94e7ecd6e222@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c8e67ea-6505-43d1-bd51-94e7ecd6e222@gmail.com>

On Wed, Jan 31, 2024 at 09:24:29PM +0100, Heiner Kallweit wrote:
> A user reported that first consumer mainboards show up with a RTL8126A
> 5Gbps MAC/PHY. This adds support for the integrated PHY, which is also
> available stand-alone. From a PHY driver perspective it's treated the
> same as the 2.5Gbps PHY's, we just have to support the new PHY ID.
> 
> Reported-by: Joe Salmeri <jmscdba@gmail.com>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Joe, can you add a Tested-by:

Otherwise, this looks O.K.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

