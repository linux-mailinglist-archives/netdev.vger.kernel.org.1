Return-Path: <netdev+bounces-92292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 950E18B67B0
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 03:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 952AC1C21829
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 01:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66778BF1;
	Tue, 30 Apr 2024 01:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="k3GPcamv"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BA11FB2
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 01:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714441837; cv=none; b=tr+c2jYOjpuzRrBHCKsVA0DqyhWfr8wwaf4QJ9sVhzurn5gk2wYx0r0T2I5s0QtKctreSBLCxQ7oKqmDhzYl1u/R2ndsg0jZ1ryRMcRzZidhToZ1uXa98unusy0LDeXdchA4FWE/1PIWUbz4gU3UEBoViOUdjxmb/xmIHAft658=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714441837; c=relaxed/simple;
	bh=VXw7ofil+IGQG00hQ8zgj6MwKrzMuDqAcMWr7YIgSkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gMxM5I2RduVxns90AYcF++mGiIM4P7e1YSRwluhoW31MnzVHd0QsljSoO+STRpJOx6R6P8EWCd595Hr6rvEK0HUZ9F/jwj1KY27bnt0t//IP7dYXeJ9QueJgvb8iwtxhKDzreoV95H7j4n7om9V4LDw5w5cG3hytKQ9susDWX7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=k3GPcamv; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 20E618872F;
	Tue, 30 Apr 2024 03:50:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714441833;
	bh=gmv7a954P1DKOpnOtpQgTBhFZPwtSJUO1QwyR11v7ts=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k3GPcamvgC3GQaSJAmNgji236n52HgaAvIcrAqpvgykK1c1Qug+wcdL7mIpPlJPb8
	 2zvwIy/WZkryQRWwynZ0T9ujW62mC1xi9hM9ZI4cg45NWoNbVaPSd1MM0qIuEGYzjB
	 JnREqLTPqRuFYIG875tCIsP5E0vUoLENZqSFlT2t9Swy1maHBd6giiTMWA0WrpNYTg
	 thvHoOsY2Y4QGLC5OMXZiblt+AaMHGhgMrTa7vql+ctWuy+A9aHTwhZAbveKlqmiNy
	 S9dC+IOjKrZHaQNiCK44CSrHg0R0eFTEfrZftgEydxfbH/I9LrTOoJTrdwdmYL5zSt
	 GJpQtk0LgzioQ==
Message-ID: <a8d51f07-030c-45fe-a99e-fb290488e3a8@denx.de>
Date: Tue, 30 Apr 2024 03:18:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net: ks8851: Handle softirqs at the end of IRQ thread
 to fix hang
To: Ronald Wahl <ronald.wahl@raritan.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Mark Brown <broonie@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
References: <20240331142353.93792-1-marex@denx.de>
 <20240331142353.93792-2-marex@denx.de>
 <fa332bfc-68fb-4eea-a70a-8ac9c0d3c990@raritan.com>
 <16f52bb6-59a1-4f6f-8d1a-c30198b0f743@denx.de>
 <001769c4-02de-4114-ab64-46530f36838e@raritan.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <001769c4-02de-4114-ab64-46530f36838e@raritan.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 4/29/24 3:50 PM, Ronald Wahl wrote:
> On 29.04.24 15:23, Marek Vasut wrote:
>> On 4/29/24 1:46 PM, Ronald Wahl wrote:
>>> Hi,
>>
>> Hi,
>>
>>> for the spi version of the chip this change now leads to
>>>
>>> [   23.793000] BUG: sleeping function called from invalid context at
>>> kernel/locking/mutex.c:283
>>> [   23.801915] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid:
>>> 857, name: irq/52-eth-link
>>> [   23.810895] preempt_count: 200, expected: 0
>>> [   23.815288] CPU: 0 PID: 857 Comm: irq/52-eth-link Not tainted
>>> 6.6.28-sama5 #1
>>> [   23.822790] Hardware name: Atmel SAMA5
>>> [   23.826717]  unwind_backtrace from show_stack+0xb/0xc
>>> [   23.831992]  show_stack from dump_stack_lvl+0x19/0x1e
>>> [   23.837433]  dump_stack_lvl from __might_resched+0xb7/0xec
>>> [   23.843122]  __might_resched from mutex_lock+0xf/0x2c
>>> [   23.848540]  mutex_lock from ks8851_irq+0x1f/0x164
>>> [   23.853525]  ks8851_irq from irq_thread_fn+0xf/0x28
>>> [   23.858776]  irq_thread_fn from irq_thread+0x93/0x130
>>> [   23.864037]  irq_thread from kthread+0x7f/0x90
>>> [   23.868699]  kthread from ret_from_fork+0x11/0x1c
>>>
>>> Actually the spi driver variant does not suffer from the issue as it has
>>> different locking so we probably should do the
>>> local_bh_disable/local_bh_enable only for the "par" version. What do
>>> you think?
>>
>> Ah sigh, sorry for the breakage. Indeed, the locking is not great here.
>>
>> I am not entirely sure about the local_bh_disable/enable being par only.
>>
>> I will try to prepare some sort of a patch, would you be willing to test
>> it on the SPI variant ?
> 
> Yes, I can help here, thanks. Meanwhile I also have some good understanding
> at least on the TX path because we had some issues here in the past.
> 
> I will come up myself with another fix in the interrupt handler later. We
> currently reset the ISR status flags too late risking a TX queue stall with
> the SPI chip variant. They must be reset immediately after reading them.
> Need
> to wait a bit for field feedback as I was not able to reproduce this
> mysqelf.

This chip really is a gift that keeps on giving ... sigh.

I just sent this patch, you are on CC, please give it a try:

https://patchwork.kernel.org/project/netdevbpf/patch/20240430011518.110416-1-marex@denx.de/

