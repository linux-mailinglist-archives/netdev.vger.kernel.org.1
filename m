Return-Path: <netdev+bounces-47903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DB57EBCAD
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 05:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7DF21F24902
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 04:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBE310FF;
	Wed, 15 Nov 2023 04:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2671A7E
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 04:52:21 +0000 (UTC)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E54DA
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 20:52:19 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VwRTcUH_1700023933;
Received: from 30.221.148.252(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VwRTcUH_1700023933)
          by smtp.aliyun-inc.com;
          Wed, 15 Nov 2023 12:52:15 +0800
Message-ID: <b337cb82-afa8-411b-a38f-88c0d05d1aec@linux.alibaba.com>
Date: Wed, 15 Nov 2023 12:52:11 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 5/5] virtio-net: return -EOPNOTSUPP for
 adaptive-tx
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 "David S . Miller" <davem@davemloft.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Simon Horman <horms@kernel.org>,
 xuanzhuo@linux.alibaba.com
References: <cover.1699938946.git.hengqi@linux.alibaba.com>
 <6a79229fbeb72edf41185a45a0f9ea5cd87a1086.1699938946.git.hengqi@linux.alibaba.com>
 <20231114232305.4cd58415@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20231114232305.4cd58415@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2023/11/15 下午12:23, Jakub Kicinski 写道:
> On Tue, 14 Nov 2023 13:55:47 +0800 Heng Qi wrote:
>> We do not currently support tx dim, so respond to -EOPNOTSUPP.
> Hm, why do you need this? You don't set ADAPTIVE_TX in
> .supported_coalesce_params, so core should prevent attempts
> to enable ADAPTIVE_TX.

Indeed. Will drop this.

Thanks!



