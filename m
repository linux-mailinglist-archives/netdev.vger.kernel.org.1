Return-Path: <netdev+bounces-82704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8D888F50C
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 03:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDEFB29E4CC
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 02:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFBF22618;
	Thu, 28 Mar 2024 02:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sRn1ESua"
X-Original-To: netdev@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8945CFBF0
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 02:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711591366; cv=none; b=OmyeHKLLwMYddOZJisptDCnrQGGDPTN2kvew6On7MXw6skbo7pg+Vi9dYhHp0QC/01oN2ioSRwLXBwn8iE1vcYcUSKCp0rLsL8SQxsieS+huYuJE4+ijSw5XJharJm/Y5A1L7B11NJt0GXpTF+YRoCNPnBI0sIj02/uw05MTCxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711591366; c=relaxed/simple;
	bh=X/Tckc3Af5oxrbcQn0TygAvQUc9VKQnEbaPGljUVYoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S2hAGU+6wJGWNO0bo+LgcXZDM7SkCFx7bSNbaMp9ZeWJ29ZVuzHu0q6l8Az9tzdXiwThFli74zZNMkusIdkUEa820lyC/OI+31xpp4kYf4W/4wZbuz/S99zphwhR+ld0454En4zf92Zl0tCJNujXhw/uz6iYHFGXmNN+ohwARCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sRn1ESua; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711591355; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9eWZzhHcFDFZepTkmHL2HqA/lnC2pj1j1x1+d7dBfTE=;
	b=sRn1ESuaTWnndrUhMAUR0S8IJ2iEtMvB8MB7VAyQ2xS2zY1SqH9HhXF5Y4H6FbNFs2a5dzgCj6QLxr8tGBq/CAj4l95VGs/lHo8CglKRiqHY0V/IIoZXBrCCU78b0gTO9A7GNn4ikqZZrT6zSUBN+DPWdMBpLNZPZSiTsaJEsg4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W3QD6BM_1711591352;
Received: from 30.221.148.146(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W3QD6BM_1711591352)
          by smtp.aliyun-inc.com;
          Thu, 28 Mar 2024 10:02:34 +0800
Message-ID: <8bbbcd8b-b812-4e65-8169-73ffc5479eef@linux.alibaba.com>
Date: Thu, 28 Mar 2024 10:02:31 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] virtio-net: support dim profile
 fine-tuning
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 "David S. Miller" <davem@davemloft.net>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1711531146-91920-1-git-send-email-hengqi@linux.alibaba.com>
 <1711531146-91920-3-git-send-email-hengqi@linux.alibaba.com>
 <556ec006-6157-458d-b9c8-86436cb3199d@intel.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <556ec006-6157-458d-b9c8-86436cb3199d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/27 下午10:45, Alexander Lobakin 写道:
> From: Heng Qi <hengqi@linux.alibaba.com>
> Date: Wed, 27 Mar 2024 17:19:06 +0800
>
>> Virtio-net has different types of back-end device
>> implementations. In order to effectively optimize
>> the dim library's gains for different device
>> implementations, let's use the new interface params
>> to fine-tune the profile list.
> Nice idea, but
>
>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>> ---
>>   drivers/net/virtio_net.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 52 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index e709d44..9b6c727 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -57,6 +57,16 @@
>>   
>>   #define VIRTNET_DRIVER_VERSION "1.0.0"
>>   
>> +/* This is copied from NET_DIM_RX_EQE_PROFILES in DIM library */
>> +#define VIRTNET_DIM_RX_PKTS 256
>> +static struct dim_cq_moder rx_eqe_conf[] = {
>> +	{.usec = 1,   .pkts = VIRTNET_DIM_RX_PKTS,},
>> +	{.usec = 8,   .pkts = VIRTNET_DIM_RX_PKTS,},
>> +	{.usec = 64,  .pkts = VIRTNET_DIM_RX_PKTS,},
>> +	{.usec = 128, .pkts = VIRTNET_DIM_RX_PKTS,},
>> +	{.usec = 256, .pkts = VIRTNET_DIM_RX_PKTS,}
>> +};
> This is wrong.
> This way you will have one global table for ALL the virtio devices in
> the system, while Ethtool performs configuration on a per-netdevice basis.
> What you need is to have 1 dim_cq_moder per each virtio netdevice,
> embedded somewhere into its netdev_priv(). Then
> virtio_dim_{rx,tx}_work() will take profiles from there, not the global
> struct. The global struct can stay here as const to initialize default
> per-netdevice params.

You are right. Good catch!

Thanks,
Heng

>> +
>>   static const unsigned long guest_offloads[] = {
>>   	VIRTIO_NET_F_GUEST_TSO4,
>>   	VIRTIO_NET_F_GUEST_TSO6,
> Thanks,
> Olek


