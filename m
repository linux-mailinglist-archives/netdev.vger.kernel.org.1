Return-Path: <netdev+bounces-264701-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHiROuh/qmnKSgEAu9opvQ
	(envelope-from <netdev+bounces-264701-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 08:19:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5024721C58B
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 08:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DE8E30214CE
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 07:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C011372B5A;
	Fri,  6 Mar 2026 07:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="K8Fzp1CY"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E39D366DD2;
	Fri,  6 Mar 2026 07:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772781542; cv=none; b=PjDOnL6FqbuNW55inW+Xx6HcABfxhnBw6caRafhgC9CEEq1XiJZfRQc87NeZ24meZ/1BESMcO/S7jNXdAJJXdawXZUc5Etb7Yo5TaxHrmEA7tWOVeEmSeE+e/QJ5VHVcyQ3bU4VFw3aiZusw4B5s4nnDzvOV+UwLn4X7V+tdRfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772781542; c=relaxed/simple;
	bh=QS1LqBGW/nLFJlqP/PjmzTVEZxZ53PrUgnIXXFrKWUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eml6LZuH0QN3tJBzrg06WKBU7b5EdxBWp/v8vOT8TGvP3jUddRznZJXURvpUD6s82eWegqYAvkWT/xbmfcANYrlVkcQCpQQJ0oynLNoMFA7uhf+X9fLKZIVjkcKTj0rhH7n/58D1xNNJ+2KseTi1wuT6e3QfUIChGvkV4hCz0Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=K8Fzp1CY; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E1997C40429;
	Fri,  6 Mar 2026 07:19:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CFACA5FF92;
	Fri,  6 Mar 2026 07:18:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2747D10369825;
	Fri,  6 Mar 2026 08:18:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772781534; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=zUg27mbAuIdJpz/KJJFi1eaL81fQeVR6Pdo92J8b+nA=;
	b=K8Fzp1CYK/W7CZPUdUxFCQ7IuZs5d94U1MywavhBQrjihlzAX4cUcTNdEmjXc6FHc7Jb9k
	d0TFlRd9VLSWCRZ5JybwE7eM7sdxdpIDXn0jxxt4Z5JjBpha6OIdUtfaiE8nuarejIIwEe
	5ZFCCxHlzm9Fspq6ta/xL5K/dkIPnW5kjFFlS6ngczJ7eQGeDH/mzDkzy4PR74xK2mAzR/
	Z65FfjrU74DYyHSJqwe7fmtkCEezLGOyZ1YY+ShEVjQJC95EzYXPZ6f3xLDlTe4L10hz27
	+oSDY5F9Vq8nX8VX4y3vqvCTuoZQh5eOPJJWjqZ4WLQ6eMpAwCT1fg7Ztl/3Sw==
Message-ID: <83f277bf-a1f6-4cca-8adf-87f77f77bbc6@bootlin.com>
Date: Fri, 6 Mar 2026 08:18:48 +0100
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
 <c4a5edee-4920-4ce3-aba1-913a0facc9f8@bootlin.com>
 <aamy7-Y4xRv_yTKW@shell.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <aamy7-Y4xRv_yTKW@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 5024721C58B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264701-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,kernel.org,google.com,redhat.com,gmail.com,vger.kernel.org,bootlin.com,broadcom.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,fs.com:url,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Action: no action


>>>> In your tree there's :
>>>>
>>>> net: phylink: use phy interface mode bitmaps for SFP PHYs	
>>>> net: phy: add supported_interfaces to Aquantia AQR113C
>>>> net: phy: add supported_interfaces to marvell10g PHYs
>>>> net: phy: add supported_interfaces to marvell PHYs
>>>> net: phy: add supported_interfaces to bcm84881
>>>> net: phy: add supported_interfaces to phylib
>>>>
>>>> These would be pre-requisites for the 100FX-SGMII SFP support, as the
>>>> interface resolution currently doesn't elect SGMII for 100FX modules.
>>>>
>>>> That would require some changes to the current host_interfaces API as
>>>> well, potentially replacing it altogether.
>>>>
>>>> Is this something you can do, or can I get your permission to submit
>>>> these (ofc maybe with more stuff to deal with host_interfaces)
>>>
>>> One of the issues that will need to be solved is how to tell
>>> 100FX-SGMII (e.g. https://www.fs.com/uk/products/37770.html) which need
>>> SGMII apart from 100FX modules that don't (e.g.
>>> https://www.fs.com/uk/products/37324.html)
>>>
>>> host_interfaces don't satisfy that, because this has nothing to do with
>>> what the host can do. Either the module has a PHY and uses SGMII on
>>> the host side, or it doesn't have a PHY in which case 100BASE-X needs
>>> to be used. If we have a PHY, then we will work out using what we
>>> already have.
>>>
>>> Given that 100FX-SGMII, the PHY _should_ be coming up in SGMII mode,
>>> so that's what we need to use to talk to them.
>>
>> _should_ indeed. All modules I got required some level of configuration
>> of the internal PHY for it to work, and without Florian's help [1] on
>> how to setup the broadcom PHY in SGMII to 100FX mode, all the modules I
>> tried were just fancy paperweights :(
>>
>> [1] : https://lore.kernel.org/netdev/24146e10-5e9c-42f5-9bbe-fe69ddb01d95@broadcom.com/
> 
> If they don't come up configured correctly, then how do commercial off
> the shelf switches work with these modules?

I have no clue, I've only ever tested these with linux boards :/

> 
>>> If we change the PHY's
>>> mode to something else, we get into the horrid problems that is rate
>>> matching, which gives us the problem that we don't have very good
>>> support for that (e.g. PHYs that require the MAC to pace the transmit
>>> rate.)
>>>
>>> I suspect there is no way to tell these SFPs apart using the EEPROM,
>>> which means we're left with the "does this module that looks like a
>>> optical module have a PHY?" problem that we already use for copper
>>> SFPs. If there's no detectable PHY, then we'd likely have to assume
>>> that the SFP requires 100BASE-X.
>>
>> I agree with that completely. From the few such modules I have, we don't
>> have much to work with in the eeprom to come-up with a proper generic
>> support for these.
>>
>> I see no way around that other than probing for a PHY for every 100FX
>> module, and see what we get. Alternatively, we could rely on fixups
>> and have that internal hardcoded database of supported modules ?
> 
> Note that there is base.e100_base_fx and base.e100_base_lx, but also
> base.e_base_px and base.e_base_bx10 which can also require 100BASE-X
> provided the bitrate is for 100. It would be good to know what
> capabilities your modules report.

Ah I didn't know about e_base_bx10 and e_base_px. See below for the capabilities.

> 
> (side note, I'm looking at:
>         if ((id->base.e_base_px || id->base.e_base_bx10) && br_nom == 100) {
> and wondering whether that should be 1.25x 100.)
> 
> I have some EEPROM dumps in my database for:
> 
>         Transceiver codes                         : 0x00 0x00 0x01 0x20 0x00 0x00 0x00 0x00 0x00
>         Transceiver type                          : SONET: OC-3, short reach
>         Transceiver type                          : Ethernet: 100BASE-FX
>         Encoding                                  : 0x02 (4B/5B)
>         BR, Nominal                               : 100MBd
> 
>         Connector                                 : 0x07 (LC)
>         Transceiver codes                         : 0x00 0x10 0x02 0x10 0x00 0x00 0x00 0x00 0x00
>         Transceiver type                          : SONET: SONET reach specifier bit 1
>         Transceiver type                          : SONET: OC-3, single mode, inter. reach
>         Transceiver type                          : Ethernet: 100BASE-LX/LX10
>         Encoding                                  : 0x02 (4B/5B)
>         BR, Nominal                               : 100MBd
> 
>         Connector                                 : 0x07 (LC)
>         Transceiver codes                         : 0x00 0x00 0x01 0x10 0x00 0x00 0x00 0x00 0x00
>         Transceiver type                          : SONET: OC-3, short reach
>         Transceiver type                          : Ethernet: 100BASE-LX/LX10
>         Encoding                                  : 0x02 (4B/5B)
>         BR, Nominal                               : 100MBd
> 
>         Connector                                 : 0x07 (LC)
>         Transceiver codes                         : 0x00 0x00 0x00 0x40 0x00 0x00 0x00 0x00 0x00
>         Transceiver type                          : Ethernet: BASE-BX10
>         Encoding                                  : 0x02 (4B/5B)
>         BR, Nominal                               : 100MBd
> 
> I don't have the actual modules though. I think all of these are
> ones which require 100BASE-X rather than having a PHY.

Then here's more for your database :)

 - Prolabs GLC-GE-100FX-C, with bcm5461 PHY. Works after this series.

	Identifier                                : 0x03 (SFP)
	Extended identifier                       : 0x04 (GBIC/SFP defined by 2-wire interface ID)
	Connector                                 : 0x07 (LC)
	Transceiver codes                         : 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x80
	Encoding                                  : 0x02 (4B/5B)
	BR Nominal                                : 100MBd
	Rate identifier                           : 0x00 (unspecified)
	Length (SMF)                              : 0km
	Length (OM2)                              : 2000m
	Length (OM1)                              : 2000m
	Length (Copper or Active cable)           : 0m
	Length (OM3)                              : 0m
	Laser wavelength                          : 1310nm
	Vendor name                               : CISCO-PROLABS
	Vendor OUI                                : 00:00:00
	Vendor PN                                 : GLC-GE-100FX-C
	Vendor rev                                : D2
	Option values                             : 0x00 0x1a
	Option                                    : TX_DISABLE implemented
	BR margin max                             : 0%
	BR margin min                             : 0%
	Vendor SN                                 : PRLF6AFB1141
	Date code                                 : 241216


 - Prolabs SFP-GE-100FX-C, with bcm5461 PHY. Doesn't work after this series :

	Identifier                                : 0x03 (SFP)
	Extended identifier                       : 0x04 (GBIC/SFP defined by 2-wire interface ID)
	Connector                                 : 0x07 (LC)
	Transceiver codes                         : 0x00 0x00 0x00 0x20 0x00 0x00 0x00 0x00 0x00
	Transceiver type                          : Ethernet: 100BASE-FX
	Encoding                                  : 0x02 (4B/5B)
	BR Nominal                                : 100MBd
	Rate identifier                           : 0x00 (unspecified)
	Length (SMF)                              : 0km
	Length (OM2)                              : 2000m
	Length (OM1)                              : 2000m
	Length (Copper or Active cable)           : 0m
	Length (OM3)                              : 0m
	Laser wavelength                          : 1310nm
	Vendor name                               : PROLABS
	Vendor OUI                                : 00:00:00
	Vendor PN                                 : SFP-GE-100FX-C
	Vendor rev                                : A3
	Option values                             : 0x00 0x1a
	Option                                    : TX_DISABLE implemented
	BR margin max                             : 0%
	BR margin min                             : 0%
	Vendor SN                                 : PR21F07D1463
	Date code                                 : 250416
	Optical diagnostics support               : Yes
	Laser bias current                        : 0.000 mA
	Laser output power                        : 0.0000 mW / -inf dBm
	Receiver signal average optical power     : 0.0000 mW / -inf dBm
	Module temperature                        : 22.17 degrees C / 71.90 degrees F
	Module voltage                            : 3.3329 V
	Alarm/warning flags implemented           : Yes
	Laser bias current high alarm             : Off
	Laser bias current low alarm              : On
	Laser bias current high warning           : Off
	Laser bias current low warning            : On
	Laser output power high alarm             : Off
	Laser output power low alarm              : On
	Laser output power high warning           : Off
	Laser output power low warning            : On
	Module temperature high alarm             : Off
	Module temperature low alarm              : Off
	Module temperature high warning           : Off
	Module temperature low warning            : Off
	Module voltage high alarm                 : Off
	Module voltage low alarm                  : Off
	Module voltage high warning               : Off
	Module voltage low warning                : Off
	Laser rx power high alarm                 : Off
	Laser rx power low alarm                  : On
	Laser rx power high warning               : Off
	Laser rx power low warning                : On
	Laser bias current high alarm threshold   : 100.000 mA
	Laser bias current low alarm threshold    : 2.000 mA
	Laser bias current high warning threshold : 80.000 mA
	Laser bias current low warning threshold  : 4.000 mA
	Laser output power high alarm threshold   : 0.1510 mW / -8.21 dBm
	Laser output power low alarm threshold    : 0.0253 mW / -15.97 dBm
	Laser output power high warning threshold : 0.1259 mW / -9.00 dBm
	Laser output power low warning threshold  : 0.0316 mW / -15.00 dBm
	Module temperature high alarm threshold   : 75.00 degrees C / 167.00 degrees F
	Module temperature low alarm threshold    : -5.00 degrees C / 23.00 degrees F
	Module temperature high warning threshold : 70.00 degrees C / 158.00 degrees F
	Module temperature low warning threshold  : 0.00 degrees C / 32.00 degrees F
	Module voltage high alarm threshold       : 3.6300 V
	Module voltage low alarm threshold        : 2.9700 V
	Module voltage high warning threshold     : 3.4600 V
	Module voltage low warning threshold      : 3.1300 V
	Laser rx power high alarm threshold       : 1.0000 mW / 0.00 dBm
	Laser rx power low alarm threshold        : 0.0003 mW / -35.23 dBm
	Laser rx power high warning threshold     : 0.5000 mW / -3.01 dBm
	Laser rx power low warning threshold      : 0.0006 mW / -32.22 dBm

- FS SFP-GB-GE-T, with bcm5461 PHY, works after this series :

	Identifier                                : 0x03 (SFP)
	Extended identifier                       : 0x04 (GBIC/SFP defined by 2-wire interface ID)
	Connector                                 : 0x07 (LC)
	Transceiver codes                         : 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
	Encoding                                  : 0x02 (4B/5B)
	BR Nominal                                : 100MBd
	Rate identifier                           : 0x00 (unspecified)
	Length (SMF)                              : 0km
	Length (OM2)                              : 2000m
	Length (OM1)                              : 2000m
	Length (Copper or Active cable)           : 0m
	Length (OM3)                              : 0m
	Laser wavelength                          : 1310nm
	Vendor name                               : FS
	Vendor OUI                                : 00:00:00
	Vendor PN                                 : SFP-GE-100FX
	Vendor rev                                : 1.0
	Option values                             : 0x00 0x12
	Option                                    : TX_DISABLE implemented
	BR margin max                             : 0%
	BR margin min                             : 0%
	Vendor SN                                 : C2405662285
	Date code                                 : 240606
	Optical diagnostics support               : Yes
	Laser bias current                        : 0.000 mA
	Laser output power                        : 0.0000 mW / -inf dBm
	Receiver signal average optical power     : 0.0000 mW / -inf dBm
	Module temperature                        : 3.96 degrees C / 39.13 degrees F
	Module voltage                            : 3.3236 V
	Alarm/warning flags implemented           : Yes
	Laser bias current high alarm             : Off
	Laser bias current low alarm              : On
	Laser bias current high warning           : Off
	Laser bias current low warning            : Off
	Laser output power high alarm             : Off
	Laser output power low alarm              : On
	Laser output power high warning           : Off
	Laser output power low warning            : Off
	Module temperature high alarm             : Off
	Module temperature low alarm              : Off
	Module temperature high warning           : Off
	Module temperature low warning            : Off
	Module voltage high alarm                 : Off
	Module voltage low alarm                  : Off
	Module voltage high warning               : Off
	Module voltage low warning                : Off
	Laser rx power high alarm                 : Off
	Laser rx power low alarm                  : On
	Laser rx power high warning               : Off
	Laser rx power low warning                : Off
	Laser bias current high alarm threshold   : 90.000 mA
	Laser bias current low alarm threshold    : 2.000 mA
	Laser bias current high warning threshold : 80.000 mA
	Laser bias current low warning threshold  : 4.000 mA
	Laser output power high alarm threshold   : 0.0631 mW / -12.00 dBm
	Laser output power low alarm threshold    : 0.0063 mW / -22.01 dBm
	Laser output power high warning threshold : 0.0501 mW / -13.00 dBm
	Laser output power low warning threshold  : 0.0079 mW / -21.02 dBm
	Module temperature high alarm threshold   : 85.00 degrees C / 185.00 degrees F
	Module temperature low alarm threshold    : -5.00 degrees C / 23.00 degrees F
	Module temperature high warning threshold : 75.00 degrees C / 167.00 degrees F
	Module temperature low warning threshold  : 0.00 degrees C / 32.00 degrees F
	Module voltage high alarm threshold       : 3.5700 V
	Module voltage low alarm threshold        : 3.1300 V
	Module voltage high warning threshold     : 3.4700 V
	Module voltage low warning threshold      : 3.1500 V
	Laser rx power high alarm threshold       : 0.7943 mW / -1.00 dBm
	Laser rx power low alarm threshold        : 0.0006 mW / -32.22 dBm
	Laser rx power high warning threshold     : 0.6310 mW / -2.00 dBm
	Laser rx power low warning threshold      : 0.0008 mW / -30.97 dBm

- Phoenix Contact FL SFP FX, not sure what's in it, not even sure it's
the right kind of module as it shows 200MBd ?

	Identifier                                : 0x03 (SFP)
	Extended identifier                       : 0x04 (GBIC/SFP defined by 2-wire interface ID)
	Connector                                 : 0x07 (LC)
	Transceiver codes                         : 0x00 0x00 0x01 0x00 0x00 0x00 0x00 0x00 0x00
	Transceiver type                          : SONET: OC-3, short reach
	Encoding                                  : 0x02 (4B/5B)
	BR Nominal                                : 200MBd
	Rate identifier                           : 0x00 (unspecified)
	Length (SMF)                              : 0km
	Length (OM2)                              : 2000m
	Length (OM1)                              : 2000m
	Length (Copper or Active cable)           : 0m
	Length (OM3)                              : 0m
	Laser wavelength                          : 1310nm
	Vendor name                               : PHOENIX CONTACT
	Vendor OUI                                : 00:a0:45
	Vendor PN                                 : 2891081
	Vendor rev                                : 02
	Option values                             : 0x00 0x1a
	Option                                    : TX_DISABLE implemented
	BR margin max                             : 0%
	BR margin min                             : 0%
	Vendor SN                                 : 3053642005
	Date code                                 : 240709
	Optical diagnostics support               : Yes
	Laser bias current                        : 0.000 mA
	Laser output power                        : 0.0000 mW / -inf dBm
	Receiver signal average optical power     : 0.0000 mW / -inf dBm
	Module temperature                        : 17.00 degrees C / 62.60 degrees F
	Module voltage                            : 3.3285 V
	Alarm/warning flags implemented           : Yes
	Laser bias current high alarm             : Off
	Laser bias current low alarm              : On
	Laser bias current high warning           : Off
	Laser bias current low warning            : On
	Laser output power high alarm             : Off
	Laser output power low alarm              : On
	Laser output power high warning           : Off
	Laser output power low warning            : On
	Module temperature high alarm             : Off
	Module temperature low alarm              : Off
	Module temperature high warning           : Off
	Module temperature low warning            : Off
	Module voltage high alarm                 : Off
	Module voltage low alarm                  : Off
	Module voltage high warning               : Off
	Module voltage low warning                : Off
	Laser rx power high alarm                 : Off
	Laser rx power low alarm                  : On
	Laser rx power high warning               : Off
	Laser rx power low warning                : On
	Laser bias current high alarm threshold   : 80.000 mA
	Laser bias current low alarm threshold    : 2.000 mA
	Laser bias current high warning threshold : 70.000 mA
	Laser bias current low warning threshold  : 4.000 mA
	Laser output power high alarm threshold   : 0.0794 mW / -11.00 dBm
	Laser output power low alarm threshold    : 0.0100 mW / -20.00 dBm
	Laser output power high warning threshold : 0.0631 mW / -12.00 dBm
	Laser output power low warning threshold  : 0.0126 mW / -19.00 dBm
	Module temperature high alarm threshold   : 110.00 degrees C / 230.00 degrees F
	Module temperature low alarm threshold    : -40.00 degrees C / -40.00 degrees F
	Module temperature high warning threshold : 100.00 degrees C / 212.00 degrees F
	Module temperature low warning threshold  : -35.00 degrees C / -31.00 degrees F
	Module voltage high alarm threshold       : 3.6000 V
	Module voltage low alarm threshold        : 3.0000 V
	Module voltage high warning threshold     : 3.5000 V
	Module voltage low warning threshold      : 3.1000 V
	Laser rx power high alarm threshold       : 0.5012 mW / -3.00 dBm
	Laser rx power low alarm threshold        : 0.0010 mW / -30.00 dBm
	Laser rx power high warning threshold     : 0.3981 mW / -4.00 dBm
	Laser rx power low warning threshold      : 0.0013 mW / -28.86 dBm

Maxime
> 


