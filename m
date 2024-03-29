Return-Path: <netdev+bounces-83200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB18A891546
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 09:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EACEA1C21DE9
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 08:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70212E635;
	Fri, 29 Mar 2024 08:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vhUEzF/H"
X-Original-To: netdev@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2082D304
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 08:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711702586; cv=none; b=jci8DCQeH638W/Y58Oyn6oXx2d0ySUgcYgTrQRuaVW6FFy7WL+/YaQOpHrPhEP6Kb2sIhoDYVpdqDdrNg9sSK2lL4qShW3z2ZpbdPa1Z7cMe1YOnI1+5CvXOyY/UGafiq4zhDhfg784JAaoiGJQ0VUygwxMPOpcSMr5rptMPthc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711702586; c=relaxed/simple;
	bh=cpJs5kD+Lu2Q+JYdC7iinQVkG7G6gUjDO0fE+3rajzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V6dKmm4v4cx0rj6Qp6kypRFwxZLVHw76GNMJ7chzLWKZB1tML0Hj5lNkOF8yOyBvhYaUWdv+Cur/FRYyjcCRkHR/yFS9e21UFLMoyyI2EyzOAI/QWxvs/Kw77MEt6ke1QNtvF0Du7cC9nhLLafCqICDqr7GM2rYtegWQcik9MYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vhUEzF/H; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711702576; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bHYDH9T66pPClKkWBhcKxiq5qnrvCdE3+Ds9F+4j2dY=;
	b=vhUEzF/HUGBzG8zJOqAWKMUhUyW5y8YTN0szSGCOHpmB9KJMGEM21xdiRIP34m5odzLO0Q/33XdcUDWaYgi0bMXCcFG8TS/9V8C1TR4l6WLxx7WmQ5/sqVQpNxleU+m3AA6CYEgi9uEDHgJ+JggerA5TtrGhjsBKFHDh/MEPwk8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W3WCJ76_1711702573;
Received: from 30.221.147.241(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W3WCJ76_1711702573)
          by smtp.aliyun-inc.com;
          Fri, 29 Mar 2024 16:56:15 +0800
Message-ID: <7e54d23c-caa6-4bbd-aef6-26ed6a9dd889@linux.alibaba.com>
Date: Fri, 29 Mar 2024 16:56:12 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] virtio-net: support dim profile
 fine-tuning
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 "David S. Miller" <davem@davemloft.net>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, vadim.fedorenko@linux.dev,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1711531146-91920-1-git-send-email-hengqi@linux.alibaba.com>
 <1711531146-91920-3-git-send-email-hengqi@linux.alibaba.com>
 <556ec006-6157-458d-b9c8-86436cb3199d@intel.com>
 <20240327173258.21c031a8@kernel.org>
 <1711591930.8288093-2-xuanzhuo@linux.alibaba.com>
 <20240328094847.1af51a8d@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240328094847.1af51a8d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/29 上午12:48, Jakub Kicinski 写道:
> On Thu, 28 Mar 2024 10:12:10 +0800 Xuan Zhuo wrote:
>> For netdim, I think profiles are an aspect. In many cases, this can solve many
>> problems.
> Okay, but then you should try harder to hide all the config in the core.
> The driver should be blissfully unaware that the user is changing
> the settings. It should just continue calling net_dim_get_*moderation().
>
> You can create proper dim_init(), dim_destroy() functions for drivers
> to call, instead of doing
>
> 	INIT_WORK(&bla->dim.work, my_driver_do_dim_work);
>
> directly. In dim_init() you can hook the dim structure to net_device
> and then ethtool code can operation on it without driver involvement.

Ok. Will try this.

>
> About the uAPI - please make sure you add the new stuff to
> Documentation/netlink/specs/ethtool.yaml
> see: https://docs.kernel.org/next/userspace-api/netlink/specs.html
>
> And break up the attributes, please, no raw C structs of this nature:
>
> +	return nla_put(skb, attr_type, sizeof(struct dim_cq_moder) *
> +		       NET_DIM_PARAMS_NUM_PROFILES, profs);
>
> They are hard to extend.

Sorry, I don't seem to get your point, why does this make extending hard?

Are you referring to specifying ETHTOOL_A_COALESCE_RX_EQE_PROFILE
as a nested array, i.e. having each element explicitly have an attr 
name? or passing the
u16 pointer and length as arguments?

Thanks.


