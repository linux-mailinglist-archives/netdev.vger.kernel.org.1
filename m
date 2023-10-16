Return-Path: <netdev+bounces-41172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E67B7CA0F3
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 09:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2A61C203A4
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 07:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AFE171D0;
	Mon, 16 Oct 2023 07:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AD9A2D
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 07:45:50 +0000 (UTC)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF5E95
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 00:45:47 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VuDg77G_1697442342;
Received: from 30.221.149.148(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VuDg77G_1697442342)
          by smtp.aliyun-inc.com;
          Mon, 16 Oct 2023 15:45:43 +0800
Message-ID: <06d90cc8-ccc0-4b2f-ad42-2db4a6fb229f@linux.alibaba.com>
Date: Mon, 16 Oct 2023 15:45:38 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/5] virtio-net: separate rx/tx coalescing
 moderation cmds
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Simon Horman <horms@kernel.org>,
 "Liu, Yujie" <yujie.liu@intel.com>
References: <cover.1697093455.git.hengqi@linux.alibaba.com>
 <dc171e2288d2755b1805afde6b394d2d443a134d.1697093455.git.hengqi@linux.alibaba.com>
 <20231013181148.3fd252dc@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20231013181148.3fd252dc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



在 2023/10/14 上午9:11, Jakub Kicinski 写道:
> On Thu, 12 Oct 2023 15:44:06 +0800 Heng Qi wrote:
>> +
>> +static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
>> +					  struct ethtool_coalesce *ec)
>> +{
>> +	struct scatterlist sgs_rx;
>> +
> ../drivers/net/virtio_net.c: In function ‘virtnet_send_rx_notf_coal_cmds’:
> ../drivers/net/virtio_net.c:3306:14: error: ‘i’ undeclared (first use in this function); did you mean ‘vi’?
>   3306 |         for (i = 0; i < vi->max_queue_pairs; i++) {
>        |              ^
>        |              vi

Will fix in the next version.

Thanks!



