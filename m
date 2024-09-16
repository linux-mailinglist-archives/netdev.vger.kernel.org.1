Return-Path: <netdev+bounces-128572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA30197A5F8
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 18:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1877A1C25420
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 16:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5386915B0EC;
	Mon, 16 Sep 2024 16:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lFb/OdII"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7125515AAD9;
	Mon, 16 Sep 2024 16:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726504182; cv=none; b=UYTcfMFxYVYwucyyZWZA2BU1mYagbrCAQv7e9RDEG6+i3whCbbfIMBDiiixXrvhFxDLTLVIK9Hu5aKpNk8hfZqzzVmfEoNa4eh2Yf4rlOgHEnkenqtpT11FfHB7zFk2+ByqWO8kJmbqD0AuxO2190HsfuMyZRNCJNGheENNvhR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726504182; c=relaxed/simple;
	bh=EXFcYU2rvBvGtvIDnjUL73iKbExlPtZBqcdmQ1tyH9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C/y4PS9fK50+ZWTtKexff2ZeJXLNhJfN1TRNUDlCcKzHqsosoMyzREl3UXaknk+/qDMXuvMjuWzfMQee3QKZHA7DRjeCl41GRIbiJRg2XnqCVBd+RlKZIszTQtzJBN5nvgPv5O75KO+C15KdzTDjm3chzHmZMmxbjDw1rKOMoAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lFb/OdII; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5E65A60006;
	Mon, 16 Sep 2024 16:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726504172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XD9je6kghiJn7GolaqKoMViTS66UJJpVrUl9PKf1GLw=;
	b=lFb/OdII7ME1TPdWjQFCbxh+GESLEF/jlM7MhCS88jAkjxe39zeu+XijEHnIkNaBTn6d1D
	OBHAk+FIJMr7Mqft7LU6hWVhxwGjO131YF7+4UJPcVLktdkC7sxauRrNs1sReqOc19fh3J
	DI1A76ogBBUgS18WbpkMMwkNhSGGKMNqIAX2OdANNRmqI07+9O2AHawU3sQj1o/kXt08rb
	ELv1szv8ZW21bkJwhHyXgNvDUMBZyIFj+pU/TdCKkVmW9mJfvobKKlOO1mCCxSLrXLghA8
	aEJ25zgOQsg/e+ap3tCzHCPIoWu6Svt+GEear4pey3i5qqRjeKy8wa6aqX94lA==
Date: Mon, 16 Sep 2024 18:29:29 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Daniel Golle <daniel@makrotopia.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>, Russell
 King <linux@armlinux.org.uk>, Kory Maincent <kory.maincent@bootlin.com>,
 Edward Cree <ecree.xilinx@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>, John Crispin <john@phrozen.org>
Subject: Re: ethtool settings and SFP modules with PHYs
Message-ID: <20240916182929.25cb6582@fedora.home>
In-Reply-To: <ccf7ea15-203e-4860-a85d-31641a26c872@lunn.ch>
References: <ZuhQjx2137ZC_DCz@makrotopia.org>
	<20240916180224.39a6543c@fedora.home>
	<ccf7ea15-203e-4860-a85d-31641a26c872@lunn.ch>
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

On Mon, 16 Sep 2024 18:12:32 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > A notification would indeed be better, and is something I can prototype
> > quickly. I was hesitating to add that, but as you show interest in
> > this, I'm OK to move forward on that :)  
> 
> This might need further brainstorming. What are we actually interested
> in?
> 
> The EEPROM has been read, we know what sort of SFP it is?
> 
> It happens to be a copper SFP, we know what MDIO over I2C protocol to
> use, it responds, and the PHY device has been created? Does the SFP
> layer actually know this? Are we actually adding a notification for
> any PHY, not just an SFP PHY?

What I was refering to is to notify on a phy_link_topo_add_phy() call,
which deals with both "regular" PHYs and SFP PHYs.

I'm still not fully expert on the netlink aspect, but could
ETHTOOL_A_PHY_NTF be emitted upon PHY addition to the topology,
containing exactly the same info as a regular ETHTOOL_A_PHY_GET message
?

At that time, we know what PHY it is, and that it's attached to the
netdev, the eeprom has been read and phydev created.

That covers the PHY aspect, but not the whole SFP aspect. We won't get
that notif for Fibre modules, as there's no PHY.

Triggering notifications upon SFP insertion will require extra
plumbing. As of today, the sfp-bus itself doesn't know which netdev
it's attached to (there's not sfp_bus.netdev pointer), so a notif won't
help much as we don't know which interface the event concerns.

That attachment can happen at link-up time or probe-time, so for example
there might be no easy way to trigger that notification when a module
is inserted while the link is down, that behaviour would depend on the
driver(s) (wether or not it uses phylink, whether or not the SFP is
driver by a PHY or directly by the MAC).

I have prototype code here[1] (beware, one giant hard-to-read patch
without commit log for now, will be split eventually) that deals with
parts of that issue, the end-goal being to report the state of all
front-facing ports (including SFP and their module) to users.

Maxime

[1] : https://github.com/minimaxwell/linux/tree/mc/main

