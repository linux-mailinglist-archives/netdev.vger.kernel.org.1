Return-Path: <netdev+bounces-60130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC1281D861
	for <lists+netdev@lfdr.de>; Sun, 24 Dec 2023 09:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14BF4B217E0
	for <lists+netdev@lfdr.de>; Sun, 24 Dec 2023 08:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E591FECB;
	Sun, 24 Dec 2023 08:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xienUmTN"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E062620F8
	for <netdev@vger.kernel.org>; Sun, 24 Dec 2023 08:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2f475009-709a-4e0b-8711-51fd4a938763@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703407249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xniFk5TJQq0x7QayvNm1iGquiN4ClihcHbvk3cB5Wr8=;
	b=xienUmTNwVbZOK1fCRRuTF/pyRI3LSa8h3F28wXiqiRFdldSl45s8MZSI144ao72lAz5K5
	WjicJjyDQgnZgGWdDEHUgCQusr6AsEai9V9QVCGddubOc5MiimFIZ6AALjCHrJGIHBWnmE
	69LzA6n/LmcZjK56FETnRAxkiCUNlEc=
Date: Sun, 24 Dec 2023 16:40:42 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/6] virtio_net: introduce device stats feature
 and structures
To: kernel test robot <lkp@intel.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev
References: <20231222033021.20649-2-xuanzhuo@linux.alibaba.com>
 <202312240125.00z3nxGY-lkp@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <202312240125.00z3nxGY-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2023/12/24 1:55, kernel test robot 写道:
> Hi Xuan,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on mst-vhost/linux-next]
> [also build test ERROR on linus/master v6.7-rc6 next-20231222]
> [cannot apply to net-next/main horms-ipvs/master]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Xuan-Zhuo/virtio_net-introduce-device-stats-feature-and-structures/20231222-175505
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
> patch link:    https://lore.kernel.org/r/20231222033021.20649-2-xuanzhuo%40linux.alibaba.com
> patch subject: [PATCH net-next 1/6] virtio_net: introduce device stats feature and structures
> config: x86_64-buildonly-randconfig-002-20231223 (https://download.01.org/0day-ci/archive/20231224/202312240125.00z3nxGY-lkp@intel.com/config)
> compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231224/202312240125.00z3nxGY-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312240125.00z3nxGY-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>     In file included from <built-in>:1:
>>> ./usr/include/linux/virtio_net.h:454:2: error: unknown type name 'u8'
>             u8 type;
>             ^
>     ./usr/include/linux/virtio_net.h:455:2: error: unknown type name 'u8'
>             u8 reserved;
I can reproduce this problem.
Replacing u8 as __u8 can fix this problem.
Not sure whether __u8 is correct to the whole patches.

Zhu Yanjun

>             ^
>     2 errors generated.
> 


