Return-Path: <netdev+bounces-174751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FCAA602B4
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 21:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF84C17E998
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 20:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFA41F4160;
	Thu, 13 Mar 2025 20:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hPXDeoEm"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDB516B3A1;
	Thu, 13 Mar 2025 20:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741898131; cv=none; b=DiVR4RRbHqhPq3yjP2KVBF15KhcDdZMhgaKMyhtfEapRBsJEzEnGoiFX6ro1NqbIx+oj+UzDDCC9Hbu4PdJsyi7ZTkzHo0W1WeSIr/jbL2GzJa1WaLG8ezVZsfZyyOh7G32/+fiAv2FgqvA1wiyDJz+NU/ZJlbFdwwoK2ouZDoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741898131; c=relaxed/simple;
	bh=vG1/GTZTztaKTlFbvjaWpZ7BP6jdv4Vi801Ajq1rZxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhmdZP9VcbbxYDeuu6RHSS+SNrqMeV22kkLGhqEJo2IW9GiJ0ORqwFnQrPqrbXLuXNbjl2ind07CpRRM+Ehe9bWsj/uIlbtDNvELsq8Sjw7VOFWyi7yOM2Q+DJh5DwAw4+VRsaupJdd2CUVAzX59X+dgi53c1Byiq25z3EYy+pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hPXDeoEm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=47pVUFdvv/TqY2u3zdaa6j0HG9FLVWfVN2aBELxBuiE=; b=hPXDeoEmQp90e5m6r6DEysatbO
	a5RBxQjmlA+6jQBUOcyA3g2CG47an3uhOzVB21iFiUJCBEJm77HxomiNhjCq+esOnT5XjXbPvzMwd
	sSjRcTSnBM3eu/d03my6FROS8urAsi5lfzWqlXIS1KH6P/uCPLkUe5bzLZQ33jrKGJZY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tspGj-0056DQ-Tk; Thu, 13 Mar 2025 21:35:05 +0100
Date: Thu, 13 Mar 2025 21:35:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	"markus.stockhausen@gmx.de" <markus.stockhausen@gmx.de>,
	"sander@svanheule.net" <sander@svanheule.net>,
	netdev <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10] net: mdio: Add RTL9300 MDIO driver
Message-ID: <be39bb63-446e-4c6a-9bb9-a823f0a482be@lunn.ch>
References: <20250313010726.2181302-1-chris.packham@alliedtelesis.co.nz>
 <f7c7f28b-f2b0-464a-a621-d4b2f815d206@lunn.ch>
 <5ea333ec-c2e4-4715-8a44-0fd2c77a4f3c@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ea333ec-c2e4-4715-8a44-0fd2c77a4f3c@alliedtelesis.co.nz>

On Thu, Mar 13, 2025 at 07:54:39PM +0000, Chris Packham wrote:
> +cc netdev, lkml
> 
> On 14/03/2025 01:34, Andrew Lunn wrote:
> >> +	/* Put the interfaces into C45 mode if required */
> >> +	glb_ctrl_mask = GENMASK(19, 16);
> >> +	for (i = 0; i < MAX_SMI_BUSSES; i++)
> >> +		if (priv->smi_bus_is_c45[i])
> >> +			glb_ctrl_val |= GLB_CTRL_INTF_SEL(i);
> >> +
> >> +	fwnode_for_each_child_node(node, child)
> >> +		if (fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45"))
> >> +			priv->smi_bus_is_c45[mdio_bus] = true;
> >> +
> > This needs more explanation. Some PHYs mix C22 and C45, e.g. the > 1G
> > speed support registers are in the C45 address space, but <= 1G is in
> > the C22 space. And 1G PHYs which support EEE need access to C45 space
> > for the EEE registers.
> 
> Ah good point. The MDIO interfaces are either in GPHY (i.e. clause 22) 
> or 10GPHY mode (i.e. clause 45). This does mean we can't support support 
> both c45 and c22 on the same MDIO bus (whether that's one PHY that 
> supports both or two different PHYs). I'll add a comment to that effect 
> and I should probably only provide bus->read/write or 
> bus->read_c45/write_c45 depending on the mode.

Is there more to it than this? Because why not just set the mode per
bus transaction?

	Andrew

