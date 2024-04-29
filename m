Return-Path: <netdev+bounces-92151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCCA8B59E4
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 15:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7251F210B1
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 13:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002BD5F861;
	Mon, 29 Apr 2024 13:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="KRnjXvpl"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A12D7317F
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 13:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397299; cv=none; b=CgHj/buOsx1uIvDztwzwyj1loaBlQCKYo6A8ebf4+52hUfXfOv80nkPOLWZqh+12ORZ5psXUpHNqljgKETM4+hy2ezRpe1LN1sI88ldGxa+snJWanY8OQdNUZJb70oDJA96Ao1HzkLjUnu0hLLgJiiXwhitkGXld6tsY4FeuuBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397299; c=relaxed/simple;
	bh=6hd2ZESwHfIxH8+Zvwh04skQgMyBwVzIqYlKEBIA0S4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RkrBXQpQMNyi69b5jaGHBfXxKbWlb+DZVO8SZHLS9ggPU3tIYHqtLNr6jQb7HqOLDsaLABBFfIAWHWL8EKb7TxGyYEaXDdp91NeA+/j9v1YBXAP1wLbxIWimkX8rUUCYZaAcQoasasEtl22FZ1jOJ5IIAXs+uKWYA6npWL8gqvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=KRnjXvpl; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 95CBA888EA;
	Mon, 29 Apr 2024 15:28:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714397295;
	bh=v3578JMxi7WxGcVmX3sr/pNv0BW2+lSt7wC1vY49/JY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KRnjXvplmCQzf4QB59hxkDRWktSjfBwpb/exLlHo+T4+aprHHvyrqm6AkXqIVzJ6O
	 8ERdalQnXAxH8AFwDcEgue4FEYRb0w942/N2lEqG4OG3tXyB0ynzL+4vQlkagWdKxa
	 qGtCmZsumQWn/I2WD3Y53GW1j1/9zvQhx+8wq/qjXXAs+/0i97CAt6SpRI5M6Sr4Ij
	 KoyVMgcta+nqUyA8p+ZtQutcpQua3HFJidb+sWpjOnDuO0ybP4AwDG6QEVzJtpjApS
	 aT4Za/5pjmBhvo7Bgi8cvQu5EV6Sx8S6ESfeiMPf/y5Qp1j9erzwAkk9fjIikJVtHT
	 MYuKvC/owpssA==
Message-ID: <16f52bb6-59a1-4f6f-8d1a-c30198b0f743@denx.de>
Date: Mon, 29 Apr 2024 15:23:18 +0200
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
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <fa332bfc-68fb-4eea-a70a-8ac9c0d3c990@raritan.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 4/29/24 1:46 PM, Ronald Wahl wrote:
> Hi,

Hi,

> for the spi version of the chip this change now leads to
> 
> [   23.793000] BUG: sleeping function called from invalid context at 
> kernel/locking/mutex.c:283
> [   23.801915] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 
> 857, name: irq/52-eth-link
> [   23.810895] preempt_count: 200, expected: 0
> [   23.815288] CPU: 0 PID: 857 Comm: irq/52-eth-link Not tainted 
> 6.6.28-sama5 #1
> [   23.822790] Hardware name: Atmel SAMA5
> [   23.826717]  unwind_backtrace from show_stack+0xb/0xc
> [   23.831992]  show_stack from dump_stack_lvl+0x19/0x1e
> [   23.837433]  dump_stack_lvl from __might_resched+0xb7/0xec
> [   23.843122]  __might_resched from mutex_lock+0xf/0x2c
> [   23.848540]  mutex_lock from ks8851_irq+0x1f/0x164
> [   23.853525]  ks8851_irq from irq_thread_fn+0xf/0x28
> [   23.858776]  irq_thread_fn from irq_thread+0x93/0x130
> [   23.864037]  irq_thread from kthread+0x7f/0x90
> [   23.868699]  kthread from ret_from_fork+0x11/0x1c
> 
> Actually the spi driver variant does not suffer from the issue as it has
> different locking so we probably should do the
> local_bh_disable/local_bh_enable only for the "par" version. What do you 
> think?

Ah sigh, sorry for the breakage. Indeed, the locking is not great here.

I am not entirely sure about the local_bh_disable/enable being par only.

I will try to prepare some sort of a patch, would you be willing to test 
it on the SPI variant ?

