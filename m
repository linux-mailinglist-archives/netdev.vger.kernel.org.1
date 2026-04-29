Return-Path: <netdev+bounces-282291-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFH5CDzB8WkbkQEAu9opvQ
	(envelope-from <netdev+bounces-282291-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:28:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5EA4912CE
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5F173024103
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 08:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1D83B27C2;
	Wed, 29 Apr 2026 08:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uteRq7Qf"
X-Original-To: netdev@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436E03B27CD;
	Wed, 29 Apr 2026 08:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777451301; cv=none; b=tsxgyM3DOfnWqQ1g9AJ4Fdp1HDqmPCMrNJY9XaSUVyBTAndZB7A4HtcWLtK5+jkwBzX0TBmp2zXke/uUrjcDXUvv7k3yLxsPPBp7ytVKOdcFvfOeiQfnRsKGzXJ7eCKqDBKy91c9eFmYW5JCKhtgWrb4lrp35Yt3ilTxdWvw+14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777451301; c=relaxed/simple;
	bh=gp0X0IKX1nlk1W58F7GG9Yrg2G+Bl/rYge1cXsrGT8I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aozj8NLdALuNSh66tub1bNEtbfMeQ7clfvJI1HWc2DGki0Gs2cCMXJsbflylMlIO0d9RI/HLvzUHyQXdpOPL02bYINVunJRlEhUiQI2B4xfsZ6Unx5z8d1q2ikG7MjYACCIOuwmxNj2b1T2UgGpaS83bpk+07mcpI14ev2IxrNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uteRq7Qf; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1777451296; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=xSa86XxQYWXAtuebcZ/sZ7wICcG6K5woqk8TDtWkg3Y=;
	b=uteRq7Qf/W6QY8e/YDZTTWmrR6/pZTyf78FVO9u/+ou93bgp9jVzWhPRT6m5BhHSP8evCo12gKmV5ErIEbtq3lhOhbXVf0J3ygmm3886lcqR17f1eLOCxj03KoFYD7qv/LePksM9bBCAaS9yR/nPgG+9rMiK3fQypN92kedX9UA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0X1wyHwL_1777451283;
Received: from 30.221.129.232(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0X1wyHwL_1777451283 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 29 Apr 2026 16:28:14 +0800
Message-ID: <6117ac34-cf26-40b1-a522-3bbfbd7024ea@linux.alibaba.com>
Date: Wed, 29 Apr 2026 16:28:03 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] MAINTAINERS: update PTP maintainer entries after
 directory split
From: Wen Gu <guwen@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>, David Woodhouse <dwmw2@infradead.org>
Cc: tglx@kernel.org, richardcochran@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jstultz@google.com,
 anna-maria@linutronix.de, frederic@kernel.org, daniel.lezcano@kernel.org,
 sboyd@kernel.org, vladimir.oltean@nxp.com, wei.fang@nxp.com,
 xiaoning.wang@nxp.com, jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev,
 yangbo.lu@nxp.com, svens@linux.ibm.com, nick.shi@broadcom.com,
 ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, linux-fpga@vger.kernel.org,
 imx@lists.linux.dev, linux-s390@vger.kernel.org, dust.li@linux.alibaba.com,
 xuanzhuo@linux.alibaba.com, mani@kernel.org, imran.shaik@oss.qualcomm.com,
 taniya.das@oss.qualcomm.com
References: <20260407104802.34429-1-guwen@linux.alibaba.com>
 <20260407104802.34429-3-guwen@linux.alibaba.com>
 <20260412084704.743482ad@kernel.org>
 <4B889ED5-D1F6-401D-B753-89AE2037F316@infradead.org>
 <20260412095301.4fe1fe65@kernel.org>
 <ebf19246-91af-4887-b2aa-d9007921f7b2@linux.alibaba.com>
In-Reply-To: <ebf19246-91af-4887-b2aa-d9007921f7b2@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9B5EA4912CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282291-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,linutronix.de,nxp.com,linux.dev,linux.ibm.com,broadcom.com,lists.linux.dev,linux.alibaba.com,oss.qualcomm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guwen@linux.alibaba.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:url,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.alibaba.com:dkim,linux.alibaba.com:mid]



On 2026/4/13 17:00, Wen Gu wrote:
> 
> 
> On 2026/4/13 00:53, Jakub Kicinski wrote:
>> On Sun, 12 Apr 2026 17:32:22 +0100 David Woodhouse wrote:
>>> On 12 April 2026 16:47:04 BST, Jakub Kicinski <kuba@kernel.org> wrote:
>>>> On Tue,  7 Apr 2026 18:48:02 +0800 Wen Gu wrote:
>>>>> +PTP EMULATED CLOCK SUPPORT
>>>>> +M:    David Woodhouse <dwmw2@infradead.org>
>>>>> +M:    Wen Gu <guwen@linux.alibaba.com>
>>>>> +M:    Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>>>> +L:    linux-kernel@vger.kernel.org
>>>>> +S:    Maintained
>>>>> +T:    git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
>>>>
>>>> Hi David,
>>>>
>>>> Do you have a tree to route the patches thru? Or do you really have
>>>> access to the tip tree?
>>>
>>> I do not have access to the tip tree. I can make a shared tree on
>>> git.infradead.org if the other two maintainers would like to send me
>>> a SSH pubkey and preferred username...
>>
>> Honestly I'd love for you to be the only M here, and the other two
>> to be reviewers. Xuan Zhuo is currently at v40 trying to upstream
>> an Ethernet driver. Some growth needed there to become a subsystem
>> maintainer IMO.
> 
> Hi Jakub, David,
> 
> That works for us. We can act as reviewers.
> 
> If David sets up a new tree, I will update the MAINTAINERS entry
> accordingly in v3.

Hi David,

Just checking if there is any update on the maintainer tree
for the emulated PTP drivers.

Thanks.

> 
> Thanks.


