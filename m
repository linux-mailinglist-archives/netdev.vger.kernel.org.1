Return-Path: <netdev+bounces-146769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE069D5A82
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 08:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60DD02829F6
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 07:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C608E17B4E1;
	Fri, 22 Nov 2024 07:59:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC64166F26
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 07:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732262369; cv=none; b=PaB6gtQN/xEGib+VtcgcgKcNdhp7yHo7ZA3O2dOQyM6DQ06NLMuAKaxC0rsv7axicuvCSlgs6Sw3njsmvrko26pl+4dt6HGM2vbs9QMNVQwOjwLcJbvWLJjjoRqmqA2Y41LMOnbFbJSzZj7+76j9dj6QdMKUOfh8Sv0GbPo64I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732262369; c=relaxed/simple;
	bh=ua4WWXrbFmKwDf0c9+PM4R4TLQFOmCnKY7Grbp6lZt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sMZO114k465kxvHunqTEAEbhY2+yGlZR9zeRL7ZOJNybYvdRtYXIpkI0WUd2H+C16IwfYMhnNITJl89e/UPzYMGtLOxsMfbIpTFCh4bAx7Bl6ufv+WUHnXHKz7d7a0X7uIREKClEBskIUil6ZkqnaQFIXZidFv6IEJ3JkoYWTow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a97ef06ea8a711efa216b1d71e6e1362-20241122
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:e4b70828-f217-4a76-a0bb-d5081ef3d62e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:9d575819d1210145532e6e92a005ebd7,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM:-3,
	IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:
	0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a97ef06ea8a711efa216b1d71e6e1362-20241122
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <luoxuanqiang@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 7202630; Fri, 22 Nov 2024 15:59:12 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 9ECEFB80758A;
	Fri, 22 Nov 2024 15:59:12 +0800 (CST)
X-ns-mid: postfix-674039D0-5586047365
Received: from [10.42.20.255] (unknown [10.42.20.255])
	by node2.com.cn (NSMail) with ESMTPA id BAF74B80758A;
	Fri, 22 Nov 2024 07:59:08 +0000 (UTC)
Message-ID: <833ea8e7-f15b-ff66-84bf-2bcd77710fd8@kylinos.cn>
Date: Fri, 22 Nov 2024 15:59:08 +0800
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
To: Zeng Heng <zengheng4@huawei.com>, hkallweit1@gmail.com,
 edumazet@google.com, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com,
 linux@armlinux.org.uk
Cc: liwei391@huawei.com, netdev@vger.kernel.org
References: <20221203073441.3885317-1-zengheng4@huawei.com>
From: luoxuanqiang <luoxuanqiang@kylinos.cn>
In-Reply-To: <20221203073441.3885317-1-zengheng4@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Heng,

=E5=9C=A8 2022/12/3 15:34, Zeng Heng =E5=86=99=E9=81=93:
> There is warning report about of_node refcount leak
> while probing mdio device:
>
> OF: ERROR: memory leak, expected refcount 1 instead of 2,
> of_node_get()/of_node_put() unbalanced - destroy cset entry:
> attach overlay node /spi/soc@0/mdio@710700c0/ethernet@4
>
> In of_mdiobus_register_device(), we increase fwnode refcount
> by fwnode_handle_get() before associating the of_node with
> mdio device, but it has never been decreased in normal path.
> Since that, in mdio_device_release(), it needs to call
> fwnode_handle_put() in addition instead of calling kfree()
> directly.
>
> After above, just calling mdio_device_free() in the error handle
> path of of_mdiobus_register_device() is enough to keep the
> refcount balanced.
>
> Fixes: a9049e0c513c ("mdio: Add support for mdio drivers.")
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> Reviewed-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>   changes in v2:
>    - Add operation about setting device node as NULL-pointer.
>      There is no practical changes.
>    - Add reviewed-by tag.
> ---
>   drivers/net/mdio/of_mdio.c    | 3 ++-
>   drivers/net/phy/mdio_device.c | 2 ++
>   2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/mdio/of_mdio.c b/drivers/net/mdio/of_mdio.c
> index 796e9c7857d0..510822d6d0d9 100644
> --- a/drivers/net/mdio/of_mdio.c
> +++ b/drivers/net/mdio/of_mdio.c
> @@ -68,8 +68,9 @@ static int of_mdiobus_register_device(struct mii_bus =
*mdio,
>   	/* All data is now stored in the mdiodev struct; register it. */
>   	rc =3D mdio_device_register(mdiodev);
>   	if (rc) {
> +		device_set_node(&mdiodev->dev, NULL);
> +		fwnode_handle_put(fwnode);
According to my understanding, the process flow of mdio_device_free() is
as follows:
mdio_device_free()
 =C2=A0=C2=A0=C2=A0 -> put_device()
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ->kobject_put()
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ->kob=
ject_release()
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ->device_release()
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ->mdio_device_release()
 =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 //Here, it will be called once fwnode_handle_put()=
;

Why is it necessary to add fwnode_handle_put(fwnode) again here? In the
body of your email, you described that mdio_device_free() is sufficient
to keep refcount balanced, and it was not added in the v1.
Could you please explain the reason for this?
I am looking forward to your response :)

Thanks
Xuanqiang
>   		mdio_device_free(mdiodev);
> -		of_node_put(child);
>   		return rc;
>   	}
>  =20
> diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_devic=
e.c
> index 250742ffdfd9..044828d081d2 100644
> --- a/drivers/net/phy/mdio_device.c
> +++ b/drivers/net/phy/mdio_device.c
> @@ -21,6 +21,7 @@
>   #include <linux/slab.h>
>   #include <linux/string.h>
>   #include <linux/unistd.h>
> +#include <linux/property.h>
>  =20
>   void mdio_device_free(struct mdio_device *mdiodev)
>   {
> @@ -30,6 +31,7 @@ EXPORT_SYMBOL(mdio_device_free);
>  =20
>   static void mdio_device_release(struct device *dev)
>   {
> +	fwnode_handle_put(dev->fwnode);
>   	kfree(to_mdio_device(dev));
>   }
>  =20

