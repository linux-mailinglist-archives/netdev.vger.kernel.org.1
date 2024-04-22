Return-Path: <netdev+bounces-90009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7758AC839
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 11:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C76BE1F21070
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 09:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B018C51C5C;
	Mon, 22 Apr 2024 09:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="o57PPAl6"
X-Original-To: netdev@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CC651016;
	Mon, 22 Apr 2024 09:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713776435; cv=none; b=gvJaYPReRSddaGz7UwaIFG21B3x+UyAVYkFO30u9QFcDCNBZeUsC/xJP7EQjyK+d3q3Tq4srI4n7EHCMt4Lbix+SAOTHXMH99mRwyh3HiXsLrYimAgLXMDOqRkOYJV7OrBgt+4EV8ZBOLNVOit5cjhR5ojpnZMjdNWkdxhRxnJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713776435; c=relaxed/simple;
	bh=Ltp/SC14u5VghgklXQfgj9JGlFcBCHZKOS6N6PLdyy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lnL4EueG/1BhUP1+ns7EKX9WsWhauxnCQqCQar2rjcaaIKb0PgpbV4lDBiT5qt8pBt1WCw50cHZnxMRBlNCsiiioF4UFdEHTJgT/QsNzyg6zqsTread3fMgBFB1gigeQ8swt39hr3gqUwxAYlOkv+Gs2tV4Hr4o56LMrTFCjzpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=o57PPAl6; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713776430; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yjewXBy2VepXX+C8JfjCtNXAwQb8iFrWp3+M3n2rkko=;
	b=o57PPAl6lx2bvUwAG2TY0qHbKa4bAGkOqhm3EiMyuIQUrdgEzlPfzH4LgWI0OptsZ1xkL9ypr4ufa+ldLWl1YxOFQzKp3fWT3paoRhYcCrbBvr/xZkGJvWc21GxtTNPOx0iy6aBQyq366t2m7kjktCAJkxqNEusTGyoJhusuF/g=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0W50oI7-_1713776426;
Received: from 30.221.148.142(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W50oI7-_1713776426)
          by smtp.aliyun-inc.com;
          Mon, 22 Apr 2024 17:00:28 +0800
Message-ID: <96b59800-85e6-4a9e-ad9b-7ad3fa56fff4@linux.alibaba.com>
Date: Mon, 22 Apr 2024 17:00:25 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240418174843.492078d5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/19 上午8:48, Jakub Kicinski 写道:
> On Wed, 17 Apr 2024 23:55:44 +0800 Heng Qi wrote:
>> $ ethtool -c ethx
>> ...
>> rx-eqe-profile:
>> {.usec =   1, .pkts = 256, .comps =   0,},
>> {.usec =   8, .pkts = 256, .comps =   0,},
>> {.usec =  64, .pkts = 256, .comps =   0,},
>> {.usec = 128, .pkts = 256, .comps =   0,},
>> {.usec = 256, .pkts = 256, .comps =   0,}
>> rx-cqe-profile:   n/a
>> tx-eqe-profile:   n/a
>> tx-cqe-profile:   n/a
> I don't think that exposing CQE vs EQE mode makes much sense here.
> We enable the right mode via:
>
> struct kernel_ethtool_coalesce {
> 	u8 use_cqe_mode_tx;
> 	u8 use_cqe_mode_rx;

I think it is reasonable to use 4 types:

dim lib itself is designed with 4 independent arrays, which are queried 
by dim->mode and
dim->profile_ix. This way allows users to manually modify the cqe mode 
of tx or rx, and the
dim interface can automatically match the profile of the corresponding 
mode when obtaining
the results.

Merely exposing rx_profile and tx_profile does not seem to make the 
interface and code clearer.

>
> the user needs to set the packets and usecs in an educated way
> (matching the mode).

I think this is acceptable. In addition to the above reasons, users can 
already set the cqe
mode of tx and rx in user mode, which means that they have been educated.

> The kernel never changes the mode.

Sorry, I don't seem to understand what this means.

>
> Am I missing something?
>
>> +  -
>> +    name: moderation
> irq-moderation ?

OK.

>
>> +    attributes:
>> +      -
>> +        name: usec
>> +        type: u32
>> +      -
>> +        name: pkts
>> +        type: u32
>> +      -
>> +        name: comps
>> +        type: u32
>> +++ b/include/linux/ethtool.h
>> @@ -284,7 +284,11 @@ bool ethtool_convert_link_mode_to_legacy_u32(u32 *legacy_u32,
>>   #define ETHTOOL_COALESCE_TX_AGGR_MAX_BYTES	BIT(24)
>>   #define ETHTOOL_COALESCE_TX_AGGR_MAX_FRAMES	BIT(25)
>>   #define ETHTOOL_COALESCE_TX_AGGR_TIME_USECS	BIT(26)
>> -#define ETHTOOL_COALESCE_ALL_PARAMS		GENMASK(26, 0)
>> +#define ETHTOOL_COALESCE_RX_EQE_PROFILE         BIT(27)
>> +#define ETHTOOL_COALESCE_RX_CQE_PROFILE         BIT(28)
>> +#define ETHTOOL_COALESCE_TX_EQE_PROFILE         BIT(29)
>> +#define ETHTOOL_COALESCE_TX_CQE_PROFILE         BIT(30)
>> +#define ETHTOOL_COALESCE_ALL_PARAMS		GENMASK(30, 0)
> I think it's better to add these to netdev_ops, see below.
>
>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>> index d45f330d083d..a1c7e9c2be86 100644
>> --- a/include/linux/netdevice.h
>> +++ b/include/linux/netdevice.h
>> @@ -80,6 +80,25 @@ struct xdp_frame;
>>   struct xdp_metadata_ops;
>>   struct xdp_md;
>>   
>> +#if IS_ENABLED(CONFIG_DIMLIB)
> Don't wrap type definitions in an ifdef.
>
>> +struct dim_cq_moder;
> Unnecessary.
>
>> +#define NETDEV_PROFILE_USEC	BIT(0)	/* device supports usec field modification */
>> +#define NETDEV_PROFILE_PKTS	BIT(1)	/* device supports pkts field modification */
>> +#define NETDEV_PROFILE_COMPS	BIT(2)	/* device supports comps field modification */
>> +
>> +struct netdev_profile_moder {
>> +	/* See NETDEV_PROFILE_* */
>> +	unsigned int flags;
>> +
>> +	/* DIM profile lists for different dim cq modes */
>> +	struct dim_cq_moder *rx_eqe_profile;
>> +	struct dim_cq_moder *rx_cqe_profile;
>> +	struct dim_cq_moder *tx_eqe_profile;
>> +	struct dim_cq_moder *tx_cqe_profile;
>> +};
>> +#endif
> All of this can move to the dim header. No need to grow netdevice.h

OK.

>
>>   typedef u32 xdp_features_t;
>>   
>>   void synchronize_net(void);
>
>> +static int dev_dim_profile_init(struct net_device *dev)
>> +{
>> +#if IS_ENABLED(CONFIG_DIMLIB)
>> +	u32 supported = dev->ethtool_ops->supported_coalesce_params;
>> +
>> +	struct netdev_profile_moder *moder;
>> +	int length;
>> +
>> +	dev->moderation = kzalloc(sizeof(*dev->moderation), GFP_KERNEL);
>> +	if (!dev->moderation)
>> +		goto err_moder;
> if the device has no DIM we should allocate nothing

This can be done by netdev_ops.

>
>> +	moder = dev->moderation;
>> +	length = NET_DIM_PARAMS_NUM_PROFILES * sizeof(*moder->rx_eqe_profile);
>> +
>> +	if (supported & ETHTOOL_COALESCE_RX_EQE_PROFILE) {
>> +		moder->rx_eqe_profile = kmemdup(dim_rx_profile[0], length, GFP_KERNEL);
>> +		if (!moder->rx_eqe_profile)
>> +			goto err_rx_eqe;
>> +	}
>> +	if (supported & ETHTOOL_COALESCE_RX_CQE_PROFILE) {
>> +		moder->rx_cqe_profile = kmemdup(dim_rx_profile[1], length, GFP_KERNEL);
>> +		if (!moder->rx_cqe_profile)
>> +			goto err_rx_cqe;
>> +	}
>> +	if (supported & ETHTOOL_COALESCE_TX_EQE_PROFILE) {
>> +		moder->tx_eqe_profile = kmemdup(dim_tx_profile[0], length, GFP_KERNEL);
>> +		if (!moder->tx_eqe_profile)
>> +			goto err_tx_eqe;
>> +	}
>> +	if (supported & ETHTOOL_COALESCE_TX_CQE_PROFILE) {
>> +		moder->tx_cqe_profile = kmemdup(dim_tx_profile[1], length, GFP_KERNEL);
>> +		if (!moder->tx_cqe_profile)
>> +			goto err_tx_cqe;
>> +	}
> This code should also live in dim rather than dev.c.
>
>> +#endif
>> +	return 0;
>> +
>> +#if IS_ENABLED(CONFIG_DIMLIB)
>> +err_tx_cqe:
>> +	kfree(moder->tx_eqe_profile);
>> +err_tx_eqe:
>> +	kfree(moder->rx_cqe_profile);
>> +err_rx_cqe:
>> +	kfree(moder->rx_eqe_profile);
>> +err_rx_eqe:
>> +	kfree(moder);
>> +err_moder:
>> +	return -ENOMEM;
>> +#endif
>> +}
>> +
>>   /**
>>    * register_netdevice() - register a network device
>>    * @dev: device to register
>> @@ -10258,6 +10310,10 @@ int register_netdevice(struct net_device *dev)
>>   	if (ret)
>>   		return ret;
>>   
>> +	ret = dev_dim_profile_init(dev);
>> +	if (ret)
>> +		return ret;
> This is fine but the driver still has to manually do bunch of init:
>
> 		INIT_WORK(&vi->rq[i].dim.work, virtnet_rx_dim_work);
> 		vi->rq[i].dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
>
> It'd be better to collect all this static info (flags, mode, work func)
> in one place / struct, attached to netdev or netdev_ops. Then the
> driver can call a helper like which only needs to take netdev and dim
> as arguments.

If mode is put into netdev, then use_cqe_mode_rx and use_cqe_mode_tx 
need to be moved into netdev too.
Then dim->mode is no longer required when dim obtain its results.
We need to transform the way all drivers with dim currently behave.

But why should work be put into netdev?
The driver still requires a for loop to initialize dim work for a 
driver-specific queues.

>
>>   	spin_lock_init(&dev->addr_list_lock);
>>   	netdev_set_addr_lockdep_class(dev);
>>   
>> @@ -11011,6 +11067,27 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
>>   }
>>   EXPORT_SYMBOL(alloc_netdev_mqs);
>>   
>> +static void netif_free_profile(struct net_device *dev)
>> +{
>> +#if IS_ENABLED(CONFIG_DIMLIB)
>> +	u32 supported = dev->ethtool_ops->supported_coalesce_params;
>> +
>> +	if (supported & ETHTOOL_COALESCE_RX_EQE_PROFILE)
>> +		kfree(dev->moderation->rx_eqe_profile);
> kfree(NULL) is valid, you don't have to check the flags

Ok.

>
>> +	if (supported & ETHTOOL_COALESCE_RX_CQE_PROFILE)
>> +		kfree(dev->moderation->rx_cqe_profile);
>> +
>> +	if (supported & ETHTOOL_COALESCE_TX_EQE_PROFILE)
>> +		kfree(dev->moderation->tx_eqe_profile);
>> +
>> +	if (supported & ETHTOOL_COALESCE_TX_CQE_PROFILE)
>> +		kfree(dev->moderation->tx_cqe_profile);
>> +
>> +	kfree(dev->moderation);
>> +#endif
>> +}
>> +
>>   /**
>>    * free_netdev - free network device
>>    * @dev: device
>> @@ -11036,6 +11113,8 @@ void free_netdev(struct net_device *dev)
>>   		return;
>>   	}
>>   
>> +	netif_free_profile(dev);
>> +
>>   	netif_free_tx_queues(dev);
>>   	netif_free_rx_queues(dev);
>>   
>> diff --git a/net/ethtool/coalesce.c b/net/ethtool/coalesce.c
>> index 83112c1a71ae..3a41840fbcc7 100644
>> --- a/net/ethtool/coalesce.c
>> +++ b/net/ethtool/coalesce.c
>> @@ -1,5 +1,6 @@
>>   // SPDX-License-Identifier: GPL-2.0-only
>>   
>> +#include <linux/dim.h>
>>   #include "netlink.h"
>>   #include "common.h"
>>   
>> @@ -51,6 +52,10 @@ __CHECK_SUPPORTED_OFFSET(COALESCE_RX_MAX_FRAMES_HIGH);
>>   __CHECK_SUPPORTED_OFFSET(COALESCE_TX_USECS_HIGH);
>>   __CHECK_SUPPORTED_OFFSET(COALESCE_TX_MAX_FRAMES_HIGH);
>>   __CHECK_SUPPORTED_OFFSET(COALESCE_RATE_SAMPLE_INTERVAL);
>> +__CHECK_SUPPORTED_OFFSET(COALESCE_RX_EQE_PROFILE);
>> +__CHECK_SUPPORTED_OFFSET(COALESCE_RX_CQE_PROFILE);
>> +__CHECK_SUPPORTED_OFFSET(COALESCE_TX_EQE_PROFILE);
>> +__CHECK_SUPPORTED_OFFSET(COALESCE_TX_CQE_PROFILE);
>>   
>>   const struct nla_policy ethnl_coalesce_get_policy[] = {
>>   	[ETHTOOL_A_COALESCE_HEADER]		=
>> @@ -82,6 +87,14 @@ static int coalesce_prepare_data(const struct ethnl_req_info *req_base,
>>   static int coalesce_reply_size(const struct ethnl_req_info *req_base,
>>   			       const struct ethnl_reply_data *reply_base)
>>   {
>> +	int modersz = nla_total_size(0) + /* _MODERATIONS_MODERATION, nest */
>> +		      nla_total_size(sizeof(u32)) + /* _MODERATION_USEC */
>> +		      nla_total_size(sizeof(u32)) + /* _MODERATION_PKTS */
>> +		      nla_total_size(sizeof(u32));  /* _MODERATION_COMPS */
>> +
>> +	int total_modersz = nla_total_size(0) +  /* _{R,T}X_{E,C}QE_PROFILE, nest */
>> +			modersz * NET_DIM_PARAMS_NUM_PROFILES;
>> +
>>   	return nla_total_size(sizeof(u32)) +	/* _RX_USECS */
>>   	       nla_total_size(sizeof(u32)) +	/* _RX_MAX_FRAMES */
>>   	       nla_total_size(sizeof(u32)) +	/* _RX_USECS_IRQ */
>> @@ -108,7 +121,8 @@ static int coalesce_reply_size(const struct ethnl_req_info *req_base,
>>   	       nla_total_size(sizeof(u8)) +	/* _USE_CQE_MODE_RX */
>>   	       nla_total_size(sizeof(u32)) +	/* _TX_AGGR_MAX_BYTES */
>>   	       nla_total_size(sizeof(u32)) +	/* _TX_AGGR_MAX_FRAMES */
>> -	       nla_total_size(sizeof(u32));	/* _TX_AGGR_TIME_USECS */
>> +	       nla_total_size(sizeof(u32)) +	/* _TX_AGGR_TIME_USECS */
>> +	       total_modersz * 4;		/* _{R,T}X_{E,C}QE_PROFILE */
>>   }
>>   
>>   static bool coalesce_put_u32(struct sk_buff *skb, u16 attr_type, u32 val,
>> @@ -127,6 +141,62 @@ static bool coalesce_put_bool(struct sk_buff *skb, u16 attr_type, u32 val,
>>   	return nla_put_u8(skb, attr_type, !!val);
>>   }
>>   
>> +#if IS_ENABLED(CONFIG_DIMLIB)
> prefer using
>
> 	if (IS_ENABLED(CONFIG_DIMLIB))
> 		return -EOPNOTSUPP;

Hiding code is to eliminate nipa's warning about "defined but not used".

>
> rather than hiding code from the compiler, where possible
>
>> +/**
>> + * coalesce_put_profile - fill reply with a nla nest with four child nla nests.
>> + * @skb: socket buffer the message is stored in
>> + * @attr_type: nest attr type ETHTOOL_A_COALESCE_*X_*QE_PROFILE
>> + * @profile: data passed to userspace
>> + * @supported_params: modifiable parameters supported by the driver
>> + *
>> + * Put a dim profile nest attribute. Refer to ETHTOOL_A_MODERATIONS_MODERATION.
>> + *
>> + * Return: false to indicate successful placement or no placement, and
>> + * true to pass the -EMSGSIZE error to the wrapper.
> Why the bool? Doesn't most of the similar code return the error?

Its wrapper function ethnl_default_doit only recognizes the EMSGSIZE code.

>
>> + */
>> +static bool coalesce_put_profile(struct sk_buff *skb, u16 attr_type,
>> +				 const struct dim_cq_moder *profile,
>> +				 u32 supported_params)
>> +{
>> +	struct nlattr *profile_attr, *moder_attr;
>> +	bool emsg = !!-EMSGSIZE;
>> +	int i;
>> +
>> +	if (!profile)
>> +		return false;
>> +
>> +	if (!(supported_params & attr_to_mask(attr_type)))
>> +		return false;
>> +
>> +	profile_attr = nla_nest_start(skb, attr_type);
>> +	if (!profile_attr)
>> +		return emsg;
>> +
>> +	for (i = 0; i < NET_DIM_PARAMS_NUM_PROFILES; i++) {
>> +		moder_attr = nla_nest_start(skb, ETHTOOL_A_MODERATIONS_MODERATION);
>> +		if (!moder_attr)
>> +			goto nla_cancel_profile;
>> +
>> +		if (nla_put_u32(skb, ETHTOOL_A_MODERATION_USEC, profile[i].usec) ||
>> +		    nla_put_u32(skb, ETHTOOL_A_MODERATION_PKTS, profile[i].pkts) ||
>> +		    nla_put_u32(skb, ETHTOOL_A_MODERATION_COMPS, profile[i].comps))
> Only put attrs for supported fields

Ok.

>
>> +			goto nla_cancel_moder;
>> +
>> +		nla_nest_end(skb, moder_attr);
>> +	}
>> +
>> +	nla_nest_end(skb, profile_attr);
>> +
>> +	return 0;
>> +
>> +nla_cancel_moder:
>> +	nla_nest_cancel(skb, moder_attr);
>> +nla_cancel_profile:
>> +	nla_nest_cancel(skb, profile_attr);
>> +	return emsg;
>> +}
>> +#endif
>> +
>>   static int coalesce_fill_reply(struct sk_buff *skb,
>>   			       const struct ethnl_req_info *req_base,
>>   			       const struct ethnl_reply_data *reply_base)
>> @@ -134,6 +204,9 @@ static int coalesce_fill_reply(struct sk_buff *skb,
>>   	const struct coalesce_reply_data *data = COALESCE_REPDATA(reply_base);
>>   	const struct kernel_ethtool_coalesce *kcoal = &data->kernel_coalesce;
>>   	const struct ethtool_coalesce *coal = &data->coalesce;
>> +#if IS_ENABLED(CONFIG_DIMLIB)
>> +	struct net_device *dev = req_base->dev;
>> +#endif
>>   	u32 supported = data->supported_params;
>>   
>>   	if (coalesce_put_u32(skb, ETHTOOL_A_COALESCE_RX_USECS,
>> @@ -192,6 +265,21 @@ static int coalesce_fill_reply(struct sk_buff *skb,
>>   			     kcoal->tx_aggr_time_usecs, supported))
>>   		return -EMSGSIZE;
>>   
>> +#if IS_ENABLED(CONFIG_DIMLIB)
>> +	if (!(dev->moderation->flags & (NETDEV_PROFILE_USEC | NETDEV_PROFILE_PKTS |
>> +					NETDEV_PROFILE_COMPS)))
>> +		return 0;
>> +
>> +	if (coalesce_put_profile(skb, ETHTOOL_A_COALESCE_RX_EQE_PROFILE,
>> +				 dev->moderation->rx_eqe_profile, supported) ||
>> +	    coalesce_put_profile(skb, ETHTOOL_A_COALESCE_RX_CQE_PROFILE,
>> +				 dev->moderation->rx_cqe_profile, supported) ||
>> +	    coalesce_put_profile(skb, ETHTOOL_A_COALESCE_TX_EQE_PROFILE,
>> +				 dev->moderation->tx_eqe_profile, supported) ||
>> +	    coalesce_put_profile(skb, ETHTOOL_A_COALESCE_TX_CQE_PROFILE,
>> +				 dev->moderation->tx_cqe_profile, supported))
>> +		return -EMSGSIZE;
>> +#endif
>>   	return 0;
>>   }
>>   
>> @@ -227,7 +315,19 @@ const struct nla_policy ethnl_coalesce_set_policy[] = {
>>   	[ETHTOOL_A_COALESCE_TX_AGGR_MAX_BYTES] = { .type = NLA_U32 },
>>   	[ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES] = { .type = NLA_U32 },
>>   	[ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS] = { .type = NLA_U32 },
>> +	[ETHTOOL_A_COALESCE_RX_EQE_PROFILE]     = { .type = NLA_NESTED },
>> +	[ETHTOOL_A_COALESCE_RX_CQE_PROFILE]     = { .type = NLA_NESTED },
>> +	[ETHTOOL_A_COALESCE_TX_EQE_PROFILE]     = { .type = NLA_NESTED },
>> +	[ETHTOOL_A_COALESCE_TX_CQE_PROFILE]     = { .type = NLA_NESTED },
> NLA_POLICY_NESTED(coalesce_set_profile_policy)

This doesn't work because the first level of sub-nesting of
ETHTOOL_A_COALESCE_RX_CQE_PROFILE is ETHTOOL_A_PROFILE_IRQ_MODERATION.

>
>> +};
>> +
>> +#if IS_ENABLED(CONFIG_DIMLIB)
>> +static const struct nla_policy coalesce_set_profile_policy[] = {
>> +	[ETHTOOL_A_MODERATION_USEC]	= {.type = NLA_U32},
>> +	[ETHTOOL_A_MODERATION_PKTS]	= {.type = NLA_U32},
>> +	[ETHTOOL_A_MODERATION_COMPS]	= {.type = NLA_U32},
>>   };
>> +#endif
>>   
>>   static int
>>   ethnl_set_coalesce_validate(struct ethnl_req_info *req_info,
>> @@ -253,6 +353,76 @@ ethnl_set_coalesce_validate(struct ethnl_req_info *req_info,
>>   	return 1;
>>   }
>>   
>> +#if IS_ENABLED(CONFIG_DIMLIB)
>> +/**
>> + * ethnl_update_profile - get a nla nest with four child nla nests from userspace.
>> + * @dev: netdevice to update the profile
>> + * @dst: data get from the driver and modified by ethnl_update_profile.
>> + * @nests: nest attr ETHTOOL_A_COALESCE_*X_*QE_PROFILE to set driver's profile.
>> + * @extack: Netlink extended ack
>> + *
>> + * Layout of nests:
>> + *   Nested ETHTOOL_A_COALESCE_*X_*QE_PROFILE attr
>> + *     Nested ETHTOOL_A_MODERATIONS_MODERATION attr
>> + *       ETHTOOL_A_MODERATION_USEC attr
>> + *       ETHTOOL_A_MODERATION_PKTS attr
>> + *       ETHTOOL_A_MODERATION_COMPS attr
>> + *     ...
>> + *     Nested ETHTOOL_A_MODERATIONS_MODERATION attr
>> + *       ETHTOOL_A_MODERATION_USEC attr
>> + *       ETHTOOL_A_MODERATION_PKTS attr
>> + *       ETHTOOL_A_MODERATION_COMPS attr
>> + *
>> + * Return: 0 on success or a negative error code.
>> + */
>> +static int ethnl_update_profile(struct net_device *dev,
>> +				struct dim_cq_moder *dst,
>> +				const struct nlattr *nests,
>> +				struct netlink_ext_ack *extack)
>> +{
>> +	struct nlattr *tb_moder[ARRAY_SIZE(coalesce_set_profile_policy)];
>> +	struct dim_cq_moder profile[NET_DIM_PARAMS_NUM_PROFILES];
>> +	struct netdev_profile_moder *moder = dev->moderation;
>> +	struct nlattr *nest;
>> +	int ret, rem, i = 0;
>> +
>> +	if (!nests)
>> +		return 0;
>> +
>> +	if (!dst)
>> +		return -EOPNOTSUPP;
>> +
>> +	nla_for_each_nested_type(nest, ETHTOOL_A_MODERATIONS_MODERATION, nests, rem) {
>> +		ret = nla_parse_nested(tb_moder,
>> +				       ARRAY_SIZE(coalesce_set_profile_policy) - 1,
>> +				       nest, coalesce_set_profile_policy,
>> +				       extack);
>> +		if (ret)
>> +			return ret;
>> +
>> +		if (NL_REQ_ATTR_CHECK(extack, nest, tb_moder, ETHTOOL_A_MODERATION_USEC) ||
>> +		    NL_REQ_ATTR_CHECK(extack, nest, tb_moder, ETHTOOL_A_MODERATION_PKTS) ||
>> +		    NL_REQ_ATTR_CHECK(extack, nest, tb_moder, ETHTOOL_A_MODERATION_COMPS))
> Only require what the device supports, reject what it doesn't

Ok.

>
>> +			return -EINVAL;
>> +
>> +		profile[i].usec = nla_get_u32(tb_moder[ETHTOOL_A_MODERATION_USEC]);
>> +		profile[i].pkts = nla_get_u32(tb_moder[ETHTOOL_A_MODERATION_PKTS]);
>> +		profile[i].comps = nla_get_u32(tb_moder[ETHTOOL_A_MODERATION_COMPS]);
>> +
>> +		if ((dst[i].usec != profile[i].usec && !(moder->flags & NETDEV_PROFILE_USEC)) ||
>> +		    (dst[i].pkts != profile[i].pkts && !(moder->flags & NETDEV_PROFILE_PKTS)) ||
>> +		    (dst[i].comps != profile[i].comps && !(moder->flags & NETDEV_PROFILE_COMPS)))
>> +			return -EOPNOTSUPP;
>> +
>> +		i++;
>> +	}
>> +
>> +	memcpy(dst, profile, sizeof(profile));
> Is this safe? I think you need to use some synchronization when
> swapping profiles, maybe RCU?..

RCU +1.

Thanks for reminding.

>
>> +	return 0;
>> +}
>> +#endif
>> +
>>   static int
>>   __ethnl_set_coalesce(struct ethnl_req_info *req_info, struct genl_info *info,
>>   		     bool *dual_change)
>> @@ -317,6 +487,35 @@ __ethnl_set_coalesce(struct ethnl_req_info *req_info, struct genl_info *info,
>>   	ethnl_update_u32(&kernel_coalesce.tx_aggr_time_usecs,
>>   			 tb[ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS], &mod);
>>   
>> +#if IS_ENABLED(CONFIG_DIMLIB)
>> +	ret = ethnl_update_profile(dev, dev->moderation->rx_eqe_profile,
>> +				   tb[ETHTOOL_A_COALESCE_RX_EQE_PROFILE],
>> +				   info->extack);
>> +	if (ret < 0)
>> +		return ret;
>> +	ret = ethnl_update_profile(dev, dev->moderation->rx_cqe_profile,
>> +				   tb[ETHTOOL_A_COALESCE_RX_CQE_PROFILE],
>> +				   info->extack);
>> +	if (ret < 0)
>> +		return ret;
>> +	ret = ethnl_update_profile(dev, dev->moderation->tx_eqe_profile,
>> +				   tb[ETHTOOL_A_COALESCE_TX_EQE_PROFILE],
>> +				   info->extack);
>> +	if (ret < 0)
>> +		return ret;
>> +	ret = ethnl_update_profile(dev, dev->moderation->tx_cqe_profile,
>> +				   tb[ETHTOOL_A_COALESCE_TX_CQE_PROFILE],
>> +				   info->extack);
>> +	if (ret < 0)
>> +		return ret;
>> +#else
>> +	if (tb[ETHTOOL_A_COALESCE_RX_EQE_PROFILE] ||
>> +	    tb[ETHTOOL_A_COALESCE_RX_CQE_PROFILE] ||
>> +	    tb[ETHTOOL_A_COALESCE_TX_EQE_PROFILE] ||
>> +	    tb[ETHTOOL_A_COALESCE_TX_CQE_PROFILE])
>> +		return -EOPNOTSUPP;
>> +
>> +#endif
>>   	/* Update operation modes */
>>   	ethnl_update_bool32(&coalesce.use_adaptive_rx_coalesce,
>>   			    tb[ETHTOOL_A_COALESCE_USE_ADAPTIVE_RX], &mod_mode);


