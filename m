Return-Path: <netdev+bounces-226907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A8EBA60E5
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 17:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBCDD1B23055
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 15:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1301F27604E;
	Sat, 27 Sep 2025 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CsnDsSrp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7572B1DE4FB
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 15:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758985932; cv=none; b=RNb7vNWiOC4XHumDKiu9voXioqmzUgj1oHZGUh0TfiC6tIH/GiPHVgQ5r1mdMFrkUbwfiIuYtL9PFNAEXIbmuzX3712E9R+IiOzOYIEqIsGdg739g7IhvitWeTn0T+OI5oFMUAg5XDGTqHHWrDcpmIK0sbBUhkVZmXZSlP7bp8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758985932; c=relaxed/simple;
	bh=Vy0k2mVWMp4wo9S3xuYBoahUJ2vO3N8E/kmrgUh07AI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKUwfqNJ5tUNb91FjSSfBPc7w9GC1gTGrtwWRbxxl7O4VlD57ITXaMvRMTerIBRQeuOFD2f/piWol1OB3fzoLvVRDLOCSRGKvLHNkoRfJFmn4IB3Y4FRDkXexu9EtTDtFfzVml9EdznI2XToFOZYp5OhA5cs+z6/Y8QPEPi0HVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CsnDsSrp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Q236Oh2TS2khj+FBBddn1YvNfYvK9uxAQSeoEwEhBvc=; b=CsnDsSrptyjNwbdUG6HW9DPRwI
	Grj9AaO7d7ZDfmR+uNgSZl4Vgw55epL5qfPMsXRuAQm19S0CozFr69r1ulQmsnumqgnBr4yqa3FzF
	p+VK2+aqNtpU2eSdsYikVJF5NN499iq/l31b6w4sDv78cfNqDAjbgjhYdrMI2dsQMEk8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v2Wak-009dzr-Bs; Sat, 27 Sep 2025 17:12:06 +0200
Date: Sat, 27 Sep 2025 17:12:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Luke Howard <lukeh@padl.com>
Cc: netdev@vger.kernel.org, vladimir.oltean@nxp.com, kieran@sienda.com,
	jcschroeder@gmail.com, max@huntershome.org
Subject: Re: [RFC net-next 3/5] net: dsa: mv88e6xxx: MQPRIO support
Message-ID: <79953e8f-a744-457b-b6b8-fa7147d1cbf5@lunn.ch>
References: <20250927070724.734933-1-lukeh@padl.com>
 <20250927070724.734933-4-lukeh@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250927070724.734933-4-lukeh@padl.com>

> +/* MQPRIO helpers */
> +
> +/* Set the AVB global policy limit registers. Caller must acquired register
> + * lock.

No where else in this driver is this assumption about the register
lock documented. If you forget it, the low level read/write functions
will tell you. So i don't think it adds value.

> + *
> + * @param chip		Marvell switch chip instance
> + * @param hilimit	Maximum frame size allowed for AVB Class A frames
> + *
> + * @return		0 on success, or a negative error value otherwise
> + */

kerneldoc wants a : after return. 

> +static int mv88e6xxx_avb_set_hilimit(struct mv88e6xxx_chip *chip, u16 hilimit)
> +{
> +	u16 data;
> +	int err;
> +
> +	if (hilimit > MV88E6XXX_AVB_CFG_HI_LIMIT_MASK)
> +		return -EINVAL;

Does it make sense to check it against the MTU? Does it matter if it
is bigger than the MTU?

> +/* Set the AVB global policy OUI filter registers. Caller must acquire register
> + * lock.
> + *
> + * @param chip		Marvell switch chip instance
> + * @param addr		The AVB OUI to load
> + *
> + * @return		0 on success, or a negative error value otherwise
> + */
> +static int mv88e6xxx_avb_set_oui(struct mv88e6xxx_chip *chip,
> +				 const unsigned char *addr)

Maybe be a bit more specific with the documentation of addr. You pass
a 6 byte address, not a 3 byte OUI. So "The AVB OUI to load" is not
quite correct. It is more like, "Use the OUI from this MAC address."
I've not looked at the big picture, but i was woundering if it makes
more sense to pass an actual OUI? But that is not something we tend to
do in the kernel.

> +static inline u16 mv88e6352_avb_pri_map_to_reg(const struct mv88e6xxx_avb_priority_map map[])
> +{
> +	return MV88E6352_AVB_CFG_AVB_HI_FPRI_SET(map[MV88E6XXX_AVB_TC_HI].fpri) |
> +		MV88E6352_AVB_CFG_AVB_HI_QPRI_SET(map[MV88E6XXX_AVB_TC_HI].qpri) |
> +		MV88E6352_AVB_CFG_AVB_LO_FPRI_SET(map[MV88E6XXX_AVB_TC_LO].fpri) |
> +		MV88E6352_AVB_CFG_AVB_LO_QPRI_SET(map[MV88E6XXX_AVB_TC_LO].qpri);
> +}
> +
> +static int mv88e6352_qav_map_fpri_qpri(u8 fpri, u8 qpri, void *reg)
> +{
> +	mv88e6352_g1_ieee_pri_set(fpri, qpri, (u16 *)reg);
> +	return 0;

Blank line before the return please.

> + *	- because the Netlink API has no way to distinguish between FDB/MDB
> + *	  entries managed by SRP from those that are not, the
> + *	  "marvell,mv88e6xxx-avb-mode" device tree property controls whether
> + *	  a FDB or MDB entry is required in order for AVB frames to egress.

We probably need to think about this. What about other devices which
require this? Would it be better to extend the netlink API to pass
some sort of owner? If i remember correctly, routes passed by netlink
can indicate which daemon is responsible for it, quagga, zebra, bgp
etc.

> + *	  To avoid breaking static IP MDB entries, only multicast addresses
> + *	  with OUI prefix of 91:e0:ff (IEEE 1722 Annex D) will have the AVB
> + *	  flag set on their ATU entry.

This probably answers my question bellow.

> +/* The MAAP address range is 91:E0:F0:00:00:00 thru 91:E0:F0:00:FF:FF
> + * (IEEE 1722 Annex D)
> + */
> +static const u8 eth_maap_mcast_addr_base[ETH_ALEN] __aligned(2) = {
> +	0x91, 0xe0, 0xf0, 0x00, 0x00, 0x00
> +};
> +
> +static inline bool ether_addr_is_maap_mcast(const u8 *addr)
> +{
> +	u8 mask[ETH_ALEN] = { 0xff, 0xff, 0xff, 0xff, 0x00, 0x00 };
> +
> +	return ether_addr_equal_masked(addr, eth_maap_mcast_addr_base, mask);
> +}

Since these are part of a standard, i assume other drivers will need
it as well? These should probably be somewhere common.


