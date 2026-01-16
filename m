Return-Path: <netdev+bounces-250549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E444D3297E
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 15:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E543C3007965
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 14:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8CC23EA86;
	Fri, 16 Jan 2026 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="b1XKOaeZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF7019AD5C;
	Fri, 16 Jan 2026 14:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573561; cv=none; b=jCNNty7HE3rIFV9guT211JFpiw61uo5IdzjYUar6vTKpyM9FepP58lgH1mNsUNULIhUpIIjYCye79oXzYAkW1Ihlmi0gVEHlFZKO7UKL2mLFkM5CHw58wneHkJaBQIFxf8vFObxC6qoi70JYEF5w96r7W9ahWYHEQ7Fhp1DGybs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573561; c=relaxed/simple;
	bh=nI9lMjS7A5iRrRsPmEe4qwDOW8denqcPW871i3/CA1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAN5t/UWPeN402zbJTjfk/XlpR+hEqVBG5qUmV4IpV8hfPEw09kobkaTJ5kGMJwbbJQUgl7vnfwzCXzvxb81cGAmxG4zdLNmKxFv6pYws9/Jf319sFFmW/DHd8apS7CjkL2b+xqN/xOMXWpOriKtboi+YlG2Ij1XQLdoVaQU8nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=b1XKOaeZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uPUgPIao/xSwushkinBSo6gCCkUkyZK7KJVENMnmfck=; b=b1XKOaeZtopDdxQPfIaLNL8Uv3
	wdS3JsdufssqSdofDMHo9jJV6OtagPJj9fw/YW/RxfgeL3w337Mf8QJFCk6O23RpIgcpFwYCicNWR
	3JByKk2EhpL5oo70Ly4b4RTqFNCPSf5TykQZKWMke3OB0ns1NtQtfS5xeFXQkwngIy+k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vgklq-0035Ci-5M; Fri, 16 Jan 2026 15:25:50 +0100
Date: Fri, 16 Jan 2026 15:25:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Jonas Jelonek <jelonek.jonas@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Subject: Re: [PATCH net-next v5] net: sfp: extend SMBus support
Message-ID: <fe1bf7b6-d024-447c-a672-e84f4e77f8d7@lunn.ch>
References: <20260116113105.244592-1-jelonek.jonas@gmail.com>
 <6a87648c-a1e8-49a2-a201-91108669ab44@bootlin.com>
 <6987689b-35ac-4c15-addb-1c8e54144fa7@gmail.com>
 <5e7c71f6-80dd-408b-a346-888e6febf07a@lunn.ch>
 <fcf7b3f2-eaf3-4da6-ab9a-a83acc9692b0@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcf7b3f2-eaf3-4da6-ab9a-a83acc9692b0@bootlin.com>

> > Is there a use case for odd lengths? Apart from 1.
> 
> There's sfp_cotsworks_fixup_check() that does a 3-byte access :
> 	
> 	id->base.phys_id = SFF8024_ID_SFF_8472;
> 	id->base.phys_ext_id = SFP_PHYS_EXT_ID_SFP;
> 	id->base.connector = SFF8024_CONNECTOR_LC;
> 	sfp_write(sfp, false, SFP_PHYS_ID, &id->base, 3);

Ah, fixing those broken cotsworks PHYs.

> It may be possible to turn that into 2 2-byte accesses if we write
> 
> 	id->base.phys_id = SFF8024_ID_SFF_8472;
> 	id->base.phys_ext_id = SFP_PHYS_EXT_ID_SFP;
> 
> and then
> 
> 	id->base.phys_ext_id = SFP_PHYS_EXT_ID_SFP;
> 	id->base.connector = SFF8024_CONNECTOR_LC;

Or just don't bother fixing the EEPROM, leave it broken, but use the
corrected values internally.

> But let's first figure-out if word-only smbus are really a thing

Some grep foo on /drivers/i2c/busses might answer that.

     Andrew

