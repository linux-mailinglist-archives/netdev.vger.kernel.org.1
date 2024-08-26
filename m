Return-Path: <netdev+bounces-122002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CE395F889
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 19:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 424351F23949
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 17:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111D6197A96;
	Mon, 26 Aug 2024 17:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="hEBFgyZY"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861C419580A
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 17:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724694600; cv=none; b=anpBRyCmhV6WbISfYOiSv5aMje1BrRRxMg3DwIl1+M2W99U5OLgY1viy1SfAbTuyJP2Grk5+3wCka5Tys4KAaWIw3ESgzmNSb/bgsvxhHjt3inTiY2XQ+oYu/SYsuwUMXtFaVrDOetCQum8YKvGVsWbiOO1lCVszMr6wbtwyqTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724694600; c=relaxed/simple;
	bh=jHExYjSVMZZOn0ZA4DecqjGkw9lzA2XXCxBk9eTvffI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G7P9kugF8VBRVQdP2/+3uZxpp5BWWuKnBnKNarbcAxSe2G8TYM5JR5PfVuzOE4eLVEB9Stb35dICxl25kjFLGU/FIHZYT89tsv5UWvJEEomM6cnCJhjNWfWYEY2oNUthCj+mWKTxHE5Hy+4vdAPVrSNaPKTbJ3T5zF0Tz7BifTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=hEBFgyZY; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1724694590; x=1725299390; i=hfdevel@gmx.net;
	bh=WRtgPDZy0BtdRPFP1Kx3UFHt0ISmkmGxz1Uvbne5owc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hEBFgyZYobg7aY415DYc/qYXJmAvz8uL8LiNtWE2rk2X5R0ipjjA2EAV98xDGI5C
	 Osbo3EOG8LGQVlhq8aMd7dk7TSGrRPOlxVf7EJdDpUJcpVPG052AoEqD/jwPMC7zQ
	 zvXQdKBZS4gTTAXQntoegLliGMDL3HEDOpFy7kiSd7UPzmZnpXv4CKZEmmcAI9un+
	 hXj2y2iZexIbdT2qKV190OdVQKHwRr7kXUlyWI+zPxy29fshExncNlKF/DdvFPAPo
	 QEDsRU9vEFj6Q7+hsmnvMs3iQi1xfyFT81Ngxac6OeigV6YTOpgoSXbZFP0IhxiWY
	 ZgITpU8gBFNhmCRWPw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.0.0.23] ([77.33.175.99]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLiCo-1sQyTO1zou-00OMVP; Mon, 26
 Aug 2024 19:49:50 +0200
Message-ID: <58560556-c288-4ea7-bea9-7e9083628dbf@gmx.net>
Date: Mon, 26 Aug 2024 19:49:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: phy: aquantia: create firmware name for
 aqr PHYs at runtime
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>
References: <trinity-916ed524-e8a5-4534-b059-3ed707ec3881-1724520847823@3c-app-gmx-bs42>
 <d0a46a2a-af5c-4616-a092-a9b65a1e15e2@lunn.ch>
Content-Language: en-US
From: Hans-Frieder Vogt <hfdevel@gmx.net>
In-Reply-To: <d0a46a2a-af5c-4616-a092-a9b65a1e15e2@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sBBr1yLPnf68SBKfgH/aSWSpvTB1L4vmnKqiHSlfMZAuByKvJNM
 TWJo+GElRfqzAeTolyLPh7rq0deTzxqAzAOJmE8o9G7xagEWgDnQLdlzJXbf4kpqH5VRSM7
 pJZUdj3sOsJp7mCAQmIWujNNx+YxOyqwcKesp74Tw3jjB447pZKLwOAJovbFMTFJBEe/PGH
 TQA6w85pZcy4fev6tm5AQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bzbMXa0yCD4=;n0uJFBZBPsdKmfG7oU3ocd03EF+
 89OqsCsIdo5suereNfTrXQ3k8oS4EVIZlanB7mDSGc8Kj+4RKGBObutXRZMi+gjZmqWFH0S/m
 JEFUtd4Ebr6YItlDtjzr4BTyGYE5CY2BCgk+eJzpy2QNc9wdcnoB3qGzIpXeMX7oTU+EgfLcU
 fdlrBwnvjQuKch+LotubQhIQIQmB339WtWayfa6MrNbI4cgj6IU3vXKMR2sK45jHzxu39MBHK
 59VXNmaKEhOMVh/C9KM0ZSqdQrulTiGKF9LAeMiuVYPilUpTkk39K7fkTjFNbZEaennMJIFmD
 pF3ku8xgcEATG7Ccry3XcCmXEExNFihUOrgo7rMkFP1BmM3pLI9Lk2wYx5F0Mu8dT4OUSOoNW
 nWhxM9jJfiwhkPcpKBLCIqzATqM7nFpqLdr8kp2rFMrHgq7BL1uqox35xJ+UOVDCYi+LHusb6
 cN8iQ4DJGSY8ZsW0tGcgW2hwgP3mzpcGmVkHN861u6Yk+pBosQ70ylbWlQmtfdRKp6WJCQA4H
 OSy/US+8MHdUPndUo16fx01a/1abvZQz+SQm/lFD3SQ5FC7K1zY7yyc5IOw9prnDf+dE6e4XU
 ZcBPZE5K74WA0/gKpx2rM/sgwyy1WEFCCI3xZueH/gm1njoAT83bi+ZUxwichH+Y1eUjAaNKe
 VefsBBe4TFUMO0qZEEVE/YNIU+78W7pCUaB3vs2fR8JRAqmkD4qMguFlPzRf/1eBy2wghjGJ9
 ehZBFLj0MxWQvxkPdKcDYo9dU2Sw2p4z/mvW8/8AizxHN8LXclqWoRvLl+dPfEV24/sW1oC/S
 3wMIh2VaI9x56UFaBbOJowQg==

On 26.08.2024 03.17, Andrew Lunn wrote:
>> +/* derive the filename of the firmware file from the PHY and the MDIO =
names
>> + * Parts of filename:
>> + *   mdio/phy-mdio_suffix
>> + *    1    2   3    4
>> + * allow name components 1 (=3D 3) and 2 to have same maximum length
>> + */
>> +static int aqr_firmware_name(struct phy_device *phydev, const char **n=
ame)
>> +{
>> +#define AQUANTIA_FW_SUFFIX "_fw.cld"
>> +#define AQUANTIA_NAME "Aquantia "
>> +/* including the trailing zero */
>> +#define FIRMWARE_NAME_SIZE 64
>> +/* length of the name components 1, 2, 3 without the trailing zero */
>> +#define NAME_PART_SIZE ((FIRMWARE_NAME_SIZE - sizeof(AQUANTIA_FW_SUFFI=
X) - 2) / 3)
>> +	ssize_t len, mac_len;
>> +	char *fw_name;
>> +	int i, j;
>> +
>> +	/* sanity check: the phydev drv name needs to start with AQUANTIA_NAM=
E */
>> +	if (strncmp(AQUANTIA_NAME, phydev->drv->name, strlen(AQUANTIA_NAME)))
>> +		return -EINVAL;
>> +
>> +	/* sanity check: the phydev drv name may not be longer than NAME_PART=
_SIZE */
>> +	if (strlen(phydev->drv->name) - strlen(AQUANTIA_NAME) > NAME_PART_SIZ=
E)
>> +		return -E2BIG;
>> +
>> +	/* sanity check: the MDIO name must not be empty */
>> +	if (!phydev->mdio.bus->id[0])
>> +		return -EINVAL;
> I'm not sure how well that is going to work. It was never intended to
> be used like this, so the names are not going to be as nice as your
> example.
>
> apm/xgene-v2/mdio.c:	snprintf(mdio_bus->id, MII_BUS_ID_SIZE, "%s-mii", d=
ev_name(dev));
> apm/xgene/xgene_enet_hw.c:	snprintf(mdio_bus->id, MII_BUS_ID_SIZE, "%s-%=
s", "xgene-mii",
> hisilicon/hix5hd2_gmac.c:	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-mii", d=
ev_name(&pdev->dev));
> intel/ixgbe/ixgbe_phy.c:	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-mdio-%s"=
, ixgbe_driver_name,
>
> I expect some of these IDs contain more than the MAC, eg. include the
> PCI slot information, or physical address of the device. Some might
> indicate the name of the MDIO controller, not the MAC.
>
> Aquantia PHYs firmware is not nice. It contains more than firmware. I
> think it has SERDES eye information. It also contain a section which
> sets the reset values of various registers. It could well be, if you
> have a board with two MACs and two PHYs, each needs it own firmware,
> because it needs different eye information. So what you propose works
> for your limited use case, but i don't think it is a general solution.
>
> Device tree works, because you can specific a specific filename per
> PHY. I think you need a similar solution. Please look at how txgbe
> uses swnodes. See if you can populate the firmware-name node from the
> MAC driver. That should be a generic solution.
>
> 	Andrew
Thanks Andrew!
I have checked many cases, but obviously haven't considered enough the
multiplicity of network device topologies.
Thanks very much for the hint with the txgbe driver. I will study it and
come
back with hopefully a generic approach.

 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Hans

