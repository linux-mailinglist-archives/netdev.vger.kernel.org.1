Return-Path: <netdev+bounces-128306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68042978F14
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 10:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912FD1C21C92
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 08:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB7C1CFBC;
	Sat, 14 Sep 2024 08:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="GQ58o3mJ"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDBF4C8E
	for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 08:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726301953; cv=none; b=tDfzzVfX8a7a4S67TvOBEisiYtZsisW3TIwIHemYPHbliE0rmFOyhZBlYvGAetAfnJmJ3DHe3ipxsfX9qcz2nzFSkGHn0py3qaGgbNOoxhTCaAH5j4Ua+pVBR+3t+1KpjoULY+fAYT6LrFw7BsUOQDsqMzzNirUwpy02o+1czyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726301953; c=relaxed/simple;
	bh=1bP9+MIWc92eTXTObR99EqHPfYmiujqaz9ZsO+7UcVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OA8L497DtFoSsmXqi3dVvt7ndW3z3Utin5cBKw9R6he2vbV1juVEvHEzibHvM93c7CekoSw51fJBtpqqgxV0tvEUEjeZC8rRWhvSLb5/u+5oeTXOZ3N6J3rc7v7S2bcHTGw/UNSyhJXThXhT0lacVQ0+sFPz36nHtzFOpTpw9Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=GQ58o3mJ; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1726301932; x=1726906732; i=hfdevel@gmx.net;
	bh=iAI0vd8RTD2LX8cpLad0PyYjvyTDzo6yk2IK74Epkz0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GQ58o3mJA8ZHCI8ooYBid+4Re2WpbcHizN2bEqrkWVC0aKXDETcQRvjNWkq4COBc
	 sVJSoNFFjCr8X5H4PYHEP2eB9LlHR/qP8KHik5joQiX7dSfrzAi/VysAoAYVAtM+N
	 XgSunjVumJ79oO+8jpnkiIlEq8NgPV+41+UoTQzwVnj+hDqW8kV4K4ogwkeBIHsDo
	 a52c2PxxKWvx8Cj1UtjcgQqMnpZEEXqrznkgs/Mp3gv0JuZW0gmAg6IWgbjbe2QEI
	 XfSRrYATzHiDPUIiOfwItRLUs9YbIM+vt7P/T0CAebtCiF15KxGt9wM1ux6Dp+0TE
	 c21HMCvNTV2Gy4znSQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.0.0.23] ([77.33.175.99]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWzfl-1sVIvt0uq1-00NKLP; Sat, 14
 Sep 2024 10:18:52 +0200
Message-ID: <877bd82d-2333-44a8-aedc-1a6a8fe2cb44@gmx.net>
Date: Sat, 14 Sep 2024 10:18:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/5] net: tn40xx: register swnode and connect it
 to the mdiobus
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
References: <trinity-e71bfb76-697e-4f08-a106-40cb6672054f-1726083287252@3c-app-gmx-bs04>
 <20240913.065543.2091600194424222387.fujita.tomonori@gmail.com>
Content-Language: en-US
From: Hans-Frieder Vogt <hfdevel@gmx.net>
In-Reply-To: <20240913.065543.2091600194424222387.fujita.tomonori@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HAehlN5yQPHMSJdtWgCgNWS0g7A2WAYuYmIgcQkfavAiHFwOS2Q
 bpCWcPkCr4efhR1kCBYrLdGBFLwX63xWSeIgw0ARmRcnd5kxWakWXFSOywEEMQsmS+UClel
 hwA5cR/QBavrYB5eicdDo6m4NlqRmHlplu/Fm2SFIw1tQw347R6cSAj7VENm104BdjlWSYL
 2HUGNHPiMgjV4EUMLQQ5w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LJwXH+McxAg=;MhBU4y1tw3wq9sApw00AYxuhDaS
 XSjqTEljjvQv9hUEQCjxVsoa7zJMqXtJNHbClv/Df3xah66NAc9dyU33DaOsjdUju+rW8HHKK
 oG6TyaXtx6L9vaEyO/g1qI1kvtHBsvzazrVoowxAR8Z7A3WA+X84XakQ99RimZlzkj8sV1iAV
 rfHu6xU5OVpX58hboiQWpUgcL2MJaLlnuSTJnuseUc/rINSOR7E8Ag5usuZNuv5R/djmzh4Yd
 GSrk5XF6PfZfCTqnr9j2P+9FRKO6a2mB9d3+W7f8bg2faMAIQ1mTBHI3CgnQdAy72gNSSOqqB
 23zYKxG9Cm/pgd0jF8OYl3yMH6iNWZH4DqBrMuLavM28kddDu61dhx3liUeY8bqeU1Mwe2psI
 QqMHrTIii5PGByDyg3WQWpygmOazFKQ5xxhLXhv0lMg+yKAZ1LPnG+fgwYJAzeZykZ0XLJK2N
 rPXDYN4QY06U0Lw+jyEO1sGqYAPKbhBZ5113h6K7mZp4fR9KSAm9/LA7zXDKH64Sws7wmTwZW
 1ormC9XGKQ7UkB+NX7LGhnElI9dKCVk3vSMBrgd/axFvBTe+R/JpQ7klZWZCCDXfI8Gw5QCIV
 a3LQOAJ8evLVG8/Sc6JR+6nAlxAn3kNFcB1sKI8GkwMRUSaaA6MxrwyrUMfuxNXBgEIPLLwyS
 M2tk36AljpcPZ85EyEJ1wJcmixiFpkoAMScdBj2hu+aNtIpBYyyvTA8wns1RlSKg9n3rtYCTx
 +rZ5/pQxUcdTx2xT+gyQfFXicMcs17XNzgMD97nANP37l4x93Pp5ucYHL5oi49jjPcl0p+kM+
 OTFJQOFX5xTH/WpZIZ5RVDjg==

On 13.09.2024 08.55, FUJITA Tomonori wrote:
> Hi,
> Thanks a lot for the work!
Thank you! You did the biggest part of bringing tn40xx into mainline!
>
> On Wed, 11 Sep 2024 21:34:47 +0200
> Hans-Frieder Vogt <hfdevel@gmx.net> wrote:
>
>> diff --git a/drivers/net/ethernet/tehuti/tn40.c b/drivers/net/ethernet/=
tehuti/tn40.c
>> index 4e6f2f781ffc..240a79a08d58 100644
>> --- a/drivers/net/ethernet/tehuti/tn40.c
>> +++ b/drivers/net/ethernet/tehuti/tn40.c
>> @@ -1781,7 +1781,7 @@ static int tn40_probe(struct pci_dev *pdev, const=
 struct pci_device_id *ent)
>>   	ret =3D tn40_phy_register(priv);
>>   	if (ret) {
>>   		dev_err(&pdev->dev, "failed to set up PHY.\n");
>> -		goto err_free_irq;
>> +		goto err_unregister_swnodes;
>>   	}
>>
>>   	ret =3D tn40_priv_init(priv);
>> @@ -1798,6 +1798,10 @@ static int tn40_probe(struct pci_dev *pdev, cons=
t struct pci_device_id *ent)
>>   	return 0;
>>   err_unregister_phydev:
>>   	tn40_phy_unregister(priv);
>> +err_unregister_swnodes:
>> +	device_remove_software_node(&priv->mdio->dev);
>> +	software_node_unregister_node_group(priv->nodes.group);
>> +	software_node_unregister(priv->nodes.group[SWNODE_MDIO]);
> Why this workaround is necessary? The problem lies on software node
> side?
I don't understand it either. Need to further dig into, where the usage
counters are incremented and how
to get them decremented again.
>
>> diff --git a/drivers/net/ethernet/tehuti/tn40_mdio.c b/drivers/net/ethe=
rnet/tehuti/tn40_mdio.c
>> index af18615d64a8..bbd95fabbea0 100644
>> --- a/drivers/net/ethernet/tehuti/tn40_mdio.c
>> +++ b/drivers/net/ethernet/tehuti/tn40_mdio.c
>> @@ -14,6 +14,8 @@
>>   	 (FIELD_PREP(TN40_MDIO_PRTAD_MASK, (port))))
>>   #define TN40_MDIO_CMD_READ BIT(15)
>>
>> +#define AQR105_FIRMWARE "tehuti/aqr105-tn40xx.cld"
> This firmware is for AQR PHY so aquantia directory is the better
> place?
this has been addressed by Andrew already.
>
>> +static int tn40_swnodes_register(struct tn40_priv *priv)
>> +{
>> +	struct tn40_nodes *nodes =3D &priv->nodes;
>> +	struct pci_dev *pdev =3D priv->pdev;
>> +	struct software_node *swnodes;
>> +	u32 id;
>> +
>> +	id =3D pci_dev_id(pdev);
>> +
>> +	snprintf(nodes->phy_name, sizeof(nodes->phy_name), "tn40_aqr105_phy")=
;
> This doesn't work on a system having multiple TN40 cards because it
> tries create duplicated sysfs directory.
>
> I uses a machine with TN9310 (QT2025 PHY) and TN9510 (AQR105 PHY).
Thanks, I didn't think of this problem. I have a solution though, and
will correct it in the
next version of the patch.
>
>> +MODULE_FIRMWARE(AQR105_FIRMWARE);
> AQR PHY driver better to have the above? Otherwise, how about adding
> it to tn40.c? It already has MODULE_FIRMWARE(TN40_FIRMWARE_NAME).
I understand your rationale, but moving MODULE_FIRMWARE to tn40.c would
require moving the definition
of AQR105_FIRMWARE to tn40.h. And I would prefer to keep definitions as
local as possible.

Thanks!
Hans

