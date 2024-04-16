Return-Path: <netdev+bounces-88154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8238A6107
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 04:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EFB11C20A66
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 02:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB82B65E;
	Tue, 16 Apr 2024 02:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="a5WIioG/"
X-Original-To: netdev@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52799134BC
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 02:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713234448; cv=none; b=CUNxp3poKR5DUUrhpwHo1CRNa2QyhWG0JkYIuFRUP/iTY09v8D4EeEU17OnffcpivFuEXLPBBfISmuVQMVSDyrjtJa2WGyL2MXrIsvt1fae6x+ZIJfT71fOx+w/eMlgHTZ+/vW9tYo1vpK8yJkG+1+qZCIyng4MaRsXorveh+Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713234448; c=relaxed/simple;
	bh=klJSczXd7a5izXPTzPLWa4oItlqlCgcuCGH5GqNNFSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ftniVodPiSchhWUqV0GhP8uXE4w51XoVtcQ3hiBdhFuD0qpDyXMjkSiIjRn1jQVeaRvH7QQGUSO1F33e22/SoIgdqmdI9S1+O+51v/ygRYs1gNX0BLtH+gyj1nD+gkkDkRQ3y7sJlK0iQkYbCzlCHbLyGsdZQaKmENNAbTbnKE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=a5WIioG/; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713234444; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Ur6dE2kveXQmyC8klKyeWxv9058DN9W2YwUV0NRk0Mc=;
	b=a5WIioG/96wfKoQxoGu4rmOgkngVy/2vGAw3S0B4XtXtl2kzTjsqwGDmWUgg3duRJhQGTU2+gUVsA/LNH7V7G433KMQE/znUUta6xP99kcIK0ey9gax6ZryjOawFmxrNTnT/CQvjeWz6n12YZOw1VS55zzaSfOtOZjIpzgDyces=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W4fosp8_1713234442;
Received: from 30.221.148.212(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4fosp8_1713234442)
          by smtp.aliyun-inc.com;
          Tue, 16 Apr 2024 10:27:23 +0800
Message-ID: <e8d84e95-cab4-447c-b8f2-54444e80e556@linux.alibaba.com>
Date: Tue, 16 Apr 2024 10:27:21 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/4] ethtool: provide customized dim profile
 management
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Brett Creeley <bcreeley@amd.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20240415093638.123962-1-hengqi@linux.alibaba.com>
 <20240415093638.123962-3-hengqi@linux.alibaba.com>
 <20240415200343.GG2320920@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240415200343.GG2320920@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/16 上午4:03, Simon Horman 写道:
> On Mon, Apr 15, 2024 at 05:36:36PM +0800, Heng Qi wrote:
>
> ...
>
>> @@ -10229,6 +10230,61 @@ static void netdev_do_free_pcpu_stats(struct net_device *dev)
>>   	}
>>   }
>>   
>> +static int dev_dim_profile_init(struct net_device *dev)
>> +{
>> +#if IS_ENABLED(CONFIG_DIMLIB)
>> +	u32 supported = dev->ethtool_ops->supported_coalesce_params;
>> +	struct netdev_profile_moder *moder;
>> +	int length;
>> +
>> +	dev->moderation = kzalloc(sizeof(*dev->moderation), GFP_KERNEL);
>> +	if (!dev->moderation)
>> +		goto err_moder;
>> +
>> +	moder = dev->moderation;
>> +	length = NET_DIM_PARAMS_NUM_PROFILES * sizeof(*moder->rx_eqe_profile);
>> +
>> +	if (supported & ETHTOOL_COALESCE_RX_EQE_PROFILE) {
>> +		moder->rx_eqe_profile = kzalloc(length, GFP_KERNEL);
>> +		if (!moder->rx_eqe_profile)
>> +			goto err_rx_eqe;
>> +		memcpy(moder->rx_eqe_profile, rx_profile[0], length);
>> +	}
>> +	if (supported & ETHTOOL_COALESCE_RX_CQE_PROFILE) {
>> +		moder->rx_cqe_profile = kzalloc(length, GFP_KERNEL);
>> +		if (!moder->rx_cqe_profile)
>> +			goto err_rx_cqe;
>> +		memcpy(moder->rx_cqe_profile, rx_profile[1], length);
>> +	}
>> +	if (supported & ETHTOOL_COALESCE_TX_EQE_PROFILE) {
>> +		moder->tx_eqe_profile = kzalloc(length, GFP_KERNEL);
>> +		if (!moder->tx_eqe_profile)
>> +			goto err_tx_eqe;
>> +		memcpy(moder->tx_eqe_profile, tx_profile[0], length);
>> +	}
>> +	if (supported & ETHTOOL_COALESCE_TX_CQE_PROFILE) {
>> +		moder->tx_cqe_profile = kzalloc(length, GFP_KERNEL);
>> +		if (!moder->tx_cqe_profile)
>> +			goto err_tx_cqe;
>> +		memcpy(moder->tx_cqe_profile, tx_profile[1], length);
>> +	}
> nit: Coccinelle suggests that the kzalloc()/memcpy() pattern above
>       could be replaced with calls to kmemdup()

Good idea.

Thanks.

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
> ...


