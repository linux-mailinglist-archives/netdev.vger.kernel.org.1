Return-Path: <netdev+bounces-82752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E27488F926
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 08:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6111A1C226D2
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 07:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8729354792;
	Thu, 28 Mar 2024 07:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vEEeyk+s"
X-Original-To: netdev@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A786E5FBAB
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 07:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612289; cv=none; b=P1wxF+NACXBUjMRHVAiMk4cfTBs4se7kGNDWrqmP/ORZSEK4GM5S5gAE9nA4GeAcdGfK0ZqSQNxI7RTjqZeQrBo0Xsly0APchQ3+oc+gwDRFSgHeHP/0jZO6JR7uqkm5SM4Hg+LCZcW4CADF9sGcts2hdMPE8yrj1QD/r3n8FRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612289; c=relaxed/simple;
	bh=kEscZ/8Kkqqx1MT1J4dd88+mQT+FPnz0y12rnoIaq60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QnWIL67ehCv7WHPOXNsU+8C4e00aywfhpZ0GOYge1CfTcpe26CrFBLovaFGuYPO/TbpjLvWrAJvdnRFRhF0v5fVTReXFpe42M7e511lnsjr4KgCRZxxy1f69iYGzVEbYYIxf6uE/Of+1xfY1gcIkPSdFr/kIViE/zQA2fJUe7w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vEEeyk+s; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711612284; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=eYCNs1eyvLbuEg7kTMTsjiZymK6Vox2z18+oy8WLiRM=;
	b=vEEeyk+sjJHWV6j65nfG4fBvN33w0QDJNSs5Jzy0Axdn2Rt0g+nYPUYeKHK4qAn8U10bX5Rnb19P0zjl3vr/7ii6LtKSRAxnBJhZltzOlsrNg8gNV9dMALL7puHZAaOQyEKtZJefBsD2haDDeEw3zARAqGhACABSqCtFl8O1KCc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W3Sg0gU_1711612275;
Received: from 30.221.148.146(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W3Sg0gU_1711612275)
          by smtp.aliyun-inc.com;
          Thu, 28 Mar 2024 15:51:19 +0800
Message-ID: <e73d4bc1-15cb-4f59-90b9-f8b128c2eba8@linux.alibaba.com>
Date: Thu, 28 Mar 2024 15:51:14 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] virtio-net: support dim profile
 fine-tuning
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 "David S. Miller" <davem@davemloft.net>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1711531146-91920-1-git-send-email-hengqi@linux.alibaba.com>
 <1711531146-91920-3-git-send-email-hengqi@linux.alibaba.com>
 <20240328032636-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240328032636-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/28 下午3:27, Michael S. Tsirkin 写道:
> On Wed, Mar 27, 2024 at 05:19:06PM +0800, Heng Qi wrote:
>> Virtio-net has different types of back-end device
>> implementations. In order to effectively optimize
>> the dim library's gains for different device
>> implementations, let's use the new interface params
>> to fine-tune the profile list.
>>
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
> So maybe move it to a header and reuse?

Will do. And plan to put configurable parameters into 'vi'.

Thanks.

>
>
>> +#define VIRTNET_DIM_RX_PKTS 256
>> +static struct dim_cq_moder rx_eqe_conf[] = {
>> +	{.usec = 1,   .pkts = VIRTNET_DIM_RX_PKTS,},
>> +	{.usec = 8,   .pkts = VIRTNET_DIM_RX_PKTS,},
>> +	{.usec = 64,  .pkts = VIRTNET_DIM_RX_PKTS,},
>> +	{.usec = 128, .pkts = VIRTNET_DIM_RX_PKTS,},
>> +	{.usec = 256, .pkts = VIRTNET_DIM_RX_PKTS,}
>> +};
>> +
>>   static const unsigned long guest_offloads[] = {
>>   	VIRTIO_NET_F_GUEST_TSO4,
>>   	VIRTIO_NET_F_GUEST_TSO6,
>> @@ -3584,7 +3594,10 @@ static void virtnet_rx_dim_work(struct work_struct *work)
>>   		if (!rq->dim_enabled)
>>   			continue;
>>   
>> -		update_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
>> +		if (dim->profile_ix >= ARRAY_SIZE(rx_eqe_conf))
>> +			dim->profile_ix = ARRAY_SIZE(rx_eqe_conf) - 1;
>> +
>> +		update_moder = rx_eqe_conf[dim->profile_ix];
>>   		if (update_moder.usec != rq->intr_coal.max_usecs ||
>>   		    update_moder.pkts != rq->intr_coal.max_packets) {
>>   			err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, qnum,
>> @@ -3627,6 +3640,34 @@ static int virtnet_should_update_vq_weight(int dev_flags, int weight,
>>   	return 0;
>>   }
>>   
>> +static int virtnet_update_profile(struct virtnet_info *vi,
>> +				  struct kernel_ethtool_coalesce *kc)
>> +{
>> +	int i;
>> +
>> +	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
>> +		for (i = 0; i < NET_DIM_PARAMS_NUM_PROFILES; i++)
>> +			if (kc->rx_eqe_profs[i].comps)
>> +				return -EINVAL;
>> +	} else {
>> +		for (i = 0; i < NET_DIM_PARAMS_NUM_PROFILES; i++) {
>> +			if (kc->rx_eqe_profs[i].usec != rx_eqe_conf[i].usec ||
>> +			    kc->rx_eqe_profs[i].pkts != rx_eqe_conf[i].pkts ||
>> +			    kc->rx_eqe_profs[i].comps)
>> +				return -EINVAL;
>> +		}
>> +
>> +		return 0;
>> +	}
>> +
>> +	for (i = 0; i < NET_DIM_PARAMS_NUM_PROFILES; i++) {
>> +		rx_eqe_conf[i].usec = kc->rx_eqe_profs[i].usec;
>> +		rx_eqe_conf[i].pkts = kc->rx_eqe_profs[i].pkts;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static int virtnet_set_coalesce(struct net_device *dev,
>>   				struct ethtool_coalesce *ec,
>>   				struct kernel_ethtool_coalesce *kernel_coal,
>> @@ -3653,6 +3694,10 @@ static int virtnet_set_coalesce(struct net_device *dev,
>>   		}
>>   	}
>>   
>> +	ret = virtnet_update_profile(vi, kernel_coal);
>> +	if (ret)
>> +		return ret;
>> +
>>   	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL))
>>   		ret = virtnet_send_notf_coal_cmds(vi, ec);
>>   	else
>> @@ -3689,6 +3734,10 @@ static int virtnet_get_coalesce(struct net_device *dev,
>>   			ec->tx_max_coalesced_frames = 1;
>>   	}
>>   
>> +	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
>> +		memcpy(kernel_coal->rx_eqe_profs, rx_eqe_conf,
>> +		       sizeof(rx_eqe_conf));
>> +
>>   	return 0;
>>   }
>>   
>> @@ -3868,7 +3917,8 @@ static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
>>   
>>   static const struct ethtool_ops virtnet_ethtool_ops = {
>>   	.supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES |
>> -		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
>> +		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
>> +		ETHTOOL_COALESCE_RX_EQE_PROFILE,
>>   	.get_drvinfo = virtnet_get_drvinfo,
>>   	.get_link = ethtool_op_get_link,
>>   	.get_ringparam = virtnet_get_ringparam,
>> -- 
>> 1.8.3.1


