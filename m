Return-Path: <netdev+bounces-87376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 383D88A2EF4
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 15:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFF4A1F217FD
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 13:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B075D73D;
	Fri, 12 Apr 2024 13:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="YCWFUFPR"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD783EA83
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 13:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927440; cv=none; b=UQ1IiUgyUQ7Eq1+CRGtfEaNKihJ4wLTFHsvda2JumTVYhwabqH77c3tGzxvmp9pdhbdGSViF4XUKNTpsx8toBPVVTLlHAuCXT7pwzSc4k06itIDg7VJMOMtLBRDod32YCacfetuWUNtlsm05wZj+WpFF/ycVNBdNxcaV1V59Fzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927440; c=relaxed/simple;
	bh=Smur38fq96z/oKuDmaN9Qn5jAzzHc32QMK5HjR+d3Yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GCZzCQunxCVIMLLr/fs8P6iad7vPayburbAATfUPweU3BleP5AlK+iLYl76uHPlPY01ONO27GM31Ho3G08hhLluV1ip4UxxSY7dpNgL7MbYUJGY/FiRjVoILFm0IAkTB0AXMAI3KqhPMBUT+65TEN0lXghpaf2UNOXzgR0mfKMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=YCWFUFPR; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 41CD487EA8;
	Fri, 12 Apr 2024 15:10:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1712927431;
	bh=6JAgiaXzVQTahOa+hyh01rVVeeR3af3Wl40P3t9Rj3w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YCWFUFPRyYipDZqWjMotGRk3YdNuIFnmwT8wd6+vgLOMl7Uq5nAKrBRzMdZYuQ6x4
	 q3ZJVWDU70qsrCRaIDDaidmhdFw1zkAi6T1XygDPI0AyHL5CfNKHFzjLXmFmwetEtl
	 iQrQhNh1xpury0/eAy7HXkFJIouY5r4FSVv4F+MqMnjahyfRDcc93tOESJAmlXbjNp
	 +B78RKTfWY09R/708GKKNqShD+NbX1fZWowOpBcFuVM5Hgvk0j0lCu/dUr8K4+q3VT
	 agLgxDebOLSVLc3rEXdBHUOGF9di3pJD+szrVr0TnrQqhnBRFiJ9lGIY57pGMe7U5G
	 R7y+xdWCqJnOg==
Message-ID: <a8e28385-5b92-4149-be0c-cfce6394fbc2@denx.de>
Date: Fri, 12 Apr 2024 13:29:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] net: ks8851: Handle softirqs at the end of IRQ
 thread to fix hang
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Mark Brown <broonie@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Ronald Wahl <ronald.wahl@raritan.com>, Simon Horman <horms@kernel.org>
References: <20240405203204.82062-1-marex@denx.de>
 <20240405203204.82062-2-marex@denx.de> <ZhQEqizpGMrxe_wT@smile.fi.intel.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <ZhQEqizpGMrxe_wT@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 4/8/24 4:52 PM, Andy Shevchenko wrote:
> On Fri, Apr 05, 2024 at 10:30:40PM +0200, Marek Vasut wrote:
>> The ks8851_irq() thread may call ks8851_rx_pkts() in case there are
>> any packets in the MAC FIFO, which calls netif_rx(). This netif_rx()
>> implementation is guarded by local_bh_disable() and local_bh_enable().
>> The local_bh_enable() may call do_softirq() to run softirqs in case
>> any are pending. One of the softirqs is net_rx_action, which ultimately
>> reaches the driver .start_xmit callback. If that happens, the system
>> hangs. The entire call chain is below:
>>
>> ks8851_start_xmit_par from netdev_start_xmit
>> netdev_start_xmit from dev_hard_start_xmit
>> dev_hard_start_xmit from sch_direct_xmit
>> sch_direct_xmit from __dev_queue_xmit
>> __dev_queue_xmit from __neigh_update
>> __neigh_update from neigh_update
>> neigh_update from arp_process.constprop.0
>> arp_process.constprop.0 from __netif_receive_skb_one_core
>> __netif_receive_skb_one_core from process_backlog
>> process_backlog from __napi_poll.constprop.0
>> __napi_poll.constprop.0 from net_rx_action
>> net_rx_action from __do_softirq
>> __do_softirq from call_with_stack
>> call_with_stack from do_softirq
>> do_softirq from __local_bh_enable_ip
>> __local_bh_enable_ip from netif_rx
>> netif_rx from ks8851_irq
>> ks8851_irq from irq_thread_fn
> 
>> irq_thread_fn from irq_thread
>> irq_thread from kthread
>> kthread from ret_from_fork
> 
> These lines are unneeded (in case you need a new version, you can drop them).

I just got back and going through a mountain of email, I see Jakub 
already picked the V2, so, noted for next time. Thank you !

