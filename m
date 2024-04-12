Return-Path: <netdev+bounces-87234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 870D48A23BF
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 04:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3AE21F2291F
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 02:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CD6D53E;
	Fri, 12 Apr 2024 02:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vpTyff59"
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85ADD27A
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 02:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712888404; cv=none; b=sK01c67q+/7WsxB4U8N3tfq8MHZkekfWpfC2AGwANi5xB/B4Mr+dOQ7d4wFRG401rip/hc2xsPbvMhS8I38KHYiTv0+uMA2GyCPNy1oEY+tJHPHdF5u/22FKqtzHdzF4ZRfWyCDRP/xIFVK1E6nOERgB/n9tK+S8yMAyAW0aQcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712888404; c=relaxed/simple;
	bh=2jNnJCfDAPUEKRrpEthErV+KmzCGXFUSyGVzU5TBHK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kFZHszBCZihCIAj97G/jh4SiASszu46lveR7dlfgFNYMSDbBy2cDkC/OfmKYjZgaQLZL9HspYmtbXwKXnFb6CRCAEIttj/6ab7uPQNA2P4rfLAW9BfPuOH0fXMmxIWIhWKEWXojTt3exUdO8JO4fdNyRkrvylznYkwpdmm1+kHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vpTyff59; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712888399; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VgScfaw58Cz39APebosTdhMRMuFgoK011psxoN7p3Lo=;
	b=vpTyff59B181HP0AdES/tWDU9OXe1ghT+fKMs2xiobz8gBxpcLVWa65fOb0Qmq1ppB3WEs5MfmTBIJZgT69DkNEYy8aG+7w0JAWRb1Ejhr+MnI2OIJR1zAVnmks7Dxrsjkl5WKJIrD+bTl5FN9mlWudKjlxGRZPAbGYJiNDUuuo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W4MZyfG_1712888397;
Received: from 30.221.148.182(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4MZyfG_1712888397)
          by smtp.aliyun-inc.com;
          Fri, 12 Apr 2024 10:19:58 +0800
Message-ID: <207f4375-b9f5-4102-a905-ae5710c18d3f@linux.alibaba.com>
Date: Fri, 12 Apr 2024 10:19:56 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 4/4] virtio-net: support dim profile
 fine-tuning
To: Brett Creeley <bcreeley@amd.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 "open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>
References: <1712844751-53514-1-git-send-email-hengqi@linux.alibaba.com>
 <1712844751-53514-5-git-send-email-hengqi@linux.alibaba.com>
 <8bdcdf49-25fb-46d4-926c-6b0275164d97@amd.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <8bdcdf49-25fb-46d4-926c-6b0275164d97@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/11 下午11:23, Brett Creeley 写道:
>
>
> On 4/11/2024 7:12 AM, Heng Qi wrote:
>> Caution: This message originated from an External Source. Use proper 
>> caution when opening attachments, clicking links, or responding.
>>
>>
>> Virtio-net has different types of back-end device
>> implementations. In order to effectively optimize
>> the dim library's gains for different device
>> implementations, let's use the new interface params
>> to fine-tune the profile list.
>>
>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>> ---
>>   drivers/net/virtio_net.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index a64656e..813d9ed 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -3584,7 +3584,7 @@ static void virtnet_rx_dim_work(struct 
>> work_struct *work)
>>                  if (!rq->dim_enabled)
>>                          continue;
>>
>> -               update_moder = net_dim_get_rx_moderation(dim->mode, 
>> dim->profile_ix);
>> +               update_moder = dev->rx_eqe_profile[dim->profile_ix];
>
> Looking at this it seems like the driver has to be aware of the active 
> profile type, i.e. eqe or cqe. Why not continue to use the dim->mode 
> and also the net_dim_get_rx_moderation() helper?

At this point I plan to issue a patch set after this to clean up all 
related drivers together,
which I have mentioned in the cover-letter:

"
Since the profile now exists in netdevice, adding a function similar
to net_dim_get_rx_moderation_dev() with netdevice as argument is
nice, but this would be better along with cleaning up the rest of
the drivers, which we can get to very soon after this set.
"

>
> Does the dim->mode not get updated based on the ethtool command(s) 
> setting up the new and active profile?

This will not be updated.

Thanks.

>
> Thanks,
>
> Brett
>
>>                  if (update_moder.usec != rq->intr_coal.max_usecs ||
>>                      update_moder.pkts != rq->intr_coal.max_packets) {
>>                          err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, 
>> qnum,
>> @@ -3868,7 +3868,8 @@ static int virtnet_set_rxnfc(struct net_device 
>> *dev, struct ethtool_rxnfc *info)
>>
>>   static const struct ethtool_ops virtnet_ethtool_ops = {
>>          .supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES |
>> -               ETHTOOL_COALESCE_USECS | 
>> ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
>> +               ETHTOOL_COALESCE_USECS | 
>> ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
>> +               ETHTOOL_COALESCE_RX_EQE_PROFILE,
>>          .get_drvinfo = virtnet_get_drvinfo,
>>          .get_link = ethtool_op_get_link,
>>          .get_ringparam = virtnet_get_ringparam,
>> @@ -4424,6 +4425,7 @@ static int virtnet_find_vqs(struct virtnet_info 
>> *vi)
>>
>>   static void virtnet_dim_init(struct virtnet_info *vi)
>>   {
>> +       struct net_device *dev = vi->dev;
>>          int i;
>>
>>          if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
>> @@ -4433,6 +4435,8 @@ static void virtnet_dim_init(struct 
>> virtnet_info *vi)
>>                  INIT_WORK(&vi->rq[i].dim.work, virtnet_rx_dim_work);
>>                  vi->rq[i].dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
>>          }
>> +
>> +       dev->priv_flags |= IFF_PROFILE_USEC | IFF_PROFILE_PKTS;
>>   }
>>
>>   static int virtnet_alloc_queues(struct virtnet_info *vi)
>> -- 
>> 1.8.3.1
>>
>>


