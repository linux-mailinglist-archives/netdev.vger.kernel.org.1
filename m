Return-Path: <netdev+bounces-111254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C509306D9
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 20:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBC9E284D07
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 18:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669FE13C9B9;
	Sat, 13 Jul 2024 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KHsJ4ETt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933DA125B9;
	Sat, 13 Jul 2024 18:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720893793; cv=none; b=siprLHzL4zzzG0YjfRfRGzGwNWtDR9AjgLhwL9LXsxJcDCchEHVSQMGq7kdeSjjvUmCJNOj196S1+AmTYFbFPdKF/alKr6bqzV1raVnei70ESIDKK39naD/rIsD1bpFnD+oGN3rdiOP0gkMl6AeFMJs7HwkFVlHAIRrwmrV7KKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720893793; c=relaxed/simple;
	bh=CPWL/exSQPhG0+hvBiBh939ZE+v6ik7VqFUQbsFVsnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1kUhHDzF84QX1tBPTFo9tEqe60TpcMZT8kXXI2goxPknAEXhnz+Qx3/XHrfc5HLlJ8b6Ea1pA7aQwhHqNTRGHikiMRXolcm64UhX6EXhMX0vEproykQHYmFH9Jj3FFf6jR6JrHtPrnLsAaR6Qvt2EMsqKrSHcycV335PYYwvjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KHsJ4ETt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mp5nhIYxJqMoieUdL5bnM1wOV5UiiBM9+wgeApKoYyQ=; b=KHsJ4ETtjvnhO6z0lsJZ9R+Pqa
	SLB4tz4M76w6b6c5GhkJystODX+AMZuYBRGKv/uuah/r4vHNhNTsGfyyPvvxZDGq93R/jdQ+N/gnl
	5h+qY2Z2W4nIbGhNqdiBDyiOiXtlT+oPJ8DZiiVXnz5vmv1LqPVQP5tP2PCwyIRKRIUk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sSh57-002T8U-2o; Sat, 13 Jul 2024 20:02:49 +0200
Date: Sat, 13 Jul 2024 20:02:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jacob.e.keller@intel.com, horms@kernel.org,
	u.kleine-koenig@pengutronix.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: ethernet: lantiq_etop: remove redundant
 device name setup
Message-ID: <92570003-ddcd-482b-80e1-1da1fa0cc91f@lunn.ch>
References: <20240713170920.863171-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240713170920.863171-1-olek2@wp.pl>

On Sat, Jul 13, 2024 at 07:09:20PM +0200, Aleksander Jan Bajkowski wrote:
> The same name is set when allocating the netdevice structure in the
> alloc_etherdev_mq()->alloc_etherrdev_mqs() function. Therefore, there
> is no need to manually set it.

If this one is not needed:

grep -r "eth%d" *
3com/3c515.c:		sprintf(dev->name, "eth%d", unit);
8390/smc-ultra.c:	sprintf(dev->name, "eth%d", unit);
8390/wd.c:	sprintf(dev->name, "eth%d", unit);
8390/ne.c:	sprintf(dev->name, "eth%d", unit);
amd/lance.c:	sprintf(dev->name, "eth%d", unit);
atheros/atlx/atl2.c:	strcpy(netdev->name, "eth%d"); /* ?? */
cirrus/cs89x0.c:	sprintf(dev->name, "eth%d", unit);
dec/tulip/tulip_core.c:		strcpy(dev->name, "eth%d");			/* un-hack */
intel/ixgbe/ixgbe_main.c:	strcpy(netdev->name, "eth%d");
intel/ixgbevf/ixgbevf_main.c:	strcpy(netdev->name, "eth%d");
intel/e100.c:	strcpy(netdev->name, "eth%d");
intel/igbvf/netdev.c:	strcpy(netdev->name, "eth%d");
intel/e1000e/netdev.c:	strscpy(netdev->name, "eth%d", sizeof(netdev->name));
intel/igb/igb_main.c:	strcpy(netdev->name, "eth%d");
intel/igc/igc_main.c:	strscpy(netdev->name, "eth%d", sizeof(netdev->name));
intel/e1000/e1000_main.c:	strcpy(netdev->name, "eth%d");
lantiq_etop.c:	strcpy(dev->name, "eth%d");
micrel/ks8842.c:	strcpy(netdev->name, "eth%d");
smsc/smc9194.c:		sprintf(dev->name, "eth%d", unit);

maybe you can remove all these as well?

      Andrew

