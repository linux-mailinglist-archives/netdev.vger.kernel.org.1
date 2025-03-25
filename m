Return-Path: <netdev+bounces-177602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14006A70B98
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 21:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 407071891AF6
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 20:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458CA1FFC4F;
	Tue, 25 Mar 2025 20:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="q0GxFkxW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369191A0BF8;
	Tue, 25 Mar 2025 20:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742934818; cv=none; b=UhUAZR5VCe/9EGK8Xv5kIcW5x4Den2SCE5t9JRal2pX0MP6lC7FImBjwmKHKMsqCqhGDmMHkpjb/6Z5j6nN5NqurJdNWgYbVksrsuWUFCwN1HgJV8IqF/ONoKkhz24jK3lQBdOWHizeo3J3DA9L9zq0E2A7BUB8MlbAFxdhp1w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742934818; c=relaxed/simple;
	bh=Sz2WL1G1NaIwqe39FIYWpMn+gO0sXXhznamMETN+r1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwdwN1dsazCsJPEt7VHBsSTlsqL3J/xCCFzWM31hXPBya7396qgrNT196EXSa/BYAyLVPe0Z8G74ZdS2x6x/RXaZ611DlCdvYOusSmyNBDeZA9fTGobdEBPGPy/vci7ohuWaVmb54ua79Sg1QeH16pN9FAFNPA8CqcaKu7xnGJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=q0GxFkxW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+MRzvg3hix3D3aX4/I3iSCDpR1ngitDWf6pexRiR87M=; b=q0GxFkxWgDhNs8d7jt//EUWTsr
	YIMmQ905walh4pHUfthsk8pqglDW6LELTw1NsEpmDrmVzn8Svpfyztof8gWJZ1gLxzB5UN1oPHK4U
	fgb1KdftVZ9GMCUBKNy2CcbY8FYoysqrD1wfkkbk+2M9D/kclnpfvD9OuVqYbkpUCYk0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1txAxi-0076De-Oz; Tue, 25 Mar 2025 21:33:26 +0100
Date: Tue, 25 Mar 2025 21:33:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 1/2] net: phy: Add support for new Aeonsemi PHYs
Message-ID: <4f865b3a-0568-4fef-a56d-6360dfbd18f6@lunn.ch>
References: <20250323225439.32400-1-ansuelsmth@gmail.com>
 <f0c685b0-b543-4038-a9bd-9db7fc00c808@lunn.ch>
 <67e1692c.050a0220.2b4ad0.c073@mx.google.com>
 <a9abc0c6-91c2-4366-88dd-83e993791508@lunn.ch>
 <67e29bce.050a0220.15db86.84a4@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e29bce.050a0220.15db86.84a4@mx.google.com>

On Tue, Mar 25, 2025 at 01:04:30PM +0100, Christian Marangi wrote:
> On Mon, Mar 24, 2025 at 04:16:09PM +0100, Andrew Lunn wrote:
> > On Mon, Mar 24, 2025 at 03:16:08PM +0100, Christian Marangi wrote:
> > > On Mon, Mar 24, 2025 at 03:03:51PM +0100, Andrew Lunn wrote:
> > > > > Supported PHYs AS21011JB1, AS21011PB1, AS21010JB1, AS21010PB1,
> > > > > AS21511JB1, AS21511PB1, AS21510JB1, AS21510PB1, AS21210JB1,
> > > > > AS21210PB1 that all register with the PHY ID 0x7500 0x7500
> > > > > before the firmware is loaded.

Do you have details of how these different PHY differ? Do they have
different features?

> Ok update on this... The PHY report 7500 7500 but on enabling PTP clock,
> a more specific ""family"" ID is filled in MMD that is 0x7500 0x9410.

Do they all support PTP?

> They all use the same firmware so matching for the family ID might not
> be a bad idea... The alternative is either load the firmware in
> match_phy_device or introduce some additional OPs to handle this
> correctly...
> 
> Considering how the thing are evolving with PHY I really feel it's time
> we start introducing specific OP for firmware loading and we might call
> this OP before PHY ID matching is done (or maybe do it again).

You cannot download firmware before doing some sort of match, because
you have no idea what PHY you actually have until you do a match, and
if the PHY needs firmware.

match_phy_device() gives you a bit more flexibility. It will be called
for every PHY on the board, independent of the ID registers. So you
can read the ID registers, see if it is at least a vendor you know how
to download firmware to, do the download, and then look at the ID
registers again to see if it is the version of the PHY you want to
drive. If not, return -ENODEV, and the core will try the next driver
entry.

	Andrew


