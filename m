Return-Path: <netdev+bounces-97984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 908878CE752
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 16:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFEA6B210CC
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 14:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFE312BF34;
	Fri, 24 May 2024 14:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3KCexhg7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BD12BAF3;
	Fri, 24 May 2024 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716562275; cv=none; b=o5esppe4lnM92lp57Yev3xmRk8YobTOMesYN1rYIoukmOyLIUWx3CAYZ0Sx9330hMD+C/r93kw6zFgJ6D/68c+Ja+begerOmY5kBsgQB6rjR00+jBvQGwi/UAXYqheMiIoXYU+gj0chzXz8ucKDbT6bP7m64MWdjp/uKXFWmbLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716562275; c=relaxed/simple;
	bh=SPu4GI7WlkmJaXShM+lFsDtYUKL+8xfKGCieEDmX8bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+oP0sBy7uqz2BVYOkMOhsXapp6dq/7Rl+7ih/8lxV9K5819s+HYGgW1OM+5wzMXtFi4LYr7jfM8Rg/09I5jLjRglrDBYEEirLz+q0uu2R9lVif8diW6fxrECkJbCThI2XyDOpS5Sz1HHuol3NHUQCSuTcIWLy3DVuN+UL87/gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3KCexhg7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GV/QsjEvDtrhh/ZaXZqdvmVcpw7ReZRze9VGzicNnAo=; b=3KCexhg73Y03UA5lUAYDBBkSIo
	TvXOKhmEyaz7DCfsb4AyRCFL5tGRInrmjgxHjCvr6TgT9JnO06oCPnAi67Z1dbri4Dl7kQnnY0wPz
	xMpBpvyU/DG6ql12hp9znHX1F6QfUBjXz2RvfaQstu7sWYlgWDmbzrH7RiiVsVveCg84=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sAWFp-00FxZ4-Kb; Fri, 24 May 2024 16:50:45 +0200
Date: Fri, 24 May 2024 16:50:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	parthiban.veerasooran@microchip.com
Subject: Re: [PATCH net 0/1] phy: microchip_t1s: lan865x rev.b1 support
Message-ID: <99f56020-9293-4e6b-8c2a-986af8c3dd79@lunn.ch>
References: <20240524140706.359537-1-ramon.nordin.rodriguez@ferroamp.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524140706.359537-1-ramon.nordin.rodriguez@ferroamp.se>

> Far as I can tell the phy-driver cannot access some of the regs necessary
> for probing the hardware and performing the init/fixup without going
> over the spi interface.
> The MMDCTRL register (used with indirect access) can address
> 
> * PMA - mms 3
> * PCS - mms 2
> * Vendor specific / PLCA - mms 4
> 
> This driver needs to access mms (memory map seleector)
> * mac registers - mms 1,
> * vendor specific / PLCA - mms 4
> * vencor specific - mms 10

In general, a MAC should not be touching the PHY, and the PHY should
not be touching the MAC. This rule is because you should not assume
you have a specific MAC+PHY pair. However, this is one blob of
silicon, so we can relax that a bit if needed.

So it sounds like Microchip have mixed up the register address spaces
:-(

I guess this also means there is no discrete version of this PHY,
because where would these registers be?

Do any of the registers in the wrong address space need to be poked at
runtime? By that i mean config_aneg(), read_status(). Or are they only
needed around the time the PHY is probed?

How critical is the ordering? Could we have the Microchip MAC driver
probe. It instantiates the TC6 framework which registers the MDIO bus
and probes the PHY. Can the MAC driver then complete the PHY setup
using the registers in the wrong address space? Does it need to access
any PHY registers in the correct address space? The MAC driver should
be able to do this before phy_start()

Does MMS 0 register 1 "PHY Identification Register" give enough
information to know it is a B1 PHY? The standard suggests it is a
straight copy of PHY registers 2 and 3. So the MAC driver does not
need to touch PHY registers, we are not totally violating the
layering...

	Andrew


