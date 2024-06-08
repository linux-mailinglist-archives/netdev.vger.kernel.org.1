Return-Path: <netdev+bounces-101985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5E5900F72
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 06:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBA821F229B2
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 04:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D5ADDDA;
	Sat,  8 Jun 2024 04:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mTtAnQj9"
X-Original-To: netdev@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03489E57E;
	Sat,  8 Jun 2024 04:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717820281; cv=none; b=ddhKeCKkPHHyy5l4X+YEBwqGWN90s3B3gPrLHduO0O+dSfS/NL78LfdEkIu94JoM94qH+F6yBgHGKxGiDdN8OVOGShzrlDstbMpp9k3vE1Tl7XbeAWFGRpH2aRHInMhvwWKFgz95v5xN3pDZruX1S/Dt3MoAeudWtMsjNnVpLU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717820281; c=relaxed/simple;
	bh=ekmqOcLE4iH6H9/1UXBJARqZityuqrevYo5eanX1HBg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dvxr6anWLqfL+M8m4kYdCOGjP9KCf73wOx2aatH57VQQRqv6erhMSuq80vUAvGik/4e005wJ6uX9SSxTcthKQ/zsMtav0GuNkDgWPZ73xGzAcBTFHPq8njBDrNSmJM4PqBnHVt/J3b6vUW0kgBbug4DnfdbI1iBCtwRtMScvzqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mTtAnQj9; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717820270; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=Ttp/o9fQaKCeIOlWsO2k2ss4apRk3x0NTTyLGlgh39o=;
	b=mTtAnQj9U2IIMqAM8uD89YfVxCnX5XgIO59S17LHUEa3VaPVG5tRadtSALzWRZ/mL7bPwOymnUpXP61t0sx5h9OjIFfOZdiDJsv9zvlPqxcOVTsI+4/q5eJj/eNMcggm8/U6BItqhVx/dd0Fe2sRJTz04HNncsthJCs+o/DJTaU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=31;SR=0;TI=SMTPD_---0W80ed0T_1717820266;
Received: from 30.39.231.133(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W80ed0T_1717820266)
          by smtp.aliyun-inc.com;
          Sat, 08 Jun 2024 12:17:48 +0800
Message-ID: <2279297c-ac6e-46ed-b1a7-5229bc622f09@linux.alibaba.com>
Date: Sat, 8 Jun 2024 12:17:46 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v14 0/5] ethtool: provide the dim profile
 fine-tuning channel
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Brett Creeley <bcreeley@amd.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Tal Gilboa <talgi@nvidia.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jiri Pirko <jiri@resnulli.us>, Paul Greenwalt <paul.greenwalt@intel.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>, justinstitt@google.com,
 donald.hunter@gmail.com, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Dragos Tatulea <dtatulea@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 awel Dembicki <paweldembicki@gmail.com>
References: <20240603154727.31998-1-hengqi@linux.alibaba.com>
In-Reply-To: <20240603154727.31998-1-hengqi@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Gentle ping.

Thanks.

在 2024/6/3 下午11:47, Heng Qi 写道:
> The NetDIM library provides excellent acceleration for many modern
> network cards. However, the default profiles of DIM limits its maximum
> capabilities for different NICs, so providing a way which the NIC can
> be custom configured is necessary.
>
> Currently, the way is based on the commonly used "ethtool -C".
>
> Please review, thank you very much!
>
> Changelog
> =====
> v13->v14:
>    - Make DIMLIB dependent on NET (patch 2/5).
>
> v12->v13:
>    - Rebase net-next to fix the one-line conflict.
>    - Update tiny comments.
>    - Config ETHTOOL_NETLINK to select DIMLIB.
>
> v11->v12:
>    - Remove the use of IS_ENABLED(DIMLIB).
>    - Update Simon's htmldoc hint.
>
> v10->v11:
>    - Fix and clean up some issues from Kuba, thanks.
>    - Rebase net-next/main
>
> v9->v10:
>    - Collect dim related flags/mode/work into one place.
>    - Use rx_profile + tx_profile instead of four profiles.
>    - Add several helps.
>    - Update commit logs.
>
> v8->v9:
>    - Fix the compilation error of conflicting names of rx_profile in
>      dim.h and ice driver: in dim.h, rx_profile is replaced with
>      dim_rx_profile. So does tx_profile.
>
> v7->v8:
>    - Use kmemdup() instead of kzalloc()/memcpy() in dev_dim_profile_init().
>
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
>    - Update some snippets from Kuba.
>
> v3->v4:
>    - Some tiny updates and patch 1 only add a new comment.
>
> v2->v3:
>    - Break up the attributes to avoid the use of raw c structs.
>    - Use per-device profile instead of global profile in the driver.
>
> v1->v2:
>    - Use ethtool tool instead of net-sysfs.
>
> Heng Qi (5):
>    linux/dim: move useful macros to .h file
>    dim: make DIMLIB dependent on NET
>    ethtool: provide customized dim profile management
>    dim: add new interfaces for initialization and getting results
>    virtio-net: support dim profile fine-tuning
>
>   Documentation/netlink/specs/ethtool.yaml     |  31 +++
>   Documentation/networking/ethtool-netlink.rst |   4 +
>   Documentation/networking/net_dim.rst         |  42 +++
>   drivers/net/virtio_net.c                     |  54 +++-
>   drivers/soc/fsl/Kconfig                      |   2 +-
>   include/linux/dim.h                          | 113 ++++++++
>   include/linux/ethtool.h                      |   4 +-
>   include/linux/netdevice.h                    |   3 +
>   include/uapi/linux/ethtool_netlink.h         |  22 ++
>   lib/Kconfig                                  |   1 +
>   lib/dim/net_dim.c                            | 144 +++++++++-
>   net/Kconfig                                  |   1 +
>   net/ethtool/coalesce.c                       | 263 ++++++++++++++++++-
>   13 files changed, 667 insertions(+), 17 deletions(-)
>

