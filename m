Return-Path: <netdev+bounces-128311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE4E978F3F
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 10:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E4F31C21B49
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 08:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DE9145B0F;
	Sat, 14 Sep 2024 08:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="gj/EZunB"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC99415D1
	for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 08:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726303958; cv=none; b=pynn+/pnsK/07zvP7DzVIjcVyFpFXUFwosE2K60Lw+2gjlfUWq42LQSUmGmkdfaAYD2HNR6+HWNJESLXf0NroVeLRjE8Lybp9dkWjsA3k3nt+cjjdCLFolMC5R6RgAt3Gg5/hwMro3w8oRKu6vRjv6miDwQoFwLxzoeA+o5cbbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726303958; c=relaxed/simple;
	bh=r2BRpjxQcUtOTto1rxfIpbI8JZpijtBVnI5L5HMYCGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IBVRqH29ft4xlODYbtuh48yxWISQkuTcb+Ia6PvQ6vMYA8JCJBfbhaO0T2QNcw/Oqs3HxyGVNml6eqHV+ChHNOku6rYKhiTxZXSEnWGRSTDvdltJg86tuYSh770Hs2GBJqVTVmaUAky7cWQhrE1JY1mblrlXjB4K0CTnQMWaBlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=gj/EZunB; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1726303933; x=1726908733; i=hfdevel@gmx.net;
	bh=LvKusE5nI5hyUmHyh/2XzIL56IM/aPhIruA4/hj/Nas=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gj/EZunBf5/GuO8RcEkHcTdzQt8iWOuxXVRMZAN5P6tOI83lzZpCQBCQFW6bU3cI
	 fJObD4uddzBh4UE2ympPIIcX+/aPo8fGcsUV+Jhur6aCG+5c6ZJM+7ake5/kE9UjZ
	 L7HpvUlrOrFJL1qLcNGUdiqqqkEaN5W6VaJ5AMV/1WyKkKEfgCvlOkldCMKbxF9N5
	 P8rM7ThHHecmaic0UpgirMxn3zP+ZeYh3gNuaRk3GODHc/K8C5LFOpN0x4FVA0LR5
	 OL1YCuKUDmmXCPh8W+OP88VOtBkk7Z776TpJrhqXsStbjikWoa8nd3WhVZdJTD7Gi
	 Z2Jj89NniK4vhMnARA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.0.0.23] ([77.33.175.99]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvbG2-1ry6rz2aU2-012jZZ; Sat, 14
 Sep 2024 10:52:13 +0200
Message-ID: <e632b37f-e39c-48a8-a18e-72f23a3e3a08@gmx.net>
Date: Sat, 14 Sep 2024 10:52:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/5] net: tn40xx: enable driver to support TN4010
 cards with AQR105 PHY
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
References: <trinity-0e61ef5a-b461-485b-a7ea-787ffe9b1689-1726083054223@3c-app-gmx-bs04>
 <20240913.072449.1448639398786513810.fujita.tomonori@gmail.com>
Content-Language: en-US
From: Hans-Frieder Vogt <hfdevel@gmx.net>
In-Reply-To: <20240913.072449.1448639398786513810.fujita.tomonori@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iQ4qdVHldAnf0LbjNVEh6jlLpigqI8OOgzxeBVgL3YptTgud3fr
 5KyOBWF4E4X6oJyNU0Zhv0jaHAysBdgLB5bbudyVRFLDYKyY7ECMjgt7fK3nVqlJGF+3/F0
 wiGO7vFIoIpImWv3FbuQTKJ10NjV0sQ1zhApnofJc64WulywnMiBd+p2/MOKbQ1xn+82fHr
 hTgXJ1Fte2iTveqSwAC7Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1VhRvRUcLhg=;F/XhVoYcRG6yTQ8DIz7Q0jetxha
 M3yB7+2QLExLj5upy33twmha3jrADohD2wc3x3ToGmZvnrZ6f9nzMx8VpSl6OhM2oo/H161oD
 FsQ/g3RuyxA4ypew82QgC7Z3VxRUw7+IZ2G0JUQNe2XDNyBKzzyQ+TRYN5D9lDbDDX2go78ut
 Fag4qsaLrdh5BllGjC8K0eHGvyOOy8TqxydGY66C7J1PIsB7+r/Rsqf0r8OPQzZIoCExysi5b
 w89hOvBDVll0gOEF+DqdD1W1zCydh02+pRI8Nttw7xLBjBPPmLVsW3V3dCvC6/SBZCdSAwUpe
 t1pbJDTHX6655699o2gWsU+Qkhp8qBjE0oILK4zom2iL6pBSFMP1nVWuE4aba6VvB5gAJ6sIf
 HpYTKbwQx6iyhkJRqc6255aORaH0hvrY5+RDTPyLwo8m+mZSnvTfzvsIGGBw0AKLWEsfe3YE0
 um2prOWlsiy4Mrxnn6I22CS/rboSikaoUjJfASisLxhULwiZ8u4g1O4vKYUSus3x9mH8C19rL
 clGK7WF1Pl4mkuWTv4rlq0AZod5ljkUe7/TomgUzRdcTb5ki9aXmFj4HH8kmCU1Q63WGdriP5
 5a1Cy0Fb95HVoAmmUezyfw4oPn6+NvoCM7gpvuRe3Lir+bHYQuq3ExpLvZyS8GSDWBgsYEtv3
 OT+bvAg11vM8zZuF/U7Wa1u9i2Ily/oyYePDNEtoyyhkFalPvSlT32M3PfLvbmCco+cPPiydn
 Eu4cJkVeX+kE8yPpNgwuPU6+QyGsC35aPvu+u7nuzRhR1lqQ+yJVWTbk6lKY8MN4I/jJGAhvy
 11njnT4wLgjrCDsrGOy5Fw2w==

On 13.09.2024 09.24, FUJITA Tomonori wrote:
> On Wed, 11 Sep 2024 21:30:54 +0200
> Hans-Frieder Vogt <hfdevel@gmx.net> wrote:
>
>> Prepare the tn40xx driver to load for Tehuti TN9510 cards
>> and set bit 3 in the TN40_REG_MDIO_CMD_STAT register, because otherwise=
 the
>> AQR105 PHY will not be found. The function of bit 3 is unclear, but may=
 have
>> something to do with the length of the preamble in MDIO communication.
>>
>> Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
>> ---
>>   drivers/net/ethernet/tehuti/tn40.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/tehuti/tn40.c b/drivers/net/ethernet/=
tehuti/tn40.c
>> index 259bdac24cf2..4e6f2f781ffc 100644
>> --- a/drivers/net/ethernet/tehuti/tn40.c
>> +++ b/drivers/net/ethernet/tehuti/tn40.c
>> @@ -1760,6 +1760,9 @@ static int tn40_probe(struct pci_dev *pdev, const=
 struct pci_device_id *ent)
>>   		goto err_unset_drvdata;
>>   	}
>>
>> +	/* essential for identification of some PHYs is bit 3 set */
>> +	ret =3D tn40_read_reg(priv, TN40_REG_MDIO_CMD_STAT);
>> +	tn40_write_reg(priv, TN40_REG_MDIO_CMD_STAT, ret | 0x8);
>>   	ret =3D tn40_mdiobus_init(priv);
> How about setting the speed of mdio 1MHZ by calling
> tn40_mdio_set_speed() like the vendor driver?
it is not about setting the speed here, but ensuring that bit 3 is set.
But I agree, with tn40_mdio_set_speed()
the intended effect is also achieved, and will make the code more readable=
.
And my fear to overwrite other bits in this register is also not
justified, because the initial
value of the register is consistently 0x3ec0.
>
> The following works for my TN9510 card.
>
> diff --git a/drivers/net/ethernet/tehuti/tn40_mdio.c b/drivers/net/ether=
net/tehuti/tn40_mdio.c
> index bbd95fabbea0..e8b8dea250f2 100644
> --- a/drivers/net/ethernet/tehuti/tn40_mdio.c
> +++ b/drivers/net/ethernet/tehuti/tn40_mdio.c
> @@ -183,6 +183,7 @@ int tn40_mdiobus_init(struct tn40_priv *priv)
>   			ret);
>   	}
>
> +	tn40_mdio_set_speed(priv, TN40_MDIO_SPEED_1MHZ);
>   	ret =3D devm_mdiobus_register(&pdev->dev, bus);
>   	if (ret) {
>   		dev_err(&pdev->dev, "failed to register mdiobus %d %u %u\n",
Yes, of course it can be moved here.
Will change it in the next version of the patch.

Thanks!
Hans

