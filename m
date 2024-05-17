Return-Path: <netdev+bounces-96965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D848C8770
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 15:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D4E8281FED
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 13:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CC754BEF;
	Fri, 17 May 2024 13:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ehP7IVIY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DEB548EF;
	Fri, 17 May 2024 13:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715953788; cv=none; b=d+0So2haPNQFKFGHU+HQthkg0Tmfsd/8JetX4U2tFr7WPZtJZMltePUFri6Qcm+R5rp1eHNF/hB5t6WTGyh5QcEfoR1q8COvoc1UEOOmG1Ndrxspv83o60tYkTibu9Nsx2aEmfOfRODHYaVX1HTMIylDFr7vkDARm05pCxR52/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715953788; c=relaxed/simple;
	bh=zfMkOZOZZjgIRP4nwmmYsQYWA3FLGwCB0g70lmT6LcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1y1ZfoUwgJVJBYANtakXIhb3kslKkqD9vIPRMQRAGWoeOqhObYq88TPKOurCBtjDggjHm6nDVH+Y4KdH4xyX8/cA2HcLDE2dKTlrpxT62QVeqDsG+gVv2Y2HIZZrZhcZRReiDqvo1PoIgk33wSU+xq6jdPMo5ziN3w7IoDgOpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ehP7IVIY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/ICNmatV/n196PbAHkCh3rR4p2kraFQbw8tCOH/qr2M=; b=ehP7IVIYPNQvBLiyDwvrI7zodb
	s1dqK41wqH0mETbvXWzraag2uqumIGbWTif/zaERrUVs8YIN7T9V7AVr0/YaYirK8cCFgqBazEBme
	ju8TTUc0vzI2vNMEzu3zP3j9dXkTDXqRZKIVI2kyUMBljoDUip5POvdKGYHAX+5O1ECo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s7xxr-00FZu4-4B; Fri, 17 May 2024 15:49:39 +0200
Date: Fri, 17 May 2024 15:49:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, jiri@resnulli.us, horms@kernel.org,
	rkannoth@marvell.com, pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net-next v19 01/13] rtase: Add pci table supported in
 this module
Message-ID: <d840e007-c819-42df-bc71-536328d4f5d7@lunn.ch>
References: <20240517075302.7653-1-justinlai0215@realtek.com>
 <20240517075302.7653-2-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517075302.7653-2-justinlai0215@realtek.com>

> + *  Below is a simplified block diagram of the chip and its relevant interfaces.
> + *
> + *               *************************
> + *               *                       *
> + *               *  CPU network device   *
> + *               *                       *
> + *               *   +-------------+     *
> + *               *   |  PCIE Host  |     *
> + *               ***********++************
> + *                          ||
> + *                         PCIE
> + *                          ||
> + *      ********************++**********************
> + *      *            | PCIE Endpoint |             *
> + *      *            +---------------+             *
> + *      *                | GMAC |                  *
> + *      *                +--++--+  Realtek         *
> + *      *                   ||     RTL90xx Series  *
> + *      *                   ||                     *
> + *      *     +-------------++----------------+    *
> + *      *     |           | MAC |             |    *
> + *      *     |           +-----+             |    *
> + *      *     |                               |    *
> + *      *     |     Ethernet Switch Core      |    *
> + *      *     |                               |    *
> + *      *     |   +-----+           +-----+   |    *
> + *      *     |   | MAC |...........| MAC |   |    *
> + *      *     +---+-----+-----------+-----+---+    *
> + *      *         | PHY |...........| PHY |        *
> + *      *         +--++-+           +--++-+        *
> + *      *************||****************||***********
> + *
> + *  The block of the Realtek RTL90xx series is our entire chip architecture,
> + *  the GMAC is connected to the switch core, and there is no PHY in between.

Given this architecture, this driver cannot be used unless there is a
switch driver as well. This driver is nearly ready to be merged. So
what are your plans for the switch driver? Do you have a first version
you can post? That will reassure us you do plan to release a switch
driver, and not use a SDK in userspace.

	Andrew

