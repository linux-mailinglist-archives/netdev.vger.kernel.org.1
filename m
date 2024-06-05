Return-Path: <netdev+bounces-100804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2773B8FC197
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 04:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A4681C22832
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 02:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8368124B34;
	Wed,  5 Jun 2024 02:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jvyVgnac"
X-Original-To: netdev@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52951EB36;
	Wed,  5 Jun 2024 02:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717553807; cv=none; b=hFFka/51V+mIkUXUG6vBXltYggVqnGRixtCF0s/mWaL1crnAZR0Y+/HFM8atlwdCT0UvjDgPZJrK7eD5xmufsLl7+ZNS2CD5TgkzR8YJrBmkMpITIO8Nma4LcJEfGYFlqxX6Oyo6XIO1XPv3koe5JRGdxwEx8aba7kEQYRiQpFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717553807; c=relaxed/simple;
	bh=189mdYsXxsccLCMxzEslQckd9F6l5Pkg+vVbG5gSlLA=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=HbhT5a9E7p8ZMgJsDZIuKWi3yHDpDTJzVdS2SkicZYcWzipOghoeacgSBdMgeLGf2AYMrHpunQkgU9jP0MQ46elOABLtx9igxk7UfJTG1+Cpn+nGEXWjrHbQHjvYBdAWyfK/N8YtNibbQcX0qydsVqGVOlzIdTt2jTZg2G6gTXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jvyVgnac; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717553797; h=Message-ID:Subject:Date:From:To;
	bh=ddRm+B+lk3X4PjmjFxIaCezOgjOl1Nl1gTwxZc1qjRA=;
	b=jvyVgnaci7hNTu33Ryyfer/l281TFTFFufo7oysqY38Hmxzuyh9E5GifGR6crZ7bj3NFMQoK8nA3k+3m8IdAG70V7y2XMFuaFmq6OFOLfa7/0asJPmMx1BdVOFeQmLLqRos3UPInCqIIQZigq1vb4fadP4v1fmROfQpbGg7jUL8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=38;SR=0;TI=SMTPD_---0W7sUjyI_1717553793;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W7sUjyI_1717553793)
          by smtp.aliyun-inc.com;
          Wed, 05 Jun 2024 10:16:34 +0800
Message-ID: <1717553610.6275685-4-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v14 3/5] ethtool: provide customized dim profile management
Date: Wed, 5 Jun 2024 10:13:30 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: oe-kbuild-all@lists.linux.dev,
 Huacai Chen <chenhuacai@loongson.cn>,
 Xuerui Wang <kernel@xen0n.name>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Guo Ren <guoren@kernel.org>,
 loongarch@lists.linux.dev,
 Jakub Kicinski <kuba@kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>,
 Jason Wang <jasowang@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Brett Creeley <bcreeley@amd.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Tal Gilboa <talgi@nvidia.com>,
 Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Paul Greenwalt <paul.greenwalt@intel.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>,
 justinstitt@google.com,
 donald.hunter@gmail.com,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Dragos Tatulea <dtatulea@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 kernel test robot <lkp@intel.com>
References: <20240603154727.31998-1-hengqi@linux.alibaba.com>
 <20240603154727.31998-4-hengqi@linux.alibaba.com>
 <202406040645.6z95FW1f-lkp@intel.com>
 <1717478006.038663-1-hengqi@linux.alibaba.com>
In-Reply-To: <1717478006.038663-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Tue, 4 Jun 2024 13:13:26 +0800, Heng Qi <hengqi@linux.alibaba.com> wrote:
> On Tue, 4 Jun 2024 07:00:35 +0800, kernel test robot <lkp@intel.com> wrote:
> > Hi Heng,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on net-next/main]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Heng-Qi/linux-dim-move-useful-macros-to-h-file/20240603-235834
> > base:   net-next/main
> > patch link:    https://lore.kernel.org/r/20240603154727.31998-4-hengqi%40linux.alibaba.com
> > patch subject: [PATCH net-next v14 3/5] ethtool: provide customized dim profile management
> > config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20240604/202406040645.6z95FW1f-lkp@intel.com/config)
> > compiler: loongarch64-linux-gcc (GCC) 13.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240604/202406040645.6z95FW1f-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202406040645.6z95FW1f-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> net/ethtool/coalesce.o: warning: objtool: unexpected relocation symbol type in .rela.discard.reachable
> 
> 
> I'm not sure if this seems to be related to the update of loongarch[1]?
> didn't find this warning on other architectures such as arm/openrisc/x86.

I noticed that the loongarch community has submitted a fix[1], and after applying
the fix, the robot no longer reports the warning. So the warning is specific
to the loongarch architecture.

[1] https://lore.kernel.org/all/20240604150741.30252-1-xry111@xry111.site/

Thanks.

> 
> +Cc:
> loongarch@lists.linux.dev, Guo Ren <guoren@kernel.org>,
> Xuerui Wang <kernel@xen0n.name>,
> Jiaxun Yang <jiaxun.yang@flygoat.com>,
> Huacai Chen <chenhuacai@loongson.cn>
> 
> [1] https://lore.kernel.org/all/20240322135619.1423490-1-chenhuacai@loongson.cn/
> 
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> 

