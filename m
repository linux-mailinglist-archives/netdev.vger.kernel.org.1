Return-Path: <netdev+bounces-250017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F644D22EDC
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 08:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 75C00301986C
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 07:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8447232BF22;
	Thu, 15 Jan 2026 07:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tM32YNnk"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCC831353E;
	Thu, 15 Jan 2026 07:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768463386; cv=none; b=Gtsa5cy78sNjNAfH6m+SH7aggHr/2g7274jht+zhSTQTUSIwacKuLWdwDm2gLeuiXFOM46SOPf9xD8Vdv3o/JBqUAdIqPB7slNGuAlM4+rP1IX7Uw1M8LeljdImwdUmSeEen1ZNqDj7eVh68nm/Hq+WxjzkIJKtuBQCzbpLxCPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768463386; c=relaxed/simple;
	bh=9PlLrC7+QoI4WBEHZ/2y3JpLHZ3p1SzET0kSYD90bLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q2d2brrHMoY1MEttbeE3E75eszg1b9VZSBACCLyldFqaGeXhIGiEWDXfPC3UzVWmtEhiXj0mvLijaAnBGf6cHMbwkvQllI6HZxdPW8006k0ODwv8t93ZRWN5doVp5eowGnphq1VsNJmKsHsVxO94Yxq2NlNOJvsTOz1Ow9d2A+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tM32YNnk; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 276334E420F2;
	Thu, 15 Jan 2026 07:49:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EFE4D606B6;
	Thu, 15 Jan 2026 07:49:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A28AE10B684A8;
	Thu, 15 Jan 2026 08:49:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768463370; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=6wgX3T55tHgIPFpJB2Dl4d7F1Quzo9e+vU4hu4/3zUg=;
	b=tM32YNnkbe5GbLCPsjEOXiuve1Up/fWJxAbPCAKFH1/UI4lXGnPcdhzM4RnFRhbnGHDH8l
	pLtXNS/VEfscxzgq6njV+PIYy680G/G/RhYiuMOwWmd7P7h/g5tYQwblMJ+d6rITqgttlk
	X27RtpKaGIhrtVMD7F7Im0M/9fSM3IFLxcOsNEUS5jbRX8SUxqug/VyrZ9zHoRoyAwoQ+6
	7P+0H1rGhmNlUhz6sgug25pTGCfkGFFWtijBbPwQD7xRiBNIEIDkczYEe2ZR/rutRolJG6
	6uVDIvyV0uChx/QRQAak3aLuKKUMo7X/hZ1z7p/60DHeqVD4O5NbgsvTcukjcQ==
Message-ID: <01ce4d48-6f64-4d90-9f87-ed1382fa57cf@bootlin.com>
Date: Thu, 15 Jan 2026 08:49:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/6] net: phylink: Allow more interfaces in SFP
 interface selection
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jonas Jelonek <jelonek.jonas@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 Simon Horman <horms@kernel.org>, Romain Gantois
 <romain.gantois@bootlin.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, bcm-kernel-feedback-list@broadcom.com
References: <20260114225731.811993-1-maxime.chevallier@bootlin.com>
 <20260114225731.811993-3-maxime.chevallier@bootlin.com>
 <aWgnHo01j38TF3lp@shell.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <aWgnHo01j38TF3lp@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Russell,

On 15/01/2026 00:30, Russell King (Oracle) wrote:
> On Wed, Jan 14, 2026 at 11:57:24PM +0100, Maxime Chevallier wrote:
>> When phylink handles an SFP module that contains a PHY, it selects a
>> phy_interface to use to communicate with it. This selection ensures that
>> the highest speed gets achieved, based on the linkmodes we want to
>> support in the module.
>>
>> This approach doesn't take into account the supported interfaces
>> reported by the module
> 
> This is intentional by design, because the capabilities of the PHY
> override in this case.

OK makes sense. Just to summarize my understanding, let me know if
I'm wrong there :

 - The interfaces list we have in sfp_module_caps is to be used when we 
   don't have a PHY in the module (there may be one, but we don't
   know/care about it).

 - When we do have a PHY, we _should_ select the interface based on what
   the MAC (+ PCS + Serdes etc.) can output on this sfp-bus and what
   the SFP PHY can take as an input. We ignore the sfp_module_caps
   interfaces list.

> Unfortunately, as I've said previously, the> rush to throw in a regurgitated version of my obsoleted
> "host_interfaces" rather messed up my replacement patch set which
> had the PHY driver advertising the interface capabilities of the
> PHY, which were then going to be used to make the PHY interface
> selection when attaching the PHY.
>
> I've still got the code, but I can't now push it into mainline
> because, with the obsolete host_interfaces stuff merged, we will end
> up with two competing solutions.
> 
> In any case, I really would appreciate people looking through
> http://git.armlinux.org.uk/cgit/linux-arm.git/log/?h=net-queue
> 
> before doing development on SFP and phylink to see whether I've
> already something that solves their issue.

So what's the plan there ? This work here is kinda low priority
for me, I wanted to get this out there before continuing with
phy_port followup. Without this patch though, this whole series
is blocked as SGMII will never be selected for 100FX modules.

With your permission, can I pick up your patchs for supported_interfaces
and see what I can do from there ? I also found host_interfaces to be
not enough there.

Knowing that for me, phy_port is the priorty, this is going to be
something I'll do on my free time so don't expect fast progress :(

> Quite simply, I don't have> the time to push every patch out that I have, especially as I'm up to
> my eyeballs with the crappy stmmac driver now, but also because I
> have work items from Oracle that reduce the time I can work on
> mainline. BTW, the "age" stated in cgit is based on the commit time
> (which gets reset when rebased) not the initial merge time. You will
> see that the "supported_interfaces" stuff dates from 2019, not 2025.

Besides that part, will you take a look at the rest of the series ? I'm
not saying that to rush you, but this whole SGMII to 100Fx journey seemed
to me that a lot of hacky stuff, I'd like to get your opinion on the rest
before iterating and facing anther blocking problem down the line on
another part of that series.

I know you have a lot on your plate, but as I said, this series is probably
going to move slowly anyways :)

Maxime

