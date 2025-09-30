Return-Path: <netdev+bounces-227352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED0FBACE59
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 14:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 809673BC2BA
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 12:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E0B2FCBEF;
	Tue, 30 Sep 2025 12:43:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay-b01.edpnet.be (relay-b01.edpnet.be [212.71.1.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183342571DD
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 12:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.71.1.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759236213; cv=none; b=mFDtmApvdqwUBIv5Y8h8YBugmYsALGDwP3k0qQa5GKWBuB3Ak9lWDiZJiGWVBBvqz9suj/Ta3HjXbA5gEwcLv/IBXp4HFc++2F9u4eQ7B/fYhlZKIrjx/Y0SKrbg5WVKxPS/yWnNiyX08xUL/EDrjrYvbFdfAbJjuWXldT9spd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759236213; c=relaxed/simple;
	bh=1L8enFHqffnYoUbDLe2TaTjFpFPDojRGWAA8nTLnp7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aS+cYrSeUigiFnsAzEMT3tyTWEsH/8QLp6TEmzO3RS98Llceq0LlDDb03nMlGqtyAqEek2Y5og4VbW4bh/8rbS7oQesCVEjZAwd1McYCDGdrBmcWZLAuxWlBNa182Emxf7iP2qPo/8B/0ksKiW2hL6Oat9LC4Wn1+cHiA8MLlBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=kabelmail.de; spf=fail smtp.mailfrom=kabelmail.de; arc=none smtp.client-ip=212.71.1.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=kabelmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kabelmail.de
Received: from [192.168.177.115] (213.219.178.105.adsl.dyn.edpnet.net [213.219.178.105]) by relay-b01.edpnet.be with ESMTP id YryuBmno8DEwRQTe; Tue, 30 Sep 2025 14:43:19 +0200 (CEST)
X-Barracuda-Envelope-From: janpieter.sollie@kabelmail.de
X-Barracuda-Effective-Source-IP: 213.219.178.105.adsl.dyn.edpnet.net[213.219.178.105]
X-Barracuda-Apparent-Source-IP: 213.219.178.105
Message-ID: <21cb8551-ce9c-4051-8b40-2ada0ef51a33@kabelmail.de>
Date: Tue, 30 Sep 2025 14:41:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] increase i2c_mii_poll timeout for very slow SFP
 modules
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
X-ASG-Orig-Subj: Re: [PATCH RFC] increase i2c_mii_poll timeout for very slow SFP
 modules
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
References: <d73c74c0-5832-4358-a18e-1f555e928e79@kabelmail.de>
 <aNqJS6sUp-lk2-xC@shell.armlinux.org.uk>
From: Janpieter Sollie <janpieter.sollie@kabelmail.de>
Autocrypt: addr=janpieter.sollie@kabelmail.de; keydata=
 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
Content-Language: en-US
In-Reply-To: <aNqJS6sUp-lk2-xC@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-Barracuda-Connect: 213.219.178.105.adsl.dyn.edpnet.net[213.219.178.105]
X-Barracuda-Start-Time: 1759236199
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1741
X-Barracuda-BRTS-Status: 1
Content-Transfer-Encoding: quoted-printable
X-ASG-Debug-ID: 1759236199-2392347e96487b0001-BZBGGp
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=10.0 QUARANTINE_LEVEL=10.0 KILL_LEVEL=7.0 test= 
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.125474
	Rule breakdown below
	  pts rule name              description
	 ---- ---------------------- --------------------------------------------------
	

Op 29/09/2025 om 15:27 schreef Russell King (Oracle):
> Your persistent attempts to differentiate between the platforms that
> this code was developed on (allegedly, according to you, "high
> performance") and your "embedded devices" is becoming very very
> wearing.
I was surprised reading this.
The code of Marek seems to work since 2023, very few modifications have b=
een made.
I assume it has been tested + used many many times, and nobody ever had p=
roblems.

Why target embedded devices?
I also assumed the major use of this code are corporations using enterpri=
se setups.
Whatever device Marek his code was developed for,
It seems to be stable with a total wait of +- 200ms targeting 70ms, for e=
very user using it.
Me using rare setups -> me trying to fix a almost nonexistent situation.
The BPI people suggested it *might* be a power problem.

The phy is known to work correctly, AQR113C has been supported for quite =
some time now.
I can't imagine the SFP module vendor sells a not-linux-compatible EEPROM=
 which needs > 200 ms.
There must be something inside the module that's slowing down for whateve=
r reason.

So is it wearing?=C2=A0 Yes.

Using your hints, I saw the i2c_transfer_rollball() call takes 10ms to ex=
ecute,
with a 20ms sleep this is 33% of one loop querying the endpoint for an an=
swer.
If it would have been 10% or even less, I'd simply say:
"increase i to 20, query a few more times".
But in this case I'd rather not.

> Please come back when you've changed your attitude.
>
> Thanks.
>

No worries, you gave me the knowledge I needed to fix it.
If it's that rare, it should not be implemented at all.
I hope my clarification explains.=C2=A0 I've overthought things more-than=
-once.

Thanks

