Return-Path: <netdev+bounces-85474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1287A89AE03
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 04:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 390B5B22B89
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 02:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A601EDC;
	Sun,  7 Apr 2024 02:12:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046CE1849;
	Sun,  7 Apr 2024 02:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712455935; cv=none; b=F2wxLAjYW6J0Zoeu0Qe9IlKQq6wdIcZ+JxroOIH13aexe/TjgY5kcePf/kd0Lc8ZOLPUHFj9kARb2Btv1nxfVFdgkVO/Yv1nGc1avMibCjLJNyMV/989Yu+QF0wnzFxeRRcOo23ilcrKIbw8/cV+SqLFxTi0R/BKozfRxq9qoZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712455935; c=relaxed/simple;
	bh=71RVXQgx/EzQHXWmMSI0tWquMHamfIoAHlsjnAZvuFI=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UMrQ24XDyGr1kS67s2YTMW+pGHBDWwCl8CeWFom5ziSu6G+oZ61APwGdYo9Mlm0bdfBvRfQJi58gfV/rDQvyT8F2cjCV4DRbAU+HDs8/AjOG7m3gpVpU/CWU2Ywc9sohGm2iXhWht0ncm521x+FK2kuolrbPBuSI1KFZFEIwJgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VBwdc5Xwsz1QCRX;
	Sun,  7 Apr 2024 10:09:24 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (unknown [7.193.23.54])
	by mail.maildlp.com (Postfix) with ESMTPS id A749B140154;
	Sun,  7 Apr 2024 10:12:03 +0800 (CST)
Received: from [10.67.111.5] (10.67.111.5) by kwepemm600014.china.huawei.com
 (7.193.23.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 7 Apr
 2024 10:12:03 +0800
Subject: Re: [PATCH -next] net: usb: asix: Add check for usbnet_get_endpoints
To: Simon Horman <horms@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>,
	<wangweiyang2@huawei.com>
References: <20240402113048.873130-1-yiyang13@huawei.com>
 <20240403105329.GV26556@kernel.org>
From: "yiyang (D)" <yiyang13@huawei.com>
Message-ID: <16281533-d768-1523-467a-4408916e6067@huawei.com>
Date: Sun, 7 Apr 2024 10:11:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240403105329.GV26556@kernel.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600014.china.huawei.com (7.193.23.54)

On 2024/4/3 18:53, Simon Horman wrote:
> On Tue, Apr 02, 2024 at 11:30:48AM +0000, Yi Yang wrote:
>> Add check for usbnet_get_endpoints() and return the error if it fails
>> in order to transfer the error.
>>
>> Signed-off-by: Yi Yang <yiyang13@huawei.com>
> 
> Hi,
> 
> I am wondering if this is a fix for a user-visible problem and as such
> should:
> 1. Be targeted at net
> 2. Have a Fixes tag
> 3. CC stable
> 
I will split this patch to two patch. one for bugfix, anorther one for 
cleanup.
> See: https://docs.kernel.org/process/maintainer-netdev.html
> 
>> ---
>>   drivers/net/usb/asix_devices.c | 20 +++++++++++++-------
>>   1 file changed, 13 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
>> index f7cff58fe044..11417ed86d9e 100644
>> --- a/drivers/net/usb/asix_devices.c
>> +++ b/drivers/net/usb/asix_devices.c
>> @@ -230,7 +230,9 @@ static int ax88172_bind(struct usbnet *dev, struct usb_interface *intf)
>>   	int i;
>>   	unsigned long gpio_bits = dev->driver_info->data;
>>   
>> -	usbnet_get_endpoints(dev,intf);
>> +	ret = usbnet_get_endpoints(dev, intf);
>> +	if (ret)
>> +		goto out;
>>   
>>   	/* Toggle the GPIOs in a manufacturer/model specific way */
>>   	for (i = 2; i >= 0; i--) {
>> @@ -834,7 +836,9 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
>>   
>>   	dev->driver_priv = priv;
>>   
>> -	usbnet_get_endpoints(dev, intf);
>> +	ret = usbnet_get_endpoints(dev, intf);
>> +	if (ret)
>> +		goto mdio_err;
>>   
>>   	/* Maybe the boot loader passed the MAC address via device tree */
>>   	if (!eth_platform_get_mac_address(&dev->udev->dev, buf)) {
>> @@ -858,7 +862,7 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
>>   		if (ret < 0) {
>>   			netdev_dbg(dev->net, "Failed to read MAC address: %d\n",
>>   				   ret);
>> -			return ret;
>> +			goto mdio_err;
>>   		}
>>   	}
>>   
> 
> The two hunks above do not seem related to the subject of the patch, but
> rather separate cleanups. So I think they should not be part of this patch.
> Instead they could be a separate patch, targeted at net-next.  (FWIIW, I
> would go the other way and drop the mdio_err label from this function.)
> 
>> @@ -871,7 +875,7 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
>>   
>>   	ret = asix_read_phy_addr(dev, true);
>>   	if (ret < 0)
>> -		return ret;
>> +		goto mdio_err;
>>   
>>   	priv->phy_addr = ret;
>>   	priv->embd_phy = ((priv->phy_addr & 0x1f) == AX_EMBD_PHY_ADDR);
>> @@ -880,7 +884,7 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
>>   			    &priv->chipcode, 0);
>>   	if (ret < 0) {
>>   		netdev_dbg(dev->net, "Failed to read STATMNGSTS_REG: %d\n", ret);
>> -		return ret;
>> +		goto mdio_err;
>>   	}
>>   
>>   	priv->chipcode &= AX_CHIPCODE_MASK;
>> @@ -895,7 +899,7 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
>>   	ret = priv->reset(dev, 0);
>>   	if (ret < 0) {
>>   		netdev_dbg(dev->net, "Failed to reset AX88772: %d\n", ret);
>> -		return ret;
>> +		goto mdio_err;
>>   	}
>>   
>>   	/* Asix framing packs multiple eth frames into a 2K usb bulk transfer */
>> @@ -1258,7 +1262,9 @@ static int ax88178_bind(struct usbnet *dev, struct usb_interface *intf)
>>   	int ret;
>>   	u8 buf[ETH_ALEN] = {0};
>>   
>> -	usbnet_get_endpoints(dev,intf);
>> +	ret = usbnet_get_endpoints(dev, intf);
>> +	if (ret)
>> +		return ret;
>>   
>>   	/* Get the MAC address */
>>   	ret = asix_read_cmd(dev, AX_CMD_READ_NODE_ID, 0, 0, ETH_ALEN, buf, 0);
>> -- 
>> 2.25.1
>>
>>
> .
> 


