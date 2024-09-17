Return-Path: <netdev+bounces-128676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4D797ADE5
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 11:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4930F283F2A
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 09:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E6615D5C5;
	Tue, 17 Sep 2024 09:29:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D8F15A853
	for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 09:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726565394; cv=none; b=ENsnvduCn2s1ciHqEa/bWxG1I0pGF5vDV05i8RTCRomKa34/2ec6rBqBngLdME0voJdpyZ2V0xbG4XpdhlMCTRM3/eZvkswCxf5nSPAW4dg1QJPIM8B1erudV1+lqjCCs0fTutf6blVB579s0G9iMiO2Z8oEG+EN1hG+jdQ1nHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726565394; c=relaxed/simple;
	bh=6z3ylPcsDoxYnF3RvsW/5CW6s7kXk7w3W/c+LA7gHfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWXEn8s/33g7lBDLfHf6MEWLz1VEkxcU/VB+Va5ZEvXUEiKqSbS4nduJcYPdbsEOI2H4rn6XwnScn/XZx+ZxkHNHA6gwCCLWkU6en6aIaLaVI59yU+fD5qr6Pv2Bblvc5Bk+mLlnz60fS3LOPTFaksBRGBKrzABuS7ZGV4mlQO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sqUW5-00028y-I5; Tue, 17 Sep 2024 11:29:01 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sqUW3-008XC0-Rd; Tue, 17 Sep 2024 11:28:59 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sqUW3-00DCdr-2P;
	Tue, 17 Sep 2024 11:28:59 +0200
Date: Tue, 17 Sep 2024 11:28:59 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: ethernet-phy: Add
 timing-role role property for ethernet PHYs
Message-ID: <ZulL2w0s6m7BnqV6@pengutronix.de>
References: <20240913084022.3343903-1-o.rempel@pengutronix.de>
 <20240913084022.3343903-2-o.rempel@pengutronix.de>
 <ZulHp9IBvptenuRa@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZulHp9IBvptenuRa@shell.armlinux.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Tue, Sep 17, 2024 at 10:11:03AM +0100, Russell King (Oracle) wrote:
> On Fri, Sep 13, 2024 at 10:40:21AM +0200, Oleksij Rempel wrote:
> > This patch introduces a new `timing-role` property in the device tree
> > bindings for configuring the master/slave role of PHYs. This is
> > essential for scenarios where hardware strap pins are unavailable or
> > incorrectly configured.
> > 
> > The `timing-role` property supports the following values:
> > - `force-master`: Forces the PHY to operate as a master (clock source).
> > - `force-slave`: Forces the PHY to operate as a slave (clock receiver).
> > - `prefer-master`: Prefers the PHY to be master but allows negotiation.
> > - `prefer-slave`: Prefers the PHY to be slave but allows negotiation.
> > 
> > The terms "master" and "slave" are retained in this context to align
> > with the IEEE 802.3 standards, where they are used to describe the roles
> > of PHY devices in managing clock signals for data transmission. In
> > particular, the terms are used in specifications for 1000Base-T and
> > MultiGBASE-T PHYs, among others. Although there is an effort to adopt
> > more inclusive terminology, replacing these terms could create
> > discrepancies between the Linux kernel and the established standards,
> > documentation, and existing hardware interfaces.
> 
> Does this provide the boot-time default that userspace is subsequently
> allowed to change through ethtool, or does it provide a fixed
> configuration?

It provides the boot-time default.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

