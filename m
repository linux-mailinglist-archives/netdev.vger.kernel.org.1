Return-Path: <netdev+bounces-132780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD14993253
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 18:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6572283F2D
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9531D5CDE;
	Mon,  7 Oct 2024 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWw9gKTg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0198A1D2B2F;
	Mon,  7 Oct 2024 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316849; cv=none; b=nkrOKvYrJvslnP1hN0aCxxtu2yWPWklXxPSU1qhpZmVKdc+9LUYb1N6agfML2oMVghQuUqygBH+JSzgf404vS/6pNkb+LpKhsBJoTznh8o5mPzbgzITg2/vKyI4N9yTM9edI8ti4uvQ7OUfK2SwCcaqO9yMEjB31bdecC79v5Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316849; c=relaxed/simple;
	bh=PHuV8i42D3IcLa5ai+RwLXHJQ2M2sbKr33lxihFuD3U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z4V+XiIW81PMst5l/0b784DKfpI7Lkv7KilRBqC6JnYlegdt23wrZYR9sSuOEP1Ck9xADDpSpish+Tfa+PwbDk+uZvlin1b4ZatbcsBbu8k7pX/gGHPRsyclB95RzJ1b+AsxQ9Kqkds/ahlmd5UpG6+2X1nNEmj1GKSiuPYS5dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWw9gKTg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B33C4CEC6;
	Mon,  7 Oct 2024 16:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728316848;
	bh=PHuV8i42D3IcLa5ai+RwLXHJQ2M2sbKr33lxihFuD3U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tWw9gKTggu0sXA/A49DmgnIJP8c49cyXOarpEH3diPKuTNLhdwWufl1+PuP65Mwqo
	 eVFx+kJ/hDELX6s4qDErCuqj/KZWjNTXUgza7wCMTn/UqrZoS22srj5VFQwBuzurYv
	 ik841qJa8r3aG55RVnPLCIfTyjjL31TNbVuL3TYvWU4nOcjupJM9IcplsLtqKzuhyF
	 zmeL31+nKM2I93q7Ui1R1PiRsHx7RZvloX4+76V5kpcV/LwwIx+5qZLuEHSSA1kzL9
	 cyuoz0uxBIiSCWTblf6nneXVQqdy6/yEqrhG0J0IS+QINmtzA5vcSJuybXNnNz3mw8
	 6xdYwiEPT9fOA==
Date: Mon, 7 Oct 2024 09:00:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <Parthiban.Veerasooran@microchip.com>
Cc: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <ramon.nordin.rodriguez@ferroamp.se>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
 <Thorsten.Kummermehr@microchip.com>
Subject: Re: [PATCH net-next v3 2/7] net: phy: microchip_t1s: update new
 initial settings for LAN865X Rev.B0
Message-ID: <20241007090047.07483ee1@kernel.org>
In-Reply-To: <2fb5dab7-f266-4304-a637-2b9eabb1184f@microchip.com>
References: <20241001123734.1667581-1-parthiban.veerasooran@microchip.com>
	<20241001123734.1667581-3-parthiban.veerasooran@microchip.com>
	<20241004115006.4876eed1@kernel.org>
	<2fb5dab7-f266-4304-a637-2b9eabb1184f@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Oct 2024 07:51:36 +0000 Parthiban.Veerasooran@microchip.com
wrote:
> On 05/10/24 12:20 am, Jakub Kicinski wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Tue, 1 Oct 2024 18:07:29 +0530 Parthiban Veerasooran wrote:  
> >> +     cfg_results[0] = FIELD_PREP(GENMASK(15, 10), (9 + offsets[0]) & 0x3F) |
> >> +                      FIELD_PREP(GENMASK(15, 4), (14 + offsets[0]) & 0x3F) |
> >> +                      0x03;
> >> +     cfg_results[1] = FIELD_PREP(GENMASK(15, 10), (40 + offsets[1]) & 0x3F);  
> > 
> > It's really strange to OR together FIELD_PREP()s with overlapping
> > fields. What's going on here? 15:10 and 15:4 ranges overlap, then
> > there is 0x3 hardcoded, with no fields size definition.  
> This calculation has been implemented based on the logic provided in the 
> configuration application note (AN1760) released with the product. 
> Please refer the link [1] below for more info.
> 
> As mentioned in the AN1760 document, "it provides guidance on how to 
> configure the LAN8650/1 internal PHY for optimal performance in 
> 10BASE-T1S networks." Unfortunately we don't have any other information 
> on those each and every parameters and constants used for the 
> calculation. They are all derived by design team to bring up the device 
> to the nominal state.
> 
> It is also mentioned as, "The following parameters must be calculated 
> from the device configuration parameters mentioned above to use for the
> configuration of the registers."
> 
> uint16 cfgparam1 = (uint16) (((9 + offset1) & 0x3F) << 10) | (uint16) 
> (((14 + offset1) & 0x3F) << 4) | 0x03
> uint16 cfgparam2 = (uint16) (((40 + offset2) & 0x3F) << 10)
> 
> This is the reason why the above logic has been implemented.

In this case the code should simply be:

     cfg_results[0] = FIELD_PREP(GENMASK(15, 10), 9 + offsets[0]) |
                      FIELD_PREP(GENMASK(9, 4), 14 + offsets[0]) |

the fields are clearly 6b each. FILED_PREP() already masks.

> > Could you clarify and preferably name as many of the constants
> > as possible?  
> I would like to do that but as I mentioned above there is no info on 
> those constants in the application note.
> > 
> > Also why are you masking the result of the sum with 0x3f?
> > Can the result not fit? Is that safe or should we error out?  
> Hope the above info clarifies this as well.
> >   
> >> +             ret &= GENMASK(4, 0);  
> > ?               if (ret & BIT(4))
> > 
> > GENMASK() is nice but naming the fields would be even nicer..
> > What's 3:0, what's 4:4 ?  
> As per the information provided in the application note, the offset 
> value expected range is from -5 to 15. Offsets are stored as signed 
> 5-bit values in the addresses 0x04 and 0x08. So 0x1F is used to mask the 
> 5-bit value and if the 4th bit is set then the value from 27 to 31 will 
> be considered as -ve value from -5 to -1.
> 
> I think adding the above comment in the above code snippet will clarify 
> the need. What do you think?

Oh yes, a comment, e.g. /* 5-bit signed value, sign extend */
would help a lot, thanks!

