Return-Path: <netdev+bounces-84897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B5F898945
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 15:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EDC22814DF
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 13:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDA6128834;
	Thu,  4 Apr 2024 13:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="siCxvmBC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0328F18AF6
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 13:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712238832; cv=none; b=RGzgiaY8lGA/DMjfFN6oBdkkzPRa6a4gYX8KjpBfsCYFt+KMbVFblYDni0JDy3cpTexTpaltv+uWjam4Exaz8bc8IbMyelOp94GZ+r3JeEbRR9htjPfEd+E5nJ3oHw5rI8oGiN/9/VEY8qUfwQnKrlIKye/xb1gHYsQTuunYnTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712238832; c=relaxed/simple;
	bh=bkvngvljQS4SkHxgL/nGmJLYrySEzRRUTOV4mqJ1vT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSKAjFzzfyUkv27j8y1vXYqIW7dPhy6W+/KzfoQGildl+g1Sq4PhPyhTgb4YbVJJ4XX5PUobzWsZmE/Tf2TQBYAma+byOTfzfZzAxRJoPJsW9educnNqPBMXhN1p8lkrbiHaoYWWQG73FAAUt9FBTAz9IlQh3PyWWlV3oTOVaZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=siCxvmBC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hmWmHREKqogw3d0DbxNAb2MrhApA1IcAFR4uCegy1A4=; b=siCxvmBCjgdLCV9W1+R7c5OGmN
	STRqQ6L9IMxedQHVl0XjQ6n1cQtNCajb7yVw/KntjwRPmXCfy8RCd8zjpJOtKgX4SpH/WH3Fk5llS
	HcqBfjYpVrAQoqSqzjMeT1sC+R70ZHhYqXFLyWqFD09FWMWyCeZr/zxeUdKGx3nUNqDI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rsNXE-00CBkg-LT; Thu, 04 Apr 2024 15:53:44 +0200
Date: Thu, 4 Apr 2024 15:53:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, edumazet@google.com,
	marcin.szycik@linux.intel.com, anthony.l.nguyen@intel.com,
	kuba@kernel.org, intel-wired-lan@lists.osuosl.org,
	pabeni@redhat.com, przemyslaw.kitszel@intel.com
Subject: Re: [Intel-wired-lan] [PATCH net-next 0/3] ethtool: Max power support
Message-ID: <e4224da7-0a09-41b7-b652-bf651cfea0d0@lunn.ch>
References: <20240329092321.16843-1-wojciech.drewek@intel.com>
 <38d874e3-f25b-4af2-8c1c-946ab74c1925@lunn.ch>
 <a3fd2b83-93af-4a59-a651-1ffe0dbddbe4@intel.com>
 <dc601a7c-7bb7-4857-8991-43357b15ed5a@lunn.ch>
 <ad026426-f6a4-4581-b090-31ab65fb4782@intel.com>
 <61a89488-e79a-4175-8868-3de36af7f62d@lunn.ch>
 <206686dc-c39b-4b52-a35c-914b93fe3f36@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <206686dc-c39b-4b52-a35c-914b93fe3f36@intel.com>

On Thu, Apr 04, 2024 at 02:45:43PM +0200, Wojciech Drewek wrote:
> 
> 
> On 03.04.2024 15:49, Andrew Lunn wrote:
> >>> $ ethtool --set-module enp1s0f0np0 power-max-set 4000
> >>>
> >>> actually talk to the SFP module and tell it the maximum power it can
> >>> consume. So in this case, it is not the cage, but the module?
> >>
> >> It does not work that way in ice example.
> >>>
> >>> Or is it talking to some entity which is managing the overall power
> >>> consumption of a number of cages, and asking it to allocate a maximum
> >>> of 4W to this cage. It might return an error message saying there is
> >>> no power budget left?
> >>
> >> That's right, we talk to firmware to set those restrictions.
> >> In the ice implementation, the driver is responsible for checking if the
> >> overall board budget is not exceeded.
> > 
> > So i can get the board to agree that the cage can supply 3W to the
> > module, but how do i then tell the module this?
> 
> I'd assume it is not possible, if the module consumes more power
> than maximum than the link will not come up and error will be printed.

Take a look at the Linux SFP driver. In sfp_probe() is reads the DT
property maximum-power-milliwatt:

https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/sfp.c#L3030

When the module is inserted and probed, the modules power capabilities
are read from the EEPROM:

https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/sfp.c#L2320

https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/sfp.c#L1929

The code looks to see what conformance level the module has, so to
know if it even supports different power levels, and the registers
needed have been implemented.

Later, the SFP state machine will transition the module to higher
power:
https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/sfp.c#L1995

by writing a register in the SFP.

> > I would also suggest you don't focus too much on ICE. I find it better
> > to think about an abstract system. A board with a power supply to a
> > number of SFP cages, and some cages have modules in them. What does
> > the kAPI look like, the use cases for this abstract system.
> 
> My design for this API is to have an option to get and set maximum
> power that the module in the cage can consume. It's not about modifying
> module's power consumption, it's about setting restrictions for it.
> 
> The use case is to let the user change maximum power in the given cage
> (so he can plug in the module with higher power consumption). Before that
> he will lower maximum power in different cage. Thanks to that the overall
> budget for the board won't be exceeded. Does it make sense for the abstract
> system you described?

So there are a few different phases here. The standard says the module
start up in low power mode.

Something needs to enumerate what the module actually supports in
terms of different power modes.

Something then needs to determine if the board/cage can support higher
power operation, that there is sufficient power budged. Budget then
needs to be allocated to the cage.

Lastly, the module needs to be told it can go to a higher power level.

I would say the current Linux SFP code is overly simple, by design. It
supports the concept of cage supplied by a dedicated regulator. There
is no sharing of power across a number of cages. Hence it just ups the
power if the board indicates the power is available and the module
support a higher power level.

However, you have a more complex setup, shared power supplies,
etc. The policy of what modules gets how much power should come from
user space. So we need user space APIs for this, and a clear
understanding of how they work. Please could you describe how i would
use ethtool to go through these phases. And how do i down grade a
modules power consumption to make more power available to another
module.

	Andrew


