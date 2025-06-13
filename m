Return-Path: <netdev+bounces-197391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 125CCAD8814
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 11:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A58718835AF
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 09:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94A927281F;
	Fri, 13 Jun 2025 09:38:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay-b01.edpnet.be (relay-b01.edpnet.be [212.71.1.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB5F291C19
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 09:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.71.1.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749807481; cv=none; b=Cr00vNihQ/GdNP+2hpV7A1BGZ3Lc/6C1fN6eVql5M/Y/j8Pifk0pLWo6zGrNisHZ5uAoUrHwbPDXgXZbbuao7YXhLpQCvSZ+tT++WM0bMeGbMnWgd7sJBPd0RKzoG5LroOI14I16A3IGX8Rn1K7oDvWxcgAL3deFf2jz0mMTrjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749807481; c=relaxed/simple;
	bh=pT37qa2Y7B0AAUG7em9ba55oNXzMdJcI4wIOYemlkDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e17uKeJXiL7UK8X34UM5hFkSU5ynn4novXflnD90b8uIdMNNozcADwtNjrYCQe8LY/haUIz3M8VfZoCRJywX+aZ/31vjqWWdhSHvteh16QnqhZOPa2xEzoUacIWUWTVpvRhtwi2QbG3kXN/NbPPqVfwxflHwWVsUPOJsketji6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kabelmail.de; spf=fail smtp.mailfrom=kabelmail.de; arc=none smtp.client-ip=212.71.1.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kabelmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kabelmail.de
X-ASG-Debug-ID: 1749807468-23923465f817ec90001-BZBGGp
Received: from [192.168.177.53] (213.219.166.145.adsl.dyn.edpnet.net [213.219.166.145]) by relay-b01.edpnet.be with ESMTP id 2comrNGkf68lUcOo; Fri, 13 Jun 2025 11:37:48 +0200 (CEST)
X-Barracuda-Envelope-From: janpieter.sollie@kabelmail.de
X-Barracuda-Effective-Source-IP: 213.219.166.145.adsl.dyn.edpnet.net[213.219.166.145]
X-Barracuda-Apparent-Source-IP: 213.219.166.145
Message-ID: <b6a4604e-55bd-4ab7-9cf2-05fb94e72500@kabelmail.de>
Date: Fri, 13 Jun 2025 11:37:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [support request]: where should I register this (apparently not
 supported yet) transceiver?
To: Andrew Lunn <andrew@lunn.ch>
X-ASG-Orig-Subj: Re: [support request]: where should I register this (apparently not
 supported yet) transceiver?
Cc: netdev@vger.kernel.org
References: <5568c38c-5c93-493a-96bd-b6537a4d1ad6@kabelmail.de>
 <da8834aa-da77-4633-ac6f-d2b738a97337@lunn.ch>
Content-Language: nl
From: Janpieter Sollie <janpieter.sollie@kabelmail.de>
Autocrypt: addr=janpieter.sollie@kabelmail.de; keydata=
 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
In-Reply-To: <da8834aa-da77-4633-ac6f-d2b738a97337@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Barracuda-Connect: 213.219.166.145.adsl.dyn.edpnet.net[213.219.166.145]
X-Barracuda-Start-Time: 1749807468
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 7048
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.142799
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

Op 12/06/2025 om 14:18 schreef Andrew Lunn:
> On Thu, Jun 12, 2025 at 10:58:23AM +0200, Janpieter Sollie wrote:
>> Hi Everyone, I'm looking for support to register my trainsceiver in the phy subsystem. This 
>> RJ45 transceiver (ZK-10G-TX) looks very weird in ethtool: |> Identifier : 0x03 (SFP)
>>> Extended identifier : 0x04 (GBIC/SFP defined by 2-wire interface ID) Connector : 0x07 (LC) 
>>> Transceiver codes : 0x10 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 Transceiver type : 10G 
>>> Ethernet: 10G Base-SR Encoding : 0x06 (64B/66B) BR Nominal : 10300MBd Rate identifier : 0x00 
>>> (unspecified) Length (SMF) : 0km Length (OM2) : 80m Length (OM1) : 20m Length (Copper or 
>>> Active cable) : 0m Length (OM3) : 300m Laser wavelength : 850nm Vendor name : OEM Vendor OUI 
>>> : 00:1b:21 Vendor PN : ZK-10G-TX Vendor rev : 1 Option values : 0x00 0x1a Option : 
>>> TX_DISABLE implemented BR margin max : 0% BR margin min : 0% Vendor SN : 2505010443 Date 
>>> code : 250412 Optical diagnostics support : Yes Laser bias current : 6.000 mA Laser output 
>>> power : 0.5000 mW / -3.01 dBm Receiver signal average optical power : 0.4000 mW / -3.98 dBm 
>> ... I cannot read its pages with i2c tools. It has a big "AQR113C" sticker on it, 
> The protocol to talk to the PHY is not defined in the standards. However, there are two main 
> protocols. It could be this PHY needs rollball. Please try adding an entry to 
> drivers/net/phy/sfp.c:sfp_quirk[] for this SFP, using sfp_fixup_rollball. It might work, it 
> might not... Andrew 
Hi Andrew,

Thank you for your support,
I added the following quirk in sfp.c:

--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -515,6 +515,7 @@
SFP_QUIRK_F("OEM", "SFP-GE-T", sfp_fixup_ignore_tx_fault),

SFP_QUIRK_F("OEM", "SFP-10G-T", sfp_fixup_rollball_cc),
+SFP_QUIRK_F("OEM", "ZK-10G-TX", sfp_fixup_rollball_cc),
SFP_QUIRK_M("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
SFP_QUIRK_M("OEM", "SFP-2.5G", sfp_quirk_oem_2_5g),
SFP_QUIRK_M("OEM", "SFP-2.5G-BX10-D", sfp_quirk_2500basex),


Unfortunately, the result was not as I'd expect (on kernel 6.12.32):

 > ... (booting kernel 6.12.32 with quirk) ...
> [   37.832050] mtk_soc_eth 15100000.ethernet sfp-lan:
validation with support 00,00000000,00000000,00000000 failed: -EINVAL
> [   37.843056] sfp sfp2: sfp_add_phy failed: -EINVAL
 > ...

I tried the eepromfix of i2csfp:

> root@APBureau4:~# i2csfp sfp1 eepromfix
> [ 1141.132693] sfp sfp1: module removed
> Checksum 0x00-0x3e matched 89
> Checksum 0x40-0x5e matched 9b
> RollBall Password used: 0x63737777
> Checksum 0x00-0x3e matched 89
> Checksum 0x40-0x5e matched 9b
> root@APBureau4:~# i2csfp sfp1 restore
> [ 1154.964505] sfp sfp1: Host maximum power 3.0W
> root@APBureau4:~# [ 1155.287121] sfp sfp1: module OEM
ZK-10G-TX        rev 1    sn 2505010443       dc 250412
> [ 1155.336988] hwmon hwmon1: temp1_input not attached to any thermal zone
 >
> root@APBureau4:~# [ 1163.222307] mtk_soc_eth 15100000.ethernet sfp-wan:
validation with support 00,00000000,00000000,00000000 failed: -EINVAL
> [ 1163.233253] sfp sfp1: sfp_add_phy failed: -EINVAL

the link is down ... there's no traffic on this link

However, ethtool shows some positive news:

 > ethtool sfp-wan
 > Settings for sfp-wan:
 >         Supported ports: [ MII ]
 >         Supported link modes:   10baseT/Half 10baseT/Full
 >                                 100baseT/Half 100baseT/Full
 >                                1000baseT/Half 1000baseT/Full
 >                                10000baseT/Full
 >                                2500baseX/Full
 >                                1000baseKX/Full
 >                                10000baseKX4/Full
 >                                10000baseKR/Full
 >                                10000baseR_FEC
 >                                1000baseX/Full
 >                                10000baseCR/Full
 >                                10000baseSR/Full
 >                                10000baseLR/Full
 >                                10000baseLRM/Full
 >                                10000baseER/Full
 >                                2500baseT/Full
 >                                5000baseT/Full
 >                                100baseT1/Full
 >                                1000baseT1/Full
 >                                100baseFX/Half 100baseFX/Full
 >                                10baseT1L/Full
 >                                10baseT1S/Full
 >                                10baseT1S/Half 10baseT1S_P2MP/Half
 >        Supported pause frame use: Symmetric Receive-only
 >        Supports auto-negotiation: Yes
 >        Supported FEC modes: Not reported
 >        Advertised link modes:  10000baseT/Full
 >                                10000baseKX4/Full
 >                                10000baseKR/Full
 >                                10000baseR_FEC
 >                                10000baseCR/Full
 >                                10000baseSR/Full
 >                                10000baseLR/Full
 >                                10000baseLRM/Full
 >                                10000baseER/Full
 >        Advertised pause frame use: Symmetric Receive-only
 >        Advertised auto-negotiation: Yes
 >        Advertised FEC modes: Not reported
 >        Speed: 10000Mb/s
 >        Duplex: Full
 >        Auto-negotiation: on
 >        Port: MII
 >        PHYAD: 0
 >        Transceiver: internal
 >        Current message level: 0x000000ff (255)
 >                               drv probe link timer ifdown ifup rx_err tx_err
 >        Link detected: no

When playing with "ip link down / up",
I ultimately came to a point where this host and the endpoint agreed the link was up,
but no communication was possible.
Do you have a suggestion based on the error output of the sfp driver?

Thank you,

Janpieter Sollie

