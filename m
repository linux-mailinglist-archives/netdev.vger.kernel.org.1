Return-Path: <netdev+bounces-103570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038C2908AC6
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 13:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B9B2888A0
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 11:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBE414B091;
	Fri, 14 Jun 2024 11:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EKJLlbFT"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08D113B2AD
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718364463; cv=none; b=H7Ayi+40tven2iHuVUbWWi6l1YGMDLoOaHHPFoZE2+8EVi/vaZGFgjB8qDvLiAC3W7q5eEDgH5fDDh+WXyfVAWN5SGPXF5gG8dZ0Kvlxj1UNZLqtIS6+jPKAOSD/BhioApFTJmE55IycbAKDltAedupoI1ca/fLiIMpVf7/n14Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718364463; c=relaxed/simple;
	bh=qJoytK/Xjas/UAvR+XGvkcsE5M2lOqZ5ixpvyfacx8o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DG4S44QdPKHnoKobkSDiJ9st109CoTT7ttym8en5uZP8VKllAtixAvyA0GMc/fQQXdw6eO8DWfiSDaS+NohgP8oLDSFCNbFVQotjhxaC6UeI66qBa1P+k7aAXFcFS8lFhjdSbGVTZ0KuOhPogJZAXe3oOX3xA6Ef/hV53Cx4Yc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EKJLlbFT; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718364459; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=/xi0LH0zFdkGfjRZOqxRRwbakY81T/y0b5hCkzGfw9U=;
	b=EKJLlbFT6KL4Sj1ZjhNuBcV5NgxPK1l6QYW2/7fDSjVG/HHIlMoPv31rAQLX+95vRtKO6u3oAmekURZaihxoOHJ+fTriSzd9a0AJoydMk28VfbI+9anILLVBf8FDjSSH0T8HAdxIU5I+6UJmXwn9HcbmF6ZJIuYGQB+f4dvJw4A=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W8R.y7A_1718364457;
Received: from 30.221.128.116(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0W8R.y7A_1718364457)
          by smtp.aliyun-inc.com;
          Fri, 14 Jun 2024 19:27:38 +0800
Message-ID: <86515ee3-13d7-4bed-8e04-3c519278d314@linux.alibaba.com>
Date: Fri, 14 Jun 2024 19:27:37 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Philo Lu <lulie@linux.alibaba.com>
Subject: Re: [PATCH net-next] tcp: Add tracepoint for rxtstamp coalescing
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 edumazet@google.com
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
 xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com
References: <20240611045830.67640-1-lulie@linux.alibaba.com>
 <c4ae602bd44e6b6ad739e1e17c444ca75587435e.camel@redhat.com>
In-Reply-To: <c4ae602bd44e6b6ad739e1e17c444ca75587435e.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/14 16:09, Paolo Abeni wrote:
> On Tue, 2024-06-11 at 12:58 +0800, Philo Lu wrote:
>> During tcp coalescence, rx timestamps of the former skb ("to" in
>> tcp_try_coalesce), will be lost. This may lead to inaccurate
>> timestamping results if skbs come out of order.
>>
>> Here is an example.
>> Assume a message consists of 3 skbs, namely A, B, and C. And these skbs
>> are processed by tcp in the following order:
>> A -(1us)-> C -(1ms)-> B
> 
> IMHO the above order makes the changelog confusing
>
Thank you for pointing out this, I'll try to explain it in another way.

Here it means these packets come in order of A-C-B, and B comes much 
later than C, such as 1ms later. Currently, the 1ms delay would be lost 
because of tcp coalescing.

-- 
Philo

