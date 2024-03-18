Return-Path: <netdev+bounces-80381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C572387E8F6
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 12:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 661011F23291
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 11:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F84376F4;
	Mon, 18 Mar 2024 11:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sX77BY3t"
X-Original-To: netdev@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46313374DD;
	Mon, 18 Mar 2024 11:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710762834; cv=none; b=RuKHyogqwUOfpPjUWx/q4qXk/3Wlan1rNI1ghtv0XcNS0lrtVz6C267DWWi+kBvjk909BU3TJqrApqzhSoLdyl4SvX2TRRuyWa6OucNcbh9IyTf8cdYjTT2CNNkPn88oBXmOOTrL70ZYUwcNhvgCAatlsymGnZKxQULlvlyBCGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710762834; c=relaxed/simple;
	bh=W6g4yZ4VJx/sK33OAzIbSo9XH2RCMHDyntFci0j3bqw=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=u+UZRJDm0GbgPJhanIMlWJykEUw+haMPkJBYwx2hVfNQUK1eteOuIIgXXH7kJvojyf3s4UOkL/5+NMk2YHt2Ap1UxuHrPy+gkA5DlON6niIoOWCo3KVGd/1tYzq2D+Vjx9qWYgAn4YO1QdBaizrZysfQdJuZWedFu8pkZ1WWz/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sX77BY3t; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710762830; h=Message-ID:Subject:Date:From:To;
	bh=W6g4yZ4VJx/sK33OAzIbSo9XH2RCMHDyntFci0j3bqw=;
	b=sX77BY3tAJd7dwz/8hgx8qv2g+oRmDgsywjNwEwWkrAixGAI0OYza71r9g9DBF+j1VMef5EmsCVojb0K9nJkCBCYCwx5nvR2Yy510SYEwYF2V+YIZmGOVsmaK3nEdKd4wrg+71rZEzkDJGd6jjRXFV86KTzuD3tErs0X8ncjJ8Y=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W2ndA9H_1710762827;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W2ndA9H_1710762827)
          by smtp.aliyun-inc.com;
          Mon, 18 Mar 2024 19:53:48 +0800
Message-ID: <1710762818.1520293-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 0/9] virtio-net: support device stats
Date: Mon, 18 Mar 2024 19:53:38 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@google.com>,
 Amritha Nambiar <amritha.nambiar@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org
References: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com>
 <Zfgq8k2Q-olYWiuw@nanopsycho>
In-Reply-To: <Zfgq8k2Q-olYWiuw@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Mon, 18 Mar 2024 12:52:18 +0100, Jiri Pirko <jiri@resnulli.us> wrote:
> Mon, Mar 18, 2024 at 12:05:53PM CET, xuanzhuo@linux.alibaba.com wrote:
> >As the spec:
> >
> >https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82
> >
> >The virtio net supports to get device stats.
> >
> >Please review.
>
> net-next is closed. Please resubmit next week.


For review.

Thanks.

