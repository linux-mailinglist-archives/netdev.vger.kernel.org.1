Return-Path: <netdev+bounces-247091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CDDCF4635
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 16:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8B2130230E0
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 15:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FACC25A2CF;
	Mon,  5 Jan 2026 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2vwEU2eG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9111C84D0;
	Mon,  5 Jan 2026 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767626813; cv=none; b=n+LFltnhRSJff3Y3u7/ib9owgrIsIOC5i935lNQfR3fHBxb8gnYh0z9QzY1E3pqaAqoM/XmZlxWb10+KAEjCEcUK0gaqJ06PIwq5oYmVaPyrw0GrmPL2tRxVPbLyF5kIlc75v4EoNyc+YLLqoNsNV+naUKBLTpegpUXzgu8cw2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767626813; c=relaxed/simple;
	bh=xz/PTjb0T5tqZ1oFEXNMyfRkMFounVQ0xM2RI3JAMpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R79WoDMQ4eVaqkJ2PBa+m7QTphyACEn3wkOY2CPxuW5giFbmLKENlhJsrGvtYs9vvJm6r3lmPVpE1GL/Uac4Lz+v3liPL57Q8c43l8zMYWbhYSEztrAKK7X853YNL5W0g1vDj6MgBTEI7JwNG25Ae/pc4clQSiNtHKPs/CRIJfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2vwEU2eG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HZ3xa3P/xVD4k6aRA4vAlvbRr8JEcexhofE4zzLTRUs=; b=2vwEU2eG0aUaJ3bNDwH4OOsDdR
	n6K+LJiqiWFCDf3xWEand32l3DoMR00YAHydOCnaFPZAGSjcmS/Xq6pfOYzhVXW66Oza3yNXp7AN0
	+35/3QTWslyDCbrrl5a/LkjDK8x4quyOHMFTjkNupeugsyPIiJsA4rL/HT3fEeWRF3HE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vcmTg-001V8O-9t; Mon, 05 Jan 2026 16:26:40 +0100
Date: Mon, 5 Jan 2026 16:26:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, francesco.dolcini@toradex.com,
	robh@kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH RESEND net-next v2] net: stmmac: dwmac: Add a fixup for
 the Micrel KSZ9131 PHY
Message-ID: <a597b9d6-2b32-461f-ac90-2db5bb20cdb2@lunn.ch>
References: <20260105100245.19317-1-eichest@gmail.com>
 <6ee0d55a-69de-4c28-8d9d-d7755d5c0808@bootlin.com>
 <aVuxv3Pox-y5Dzln@eichest-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVuxv3Pox-y5Dzln@eichest-laptop>

> Unfortunately, I'm afraid of breaking something on the platforms
> that are already working, as this is an Ethernet controller
> issue. As I understand it, the PHY works according to the standard.

What is the exact wording of the standard? I'm assuming this is IEEE
802.3?  Please could you quote the relevant part.

Thanks
	Andrew

