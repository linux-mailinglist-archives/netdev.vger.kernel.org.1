Return-Path: <netdev+bounces-91026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B398B1039
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 18:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C98391C24745
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 16:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E604D16ABE8;
	Wed, 24 Apr 2024 16:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pfJA4PKm"
X-Original-To: netdev@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53861FDA;
	Wed, 24 Apr 2024 16:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713977375; cv=none; b=Zr/2MQEpSAIpkUPDjbVvcMjIFF49AGZH0Z2cPhVTn/cEJDRVYF2UNE1GFOXnfhJ27E8a1hhXaFlGNItu+WkRW1KEAekTj5s7lYxoWdljl4T3BSBSAo3UaBI6nscyEjLNLsQUClw6FiUOWa0qgQUFTSBIIvP8uIUaRBg/FUq4RNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713977375; c=relaxed/simple;
	bh=BeuHAPFHOzgLj7bcwamrKQ0nWHsiW0duK0tmhO0g0NU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KOHpQ6UcXyXMNxDAs7pIuvQUKzYdn7kwtAtFQQoEf9G4S7sjnZ7Zw/erVPAbUM2teVe/ihw3N//JeBoL2CFG25d0PQWQEdJibWMMiOpcp3NX6/e47AKBvtnqADGPygN8p2+qMdUv2IwfFmFXTmMyyPyzYbHpMjerHgr/O37ztzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pfJA4PKm; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713977370; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=8KMQJzU1aMbtALFenO9YraP0j/CgdS9fdFoFzB32RZY=;
	b=pfJA4PKmrv+Vn+ktQaz173jN7ZpLTxqAYOtxy7CReC3WiTfUFpSASdVhnI5IyqXHxzVt1Z1FV0zwoQUh0WtyflMbaB8TAEjMEh4NX+Uz55QJhAqB6bDcoNJSX973frajERSl39EONm9ZG8r0kgiEipnMQAnKT8HfaQnXVYr0ujA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014016;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0W5Ck5Xj_1713977366;
Received: from 30.39.150.89(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W5Ck5Xj_1713977366)
          by smtp.aliyun-inc.com;
          Thu, 25 Apr 2024 00:49:28 +0800
Message-ID: <df6163de-d82c-458d-b298-1eaf406e6b3d@linux.alibaba.com>
Date: Thu, 25 Apr 2024 00:49:26 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heng Qi <hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v9 2/4] ethtool: provide customized dim profile
 management
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Brett Creeley <bcreeley@amd.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Tal Gilboa <talgi@nvidia.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jiri Pirko <jiri@resnulli.us>, Paul Greenwalt <paul.greenwalt@intel.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>, "justinstitt@google.com"
 <justinstitt@google.com>
References: <20240417155546.25691-1-hengqi@linux.alibaba.com>
 <20240417155546.25691-3-hengqi@linux.alibaba.com>
 <20240418174843.492078d5@kernel.org>
 <96b59800-85e6-4a9e-ad9b-7ad3fa56fff4@linux.alibaba.com>
 <640292b7-5fcd-44c2-bdd1-03702b7e60a1@linux.alibaba.com>
 <20240424091823.4e9b008b@kernel.org>
In-Reply-To: <20240424091823.4e9b008b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2024/4/25 上午12:18, Jakub Kicinski 写道:
> On Wed, 24 Apr 2024 21:41:55 +0800 Heng Qi wrote:
>> +struct dim_irq_moder {
>> +       /* See DIM_PROFILE_* */
>> +       u8 profile_flags;
>> +
>> +       /* See DIM_COALESCE_* for Rx and Tx */
>> +       u8 coal_flags;
>> +
>> +       /* Rx DIM period count mode: CQE or EQE */
>> +       u8 dim_rx_mode;
>> +
>> +       /* Tx DIM period count mode: CQE or EQE */
>> +       u8 dim_tx_mode;
>> +
>> +       /* DIM profile list for Rx */
>> +       struct dim_cq_moder *rx_profile;
>> +
>> +       /* DIM profile list for Tx */
>> +       struct dim_cq_moder *tx_profile;
>> +
>> +       /* Rx DIM worker function scheduled by net_dim() */
>> +       void (*rx_dim_work)(struct work_struct *work);
>> +
>> +       /* Tx DIM worker function scheduled by net_dim() */
>> +       void (*tx_dim_work)(struct work_struct *work);
>> +};
>> +
>>
>> .....
>>
>>
>> +       .ndo_init_irq_moder     = virtnet_init_irq_moder,
> The init callback mostly fills in static data, can we not
> declare the driver information statically and move the init
> code into the core?

Now the init callback is used as following

In dim.c:

+int net_dim_init_irq_moder(struct net_device *dev)
+{
+       if (dev->netdev_ops && dev->netdev_ops->ndo_init_irq_moder)
+               return dev->netdev_ops->ndo_init_irq_moder(dev);
+
+       return 0;
+}
+EXPORT_SYMBOL(net_dim_init_irq_moder);


In dev.c

@@ -10258,6 +10259,10 @@ int register_netdevice(struct net_device *dev)
         if (ret)
                 return ret;

+       ret = net_dim_init_irq_moder(dev);
+       if (ret)
+               return ret;
+
         spin_lock_init(&dev->addr_list_lock);
         netdev_set_addr_lockdep_class(dev);


The collected flags, mode, and work must obtain driver-specific

values from the driver. If I'm not wrong, you don't want an interface

like .ndo_init_irq_moder, but instead provide a generic interface in

dim.c (e.g. net_dim_init_irq_moder() with parameters dev and struct

dim_irq_moder or separate flags,mode,work). Then this func is called

by the driver in the probe phase?


>> ....
>>
>>
>> +static int virtnet_init_irq_moder(struct net_device *dev)
>> +{
>> +        struct virtnet_info *vi = netdev_priv(dev);
>> +        struct dim_irq_moder *moder;
>> +        int len;
>> +
>> +        if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
>> +                return 0;
>> +
>> +        dev->irq_moder = kzalloc(sizeof(*dev->irq_moder), GFP_KERNEL);
>> +        if (!dev->irq_moder)
>> +                goto err_moder;
>> +
>> +        moder = dev->irq_moder;
>> +        len = NET_DIM_PARAMS_NUM_PROFILES * sizeof(*moder->rx_profile);
>> +
>> +        moder->profile_flags |= DIM_PROFILE_RX;
>> +        moder->coal_flags |= DIM_COALESCE_USEC | DIM_COALESCE_PKTS;
>> +        moder->dim_rx_mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
>> +
>> +        moder->rx_dim_work = virtnet_rx_dim_work;
>> +
>> +        moder->rx_profile = kmemdup(dim_rx_profile[moder->dim_rx_mode],
>> +                                   len, GFP_KERNEL);
>> +        if (!moder->rx_profile)
>> +                goto err_profile;
>> +
>> +        return 0;
>> +
>> +err_profile:
>> +        kfree(moder);
>> +err_moder:
>> +        return -ENOMEM;
>> +}
>> +
>>
>> ......
>>
>> +void net_dim_setting(struct net_device *dev, struct dim *dim, bool is_tx)
>> +{
>> +       struct dim_irq_moder *irq_moder = dev->irq_moder;
>> +
>> +       if (!irq_moder)
>> +               return;
>> +
>> +       if (is_tx) {
>> +               INIT_WORK(&dim->work, irq_moder->tx_dim_work);
>> +               dim->mode = irq_moder->dim_tx_mode;
>> +               return;
>> +       }
>> +
>> +       INIT_WORK(&dim->work, irq_moder->rx_dim_work);
>> +       dim->mode = irq_moder->dim_rx_mode;
>> +}
>>
>> .....
>>
>> +       for (i = 0; i < vi->max_queue_pairs; i++)
>> +               net_dim_setting(vi->dev, &vi->rq[i].dim, false);
>>
>> .....
>>
>>       ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES,          /* u32 */
>>
>>       ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS,           /* u32 */
>>
>> + /* nest - _A_PROFILE_IRQ_MODERATION */
>>
>> +  ETHTOOL_A_COALESCE_RX_PROFILE,
>>
>> +   /* nest - _A_PROFILE_IRQ_MODERATION */
>> +  ETHTOOL_A_COALESCE_TX_PROFILE,
>>
>> ......
>>
>>
>> Almost clear implementation, but the only problem is when I want to
>> reuse "ethtool -C" and append ETHTOOL_A_COALESCE_RX_PROFILE
>> and ETHTOOL_A_COALESCE_TX_PROFILE, *ethnl_set_coalesce_validate()
>> will report an error because there are no ETHTOOL_COALESCE_RX_PROFILE
>> and ETHTOOL_COALESCE_TX_PROFILE, because they are replaced by
>> DIM_PROFILE_RX and DIM_PROFILE_TX in the field profile_flags.*
> I see.
>
>> Should I reuse ETHTOOL_COALESCE_RX_PROFILE and
>> ETHTOOL_A_COALESCE_TX_PROFILE in ethtool_ops->.supported_coalesce_params
>> and remove the field profile_flags from struct dim_irq_moder?
>> Or let ethnl_set_coalesce_validate not verify these two flags?
>> Is there a better solution?
> Maybe create the bits but automatically add them for the driver?


Ok. I think it works.


Thanks!


> diff --git a/net/ethtool/coalesce.c b/net/ethtool/coalesce.c
> index 83112c1a71ae..56777d36f7f1 100644
> --- a/net/ethtool/coalesce.c
> +++ b/net/ethtool/coalesce.c
> @@ -243,6 +243,8 @@ ethnl_set_coalesce_validate(struct ethnl_req_info *req_info,
>   
>   	/* make sure that only supported parameters are present */
>   	supported_params = ops->supported_coalesce_params;
> +	if (dev->moder->coal_flags ...)
> +		supported_params |= ETHTOOL_COALESCE_...;
>   	for (a = ETHTOOL_A_COALESCE_RX_USECS; a < __ETHTOOL_A_COALESCE_CNT; a++)
>   		if (tb[a] && !(supported_params & attr_to_mask(a))) {
>   			NL_SET_ERR_MSG_ATTR(info->extack, tb[a],

