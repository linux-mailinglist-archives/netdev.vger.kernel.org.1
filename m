Return-Path: <netdev+bounces-55702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AEE80C029
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 04:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CB89B20403
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 03:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C5A168D5;
	Mon, 11 Dec 2023 03:57:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AAEF2
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 19:56:56 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0Vy9pc7B_1702267012;
Received: from 30.221.148.156(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0Vy9pc7B_1702267012)
          by smtp.aliyun-inc.com;
          Mon, 11 Dec 2023 11:56:54 +0800
Message-ID: <9fcc649f-8c0c-41da-9372-3c489859274d@linux.alibaba.com>
Date: Mon, 11 Dec 2023 11:56:48 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 4/4] virtio-net: support rx netdim
To: "Michael S. Tsirkin" <mst@redhat.com>, kernel test robot <lkp@intel.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oe-kbuild-all@lists.linux.dev, jasowang@redhat.com, pabeni@redhat.com,
 kuba@kernel.org, yinjun.zhang@corigine.com, edumazet@google.com,
 davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
 ast@kernel.org, horms@kernel.org, xuanzhuo@linux.alibaba.com
References: <9be20d1e86bea91b373f28401a96401b640ef4d1.1701929854.git.hengqi@linux.alibaba.com>
 <202312091132.7eR6Cbs9-lkp@intel.com>
 <20231209052724-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20231209052724-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2023/12/9 下午6:27, Michael S. Tsirkin 写道:
> On Sat, Dec 09, 2023 at 11:22:11AM +0800, kernel test robot wrote:
>> Hi Heng,
>>
>> kernel test robot noticed the following build errors:
>>
>> [auto build test ERROR on net-next/main]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Heng-Qi/virtio-net-returns-whether-napi-is-complete/20231207-143044
>> base:   net-next/main
>> patch link:    https://lore.kernel.org/r/9be20d1e86bea91b373f28401a96401b640ef4d1.1701929854.git.hengqi%40linux.alibaba.com
>> patch subject: [PATCH net-next v7 4/4] virtio-net: support rx netdim
>> config: nios2-randconfig-r064-20231209 (https://download.01.org/0day-ci/archive/20231209/202312091132.7eR6Cbs9-lkp@intel.com/config)
>> compiler: nios2-linux-gcc (GCC) 13.2.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231209/202312091132.7eR6Cbs9-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202312091132.7eR6Cbs9-lkp@intel.com/
>>
>> All errors (new ones prefixed by >>):
>>
>>     nios2-linux-ld: drivers/net/virtio_net.o: in function `virtnet_rx_dim_work':
>>     virtio_net.c:(.text+0x21dc): undefined reference to `net_dim_get_rx_moderation'
>>>> virtio_net.c:(.text+0x21dc): relocation truncated to fit: R_NIOS2_CALL26 against `net_dim_get_rx_moderation'
>>     nios2-linux-ld: drivers/net/virtio_net.o: in function `virtnet_poll':
>>     virtio_net.c:(.text+0x97bc): undefined reference to `net_dim'
>>>> virtio_net.c:(.text+0x97bc): relocation truncated to fit: R_NIOS2_CALL26 against `net_dim'
>
> Looks like select DIMLIB is missing?

Yes. I'll add this. Thanks!

>> -- 
>> 0-DAY CI Kernel Test Service
>> https://github.com/intel/lkp-tests/wiki


