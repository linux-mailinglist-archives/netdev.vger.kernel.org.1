Return-Path: <netdev+bounces-81883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0723488B7BD
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 03:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B62F32E7A29
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 02:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3089612838B;
	Tue, 26 Mar 2024 02:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="C7vwQrPE"
X-Original-To: netdev@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F99128379
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 02:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711421676; cv=none; b=kMSEJuEOOaI9V/UlY36w6He+Y9rGmRxcIQfY+s0m2+FUK4QKF2+slT/jXjBWrqy8YSTSHwaqR8YxKYQRoGoGY3CwGxsxzFWe5N5+CTTQEZTnuiLTh6U/I9xYQYSWS3TfJOg+sSQvv2r0IXJfS+teEMGcDU7zDWLucPKySxTJoAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711421676; c=relaxed/simple;
	bh=TxGTsuGBxROLKSdAQvZMyFNNsHy1cOax6j6iJDS9unM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OsowXnoTfUeJVZ4DIJbrhFvDUFif8iC/PA1Xs4lOgNP0tJR4k+SX63Wk9wfaaPZ4wkeKeyp5JRjEP6iEM+/INzkRuToXee2ye/ZpPQOzuQIfTGKuAEkXGfan9/5sXC3uYbak9biyxBq3MJgcEMpIpLOhiUbiR/5gIlZJeK7aVQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=C7vwQrPE; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711421663; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Fk4VDor+i7xq88k4s0CwyfZDIKcm6sD+3WARYskt/aI=;
	b=C7vwQrPEVi3JTb9u30Msbv0TyFBwyjjEthPcUNcRgR+VeYcxqG5y4DRuPrV38VCTHep9vvHXJlS55ug7id8MLoh90GyZ2VW9vZ4l8ouwTKRwwwt28qtTpoZ9NdBcWypTX33qP0X+Zg8Xb+s0BCAyPGucog2vJVZK0bZVGRQAz20=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W3JVLgT_1711421660;
Received: from 30.221.81.94(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W3JVLgT_1711421660)
          by smtp.aliyun-inc.com;
          Tue, 26 Mar 2024 10:54:22 +0800
Message-ID: <23e442f0-a18b-4da0-9321-f543b028cd7e@linux.alibaba.com>
Date: Tue, 26 Mar 2024 10:54:20 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] Remove RTNL lock protection of CVQ
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 virtualization@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jiri@nvidia.com
References: <20240325214912.323749-1-danielj@nvidia.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240325214912.323749-1-danielj@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/26 上午5:49, Daniel Jurgens 写道:
> Currently the buffer used for control VQ commands is protected by the
> RTNL lock. Previously this wasn't a major concern because the control
> VQ was only used during device setup and user interaction. With the
> recent addition of dynamic interrupt moderation the control VQ may be
> used frequently during normal operation.
>
> This series removes the RNTL lock dependancy by introducing a spin lock
> to protect the control buffer and writing SGs to the control VQ.

Hi Daniel.

It's a nice piece of work, but now that we're talking about ctrlq adding 
interrupts, spin lock has some
conflicts with its goals. For example, we expect the ethtool command to 
be blocked.
Therefore, a mutex lock may be more suitable.

Any how, the final conclusion may require some waiting.

Regards,
Heng

>
> Daniel Jurgens (4):
>    virtio_net: Store RSS setting in virtnet_info
>    virtio_net: Remove command data from control_buf
>    virtio_net: Add a lock for the command VQ.
>    virtio_net: Remove rtnl lock protection of command buffers
>
>   drivers/net/virtio_net.c | 185 ++++++++++++++++++++++-----------------
>   1 file changed, 104 insertions(+), 81 deletions(-)
>


