Return-Path: <netdev+bounces-210621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C72B140E9
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 19:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 085093A1E5C
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 17:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595BD273D65;
	Mon, 28 Jul 2025 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NYW911v0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BAC42AA5
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 17:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753722423; cv=none; b=AXscEPnQqNkawSUI2fcg1hXjuC9LEgsV05dnhj5bt/40G9BFsTXWPOZjpxYAQCLhYYd/eRQawyp6ZgWXwXCX0G8bynrKUxEzCiPriXuG/qoj8ryCOV7L9rf5SXXK2cY/cqN/FaheY4AQsvVsYn/1gp6EPQlYyc6GnYiSUegqI7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753722423; c=relaxed/simple;
	bh=cL1tYcYE+jlRsNtY763UrOL46FUHm8khRTqW0eA7Bag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsEQ2HsxeyoXMKmlDAuh432gQIMQXx3zNAytf1SU6iDKcGW2ma0qBaQXa57hGz0NriFxZG1bgI9WWjD2pC/Gqz8Db2jfZRQmrMrv5eEBtS2FBb6Y+uAR24JcnVSQ8bMWBVbqD+STZbngpgDqvJuUk+EtWhEwSy2Ev69z/CgVbck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NYW911v0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9NKVSbJ3EylcastEnGb+9vHs9axW6SpWMaxjBfENn0c=; b=NYW911v0akys02RoniGWSqq53V
	d3/uE7aOCooTAypvLjOr2Sw128ojLzoRUEVF6hmqkwlv1dg12Z5YwnrdGaNELrz+ZXBLC9SlD4RiK
	UFyBXEk3HxVIsX3LcY1FKhRhrONwE7YUpD0Bfm1T65OA20yuw+fN5aLjuNtHkT4Z9cKU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ugRJN-0037IP-Ga; Mon, 28 Jul 2025 19:06:53 +0200
Date: Mon, 28 Jul 2025 19:06:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC net-next 4/7] net: stmmac: remove unnecessary
 "stmmac: wakeup enable" print
Message-ID: <0822be86-f344-4b38-9cef-732145b78ce6@lunn.ch>
References: <aIebMKnQgzQxIY3j@shell.armlinux.org.uk>
 <E1ugQ2t-006KDF-H8@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1ugQ2t-006KDF-H8@rmk-PC.armlinux.org.uk>

On Mon, Jul 28, 2025 at 04:45:47PM +0100, Russell King (Oracle) wrote:
> Printing "stmmac: wakeup enable" to the kernel log isn't useful - it
> doesn't identify the adapter, and is effectively nothing more than a
> debugging print. This information can be discovered by looking at
> /sys/device.../power/wakeup as the device_set_wakeup_enable() call
> updates this sysfs file.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

