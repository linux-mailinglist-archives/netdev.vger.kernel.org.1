Return-Path: <netdev+bounces-141390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C029BAB23
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 04:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88CD0282170
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 03:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FA615B97D;
	Mon,  4 Nov 2024 03:18:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D091F949;
	Mon,  4 Nov 2024 03:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730690290; cv=none; b=APZBq9yajUWiujqlRgktCpVC+ZNtlwbVIHSH1QTgMBa4YDPQb7sYMmffvIUH5SbYv1GWPyJnqMCMd5yUJjvuLXxXzq4Uxmg3l5xn2Z82tB+XaHC2YAoPh7HupnDvcXYHDJNpy4qPRnUpaCPZvsKsgbka7pFHVIxWzm+uhnQdm+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730690290; c=relaxed/simple;
	bh=ktRwMUiWtoX4QngdqRoJavXr5TZT203Nm+zrwkYu8fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u4RLd3ajgPtlOrrXcoQ3U6+fToId29SeF7uwSOQR38k0h3TV81zQscXrWy+RISyw/YEmfiWS+FlPwFMQlenO78+pyjPkl8OzfzL77Gg0/DW4+8piFFk+oirAN0iSrO4/3kjup+SRyZhBKq0AjqcbxvX4C2OWWkbuHQU1OFoipWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Xhc8B0f90z20rVB;
	Mon,  4 Nov 2024 11:16:58 +0800 (CST)
Received: from dggemv703-chm.china.huawei.com (unknown [10.3.19.46])
	by mail.maildlp.com (Postfix) with ESMTPS id 823641402E0;
	Mon,  4 Nov 2024 11:18:02 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 11:18:02 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 4 Nov
 2024 11:18:01 +0800
Message-ID: <6eba7c8b-000f-7be0-4a8a-53bf8d6dc25f@huawei.com>
Date: Mon, 4 Nov 2024 11:17:44 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v6 1/2] mctp pcc: Check before sending MCTP PCC response
 ACK
To: Adam Young <admiyo@amperemail.onmicrosoft.com>,
	<admiyo@os.amperecomputing.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jeremy Kerr
	<jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Len
 Brown" <lenb@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Robert Moore <robert.moore@intel.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Jassi Brar <jassisinghbrar@gmail.com>, "Sudeep
 Holla" <sudeep.holla@arm.com>
References: <20241029165414.58746-1-admiyo@os.amperecomputing.com>
 <20241029165414.58746-2-admiyo@os.amperecomputing.com>
 <a05fd200-c1ea-dff6-8cfa-43077c6b4a99@huawei.com>
 <38fab0d5-8a31-41be-8426-6f180e6d4203@amperemail.onmicrosoft.com>
 <f44f9b12-5cb1-af1d-5e2f-9a06ad648347@huawei.com>
 <d9969244-8f4c-4f66-9ab1-064be665495d@amperemail.onmicrosoft.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <d9969244-8f4c-4f66-9ab1-064be665495d@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2024/11/2 23:34, Adam Young 写道:
>
> On 10/31/24 21:30, lihuisong (C) wrote:
>>>
>>> On 10/30/24 05:45, lihuisong (C) wrote:
>>>>> + check_and_ack(pchan, chan);
>>>>>       pchan->chan_in_use = false;
>>>>>         return IRQ_HANDLED;
>>>>> @@ -352,6 +368,9 @@ pcc_mbox_request_channel(struct mbox_client 
>>>>> *cl, int subspace_id)
>>>>>       if (rc)
>>>>>           return ERR_PTR(rc);
>>>>>   +    pchan->shmem_base_addr = devm_ioremap(chan->mbox->dev,
>>>>> +                          pchan->chan.shmem_base_addr,
>>>>> +                          pchan->chan.shmem_size);
>>>> Currently, the PCC mbox client does ioremap after requesting PCC 
>>>> channel.
>>>> Thus all current clients will ioremap twice. This is not good to me.
>>>> How about add a new interface and give the type4 client the right 
>>>> to decide whether to reply in rx_callback?
>>>
>>>
>>> I do agree that is a cleaner implementation, but I don't have a way 
>>> of testing the other drivers, and did not want to break them. I 
>>> think your driver is the only that makes use of it, so we can 
>>> certainly come up with a common approach.
>> I understand what you are concerned about.
>> But this duplicate ioremap also works for all PCC clients no matter 
>> which type they used. It has very wide influence.
>> My driver just uses type3 instead of type4. What's more, AFAICS, it 
>> doesn't seem there is type4 client driver in linux.
>> Therefore, determining whether type4 client driver needs to reply to 
>> platform has the minimum or even no impact in their rx_callback. 
>
>  I can move the place where we hold on to the shmem from struct 
> pcc_chan_info in pcc.c, where it is local to the file, to struct 
> pcc_mbox_chan in  include/acpi/pcc.h where it will be visible from 
> both files.  With that change, we only need ioremap once for the segment.
>
> I don't like adding the callback decision in the driver:  it is part 
> of the protocol, and should be enforced  by the pcc layer. If we do it 
> in the driver, the logic will be duplicated by each driver.
Yes
>
> I could make a further  change and allow the driver to request the 
> remapped memory segment from the pcc layer, and couple  to the 
> memory-remap to the client/channel.  It seems like that code, too, 
> should be in the common layer.  However most drivers would not know to 
> use  this function yet, so the mechanism would have to be optional, 
> and only clean up if called this way.
I agree this method.
Don't remap twice for one shared memory.
This remaping is reasonable in PCC layer. We can let PCC client to 
decide if PCC layer does remap and then they use it directly.
For new driver like the driver you are uploading, driver can give PCC 
one flag to tell PCC layer remap when request channel.
For old PCC client driver, do not send this flag, PPC layer do not 
remap. So no any impact on them.
>
>
>
>
>
>
> .

