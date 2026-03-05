Return-Path: <netdev+bounces-264482-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJSkIfawqWlXCgEAu9opvQ
	(envelope-from <netdev+bounces-264482-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 17:36:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2926215762
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 17:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89295301BA7B
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 16:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C623D5247;
	Thu,  5 Mar 2026 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HYsHjkGd"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607533C6A59;
	Thu,  5 Mar 2026 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772728562; cv=none; b=RV4neW8lksaLm+B/T4oXxCQqPihXIVJiyjjFPheKmpPx65wbqCpPJ/uE79HJ4mi7dlMWukT3S5kh5Dd3W3MyMSAwET5kBPidGnyHgwlRThdX7dWE2b/N+mxRihbZn5vZELZzLxlDzMqxJ8R6xoMUcWqecmSiAj48Xg149jfVhWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772728562; c=relaxed/simple;
	bh=9Pilo2yniHGaelgdzcmw0lQrsgOHGBzjKjSdHmYMUcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f9etFnNT2q/NfwT00Ife9vDcFLDYZQ/pDy2ggIkEy1g8nX8sio3kaGHRV5Tt7O5zNskLavq8dcfB6VkGRil+HZ9EbQGTm02RT1585010tSjCqUNcuRgehYj3u91AmkHNbI5eCQL6EGEbLmLWI0AQXeIYX1f4922n9B7ZZrJ6csY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HYsHjkGd; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B83A21A2CE8;
	Thu,  5 Mar 2026 16:35:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8C3A95FF89;
	Thu,  5 Mar 2026 16:35:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4614E103696FE;
	Thu,  5 Mar 2026 17:35:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772728555; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=15Zb7kxTviDLCqrwzjiGkkoGHFZBevdkVCcEYyh/Ufs=;
	b=HYsHjkGdcUotWQtQCj+NSKBKNXJO1Jl+PkEnuYnC2CrhCzfixRKZkIwOC4NlxfO3VSz8oS
	F9F+zug5k03aFSDBCcpESHwwzEs6vW02uBZSCLpQgQsqopYBjwE8KhFj5GAHh0y2yQAJlO
	4/sai+w69VoUVvayR01t8dEDmtZeQDG8KaGYpuP1fZeHUcznX6P640htQXC/TVQRRftJPd
	J5SR3fgPjgivUiwTmxif9U8qzgWGvqWExdjlznwh1Ldr3CWenr/Wh+oFgVaKsvXSF+W5ch
	ef1thgPXcBRrIq1GGUBTRNQmHwAh4PBB/BNxF8sCNejT3pw4jQPyQbZNXHVTJg==
Message-ID: <c4a5edee-4920-4ce3-aba1-913a0facc9f8@bootlin.com>
Date: Thu, 5 Mar 2026 17:35:50 +0100
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
 <18657687-343f-4197-bdab-0eb0bed96964@bootlin.com>
 <aambsExznAN9YIPJ@shell.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <aambsExznAN9YIPJ@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: F2926215762
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264482-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,kernel.org,google.com,redhat.com,gmail.com,vger.kernel.org,bootlin.com,broadcom.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Action: no action

Hi Russell,

On 05/03/2026 16:05, Russell King (Oracle) wrote:
> On Fri, Feb 13, 2026 at 09:41:43AM +0100, Maxime Chevallier wrote:
>> Hi Russell,
>>
>> On 15/01/2026 00:30, Russell King (Oracle) wrote:
>>> On Wed, Jan 14, 2026 at 11:57:24PM +0100, Maxime Chevallier wrote:
>>>> When phylink handles an SFP module that contains a PHY, it selects a
>>>> phy_interface to use to communicate with it. This selection ensures that
>>>> the highest speed gets achieved, based on the linkmodes we want to
>>>> support in the module.
>>>>
>>>> This approach doesn't take into account the supported interfaces
>>>> reported by the module
>>>
>>> This is intentional by design, because the capabilities of the PHY
>>> override in this case. Unfortunately, as I've said previously, the
>>> rush to throw in a regurgitated version of my obsoleted
>>> "host_interfaces" rather messed up my replacement patch set which
>>> had the PHY driver advertising the interface capabilities of the
>>> PHY, which were then going to be used to make the PHY interface
>>> selection when attaching the PHY.
>>>
>>> I've still got the code, but I can't now push it into mainline
>>> because, with the obsolete host_interfaces stuff merged, we will end
>>> up with two competing solutions.
>>>
>>> In any case, I really would appreciate people looking through
>>> http://git.armlinux.org.uk/cgit/linux-arm.git/log/?h=net-queue
>>>
>>> before doing development on SFP and phylink to see whether I've
>>> already something that solves their issue. Quite simply, I don't have
>>> the time to push every patch out that I have, especially as I'm up to
>>> my eyeballs with the crappy stmmac driver now, but also because I
>>> have work items from Oracle that reduce the time I can work on
>>> mainline.
>>
>> net-next being closed, I was going through my backlog and I was thinking
>> about giving this series another go after net-next re-opens, I'd like to
>> sync with you about the way forward.
>>
>> In your tree there's :
>>
>> net: phylink: use phy interface mode bitmaps for SFP PHYs	
>> net: phy: add supported_interfaces to Aquantia AQR113C
>> net: phy: add supported_interfaces to marvell10g PHYs
>> net: phy: add supported_interfaces to marvell PHYs
>> net: phy: add supported_interfaces to bcm84881
>> net: phy: add supported_interfaces to phylib
>>
>> These would be pre-requisites for the 100FX-SGMII SFP support, as the
>> interface resolution currently doesn't elect SGMII for 100FX modules.
>>
>> That would require some changes to the current host_interfaces API as
>> well, potentially replacing it altogether.
>>
>> Is this something you can do, or can I get your permission to submit
>> these (ofc maybe with more stuff to deal with host_interfaces)
> 
> One of the issues that will need to be solved is how to tell
> 100FX-SGMII (e.g. https://www.fs.com/uk/products/37770.html) which need
> SGMII apart from 100FX modules that don't (e.g.
> https://www.fs.com/uk/products/37324.html)
> 
> host_interfaces don't satisfy that, because this has nothing to do with
> what the host can do. Either the module has a PHY and uses SGMII on
> the host side, or it doesn't have a PHY in which case 100BASE-X needs
> to be used. If we have a PHY, then we will work out using what we
> already have.
> 
> Given that 100FX-SGMII, the PHY _should_ be coming up in SGMII mode,
> so that's what we need to use to talk to them.

_should_ indeed. All modules I got required some level of configuration
of the internal PHY for it to work, and without Florian's help [1] on
how to setup the broadcom PHY in SGMII to 100FX mode, all the modules I
tried were just fancy paperweights :(

[1] : https://lore.kernel.org/netdev/24146e10-5e9c-42f5-9bbe-fe69ddb01d95@broadcom.com/

> If we change the PHY's
> mode to something else, we get into the horrid problems that is rate
> matching, which gives us the problem that we don't have very good
> support for that (e.g. PHYs that require the MAC to pace the transmit
> rate.)
> 
> I suspect there is no way to tell these SFPs apart using the EEPROM,
> which means we're left with the "does this module that looks like a
> optical module have a PHY?" problem that we already use for copper
> SFPs. If there's no detectable PHY, then we'd likely have to assume
> that the SFP requires 100BASE-X.
> 

I agree with that completely. From the few such modules I have, we don't
have much to work with in the eeprom to come-up with a proper generic
support for these.

I see no way around that other than probing for a PHY for every 100FX
module, and see what we get. Alternatively, we could rely on fixups
and have that internal hardcoded database of supported modules ?

Maxime

