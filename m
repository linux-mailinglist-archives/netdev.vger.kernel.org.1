Return-Path: <netdev+bounces-241572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE96C85F3A
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 17:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 27792352E47
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 16:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588C41F1518;
	Tue, 25 Nov 2025 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="w3o2DKI4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B2522A4EB;
	Tue, 25 Nov 2025 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764087612; cv=none; b=DneK9z/r8yK45uIOLPnpR5vB47KrhK/33dAcl3YQiPare6Dcb8+zgI3vRMlDxcPveibjiLcnANfLjIGQQKGm+OhnMVE6aZgI30PkOwKl8Pnn6cKsPU2F1NQ90uWCWwTFyvfw5OtrgK4IazSCP2PqKn/noCpeMNua5oLb4dcxosU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764087612; c=relaxed/simple;
	bh=Sb8PYC39UtTJVw/SBaIg/BW0P8JGqchWhqkLuKMq/CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDub35UYos+grcPaluNONkY1NxZahsSIsSx1S/hZvqXGaUO+K0VRWFbN3iUxQVnJwGuDHBLBIkBqzptqHVhlbA2tqy+M8CVVOEqE/FAOBHKzYqGaqJsxPOwcekBMG2QDmwT3LwTj/kNLXnJPeHFXF5fLoZEMoR9XVVnNRNts0q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=w3o2DKI4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=saycRsU5HZMgrOY6FgBWMKFyWl/Pb+ueWB3SQnvSrKg=; b=w3o2DKI4vhH8siIz+Ag5QoM0DM
	D6e9JwwJqeesT9Qv6NyfNATkUYlLFuDwbehTs6rx84MCTDoJIxs1v6krOq1rioZtcs4PMXHyLcnnK
	aveMsCrlcRCnqxNCbKge3GApcjDj0G5IfMoh3rSk0fGWuNopkpEJNHZgNOwDO9MYu6uA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vNvlm-00F23M-VE; Tue, 25 Nov 2025 17:19:58 +0100
Date: Tue, 25 Nov 2025 17:19:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Wei Fang <wei.fang@nxp.com>, claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, aziz.sellami@nxp.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net-next 3/3] net: enetc: update the base address of
 port MDIO registers for ENETC v4
Message-ID: <c177a361-84dc-4523-8b1f-5c6a4437b064@lunn.ch>
References: <20251119102557.1041881-1-wei.fang@nxp.com>
 <20251119102557.1041881-4-wei.fang@nxp.com>
 <46765613-9a04-454b-8555-21f6fd965008@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46765613-9a04-454b-8555-21f6fd965008@redhat.com>

On Tue, Nov 25, 2025 at 11:05:06AM +0100, Paolo Abeni wrote:
> On 11/19/25 11:25 AM, Wei Fang wrote:
> > Each ENETC has a set of external MDIO registers to access its external
> > PHY based on its port EMDIO bus, these registers are used for MDIO bus
> > access, such as setting the PHY address, PHY register address and value,
> > read or write operations, C22 or C45 format, etc. The base address of
> > this set of registers has been modified in ENETC v4 and is different
> > from that in ENETC v1. So the base address needs to be updated so that
> > ENETC v4 can use port MDIO to manage its own external PHY.
> > 
> > Additionally, if ENETC has the PCS layer, it also has a set of internal
> > MDIO registers for managing its on-die PHY (PCS/Serdes). The base address
> > of this set of registers is also different from that of ENETC v1, so the
> > base address also needs to be updated so that ENETC v4 can support the
> > management of on-die PHY through the internal MDIO bus.
> > 
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> 
> Andrew, it's not clear to me if you are with the current patch version,
> could you please chime-in?

I say merge it. I'm not sure it is the best of architectures, but i
don't have time to dig into all the details in order to suggest
something better.

	Andrew

