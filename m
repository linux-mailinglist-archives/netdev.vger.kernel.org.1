Return-Path: <netdev+bounces-168867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5DDA41208
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 23:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3EAE7A8FEE
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 22:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63E11EEA29;
	Sun, 23 Feb 2025 22:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="Ec4keQcG"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F28B33993;
	Sun, 23 Feb 2025 22:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740349622; cv=none; b=VSGFQJchk/J+O/jRV3IyDz4lhQv0SFoJC9v8gRtJ/GOMspBMppqzaKgDWt3yftk9+K3b7iUndGxYjeEKCLy8M3GWhLIqbYX92aqvrjQx7/9ud5Sgs15AFnMM9omD8esUVjf1Fl7uLXokwVN1ZSnVpkKiBgSg5cC4S9vH3tB5A38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740349622; c=relaxed/simple;
	bh=CYVuYussyon2xyhZm0JT9rnJSvFtDp/joLsqNlUmBkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BUhNA5cMv0qaXz3LotpYRMp7XI8lqaWFWJsuQg5EkV4T6KY7Hdt15eSck8aysuk9iSrcsYtlHJSkeJxAee4oaqpjwAz5ECKydCUe2qpVFEYLE7se0geX5boX6+DDHtD9+irEpsWzSR2buJf99iW7calLlkyF1MH/yg63tUjQ5CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=Ec4keQcG; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1740349615; x=1740954415; i=hfdevel@gmx.net;
	bh=GAUnvypXpsPskkAYkCAtdvXbIMxTmJvrZvkgi8HqgmE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Ec4keQcGN8roaGJGgijj+KZfaZiXhBiRcZYyHtj+XqZyM3pxs6hH4u/I++lDK9V4
	 NDZIKBckGPcchViFCsLK2+RhHlKn8ukUeEy59VsPLF7urUWm3aWRAv0WRlrE4Q+vS
	 jXiSErj2MlAce6Iu8P2y745vQr8qwnHYv625zFWOPq3H8E6PFn7wBTDMRaEW0YoZV
	 WbSLOBbpMXpj/ukAmWfBLGW+opPTRWB/QXwfQWpcNVEXYLsx9RXwAAFAju+482yMT
	 zGrMi+upN4aF3hLY+8G30fs2BIFnp8tDXYtUlUiTj9beyiZu9yFIIy6U+3S9fgMwS
	 nlbWAQfAuaAiLLfQJA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.0.0.23] ([77.33.175.99]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1wlv-1tJMTm0p0T-0155ZY; Sun, 23
 Feb 2025 23:26:55 +0100
Message-ID: <d944c0bd-a652-4bfe-b6e8-c264f5b36562@gmx.net>
Date: Sun, 23 Feb 2025 23:26:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 4/7] net: phy: aquantia: add essential
 functions to aqr105 driver
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250222-tn9510-v3a-v5-0-99365047e309@gmx.net>
 <20250222-tn9510-v3a-v5-4-99365047e309@gmx.net>
 <20250223113232.3092a990@fedora.home>
Content-Language: en-US
From: Hans-Frieder Vogt <hfdevel@gmx.net>
In-Reply-To: <20250223113232.3092a990@fedora.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BMeUTflewcFwbAKmtrQhvjLo+AsFbays6Kk73VD3y7IzxjkVMR7
 JMZLQmRV0r7wwf7fJd06uAd17bluJtJ8zkS/UMlr/mC0pp60HMGP4NgrylDNz14XdMabTpK
 Sa0AjQTsNpSq7XfLmK6V4zH8/Cx66JulXoxnDTS3BTdlXfO2DuVOFl+efw/ZC2Y8ZmcTAon
 UjC3LE3ygjegs3bKE44Fg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Z/CSSJg9Xaw=;Rd9v/f9aXATZ1DaQ7IsPFsGWI9B
 7zwub7kyVnSKbeIk53jA1ALCiYr6tXVw9yuXwwynP/ixH6IL76YRxiCHwBiOX2w0NZWLqd/8Q
 Ra7WACJEVKZXJmxlAnmYvnzd4Ukd/99HRKLnjWtjDGILvtoG+szBcoa9mHBlZeieHArfh+IVN
 zglAtQFc+bnBHmHLIur/SgYJA08JaD9bDMctf4dtwatVuJmhJzSeUaavG5CY3psdcJM6LT3aS
 wH4AJb6PLyAKodmZMJF+2c+puIRZd0IJpzsBRfaueKTNw6P8K3SGQkmHNh+ttVR1Lso0W5qmE
 dQQynhY+GI4k/HXhNxod1fescCHtFVFagvE5SHnxIOU4WOUBPGZbamBjmzIXSxbq5NRiOjVIs
 7+zBZZAJqesPjva/G/WgTF8A1tfPeQHatchaD6RjKOXTXCfxZiWrj4DcGsfytNuSc4WLdcA7q
 PGxbKXVPXdjnLQiRDnj4qkhQg5vR8D2Y6xJRjDQigC+w5VdvYXBsRaFKy38It6Kvv289XpRUB
 /oAG17qjJ1bM378p5v7UtN+rMbnrSE5pz6tiMV75Su+f3qAGPgmGEhSmYagixpadCG2lbMz8r
 1cKKBZx+e8f9DMS9UqUV2IMRWeE3QNBPDErsXRnn1LhtBRY0eayRJHhVZI57YWwb9755nvWMs
 nrSGWBUeOA0IYHN+h9+miXVa3C5za3sVqZ4yJaOW34Y+z5uYvMCiP5J/mLOs8fiVBDmk61yGk
 XLFLuDZxm4gS/p4Io1AcyHC889nDzCmu6uRIgDrK7YpJBIgnyuuFaJg+1J0n4t8t8zpr1COFg
 SPnpenSYtri9JHKelTMfW5yylx7Qpk6+0gnbAJV0KvE7cHZqEjOejzorgT9IBpJbmq3uz3qUp
 p93YKL/yUhkak9RqEAWbGGGHiiQhhJYNamiKGI3um5u8Dxvillmh3wpKdUNwT5DS+w1reVfv7
 U42aN/BO0cmz5XFwp9Sl9q1G+SRyVu6Gj0PJwk1xOf1Olntu2C7tnNpauY5ApANBduSo9lq2B
 IGYNwoR0DWBYMQxT9lMtXcyOEDxXoCTgRM8KWY9+vcxOE9/j9JRgflFwgS0hUnbF6VovqHUX6
 1QSRRHZKjyqJRp+eZuIs3iD8aD2y7qRySQ50NdvsR3h3t2oWGOs+U9LCxkUqZo0dK5nZg+X4B
 TgVGdPEWkpcqnJpdOc6UOvzQRXGP050OPavFD7VLcl4KpvO6f4Xg6cyownuuNWKMUB67NLPyG
 zHa1yeX/GPdWsjk6JQ2Sb/6w5wNzSw6n+SiIIwQV6r9WMekKdsY63jcEX/IeOa/XpYCTAc+bi
 OYjEUrOEAEtcRn9Ioqx4ZAUPBsUAoxn0vHxtQ8f8oW7AavmH/4jWBmvjd6BPyGJ5bHPnneUWH
 HfWuv+50pqwKXhuFR1V3MfFsZxhIfWMP2lZ4k=

Hi Maxime,

On 23.02.2025 11.32, Maxime Chevallier wrote:
> Hi,
>
> On Sat, 22 Feb 2025 10:49:31 +0100
> Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org>
> wrote:
>
>> From: Hans-Frieder Vogt <hfdevel@gmx.net>
>>
>> This patch makes functions that were provided for aqr107 applicable to
>> aqr105, or replaces generic functions with specific ones. Since the aqr=
105
>> was introduced before NBASE-T was defined (or 802.3bz), there are a num=
ber
>> of vendor specific registers involved in the definition of the
>> advertisement, in auto-negotiation and in the setting of the speed. The
>> functions have been written following the downstream driver for TN4010
>> cards with aqr105 PHY, and use code from aqr107 functions wherever it
>> seemed to make sense.
>>
>> Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
>> ---
>>   drivers/net/phy/aquantia/aquantia_main.c | 242 ++++++++++++++++++++++=
++++++++-
>>   1 file changed, 240 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy=
/aquantia/aquantia_main.c
>> index 86b0e63de5d88fa1050919a8826bdbec4bbcf8ba..38c6cf7814da1fb9a4e715f=
242249eee15a3cc85 100644
>> --- a/drivers/net/phy/aquantia/aquantia_main.c
>> +++ b/drivers/net/phy/aquantia/aquantia_main.c
>> @@ -33,6 +33,9 @@
>>   #define PHY_ID_AQR115C	0x31c31c33
>>   #define PHY_ID_AQR813	0x31c31cb2
>>
>> +#define MDIO_AN_10GBT_CTRL_ADV_LTIM		BIT(0)
> This is a standard C45 definition, from :
> 45.2.7.10.15 10GBASE-T LD loop timing ability (7.32.0)
>
> So if you need this advertising capability, you should add that in the
> generic definitions for C45 registers in include/uapi/linux/mdio.h
Thanks. Wasn't aware this being a standard definition.

Wouldn't the definition
#define ADVERTISE_XNP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(12)
then need to go to include/uapi/linux/mii.h accordingly?
There, bit 12 is currently named ADVERTISE_RESV and commented as unused
(which it obviously is not, because it is used in
drivers/net/ethernet/sfc/falcon/mdio_10g.c
I think, for now, I will just do the same as in the falcon driver and
use ADVERTISE_RESV instead. Then it may be renamed later in all places.
>
> That being said, as it looks this is the first driver using this
> feature, do you actually need to advertise Loop Timing ability here ?
> I guess it comes from the vendor driver ?
you are right. The code just tries to replicate the vendor code.
However, I have now tested the driver without this flag and haven't
noticed any unusual behavior. So, I guess, it works indeed without.
I'll remove the flag in the next revision of the patch.
> Thanks,
>
> Maxime
Thanks as well,
Hans-Frieder

