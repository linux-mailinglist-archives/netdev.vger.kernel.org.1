Return-Path: <netdev+bounces-52171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA7C7FDB16
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 16:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44131B2126E
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 15:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAE3374F9;
	Wed, 29 Nov 2023 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KVed2Zjg"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EB0E6
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 07:22:39 -0800 (PST)
Message-ID: <b699fbc8-260a-48e9-b6cc-8bfecd09afed@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701271358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HQiZ+7wAuSeNjpj8apTyPg8hJlrrmCrTI0XRLYKF0N8=;
	b=KVed2Zjgv7XeII9r2X+MTlQ6MpHbUpzjRjxCRVryPjqS7WQgL/klPvl0DGCIJtn+2HJ9i0
	zpbKIVf6tnVZwxthxtzt9g6JYlqiuCCWus9aNEciqYzPTrPZXLvo98bW6UJ4CPgjB7NzAd
	duAQwvGTlZusGXFH/EPUzS2lSrfQJfM=
Date: Wed, 29 Nov 2023 23:22:30 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/5] virtio_net: Add page_pool support to improve
 performance
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Liang Chen <liangchen.linux@gmail.com>, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, xuanzhuo@linux.alibaba.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, pabeni@redhat.com,
 alexander.duyck@gmail.com
References: <20230526054621.18371-1-liangchen.linux@gmail.com>
 <20230526054621.18371-2-liangchen.linux@gmail.com>
 <c745f67e-91e6-4a32-93f2-dc715056eb51@linux.dev>
 <20231129095825-mutt-send-email-mst@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20231129095825-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2023/11/29 22:59, Michael S. Tsirkin 写道:
> On Wed, Nov 29, 2023 at 10:50:57PM +0800, Zhu Yanjun wrote:
>> 在 2023/5/26 13:46, Liang Chen 写道:
>
> what made you respond to a patch from May, now?

I want to apply page_pool to our virtio_net. This virtio_net works on 
our device.

I want to verify whether page_pool on virtio_net with our device can 
improve the performance or not.

And I found that ethtool is wrong.

I use virtio_net on our device. I found that page member variable in rq 
is not used in recv path.

When virtio_net is modprobe, I checked page member variable in rq with 
kprobe or crash tool.  page member variable in rq is always NULL.

But sg in recv path is used.

So how to use page member variable in rq? If page member variable in rq 
is always NULL, can we remove it?

BTW, I use ping and iperf tool to make tests with virtio_net. In the 
tests, page member variable in rq is always NULL.

It is interesting.

Zhu Yanjun

>

