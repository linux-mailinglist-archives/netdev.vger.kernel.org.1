Return-Path: <netdev+bounces-184553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9C8A962FD
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 10:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 644C444150B
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 08:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5963725A2CB;
	Tue, 22 Apr 2025 08:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="yPUsWyuC"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A053C25A2C3;
	Tue, 22 Apr 2025 08:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745311332; cv=none; b=IyJGTXfhPp4b3KdDb38wiW1uAHG8CteY09LrLNZdPwBngPWPL2a5SRDwmiHrCO7oNVkF1f+0/TvD+jJPOhp5xiFYz2m/JsN7E5hyQwCBD37zjy9DtK8NC+/X1RSPjmbENC01tBQIcbPW6JnqpdoowZ7oCV6ZVXz8JlESbgpZDpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745311332; c=relaxed/simple;
	bh=DMUEgWT1IONXSjjzWV9s6i78gMC3EiOES5rQkWX860w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfRrgh3HsOby5Cg6bqiNJHF6JnQ8MdcpOfWhqmWXeBOKc6jTCccoEBDugl/93VyUGa1gPj321FMpZ1Ij8Pa8ZtgmQbebfKJAHYz1mz0lDBt0UzWVl3nqs1z6ouoPjTmDntHwmgp7MXZWNqLiZ6MYhSkfpG9gU932LCv06tVcsE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=yPUsWyuC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=S54P5rf09JI3kvunV4HEvrJrmrs+ZWs16gH9mbduXto=; b=yPUsWyuCuwXN3/Bg2nhooh3nNK
	Svw04aOt11SnDpbJXWhhJW/TiAybsS/AlgHxMw+TE0x+HMZMr+ZWktRKxjylbtGDmPrxXt6v0lZWo
	NNVnPkT8gm8MgrNEMjtiCMUS8+j3KzG2KaJuz9fs+IfqrPVP2A5+mFTw0i8Vz67D3fEetPgcAetU2
	LAszEtD+NQW9nJfm4+pNzL6h+T/5D4hJL+GFjqNy87bp2rIUtbYjhZ8VEsinU8d2JFlFd8mnLqyyK
	qX0nyycdC4zfwLtYU/k+15PyPQfe30gxP8yyjtciZ3/44LNGRqNr4MpZZTZCPot7BttLS8VRxhAno
	dpNBcDfA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48000)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u79CX-00043D-1U;
	Tue, 22 Apr 2025 09:41:57 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u79CV-0007LW-0t;
	Tue, 22 Apr 2025 09:41:55 +0100
Date: Tue, 22 Apr 2025 09:41:55 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>, Tero Kristo <kristo@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: ethernet-controller:
 update descriptions of RGMII modes
Message-ID: <aAdWU4xPc2UOU5wu@shell.armlinux.org.uk>
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
 <218a27ae2b2ef2db53fdb3573b58229659db65f9.1744710099.git.matthias.schiffer@ew.tq-group.com>
 <6be3bdbe-e87e-4e83-9847-54e52984c645@ti.com>
 <cd483b43465d6e50b75f0b11d0fae57251cdc3db.camel@ew.tq-group.com>
 <5d74d4b2-f442-4cb8-910e-cb1cc7eb2b3d@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d74d4b2-f442-4cb8-910e-cb1cc7eb2b3d@ti.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 15, 2025 at 05:25:23PM +0530, Siddharth Vadapalli wrote:
> For a fixed PHY,

No such thing in reality. The kernel has an obsolete idea of a fixed PHY
which is a software-emulated PHY to represent a fixed link, but that is
basically dead with phylink (there is now no PHY for fixed links under
phylink).

As I stated, "phy-mode" describes how the MAC needs to configure its
PHY facing interface, whether there is or is not a PHY present. One can
argue that it's misnamed, but it's buried in deep DT history going back
decades, and there's a rule that we don't break backwards compatibility.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

