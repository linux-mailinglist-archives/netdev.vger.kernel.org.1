Return-Path: <netdev+bounces-147534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC159DA114
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 04:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 256972818E8
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 03:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACBC42A9D;
	Wed, 27 Nov 2024 03:14:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A080C139D
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 03:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732677268; cv=none; b=fjBZmBHKYYdt/7HRkr0PvY5+YNCrCjHA6TJ+H5k46GVpZHEQx1BHgth9AWdmiGv6PJicsNnsbHwRyjo+oQrTi/2ptOoYPe5+d6D9qGPmSWFxNLmYqrzjRUY5lQB6rNWiS5T27x9TPALnmqVo9F+hYKNd9V6eHMOYRLr45i+EV2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732677268; c=relaxed/simple;
	bh=D68W2/mFJ5W3E1GKVPHSOoNpy+Ihcx9ZWcYPSO0aPzQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=a3Ar1q+BDXGFgvwawcGOSdunwRgOGHUWKR6ayOCSyJ9Jp+VtOizlgtKUSWmQkE6pKpoKcZEH+4ZjG1ODnRj+hUMnLYpeeeoBiXy6yMQnyQ3ATJwQIiJE7oZrrpDf/Upi38WwXxuHnEtzg+6R1rsN2ivsNFC4vD7Rtfq8gWWeO7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: abc2172eac6d11efa216b1d71e6e1362-20241127
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:48d106e8-f44b-4719-bc6c-3e658d708ee0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:40e9e96e57f7affb107b3b612ff67756,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM:-3,
	IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:
	0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: abc2172eac6d11efa216b1d71e6e1362-20241127
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <luoxuanqiang@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1785016247; Wed, 27 Nov 2024 11:14:10 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 49EC8B807587;
	Wed, 27 Nov 2024 11:14:10 +0800 (CST)
X-ns-mid: postfix-67468E82-213949681
Received: from [10.42.20.255] (unknown [10.42.20.255])
	by node2.com.cn (NSMail) with ESMTPA id 86ED6B807587;
	Wed, 27 Nov 2024 03:14:06 +0000 (UTC)
Message-ID: <71ae37d6-b5cf-d407-be4b-0c8b3c9f01d7@kylinos.cn>
Date: Wed, 27 Nov 2024 11:14:06 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] net: mdio: fix unbalanced fwnode reference count in
 mdio_device_release()
Content-Language: en-US
From: luoxuanqiang <luoxuanqiang@kylinos.cn>
To: Zeng Heng <zengheng4@huawei.com>, hkallweit1@gmail.com,
 edumazet@google.com, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com,
 linux@armlinux.org.uk
Cc: liwei391@huawei.com, netdev@vger.kernel.org
References: <20221203073441.3885317-1-zengheng4@huawei.com>
 <833ea8e7-f15b-ff66-84bf-2bcd77710fd8@kylinos.cn>
In-Reply-To: <833ea8e7-f15b-ff66-84bf-2bcd77710fd8@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Heng,

=E5=9C=A8 2024/11/22 15:59, luoxuanqiang =E5=86=99=E9=81=93:
> Hi Heng,
>
> =E5=9C=A8 2022/12/3 15:34, Zeng Heng =E5=86=99=E9=81=93:
>> There is warning report about of_node refcount leak
>> while probing mdio device:
>>
>> OF: ERROR: memory leak, expected refcount 1 instead of 2,
>> of_node_get()/of_node_put() unbalanced - destroy cset entry:
>> attach overlay node /spi/soc@0/mdio@710700c0/ethernet@4
>>
>> In of_mdiobus_register_device(), we increase fwnode refcount
>> by fwnode_handle_get() before associating the of_node with
>> mdio device, but it has never been decreased in normal path.
>> Since that, in mdio_device_release(), it needs to call
>> fwnode_handle_put() in addition instead of calling kfree()
>> directly.
>>
>> After above, just calling mdio_device_free() in the error handle
>> path of of_mdiobus_register_device() is enough to keep the
>> refcount balanced.
>>
>> Fixes: a9049e0c513c ("mdio: Add support for mdio drivers.")
>> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
>> Reviewed-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>> =C2=A0 changes in v2:
>> =C2=A0=C2=A0 - Add operation about setting device node as NULL-pointer=
.
>> =C2=A0=C2=A0=C2=A0=C2=A0 There is no practical changes.
>> =C2=A0=C2=A0 - Add reviewed-by tag.
>> ---
>> =C2=A0 drivers/net/mdio/of_mdio.c=C2=A0=C2=A0=C2=A0 | 3 ++-
>> =C2=A0 drivers/net/phy/mdio_device.c | 2 ++
>> =C2=A0 2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/mdio/of_mdio.c b/drivers/net/mdio/of_mdio.c
>> index 796e9c7857d0..510822d6d0d9 100644
>> --- a/drivers/net/mdio/of_mdio.c
>> +++ b/drivers/net/mdio/of_mdio.c
>> @@ -68,8 +68,9 @@ static int of_mdiobus_register_device(struct=20
>> mii_bus *mdio,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* All data is now stored in the mdiode=
v struct; register it. */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D mdio_device_register(mdiodev);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rc) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device_set_node(&mdiodev->=
dev, NULL);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fwnode_handle_put(fwnode);
> According to my understanding, the process flow of mdio_device_free() i=
s
> as follows:
> mdio_device_free()
> =C2=A0=C2=A0=C2=A0 -> put_device()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ->kobject_put()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ->ko=
bject_release()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ->device_release()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ->mdio_device_release()
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 //Here, it will be called once fwnode_handle_put()=
;
>
> Why is it necessary to add fwnode_handle_put(fwnode) again here? In the
> body of your email, you described that mdio_device_free() is sufficient
> to keep refcount balanced, and it was not added in the v1.
> Could you please explain the reason for this?
> I am looking forward to your response :)
>
> Thanks
> Xuanqiang
I noticed that I had missed the fact that you had already disconnected
the relationship between dev and node by calling
device_set_node(&mdiodev->dev, NULL). Even though it would go through
fwnode_handle_put() again, it would not have any effect.

Thanks
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mdio_device_fre=
e(mdiodev);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 of_node_put(child);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return rc;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 diff --git a/drivers/net/phy/mdio_device.c=20
>> b/drivers/net/phy/mdio_device.c
>> index 250742ffdfd9..044828d081d2 100644
>> --- a/drivers/net/phy/mdio_device.c
>> +++ b/drivers/net/phy/mdio_device.c
>> @@ -21,6 +21,7 @@
>> =C2=A0 #include <linux/slab.h>
>> =C2=A0 #include <linux/string.h>
>> =C2=A0 #include <linux/unistd.h>
>> +#include <linux/property.h>
>> =C2=A0 =C2=A0 void mdio_device_free(struct mdio_device *mdiodev)
>> =C2=A0 {
>> @@ -30,6 +31,7 @@ EXPORT_SYMBOL(mdio_device_free);
>> =C2=A0 =C2=A0 static void mdio_device_release(struct device *dev)
>> =C2=A0 {
>> +=C2=A0=C2=A0=C2=A0 fwnode_handle_put(dev->fwnode);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(to_mdio_device(dev));
>> =C2=A0 }
>

