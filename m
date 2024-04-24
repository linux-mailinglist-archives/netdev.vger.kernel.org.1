Return-Path: <netdev+bounces-90954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4170B8B0C70
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 16:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDC32281485
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 14:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4DB15E5BE;
	Wed, 24 Apr 2024 14:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FKKSJJG+"
X-Original-To: netdev@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AF215B996
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 14:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713968806; cv=none; b=FZFaWMKq1flR28A8a/yjOSsgMw1UhxFguFoJ2DgW6vJtZ2EcqHkiy+4CkevIB6vOvSwlSm7CYI3wmZxJqAPqWVoX3x0wUMiLyD5mNDSVndqkLMSyUXxBIz8Y+CgVQZlyEhU64xaTCGsuA84luQlwXlpdZVFq85e069gmk9Kcuw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713968806; c=relaxed/simple;
	bh=6WncPP1f0Ia6dk7ZkOHTYIcFgae85cIvVUAMzALi/P4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FLWxIVlG4Lm2aw8G1YwilGFNRFrFcZcCtAQH+JAYWJdJ/DatuFBbP2+Zri2+br0qgT41wo8NRrhj8tyBzd4B36Kq4PdUxlIRh3a6lbgnLLG2IZHpKJqiQHE6pfPDFVL+szzDQyBKjFfRvOdp8CLFCR07YpSVL+RguCdWay3uDKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FKKSJJG+; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713968799; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=x9V9kFjm1xOhQWW6hghXKNWYOBQlGLUX4xl805MN+iU=;
	b=FKKSJJG+kZHeCg75IkeW5EjOM997SPp2tigzJb1xPnsuqxJYUxaa4o/H9CBC3Udb8QdS3Vp/wskSHLXMr5+sOgm6sgd/csTIeQzYgD0BqyCYOuaVZt1QmhRClqikDPMohHdkUepe/UvtuskHKz/OAV/iMxfl8qVr3W00IbZ3Qs0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014016;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W5CTXgW_1713968797;
Received: from 192.168.0.101(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W5CTXgW_1713968797)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 22:26:38 +0800
Message-ID: <acf47cc1-3aaa-4ca4-b0f5-434ad6d6b0dd@linux.alibaba.com>
Date: Wed, 24 Apr 2024 22:26:36 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net-next v7 0/4] ethtool: provide the dim profile
 fine-tuning channel
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Brett Creeley <bcreeley@amd.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20240415133807.116394-1-hengqi@linux.alibaba.com>
 <20240422165456-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240422165456-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2024/4/23 上午4:55, Michael S. Tsirkin 写道:
> On Mon, Apr 15, 2024 at 09:38:03PM +0800, Heng Qi wrote:
>> The NetDIM library provides excellent acceleration for many modern
>> network cards. However, the default profiles of DIM limits its maximum
>> capabilities for different NICs, so providing a way which the NIC can
>> be custom configured is necessary.
>>
>> Currently, interaction with the driver is still based on the commonly
>> used "ethtool -C".
>>
>> Since the profile now exists in netdevice, adding a function similar
>> to net_dim_get_rx_moderation_dev() with netdevice as argument is
>> nice, but this would be better along with cleaning up the rest of
>> the drivers, which we can get to very soon after this set.
>>
>> Please review, thank you very much!
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Hi Michael,

Thanks for your ACK, the profile series has progressed to v9 and is still

being iterated. it would be better to collect your tag again in a newer 
version.

Thanks!

>
>> Changelog
>> =====
>> v6->v7:
>>    - A new wrapper struct pointer is used in struct net_device.
>>    - Add IS_ENABLED(CONFIG_DIMLIB) to avoid compiler warnings.
>>    - Profile fields changed from u16 to u32.
>>
>> v5->v6:
>>    - Place the profile in netdevice to bypass the driver.
>>      The interaction code of ethtool <-> kernel has not changed at all,
>>      only the interaction part of kernel <-> driver has changed.
>>
>> v4->v5:
>>    - Update some snippets from Kuba, Thanks.
>>
>> v3->v4:
>>    - Some tiny updates and patch 1 only add a new comment.
>>
>> v2->v3:
>>    - Break up the attributes to avoid the use of raw c structs.
>>    - Use per-device profile instead of global profile in the driver.
>>
>> v1->v2:
>>    - Use ethtool tool instead of net-sysfs
>>
>> Heng Qi (4):
>>    linux/dim: move useful macros to .h file
>>    ethtool: provide customized dim profile management
>>    virtio-net: refactor dim initialization/destruction
>>    virtio-net: support dim profile fine-tuning
>>
>> Heng Qi (4):
>>    linux/dim: move useful macros to .h file
>>    ethtool: provide customized dim profile management
>>    virtio-net: refactor dim initialization/destruction
>>    virtio-net: support dim profile fine-tuning
>>
>>   Documentation/netlink/specs/ethtool.yaml     |  33 +++
>>   Documentation/networking/ethtool-netlink.rst |   8 +
>>   drivers/net/virtio_net.c                     |  46 +++--
>>   include/linux/dim.h                          |  13 ++
>>   include/linux/ethtool.h                      |  11 +-
>>   include/linux/netdevice.h                    |  24 +++
>>   include/uapi/linux/ethtool_netlink.h         |  24 +++
>>   lib/dim/net_dim.c                            |  10 +-
>>   net/core/dev.c                               |  83 ++++++++
>>   net/ethtool/coalesce.c                       | 201 ++++++++++++++++++-
>>   10 files changed, 430 insertions(+), 23 deletions(-)
>>
>> -- 
>> 2.32.0.3.g01195cf9f

