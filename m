Return-Path: <netdev+bounces-113633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C76CB93F5B7
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 14:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C431C21C4C
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 12:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC5F1487D6;
	Mon, 29 Jul 2024 12:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ETVA7qv5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7790A1487CB;
	Mon, 29 Jul 2024 12:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722256951; cv=none; b=QCKWtGR3XMOEXFCD1eeG4/usqkeL50Wdv7l4gSyyHDpPpIBfTZajSm2bVEcIwS55V3WQA/m3Xm2MQ5xkBeF0leeqnrUts3wDxKke6KzrYNnXBv1xGVayLDF46QJpXurqdZMoGEhqtbClm5kdsgeRMDbXRw9moGVp1w4Ocy1TC+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722256951; c=relaxed/simple;
	bh=7nRY9eKe0ZjoahogvmUfEzeK+43yJk5DjYrF0b2sgP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toF9S7Odj+64uqoV+Kyu3WKXe/JSSvreQ6tL/VwwqGf2WaKAIdcm0bZPPnzctAyg0Zet2sB8mTyGSidmc7x4mWvkeksj4q1b6d+5jU3OpWRXNLVVAf7hL7X7vTYQ8KoIXA7hnQ7OlNdCyCTiwt2sRQlz++RsSLLEzNXzqVTTHrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ETVA7qv5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ooEURTufHLa7PnQkDLSEEZTYaSbf266pfo/8TJSynOY=; b=ETVA7qv5gyZAZGh4ez0ca8UMaH
	Z1MwVXEUpGMY7pod6RG/1lEt3AmimP13y3Y9WKqv3Osbxq3E+Wkvu+bk3Wy3/dVL4YO3FVRgTOicI
	sP6rxcnp/tlIVeID9vRCrdNBwP3CX/B5e+VRaco/JbCnWVkNMJqvdtAtCIuUlPQP7VkM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sYPhc-003SvQ-J9; Mon, 29 Jul 2024 14:42:12 +0200
Date: Mon, 29 Jul 2024 14:42:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: UNGLinuxDriver@microchip.com, davem@davemloft.net, edumazet@google.com,
	gregkh@linuxfoundation.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	lucas.demarchi@intel.com, mcgrof@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, woojung.huh@microchip.com
Subject: Re: [PATCH] net: usb: lan78xx: add weak dependency with micrel phy
 module
Message-ID: <c169a84d-d0e5-4fdf-a112-01ac819447e4@lunn.ch>
References: <fc40244c-b26f-421e-8387-98c7f9f0c8ca@lunn.ch>
 <20240729083739.11360-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729083739.11360-1-jtornosm@redhat.com>

On Mon, Jul 29, 2024 at 10:37:38AM +0200, Jose Ignacio Tornos Martinez wrote:
> Hello Andrew,
> 
> I like the idea from Jakub, reading the associated phy from the hardware
> in some way, although reading your last comments I don't know if it could
> be possible for all the cases.
> Let me ask you about this to understand better, if present,
> always reading /sys/bus/mdio_bus/devices/*/phy_id,
> could it be enough to get the possible related phy? 
> And after this get the related phy module?

There should be sufficient information in /sys. eg.

$ cat /sys/class/net/enp1s0/phydev/phy_id
0x001cc914

So enp1s0 probed a PHY using the ID 0x001cc914. Turn that into binary
and you get 0000 0000 0001 1100 1100 1001 0001 0100. Look that up in alias.

alias mdio:0000000000011100110010?????????? realtek

So you need to realtek PHY driver for my enp1s0.

	Andrew

