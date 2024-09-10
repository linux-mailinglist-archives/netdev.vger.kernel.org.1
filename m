Return-Path: <netdev+bounces-127127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7CE97439C
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 21:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9A58B21149
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 19:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7E61A704B;
	Tue, 10 Sep 2024 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ghv9c+q/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF51E17C7B1;
	Tue, 10 Sep 2024 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725997229; cv=none; b=Ok21ExncF4YKlRBFRAa7EQUzeJXfEtVA5FpoxbIU1UiwnyqREbURdvdxOKL3hxZ5+kKJTWZG83sZ7Job4HS4bfp9GrCM7yTKzv462EJRFl433P0lZFRDAFjj+RcfCdzxZPIe55t2rTGG6MTjrXm5tjXrfPXZ84zARmcr7f8/ROE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725997229; c=relaxed/simple;
	bh=63JGDtgAK6PTDT6/mIuRtq6JbNmU4epoY1XA9is8Amk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A4C6jBPlGbzvfXny3By45qB9rtTxNEzcVEGkcggx3OxZg8C1rtCgl7AJybwy/ffs90U6m/Q8YzF58yGhpttDVmPqY5s9B/K1iPDhorb3MFfu9EYR4xWXhlIrky+WORgjtzepeGt0F6A/QOGYhDu+V4LbObsN88Xsvn0/oVAOULk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ghv9c+q/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F7CC4CEC3;
	Tue, 10 Sep 2024 19:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725997229;
	bh=63JGDtgAK6PTDT6/mIuRtq6JbNmU4epoY1XA9is8Amk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ghv9c+q/yHOUfQddiBJl0gSqL1Atj4vQ0wz96uMvN/teOBCpaCiPpd3waPbWpKmXy
	 7f2qKqnZuO7O+ftF1ldSTt00Z+cMup0AyQRvzwbkYKd1iMoceYc4pE8zyGVS8TTcfQ
	 nQzLT6wNYu+tmElaeHdzmMLDoMSToB9bNXJA4NsB6UNyG9y3mhJSq+VTlupoN1DVUK
	 8v4aHPHChJapnsvviHgsSFQLB/bzIx+xpr9ls1KzrDh0o+7EKG5p9F5nayI2gm4KdH
	 MCW985diuhmrySvPVYj4YQhZJGfCGXQFCkFuzEl8QGGue5pY+gQXuHCdftOUQktSxP
	 XGemOvzHbFJUA==
Message-ID: <3d87bdde-4800-4a8b-9b34-ba7998f503c3@kernel.org>
Date: Tue, 10 Sep 2024 21:40:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression v6.11 booting cannot mount harddisks (xfs)
To: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>
Cc: Netdev <netdev@vger.kernel.org>, linux-ide@vger.kernel.org,
 cassel@kernel.org, handan.babu@oracle.com, djwong@kernel.org,
 Linux-XFS <linux-xfs@vger.kernel.org>, hdegoede@redhat.com,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 kernel-team <kernel-team@cloudflare.com>, rjones@redhat.com
References: <0a43155c-b56d-4f85-bb46-dce2a4e5af59@kernel.org>
 <d2c82922-675e-470f-a4d3-d24c4aecf2e8@kernel.org>
 <ee565fda-b230-4fb3-8122-e0a9248ef1d1@kernel.org>
 <7fedb8c2-931f-406b-b46e-83bf3f452136@kernel.org>
 <c9096ee9-0297-4ae3-9d15-5d314cb4f96f@kernel.dk>
 <0ad933b9-9df5-4acc-aa72-d291aa7d7f4d@kernel.org>
 <894a9361-d232-41c5-8090-89fd61fadb28@kernel.dk>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <894a9361-d232-41c5-8090-89fd61fadb28@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/09/2024 21.21, Jens Axboe wrote:
> On 9/10/24 1:19 PM, Jesper Dangaard Brouer wrote:
>>
>>
>> On 10/09/2024 20.38, Jens Axboe wrote:
>>> On 9/10/24 11:53 AM, Jesper Dangaard Brouer wrote:
>>>> Hi Hellwig,
>>>>
>>>> I bisected my boot problem down to this commit:
>>>>
>>>> $ git bisect good
>>>> af2814149883e2c1851866ea2afcd8eadc040f79 is the first bad commit
>>>> commit af2814149883e2c1851866ea2afcd8eadc040f79
>>>> Author: Christoph Hellwig <hch@lst.de>
>>>> Date:   Mon Jun 17 08:04:38 2024 +0200
>>>>
>>>>       block: freeze the queue in queue_attr_store
>>>>
>>>>       queue_attr_store updates attributes used to control generating I/O, and
>>>>       can cause malformed bios if changed with I/O in flight.  Freeze the queue
>>>>       in common code instead of adding it to almost every attribute.
>>>>
>>>>       Signed-off-by: Christoph Hellwig <hch@lst.de>
>>>>       Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>>>>       Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
>>>>       Reviewed-by: Hannes Reinecke <hare@suse.de>
>>>>       Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>>>>       Link: https://lore.kernel.org/r/20240617060532.127975-12-hch@lst.de
>>>>       Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>>
>>>>    block/blk-mq.c    | 5 +++--
>>>>    block/blk-sysfs.c | 9 ++-------
>>>>    2 files changed, 5 insertions(+), 9 deletions(-)
>>>>
>>>> git describe --contains af2814149883e2c1851866ea2afcd8eadc040f79
>>>> v6.11-rc1~80^2~66^2~15
>>>
>>> Curious, does your init scripts attempt to load a modular scheduler
>>> for your root drive?
>>
>> I have no idea, this is just a standard Fedora 40.
>>
>>>
>>> Reference: https://git.kernel.dk/cgit/linux/commit/?h=for-6.12/block&id=3c031b721c0ee1d6237719a6a9d7487ef757487b
>>

[1] 
https://git.kernel.dk/cgit/linux/commit/?h=for-6.12/block&id=3c031b721c0ee1d6237719a6a9d7487ef757487b

>> The commit doesn't apply cleanly on top of af2814149883e2c185.
>>
>> $ patch --dry-run -p1 < ../block-jens/block-jens-bootfix.patch
>> checking file block/blk-sysfs.c
>> Hunk #1 FAILED at 23.
>> Hunk #2 succeeded at 469 (offset 56 lines).
>> Hunk #3 succeeded at 484 (offset 56 lines).
>> Hunk #4 succeeded at 723 with fuzz 1 (offset 45 lines).
>> 1 out of 4 hunks FAILED
>> checking file block/elevator.c
>> Hunk #1 FAILED at 698.
>> 1 out of 1 hunk FAILED
>> checking file block/elevator.h
>> Hunk #1 FAILED at 148.
>> 1 out of 1 hunk FAILED
>>
>> I will try to apply and adjust manually.
> 
> Just apply it on top of current -git, doesn't have to be your bisection
> point.
>

I applied it manually and now my testlab server boots :-)

Just with the patch[1] on top of bisection point
... as it was faster to recompile this way ;-)

--Jesper


