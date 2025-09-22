Return-Path: <netdev+bounces-225236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C85B5B9049B
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 12:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80B513A6B26
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 10:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1C02FE58F;
	Mon, 22 Sep 2025 10:56:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay-b02.edpnet.be (relay-b02.edpnet.be [212.71.1.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A793E42AA9
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.71.1.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758538568; cv=none; b=ASYfytxoJ74eGw3yjWijhuYefc7/CAaZfW3CShY1QhaEibvvwz24yb726+EydNH9/OJeQCeSZ0nPpO/k9P70pOj2DckO2Y5hWQd+3yhT5Ea09Gk3i11+w+6dzdSy0kEboWkB2We0sA23BBeGBUzZj3kIzS6BeN/5HkXMuf5fnQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758538568; c=relaxed/simple;
	bh=dwdNahWurzMEEwtjWhGhKcmZUKWkGcK/KvD4niw2IQA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GZsmyrxgKiMxQLSH0mTCjDV6v6HwEGZqYHqN1Nc7EZ3Gh2qao1aVlth3UKO97PdU3elxygb/8awPpzKziVS/kOC7TGmSgQkYF6Kn2JHehhSHw3Mpbjds7Us37oaU1nuonxX4hHqNheNcb8QST4SP5l67jehTz596ClbeSd8fnSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=kabelmail.de; spf=fail smtp.mailfrom=kabelmail.de; arc=none smtp.client-ip=212.71.1.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=kabelmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kabelmail.de
Received: from [192.168.177.65] (94.105.126.5.dyn.edpnet.net [94.105.126.5]) by relay-b02.edpnet.be with ESMTP id Wgk06BKhwAZLxdeb; Mon, 22 Sep 2025 12:55:54 +0200 (CEST)
X-Barracuda-Envelope-From: janpieter.sollie@kabelmail.de
X-Barracuda-Effective-Source-IP: 94.105.126.5.dyn.edpnet.net[94.105.126.5]
X-Barracuda-Apparent-Source-IP: 94.105.126.5
Message-ID: <3fab95da-95c8-4cf5-af16-4b576095a1d9@kabelmail.de>
Date: Mon, 22 Sep 2025 12:54:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] increase MDIO i2c poll timeout gradually (including patch)
From: Janpieter Sollie <janpieter.sollie@kabelmail.de>
X-ASG-Orig-Subj: Re: [RFC] increase MDIO i2c poll timeout gradually (including patch)
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <971aaa4c-ee1d-4ca1-ba38-d65db776d869@kabelmail.de>
 <cbc4a620-36d3-409b-a248-a2b4add0016a@lunn.ch>
 <f86737b0-a0fe-49a6-aeca-9e51fbdf0f0d@kabelmail.de>
 <aM6Ng7tnEYdWmI1F@shell.armlinux.org.uk>
 <6d444507-1c97-4904-8edb-e8cc1aa4399e@kabelmail.de>
 <aM6xwq6Ns_LGxl4o@shell.armlinux.org.uk>
 <4683e9ea-f795-4dab-8a0a-bd0b0f4fbd99@kabelmail.de>
Content-Language: nl
Autocrypt: addr=janpieter.sollie@kabelmail.de; keydata=
 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
In-Reply-To: <4683e9ea-f795-4dab-8a0a-bd0b0f4fbd99@kabelmail.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-Barracuda-Connect: 94.105.126.5.dyn.edpnet.net[94.105.126.5]
X-Barracuda-Start-Time: 1758538554
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 2325
X-Barracuda-BRTS-Status: 1
Content-Transfer-Encoding: quoted-printable
X-ASG-Debug-ID: 1758538554-214fdf1df67bc6a0001-BZBGGp
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=10.0 QUARANTINE_LEVEL=10.0 KILL_LEVEL=7.0 test= 
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.125474
	Rule breakdown below
	  pts rule name              description
	 ---- ---------------------- --------------------------------------------------
	

Op 22/09/2025 om 10:04 schreef Janpieter Sollie:
> Op 20/09/2025 om 15:53 schreef Russell King (Oracle):
>> So, what we need you to do is to work out how long it takes this modul=
e
>> to respond, and whether it always takes a long time to respond. Please
>> add some debugging to i2c_rollball_mii_poll() to measure the amount of
>> time it takes for the module to respond - and please measure it for
>> several transactions.
>>
>> You can use jiffies, and convert to msecs using jiffies_to_msecs(),
>> or you could use ktime_get_ns().
>>
>> Thanks.
>>
>
> All right, so I changed the modification to a more debug-friendly funct=
ion (view below).
> I also changed the incremental wait() function from (20+10*(10-i)) to (=
20+5*(10-i)) to be more=20
> accurate.
>
> [156732.241897] i2c_rollball_mii_poll:267: mdio_bus i2c:sfp2: poll cmd =
success after 398065122=20
> ns in iteration 3
> [156732.581982] i2c_rollball_mii_poll:267: mdio_bus i2c:sfp2: poll cmd =
success after 328157082=20
> ns in iteration 4
> [156732.921978] i2c_rollball_mii_poll:267: mdio_bus i2c:sfp2: poll cmd =
success after 327986467=20
> ns in iteration 4
>
> ...
>

Something I noticed when going through a lot more iterations:

FYI: The kernel has been compiled with a 100hz timer, tickless idle and n=
o kernel preemption.
I wanted to count how much the system actually runs those i2c calls, subs=
tracting msleep,
which is 20, 245 and 300, respectively.

So, I separated i =3D 10, i =3D 4 and i =3D 3 a bit.
 > 192 numbers for i =3D 10
 > 2309 numbers for i =3D 4
 > 1129 numbers for i =3D 3

and calculating max and min, substracting the msleep:

 > 1 function call max: 20131327
 > 1 function call min: 9990574
 > diff at iteration 10: 10140753
 > avg at iteration 10:=C2=A0 10723993

 > 7 function calls min: 82868351
 > 7 function calls max:=C2=A0 123074939
 > diff at iteration 4: 40206588
 > avg at iteration 4: 86375811

 > 8 function calls min: 97889217
 > 8 function calls max: 128086531
 > diff at iteration 3: 30197314
 > avg at iteration 3: 99901858

this is a diff of 10usecs (i=3D10), 40usecs (i=3D4) and 30usecs (i=3D3) m=
y device is running the=20
i2c_transfer_rollball().
seems a lot to me when an i2c call takes 11-12 usecs avg per call
are you sure these numbers point to a stable i2c bus?

thanks,

Janpieter Sollie

