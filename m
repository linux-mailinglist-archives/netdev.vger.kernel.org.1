Return-Path: <netdev+bounces-169155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33F2A42B2F
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 19:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662903B8862
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 18:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F462676EA;
	Mon, 24 Feb 2025 18:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="P4xwMRZx"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DDECA64;
	Mon, 24 Feb 2025 18:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740421353; cv=none; b=JVC8xAitD7zCQy/VeDEY5Sp3WsI0CZff1NGwYLK9DR1MrDuyy2BQXXoB402eKXOeCjlzcpiVxoab7LywyxwyAVuQqziyOOJ/28eGJo2NcpZrEyNEThVVqweVNoG1bLwZeaaTtBOP6w4kEuADNInpl3YoXcuOvAfynrH8C7TvAYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740421353; c=relaxed/simple;
	bh=lHMlBKWdkJyWJ/ZNdPbig2n/AkyDPvY7GCSxBIUEiPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BSJCIG/+9/PyCdMoliysBIQNg0D5mk1OQBzKPlj7Ywjvaao4VQmei0h3I1peKNH0NY+Qgx8HkeX9d1FkoZ4Xp5tgTDWCkZgEl+u9kE/ABTqklJQ4EimFrr3oHNyThfpOmtPUHT9A01bIcVFv8yexOe+ig3enko98IybIwPsFSU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=P4xwMRZx; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1740421348; x=1741026148; i=hfdevel@gmx.net;
	bh=s56f0o7oXiJ7g53XxI4zCe4QREjxnu0AzfGzWl/KBy8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=P4xwMRZxFl/i0cfVxDKoCDDYMEBSQofRCpiditFUo/nnI9qDGqroC+sAkb60cBOl
	 Aspf+LQ/s5l0vraKpipxWWalUQDL9YeJiZnuN1wk7m237wihfMmNhZ7IhpkdHHzJ3
	 P47grf9ObO6c7XmnFPufH0+idE6eBBau+YP2wE/0NAiYdCs1hVBZ8lYoKAcxOmyWd
	 r3OjjN2qRLpwcy5rwC5ruFZHgwFG2gll7qpL+pse5IsUzkvTE3+Z5mTpTXB7+ge5u
	 M1BO9NziQ3oeLbl9Au3Iz4st0EJCdWqhZZhc/01nsEAIS9QkdmfF9s/yBNrsZr9L6
	 DaKDIhyQnVYnpQNZ9A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.0.0.23] ([77.33.175.99]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3bWr-1tMwwf2kwl-015nKq; Mon, 24
 Feb 2025 19:11:42 +0100
Message-ID: <355d0805-61df-4834-a266-e74117e21302@gmx.net>
Date: Mon, 24 Feb 2025 19:11:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 5/7] net: tn40xx: create swnode for mdio and
 aqr105 phy and add to mdiobus
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250222-tn9510-v3a-v5-0-99365047e309@gmx.net>
 <20250222-tn9510-v3a-v5-5-99365047e309@gmx.net>
 <20250224040838.GA1655046@maili.marvell.com>
Content-Language: en-US
From: Hans-Frieder Vogt <hfdevel@gmx.net>
In-Reply-To: <20250224040838.GA1655046@maili.marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ee78AkA0+pD13CQ5EnSHbst9pHFtKJ3LOD+UBaP/M/x+o/fOqo5
 99jPSvi0WOR8WuZaL9U800rDZ2fGwwIizbfrnsUUahUpy/ZP8oMJpWu5BZJM3SacBGC+2xI
 /n4trkxwTjHMSAxeCMT5Ls/UPIQJygTVGij4a/lvQdrB1TZyDmoSZBeH0eDwmxF21xxk3M4
 2vFqcL2h7eKbJhJQ2oOyA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Z6qiYfGX9J8=;2e/eCYPQzvtB2PATz+zm4749US3
 JIArM80/lUKmmqyuNqC5skhqDJXS2LcO5LLsAi5+ZOA/7V8ASkY2mPh9hN2qzA9o720z0M+g4
 F40xm9A14jpLluZQF7HgtxDXY/Jr+BJ8e+nVmAnUf4pX8s7V2LZM88g4khXp7SU6hCVMzesrl
 qj/IIiXzPNt+J1Vc1nKCbogEBv1mvH9jbkHnAsQWiyjmBm/ZH+4V4b0uphwaHV0dNVi/KNFFR
 rDWVW5VQ/gseGrgTquyND7dvvkGZlarCWBitzofEw7vFknlNRlcoCKcQmquE0rogfQxziLaUi
 V8Kmfqf+RbiOZb7Nl3paG6uVpw/iRzx+O42Z/qKvuR4shIG/TuCrf66AKdUR8X4ks5DahkWwo
 stIEwNBIuowwwo3/G/dELTkyGhhbjcGUNhhH4woEIqAFSv5skVni0rYWtPjACN47PgMdVbJXG
 Z5jZ4BCzuJJQEZW8cVufKuko8PZY4MVTssLjFzE8x8LnbzxzpWR40FjG8P6B0/kR+zyol4lUk
 y7vkDL7XYSTWSqK6oBzYxbURIjE+jkVdol+TJwfYBH043cYqAT1eDxYaE70Yw1o/O4XL0AtIF
 9z1en9+Wl1pEYK9lj4PbrwHkOIIS6gU0n2h0y8GGvJcHcHsYLK0Lz7puosGqR8NPNcuaY2z0J
 OJF/AXGReB4W8RG2dwCJrdl3CY6Az+i8McIAmDbrJ+w7jhYDCEHQW3rvZhYpcGFZ6VdKhl6it
 LanHRBWimMZpsPlzTcAeU2rsDQeJnE/fcATTdN2b7ahKrGIEtx7xMJfTH4OuNgybt/7z0O6UC
 b+rPbx6eUEzfeW9DSUALyU8befnmOCfBEUKQXXT80KC9AQ0ZAtfzs6FeVgFl51V0bZS7bzesy
 zhuJxADlVsb3c7XL2IABPvPIuB/2dbkAxZRMR5eqgH/BQ5gAJTqzTASJVqf2I4YwD72MPSVRn
 RzNZalNMDaMHvGpF3FpoeMsxiHpNad3GocEnP/FKj1x+wqPtvCeNafDOJF/CP7qx3kOjPJShf
 T1MOjLl/orHyjGd5GILBIoTWz1PqWMa4V6Rks0jkdULnECYWiLFH7r+Ie2YMAUC2oTLfT1Ppy
 9Ddti/wXP93FrWTebdDnQA6kDXhz31ITmxpaVQ4TYDgokTx+H3wYqt70zUtgC2o9MwvAhStvt
 jJsrohKzUaLeCxbe6KdLXOCg1F3/7eBI301jd+1AF6+N+U5QxT7u2OWc0Cwoc/HYGH8oF3x5q
 9hOSWoz6jlW4VBuzwvQHQhkHJpQc0GU9kFTaXn8O8nFt/Bqrfor7t7JJ9FCqVmuEuvZS5rAzQ
 NHfa3xk1w87k4bVhFjqbGmfNWfgMlIBJX/BOeID9llkgf3H2idnmwDSOwQIVVY6xpWwYuMeBu
 7YdOQn8Gnyl47jI0j7aUXz56S+9DbUqT3qfxo=

Hi Kannoth,

On 24.02.2025 05.08, Ratheesh Kannoth wrote:
> On 2025-02-22 at 15:19:32, Hans-Frieder Vogt via B4 Relay (devnull+hfdev=
el.gmx.net@kernel.org) wrote:
>> From: Hans-Frieder Vogt <hfdevel@gmx.net>
>>   int tn40_mdiobus_init(struct tn40_priv *priv)
>>   {
>>   	struct pci_dev *pdev =3D priv->pdev;
>> @@ -129,14 +181,36 @@ int tn40_mdiobus_init(struct tn40_priv *priv)
>>
>>   	bus->read_c45 =3D tn40_mdio_read_c45;
>>   	bus->write_c45 =3D tn40_mdio_write_c45;
>> +	priv->mdio =3D bus;
>> +
>> +	/* provide swnodes for AQR105-based cards only */
>> +	if (pdev->device =3D=3D 0x4025) {
>> +		ret =3D tn40_swnodes_register(priv);
>> +		if (ret) {
>> +			pr_err("swnodes failed\n");
>> +			return ret;
>> +		}
>> +
>> +		ret =3D device_add_software_node(&bus->dev,
>> +					       priv->nodes.group[SWNODE_MDIO]);
>> +		if (ret) {
>> +			dev_err(&pdev->dev,
>> +				"device_add_software_node failed: %d\n", ret);
> No need to return on this error ?
Good catch. Yes, indeed, all TN4010-based cards that I know of need to
load the firmware from
the filesystem. And this will only work if the software node is
available to provide a file
name.
I'll add a
return ret;
in the next version.
>> +		}
>> +	}
>>
>>   	ret =3D devm_mdiobus_register(&pdev->dev, bus);
>>   	if (ret) {
>>   		dev_err(&pdev->dev, "failed to register mdiobus %d %u %u\n",
>>   			ret, bus->state, MDIOBUS_UNREGISTERED);
>> -		return ret;
>> +		goto err_swnodes_cleanup;
>>   	}
>>   	tn40_mdio_set_speed(priv, TN40_MDIO_SPEED_6MHZ);
>> -	priv->mdio =3D bus;
>>   	return 0;
>> +
>> +err_swnodes_cleanup:
> No need to call device_remove_software_node() ?
It is called from tn40_swnodes_cleanup.
>> +	tn40_swnodes_cleanup(priv);
>> +	return ret;
>>   }
>> +
>> +MODULE_FIRMWARE(AQR105_FIRMWARE);
>>
>> --
>> 2.47.2
>>
>>
Thanks,
Hans-Frieder

