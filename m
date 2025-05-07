Return-Path: <netdev+bounces-188699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0E9AAE447
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 17:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 822A59A487E
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 15:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB49C28A1E6;
	Wed,  7 May 2025 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="k8+ryHa6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1615F2147F6
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 15:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746630904; cv=none; b=JyVAbnDIqROGswVJ+11fn1xRPWwmOA0VlQLSuafHwOctoxvbv7pAGuKM8kHK5WRq2YaHC5GlAtyoMXMFvJ1Ti8IMhRTcnjMnc17vwl7J4t48+HymPfShczY3I7N0FdCgLSsp4XHlZJ+qaLzLmMmUP37+f0WVutYwGYOdSEq8pCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746630904; c=relaxed/simple;
	bh=rlHLuiGC5c6waE85c0fkpAP3hvPOCAASp7f1dAklxaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qot6BWOmnBNk87YDK/592ekryhiA2xPJyekJWPG2HdpUd6CtBY+NOB4jbxUYidquE9fCyk3HLqK+GEshO7mUdzm/LphrbmGsYGq7x1Xf2XKFE1pgQrEKChBbInUeJP70whS7TjSfmusD7NVSLp7ChLY401vG9J1QvJybqmmW4gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=k8+ryHa6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CzPv5Sf/evDloMS75rhmvjJBp5os7gF4yk0W1t7WgEQ=; b=k8+ryHa68U6gjMGwXxqoSMJfiS
	NIPpDZod2fmjWxHWJbmtz/Tapf6ywL785Y+fjwWXdp5yIpuwvlvIME4VlCImI+QD89hD/2CWkO3by
	YIy3iovz0hkx+LDwGoCxoa5PkoDWsoI+fkjDzFR4pL1pUPxTJkCvNaLQIFHT0XKi+sEE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uCgU8-00BtlW-UW; Wed, 07 May 2025 17:15:00 +0200
Date: Wed, 7 May 2025 17:15:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Steve Broshar <steve@palmerwirelessmedtech.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: request for help using mv88e6xxx switch driver
Message-ID: <0629bce6-f5eb-4c07-bff0-76003b383568@lunn.ch>
References: <20250507065116.353114-1-quic_wasimn@quicinc.com>
 <d87d203c-cd81-43c6-8731-00ff564bbf2f@lunn.ch>
 <IA1PR15MB6008DCCD2E42E0B17ACBC974B588A@IA1PR15MB6008.namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR15MB6008DCCD2E42E0B17ACBC974B588A@IA1PR15MB6008.namprd15.prod.outlook.com>

On Wed, May 07, 2025 at 02:57:32PM +0000, Steve Broshar wrote:
> Hi,
> 
> We are struggling to get ethernet working on our newly designed, custom device with a imx8mn processor and a mv88e6230 switch ... using the mv88e6xxx driver. We have worked on it for weeks, but networking is not functional. I don't know where to find community support or maybe this is the community. I'm used to more modern things like websites; not email lists.
> 
> So that you understand the context at least a little: we have MDIO comms working, but the network interface won't come up. I get encouraging messages like:
> 
> 	[    6.794063] mv88e6085 30be0000.ethernet-1:00: Link is Up - 1Gbps/Full - flow control off
> 	[    6.841921] mv88e6085 30be0000.ethernet-1:00 lan3 (uninitialized): PHY [mv88e6xxx-0:03] driver [Generic PHY] (irq=POLL)
> 
> But near the end of boot I get messages:
> 
> 	[   11.889607] net eth0: phy NOT found
> 	[   11.889617] fec 30be0000.ethernet eth0: A Unable to connect to phy
> 	[   11.892275] mv88e6085 30be0000.ethernet-1:00 lan4: failed to open master eth0

Do you have a direct MAC to MAC connection between the FEC and the
Switch? If so, you need fixed-link. Look at imx7d-zii-rpu2.dts for an
example.

	Andrew

