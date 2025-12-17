Return-Path: <netdev+bounces-245098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 610B4CC6CDE
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 10:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49D893033D50
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 09:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4D033AD97;
	Wed, 17 Dec 2025 09:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="la+78ZpZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B61A1A5B84;
	Wed, 17 Dec 2025 09:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765963894; cv=none; b=Ay/pHOAdRRwNDulE9lwTKcv+6jwoZTfG931BVE/VsuJYCxpPOObkPuHsL18Q9u954pBRSIKR5QxDE17lE43PVCZyTvi5q53ZDTuBz6kwN4/0/gYPMNKqAwUuElhvCIOLCGCOJESRLuqglPjdxuIUZlVbVtAGdFvZ8oAbk9iQlC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765963894; c=relaxed/simple;
	bh=BXLxzbhseqWW9+E3ZG8MG2xyKFCRlYCC+0xv1drqtqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObLXqqz3dfp16orwkm2Qy/PQpKsrffBb1BJl0HVHkbSOfJwNcLyTnaDlLXeNHkkC503ZwQ2TEoDqAiw+36uJB7stCTraQL+XkqrmILwjYDv8PTftEBUVB1gdU2kOnWq2XO/6aNGEdMqFb55DojWyDVwysYVGX0ozweY7zmWTR9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=la+78ZpZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xdEcrPWkvSAzg336AKvARmimsvC4eRURp1eBqPrzmIM=; b=la+78ZpZtKYDyxdj+Eogbdk4DL
	Iee0BnQhwxMyVrjMGTF4CeCYwvKPzaUS8i4m6nxfhoNAKaXyYmjB9N1oMsIBLxoSoR5emN+4uMmlZ
	t/ZTBHEswXe2CJLd211b8n4L4HWdMgVs6bIxfUj2qhpbEpGqzJbnmU/sLjxyztk6yc/A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vVnsH-00HBiP-3R; Wed, 17 Dec 2025 10:31:13 +0100
Date: Wed, 17 Dec 2025 10:31:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lee Jones <lee@kernel.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 07/15] mfd: core: add ability for cells to probe
 on a custom parent OF node
Message-ID: <987743fa-5673-4067-9a53-f5155b8d9ad8@lunn.ch>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
 <20251118190530.580267-8-vladimir.oltean@nxp.com>
 <20251120144136.GF661940@google.com>
 <20251120153622.p6sy77coa3de6srw@skbuf>
 <20251121120646.GB1117685@google.com>
 <20251121170308.tntvl2mcp2qwx6qz@skbuf>
 <20251215155028.GF9275@google.com>
 <20251216002955.bgjy52s4stn2eo4r@skbuf>
 <20251216091831.GG9275@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216091831.GG9275@google.com>

> > Name         Description                                         Start      End
> > SWITCH       Ethernet Switch Subsystem                           0x000000   0x3ffffc
> > 100BASE-T1   Internal MDIO bus for 100BASE-T1 PHY (port 5 - 10)  0x704000   0x704ffc
> > SGMII1       SGMII Port 1                                        0x705000   0x705ffc
> > SGMII2       SGMII Port 2                                        0x706000   0x706ffc
> > SGMII3       SGMII Port 3                                        0x707000   0x707ffc
> > SGMII4       SGMII Port 4                                        0x708000   0x708ffc
> > 100BASE-TX   Internal MDIO bus for 100BASE-TX PHY                0x709000   0x709ffc
> 
> All in drivers/net.

I've not been following this conversation too much, but i would like
to point out that what you find in drivers/net is not a uniform set of
drivers, but a collection of different driver types.

SWITCH might belong on drivers/net/dsa
100BASE-T1 might belong on drivers/net/mdio
SGMIIX might belong in drivers/net/pcs
100BASE-TX might belong in drivers/net/mdio

I also expect those T1 and TX PHYs have drivers in drivers/net/phy,
but they are not memory mapped, so not on your list.

Each driver can probe independently, registering with different parts
of the net core. And then the switch driver will link all the parts
together using phandles.

Saying that all the sub drivers are in drivers/net seems an odd
argument it is not an MFD.

	 Andrew

