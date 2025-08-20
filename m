Return-Path: <netdev+bounces-215141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D76B2D281
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 05:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E637587704
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 03:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F6125EFBF;
	Wed, 20 Aug 2025 03:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Eg9SQF3x"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9E8198E91;
	Wed, 20 Aug 2025 03:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755659919; cv=none; b=rnPqVNwcsEkPQjjufmvggNck2oo9nwPrmOLGC8kv/PLCnxxYzgQvbbI4rYHo9oA/oD/dsOTLqf8gnxTNo5/RwDcAJME4AQdKetGBiMwjsNtom5kPPA0NsTg2NNLx3UAoi8J/KmW0C15Ugp5ZX8VWvOylP5x0JOZb2XrxBTc9nLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755659919; c=relaxed/simple;
	bh=+VcPdCTU4eeZrc2goHCn2UX/zfj6Iw1UFBiXu4yFPOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4yrb+zP1Bikx3zvFdlxd8/SLakn6IeUuye2U1pX/CnC/oiLo/zqQ7O/lzAdGztHXGVGMtKoHGTnYyWnkJI0gSR0WFygB6DXOtHJQ9ARJu84vDbeT0vqNASfXD50J99Ltb7svQwQqpOHt+Srw2NQ7q7XsvTDv8myBVciRmN7NcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Eg9SQF3x; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AnygHHst9MHIpMhavfh8cbVJsMgHaAuL432SxywULkI=; b=Eg9SQF3xFKQPPj79dAk0hMP9iR
	wFLQDB1oexMu9c3AKYvU076UbqZMuQ8YSYrklrmsmG5+TNJ5NZFI7xjc8n7zF2hu2oJ2u8qPnHhXj
	yBRbpmQtMEZMDA0IxBIOymCOOsz2eS2dqoLqUZklh/PhlE92tGXNbHYA9N02jPJH0fV8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uoZLG-005GvO-EX; Wed, 20 Aug 2025 05:18:26 +0200
Date: Wed, 20 Aug 2025 05:18:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com, o.rempel@pengutronix.de,
	alok.a.tiwari@oracle.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 4/4] net: phy: micrel: Add support for lan8842
Message-ID: <710efc3a-5618-4467-86c3-c602bd6ee6e8@lunn.ch>
References: <20250818075121.1298170-1-horatiu.vultur@microchip.com>
 <20250818075121.1298170-5-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818075121.1298170-5-horatiu.vultur@microchip.com>

On Mon, Aug 18, 2025 at 09:51:21AM +0200, Horatiu Vultur wrote:
> The LAN8842 is a low-power, single port triple-speed (10BASE-T/ 100BASE-TX/
> 1000BASE-T) ethernet physical layer transceiver (PHY) that supports
> transmission and reception of data on standard CAT-5, as well as CAT-5e and
> CAT-6, Unshielded Twisted Pair (UTP) cables.
> 
> The LAN8842 supports industry-standard SGMII (Serial Gigabit Media
> Independent Interface) providing chip-to-chip connection to a Gigabit
> Ethernet MAC using a single serialized link (differential pair) in each
> direction.
> 
> There are 2 variants of the lan8842. The one that supports timestamping
> (lan8842) and one that doesn't have timestamping (lan8832).
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

