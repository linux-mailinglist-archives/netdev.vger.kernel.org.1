Return-Path: <netdev+bounces-91641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0038B34F7
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 12:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6253F1C214EE
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 10:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC96E1428E9;
	Fri, 26 Apr 2024 10:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DQ5dV1fF"
X-Original-To: netdev@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0901A14264F
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 10:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714126128; cv=none; b=GJUEQrQ4GkIFR4FpixKrHwCvFHucrzG2gTKTBWLZj0H+KEmqLnJCMAoOfTv77RTfETShGSNFRehsHUnm96Ul8AMaLX355n+A0tQO7y8zSpYIq/v08eACFofJMdFZsex8bxHBQc4iG61byZaLUGeGLrlf8RH2W8f7Ivf8StNum78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714126128; c=relaxed/simple;
	bh=O6D5EqI+n+Wz5PrcLSUEc+Mwo0K5hqkNGOal1Nr4/og=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DujkjskZErE8mHzSFLXvIY/h/ZeYZ0/Mn2rukyx0N72R+jE/SFcEPYot+OOpD8vYjD9o8PjI3f6ZpmYsF3SJYM4/pAdgW/ljW2aZtX83k3BjjlDyOjtnx17NtHdANdgr7sUo/fc6aNlV3RfPsQu8V5CNybuNdZRc4mWzfDXZodY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DQ5dV1fF; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714126117; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=OMWxDvuwFhzkGQKKD5RYIxwbrnWRZZ3pYLh8+JuN2U8=;
	b=DQ5dV1fF/2VSz7fAeHdv34ZOjAvI8Z74nvgvVrzLdrdJFABdjHcH/a1J7vK3BcEloy6YbTKTBL9M296An4J55a/ifBOIGbjQxMvDxzMoscAG2i27knuXdQMz7SG1D1BzSJMcJeR2nt2Si3CYET8CqBvozIxIiyC5sVhefp9uanA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W5IoZhD_1714126115;
Received: from 30.221.145.218(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W5IoZhD_1714126115)
          by smtp.aliyun-inc.com;
          Fri, 26 Apr 2024 18:08:36 +0800
Message-ID: <dc01448f-d2e6-456f-a1af-e149c296cd15@linux.alibaba.com>
Date: Fri, 26 Apr 2024 18:08:35 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heng Qi <hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 0/6] Remove RTNL lock protection of CVQ
To: Daniel Jurgens <danielj@nvidia.com>, Paolo Abeni <pabeni@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 virtualization@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, jiri@nvidia.com,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>
References: <20240423035746.699466-1-danielj@nvidia.com>
In-Reply-To: <20240423035746.699466-1-danielj@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2024/4/23 上午11:57, Daniel Jurgens 写道:
> Currently the buffer used for control VQ commands is protected by the
> RTNL lock. Previously this wasn't a major concern because the control VQ
> was only used during device setup and user interaction. With the recent
> addition of dynamic interrupt moderation the control VQ may be used
> frequently during normal operation.
>
> This series removes the RNTL lock dependency by introducing a mutex
> to protect the control buffer and writing SGs to the control VQ.

I have done functional and performance tests on this set

with dim enabled, and it works well.

Please taking Paolo's tips into consideration.

For the series:

Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>
Tested-by: Heng Qi <hengqi@linux.alibaba.com>

Thanks!
> v5:
> 	- Changed cvq_lock to a mutex.
> 	- Changed dim_lock to mutex, because it's held taking
> 	  the cvq_lock.
> 	- Use spin/mutex_lock/unlock vs guard macros.
> v4:
> 	- Protect dim_enabled with same lock as well intr_coal.
> 	- Rename intr_coal_lock to dim_lock.
> 	- Remove some scoped_guard where the error path doesn't
> 	  have to be in the lock.
> v3:
> 	- Changed type of _offloads to __virtio16 to fix static
> 	  analysis warning.
> 	- Moved a misplaced hunk to the correct patch.
> v2:
> 	- New patch to only process the provided queue in
> 	  virtnet_dim_work
> 	- New patch to lock per queue rx coalescing structure.
>
> Daniel Jurgens (6):
>    virtio_net: Store RSS setting in virtnet_info
>    virtio_net: Remove command data from control_buf
>    virtio_net: Add a lock for the command VQ.
>    virtio_net: Do DIM update for specified queue only
>    virtio_net: Add a lock for per queue RX coalesce
>    virtio_net: Remove rtnl lock protection of command buffers
>
>   drivers/net/virtio_net.c | 276 +++++++++++++++++++++++----------------
>   1 file changed, 163 insertions(+), 113 deletions(-)
>

