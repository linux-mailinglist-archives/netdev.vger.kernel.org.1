Return-Path: <netdev+bounces-196628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A06AD5995
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 17:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C0387A8B19
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 15:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D301A23BA;
	Wed, 11 Jun 2025 15:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hiWnYlNV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA601A0BF3;
	Wed, 11 Jun 2025 15:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749654347; cv=none; b=hmCqztkAJIaC3QaUOr7wiImQ+09MIndYoHFdfgIFCvYHSD4bamHjBAfFoWGY0UhTlzR1ae70ipIuV8ogAofTdivSqROthWJ47puKRZGmMmQ3w+GSYKb8lNPuF+E/X80qpM8VFTkj7lZ1bSi1oktJh+4rS3cjCQCi/xDLlPHhd8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749654347; c=relaxed/simple;
	bh=GN263RmwEk00x8lzbSkBIhabezE842uTAO7Z1eXmkSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hu840eQmnTbvnHUXHxKEmBxGotHRssTeVlWKpA5i9HHpdEJ/w+y8VqbxfUr+q6cjZiKof9axDAEE0RF6HQXCrdRmA8gM+/q0IqXwjVeBoBsVGksTtssVc5OsuhYPvX4/e+A4HdCwqVgKwnlvbT7PbI2yhm0P08uKu1XHMCsvnyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hiWnYlNV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=J0ACVruKN2q4p/Qa6A04ZCMVXW2I9cmZiPjmdkppk/w=; b=hiWnYlNVjKoUvnmi4RKso3EEPZ
	ulLWMWHDeFIaWd5hFTU5U0s1B2X8GyZi8bXfuBF6QT1ied369ZeJFqJktGfvw6+EHluP3SUzqKG/A
	1kZGddH7MCe+zggdPa5VFROrxjAU+oZ6Z8AhGQYUa5U+0W+Y/LIYaxqnNo3dkO72pagk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uPN0z-00FPmp-T6; Wed, 11 Jun 2025 17:05:21 +0200
Date: Wed, 11 Jun 2025 17:05:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] dt-bindings: net: ethernet-controller: Add
 informative text about RGMII delays
Message-ID: <e08888ab-d190-4829-9aef-a8adef63b968@lunn.ch>
References: <20250430-v6-15-rc3-net-rgmii-delays-v2-1-099ae651d5e5@lunn.ch>
 <e4db4e6f0a5a42ceacacc925adbe13747a6f948e.camel@icenowy.me>
 <debcb2e1-b7ef-493b-a4c4-e13d4aaf0223@lunn.ch>
 <2e42f2f7985fb036bec6ab085432a49961c8dc42.camel@icenowy.me>
 <aEFmNMSvffMvNA8I@shell.armlinux.org.uk>
 <84c534f9dbfa7c82300863cd40e5a9b6e6e29411.camel@icenowy.me>
 <ba7b290d-0cd1-4809-822a-bfe902684d7e@lunn.ch>
 <9ebe16a8d33e00c39c142748a1ea6fff96b9565a.camel@icenowy.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ebe16a8d33e00c39c142748a1ea6fff96b9565a.camel@icenowy.me>

> BTW I found that in some case the assumption of PHY-side delay being
> always better than MAC-side one is wrong -- modern MACs usually have
> adjustable delay line, but Realtek 8211-series PHYs have only on/off
> delay with a fixed 2ns value.

There is another email conversation last month about this. The RGMII
standard says a 2ns delay is needed. If your hardware needs something
other than 2ns, it is breaking the standard. It probably means
somebody has been lazy and made a bad design. The PCB track lengths
have not been balanced, or the MAC or PHY internal delays are poorly
designed. Whatever, it is breaking the standard. We should not be
encouraging such bad design by making it easy to work around broken
designs.

There is also another thread about Broadcom MAC/PHY combinations, and
somebody doing tests and showing that combination is very robust to
delays, it will happily work with 1ns or 3ns, not just 2.00ns.

So in general, a fixed 2ns value should just work if you are
compliment to the standard.

> > > Well I am not sure, considering two examples I raised here (please
> > > note
> > > I am comparing QCOM ETHQOS and TI PRUETH two drivers, they have
> > > contrary handling of RGMII modes, and one matches the old binding
> > > document, one matches the new one).
> > 
> > Nope, i fully agree with Russell, the binding has not changed, just
> > the
> > words to explain the binding.
> 
> Well I read about phy.rst, and I found my understanding of the old
> binding matches my understanding of phy.rst, but does not match the new
> binding.

So please quote the text, explain how you interpret it, and maybe we
can then tell you how you have it wrong. Or i might admit that the
text needs more work to remove more ambiguities.

> Well I think "rgmii-*" shouldn't exist at all, if focusing on hardware.
> I prefer only "rgmii" with properties describing the delay numbers.

As Russell said, we cannot easily change it without breaking
systems. And i'm not convinced a new set of properties would be any
better. Developers are often lazy. They try various things until it
works and call it done. There are multiple ways of getting a MAC/PHY
link to work given the available parameters, and there are multiple
combination which works, but are not correct according to the
definitions. I expect the same to be true for a new set of
parameters. Laziness wins out over correctness.

And the real issue is more subtle. Working incorrect implementations
sometimes turn into broken incorrect implementations. We have seen
cases where somebody correctly describes their hardware in DT and it
did not work. Digging into the details, how the implementation was
broken was found, and fixed, so that it correctly implemented DT, and
made that correctly described board work. But in the process it broken
lots of incorrectly described but working boards.

	Andrew

