Return-Path: <netdev+bounces-196936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C06E3AD7001
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 14:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7D901894F1B
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1382F4329;
	Thu, 12 Jun 2025 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TFBy6wYU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975B72F4315
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749730689; cv=none; b=UIAD1wWAk+pO8bJmAwLM2lzOr7RjaxFaPnljQwDs07IKFbtM6VfKNJiDkRpGXRHBVrddndiIu0/vNUa4wY4oQzCpyJgVJKr+vsaPyol1MTvLTwI7pX2HKkXwfzFB2AO1YIKSJg9rxhb5XN80Ufvm2LoOH9KMpFl1YkuHypJX/8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749730689; c=relaxed/simple;
	bh=Pu0BMWkLWDIpJEiQ31D7laU90f0eD2Xd6QZV+8v6xZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/S6vU8fqu0gaENYuZvZGSmmVcpwbBfnPu4STKv1fklPy/lbXkadjrAtfD69lcjRFYZFsvQSJLBQ+wJoonLrZtliw3z8hd3I8fpTO9KOr3yDJSa2DIKXR97UgAgZVwSjWrZCwDzeDwsU53vjcgq/Mhh5lpZtcsn2127lKemu0tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TFBy6wYU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=URk7NbWnaM36duZjaEGvuxWtbMijrYsnCwLGIvQBltg=; b=TFBy6wYUmxMyf5hlTbwzMOMHB6
	FNnLksLawWo7U5OWpcvhYzWYaEluVzuXtm6iizUq7wcpEJPK523A7jZsVdNp7GQScwWWWxQQ9ssRY
	sWAlqSJGQk4EicMaB9NaSBTnbSj1xXdYIzlx0spLsLjb3Qh3FbC6TeeqMmjasQImlOiQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uPgse-00FXJ8-Pn; Thu, 12 Jun 2025 14:18:04 +0200
Date: Thu, 12 Jun 2025 14:18:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Janpieter Sollie <janpieter.sollie@kabelmail.de>
Cc: netdev@vger.kernel.org
Subject: Re: [support request]: where should I register this (apparently not
 supported yet) transceiver?
Message-ID: <da8834aa-da77-4633-ac6f-d2b738a97337@lunn.ch>
References: <5568c38c-5c93-493a-96bd-b6537a4d1ad6@kabelmail.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5568c38c-5c93-493a-96bd-b6537a4d1ad6@kabelmail.de>

On Thu, Jun 12, 2025 at 10:58:23AM +0200, Janpieter Sollie wrote:
> Hi Everyone,
> 
> I'm looking for support to register my trainsceiver in the phy subsystem.
> This RJ45 transceiver (ZK-10G-TX) looks very weird in ethtool:
> 
> |> Identifier : 0x03 (SFP)
> > Extended identifier : 0x04 (GBIC/SFP defined by 2-wire interface ID)
> > Connector : 0x07 (LC)
> > Transceiver codes : 0x10 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> > Transceiver type : 10G Ethernet: 10G Base-SR
> > Encoding : 0x06 (64B/66B) BR
> > Nominal : 10300MBd
> > Rate identifier : 0x00 (unspecified)
> > Length (SMF) : 0km
> > Length (OM2) : 80m
> > Length (OM1) : 20m
> > Length (Copper or Active cable) : 0m
> > Length (OM3) : 300m Laser
> > wavelength : 850nm
> > Vendor name : OEM
> > Vendor OUI : 00:1b:21
> > Vendor PN : ZK-10G-TX
> > Vendor rev : 1
> > Option values : 0x00 0x1a
> > Option : TX_DISABLE implemented
> > BR margin max : 0%
> > BR margin min : 0%
> > Vendor SN : 2505010443
> > Date code : 250412
> > Optical diagnostics support : Yes
> > Laser bias current : 6.000 mA
> > Laser output power : 0.5000 mW / -3.01 dBm
> > Receiver signal average optical power : 0.4000 mW / -3.98 dBm
> ...
> 
> I cannot read its pages with i2c tools.
> It has a big "AQR113C" sticker on it,

The protocol to talk to the PHY is not defined in the standards.
However, there are two main protocols. It could be this PHY needs
rollball.

Please try adding an entry to drivers/net/phy/sfp.c:sfp_quirk[]
for this SFP, using sfp_fixup_rollball.

It might work, it might not...

	Andrew

