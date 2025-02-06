Return-Path: <netdev+bounces-163664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F45A2B33D
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 21:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621993A35F2
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 20:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2121B4F0C;
	Thu,  6 Feb 2025 20:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oL8RPfhH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983A219CCEA;
	Thu,  6 Feb 2025 20:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738873048; cv=none; b=VaLHiNmYgMhb4fLBJD7eix+Xd5TxGG1DPx3terv9a3dmmDdq+aZfaXr8zhscoJzMFI1ytiAzGfRilBTGIrB4iiI09ehXErwXtqtB7RShioQirj/M/LAJulKR12AstJo2wElrW4eo9AyJTHAvyi5XD+vR+K+Ng3mz7c5TRIS7acU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738873048; c=relaxed/simple;
	bh=WjzpEuXQ/k5+ear1Nx8eLvUG8ahOuJMNOCWjsXv11wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/+yKL5ggyDGoOr0739PETSVRinuLZIzX/TDzYNglaPtJw4MSvDCpHIkxDMM/KN5r7r0S+iRg1QU/M1vqZKRPi4N4do70CypL3z6BPMU8Xxs/P+VJcr26i0j/H6mBznK1FB7F0Zdqmb7fnIR/YzKjL+4G7pgJCPPkPkmPzK5LcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oL8RPfhH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jvPDh0Nohh3uM1+R1rm0t2ikmp0Ii5bjL5aU3UeCHVQ=; b=oL8RPfhHYbcshgKjLJJIOPm/MJ
	P4Trv6TGlGqAGmJV9OoeBZyJpS4OhExnYxnYL7pnwt9mjyHCVmnCVuf0uHlA2k5T4NPNXfxMgte+g
	CnUXUwC4jXi4wazsy2uWQQOO1wRANLzAJl+MyHtc2Gd46XIQk6PQbYKRRCfSnauudWfk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tg8JD-00BczM-Ii; Thu, 06 Feb 2025 21:17:11 +0100
Date: Thu, 6 Feb 2025 21:17:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Kyle Hendry <kylehendrydev@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] net: dsa: b53: Enable internal GPHY on BCM63268
Message-ID: <9bd9c1e4-2401-46bd-937f-996e97d750c5@lunn.ch>
References: <20250206043055.177004-1-kylehendrydev@gmail.com>
 <1317d50b-8302-4936-b56c-7a9f5b3970b9@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1317d50b-8302-4936-b56c-7a9f5b3970b9@broadcom.com>

On Thu, Feb 06, 2025 at 10:15:50AM -0800, Florian Fainelli wrote:
> Hi Kyle,
> 
> On 2/5/25 20:30, Kyle Hendry wrote:
> > Some BCM63268 bootloaders do not enable the internal PHYs by default.
> > This patch series adds functionality for the switch driver to
> > configure the gigabit ethernet PHY.
> > 
> > Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
> 
> So the register address you are manipulating logically belongs in the GPIO
> block (GPIO_GPHY_CTRL) which has become quite a bit of a sundry here. I
> don't have a strong objection about the approach picked up here but we will
> need a Device Tree binding update describing the second (and optional)
> register range.

Despite this being internal, is this actually a GPIO? Should it be
modelled as a GPIO line connected to a reset input on the PHY? It
would then nicely fit in the existing phylib handling of a PHY with a
GPIO reset line?

	Andrew

