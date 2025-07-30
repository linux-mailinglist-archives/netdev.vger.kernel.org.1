Return-Path: <netdev+bounces-210917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2739B15755
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 03:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308645612C7
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 01:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FD71C5F06;
	Wed, 30 Jul 2025 01:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cFW/GKps"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07731DED42
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 01:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753840518; cv=none; b=A7IsvlYQl041iiNAEUIMGDZ+3clbhJ8PYxb+NDEIsQRKEjVRJL5cshkU2VGlHZeGLPHbDZqrMfOTexck7DJM876e56arbBxRSQqf832IkT/yVf/dvx/eK2WNB17gCm9/kBXMcSrrYshbW/jHv2SmYIgjVa5SIhFxoEcv5jqx95o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753840518; c=relaxed/simple;
	bh=revpl56mPq9KLBzHa8CWXLrKv7rkFACf5P5lX0gZwDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r2H7fzglkgNZRW7JYnLhmjGnGr7jVg9THFyhHka7bUT171jzDonj+8xiuVsbfjd45Nkn4L30npQhxwewJ0FV17rvyOoIZrqJK24jsRjD+UceqlCAMWnXJU6meiVyFZNRKmvk2rn09TYw6egPZGYElCzRoZUPNV1jnyXnNU9D+QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cFW/GKps; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7083544f-5b0c-432e-bec8-509ca733f316@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753840504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bBtDeEQmDVhAbCwRLb1FMhSSfBFoIGvei1/u976ODoM=;
	b=cFW/GKpstUwfA0eP64NEgFb+fMg5cHQC4yPqe+JA0B2ivT3Pu6QPj4QsfAt9pOakE+i3C0
	dU5eMBP8v+uNHZpzL7xCNXAd2QmYo+XXYePnIrEtk7Cugeq/oenIX5pjTFwIxkD99xed1T
	uT3yLlujhn3HJgh+LghAu/0+y8DuyEQ=
Date: Tue, 29 Jul 2025 18:54:58 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 0/4] bpf: add icmp_send_unreach kfunc
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, coreteam@netfilter.org, daniel@iogearbox.net,
 fw@strlen.de, john.fastabend@gmail.com, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
 pablo@netfilter.org, lkp@intel.com
References: <202507270940.kXGmRbg5-lkp@intel.com>
 <20250728094345.46132-1-mahe.tardy@gmail.com>
 <b36532a2-506b-4ba5-b6a3-a089386a190e@linux.dev> <aIiaB2QUxKmhvPlx@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <aIiaB2QUxKmhvPlx@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/29/25 2:53 AM, Mahe Tardy wrote:
>> Which other program types do you need this kfunc to send icmp and the future
>> tcp rst?
> 
> I don't really know, I mostly need this in cgroup_skb for my use case
> but I could see other programs type using this either for simplification
> (for progs that can already rewrite the packet, like tc) or other
> programs types like cgroup_skb, because they can't touch the packet
> themselves.

I also don't think the tc needs this kfunc either. The tc should already have 
ways to do this now.

> 
>>
>> This cover letter mentioned sending icmp unreach is easier than sending tcp
>> rst. What problems do you see in sending tcp rst?
>>
> 
> Yes, I based these patches on what net/ipv4/netfilter/ipt_REJECT.c's
> 'reject_tg' function does. In the case of sending ICMP unreach
> 'nf_send_unreach', the routing step is quite straighforward as they are
> only inverting the daddr and the saddr (that's what my renamed/moved
> ip_route_reply_fetch_dst helper does).
> 
> In the case of sending RST 'nf_send_reset', there are extra steps, first
> the same routing mechanism is done by just inverting the daddr and the
> saddr but later 'ip_route_me_harder' is called which is doing a lot
> more. I'm currently not sure which parts of this must be ported to work
> in our BPF use case so I wanted to start with unreach.

I don't think we necessarily need to completely borrow from nf, the hooks' 
locations are different and the use case may be different.

A concern that I have is the icmp6_send called by the kfunc. The icmp6_send 
should eventually call to ip6_finish_output which may call the very same 
"cgroup/egress" program again in a recursive way. The same for v4 icmp_send.

The icmp packet is sent from an internal kernel sk. I suspect you will see this 
recursive behavior if the test is done in the default cgroup (/sys/fs/cgroup). I 
think the is_ineligible(skb) should have stopped the second icmpv6_send from 
replying to an icmp error and the cgroup hook cannot change the skb. However, I 
am not sure I want to cross this bridge. Is there a way to avoid the recursive 
bpf prog?



