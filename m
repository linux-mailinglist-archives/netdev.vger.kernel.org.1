Return-Path: <netdev+bounces-86376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC74989E85A
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 05:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 974F72862D4
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 03:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D5B8489;
	Wed, 10 Apr 2024 03:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="r4l3EqMf"
X-Original-To: netdev@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7308F5B
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 03:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712718564; cv=none; b=k1/8/akkQ+rtCVEixnjnjxxvX4lZhZBHjzXKUMHojHwgzaOjY+t1WB7PaxrJ7GcqmfwjETp0kjbglp6EndGpGWrMJVyEIdHLr93KPiFmC/71/fX71ORqWNiPG848oui7TL6CWWSReMOIqHS4or0XJS72Wq20ZSQzxcWJoqcPLt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712718564; c=relaxed/simple;
	bh=i+Qwmc3ebgy3LkQ5k9BmE2CUnRMXm2zPX4vB3Yk3muI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gpb1z99poLi6SDG4kKP1S7VVl9w1IJNQDu0poH4h4NgHejpBAey2p61zx6CivFk3IT33B3Wk8tVCm2uyRfwAsUs/Q/X6VjwQ1B248GY3vKM1Xechby5iyhVpY1fWE67rhZ4YITj7xcVH8BGu+23qjJmAp3Wd5Fae6pvkT7GsdJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=r4l3EqMf; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712718558; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=s6+adsjsfh6oPSqdZBglDLUkEKuB+B54n0/Ld9Q81W8=;
	b=r4l3EqMfhHXaudpU4iJIQbp2Wx+DO0sXEUHV4h2+bjbn5sE9ew9IEtRy/hMJCujDpIm23zH1Rqow6qF2lqrUXRxZVeYI1S21AoFahHO2kwW9CuU5QgEMgnGUMnX7kKELz8YSHCBVXJ18mF1qQo+8F8M7cU/wRi4SxZYqFtWTVS4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W4GEmuq_1712718556;
Received: from 30.221.148.212(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4GEmuq_1712718556)
          by smtp.aliyun-inc.com;
          Wed, 10 Apr 2024 11:09:18 +0800
Message-ID: <1cd6cd7d-5cf2-4f86-b084-6e88b0cbf229@linux.alibaba.com>
Date: Wed, 10 Apr 2024 11:09:16 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 4/4] virtio-net: support dim profile
 fine-tuning
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1712664204-83147-1-git-send-email-hengqi@linux.alibaba.com>
 <1712664204-83147-5-git-send-email-hengqi@linux.alibaba.com>
 <20240409184020.648bc93c@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240409184020.648bc93c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/10 上午9:40, Jakub Kicinski 写道:
> On Tue,  9 Apr 2024 20:03:24 +0800 Heng Qi wrote:
>> +	/* DIM profile list */
>> +	struct dim_cq_moder rx_eqe_conf[NET_DIM_PARAMS_NUM_PROFILES];
> Can you please wrap this into a structure with other necessary
> information and add a pointer in struct net_device instead.
>
> What's the point of every single driver implementing the same
> boilerplate memcpy() in its get_coalesce / set_coalesce callbacks?

The point is that the driver may check whether the user has set 
parameters that it does not want.
For example, virtio may not want the modification of comps, and ice/idpf 
may not want the modification
of comps and pkts.

But you inspired me to think from another perspective. If parameters are 
placed in netdevice, the
goal of user modification is to modify the profile of netdevice, and the 
driver can obtain its own
target parameters from it as needed. Do you like this?

In addition, if the netdevice way is preferred, I would like to confirm 
whether we still continue the
"ethtool -C" way, that is, complete the modification of netdevice 
profile in __ethnl_set_coalesce()?

Thanks.



