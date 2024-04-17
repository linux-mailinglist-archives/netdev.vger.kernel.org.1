Return-Path: <netdev+bounces-88853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 772188A8BD4
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 21:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D30D284701
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 19:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BB41DFCB;
	Wed, 17 Apr 2024 19:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="p7TiSzc2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF922134B
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 19:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713380869; cv=none; b=MDjU6vd8yyl8MDkWwsi9hpS50K/IhZMDhMvAh5nXMhdhkBQoVT3qgWp/Ann2p3NB+Bach1gBtVmE5bdQUEeObC8NHWjry0pP6SCmlz9vASw2WEVGg1zflikY11Km9POp1/4tM6wSJmpy4Q0tNTC+cuGmpj/LvcL3H3N+5RIANdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713380869; c=relaxed/simple;
	bh=+oHFSqNW4dkdjlORFOLf6+/2dtX1DJjWFotO6BN9AVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0vbVWvbSegeHhDKy31w1gOnH7/EbiwfrigqO9WtENEoC/N3x4iqW2i7uPVtmpa9SQD0UdH90hZojmwZNLehC9d41u0+YE+vgozXB+f6Yb1KozedP4k+RcdViFSszgJBuZfD6VJnCXSoOjgph6hv4PUJv5bSxeUt1erDbnzq7hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=p7TiSzc2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=TIp5ZMjw0wdIQg22Blnb09yiTO6wa2zTH+zQj6OwGuU=; b=p7
	TiSzc2+NOIrWTXC2ZyMAfuP/AO87c0sHV1Jll19LR/avub8Hv/dccGrmopQc5XQ4maKFjiB+X6RNr
	x2Rfj3IkWMzY3WyhewBvnPNCUH1n0dZFDXsx+LBSUk6Iv5mehTBaC0n9oekdcZvo8iDNDtztBj7tc
	+ktgGvIpWY8BJsM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rxAdE-00DHAW-NN; Wed, 17 Apr 2024 21:07:44 +0200
Date: Wed, 17 Apr 2024 21:07:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: SIMON BABY <simonkbaby@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: Support needed for integrating Marvel 88e6390 with microchip
 SAMA7 processor (DSA)
Message-ID: <f3739191-1c13-481a-af70-f517f2dd75de@lunn.ch>
References: <CAEFUPH0SoiOef1t8GS+Ch2a2sk+95PfF9Fnz_tPoveRJy2eAuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEFUPH0SoiOef1t8GS+Ch2a2sk+95PfF9Fnz_tPoveRJy2eAuw@mail.gmail.com>

On Wed, Apr 17, 2024 at 10:24:00AM -0700, SIMON BABY wrote:
> Hello Team,
> 
> I am trying to integrate the Marvel 88e6390 switch with the SAMA7 processor for
> the DSA driver to work correctly.  I can get a raw mdio reply from marvel phy
> using the devmem tool in Linux. 
> But I could not get any reply with the macb driver code (drivers/net/ethernet/
> cadence/macb_main.c). 
> 
> 
> Below are some of my logs using devmem:
> 
> root@sama7g5ek-sd:~# devmem2 0xe2800034 w 0x58029800                 (C22 code)
> /dev/mem opened.
> Memory mapped at address 0xb6f86000.
> Read at address  0xE2800034 (0xb6f86034): 0x6396C1E1
> Write at address 0xE2800034 (0xb6f86034): 0x58029800, readback 0x58029800
> root@sama7g5ek-sd:~# devmem2 0xe2800034 w 0x68060000                (C22 data)
> /dev/mem opened.
> Memory mapped at address 0xb6f2a000.
> Read at address  0xE2800034 (0xb6f2a034): 0x58029800
> Write at address 0xE2800034 (0xb6f2a034): 0x68060000, readback 0x68060000
> root@sama7g5ek-sd:~# devmem2 0xe2800034         (read)
> /dev/mem opened.
> Memory mapped at address 0xb6f04000.
> Read at address  0xE2800034 (0xb6f04034): 0x68071E07     (got the correct
> marvel ID)

I don't know what you are seeing here, but the 88E6390 has a product
ID of 0x3900 in register 3.

> Below are the extra debugs executed during my testing(I added these debugs in
> my macb driver code):
> 
> macb: ============================>debug_build: inside macb_mdio_read mii_id=0
> regnum=0x3 bus_id=e2800000.ethernet-ffffffff pdev_id=ffffffff
> macb: ============================>debug_build: inside macb_mdio_read
> macb_write C22 mii_id=0 regnum=0x3
> macb: ============================>debug_build: inside macb_mdio_read status
> after macb_mdio_wait_for_idle = 0
> macb: ============================>debug_build: inside macb_mdio_read status
> after macb_readl = 65535

I would check your reset line. The switch does not respond when held
in reset. Because the MDIO data line has a pull up, if the device does
not respond you read all 1s.

> Attached is the sama7 technical document, marvel document

Marvell documents are under NDA. You should not be publishing them.

	Andrew

