Return-Path: <netdev+bounces-140875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A78159B8881
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9FD91C21EB0
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 01:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACA53CF73;
	Fri,  1 Nov 2024 01:30:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA4C381AF;
	Fri,  1 Nov 2024 01:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730424627; cv=none; b=FQEYDmm33ZCtiwz6GXOhKI1QoxA8QSTceAzzR2kA+49S05WWK5ur0ucH4yPJfwOYaA4RGJ4jDP/UnsMRu6uhVFUDfFYF1ES3LGzU6GlGjOn+SuiT5sp88xsNBRwqvTEvdUF087uAzLZwozqfov3Q7U6tGNdvD+8becdmnVAXXTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730424627; c=relaxed/simple;
	bh=v5iPvw5nCO49LFhFm+N4Y8E6Qavmqbv57ND3RjpMUyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Fgttve6EdZQTGK30MCjF8dHt6KWZj743TJbUyOh6wRykmxgkJhRE6I/nyDNffPdQwMmgQyjX88y0Q5iU6gvEDmoNAPSM30dDyhgGXQaSrzJStcp3Pe/14o9oj8avoxuB5eolsGdl3FcbqKynqnNByREQrShK4iOFjKHqK4GobWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Xfjt93nppzpXld;
	Fri,  1 Nov 2024 09:28:17 +0800 (CST)
Received: from dggemv703-chm.china.huawei.com (unknown [10.3.19.46])
	by mail.maildlp.com (Postfix) with ESMTPS id B8D78140361;
	Fri,  1 Nov 2024 09:30:12 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 09:30:12 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 1 Nov
 2024 09:30:11 +0800
Message-ID: <f44f9b12-5cb1-af1d-5e2f-9a06ad648347@huawei.com>
Date: Fri, 1 Nov 2024 09:30:10 +0800
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
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <38fab0d5-8a31-41be-8426-6f180e6d4203@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemn100009.china.huawei.com (7.202.194.112)

Hi Adam,

All modifications in the patch is done for pcc instead of mctp.
Suggest that use the prefix "mailbox: pcc: xxxx".
Please find my following reply.


在 2024/11/1 8:16, Adam Young 写道:
>
> On 10/30/24 05:45, lihuisong (C) wrote:
>>> + check_and_ack(pchan, chan);
>>>       pchan->chan_in_use = false;
>>>         return IRQ_HANDLED;
>>> @@ -352,6 +368,9 @@ pcc_mbox_request_channel(struct mbox_client *cl, 
>>> int subspace_id)
>>>       if (rc)
>>>           return ERR_PTR(rc);
>>>   +    pchan->shmem_base_addr = devm_ioremap(chan->mbox->dev,
>>> +                          pchan->chan.shmem_base_addr,
>>> +                          pchan->chan.shmem_size);
>> Currently, the PCC mbox client does ioremap after requesting PCC 
>> channel.
>> Thus all current clients will ioremap twice. This is not good to me.
>> How about add a new interface and give the type4 client the right to 
>> decide whether to reply in rx_callback?
>
>
> I do agree that is a cleaner implementation, but I don't have a way of 
> testing the other drivers, and did not want to break them. I think 
> your driver is the only that makes use of it, so we can certainly come 
> up with a common approach.
I understand what you are concerned about.
But this duplicate ioremap also works for all PCC clients no matter 
which type they used. It has very wide influence.
My driver just uses type3 instead of type4. What's more, AFAICS, it 
doesn't seem there is type4 client driver in linux.
Therefore, determining whether type4 client driver needs to reply to 
platform has the minimum or even no impact in their rx_callback.
>
> The mailbox interface does not allow a return code from 
> mbox_chan_received_data, which is what I originally wanted.  If that 
> could return multiple status codes, one of them could indicate the 
> need  to send the interrupt back.  Otherwise, we need to query the 
> driver to read the shared memory again.
yes
>
> .

