Return-Path: <netdev+bounces-207545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B03B07B65
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 18:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B655B4A2503
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 16:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAC12F5C3A;
	Wed, 16 Jul 2025 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GXBKh6Bk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052F32F5C34;
	Wed, 16 Jul 2025 16:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752684167; cv=none; b=UpvCtpGqy/MSvglmIzCRoHy+WFfpfGtZpkphQUa7cOkJ4k16JTK4j7UgYd4UYmJznh7ZA4biBv6lUEIyTVa7h1y085tLjhL9WeemJ88iehENSlIc40cXYuE85AR2JirGdZ9fOrgWxXLiq/Mfe8IByy3R7TIb8WHYF3sNJNj4DDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752684167; c=relaxed/simple;
	bh=GUjE5/Z671zGtY7yXDdoFGX6E3uyL/DTB94FNzppBcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHKlRkJ15/mfJ+grmwdjsEOLmvQ8H35C0YtBvrff+5g9m6nTlKwPsvENOBLma0jrPKvJ3bJqZ4dkUuNnOMT0EV/hiToTtssXA5Xdps4rN730xPbBIAHTRkECx8LIHEYS9qcMkrEKBGKnHvOGp2zKiVneMyciHgmFnplnZabvsU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GXBKh6Bk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=D1SxE35RjUfzzoDArd7E3eV4u1nAaqmQ4uLUf75JLio=; b=GXBKh6BkAnnCMPiKyBt90fAuUv
	LbaVnxobMEWC/iYKM44AyRJl0UzrQ4VyUW94TPlPj3Ey2nanzP5Iph7+n4NBY20zrl3EbOZmZ7NmS
	NuVglBmOTbqA538FR5/N+EE0cpiyDIoLI+JDjWe4kVSTxYc1mRI/22Xx/UIeUI3sR1rY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uc5DI-001hxs-FO; Wed, 16 Jul 2025 18:42:36 +0200
Date: Wed, 16 Jul 2025 18:42:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	Frank.Sae@motor-comm.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: hibmcge: Add support for PHY LEDs on
 YT8521
Message-ID: <023a85e4-87e2-4bd3-9727-69a2bfdc4145@lunn.ch>
References: <20250716100041.2833168-1-shaojijie@huawei.com>
 <20250716100041.2833168-3-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716100041.2833168-3-shaojijie@huawei.com>

On Wed, Jul 16, 2025 at 06:00:41PM +0800, Jijie Shao wrote:
> hibmcge is a PCIE EP device, and its controller is
> not on the board. And board uses ACPI not DTS
> to create the device tree.
> 
> So, this makes it impossible to add a "reg" property(used in of_phy_led())
> for hibmcge. Therefore, the PHY_LED framework cannot be used directly.
> 
> This patch creates a separate LED device for hibmcge
> and directly calls the phy->drv->led_hw**() function to
> operate the related LEDs.

Extending what Russell said, please take a look at:

Documentation/firmware-guide/acpi/dsd/phy.rst

and extend it to cover PHY LEDs.

	Andrew

