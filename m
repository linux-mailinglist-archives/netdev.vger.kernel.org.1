Return-Path: <netdev+bounces-209107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8502BB0E52B
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 23:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA2C258043F
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 21:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F68285C8E;
	Tue, 22 Jul 2025 21:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DMD8TWmY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01D22857F0;
	Tue, 22 Jul 2025 21:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753218012; cv=none; b=Z58v2115a9vgU/A4RxgtKTZBNGvrKT8620MAuUxvDcdTqgio4ieho74lQNR6rZEjH25luGI3zj8Uu1g7hiz5Yy9ezvsMOZuY07qpOEGGYuqbyr+D4T7DGbkNj6iJiZaHI6MsFeUhPej4lOrg65nwycP7ElEjXUTILA54HXZr6vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753218012; c=relaxed/simple;
	bh=424qtBj7As3BusOn+abIiFBQyCjPATLbPyyiCsGTn/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4dDJMiTKqR89eP63vP9R2dyFQxBHspYIdTcWjcjefz36iC6GpEEjg4Htb7G+2YpnuJAD58iDa0d0rhAMR+ewvO85i3NdmdwWGLfhF+MxRvRkLKxXfEVc5lal4idv5QKsWRloxRF9GhVJMV2ouIqDkDyCXKi2U8Lvr3+PFWp04s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DMD8TWmY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eVLbWCzQczw2dFn7K3G8G8HQYlWdsk18wtghWYXLXEs=; b=DMD8TWmYpjGyDAzTKybNamT+9v
	SMMohcfkCxMGht1XfGZKiyP/Qib/NSMjLLos+LeLQa96Y4GQGSFrjFFwqk/pQ5VgZmgaYiqNsVZi9
	5T9ER95fROMwNnkI03V/xl204eX2geij4sBPIBBSPkjVK3onQrXq4cPe4MPu/8yU1NOM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ueK5X-002VRl-Bv; Tue, 22 Jul 2025 22:59:51 +0200
Date: Tue, 22 Jul 2025 22:59:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Tristram Ha <Tristram.Ha@microchip.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: document st,phy-wol
 property
Message-ID: <ae31d10f-45cf-47c8-a717-bb27ba9b7fbe@lunn.ch>
References: <20250721-wol-smsc-phy-v1-0-89d262812dba@foss.st.com>
 <20250721-wol-smsc-phy-v1-1-89d262812dba@foss.st.com>
 <faea23d5-9d5d-4fbb-9c6a-a7bc38c04866@kernel.org>
 <f5c4bb6d-4ff1-4dc1-9d27-3bb1e26437e3@foss.st.com>
 <e3c99bdb-649a-4652-9f34-19b902ba34c1@lunn.ch>
 <38278e2a-5a1b-4908-907e-7d45a08ea3b7@foss.st.com>
 <5b8608cb-1369-4638-9cda-1cf90412fc0f@lunn.ch>
 <383299bb-883c-43bf-a52a-64d7fda71064@foss.st.com>
 <2563a389-4e7c-4536-b956-476f98e24b37@lunn.ch>
 <aH_yiKJURZ80gFEv@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aH_yiKJURZ80gFEv@shell.armlinux.org.uk>

>         if (!priv->plat->pmt) {

Let me start with maybe a dumb question. What does pmt mean? Why would
it be true?

>                 struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
> 
>                 phylink_ethtool_get_wol(priv->phylink, &wol);
>                 device_set_wakeup_capable(priv->device, !!wol.supported);
>                 device_set_wakeup_enable(priv->device, !!wol.wolopts);

Without knowing what pmt means, this is pure speculation....  Maybe it
means the WoL output from the PHY is connected to a pin of the stmmac.
It thus needs stmmac to perform the actual wakeup of the system, as a
proxy for the PHY?

	Andrew


