Return-Path: <netdev+bounces-133224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3C599557E
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 19:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F16651C217C1
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 17:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F7F1F9AAF;
	Tue,  8 Oct 2024 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="O9GbM27K"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327881E1A08;
	Tue,  8 Oct 2024 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728408006; cv=none; b=Rn25ZCbpbyRh54CSPTNraWdmmzdQ7Rr70A/o34Rfyk9dYZJuXOkHy9KKKILVyNC3VHMwApQWMgtZaG+bpvar0GDqB2B0G8uICmfdQQSNDYJMbEaNLt686dodd6Jlt7vBLHhM3nk6MqzLkZwIZHV2Jmv8pljDEKbz4woD8+TxPDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728408006; c=relaxed/simple;
	bh=V4zdqUC6VB1LXKRGgJUj/RJKtO246Elyw+hwclk5nik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jkk/Zkk9R9bT3blpT6NBKQJdORnoyJzZ7MI7wUKTyiNq8wv3Pu8xMLoNeoefOidPrzbcuJ8LlYM9zyGc9oRPbY9MLcEd4pBRv//7D5/M/xMJDhb1KFtNzGO5LrOGyuAc5UG62r3rqa93PIDUW0kkb6l+nr6gV5Ediv+DWVihzBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=O9GbM27K; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0844540006;
	Tue,  8 Oct 2024 17:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728408001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dq0/sc4JpzgfCBB0HQCf5pqmInt6zBed91zJbKhlDwg=;
	b=O9GbM27K1fmfdiJxxGVRU3ymaoYMzq41KRPUN6VlG7+YMkBhXbh/QD575GoEeIP3wfQidf
	WjM7+S/1yY4gT4JqmAeU0fLJ7jy0b915Kxj5aDBNLc2UyK6cDx8XPRCjaSpNcAq1NoD+6Y
	y2L5z4DCs41SyD/dtkOeS/5OR60DfoVTwM9cd46+jNjoUojumFLyrtEPmUDDSx1Tz9XM+7
	KJstTty7+cxPugNxMCBiniC8hx/Anhwtp8ulmrZWlGUbwY0Pj8mjKby8DVJVJjJqYyDbFr
	6ru5MMVljLOafVEjG4V7BkY9jeND66nkaarvdPsQWvHONiyMeQ/Ev1hEbJVhcw==
Date: Tue, 8 Oct 2024 19:19:58 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next v2 7/9] net: phy: introduce ethtool_phy_ops to
 get and set phy configuration
Message-ID: <20241008191958.712a2f51@device-21.home>
In-Reply-To: <ZwVmQXVJMmkIbY1D@shell.armlinux.org.uk>
References: <ZwA7rRCdJjU9BUUq@shell.armlinux.org.uk>
	<20241007123751.3df87430@device-21.home>
	<6bdaf8de-8f7e-42db-8c29-1e8a48c4ddda@lunn.ch>
	<20241007154839.4b9c6a02@device-21.home>
	<b71aa855-9a48-44e9-9287-c9b076887f67@lunn.ch>
	<20241008092557.50db7539@device-21.home>
	<f1af0323-23f5-44fd-a980-686815957b5a@lunn.ch>
	<20241008165742.71858efa@device-21.home>
	<ZwVPb1Prm_zQScH0@shell.armlinux.org.uk>
	<20241008184102.5d1c3a9e@device-21.home>
	<ZwVmQXVJMmkIbY1D@shell.armlinux.org.uk>
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

On Tue, 8 Oct 2024 18:05:05 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> > What I mean is the ability for users to see, from tools like ethtool,
> > that the MCBin doubleshot's eth0 and eth1 interfaces have 2 ports
> > (copper + sfp), and potentially allow picking which one to use in case
> > both ports are connected.
> > 
> > There are mutliple devices out-there with such configurations (some
> > marvell switches for example). Do you not see some value in this ?  
> 
> Many PHYs that have two media facing ports give configuration of the
> priority between the two interfaces, and yes, there would definitely be
> value in exposing that to userspace, thereby allowing userspace to
> configure the policy there.

Great !

> This would probably be more common than the two-PHY issue that we're
> starting with - as I believe the 88e151x PHYs support exactly the same
> thing when used with a RGMII host interface. The serdes port becomes
> available for "fiber" and it is only 1000base-X there.

True, I've seen several setups with this so far indeed, as well as with
PHYs from other vendors.

> I was trying to work out what the motivation was for this platform.

It also turns out that the MCBin is one of the only boards that has a
permanent spot on my desk, as it's a pretty nice platform to experiment
with various PHY aspects.

> 
> Sorry if you mentioned it at NetdevConf and I've forgotten it all,
> it was quite a while ago now!

No worries :)

> 
> Thanks!

Thanks for your feedback on that whole topic,

Maxime 


