Return-Path: <netdev+bounces-126521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63ECB971A9E
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 15:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 136EB1F23BC1
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 13:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1F61B4C32;
	Mon,  9 Sep 2024 13:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DClSZjwY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D2F1B7908;
	Mon,  9 Sep 2024 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725887850; cv=none; b=RIT7lRfAYgJcGfard3Q3z8cZXQN1PIu4ADjzoeqs6yAQ1g3AXsMbJSicXDfaEZH1qCPJhJHmBWsAGCh6pnXbrkDiELfjPoBvzGcnKI+nkT9xQ6/jKHlPavYwkU8/U4Lt3Jct+6CA4zPbVS4Qv4b/qgE46AJVqjZvRCAa27rmXmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725887850; c=relaxed/simple;
	bh=Y1lK6iZZ2+zh2XFzt9OQvg2lKuZYoyyKm0O4rOnsOm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6dfyd0LNJfxhWeeFT0moWgWTQns0flTpzMTZKLLdz+CmJwomy0/ocUGia7rVtlhgYgfG8VJB9M3TcqhQzlHpAt1YJj8ZNRPKORQVghjcc47iRzh5zrMHwa2c2JLbz8w4p5o8Gk4oXaV0873DVh/9Ryjbv8vJwdmj70efmgKoU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DClSZjwY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZE5a7cTm7guS50TTXUUHpvc0metKEPI4vMNOHwO2P6A=; b=DClSZjwYYw4Tj2b1LFzxZ4y1ER
	n/tL7b8LaXpy5Hf53ZX/1zNFL70SY2C9W02E2sejxqREKODXMmmDxy61/ltnBLo9iojr5+uTdN9pI
	B2BgeM0GA62SfdNJtQnb9On1JoummenZiTntZOvlZXi7qRGtLD0WUOBdROE2WHgfbRQA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sneGY-0070Ze-W9; Mon, 09 Sep 2024 15:17:14 +0200
Date: Mon, 9 Sep 2024 15:17:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tarun.Alle@microchip.com
Cc: Arun.Ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: microchip_t1: SQI support for LAN887x
Message-ID: <71af5cf3-0481-4d4a-ac4a-426f68ffa7b8@lunn.ch>
References: <20240904102606.136874-1-tarun.alle@microchip.com>
 <dba796b1-bb59-4d90-b592-1d56e3fba758@lunn.ch>
 <DM4PR11MB623922B7FE567372AB617CA88B9E2@DM4PR11MB6239.namprd11.prod.outlook.com>
 <af78280b-68a5-47f4-986e-667cc704f8da@lunn.ch>
 <DM4PR11MB62394BE8D22B85DC9FAFC1808B992@DM4PR11MB6239.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR11MB62394BE8D22B85DC9FAFC1808B992@DM4PR11MB6239.namprd11.prod.outlook.com>

> > With this only taking 76ms, what is the likelihood of link down and link up again
> > within 76ms? For a 1000BaseT PHY, they don't report link down for 1 second, and
> > it takes another 1 second to perform autoneg before the link is up again. Now this
> > is an automotive PHY, so the timing is different. What does the data sheet say
> > about how fast it detects and reports link down and up?
> > 
> 
> For 1000M this sampling procedure will not be run rather we use SQI hardware register to read the value.
> as this procedure is only for 100M and linkup time is ~100ms we can check link status before starting the sampling and after 
> completing the sampling. This would ensure that link is not down before calculating SQI.

Great. That will help users who have a slower MDIO bus.

    Andrew

---
pw-bot: cr

