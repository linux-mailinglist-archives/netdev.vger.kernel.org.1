Return-Path: <netdev+bounces-161641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7147A22DAA
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 14:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E225188910E
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 13:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A961E376E;
	Thu, 30 Jan 2025 13:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JS89fvrY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5941B819;
	Thu, 30 Jan 2025 13:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738243484; cv=none; b=iq2JZJPEVhzjpX0RYuDqlhB9J42qeD0Tmu1C4gpHQghIdW1qg7LKSQCaqUGO2yyFJB7xl66ZScpR2Q6n+PqO7Su0ExXeyLrVQuUG2gPmRqT65wWnNC4GEL8LvO32wJgPa7ouRlhmmsv972RAFMaaphjy2eNvgkL0qdIxkNqmsnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738243484; c=relaxed/simple;
	bh=lJiOt4TjwzF0s7cAcZoJ6GVtoajcILHi8WWa/mfpuSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOdAQyUOIvRyNQYyhEnPjsfsBFxuGV+KQMJWG1Wim/kYVLrDvOWi/vsk+Hf5r2/FLe5K355G5dh6xH2gTxK1lQiN6wtVzAKkJxVmy26+mb8J3Zu9QcX7/2B/nwAZOv/y0nWxhbnUGS01cTxEUuQvS9Sz+c/fyujkh0BXAtH1RSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JS89fvrY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PXe4JbbDh0vvlSGOfbnRZy/Cv+zCvilTMEJheMeI+Sc=; b=JS89fvrYcDRcww4ABuBvy52Ux/
	yQ8hVP5AyAPmXlyfdqiopk2Qom24luNUaBaPUxiXuFUDlGR/2WG8R1Pxki429mGntUFOAPJ7G0F6f
	B/VoCutAGCT2wWdvL1Jph7S8h8X2pvb/rkGG3QOb068Q4Id3zOJfr04G53sfJNVaq8Lw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tdUWy-009PlG-N0; Thu, 30 Jan 2025 14:24:28 +0100
Date: Thu, 30 Jan 2025 14:24:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tristram.Ha@microchip.com
Cc: olteanv@gmail.com, Woojung.Huh@microchip.com, hkallweit1@gmail.com,
	maxime.chevallier@bootlin.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux@armlinux.org.uk, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 1/2] net: pcs: xpcs: Add special code to
 operate in Microchip KSZ9477 switch
Message-ID: <dd2e35c7-0bfd-4679-8ee9-5c69244acb8f@lunn.ch>
References: <20250128033226.70866-1-Tristram.Ha@microchip.com>
 <20250128033226.70866-2-Tristram.Ha@microchip.com>
 <Z5iiXWkhm2OvbjOx@shell.armlinux.org.uk>
 <20250128102128.z3pwym6kdgz4yjw4@skbuf>
 <Z5jOhzmQAGkv9Jlw@shell.armlinux.org.uk>
 <20250128152324.3p2ccnxoz5xta7ct@skbuf>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250129211226.cfrhv4nn3jomooxc@skbuf>
 <DM3PR11MB87365B3AD3C360B0EF0432F3ECE92@DM3PR11MB8736.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM3PR11MB87365B3AD3C360B0EF0432F3ECE92@DM3PR11MB8736.namprd11.prod.outlook.com>

> As I mentioned before, the IP used in KSZ9477 is old and so may not match
> the behavior in current DesignWare specifications.

Can you tell us the exact revision? Now that Synopsys have said they
will try to answer questions, they should have access to all the
versions of the data book, and can do comparisons between revisions.

	 Andrew

