Return-Path: <netdev+bounces-46570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0FE7E502B
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 06:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 068042812F3
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 05:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27F2CA5F;
	Wed,  8 Nov 2023 05:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A1C8F5B;
	Wed,  8 Nov 2023 05:50:40 +0000 (UTC)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016E71705;
	Tue,  7 Nov 2023 21:50:38 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VvweDUc_1699422633;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VvweDUc_1699422633)
          by smtp.aliyun-inc.com;
          Wed, 08 Nov 2023 13:50:34 +0800
Message-ID: <1699422583.92944-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 00/21] virtio-net: support AF_XDP zero copy
Date: Wed, 8 Nov 2023 13:49:43 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric  Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 "Michael S.  Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alexei  Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux-foundation.org,
 bpf@vger.kernel.org
References: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com>
 <20231107100148.560d764a@kernel.org>
In-Reply-To: <20231107100148.560d764a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Tue, 7 Nov 2023 10:01:48 -0800, Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue,  7 Nov 2023 11:12:06 +0800 Xuan Zhuo wrote:
> > Please review.
>
> ## Form letter - net-next-closed
>
> The merge window for v6.7 has begun and we have already posted our pull
> request. Therefore net-next is closed for new drivers, features, code
> refactoring and optimizations. We are currently accepting bug fixes only.
>
> Please repost when net-next reopens after Nov 12th.
>
> RFC patches sent for review only are obviously welcome at any time.


Yes. This is for review.

Thanks.

>
> See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
> --
> pw-bot: defer

