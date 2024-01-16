Return-Path: <netdev+bounces-63624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59EA82E944
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 06:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A9DD28558C
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 05:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E53A883D;
	Tue, 16 Jan 2024 05:56:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6A6882E
	for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 05:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W-l-dkk_1705384600;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W-l-dkk_1705384600)
          by smtp.aliyun-inc.com;
          Tue, 16 Jan 2024 13:56:41 +0800
Message-ID: <1705384540.169184-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v1 0/6] virtio-net: support device stats
Date: Tue, 16 Jan 2024 13:55:40 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev,
 Zhu Yanjun <yanjun.zhu@linux.dev>,
 netdev@vger.kernel.org
References: <20231226073103.116153-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231226073103.116153-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Tue, 26 Dec 2023 15:30:57 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> As the spec:
>
> https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82
>
> The virtio net supports to get device stats.

Hi Jason,

Any comments for this?

Thanks



>
> Please review.
>
> Thanks.
>
> v1:
>     1. fix some definitions of the marco and the struct
>
>
> Xuan Zhuo (6):
>   virtio_net: introduce device stats feature and structures
>   virtio_net: virtnet_send_command supports command-specific-result
>   virtio_net: support device stats
>   virtio_net: stats map include driver stats
>   virtio_net: add the total stats field
>   virtio_net: rename stat tx_timeout to timeout
>
>  drivers/net/virtio_net.c        | 533 ++++++++++++++++++++++++++++----
>  include/uapi/linux/virtio_net.h | 137 ++++++++
>  2 files changed, 610 insertions(+), 60 deletions(-)
>
> --
> 2.32.0.3.g01195cf9f
>

