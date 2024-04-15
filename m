Return-Path: <netdev+bounces-87982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C58978A51C5
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 15:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65FFC1F25A4D
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84721839E1;
	Mon, 15 Apr 2024 13:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YY6VTf1h"
X-Original-To: netdev@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB8682D90
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188168; cv=none; b=KFh4J/dE6y+67Tlllt62HdROa4W65QI5hxAqyOAEQHo4O1kgoYUCnsguMVJy+z3vJfPyRILpo0aoVMnGokEZRSakDn5mPenOh5k4N0Cay6ElgemWP4NLxOWVulW/acAOmHknW2orNRHt63pJIFRo2GqmENptrJ5KbxwK2hFpGLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188168; c=relaxed/simple;
	bh=wGaMa+KOfTiW5xuil3OgXn9uqy3fmWwe5sHpWq8sf9o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AexBt+6+bHOagEKiB4UGUqU5sSYV6WfIqSxuQ2pKNWQ+uRgsAI9ElKEnvsPQQZS29fMJF5/pozWObTu4Bif+KJeKGYgD3tjDdkibxysW7EqeDGY9kvoa7PGEDrcjcswVw7nqgcffZdtSU0kXCcaEmimpUJLhPZQ4ssTAECsUbL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YY6VTf1h; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713188161; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=onHUkSas/liov7LlRE6vK59DBrXH4QUKrvbWcxENMmk=;
	b=YY6VTf1hxuUaJUbMNK7j8anFX8mXbltNEZW3Cv7cOe/avWau60RGEbvFy/1M17iQJXEpohQ36FKbHPOr6Al1Ap8aUqk/+IkgioexmIpEqEsVogvhklJ/qnR0WTzZAgXRB3k+9dmVZiIWyCykbDXs8HEzwbUIt/nj0ZIGT+TpKqU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W4eOLRG_1713188159;
Received: from 30.221.148.177(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4eOLRG_1713188159)
          by smtp.aliyun-inc.com;
          Mon, 15 Apr 2024 21:36:00 +0800
Message-ID: <8f9f680b-c342-42b1-89be-b359ec6b8297@linux.alibaba.com>
Date: Mon, 15 Apr 2024 21:35:59 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 0/4] ethtool: provide the dim profile
 fine-tuning channel
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org, virtualization@lists.linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Brett Creeley <bcreeley@amd.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20240415093638.123962-1-hengqi@linux.alibaba.com>
In-Reply-To: <20240415093638.123962-1-hengqi@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Please ignore this set, "RESEND v7" will be used instead.

在 2024/4/15 下午5:36, Heng Qi 写道:
> The NetDIM library provides excellent acceleration for many modern
> network cards. However, the default profiles of DIM limits its maximum
> capabilities for different NICs, so providing a way which the NIC can
> be custom configured is necessary.
>
> Currently, interaction with the driver is still based on the commonly
> used "ethtool -C".
>
> Since the profile now exists in netdevice, adding a function similar
> to net_dim_get_rx_moderation_dev() with netdevice as argument is
> nice, but this would be better along with cleaning up the rest of
> the drivers, which we can get to very soon after this set.
>
> Please review, thank you very much!
>
> Changelog
> =====
> v6->v7:
>    - A new wrapper struct pointer is used in struct net_device.
>    - Add IS_ENABLED(CONFIG_DIMLIB) to avoid compiler warnings.
>    - Profile fields changed from u16 to u32.
>
> v5->v6:
>    - Place the profile in netdevice to bypass the driver.
>      The interaction code of ethtool <-> kernel has not changed at all,
>      only the interaction part of kernel <-> driver has changed.
>
> v4->v5:
>    - Update some snippets from Kuba, Thanks.
>
> v3->v4:
>    - Some tiny updates and patch 1 only add a new comment.
>
> v2->v3:
>    - Break up the attributes to avoid the use of raw c structs.
>    - Use per-device profile instead of global profile in the driver.
>
> v1->v2:
>    - Use ethtool tool instead of net-sysfs
>
> Heng Qi (4):
>    linux/dim: move useful macros to .h file
>    ethtool: provide customized dim profile management
>    virtio-net: refactor dim initialization/destruction
>    virtio-net: support dim profile fine-tuning
>
>   Documentation/netlink/specs/ethtool.yaml     |  33 +++
>   Documentation/networking/ethtool-netlink.rst |   8 +
>   drivers/net/virtio_net.c                     |  46 +++--
>   include/linux/dim.h                          |  13 ++
>   include/linux/ethtool.h                      |  11 +-
>   include/linux/netdevice.h                    |  24 +++
>   include/uapi/linux/ethtool_netlink.h         |  24 +++
>   lib/dim/net_dim.c                            |  10 +-
>   net/core/dev.c                               |  83 ++++++++
>   net/ethtool/coalesce.c                       | 199 ++++++++++++++++++-
>   10 files changed, 428 insertions(+), 23 deletions(-)
>


