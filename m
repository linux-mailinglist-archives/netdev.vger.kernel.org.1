Return-Path: <netdev+bounces-81459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16D7889AFD
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 11:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C73F2A18E0
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 10:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A86E14C5AE;
	Mon, 25 Mar 2024 05:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WWB8ZmYj"
X-Original-To: netdev@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199A314F9CB
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 02:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711333447; cv=none; b=fpYYBiKK7bEha/PqNLxfKsnhaKR/94VXexVB5rbHwxJLC6GHtm1+MDsEjyYH8Val+VQxQwmv4LZV8aDmW9RLvb85GigyPfHDlUsd0BcWzN//19yhtHMg8Untq7UjAMEG09yw0yumUa6UXg4melvilCBM32/o67T4fmkvJ7Obi2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711333447; c=relaxed/simple;
	bh=9rgPYRpDaagbcX3E9nrMjNsjvhE3F5PeuJbfUZbQl1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W8ZEP8iOZRutbdVwyu9KOtYE5pGsedbZOIo+Ze259MdkJv4SZCWyekvSEKPixq/M7gqytBUlbbRe8iyg+uM3gRfzi8d558Xf+7MHwDD8Y0gk2Feptxl4Hix5hYh0ETGTQgpBAB+lxM4i+VcB6hsMTaojQXlC2uRAMK/ov3Ce1rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WWB8ZmYj; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711333443; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RTCQR/Cnk7//DYJRvJ0H5lsC4yRFE7aveFR2+FuBNZ8=;
	b=WWB8ZmYjdpXnzn92G3qykfSLJeUPXTlVX51DNHNcjIPMgx6wR7AttSqrM1gc4zPspEmTpq1vXTp/fQb0x8+H301l/pMbFqGSrfS/OQh8QbYUBYYGpQ8akHg0VgkiQPg/qJZO33kHz36InHUWJUjufmsn/jW4uDzXuuSePsJf76c=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W38IG5O_1711333437;
Received: from 30.221.148.153(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W38IG5O_1711333437)
          by smtp.aliyun-inc.com;
          Mon, 25 Mar 2024 10:24:02 +0800
Message-ID: <74e12c42-52d2-4c7f-a9fe-ffe75de603e6@linux.alibaba.com>
Date: Mon, 25 Mar 2024 10:23:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] virtio-net: a fix and some updates for virtio dim
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1711021557-58116-1-git-send-email-hengqi@linux.alibaba.com>
 <ZfwnSz5vP4KzXNxa@nanopsycho>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <ZfwnSz5vP4KzXNxa@nanopsycho>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/21 下午8:25, Jiri Pirko 写道:
> Thu, Mar 21, 2024 at 12:45:55PM CET, hengqi@linux.alibaba.com wrote:
>> Patch 1 fixes an existing bug. Belongs to the net branch.
> Send separately with "net" indication in the patch brackets:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html?highlight=network#tl-dr
>
>
>> Patch 2 attempts to modify the sending of dim cmds to an asynchronous way.
> Not a bugfix, then send separately with "net-next" indication. Net-next
> is currently closed, send it next week.

Will do.

>
>
>> Heng Qi (2):
>>   virtio-net: fix possible dim status unrecoverable
>>   virtio-net: reduce the CPU consumption of dim worker
> The name of the driver is "virtio_net".

'git log --grep="^virtio-net:" --oneline' will see a large number of 
"virtio-net" names.

>
>
>
> pw-bot: cr
>
>
>> drivers/net/virtio_net.c | 273 ++++++++++++++++++++++++++++++++++++++++++-----
>> 1 file changed, 246 insertions(+), 27 deletions(-)
>>
>> -- 
>> 1.8.3.1
>>
>>


