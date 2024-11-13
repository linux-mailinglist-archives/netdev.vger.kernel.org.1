Return-Path: <netdev+bounces-144605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E680A9C7EB4
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 00:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35A68B22025
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 23:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6196918C330;
	Wed, 13 Nov 2024 23:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="y+PFKmMM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F75D18BB84;
	Wed, 13 Nov 2024 23:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731539666; cv=none; b=bSW1yTJN07VV4g+I/Tk+0x3AeH9JJqC57qdnklewzVNZNyMRrDS2A+kN9MtC1WOFtlGVnXQrt66Qm70QBP7ZyIIKRJac09hbG3cXGUsazcDyVgtEJHQCELDXl6M3psb9CadR8FGE3n1s4UbLZ8xJV15zHLoC9+OZldSCD8DkuAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731539666; c=relaxed/simple;
	bh=AuibqiTSNi9NWDzjDHjShst4mltVJ4baY9TgjiGj0HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MekF3DiOlcEv03GBcp2GFqs6Tjo0x3OGCzQ6aPr2Q1xtfjZ1v8+udmUq3+0lTaXwv5isPwLtEA3qxOOsw9aJm3OyZNsN4VO4YlbUNRfnErKyKIXipakkKsjY+yMofijvU4pQSxxdnjpX6nuq23jt7DLJuYG1yRUSbpzQdmPLhoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=y+PFKmMM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cHGRqTPhJ9nMEgsdRx3WnAlpB6oRfbvNXgkE4xQuo2Y=; b=y+PFKmMMkLJsOHrLKwgwrwCgPB
	jMiu6pD4csqvPlZl9HDL9wB5o3+ZZCu2p4/6/sC9RXTvYstviTqQ5/lpzKGneYK8n66mRs64IglqL
	sGB1PM3Wv2bxoqMXxRtnAlfCxgZsb7RFcAt5hYDt1+X49plqVgC/mFHBCwnV0yeqPOvI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tBMYx-00DDfe-KR; Thu, 14 Nov 2024 00:14:15 +0100
Date: Thu, 14 Nov 2024 00:14:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: mdio-mux-gpio: Drop
 undocumented "marvell,reg-init"
Message-ID: <92cabc6c-2124-4fcb-b1aa-c5d9a6adf88e@lunn.ch>
References: <20241113225713.1784118-2-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113225713.1784118-2-robh@kernel.org>

On Wed, Nov 13, 2024 at 04:57:13PM -0600, Rob Herring (Arm) wrote:
> "marvell,reg-init" is not yet documented by schema. It's irrelevant to
> the example, so just drop it.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

