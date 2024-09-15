Return-Path: <netdev+bounces-128448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B849798C0
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 22:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D06A3B2163C
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 20:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D302C3D96A;
	Sun, 15 Sep 2024 20:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="i/L7XN3c"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AB3282E1
	for <netdev@vger.kernel.org>; Sun, 15 Sep 2024 20:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726433238; cv=none; b=C6AZsauxzzR9HeNfxrWn+iH00blS27RJcMKLAg+zmelzd/HNAdSc/QClmp4H48kvZDoOX71apkBbiTmwAQOKzJzOoVdrBA8j7uXm74XIRLigyGT5UyxIiB5zo2SdD1j8+DfR0HmNd/crdR/zv4b3h6KSbrTBWk9yHiZ9j2aoPCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726433238; c=relaxed/simple;
	bh=gDkDxLj6ZYUVmP/wNaPeqUoRrqLepaxuoBifIFY6T+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XYnB8DDsCR3QOarvtTQmt3oX9yUdWgsKfL8RXITHNFoqyjvVyRuZmUF9AVdBc65qf4SOhuD5ubNsXO61QvW+9a5y6ABaNjgMZkxorcXHa7JmghU5BXa81SXdTCV6vPZFYx0yZpdIbpTjXs85jYrc5CpzRn8QjOAiOMbf9z0efUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=i/L7XN3c; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1726433216; x=1727038016; i=hfdevel@gmx.net;
	bh=hJJaI4Z8CGkDMn2tcA/VDnLeeghuNahKZfV+w1wXVmk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=i/L7XN3ckwuFpcw2KQT+dFk+c9wkch4vFHyv7M7b+100LIjCLUcxZfftdQUIoiOd
	 aldLGU1NsVpHCw+kn3RIH7OxmY7jCCloUpY+aO7c2KYk2vgkVYRCPDE8UL9KjqzGl
	 QlwxBmHefPPlfMmYK239sXDeiKQuvpJUNirZLQq69dvkQDePU4Oho7nAbUpHm5i+e
	 9v6ZhWzkq2FNjUT24V1OulL4VdsEuVeox4pr5mPqrT15QvnKTuYg95AWiDvIp85AE
	 NcJgcTqNFdF0kgO0wNDMX20DNKE2vpQMf3IQanWOcBchc2++X65XO8qdXMonH3ifQ
	 L/cpYO7esIXO5uzZZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.0.0.23] ([77.33.175.99]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mirna-1sKBlc0Hoq-00qBJm; Sun, 15
 Sep 2024 22:46:56 +0200
Message-ID: <33bcede0-8c47-47e0-ae0a-400fb0126628@gmx.net>
Date: Sun, 15 Sep 2024 22:46:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/7] net: phy: aquantia: search for
 firmware-name in fwnode
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <trinity-ad10e630-a77b-4887-b006-2f8885745738-1726430104089@3c-app-gmx-bap07>
 <3a14f1b4-44c1-47d5-b641-7c8a682e4d67@lunn.ch>
Content-Language: en-US
From: Hans-Frieder Vogt <hfdevel@gmx.net>
In-Reply-To: <3a14f1b4-44c1-47d5-b641-7c8a682e4d67@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SilRoP09dekssjhqg9Psw5zLKZoOvwHOekD3/52pzbl0/zqUjE0
 5IlWoSLxEGri7Tx6SfewNYlW9wUSBG9RbcIgRH5W2NI2hwUdv1odHTbsLZmbl70m++4/3zC
 3HaFs0SiYmvUu/PQubA0OF/9x5MZR6WrQNWj/giRPuyK+2SzBIxmlIUhYUd1p5O9NB2o5ot
 952T6m7XRChzShYXQ3piw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rLR5CouP86o=;ZR4BL5ohaXb3ysbL4sx9oQs/RYV
 haf+++hJS0L9Q0kRu6MeOD4HDVbN+5i7HvjMKNf4ZlmdXQ1oIsneFMVouvWlesSg3M4Bp9Hu/
 VLrykaukrABlCYm8vRmEEItBIQQx+ap1IYjg8/WDGyFv0kEhS0RV75BNYDDtbWtSyBxwYwby7
 Mlm7/PIIYswYXww3QjXDK6O4knm9hD0Xq9nI2AkmOEXRq87YXqR7ziD1OGRzjjFtHBMIaDYDZ
 qosoeDKCoduR+ZaE+yHE+zzrZAB136PWCGHIo8VGEu3mwJF19CBM9gE4qci30eEtlS4lsJ36M
 ph6OqHe1/bmV6GSVB1gyNMjdENxB8QzQvm1hp+jsIvLqhNABO0QGpsSUcgR5aNuA5vRgZgS0G
 4BjLQzane+Hk/i3EaESDjP3Tk+jd7gB2DMVKJl/97Nigv+l0jm9aVNMEIessMsTUEGT0vWgJe
 +v7z+1nvZDSmir9t0zwpM1MYiEEMunMlz4Ba/A4URscop/9m+WNoic4qMDSKHoDIpXGsdvEmQ
 8Dd7f0ISu65vODVafzBjCXSI8tw507b6XFR2QHTq7QmzAJSwsxE3040LoB3Dnj29j6FmEMH6O
 /IMjxwd4rdKcz7n3ozvXDi2UzuPTgyOTjJ9t7bBnuqvqHvYG+rLVxawu4uFhmkv4SRj5cQ442
 hgKZzoObsxFhOrXVMgbahqb4RvGa3QYvNYoSKOHjLEz5WE0u6BndQYmcd9T0zH0/N7ov6Tw1I
 SH8AbbOPFtU10hCmTqBVBhgFWuwKOvR+KOB/eEofkRa7PBRMEnFxPvM3v3YQVIspYSexNGhgp
 eBCskVzSSkTUfLEV6j9y/wjQ==

On 15.09.2024 22.32, Andrew Lunn wrote:
> On Sun, Sep 15, 2024 at 09:55:04PM +0200, Hans-Frieder Vogt wrote:
>> Allow the firmware name of an Aquantia PHY alternatively be provided by=
 the property
>> "firmware-name" of a swnode. This software node may be provided by the =
MAC or MDIO driver.
>>
>> Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
>> ---
>>   drivers/net/phy/aquantia/aquantia_firmware.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/net/phy/aquantia/aquantia_firmware.c b/drivers/net=
/phy/aquantia/aquantia_firmware.c
>> index 524627a36c6f..f0e0f04aa2f0 100644
>> --- a/drivers/net/phy/aquantia/aquantia_firmware.c
>> +++ b/drivers/net/phy/aquantia/aquantia_firmware.c
>> @@ -330,8 +330,14 @@ static int aqr_firmware_load_fs(struct phy_device =
*phydev)
>>
>>   	ret =3D of_property_read_string(dev->of_node, "firmware-name",
>>   				      &fw_name);
>> +	/* try next, whether firmware-name has been provided in a swnode */
>>   	if (ret)
>> +		ret =3D device_property_read_string(dev, "firmware-name",
>> +						  &fw_name);
> I could be getting this wrong, but my understanding is that
> device_property_read_string() will look at dev and see if there is an
> OF node available. If so, it will get the property from OF. If there
> is not, it looks to see if there is a swnode, and if there is, it uses
> that. And if there is an ACPI node, it tries there. So i _think_ you
> can replace the of_property_read_string() with
> device_property_read_string().
When I checked it first, it didn't look like that. However, I think I
found now, where
it diverts into the two directions: of_node or fwnode.
Thanks!

 =C2=A0=C2=A0=C2=A0 Hans

