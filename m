Return-Path: <netdev+bounces-248630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 242C0D0C54D
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 22:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12F7530D4D1D
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 21:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FB4221FBD;
	Fri,  9 Jan 2026 21:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Da9RZUY0"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E926500942;
	Fri,  9 Jan 2026 21:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767994356; cv=none; b=Mtj92UvDE1usf3jrsDQIVwWdisRAJL7dRTauCVQCbZyEzDEuJ2EH98jFXdQWFVibOQjHKsBmc+OUyQ4JPOrXG9Bjc8DBWYpd8olE1vuCJk8WplrkjkURI0wYCd0PJbJmILpG2fc4A9YK7dAAY7AzKHr3L3SYBzse0tikVhkezxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767994356; c=relaxed/simple;
	bh=fat2CoC7ZD57Pu0XLNkO1+A5yeIHqj50mpWtl2XZLtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFA6pBuHygOpTEvnn5dOo7SNHVXvjfLk0DrOKwbIzHFQfzjfWerdUgYNzGYpAKkauOKbzZtVsBcvUaRs9zp8pMTz2heSynXvylsZJVBdnFy7esaqNvHnsIdKQ7QYMxXTRolvm7XrL2UbufkMt9u9l147QNYwQzIq9w+TmTVyqiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Da9RZUY0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/nDQg9bpXjHmVcghjS2F7GZEWZqr2lL6ZJYKc/GvqCA=; b=Da9RZUY0CnXx47/5MElY2eW2+8
	fLTGpcDUgoxlZ5CiTDYeUwsc98LU3MUIu7PtL54otK/eEPnnTEmP/Fh6yq2Ln1qpuT5u7UKyx3GYK
	F9vfpHm5J45d6ymZGNdI5wnAo7xcha7rHyRfpjOWjYQQCTBqcEmejV7P9SnH+ZcS4wDLNwr/lAB5N
	abVpU3UkNqPnDM4Nq3woPGY78DzlTMxmbaZlulk3fLzZXlFvfhy+IKfx2Ym+M2Bn6GeK2xwB061st
	PUeibgU5OoqszN/Q7TBnGoPhsrDrz2gqeWIVDOcWhJhMOblJ+J5xoUTO92CRWQgJdM/Urmc0xkKST
	ZOUDm5ug==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56288)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1veK5m-000000004M5-3hoR;
	Fri, 09 Jan 2026 21:32:23 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1veK5i-000000003e9-0k86;
	Fri, 09 Jan 2026 21:32:18 +0000
Date: Fri, 9 Jan 2026 21:32:18 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Michael Klein <michael@fossekall.de>,
	Aleksander Jan Bajkowski <olek2@wp.pl>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/5] net: phy: realtek: simplify C22 reg access
 via MDIO_MMD_VEND2
Message-ID: <aWFz4TWNGEs7rGPF@shell.armlinux.org.uk>
References: <cover.1767926665.git.daniel@makrotopia.org>
 <938aff8b65ea84eccdf1a2705684298ec33cc5b0.1767926665.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <938aff8b65ea84eccdf1a2705684298ec33cc5b0.1767926665.git.daniel@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jan 09, 2026 at 03:03:22AM +0000, Daniel Golle wrote:
> RealTek 2.5GE PHYs have all standard Clause-22 registers mapped also
> inside MDIO_MMD_VEND2 at offset 0xa400. This is used mainly in case the
> PHY is inside a copper SFP module which uses the RollBall MDIO-over-I2C
> method which *only* supports Clause-45.

It isn't just Rollball. There are SoCs out there which have separate
MDIO buses, one bus signals at 3.3V and can generate only clause 22
frames. The other operates at 1.2V and can only generate clause 45
frames.

While hardware may elect to generate and recognise either frame types
at either voltage, this goes some way to explain why there are
implementations that only support one or the other on a particular
pair of MDC/MDIO wires.

Armada 8040 has this setup - there is one MDIO bus that only supports
clause 22 frames, and there is a separate MDIO bus that only supports
clause 45 frames.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

