Return-Path: <netdev+bounces-153949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAC89FA29C
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 22:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A93427A1B29
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 21:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6D819995A;
	Sat, 21 Dec 2024 21:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1J6ua/y9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAA2189F45
	for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 21:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734816995; cv=none; b=ONJ2a6P3T6wJOOqqPfZ9EoFigvs7FvEMjONWBHQN4nsWeq8i95XxwtKlzU0wYnknC72yAhxB5xAfGKP0eiyWdIfuTtL3540nOCoZtoThyjwDl+w9NKMrN7saeM0rJynhFmFzGnEzOShORIUGNPjmjzyIU9xuv6RmzmaHvkkZ5bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734816995; c=relaxed/simple;
	bh=42HXxU5IPFjhrORX57OvExO9kiiDp+/nBYJqHHMe+ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdV5dKG3ZIZxd9Kq76xp5J5GbUTM6B2wKyd8OgJ36f1Za+ORB3sCPcB2NALB7KZ9339hUWA4TuroLN4ldFSDyYQybBkfJvm3jl5hebP6CNc+fdCdlbvu57XNrqf2JI1X+jTDJcV8l1iPh/iw8YRldDTUzWkVfyDA7XYbqTeeOmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1J6ua/y9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=08zv0r7jzn3UbviVuUG4GJtw+wLi6/YNh8Im61mNQgk=; b=1J
	6ua/y98jr9qakuVLGGETPCMAp/Dl61GSgNxDVNOmUphq7MEw0bhB+hxw/qY31bSKMbQF0uQYT2pdz
	jUO6v4670cxtm5Ej0xWlt3GnR6cphkDUGrVnFhQoMtbQOKHZAryebzz7vMmhOhtRPRJX8mwOCkuvR
	bD0tguX5I0HmXX0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tP794-002Osd-VD; Sat, 21 Dec 2024 22:36:22 +0100
Date: Sat, 21 Dec 2024 22:36:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Luke Howard <lukeh@padl.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	Kieran Tyrrell <kieran@sienda.com>,
	Max Hunter <max@huntershome.org>
Subject: Re: net: dsa: mv88e6xxx architecture
Message-ID: <5bdb17e0-cd7a-44e3-bdd4-d0686ea61b14@lunn.ch>
References: <B50BFF9A-DD1D-45AC-80BF-62325C939533@padl.com>
 <B50BFF9A-DD1D-45AC-80BF-62325C939533@padl.com>
 <20241220121010.kkvmb2z2dooef5it@skbuf>
 <7E1DC313-33DE-4AA8-AD52-56316C07ABC4@padl.com>
 <fbbd0f33-240f-41c7-bb5f-3cea822c4bf9@lunn.ch>
 <F8AE422A-2A10-4C39-A431-DA6E668797D3@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F8AE422A-2A10-4C39-A431-DA6E668797D3@padl.com>

On Sat, Dec 21, 2024 at 09:52:27AM +1100, Luke Howard wrote:
>     For a moment, forget about Marvell. Think about a purely software
>     solution, maybe using the Linux bridge, and a collection of e1000e
>     cards. Does the same problem exist? How would you solve it?
> 
> 
> One could:
> 
> * Add (e.g.) TCA_MQPRIO_TC_ENTRY_SRP to indicate the TC is associated with a
> SRP class
> * Add (e.g.) NTF_EXT_SRP_MANAGED to indicate the FDB/MDB entry was inserted by
> the SRP daemon

Doesn't FDB/MDB imply you have a bridge? What about an isolated port
which is not a member of a bridge, there is only local traffic?

> Packets with TCs marked TCA_MQPRIO_TC_ENTRY_SRP to DAs not marked
> NTF_EXT_SRP_MANAGED would be dropped (or deprioritised).
> 
> For mv88e6xxx, TCA_MQPRIO_TC_ENTRY_SRP would be supported for “AVB” traffic
> classes, and NTF_EXT_SRP_MANAGED would map to MV88E6XXX_G1_ATU_DATA_STATE_
> {UC,MC}_STATIC_AVB_NRL.
> 
> Or, we do nothing. As far as I can tell the biggest issue with not supporting
> this is whether the bridge would pass the Avnu test suite. That’s not so
> important to me, but it might be to some other users.

It is back to, we use the hardware to accelerate what Linux can
already do in software. If you only use the switch ports in isolated
mode, no bridge, you could probably get away with not supporting AVB
on the linux bridge. But if you need the software bridge to setup the
acceleration via a hardware bridge, you will need the software bridge
to work with AVB without acceleration.

	Andrew

