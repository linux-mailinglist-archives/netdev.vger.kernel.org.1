Return-Path: <netdev+bounces-194785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1278ACC61A
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 14:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2D191883FE1
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 12:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382BE22D4DE;
	Tue,  3 Jun 2025 12:03:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B067246B8;
	Tue,  3 Jun 2025 12:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748952222; cv=none; b=nhUvMkN4PeFh8z9rQ8BWhR3Q4/Bj/FIesUHPXMQDb838lzbhhrcB1Wisr2QSAg1Syg1eB82mCmCE4hp7JTX/hOHiKEVAR5EAwbvDSv/Q1+nB89JsctLioiryYImb6k/CovMErfZlyMIdHl7gF293neismOEtMEcH1KAjanG1O4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748952222; c=relaxed/simple;
	bh=giLjSiS06S2p3iW3XtomXSbobX9IDJkEJ8D7v5SJ0Mw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UW9RYJSlgze0/b80kWqJQmyhpvucpcCvV8GUXXMjmW/KeaxdZXSsJFREDipHG0RUCVNqWwqpZE/9CI89cA4xl3gcgD0dcm9G/TId0REJX+NXQE+P55FAbacV1XQv3KduGNXbTIjr0Rn1m1u5aOq3u86gKDqJJS6loU852t1Cnzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bBTsQ6gKDz27hfy;
	Tue,  3 Jun 2025 20:04:26 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id D06C0180043;
	Tue,  3 Jun 2025 20:03:35 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Jun 2025 20:03:35 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Jun
 2025 20:03:34 +0800
Message-ID: <c2034f07-5422-4ab1-952e-f7d74d0675a7@huawei.com>
Date: Tue, 3 Jun 2025 20:03:34 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v20 1/1] mctp pcc: Implement MCTP over PCC
 Transport
To: Adam Young <admiyo@amperemail.onmicrosoft.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Sudeep Holla
	<sudeep.holla@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	<admiyo@os.amperecomputing.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Jeremy Kerr <jk@codeconstruct.com.au>,
	"Eric Dumazet" <edumazet@google.com>, Matt Johnston
	<matt@codeconstruct.com.au>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>
References: <20250423220142.635223-1-admiyo@os.amperecomputing.com>
 <20250423220142.635223-2-admiyo@os.amperecomputing.com>
 <497a60df-c97e-48b7-bf0f-decbee6ed732@huawei.com>
 <a9f67a55-3471-46b3-bd02-757b0796658a@amperemail.onmicrosoft.com>
 <807e5ea9-ed04-4203-b4a6-bf90952e7934@huawei.com>
 <9e3e0739-b859-4a62-954e-2b13f7d5dd85@amperemail.onmicrosoft.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <9e3e0739-b859-4a62-954e-2b13f7d5dd85@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/6/3 4:51, Adam Young 写道:
>
> On 5/30/25 02:19, lihuisong (C) wrote:
>>
>> 在 2025/4/29 2:48, Adam Young 写道:
>>>
>>> On 4/24/25 09:03, lihuisong (C) wrote:
>>>>> +    rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->inbox,
>>>>> +                     context.inbox_index);
>>>>> +    if (rc)
>>>>> +        goto free_netdev;
>>>>> +    mctp_pcc_ndev->inbox.client.rx_callback = 
>>>>> mctp_pcc_client_rx_callback;
>>>> It is good to move the assignemnt of  rx_callback pointer to 
>>>> initialize inbox mailbox.
>>>
>>>
>>> The other changes are fine, but this one I do not agree with.
>>>
>>> The rx callback only makes sense for one of the two mailboxes, and 
>>> thus is not appropriate for a generic function.
>>>
>>> Either  initialize_mailbox needs more complex logic, or would 
>>> blindly assign the callback to both mailboxes, neither of which 
>>> simplifies or streamlines the code.  That function emerged as a way 
>>> to reduce duplication.  Lets keep it that way.
>>>
>> It depends on you. But please reply my below comment. I didn't see 
>> any change about it in next version.
>>
>> -->
>>
>>> +static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct 
>>> net_device *ndev)
>>> +{
>>> +    struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
>>> +    struct mctp_pcc_hdr *mctp_pcc_header;
>>> +    void __iomem *buffer;
>>> +    unsigned long flags;
>>> +    int len = skb->len;
>>> +    int rc;
>>> +
>>> +    rc = skb_cow_head(skb, sizeof(struct mctp_pcc_hdr));
>>> +    if (rc)
>>> +        goto err_drop;
>>> +
>>> +    mctp_pcc_header = skb_push(skb, sizeof(struct mctp_pcc_hdr));
>>> +    mctp_pcc_header->signature = cpu_to_le32(PCC_MAGIC | 
>>> mpnd->outbox.index);
>>> +    mctp_pcc_header->flags = cpu_to_le32(PCC_HEADER_FLAGS);
>>> +    memcpy(mctp_pcc_header->mctp_signature, MCTP_SIGNATURE,
>>> +           MCTP_SIGNATURE_LENGTH);
>>> +    mctp_pcc_header->length = cpu_to_le32(len + 
>>> MCTP_SIGNATURE_LENGTH);
>>> +
>>> +    spin_lock_irqsave(&mpnd->lock, flags);
>>> +    buffer = mpnd->outbox.chan->shmem;
>>> +    memcpy_toio(buffer, skb->data, skb->len);
>>> + 
>>> mpnd->outbox.chan->mchan->mbox->ops->send_data(mpnd->outbox.chan->mchan,
>>> +                            NULL);
>>> +    spin_unlock_irqrestore(&mpnd->lock, flags);
>>> +
>> Why does it not need to know if the packet is sent successfully?
>> It's possible for the platform not to finish to send the packet after 
>> executing this unlock.
>> In this moment, the previous packet may be modified by the new packet 
>> to be sent.
>
> I think you missed version  21.
>
> Version 21 of this function ends with:
>         memcpy_toio(buffer, skb->data, skb->len);
>         rc = mpnd->outbox.chan->mchan->mbox->ops->send_data
>                 (mpnd->outbox.chan->mchan, NULL);
>         spin_unlock_irqrestore(&mpnd->lock, flags);
>         if ACPI_FAILURE(rc)
>                 goto err_drop;
>         dev_dstats_tx_add(ndev, len);
>         dev_consume_skb_any(skb);
>         return NETDEV_TX_OK;
> err_drop:
>         dev_dstats_tx_dropped(ndev);
>         kfree_skb(skb);
>         return NETDEV_TX_OK;
>
>
> Once the memcpy_toio completes, the driver will not look at the packet 
> again.  if the Kernel did change it at this point, it would not affect 
> the flow.  The send of the packet is checked vi rc returned from 
> send_data, and it tags the packet as dropped.  Is this not sufficient?
>
Yes, it is not enough.
Once send_data() return success, platform can receive an interrupt，but 
the processing of the platform has not ended.
This processing includes handling data and then triggering an interrupt 
to notify OS.
>
>
>

