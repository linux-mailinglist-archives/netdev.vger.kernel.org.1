Return-Path: <netdev+bounces-133204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A909954A7
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB525B295EA
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AA01E0E05;
	Tue,  8 Oct 2024 16:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LLdrRS+l"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CE31E0DF8;
	Tue,  8 Oct 2024 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728405668; cv=none; b=P4JrJ9s82KBE/xi5UPdotLC/rx42ZzoKPS8Wz75xB3t8zirLGhsJQy/WFe3HrPeh05aqGrEybA1M370h/rzX6EzFXhPA3dy3gPsWbd9Z2F0wLQs4V4DtdHi0FUfSflVm9oWDe7tFsDs4n7243T0bf+IDAEVmAVCIbP7CCJy6/i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728405668; c=relaxed/simple;
	bh=Vi5vnnVnDkisnjmqUIDBPq0/ixWHnSSPY6SO3MKtnRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BpXGuBaw3mPu0Rk1+oLSTaW1uUvmRpCtymKw+sqXbln5A/V+JaIYRn0aEpntL2s1J7L1z+oR7LIIN+T3BQ+qQTJF2PQzFdZ59/nhueirLhbajI6fvtxnpfFgAgx/lcL/ryZz25JyyZsmVtGZGkM9WsyNZwDhJqZ+o+h/2r/Lw5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LLdrRS+l; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DEB05FF803;
	Tue,  8 Oct 2024 16:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728405663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pjzLGE2IJYJwFsJ2m+a3HtCOhc52md5DhFFWrz4w1Qk=;
	b=LLdrRS+lQ0s3NBVCsEHdtkl4iErajW+ktXz8f6LpdJxcoxaa1leGcH7akawTldRjRKXeWT
	Xh5vr1TctSzmBKgHEa1frSrhwcQW4qp8xXnB8TJuoODxLLYVDDYhzqwejhYYrTJNnIpTkp
	ys+e6JyahpY1x/036ZXFvhSnCmQHgK+0moxNFVw6lPWIPIwdQJsQj83uzkUBwkK3L68JSr
	7UaQnOT25NnKAbR4kIxnh46dFv0FzYI6YDGBmJvUN7gQEqYqdOYlhydsZr/pLf3U47QCMV
	gNQTcV07TkS/CJtkMJk84nFLZhZlaL/jOU+ha9RLmtQvT/2TkuqrGYSJD062Sg==
Date: Tue, 8 Oct 2024 18:41:02 +0200
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
Message-ID: <20241008184102.5d1c3a9e@device-21.home>
In-Reply-To: <ZwVPb1Prm_zQScH0@shell.armlinux.org.uk>
References: <20241004161601.2932901-8-maxime.chevallier@bootlin.com>
	<4d4c0c85-ec27-4707-9613-2146aa68bf8c@lunn.ch>
	<ZwA7rRCdJjU9BUUq@shell.armlinux.org.uk>
	<20241007123751.3df87430@device-21.home>
	<6bdaf8de-8f7e-42db-8c29-1e8a48c4ddda@lunn.ch>
	<20241007154839.4b9c6a02@device-21.home>
	<b71aa855-9a48-44e9-9287-c9b076887f67@lunn.ch>
	<20241008092557.50db7539@device-21.home>
	<f1af0323-23f5-44fd-a980-686815957b5a@lunn.ch>
	<20241008165742.71858efa@device-21.home>
	<ZwVPb1Prm_zQScH0@shell.armlinux.org.uk>
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

On Tue, 8 Oct 2024 16:27:43 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Tue, Oct 08, 2024 at 04:57:42PM +0200, Maxime Chevallier wrote:
> > Oh but I plan to add support for the marvell switch, mcbin, and turris
> > first,  
> 
> What do you think needs adding for the mcbin?
> 
> For the single-shot version, the serdes lines are hard-wired to the
> SFP cages, so it's a MAC with a SFP cage directly connected.
> 
> For the double-shot, the switching happens dynamically within the
> 88x3310 PHY, so there's no need to fiddle with any isolate modes.

Nothing related to isolate mode regarding the mcbin :) They aren't
even implemented on the 3310 PHYs anyway :)

> 
> The only thing that is missing is switching the 88x3310's fibre
> interface from the default 10gbase-r to 1000base-X and/or SGMII, and
> allowing PHYs to be stacked on top. The former I have untested
> patches for but the latter is something that's waiting for
> networking/phylib to gain support for stacked PHY.

That's one part of it indeed

> Switching the interface mode is very disruptive as it needs the PHY
> to be software-reset, and if the RJ45 has link but one is simply
> plugging in a SFP, hitting the PHY with a software reset will
> disrupt that link.
> 
> Given that the mcbin has one SFP cage that is capable of 2500base-X,
> 1000base-X and SGMII, and two SFP cages that can do 10gbase-r, with
> a PHY that can do 10/100/1G/2.5G/5G/10G over the RJ45, I'm not sure
> adding more complexity really gains us very much other than...
> additional complexity.

What I mean is the ability for users to see, from tools like ethtool,
that the MCBin doubleshot's eth0 and eth1 interfaces have 2 ports
(copper + sfp), and potentially allow picking which one to use in case
both ports are connected.

There are mutliple devices out-there with such configurations (some
marvell switches for example). Do you not see some value in this ?

This isn't related at all to isolate, but rather the bigger picture of
the type of topology I'm trying to improve support for.

Setups with 2 PHYs connected to the same MAC are similar to the eth0/1
interfaces in the sense that they offer 2 front-facing ports for one
single MAC. IMO it's easier to first deal with the MCBin setup first.

Again that's a whole other topic, but my idea would be to be able, from
ethtool, to see that mcbin eth0 has one port capable of
10/100/1000/2500/5000/10000BaseT, and another capable of
1000BaseX/2500BaseX/5GBaseR/10GBaseR or whatever the plugged SFP module
offers.

I do know that the MCBin has a large variety of interfaces easily
accessible, but it also looks like a good board to introduce such
multi-port support. Many people have it, it works well with an upstream
kernel, making testing and review effort easier IMO.

I know that this whole thing of dealing with 2 PHYs attached to the
same MAC has lots of ramifications (the 1 PHY 2 ports setup I just
mentionned, the phy_link_topology that has been added, the isolate
mode, muxing support, etc.), that's why I tried to cover all the angles
at netdevconf + LPC. I have code for most of that pretty-much ready to
send.

Thanks,

Maxime

