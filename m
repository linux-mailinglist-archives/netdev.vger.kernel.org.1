Return-Path: <netdev+bounces-148583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D86E09E2536
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 16:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C53BC16EEC3
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACAB1F76D0;
	Tue,  3 Dec 2024 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fHCeqkM6"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1141E0496;
	Tue,  3 Dec 2024 15:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733241116; cv=none; b=jPtaFq+5fFuYxqW8wqbM6wfEOCOpsNE9aH63nJo25+12sYQS130yvQk2uKNCWO0CmAeG+9G39cmTrU48VC1mxEPImZNTOyT7/tkdE6pRtaDk2YckXgqIe2iATGSdPzg4k3H1GonUXH7elXelUqEKPF865PqvgJilAzZCW6k9R7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733241116; c=relaxed/simple;
	bh=bpMNhT7hs+A5dnCGGIqDp8qwNNx3fUETcoweFQOjllk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eqGlhlEN4RqLfuFq17v1l1vha0aNaBUKz6ykXg1CJYbzSK9bGOBRKalyIktZ1UlAsgte6k8K+cWV2DrzLCsvH/+sJVSQysMnLD30OIJXcQCE6njV5tHE5FbNyUJZ7juEWYMhwIm7sudVEI70VcodMhNdQ87930IiArCKvXc6NhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fHCeqkM6; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E8697FF811;
	Tue,  3 Dec 2024 15:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733241111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6mUUXlg2Sdr2QZ9xxnJnQJbYN76Rdm3JD+IpxMezPKc=;
	b=fHCeqkM6Iljfd74vtUc6Go6drgzqlVnBl28AhspXXsK9XVyHDw/IVJcBm9JqWph4Y99KxK
	4Oro9o3pP/wPORR2+ulupss5Q9szZdXpVRv5q4lBhgqtHRUHexaRBubmlFgh8Yx88ACHrN
	p67sdXIJNWOhgNSxbFIkX5JYKy6CVzPRqbh4XsfskquLEX4QaJSI3a50jia5diUnqVDPCH
	YnQ8eWcVajvIpP7Ocm5NhTPzKrUMJlS8eRbBFUUg23B7A6ehwCIsDcQsk39VtL6VyNjWi2
	iuT79F2GWfUNiGlkYhbyZHqSrZYL+gWTXPDyFVf2XDdLpvkQC/1ZdZIqCH5hPg==
Date: Tue, 3 Dec 2024 16:51:47 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Dennis Ostermann
 <dennis.ostermann@renesas.com>, "nikita.yoush"
 <nikita.yoush@cogentembedded.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Dege
 <michael.dege@renesas.com>, Christian Mardmoeller
 <christian.mardmoeller@renesas.com>
Subject: Re: [PATCH] net: phy: phy_ethtool_ksettings_set: Allow any
 supported speed
Message-ID: <20241203165147.4706cc3b@fedora.home>
In-Reply-To: <Z08h95dUlS7zacTY@shell.armlinux.org.uk>
References: <73ca1492-d97b-4120-b662-cc80fc787ffd@cogentembedded.com>
	<Z02He-kU6jlH-TJb@shell.armlinux.org.uk>
	<eddde51a-2e0b-48c2-9681-48a95f329f5c@cogentembedded.com>
	<Z02KoULvRqMQbxR3@shell.armlinux.org.uk>
	<c1296735-81be-4f7d-a601-bc1a3718a6a2@cogentembedded.com>
	<Z02oTJgl1Ldw8J6X@shell.armlinux.org.uk>
	<5cef26d0-b24f-48c6-a5e0-f7c9bd0cefec@cogentembedded.com>
	<Z03aPw_QgVYn8WyR@shell.armlinux.org.uk>
	<TYCPR01MB1047854DA050E52CADB04393A8E362@TYCPR01MB10478.jpnprd01.prod.outlook.com>
	<1ff52755-ef24-4e4b-a671-803db37b58fc@lunn.ch>
	<Z08h95dUlS7zacTY@shell.armlinux.org.uk>
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

Hi Andrew,

On Tue, 3 Dec 2024 15:21:27 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Tue, Dec 03, 2024 at 03:45:09PM +0100, Andrew Lunn wrote:
> > On Tue, Dec 03, 2024 at 02:05:07PM +0000, Dennis Ostermann wrote:  
> > > Hi,
> > > 
> > > according to IEE 802.3-2022, ch. 125.2.4.3, Auto-Negotiation is optional for 2.5GBASE-T1
> > >   
> > > > 125.2.4.3 Auto-Negotiation, type single differential-pair media
> > > > Auto-Negotiation (Clause 98) may be used by 2.5GBASE-T1 and 5GBASE-T1 devices to detect the
> > > > abilities (modes of operation) supported by the device at the other end of a link segment, determine common
> > > > abilities, and configure for joint operation. Auto-Negotiation is performed upon link startup through the use
> > > > of half-duplex differential Manchester encoding.
> > > > The use of Clause 98 Auto-Negotiation is optional for 2.5GBASE-T1 and 5GBASE-T1 PHYs  
> > > 
> > > So, purposed change could make sense for T1 PHYs.  
> > 
> > The proposed change it too liberal. We need the PHY to say it supports
> > 2.5GBASE-T1, not 2.5GBASE-T. We can then allow 2.5GBASE-T1 to not use
> > autoneg, but 2.5GBASE-T has to use autoneg.  
> 
> I'm wondering whether we should add:
> 
> 	__ETHTOOL_DECLARE_LINK_MODE_MASK(requires_an);
> 
> to struct phy_device, and have phylib populate that by default with all
> base-T link modes > 1G (which would be the default case as it is now.)
> Then, PHY drivers can change this bitmap as they need for their device.
> After the PHY features have been discovered, this should then get
> AND-ed with the supported bitmap.

If the standards says that BaseT4 >1G needs aneg, and that we can't
have it for baseT1, couldn't we just have some lookup table for each
mode indicating if they need or support aneg ? I'm thinking about
something similar as the big table in net/ethtool/common.c where we
have the linkmode - speed - duplex - lanes mapping :

https://elixir.bootlin.com/linux/v6.12.1/source/net/ethtool/common.c#L270

maybe looking it up for each config operation would be too expensive ?
or it maybe isn't flexible enough in case we have to deal with
phy-pecific quirks...

Maxime



