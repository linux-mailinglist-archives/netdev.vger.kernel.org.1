Return-Path: <netdev+bounces-127919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 139BC9770EB
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 20:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B09F41F235B6
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 18:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026441BE84B;
	Thu, 12 Sep 2024 18:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="KscQHJxl"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D45318734F
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 18:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726166941; cv=none; b=IqQvPpFp1E7kxpnLkB9+eA1aYMpfySSqs+/+WDXc5Q4ZPVsv3Rg5pEpvGd7S44yqP60bMHHga3Hp5ktL/tT7bgr63MK74t/nm0sWh8BVNFe8bsSLqQkmYh9QHzDHv4QzsFG6d3oWVf7VGB9WHJx9TnPfG63woGcBv4SPEZqPNSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726166941; c=relaxed/simple;
	bh=TYKbecTZ3heOcpKGzkQvLQDo+vgOZssFb9F5U2y8+us=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pBsBPDDMnK93U2oVaIsBxf6LN3F8CKvrJF++UJA6n3Pd45Rgv+VKJGInPSQjlt/uH/0NG71P8PZiNhyAQFXWR6x8pFqYjRbYnFGLIfxtgIriGTYRbRv9tQsp5jDEOv8TNGGSxCVzkDSGPNgM3lRdbREZVgm8ad/kka/1ent1DyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=KscQHJxl; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1726166920; x=1726771720; i=hfdevel@gmx.net;
	bh=ztOjVl+hR09vVB2E6h1XzwMPf5KnpLGLgHpggR9pwyg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KscQHJxlyfRGH/VBNZwWzklH/pN52MkbkppE77RCE722y1qR9ZPWQmaXNMcJY2yZ
	 pOSJov95T6Eh/rKtlzYJhCbs9Qct987Gg3s/Hpc8yH+zqZZT/h/oNsQE3FiMNQ481
	 ThdcDba9o/Z8IVvsUvSDdLb/VUPaTu8rhpLssCTJ3+OQg9cccoz/eX7U5zI9ygjys
	 LUXwDVmdTxbBOKTetAc92A56ERNsQczlJ+TopKWpwdm8Osr0jLxioO8O49d6ygBZ/
	 Kw6P/hrGCTPq6l3rmw+eSNPw/FzOb5yKJ/4l2QI5gxkSr+lgkzpdjN7TWpL1RqbYA
	 i9ag8DFGR7MepGYw9w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.0.0.23] ([77.33.175.99]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRmfi-1sQ71Z45hC-00TBbS; Thu, 12
 Sep 2024 20:48:40 +0200
Message-ID: <1ebc6d0d-6eca-4c99-be1a-3fbfa524ac71@gmx.net>
Date: Thu, 12 Sep 2024 20:48:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/5] net: phy: aquantia: search for firmware-name
 in fwnode
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <trinity-da86cb70-f227-403a-be94-6e6a3fd0a0ca-1726082854312@3c-app-gmx-bs04>
 <0f811481-0976-4aec-a000-417d8b0a2a98@lunn.ch>
Content-Language: en-US
From: Hans-Frieder Vogt <hfdevel@gmx.net>
In-Reply-To: <0f811481-0976-4aec-a000-417d8b0a2a98@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8rz3dbuGI/mu0SfrAApWA8VR96/FXdnNnViZ8TtwY9XiWibiyYP
 fmCeGP8omuQ/IAduSbgRhhZKeufKXgZK3TssNqH6QPrxaPJIFzUp1Hz8JLNxxzNFh8Ljh/q
 iWDVooB2rTcyjrm45Az4YvxZ86R9ZtQYMUUSpY27zhpTZ+mLa0cYrUyh+JO5sve2fowHqOC
 AAo5QAP/uHkTyt6tXdpPg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ODa08X0tQ6s=;RQt42ron5SQtbe9xwD31q+xLEod
 Bl181qOOJ7+ubSdqKe9ItvbJIxF3ugXbFXqJjKGn8Nbvw/bXDKh+k3UYwUhlSx9C+Ie9nCyPN
 HKn4qbQ2D4ORKFhD2u8lzwHYE1R/+0vkPUpghq098JkQmtHTuDCa46a7vjv18IOQknv22+yUH
 fGFFS7dz9TXciUwALbDU0wc6WsyZeJ6kXqpHtxB1FoctTHXDZ9tnfX9YmqxvDM8aE9EExeii/
 wMGGo7iWAWX07Su5UgEmLAk/XX+sLuHJ9fAyzqMUNzKEytVLL9sKZfw+sZqhfu3DxlUsqm5LT
 ttwgotWeWyuQG2dTr0Y4ITBfs58QeOC8I893CZl2wIppyOjZW1jyidHyRAvC0U4TKXf0pO9w0
 z21xOGcYaFMmF8HxlVtZAm3K4IkMkdnyR41HO0JMGzFFFF3m1aQyUjb8SgX44jSeBOT2RznJE
 slRdCWoNqNYFebskouLzf2rfzfxP12zsW3JjWui346EXGimP/xK6NiSu6ZwcY30/AvbDbOz4E
 A2wWl++dATpwwECmhQRJVE/bFQ7FrNylQdt4Tl9thyjb1pUd/eppzU4LMm0b9mfPDIXjDJxwC
 k8J3ncgcEV04FG17dly4ls36MZcT6HwQtWGWBb2jYp/91qCjo2f4jN2Pb+T1NHQuY+EemA4gE
 KptEaNCOnUznQ0sUyOxZ7Ao3ga6UAy38aLH0fpic7r3DTtK5b4Iw8pbZfU36c3KsppX/TneVW
 KRgGUz0ZjUNmp5DCZIJnTub0mEksNpIx2R0m6F5ZVhE/pKCblzpDnmKAL2IdoHOUMi9qcOlZh
 hmZVmKgZRycPRsdhnhmgyBIQ==

On 11.09.2024 22.58, Andrew Lunn wrote:
> On Wed, Sep 11, 2024 at 09:27:34PM +0200, Hans-Frieder Vogt wrote:
>> For loading of a firmware file over the filesystem, and
>> if the system is non-device-tree, try finding firmware-name from the so=
ftware
>> node (or: fwnode) of the mdio device. This software node may have been
>> provided by the MAC or MDIO driver.
>>
>> Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
>> ---
>>   drivers/net/phy/aquantia/aquantia_firmware.c | 25 +++++++++++++++++++=
-
>>   1 file changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/phy/aquantia/aquantia_firmware.c b/drivers/net=
/phy/aquantia/aquantia_firmware.c
>> index 090fcc9a3413..f6154f815d72 100644
>> --- a/drivers/net/phy/aquantia/aquantia_firmware.c
>> +++ b/drivers/net/phy/aquantia/aquantia_firmware.c
>> @@ -324,14 +324,37 @@ static int aqr_firmware_load_nvmem(struct phy_dev=
ice *phydev)
>>   static int aqr_firmware_load_fs(struct phy_device *phydev)
>>   {
>>   	struct device *dev =3D &phydev->mdio.dev;
>> +	struct fwnode_handle *fw_node;
>>   	const struct firmware *fw;
>>   	const char *fw_name;
>> +	u32 phy_id;
>>   	int ret;
>>
>>   	ret =3D of_property_read_string(dev->of_node, "firmware-name",
>>   				      &fw_name);
> Did you try just replacing this with:
>
>      	ret =3D device_property_read_string(dev, "firmware-name", &fw_name=
);
>
> As far as i understand, the device_property_ functions will look
> around in OF, ACPI and swnode to find the given property. As long as
> the MAC driver puts the property in the right place, i _think_ this
> will just work.
>
> 	Andrew
device_property_read_string() would would be very elegant, but it only
looks for properties in the swnode of this device.
However, I did not find a way to add a swnode directly to the phy, but
only to the mdiobus.
I could have added the firmware-name directly to the swnode of the
mdiobus of course, then
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ret =3D device_property_read_string=
(dev->parent, "firmware-name",
&fw_name);
would have succeeded.
But adding a "firmware-name" property to an mdiobus seemed not sensible
to me.

Did I maybe overlook a clever way to directly add a swnode to the
phy_device?
I'll certainly investigate this another time.
Thanks!

 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Hans


