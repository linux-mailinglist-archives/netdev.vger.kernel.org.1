Return-Path: <netdev+bounces-60131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16ED681D86C
	for <lists+netdev@lfdr.de>; Sun, 24 Dec 2023 09:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE101281EBF
	for <lists+netdev@lfdr.de>; Sun, 24 Dec 2023 08:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4751117;
	Sun, 24 Dec 2023 08:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kMVuhCXa"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F98846A0
	for <netdev@vger.kernel.org>; Sun, 24 Dec 2023 08:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dc506381-1408-46b7-9be0-403f819cee38@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703408119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fVdcs3Ctk02ImHVSOg5WJdjGh4KoKAx3MLEgb2sROMI=;
	b=kMVuhCXaaUDu80xzk+hBmL1uVtHsgUQRz3HWzVXFVcnMsCMnU7zLtGKzYxkpMyBg6LWb9N
	lfNKLCJbuJ6LU5mO+qFmlRjkPOv+iq2lylAkiSXdoFmVbNQx7klaGL7GJSofYFBjP1qwYY
	PTiRndgO9bo+MC+SbjH6i5M7FehVmR8=
Date: Sun, 24 Dec 2023 16:55:08 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 3/6] virtio_net: support device stats
To: kernel test robot <lkp@intel.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev
References: <20231222033021.20649-4-xuanzhuo@linux.alibaba.com>
 <202312240155.ow7kvQZO-lkp@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <202312240155.ow7kvQZO-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2023/12/24 1:23, kernel test robot 写道:
> Hi Xuan,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on mst-vhost/linux-next]
> [also build test WARNING on linus/master v6.7-rc6]
> [cannot apply to net-next/main horms-ipvs/master next-20231222]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Xuan-Zhuo/virtio_net-introduce-device-stats-feature-and-structures/20231222-175505
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
> patch link:    https://lore.kernel.org/r/20231222033021.20649-4-xuanzhuo%40linux.alibaba.com
> patch subject: [PATCH net-next 3/6] virtio_net: support device stats
> config: arc-haps_hs_defconfig (https://download.01.org/0day-ci/archive/20231224/202312240155.ow7kvQZO-lkp@intel.com/config)
> compiler: arc-elf-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231224/202312240155.ow7kvQZO-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312240155.ow7kvQZO-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>     In file included from include/linux/virtio_net.h:8,
>                      from drivers/net/virtio_net.c:12:
>>> include/uapi/linux/virtio_net.h:419:45: warning: left shift count >= width of type [-Wshift-count-overflow]
>       419 | #define VIRTIO_NET_STATS_TYPE_CVQ       (1L << 32)
>           |                                             ^~
>     drivers/net/virtio_net.c:215:17: note: in expansion of macro 'VIRTIO_NET_STATS_TYPE_CVQ'
>       215 |                 VIRTIO_NET_STATS_TYPE_##TYPE,                   \
>           |                 ^~~~~~~~~~~~~~~~~~~~~~
>     drivers/net/virtio_net.c:224:9: note: in expansion of macro 'VIRTNET_DEVICE_STATS_MAP_ITEM'
>       224 |         VIRTNET_DEVICE_STATS_MAP_ITEM(CVQ, cvq, CQ),
>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> 
> vim +419 include/uapi/linux/virtio_net.h
> 
> ba106d1c676c80 Xuan Zhuo 2023-12-22  418
> ba106d1c676c80 Xuan Zhuo 2023-12-22 @419  #define VIRTIO_NET_STATS_TYPE_CVQ       (1L << 32)

#define VIRTIO_NET_STATS_TYPE_CVQ       (1ULL << 32)
The above can fix this problem.
Not sure whether this is appropriate for the whole patches.

Zhu Yanjun

> ba106d1c676c80 Xuan Zhuo 2023-12-22  420
> 


