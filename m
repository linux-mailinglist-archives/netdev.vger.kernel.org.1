Return-Path: <netdev+bounces-160550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0022DA1A224
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 11:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49F2816CECE
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 10:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D42B20D4FF;
	Thu, 23 Jan 2025 10:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DUuzo9eH"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D82186A;
	Thu, 23 Jan 2025 10:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737629233; cv=none; b=dt3EKVsr/xZ16YMt4QLeLEUJCzxtuEDjjeFWvB+RL0GtBz+UvUxUSWONSWg6c08xtdUd/zPjHMTYs8wZf8PNWy+kDvyO1UwmnOtERXjWU9ILvxNWcSLa2yxGoNdiymbVUqf1kzP52hABfIlTkCaIfKjP1MAforjFpJT+80K9Etc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737629233; c=relaxed/simple;
	bh=ldv2yx7//HvG97ZMakEiZJCNXqlwF//BRONJRWhNM/o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gi0QfL7oCS8U2+EvmLICrddV3LUG+xFh+6qC0VsF2Vi3S1qVWAjq2fteGg/MTS5zM20HPWpGQGQBhACkFmftpRcYFb2x62XpocbG/jTBMz2M7hhT5Lv6hEsRWuLcn6ZRj0xb6nC3+RDq3RKuf6T2r4MqzdwOPzN+WCZCoXTRhGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DUuzo9eH; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 33211E000C;
	Thu, 23 Jan 2025 10:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737629228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z57cSE1YbxqFMvNXpCY9G1ml/Qmrt4h2lF0Z1wJAZeg=;
	b=DUuzo9eHub7/9PHurqPsH7DVY2E29qZysu/JXIZMuv4LVRmHZ/6ECt7tt2VnNLXJ8aNBEH
	R78LqtD/c5I3LNz2jM/92soLfSDNIPPM5ibHpyBjO1fdyWXFT9gJRk60J18pmwOuoXYaqC
	JarofkUBD6J08p72p8SEVzURzJPyLC27BqGGutcCUADiDKWxPe7CZ3QqOXFcyvOWPsmRW8
	pSdoP8nSBStB+hrABkz+8Ib9Yzxqr1x0j89/qHoNet9qPbWjnd4GlI2fwcte6KT6/bxL0/
	7gKbf//tehBgA1qPdBCApsdvuWANLeTEO1C1EfEavc02x7DPVFb68LvC60LkBA==
Date: Thu, 23 Jan 2025 11:47:02 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Antoine Tenart <atenart@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>
Subject: Re: [PATCH net-next RFC v2 1/6] net: ethtool: common: Make BaseT a
 4-lanes mode
Message-ID: <20250123114702.2c69f49f@fedora.home>
In-Reply-To: <Z5E_FUxSZJWRWVAq@shell.armlinux.org.uk>
References: <20250122174252.82730-1-maxime.chevallier@bootlin.com>
	<20250122174252.82730-2-maxime.chevallier@bootlin.com>
	<Z5E_FUxSZJWRWVAq@shell.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Russell,

On Wed, 22 Jan 2025 18:55:17 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Wed, Jan 22, 2025 at 06:42:46PM +0100, Maxime Chevallier wrote:
> > When referring to BaseT ethernet, we are most of the time thinking of
> > BaseT4 ethernet on Cat5/6/7 cables. This is therefore BaseT4, although
> > BaseT4 is also possible for 100BaseTX. This is even more true now that
> > we have a special __LINK_MODE_LANES_T1 mode especially for Single Pair
> > ethernet.
> > 
> > Mark BaseT as being a 4-lanes mode.  
> 
> This is a problem:
> 
> 1.4.50 10BASE-T: IEEE 802.3 Physical Layer specification for a 10 Mb/s
> CSMA/CD local area network over two pairs of twisted-pair telephone
> wire. (See IEEE Std 802.3, Clause 14.)
> 
> Then we have the 100BASE-T* family, which can be T1, T2, T4 or TX.
> T1 is over a single balanced twisted pair. T2 is over two pairs of
> Cat 3 or better. T4 is over four pairs of Cat3/4/5.
> 
> The common 100BASE-T* type is TX, which is over two pairs of Cat5.
> This is sadly what the ethtool 100baseT link modes are used to refer
> to.
> 
> We do have a separate link mode for 100baseT1, but not 100baseT4.
> 
> So, these ethtool modes that are of the form baseT so far are
> describing generally two pairs, one pair in each direction. (T1 is
> a single pair that is bidirectional.)
> 
> It's only once we get to 1000BASE-T (1000baseT) that we get to an
> ethtool link mode that has four lanes in a bidirectional fashion.
> 
> So, simply redefining this ends up changing 10baseT and 100baseT from
> a single lane in each direction to four lanes (and is a "lane" here
> defined as the total number of pairs used for communication in both
> directions, or the total number of lanes used in either direction.
> 
> Hence, I'm not sure this makes sense.
> 

I'm fine with your justification, so let's simplify and drop that
patch then. That should also avoid the lanes/pairs confusion as well.

Thanks for the feedback !

Maxime

